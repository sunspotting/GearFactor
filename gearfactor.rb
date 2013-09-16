
class Gear
  attr_accessor :prime, :count

  # note only gear size of > 1 makes sense

  def initialize(prime)
    @prime = prime
    @count = prime
  end

  def aligned?
    @count == @prime
  end

  def turn
   @count = @count - 1
   @count = @prime if @count == 0
   self.aligned?
  end

  def size
    @prime
  end
end

class GearFactor
  attr_accessor :gear_array, :count, :verbose

  def initialize
    @verbose = false
    @count = 2
    @gear_array = []
    @gear_array << Gear.new(2)
  end

  def turn(so_many = 1)
    so_many.times do
      @count = @count + 1
      # only if they are all misaligned do we add a gear; in other words, don't add a gear if any are aligned
      unless @gear_array.inject(false) { |lineup, gear| lineup || gear.turn }
        puts "Adding new gear #{@count}" if  @verbose
        gear = Gear.new(@count)
        @gear_array << gear
      end
    end
    sizes
  end

  def sizes
    @gear_array.map( &:size )
  end

  def anyaligned?
    @gear_array.inject(false) { |lineup, gear| lineup || gear.aligned? }
  end

  def verbose(set = true)
    @verbose = set
  end
end


abort "Please give an integer number argument great than 1." unless Integer(ARGV[0]) > 1

g = GearFactor.new

g.turn Integer(ARGV[0])-2

puts g.sizes
puts "Found #{g.sizes.size} primes."

