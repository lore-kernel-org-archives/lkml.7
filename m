Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FB1C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF2820880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563297320;
	bh=X7YEpFT0p8vt5Zl+0UxPWGfS6+EKPB5OGdz4wCereEA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=r8H6MxC2Om+NNCKFQUy0wUWyqUOCy7XkaqqyjCZGnUX2M8OYUG1MzrrYGH1NHKmJx
	 T2QhhOnnSGMW5EsTocjG9w73FKQVewnOWB4abr8CJ9J3O/vKXcoQUejcqMjZ1pg1f1
	 v9jufkFVz1KDBHPVo4TnviNuHd050+eq4V6oY7rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfGPRPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfGPRPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:15:18 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D85D420880;
        Tue, 16 Jul 2019 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563297316;
        bh=X7YEpFT0p8vt5Zl+0UxPWGfS6+EKPB5OGdz4wCereEA=;
        h=From:To:Cc:Subject:Date:From;
        b=fv7Nt/zeJwbjtX2pNRSyHaXG1HkAe7UEC+kIwsqjaBVgGig6kM6s0x58SVQpR6Wa3
         /eo+JzF2jg7NzRfnr6Vgf1hM6Wm13qJ18ftxPGZApTspJTYHKKoBj7hiXSJNeKumUY
         lP8CVMT33tZbXAw2a1Ky0zkw0cQj8rEspbQLdn4c=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Tue, 16 Jul 2019 10:15:15 -0700
Message-Id: <20190716171515.62403-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3ff46efbcd90d3d469de8eddaf03d12293aaa50c:

  clk: meson: meson8b: fix a typo in the VPU parent names array variable (2019-05-20 12:11:08 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to b1511f7a48c3ab28ae10b7ea1e9eae1481525bbe:

  Merge branches 'clk-bcm63xx', 'clk-silabs', 'clk-lochnagar' and 'clk-rockchip' into clk-next (2019-07-12 11:11:51 -0700)

----------------------------------------------------------------
This round of clk driver and framework updates is heavy on the driver update
side. The two main highlights in the core framework are the addition of an bulk
clk_get API that handles optional clks and an extra debugfs file that tells the
developer about the current parent of a clk.

The driver updates are dominated by i.MX in the diffstat, but that is mostly
because that SoC has started converting to the clk_hw style of clk
registration. The next big update is in the Amlogic meson clk driver that
gained some support for audio, cpu, and temperature clks while fixing some PLL
issues. Finally, the biggest thing that stands out is the conversion of a large
part of the Allwinner sunxi-ng driver to the new clk parent scheme that uses
less strings and more pointer comparisons to match clk parents and children up.

In general, it looks like we have a lot of little fixes and tweaks here and
there to clk data along with the normal addition of a handful of new drivers
and a couple new core framework features.

Core:
 - Add a 'clk_parent' file in clk debugfs
 - Add a clk_bulk_get_optional() API (with devm too)

New Drivers:
 - Support gated clk controller on MIPS based BCM63XX SoCs
 - Support SiLabs Si5341 and Si5340 chips
 - Support for CPU clks on Raspberry Pi devices
 - Audsys clock driver for MediaTek MT8516 SoCs

Updates:
 - Convert a large portion of the Allwinner sunxi-ng driver to new clk parent scheme
 - Small frequency support for SiLabs Si544 chips
 - Slow clk support for AT91 SAM9X60 SoCs
 - Remove dead code in various clk drivers (-Wunused)
 - Support for Marvell 98DX1135 SoCs
 - Get duty cycle of generic pwm clks
 - Improvement in mmc phase calculation and cleanup of some rate defintions
 - Switch i.MX6 and i.MX7 clock drivers to clk_hw based APIs
 - Add GPIO, SNVS and GIC clocks for i.MX8 drivers
 - Mark imx6sx/ul/ull/sll MMDC_P1_IPG and imx8mm DRAM_APB as critical clock
 - Correct imx7ulp nic1_bus_clk and imx8mm audio_pll2_clk clock setting
 - Add clks for new Exynos5422 Dynamic Memory Controller driver
 - Clock definition for Exynos4412 Mali
 - Add CMM (Color Management Module) clocks on Renesas R-Car H3, M3-N, E3, and D3
 - Add TPU (Timer Pulse Unit / PWM) clocks on Renesas RZ/G2M
 - Support for 32 bit clock IDs in TI's sci-clks for J721e SoCs
 - TI clock probing done from DT by default instead of firmware
 - Fix Amlogic Meson mpll fractional part and spread sprectrum issues
 - Add Amlogic meson8 audio clocks
 - Add Amlogic g12a temperature sensors clocks
 - Add Amlogic g12a and g12b cpu clocks
 - Add TPU (Timer Pulse Unit / PWM) clocks on Renesas R-Car H3, M3-W, and M3-N
 - Add CMM (Color Management Module) clocks on Renesas R-Car M3-W
 - Add Clock Domain support on Renesas RZ/N1

----------------------------------------------------------------
Abel Vesa (18):
      clk: imx: Add imx_obtain_fixed_clock clk_hw based variant
      clk: imx6sx: Do not reparent to unregistered IMX6SX_CLK_AXI
      clk: imx6q: Do not reparent uninitialized IMX6QDL_CLK_PERIPH2 clock
      clk: imx: clk-busy: Switch to clk_hw based API
      clk: imx: clk-cpu: Switch to clk_hw based API
      clk: imx: clk-gate2: Switch to clk_hw based API
      clk: imx: clk-pllv3: Switch to clk_hw based API
      clk: imx: clk-pfd: Switch to clk_hw based API
      clk: imx: clk-gate-exclusive: Switch to clk_hw based API
      clk: imx: clk-fixup-div: Switch to clk_hw based API
      clk: imx: clk-fixup-mux: Switch to clk_hw based API
      clk: imx: Switch wrappers to clk_hw based API
      clk: imx6sl: Switch to clk_hw based API
      clk: imx6q: Switch to clk_hw based API
      clk: imx6sx: Switch to clk_hw based API
      clk: imx6ul: Switch to clk_hw based API
      clk: imx7d: Switch to clk_hw based API
      clk: imx6sll: Switch to clk_hw based API

Anson Huang (14):
      dt-bindings: clock: imx8mm: Add GPIO clocks
      clk: imx8mm: add GPIO clocks to clock tree
      dt-bindings: clock: imx8mq: Add SNVS clock
      clk: imx8mq: add SNVS clock to clock tree
      dt-bindings: clock: imx8mm: Add SNVS clock
      clk: imx8mm: add SNVS clock to clock tree
      clk: imx: Add common API for masking MMDC handshake
      clk: imx: Use imx_mmdc_mask_handshake() API for masking MMDC channel
      clk: imx7ulp: update nic1_bus_clk parent info
      clk: imx: Remove __init for imx_check_clocks() API
      clk: imx8mq: Use imx_check_clocks() API directly
      clk: imx8mq: Use devm_platform_ioremap_resource() instead of of_iomap()
      clk: imx: Remove __init for imx_register_uart_clocks() API
      clk: imx8mq: Keep uart clocks on during system boot

Arnd Bergmann (1):
      clk: imx6q: fix section mismatch warning

Bjorn Andersson (2):
      clk: qcom: gdsc: WARN when failing to toggle
      clk: gcc-qcs404: Add PCIe resets

Cao Van Dong (1):
      clk: renesas: r8a779{5|6|65}: Add TPU clock

Charles Keepax (2):
      clk: lochnagar: Use new parent_data approach to register clock parents
      clk: lochnagar: Update DT binding doc to include the primary SPDIF MCLK

Chen-Yu Tsai (25):
      clk: Fix debugfs clk_possible_parents for clks without parent string names
      clk: Add CLK_HW_INIT_* macros using .parent_hws
      clk: Add CLK_HW_INIT_FW_NAME macro using .fw_name in .parent_data
      clk: Add CLK_HW_INIT_PARENT_DATA macro using .parent_data
      clk: fixed-factor: Add CLK_FIXED_FACTOR_HW which takes clk_hw pointer as parent
      clk: fixed-factor: Add CLK_FIXED_FACTOR_HWS which takes list of struct clk_hw *
      clk: fixed-factor: Add CLK_FIXED_FACTOR_FW_NAME for DT clock-names parent
      clk: sunxi-ng: switch to of_clk_hw_register() for registering clks
      clk: sunxi-ng: sun8i-r: Use local parent references for CLK_HW_INIT_*
      clk: sunxi-ng: a10: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: sun5i: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: a31: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: a23: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: a33: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: h3: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: r40: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: v3s: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: sun8i-r: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: f1c100s: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: a64: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: h6: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: h6-r: Use local parent references for CLK_FIXED_FACTOR
      clk: sunxi-ng: gate: Add macros for referencing local clock parents
      clk: sunxi-ng: a80-usb: Use local parent references for SUNXI_CCU_GATE
      clk: sunxi-ng: sun8i-r: Use local parent references for SUNXI_CCU_GATE

Chris Packham (2):
      dt-bindings: clock: mvebu: Add compatible string for 98dx1135 core clock
      clk: kirkwood: Add support for MV98DX1135

Chunyan Zhang (3):
      clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
      clk: sprd: Check error only for devm_regmap_init_mmio()
      clk: sprd: Add check for return value of sprd_clk_regmap_init()

Claudiu Beznea (11):
      clk: at91: sckc: sama5d4 has no bypass support
      clk: at91: sckc: add support to specify registers bit offsets
      dt-bindings: clk: at91: add bindings for SAM9X60's slow clock controller
      clk: at91: sckc: add support for SAM9X60
      clk: at91: sckc: add support to free slow oscillator
      clk: at91: sckc: add support to free slow rc oscillator
      clk: at91: sckc: add support to free slow clock osclillator
      clk: at91: sckc: improve error path for sam9x5 sck register
      clk: at91: sckc: remove unnecessary line
      clk: at91: sckc: improve error path for sama5d4 sck registration
      clk: at91: sckc: use dedicated functions to unregister clock

Dinh Nguyen (2):
      clk: socfpga: stratix10: add additional clocks needed for the NAND IP
      clk: socfpga: stratix10: fix divider entry for the emac clocks

Douglas Anderson (4):
      clk: rockchip: Use clk_hw_get_rate() in MMC phase calculation
      clk: rockchip: Don't yell about bad mmc phases when getting
      clk: rockchip: Slightly more accurate math in rockchip_mmc_get_phase()
      clk: rockchip: Remove 48 MHz PLL rate from rk3288

Erin Lo (1):
      clk: mediatek: Remove MT8183 unused clock

Fabien Parent (2):
      dt-bindings: mediatek: audsys: add support for MT8516
      clk: mediatek: add audsys clock driver for MT8516

Fabrizio Castro (1):
      clk: renesas: r8a774a1: Add TMU clock

Florian Fainelli (2):
      clk: bcm: Make BCM2835 clock drivers selectable
      clk: bcm: Allow CLK_BCM2835 for ARCH_BRCMSTB

Gareth Williams (2):
      dt-bindings: clock: renesas: r9a06g032-sysctrl: Document power Domains
      clk: renesas: r9a06g032: Add clock domain support

Geert Uytterhoeven (10):
      clk: renesas: cpg-mssr: Use genpd of_node instead of local copy
      clk: renesas: cpg-mssr: Remove error messages on out-of-memory conditions
      clk: renesas: mstp: Remove error messages on out-of-memory conditions
      clk: renesas: cpg-mssr: Update kerneldoc for struct cpg_mssr_priv
      clk: renesas: div6: Combine clock-private and parent array allocation
      clk: renesas: mstp: Combine group-private and clock array allocation
      clk: renesas: cpg-mssr: Combine driver-private and clock array allocation
      clk: renesas: cpg-mssr: Use [] to denote a flexible array member
      clk: Simplify clk_core_can_round()
      clk: Grammar missing "and", Spelling s/statisfied/satisfied/

Gen Zhang (1):
      clk-sunxi: fix a missing-check bug in sunxi_divs_clk_setup()

Guillaume La Roque (2):
      dt-bindings: clk: g12a-clkc: add Temperature Sensor clock IDs
      clk: meson-g12a: add temperature sensor clocks

Heiko Stuebner (7):
      clk: rockchip: add a type from SGRF-controlled gate clocks
      clk: rockchip: convert pclk_wdt boilerplat to new SGRF_GATE macro
      clk: rockchip: add clock id for watchdog pclk on rk3328
      clk: rockchip: add clock id for hdmi_phy special clock on rk3228
      Merge branch 'v5.3-shared/clk-ids' into v5.3-clk/next
      clk: rockchip: add watchdog pclk on rk3328
      clk: rockchip: export HDMIPHY clock on rk3228

JC Kuo (1):
      clk: tegra210: fix PLLU and PLLU_OUT1

Jacky Bai (1):
      clk: imx: keep the mmdc p1 ipg clock always on on 6sx/ul/ull/sll

Jacopo Mondi (5):
      clk: renesas: r8a7796: Add CMM clocks
      clk: renesas: r8a7795: Add CMM clocks
      clk: renesas: r8a77965: Add CMM clocks
      clk: renesas: r8a77990: Add CMM clocks
      clk: renesas: r8a77995: Add CMM clocks

Jeffrey Hugo (1):
      dt-bindings: clock: Document gpucc for msm8998

Jerome Brunet (10):
      clk: meson: mpll: properly handle spread spectrum
      clk: meson: gxbb: no spread spectrum on mpll0
      clk: meson: axg: spread spectrum is on mpll2
      clk: meson: mpll: add init callback and regs
      clk: meson: g12a: add mpll register init sequences
      clk: meson: eeclk: add init regs
      clk: meson: g12a: add controller register init
      Merge branch 'v5.3/dt' into v5.3/drivers
      Merge branch 'v5.3/dt' into v5.3/drivers
      Merge branch 'v5.3/dt' into v5.3/drivers

Jonas Gorski (2):
      devicetree: document the BCM63XX gated clock bindings
      clk: add BCM63XX gated clock controller driver

Justin Swartz (1):
      clk: rockchip: add 1.464GHz cpu-clock rate to rk3228

Kefeng Wang (1):
      clk: samsung: exynos5433: Use of_clk_get_parent_count()

Krzysztof Kozlowski (1):
      clk: samsung: Add bus clock for GPU/G3D on Exynos4412

Leonard Crestez (4):
      dt-bindings: clock: imx8m: Add GIC clock
      clk: imx8m: Add GIC clock
      clk: imx8mm: Mark dram_apb critical
      clk: Add clk_parent entry in debugfs

Lukasz Luba (3):
      clk: samsung: add needed IDs for DMC clocks in Exynos5420
      clk: samsung: add BPLL rate table for Exynos 5422 SoC
      clk: samsung: add new clocks for DMC for Exynos5422 SoC

Marc Gonzalez (1):
      clk: xgene: Don't build COMMON_CLK_XGENE by default

Martin Blumenstingl (5):
      clk: pwm: implement the .get_duty_cycle callback
      dt-bindings: clock: meson8b: add the audio clocks
      clk: meson: meson8b: add the cts_amclk clocks
      clk: meson: meson8b: add the cts_mclk_i958 clocks
      clk: meson: meson8b: add the cts_i958 clock

Maxime Ripard (1):
      dt-bindings: clk: Convert Allwinner CCU to a schema

Mike Looijmans (3):
      clk: clk-si544: Implement small frequency change support
      dt-bindings: clock: Add silabs,si5341
      clk: Add Si5341/Si5340 driver

Nathan Huckleberry (1):
      clk: qcom: Fix -Wunused-const-variable

Neil Armstrong (3):
      dt-bindings: clk: meson: add g12b periph clock controller bindings
      clk: meson: g12a: Add support for G12B CPUB clocks
      clk: meson: g12a: mark fclk_div3 as critical

Nicolas Saenz Julienne (4):
      clk: bcm2835: remove pllb
      clk: bcm283x: add driver interfacing with Raspberry Pi's firmware
      firmware: raspberrypi: register clk device
      clk: raspberrypi: register platform device for raspberrypi-cpufreq

Ondrej Jirman (1):
      clk: sunxi-ng: sun50i-h6-r: Fix incorrect W1 clock gate register

Paul Cercueil (10):
      clk: ingenic: Add support for divider tables
      clk: ingenic/jz4740: Fix incorrect dividers for main clocks
      clk: ingenic/jz4770: Fix incorrect dividers for main clocks
      clk: ingenic/jz4725b: Fix incorrect dividers for main clocks
      clk: ingenic/jz4725b: Fix "pll half" divider not read/written properly
      clk: ingenic: Add missing header in cgu.h
      clk: ingenic: Handle setting the Low-Power Mode bit
      MIPS: jz4740: PM: Let CGU driver suspend clocks and set sleep mode
      clk: ingenic: Remove unused functions
      MIPS: Remove dead code

Peng Fan (1):
      clk: imx: imx8mm: correct audio_pll2_clk to audio_pll2_out

Philippe Mazenauer (1):
      clk: mediatek: mt8516: Remove unused variable

Stephen Boyd (21):
      clk: Remove ifdef for COMMON_CLK in clk-provider.h
      clk: Unexport __clk_of_table
      Merge tag 'clk-renesas-for-v5.3-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-5.3-1' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'keystone-clk-for-5.3-v2' of git://git.kernel.org/.../kristo/linux into clk-ti
      clk: ti: Use int to check return value from of_property_count_elems_of_size()
      Merge tag 'sunxi-clk-for-5.3-201906210814' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'sunxi-ng-parent-rewrite-part-1-take-2' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'clk-renesas-for-v5.3-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'clk-v5.3-samsung' of git://git.kernel.org/.../snawrocki/clk into clk-samsung
      Merge tag 'imx-clk-5.3' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      clk: Simplify debugfs printing and add a newline
      clk: Document some devm_clk_bulk*() APIs
      Merge tag 'v5.3-rockchip-clk1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      Merge branches 'clk-pwm-duty', 'clk-bcm', 'clk-mtk', 'clk-qcom-msm8998-gpu' and 'clk-renesas' into clk-next
      Merge branches 'clk-qcom-gdsc-warn', 'clk-ingenic', 'clk-qcom-qcs404-reset', 'clk-xgene-limit' and 'clk-meson' into clk-next
      Merge branches 'clk-ti', 'clk-samsung', 'clk-imx' and 'clk-allwinner' into clk-next
      Merge branches 'clk-bulk-optional', 'clk-kirkwood', 'clk-socfpga' and 'clk-docs' into clk-next
      Merge branches 'clk-debugfs', 'clk-unused', 'clk-refactor' and 'clk-qoriq' into clk-next
      Merge branches 'clk-rpi-cpufreq', 'clk-tegra', 'clk-simplify-provider.h', 'clk-sprd' and 'clk-at91' into clk-next
      Merge branches 'clk-bcm63xx', 'clk-silabs', 'clk-lochnagar' and 'clk-rockchip' into clk-next

Stephen Rothwell (1):
      clk: consoldiate the __clk_get_hw() declarations

Sylwester Nawrocki (2):
      clk: Add clk_bulk_get_optional() function
      clk: Add devm_clk_bulk_get_optional() function

Tero Kristo (5):
      clk: keystone: sci-clk: cut down the clock name length
      clk: keystone: sci-clk: split out the fw clock parsing to own function
      clk: keystone: sci-clk: probe clocks from DT instead of firmware
      clk: keystone: sci-clk: extend clock IDs to 32 bits
      firmware: ti_sci: extend clock identifiers from u8 to u32

Thierry Reding (3):
      clk: tegra: Do not warn unnecessarily
      clk: tegra: Warn if an enabled PLL is in IDDQ
      clk: tegra: Do not enable PLL_RE_VCO on Tegra210

Vabhav Sharma (1):
      clk: qoriq: add support for lx2160a

Wolfram Sang (1):
      clk: clk-cdce706: simplify getting the adapter of a client

YueHaibing (2):
      clk: ti: Remove unused functions
      clk: mmp: frac: Remove set but not used variable 'prev_rate'

 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |  141 ++
 .../bindings/clock/amlogic,gxbb-clkc.txt           |    1 +
 .../devicetree/bindings/clock/at91-clock.txt       |    7 +-
 .../bindings/clock/brcm,bcm63xx-clocks.txt         |   22 +
 .../devicetree/bindings/clock/cirrus,lochnagar.txt |    1 +
 .../devicetree/bindings/clock/mvebu-core-clock.txt |    1 +
 .../devicetree/bindings/clock/qcom,gpucc.txt       |    4 +-
 .../bindings/clock/renesas,r9a06g032-sysctrl.txt   |    7 +-
 .../devicetree/bindings/clock/silabs,si5341.txt    |  162 +++
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   62 -
 Documentation/driver-model/devres.txt              |    4 +
 arch/mips/include/asm/mach-jz4740/clock.h          |   31 -
 arch/mips/jz4740/board-qi_lb60.c                   |    2 -
 arch/mips/jz4740/platform.c                        |    2 -
 arch/mips/jz4740/pm.c                              |    8 -
 arch/mips/jz4740/time.c                            |    3 -
 drivers/clk/Kconfig                                |   13 +-
 drivers/clk/Makefile                               |    1 +
 drivers/clk/at91/sckc.c                            |  281 +++-
 drivers/clk/bcm/Kconfig                            |   24 +
 drivers/clk/bcm/Makefile                           |    6 +-
 drivers/clk/bcm/clk-bcm2835.c                      |   28 +-
 drivers/clk/bcm/clk-bcm63xx-gate.c                 |  238 ++++
 drivers/clk/bcm/clk-raspberrypi.c                  |  315 +++++
 drivers/clk/clk-bulk.c                             |   23 +-
 drivers/clk/clk-cdce706.c                          |    2 +-
 drivers/clk/clk-devres.c                           |   22 +-
 drivers/clk/clk-lochnagar.c                        |  205 ++-
 drivers/clk/clk-pwm.c                              |   14 +
 drivers/clk/clk-qoriq.c                            |   12 +
 drivers/clk/clk-si5341.c                           | 1346 ++++++++++++++++++++
 drivers/clk/clk-si544.c                            |  102 +-
 drivers/clk/clk.c                                  |   63 +-
 drivers/clk/clk.h                                  |    4 -
 drivers/clk/imx/clk-busy.c                         |   30 +-
 drivers/clk/imx/clk-cpu.c                          |   14 +-
 drivers/clk/imx/clk-fixup-div.c                    |   15 +-
 drivers/clk/imx/clk-fixup-mux.c                    |   15 +-
 drivers/clk/imx/clk-gate-exclusive.c               |   17 +-
 drivers/clk/imx/clk-gate2.c                        |   14 +-
 drivers/clk/imx/clk-imx6q.c                        |  782 ++++++------
 drivers/clk/imx/clk-imx6sl.c                       |  409 +++---
 drivers/clk/imx/clk-imx6sll.c                      |  434 ++++---
 drivers/clk/imx/clk-imx6sx.c                       |  662 +++++-----
 drivers/clk/imx/clk-imx6ul.c                       |  580 ++++-----
 drivers/clk/imx/clk-imx7d.c                        |  984 +++++++-------
 drivers/clk/imx/clk-imx7ulp.c                      |    2 +-
 drivers/clk/imx/clk-imx8mm.c                       |   18 +-
 drivers/clk/imx/clk-imx8mq.c                       |   27 +-
 drivers/clk/imx/clk-pfd.c                          |   14 +-
 drivers/clk/imx/clk-pllv3.c                        |   14 +-
 drivers/clk/imx/clk.c                              |   35 +-
 drivers/clk/imx/clk.h                              |  143 ++-
 drivers/clk/ingenic/Makefile                       |    2 +-
 drivers/clk/ingenic/cgu.c                          |   41 +-
 drivers/clk/ingenic/cgu.h                          |    4 +
 drivers/clk/ingenic/jz4725b-cgu.c                  |   41 +-
 drivers/clk/ingenic/jz4740-cgu.c                   |  105 +-
 drivers/clk/ingenic/jz4770-cgu.c                   |   67 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |    3 +
 drivers/clk/ingenic/pm.c                           |   45 +
 drivers/clk/ingenic/pm.h                           |   12 +
 drivers/clk/keystone/Kconfig                       |   11 +
 drivers/clk/keystone/sci-clk.c                     |  239 +++-
 drivers/clk/mediatek/Kconfig                       |    6 +
 drivers/clk/mediatek/Makefile                      |    1 +
 drivers/clk/mediatek/clk-mt8183.c                  |   19 -
 drivers/clk/mediatek/clk-mt8516-aud.c              |   65 +
 drivers/clk/mediatek/clk-mt8516.c                  |    5 -
 drivers/clk/meson/axg.c                            |   10 +-
 drivers/clk/meson/clk-mpll.c                       |   36 +-
 drivers/clk/meson/clk-mpll.h                       |    3 +
 drivers/clk/meson/g12a.c                           |  843 +++++++++++-
 drivers/clk/meson/g12a.h                           |   41 +-
 drivers/clk/meson/gxbb.c                           |    5 -
 drivers/clk/meson/meson-eeclk.c                    |    3 +
 drivers/clk/meson/meson-eeclk.h                    |    2 +
 drivers/clk/meson/meson8b.c                        |  154 +++
 drivers/clk/meson/meson8b.h                        |    8 +-
 drivers/clk/mmp/clk-frac.c                         |    3 +-
 drivers/clk/mvebu/kirkwood.c                       |   17 +
 drivers/clk/qcom/gcc-msm8996.c                     |   36 -
 drivers/clk/qcom/gcc-qcs404.c                      |    7 +
 drivers/clk/qcom/gdsc.c                            |    4 +-
 drivers/clk/renesas/clk-div6.c                     |   19 +-
 drivers/clk/renesas/clk-mstp.c                     |   20 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    5 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    5 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    4 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    4 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    2 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    2 +
 drivers/clk/renesas/r9a06g032-clocks.c             |  227 +++-
 drivers/clk/renesas/renesas-cpg-mssr.c             |   37 +-
 drivers/clk/rockchip/clk-mmc-phase.c               |   14 +-
 drivers/clk/rockchip/clk-px30.c                    |   12 +-
 drivers/clk/rockchip/clk-rk3228.c                  |    3 +-
 drivers/clk/rockchip/clk-rk3288.c                  |   13 +-
 drivers/clk/rockchip/clk-rk3328.c                  |    3 +
 drivers/clk/rockchip/clk-rk3368.c                  |   12 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   12 +-
 drivers/clk/rockchip/clk.h                         |    4 +
 drivers/clk/samsung/clk-exynos4.c                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   78 +-
 drivers/clk/samsung/clk-exynos5433.c               |    4 +-
 drivers/clk/socfpga/clk-s10.c                      |   10 +-
 drivers/clk/sprd/common.c                          |    9 +-
 drivers/clk/sprd/sc9860-clk.c                      |    5 +-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c               |   39 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |   41 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |    4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |   69 +-
 drivers/clk/sunxi-ng/ccu-sun5i.c                   |   34 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   39 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |   34 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |   34 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   29 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |  104 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |   46 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |   29 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           |   32 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |   29 +-
 drivers/clk/sunxi-ng/ccu_common.c                  |    2 +-
 drivers/clk/sunxi-ng/ccu_gate.h                    |   53 +
 drivers/clk/sunxi/clk-sunxi.c                      |    2 +
 drivers/clk/tegra/clk-tegra210.c                   |   20 +-
 drivers/clk/ti/divider.c                           |   85 --
 drivers/clk/ti/gate.c                              |   30 -
 drivers/clk/ti/mux.c                               |   31 -
 drivers/firmware/raspberrypi.c                     |   10 +
 drivers/firmware/ti_sci.c                          |  124 +-
 drivers/firmware/ti_sci.h                          |   63 +-
 include/dt-bindings/clock/exynos4.h                |    1 +
 include/dt-bindings/clock/exynos5420.h             |   18 +-
 include/dt-bindings/clock/g12a-clkc.h              |    1 +
 include/dt-bindings/clock/imx8mm-clock.h           |   11 +-
 include/dt-bindings/clock/imx8mq-clock.h           |    5 +-
 include/dt-bindings/clock/meson8b-clkc.h           |    3 +
 include/dt-bindings/clock/mt8516-clk.h             |   17 +
 include/dt-bindings/clock/qcom,gcc-qcs404.h        |    7 +
 include/dt-bindings/clock/qcom,gpucc-msm8998.h     |   29 +
 include/dt-bindings/clock/rk3228-cru.h             |    1 +
 include/dt-bindings/clock/rk3328-cru.h             |    1 +
 include/dt-bindings/clock/stratix10-clock.h        |    4 +-
 include/linux/clk-provider.h                       |  103 +-
 include/linux/clk.h                                |   47 +
 include/linux/soc/ti/ti_sci_protocol.h             |   28 +-
 148 files changed, 7738 insertions(+), 3231 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi-ccu.txt
 delete mode 100644 arch/mips/include/asm/mach-jz4740/clock.h
 create mode 100644 drivers/clk/bcm/clk-bcm63xx-gate.c
 create mode 100644 drivers/clk/bcm/clk-raspberrypi.c
 create mode 100644 drivers/clk/clk-si5341.c
 create mode 100644 drivers/clk/ingenic/pm.c
 create mode 100644 drivers/clk/ingenic/pm.h
 create mode 100644 drivers/clk/mediatek/clk-mt8516-aud.c
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-msm8998.h

-- 
Sent by a computer through tubes
