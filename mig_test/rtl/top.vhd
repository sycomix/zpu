-- top-level beam position monitor
-- für Trenz TE0600
--
-- FPGA: LX45, LX100 or LX150
-- 10/100/1000 Gigabit Ethernet
-- 2*64 MByte DDR3 SDRAM
-- 8 MByte SPI Flash
-- 
-- enthält alle Buffer/Treiber für die FPGA-Pins
--
--

--------------------------------------------------------------------------------
-- $Date$
-- $Author$
-- $Revision$
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity top is
    port ( 
        -- pragma translate_off
        simulation_break        : out   std_logic;
        -- pragma translate_on
        -- system stuff
        CLK                     : in    std_logic; -- 125 MHz
        --RESET_N                 : in    std_logic;
        POWER_FAIL_N            : in    std_logic;
        WATCHDOG                : out   std_logic;
        REPROG_N                : out   std_logic;
        -- user clock
        USER_CLK                : in    std_logic;
        --
        -- DDR3 SDRAM
        MCB1_DRAM_A             : out   std_logic_vector(14 downto 0);
        MCB1_DRAM_BA            : out   std_logic_vector(2 downto 0);
        MCB1_DRAM_CAS_B         : out   std_logic; 
        MCB1_DRAM_RAS_B         : out   std_logic; 
        MCB1_DRAM_WE_B          : out   std_logic; 
        MCB1_DRAM_CKE           : out   std_logic; 
        MCB1_DRAM_CK_N          : out   std_logic; 
        MCB1_DRAM_CK_P          : out   std_logic; 
        MCB1_DRAM_DQ            : inout std_logic_vector(15 downto 0);
        MCB1_DRAM_LDM           : out   std_logic; 
        MCB1_DRAM_UDM           : out   std_logic; 
        MCB1_DRAM_DQS_N         : inout std_logic_vector( 1 downto 0); 
        MCB1_DRAM_DQS_P        : inout std_logic_vector( 1 downto 0); 
        MCB1_DRAM_ODT           : out   std_logic; 
        MCB1_DRAM_RESET_B       : out   std_logic; 
        MCB1_RZQ          : inout std_logic;
        MCB1_ZIO          : inout std_logic;
        --
        MCB3_DRAM_A             : out   std_logic_vector(14 downto 0);
        MCB3_DRAM_BA            : out   std_logic_vector(2 downto 0);
        MCB3_DRAM_CAS_B         : out   std_logic; 
        MCB3_DRAM_RAS_B         : out   std_logic; 
        MCB3_DRAM_WE_B          : out   std_logic; 
        MCB3_DRAM_CKE           : out   std_logic; 
        MCB3_DRAM_CK_N          : out   std_logic; 
        MCB3_DRAM_CK_P          : out   std_logic; 
        MCB3_DRAM_DQ            : inout std_logic_vector(15 downto 0);
        MCB3_DRAM_LDM           : out   std_logic; 
        MCB3_DRAM_UDM           : out   std_logic; 
        MCB3_DRAM_DQS_N        : inout std_logic_vector( 1 downto 0); 
        MCB3_DRAM_DQS_P        : inout std_logic_vector( 1 downto 0); 
        MCB3_DRAM_ODT           : out   std_logic; 
        MCB3_DRAM_RESET_B       : out   std_logic; 
        MCB3_RZQ          : inout std_logic;
        MCB3_ZIO          : inout std_logic;
        --
        -- Ethernet PHY
        -- phy address = 0b00111
        -- config(0)   = '1'
        -- config(1)   = '0'
        -- config(2)   = '1'
        -- config(3)   = PHY_L10
        -- config(4)   = '1'
        -- config(5)   = '1'
        -- config(6)   = PHY_LED_RX
        --PHY_125                 : in    std_logic; -- 125 MHz from phy, used as clk
        PHY_MDIO                : inout std_logic; 
        PHY_MDC                 : out   std_logic; 
        PHY_INT                 : in    std_logic; 
        PHY_RESET_B             : out   std_logic; 
        PHY_CRS                 : in    std_logic; 
        PHY_COL                 : inout std_logic; 
        PHY_TXEN                : out   std_logic; 
        PHY_TXCLK               : in    std_logic; 
        PHY_TXER                : out   std_logic; 
        PHY_TXD                 : out   std_logic_vector(7 downto 0);
        PHY_GTXCLK              : out   std_logic; 
        PHY_RXCLK               : in    std_logic;
        PHY_RXER                : in    std_logic; 
        PHY_RXDV                : in    std_logic; 
        PHY_RXD                 : in    std_logic_vector(7 downto 0);
        --
        -- quad SPI Flash (W25Q64BV)
        SPI_FLASH_CSO_B         : out   std_logic;
        SPI_FLASH_CCLK          : out   std_logic;
        SPI_FLASH_IO            : inout std_logic_vector(3 downto 0); -- ( 0=di, 1=do, 2=wp_n, 3=hold_n)
        --
        -- EEPROM (48bit MAC address, DS2502-E48)
        MAC_DATA                : inout std_logic;
        --
        -- B2B J1 user IO
        B2B_B2_L57_N            : inout std_logic; 
        B2B_B2_L57_P            : inout std_logic; 
        B2B_B2_L49_N            : inout std_logic; 
        B2B_B2_L49_P            : inout std_logic; 
        B2B_B2_L48_N            : inout std_logic; 
        B2B_B2_L48_P            : inout std_logic; 
        B2B_B2_L45_N            : inout std_logic; 
        B2B_B2_L45_P            : inout std_logic; 
        B2B_B2_L43_N            : inout std_logic; 
        B2B_B2_L43_P            : inout std_logic; 
        B2B_B2_L41_N            : inout std_logic; 
        B2B_B2_L41_P            : inout std_logic; 
        B2B_B2_L21_P            : inout std_logic; 
        B2B_B2_L21_N            : inout std_logic; 
        B2B_B2_L15_P            : inout std_logic; 
        B2B_B2_L15_N            : inout std_logic; 
        B2B_B2_L31_N            : inout std_logic; -- single ended
        B2B_B2_L32_N            : inout std_logic; -- single ended
        B2B_B2_L60_P            : inout std_logic; 
        B2B_B2_L60_N            : inout std_logic; 
        B2B_B2_L59_N            : inout std_logic; 
        B2B_B2_L59_P            : inout std_logic; 
        B2B_B2_L44_N            : inout std_logic; 
        B2B_B2_L44_P            : inout std_logic; 
        B2B_B2_L42_N            : inout std_logic; 
        B2B_B2_L42_P            : inout std_logic; 
        B2B_B2_L18_P            : inout std_logic; 
        B2B_B2_L18_N            : inout std_logic; 
        B2B_B2_L8_N             : inout std_logic; 
        B2B_B2_L8_P             : inout std_logic; 
        B2B_B2_L11_P            : inout std_logic; 
        B2B_B2_L11_N            : inout std_logic; 
        B2B_B2_L6_P             : inout std_logic; 
        B2B_B2_L6_N             : inout std_logic; 
        B2B_B2_L5_P             : inout std_logic; 
        B2B_B2_L5_N             : inout std_logic; 
        B2B_B2_L9_N             : inout std_logic; 
        B2B_B2_L9_P             : inout std_logic; 
        B2B_B2_L4_N             : inout std_logic; 
        B2B_B2_L4_P             : inout std_logic; 
        B2B_B2_L29_N            : inout std_logic; -- single ended 
        B2B_B2_L10_N            : inout std_logic; 
        B2B_B2_L10_P            : inout std_logic; 
        B2B_B2_L2_N             : inout std_logic; 
        B2B_B2_L2_P             : inout std_logic; 
        --
        -- B2B J2 user IO
        B2B_B3_L60_N            : inout std_logic; 
        B2B_B3_L60_P            : inout std_logic; 
        B2B_B3_L9_N             : inout std_logic; 
        B2B_B3_L9_P             : inout std_logic; 
        B2B_B0_L3_P             : inout std_logic; 
        B2B_B0_L3_N             : inout std_logic; 
        B2B_B3_L59_P            : inout std_logic; 
        B2B_B3_L59_N            : inout std_logic; 
        B2B_B0_L32_P            : inout std_logic; 
        B2B_B0_L32_N            : inout std_logic; 
        B2B_B0_L7_N             : inout std_logic; 
        B2B_B0_L7_P             : inout std_logic; 
        B2B_B0_L33_N            : inout std_logic; 
        B2B_B0_L33_P            : inout std_logic; 
        B2B_B0_L36_P            : inout std_logic; 
        B2B_B0_L36_N            : inout std_logic; 
        B2B_B0_L49_P            : inout std_logic; 
        B2B_B0_L49_N            : inout std_logic; 
        B2B_B0_L62_P            : inout std_logic; 
        B2B_B0_L62_N            : inout std_logic; 
        B2B_B0_L66_P            : inout std_logic; 
        B2B_B0_L66_N            : inout std_logic; 
        B2B_B1_L10_P            : inout std_logic; 
        B2B_B1_L10_N            : inout std_logic; 
        B2B_B1_L9_P             : inout std_logic; 
        B2B_B1_L9_N             : inout std_logic; 
        B2B_B1_L21_N            : inout std_logic; 
        B2B_B1_L21_P            : inout std_logic; 
        B2B_B1_L61_P            : inout std_logic; 
        B2B_B1_L61_N            : inout std_logic; 
        B2B_B0_L1               : inout std_logic;  -- used as reset_n
        B2B_B0_L2_P             : inout std_logic; 
        B2B_B0_L2_N             : inout std_logic; 
        B2B_B0_L4_N             : inout std_logic; 
        B2B_B0_L4_P             : inout std_logic; 
        B2B_B0_L5_N             : inout std_logic; 
        B2B_B0_L5_P             : inout std_logic; 
        B2B_B0_L6_N             : inout std_logic; 
        B2B_B0_L6_P             : inout std_logic; 
        B2B_B0_L8_N             : inout std_logic; 
        B2B_B0_L8_P             : inout std_logic; 
        B2B_B0_L34_N            : inout std_logic; 
        B2B_B0_L34_P            : inout std_logic; 
        B2B_B0_L35_N            : inout std_logic; 
        B2B_B0_L35_P            : inout std_logic; 
        B2B_B0_L37_N            : inout std_logic; 
        B2B_B0_L37_P            : inout std_logic; 
        B2B_B0_L38_N            : inout std_logic; 
        B2B_B0_L38_P            : inout std_logic; 
        B2B_B0_L50_N            : inout std_logic; 
        B2B_B0_L50_P            : inout std_logic; 
        B2B_B0_L51_N            : inout std_logic; 
        B2B_B0_L51_P            : inout std_logic; 
        B2B_B0_L63_N            : inout std_logic; 
        B2B_B0_L63_P            : inout std_logic; 
        B2B_B0_L64_N            : inout std_logic; 
        B2B_B0_L64_P            : inout std_logic; 
        B2B_B0_L65_N            : inout std_logic; 
        B2B_B0_L65_P            : inout std_logic; 
        B2B_B1_L20_P            : inout std_logic; 
        B2B_B1_L20_N            : inout std_logic; 
        B2B_B1_L19_P            : inout std_logic; 
        B2B_B1_L19_N            : inout std_logic; 
        B2B_B1_L59              : inout std_logic; 
        --
        -- misc
        USER_LED_N              : out   std_logic;
        AV                      : in    std_logic_vector(3 downto 0);
        BR                      : in    std_logic_vector(3 downto 0)
    );
end entity top;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library gaisler;
use gaisler.misc.all;                   -- types
use gaisler.uart.all;                   -- types
use gaisler.net.all;                    -- types
use gaisler.memctrl.all;                -- spimctrl types


architecture Behavioral of top is

    function simulation_active return std_ulogic is
        variable result : std_ulogic;
    begin
        result := '0';
        -- pragma translate_off
        result := '1';
        -- pragma translate_on
        return result;
    end function simulation_active;


    
    alias CARRIER_LED0 : std_logic is B2B_B3_L59_N;
    alias CARRIER_LED1 : std_logic is B2B_B3_L59_P;
    alias CARRIER_LED2 : std_logic is B2B_B3_L9_P;
    alias CARRIER_LED3 : std_logic is B2B_B3_L9_N;
    --
    alias UART_RX      : std_logic is B2B_B2_L9_N;
    alias UART_TX      : std_logic is B2B_B2_L6_P;


    constant system_frequency_c               : natural := 125_000_000;

    -- system signals
    signal clk_box                            : std_ulogic;
    signal clk_ready                          : std_ulogic := '1';
    --
    signal reset_shreg                        : std_ulogic_vector(3 downto 0) := (others => '1');
    signal reset                              : std_ulogic                    := '1';
    signal reset_n                            : std_ulogic                    := '0';
    --
    -- io signals
    signal box_i0_break                       : std_ulogic;
    signal gpioi                              : gpio_in_type;
    signal uarti                              : uart_in_type;
    --                                        
    signal box_i0_gpioo                       : gpio_out_type;
    signal box_i0_uarto                       : uart_out_type;


begin
    
    -- default output drivers
    -- for unused blocks
    PHY_MDC           <= '1';
    PHY_TXEN          <= '0';
    PHY_TXER          <= '0';
    PHY_TXD           <= (others => '1');
    PHY_GTXCLK        <= '0';
    PHY_RESET_B       <= '0';
    PHY_COL           <= 'Z';
    PHY_MDIO          <= 'Z';
                      
    MCB1_DRAM_RESET_B <= '0';
    MCB1_DRAM_A       <= (others => '1');
    MCB1_DRAM_BA      <= (others => '1');
    MCB1_DRAM_CAS_B   <= '1';
    MCB1_DRAM_RAS_B   <= '1';
    MCB1_DRAM_WE_B    <= '1';
    MCB1_DRAM_CKE     <= '0';
    MCB1_DRAM_CK_N    <= '0';
    MCB1_DRAM_CK_P    <= '1';
    MCB1_DRAM_LDM     <= '0';
    MCB1_DRAM_UDM     <= '0';
    MCB1_DRAM_ODT     <= '1';
    MCB1_DRAM_DQS_N   <= (others => 'Z');
    MCB1_DRAM_DQS_P   <= (others => 'Z');
    MCB1_DRAM_DQ      <= (others => 'Z');

    MCB3_DRAM_RESET_B <= '0';
    MCB3_DRAM_A       <= (others => '1');
    MCB3_DRAM_BA      <= (others => '1');
    MCB3_DRAM_CAS_B   <= '1';
    MCB3_DRAM_RAS_B   <= '1';
    MCB3_DRAM_WE_B    <= '1';
    MCB3_DRAM_CKE     <= '0';
    MCB3_DRAM_CK_N    <= '0';
    MCB3_DRAM_CK_P    <= '1';
    MCB3_DRAM_LDM     <= '0';
    MCB3_DRAM_UDM     <= '0';
    MCB3_DRAM_ODT     <= '1';
    MCB3_DRAM_DQS_N   <= (others => 'Z');
    MCB3_DRAM_DQS_P   <= (others => 'Z');
    MCB3_DRAM_DQ      <= (others => 'Z');

    SPI_FLASH_CSO_B   <= '1';
    SPI_FLASH_CCLK    <= '1';
    SPI_FLASH_IO      <= (others => 'Z');

    WATCHDOG          <= 'Z'; -- disable watchdog
    --REPROG_N          <= '1';

    MAC_DATA          <= 'Z';

    -- B2B J1 user IO
    B2B_B2_L57_N      <= 'Z';
    B2B_B2_L57_P      <= 'Z';
    B2B_B2_L49_N      <= 'Z';
    B2B_B2_L49_P      <= 'Z';
    B2B_B2_L48_N      <= 'Z';
    B2B_B2_L48_P      <= 'Z';
    B2B_B2_L45_N      <= 'Z';
    B2B_B2_L45_P      <= 'Z';
    B2B_B2_L43_N      <= 'Z';
    B2B_B2_L43_P      <= 'Z';
    B2B_B2_L41_N      <= 'Z';
    B2B_B2_L41_P      <= 'Z';
    B2B_B2_L21_P      <= 'Z';
    B2B_B2_L21_N      <= 'Z';
    B2B_B2_L15_P      <= 'Z';
    B2B_B2_L15_N      <= 'Z';
    B2B_B2_L31_N      <= 'Z';
    B2B_B2_L32_N      <= 'Z';
    B2B_B2_L60_P      <= 'Z';
    B2B_B2_L60_N      <= 'Z';
    B2B_B2_L59_N      <= 'Z';
    B2B_B2_L59_P      <= 'Z';
    B2B_B2_L44_N      <= 'Z';
    B2B_B2_L44_P      <= 'Z';
    B2B_B2_L42_N      <= 'Z';
    B2B_B2_L42_P      <= 'Z';
    B2B_B2_L18_P      <= 'Z';
    B2B_B2_L18_N      <= 'Z';
    B2B_B2_L8_N       <= 'Z';
    B2B_B2_L8_P       <= 'Z';
    B2B_B2_L11_P      <= 'Z';
    B2B_B2_L11_N      <= 'Z';
    B2B_B2_L6_P       <= 'Z';
    B2B_B2_L6_N       <= 'Z';
    B2B_B2_L5_P       <= 'Z';
    B2B_B2_L5_N       <= 'Z';
    B2B_B2_L9_N       <= 'Z';
    B2B_B2_L9_P       <= 'Z';
    B2B_B2_L4_N       <= 'Z';
    B2B_B2_L4_P       <= 'Z';
    B2B_B2_L29_N      <= 'Z';
    B2B_B2_L10_N      <= 'Z';
    B2B_B2_L10_P      <= 'Z';
    B2B_B2_L2_N       <= 'Z';
    B2B_B2_L2_P       <= 'Z';
    B2B_B3_L60_N      <= 'Z';
    B2B_B3_L60_P      <= 'Z';
    --B2B_B3_L9_N       <= 'Z';
    --B2B_B3_L9_P       <= 'Z';
    B2B_B0_L3_P       <= 'Z';
    B2B_B0_L3_N       <= 'Z';

    -- B2B J2 user IO
    --B2B_B3_L59_P      <= 'Z';
    --B2B_B3_L59_N      <= 'Z';
    B2B_B0_L32_P      <= 'Z';
    B2B_B0_L32_N      <= 'Z';
    B2B_B0_L7_N       <= 'Z';
    B2B_B0_L7_P       <= 'Z';
    B2B_B0_L33_N      <= 'Z';
    B2B_B0_L33_P      <= 'Z';
    B2B_B0_L36_P      <= 'Z';
    B2B_B0_L36_N      <= 'Z';
    B2B_B0_L49_P      <= 'Z';
    B2B_B0_L49_N      <= 'Z';
    B2B_B0_L62_P      <= 'Z';
    B2B_B0_L62_N      <= 'Z';
    B2B_B0_L66_P      <= 'Z';
    B2B_B0_L66_N      <= 'Z';
    B2B_B1_L10_P      <= 'Z';
    B2B_B1_L10_N      <= 'Z';
    B2B_B1_L9_P       <= 'Z';
    B2B_B1_L9_N       <= 'Z';
    B2B_B1_L21_N      <= 'Z';
    B2B_B1_L21_P      <= 'Z';
    B2B_B1_L61_P      <= 'Z';
    B2B_B1_L61_N      <= 'Z';
    B2B_B0_L2_P       <= 'Z';
    B2B_B0_L2_N       <= 'Z';
    B2B_B0_L4_N       <= 'Z';
    B2B_B0_L4_P       <= 'Z';
    B2B_B0_L5_N       <= 'Z';
    B2B_B0_L5_P       <= 'Z';
    B2B_B0_L6_N       <= 'Z';
    B2B_B0_L6_P       <= 'Z';
    B2B_B0_L8_N       <= 'Z';
    B2B_B0_L8_P       <= 'Z';
    B2B_B0_L34_N      <= 'Z';
    B2B_B0_L34_P      <= 'Z';
    B2B_B0_L35_N      <= 'Z';
    B2B_B0_L35_P      <= 'Z';
    B2B_B0_L37_N      <= 'Z';
    B2B_B0_L37_P      <= 'Z';
    B2B_B0_L38_N      <= 'Z';
    B2B_B0_L38_P      <= 'Z';
    B2B_B0_L50_N      <= 'Z';
    B2B_B0_L50_P      <= 'Z';
    B2B_B0_L51_N      <= 'Z';
    B2B_B0_L51_P      <= 'Z';
    B2B_B0_L63_N      <= 'Z';
    B2B_B0_L63_P      <= 'Z';
    B2B_B0_L64_N      <= 'Z';
    B2B_B0_L64_P      <= 'Z';
    B2B_B0_L65_N      <= 'Z';
    B2B_B0_L65_P      <= 'Z';
    B2B_B1_L20_P      <= 'Z';
    B2B_B1_L20_N      <= 'Z';
    B2B_B1_L19_P      <= 'Z';
    B2B_B1_L19_N      <= 'Z';
    B2B_B1_L59        <= 'Z';


    ------------------------------------------------------------ 
    -- (internal) reset generation
    -- with wait for locked DCM
    reset_generator_p : process( clk_box, clk_ready)
    begin
		if clk_ready = '0' then
            reset_shreg <= (others => '1');
	    elsif rising_edge( clk_box) then
            reset_shreg <= reset_shreg(reset_shreg'left-1 downto 0) & '0';
        end if;     
    end process;
    reset   <= reset_shreg(reset_shreg'left);
    reset_n <= not reset;
    
    
    ------------------------------------------------------------ 
    -- clock selection
    clk_box                 <= CLK; -- 125 MHz 

    -- used IOs
    -- LEDs
    gpioi.sig_in            <= ( others => '0');
    gpioi.sig_en            <= ( others => '0');
    gpioi.din               <= (  4     => MAC_DATA, 
                                 31     => simulation_active,
                                 others => '0');
    CARRIER_LED0            <= not box_i0_gpioo.dout( 0);
    CARRIER_LED1            <= not box_i0_gpioo.dout( 1);
    CARRIER_LED2            <= not box_i0_gpioo.dout( 2);
    CARRIER_LED3            <= not box_i0_gpioo.dout( 3);
	user_led_n              <= not box_i0_gpioo.dout( 5);
    MAC_DATA                <= box_i0_gpioo.dout(4) when box_i0_gpioo.oen(4) = '0' else 'Z';
                            
    -- uart i/o             
    uarti.rxd               <= UART_RX;
    uarti.ctsn              <= '0';
    uarti.extclk            <= '0';
    --                      
    UART_TX                 <= box_i0_uarto.txd;
    
    
    ------------------------------------------------------------ 
    -- box system
    box_i0: entity work.box
        generic map (
            simulation_active => simulation_active,               --: std_ulogic;
            system_frequency  => system_frequency_c               --: integer
        )                                                         
        port map (                                                
            clk                       => clk_box,                 --: in    std_ulogic;
            reset_n                   => reset_n,                 --: in    std_ulogic;
            break                     => box_i0_break,            --: out   std_ulogic;
            --                                                               
            uarti                     => uarti,                   --: in    uart_in_type;
            uarto                     => box_i0_uarto,            --: out   uart_out_type;
            --                                                               
            gpioi                     => gpioi,                   --: in    gpio_in_type;
            gpioo                     => box_i0_gpioo             --: out   gpio_out_type;
            );


    ------------------------------------------------------------ 
    -- break handling
    --
    -- pragma translate_off
    simulation_break <= box_i0_break;
    -- pragma translate_on

    -- reboot FPGA for real
    REPROG_N <= not box_i0_break;

end architecture Behavioral;
