require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "test", email: "test@test.com", studentid: "0356097", 
                    password: "testtest", password_confirmation: "testtest" )
    @user2 = User.new(name: "test2", email: "test2@test2.com", studentid: "0356098",
                    password: "test2test2", password_confirmation: "test2test2" )
  end

  test "shold be valid" do
    assert @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.name = "a"*224 + "@example.com"
    assert_not @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    dup_user = @user2.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "name should be unique" do
    dup_user = @user2.dup
    dup_user.name = @user.name.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "studentid should be unique" do
    dup_user = @user2.dup 
    dup_user.studentid = @user.studentid
    @user.save
    assert_not dup_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a"*4
    assert_not @user.valid?
  end
  # test "the truth" do
  #   assert true
  # end
end
