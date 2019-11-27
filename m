Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687D9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0720869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890584;
	bh=wKdHCrOgNhQnGEg7eXgpp5pH1ivrw7sdHXDRWYNcUXs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UCY+0DKNdO6fREuElNXsAylKTK0T89ukYIb7/Rh7WxGbq7NQF5Eq5Lx5AycLGUV+A
	 ZV0qMV2Lk10vuBSI9UvUUWpg6AbWwtUBRlT2uzwcn2YOoUgPiaLysrpAyI0J/y3oDi
	 lUjDZg4+yyaP/LcQQ4znQitg/prIJpaxuL6NoUv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfK0VgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfK0VgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:36:20 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6860520869;
        Wed, 27 Nov 2019 21:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574890579;
        bh=wKdHCrOgNhQnGEg7eXgpp5pH1ivrw7sdHXDRWYNcUXs=;
        h=From:To:Cc:Subject:Date:From;
        b=yx6V7lGh30Z6sc8WBOqdDXo+DmVRfR96vbDnEDbTqnNo7ICYzNdJWY5j3A7GDV9au
         MvZmCaMss2+nrFUj/n9Z9kkHuYZ39qLISFmaviteJAOdOJ57bKwvQRBZwtaB/5FUrx
         nScvfjILT3GniN2x24BUp1NMQuHRsBisDbSEoeyw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Wed, 27 Nov 2019 13:36:18 -0800
Message-Id: <20191127213618.236975-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e9323b664ce29547d996195e8a6129a351c39108:

  clk: samsung: exynos5420: Preserve PLL configuration during suspend/resume (2019-10-25 11:20:00 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to ec16ffe36d80b18a1f98d126a865d5557ab27c30:

  Merge branches 'clk-ingenic', 'clk-init-leak', 'clk-ux500' and 'clk-bitmain' into clk-next (2019-11-27 08:15:13 -0800)

----------------------------------------------------------------
This merge window we have one small clk provider API in the core framework and
then a bunch of driver updates and a handful of new drivers. In terms of
diffstat the Qualcomm and Amlogic drivers are high up there because of all the
clk data introcued by new drivers. The Nvidia Tegra driver had a lot of work
done this cycle too to support suspend/resume and memory controllers. And the
OMAP clk driver got proper clk and reset handling in place.

Rounding out the patches are various updates to remove unused data, mark things
static, correct incorrect data in drivers, etc. All the little things that
improve drivers and maintain code health. I will point out that there's a patch
in here for the GPIO clk driver, that almost nobody uses, which changes
behavior and causes clk_set_rate() to try to change the GPIO gate clk's parent.
Other than that things are fairly well SoC specific here.

Core:
 - Add a clk provider API to get current parent index
 - Plug a memory leak in clk_unregister() path

New Drivers:
 - CGU in Ingenix X1000
 - Bitmain BM1880 clks
 - Qualcomm MSM8998 GPU clk controllers
 - Qualcomm SC7180 GCC and RPMH clk controllers
 - Qualcomm QCS404 Q6SSTOP clk controllers
 - Add support for the Renesas R-Car M3-W+ (r8a77961) SoC
 - Add support for the Renesas RZ/G2N (r8a774b1) SoC
 - Add Tegra20/30 External Memory Clock (EMC) support

Updates:
 - Make gpio gate clks propagate rate setting up to parent
 - Prepare Armada 3700 for suspend to RAM by moving PCIe suspend/resume priority
 - Drop unused variables, enums, etc. in various clk drivers
 - Convert various drivers to use devm_platform_ioremap_resource()
 - Use struct_size() some more in various clk drivers
 - Improve Rockchip px30 clk tree
 - Add suspend/resume support to Tegra210 clk driver
 - Reimplement SOR clks on earlier Tegra SoCs, helping HDMI and DP
 - Allwinner DT exports and H6 clk tree fixes
 - Proper clk and reset handling for OMAP SoCs
 - Revamped TI divider clk to clamp max divider
 - Make 1443X/1416X PLL clock structure common for reusing among i.MX8 SoCs
 - Drop IMX7ULP_CLK_MIPI_PLL clock, it shouldn't be used
 - Add VIDEO2_PLL clock for imx8mq
 - Add missing gate clock for pll1/2 fixed dividers on i.MX8 SoCs
 - Add sm1 support in the Amlogic audio clock controller
 - Switch some clocks on R-Car Gen2/3 to .determine_rate()
 - Remove Renesas R-Car Gen2 legacy DT clock support
 - Improve arithmetic divisions on Renesas R-Car Gen2 and Gen3
 - Improve Renesas R-Car Gen3 SD clock handling
 - Add rate table for Samsung exynos542x GPU and VPLL clks
 - Fix potential CPU performance degradation after system suspend/resume cycle
   on exynos542x SoCs

----------------------------------------------------------------
Andrew Jeffery (4):
      dt-bindings: clock: Add AST2500 RMII RCLK definitions
      dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
      clk: ast2600: Add RMII RCLK gates for all four MACs
      clk: aspeed: Add RMII RCLK gates for both AST2500 MACs

Anson Huang (4):
      clk: imx8mm: Move 1443X/1416X PLL clock structure to common place
      clk: imx8mn: Use common 1443X/1416X PLL clock structure
      clk: imx7ulp: Correct system clock source option #7
      clk: imx7ulp: Correct DDR clock mux options

Baolin Wang (2):
      clk: sprd: Change to use devm_platform_ioremap_resource()
      clk: sprd: Use IS_ERR() to validate the return value of syscon_regmap_lookup_by_phandle()

Ben Dooks (2):
      clk: hisilicon: fix sparse warnings in clk-hi3670.c
      clk: hisilicon: fix sparse warnings in clk-hi3660.c

Ben Dooks (Codethink) (1):
      clk: rockchip: make clk_half_divider_ops static

Biju Das (5):
      dt-bindings: power: Add r8a774b1 SYSC power domain definitions
      dt-bindings: clk: Add r8a774b1 CPG Core Clock Definitions
      dt-bindings: clock: renesas: cpg-mssr: Document r8a774b1 binding
      clk: renesas: cpg-mssr: Add r8a774b1 support
      clk: renesas: r8a774b1: Add TMU clock

Dmitry Osipenko (3):
      clk: tegra: Add Tegra20/30 EMC clock implementation
      clk: tegra: Optimize PLLX restore on Tegra20/30
      clk: tegra: Add missing stubs for the case of !CONFIG_PM_SLEEP

Fancy Fang (1):
      clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL clock

Finley Xiao (2):
      clk: rockchip: Add div50 clock-ids for sdmmc on px30 and nandc
      clk: rockchip: Add div50 clocks for px30 sdmmc, emmc, sdio and nandc

Geert Uytterhoeven (18):
      clk: renesas: Remove R-Car Gen2 legacy DT clock support
      clk: renesas: rcar-gen2: Improve arithmetic divisions
      clk: renesas: rcar-gen3: Improve arithmetic divisions
      clk: renesas: rcar-gen3: Avoid double table iteration in SD .set_rate()
      clk: renesas: rcar-gen3: Absorb cpg_sd_clock_calc_div()
      clk: renesas: rcar-gen3: Loop to find best rate in cpg_sd_clock_round_rate()
      clk: renesas: rcar-gen2: Switch Z clock to .determine_rate()
      clk: renesas: rcar-gen3: Switch Z clocks to .determine_rate()
      clk: renesas: rcar-gen3: Switch SD clocks to .determine_rate()
      dt-bindings: power: Add r8a77961 SYSC power domain definitions
      dt-bindings: clock: Add r8a77961 CPG Core Clock Definitions
      dt-bindings: clock: renesas: Remove R-Car Gen2 legacy DT bindings
      dt-bindings: clock: renesas: rcar-usb2-clock-sel: Fix typo in example
      clk: renesas: r8a77965: Remove superfluous semicolon
      Merge tag 'renesas-r8a77961-dt-binding-defs-tag' into clk-renesas-for-v5.5
      dt-bindings: clock: renesas: cpg-mssr: Document r8a77961 support
      clk: renesas: Rename CLK_R8A7796 to CLK_R8A77960
      clk: renesas: r8a7796: Add R8A77961 CPG/MSSR support

Govind Singh (2):
      dt-bindings: clock: qcom: Add QCOM Q6SSTOP clock controller bindings
      clk: qcom: Add Q6SSTOP clock controller for QCS404

Guido Günther (1):
      clk: bd718x7: Add MODULE_ALIAS()

Heiko Stuebner (3):
      clk: rockchip: move px30 critical clocks to correct clock controller
      clk: rockchip: add video-related niu clocks as critical on px30
      clk: rockchip: protect the pclk_usb_grf as critical on px30

Jeffrey Hugo (4):
      clk: qcom: Enumerate clocks and reset needed to boot the 8998 modem
      clk: qcom: smd: Add missing pnoc clock
      clk: qcom: Allow constant ratio freq tables for rcg
      clk: qcom: Add MSM8998 GPU Clock Controller (GPUCC) driver

Jernej Skrabec (3):
      clk: sunxi-ng: h6: Use sigma-delta modulation for audio PLL
      clk: sunxi-ng: h6: Allow GPU to change parent rate
      clk: sunxi-ng: h3: Export MBUS clock

Jerome Brunet (8):
      dt-bindings: clk: axg-audio: add sm1 bindings
      dt-bindings: clock: meson: add sm1 resets to the axg-audio controller
      Merge branch 'v5.5/dt' into v5.5/drivers
      clk: meson: axg-audio: remove useless defines
      clk: meson: axg-audio: fix regmap last register
      clk: meson: axg-audio: prepare sm1 addition
      clk: meson: axg-audio: provide clk top signal name
      clk: meson: axg_audio: add sm1 support

Kishon Vijay Abraham I (1):
      clk: Fix memory leak in clk_unregister()

Laurentiu Palcu (1):
      clk: imx8mq: Add VIDEO2_PLL clock

Leonard Crestez (4):
      clk: imx: pll14xx: Fix quick switch of S/K parameter
      clk: imx8mq: Define gates for pll1/2 fixed dividers
      clk: imx8mm: Define gates for pll1/2 fixed dividers
      clk: imx8mn: Define gates for pll1/2 fixed dividers

Manivannan Sadhasivam (5):
      clk: Zero init clk_init_data in helpers
      clk: Add clk_hw_unregister_composite helper function definition
      dt-bindings: clock: Add devicetree binding for BM1880 SoC
      clk: Add common clock driver for BM1880 SoC
      MAINTAINERS: Add entry for BM1880 SoC clock driver

Marek Szyprowski (1):
      clk: samsung: exynos5420: Add SET_RATE_PARENT flag to clocks on G3D path

Marian Mihailescu (2):
      clk: samsung: exynos5420: Add VPLL rate table
      clk: samsung: exynos5420: Preserve CPU clocks configuration during suspend/resume

Markus Elfring (1):
      clk: renesas: mstp: Delete unnecessary kfree() in cpg_mstp_clocks_init()

Michael Hennerich (1):
      clk: clk-gpio: propagate rate change to parent

Miquel Raynal (4):
      clk: mvebu: armada-37xx-periph: add PCIe gated clock
      clk: mvebu: armada-37xx-periph: change suspend/resume time
      dt-bindings: clk: armada3700: fix typo in SoC name
      dt-bindings: clk: armada3700: document the PCIe clock

Peng Fan (9):
      clk: imx: imx8mn: drop unused pll enum
      clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
      clk: imx: imx8mn: mark sys_pll1/2 as fixed clock
      clk: imx: imx8mq: mark sys1/2_pll as fixed clock
      clk: imx: imx7d: use imx_obtain_fixed_clk_hw to simplify code
      clk: imx: imx6sll: use imx_obtain_fixed_clk_hw to simplify code
      clk: imx: imx6sx: use imx_obtain_fixed_clk_hw to simplify code
      clk: imx: imx6ul: use imx_obtain_fixed_clk_hw to simplify code
      clk: imx: imx8mq: fix sys3_pll_out_sels

Peter Griffin (1):
      clk: hi6220: use CLK_OF_DECLARE_DRIVER

Rasmus Villemoes (1):
      clk: mark clk_disable_unused() as __init

Robert Jarzmik (1):
      clk: pxa: fix one of the pxa RTC clocks

Sowjanya Komatineni (12):
      clk: Add API to get index of the clock parent
      clk: tegra: divider: Save and restore divider rate
      clk: tegra: pllout: Save and restore pllout context
      clk: tegra: pll: Save and restore pll context
      clk: tegra: Support for OSC context save and restore
      clk: tegra: periph: Add restore_context support
      clk: tegra: clk-super: Fix to enable PLLP branches to CPU
      clk: tegra: clk-super: Add restore-context support
      clk: tegra: clk-dfll: Add suspend and resume support
      clk: tegra: Use fence_udelay() during PLLU init
      clk: tegra: Share clk and rst register defines with Tegra clock driver
      clk: tegra: Add suspend and resume support on Tegra210

Stephen Boyd (17):
      Merge tag 'clk-meson-v5.5-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'clk-v5.5-samsung' of https://git.kernel.org/.../snawrocki/clk into clk-samsung
      Merge tag 'clk-renesas-for-v5.5-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'imx-clk-5.5' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'ti-clk-for-5.5-v2' of git://git.kernel.org/.../kristo/linux into clk-ti
      Merge tag 'sunxi-clk-for-5.5-1' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'aspeed-5.5-clk' of git://git.kernel.org/.../joel/aspeed into clk-aspeed
      clk: qcom: rpmh: Reuse sdm845 clks for sm8150
      Merge tag 'tegra-for-5.5-clk-core-v2' of git://git.kernel.org/.../tegra/linux into clk-hw-parent-index
      Merge tag 'tegra-for-5.5-clk-v2' of git://git.kernel.org/.../tegra/linux into clk-tegra
      Merge tag 'v5.5-rockchip-clk-1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      clk: ingenic: Allow drivers to be built with COMPILE_TEST
      Merge branches 'clk-rohm', 'clk-hisilicon', 'clk-marvell', 'clk-unused' and 'clk-devm-ioremap-resource' into clk-next
      Merge branches 'clk-hisi', 'clk-amlogic', 'clk-samsung', 'clk-renesas' and 'clk-imx' into clk-next
      Merge branches 'clk-ti', 'clk-allwinner', 'clk-qcom', 'clk-sa' and 'clk-aspeed' into clk-next
      Merge branches 'clk-gpio-flags', 'clk-tegra', 'clk-rockchip', 'clk-sprd' and 'clk-pxa' into clk-next
      Merge branches 'clk-ingenic', 'clk-init-leak', 'clk-ux500' and 'clk-bitmain' into clk-next

Stephen Kitt (2):
      drivers/clk: convert VL struct to struct_size
      clk/ti/adpll: allocate room for terminating null

Suman Anna (2):
      clk: ti: omap4: Drop idlest polling from IPU & DSP clkctrl clocks
      clk: ti: omap5: Drop idlest polling from IPU & DSP clkctrl clocks

Taniya Das (8):
      clk: qcom: rcg: update the DFS macro for RCG
      clk: qcom: common: Return NULL from clk_hw OF provider
      dt-bindings: clock: Add YAML schemas for the QCOM GCC clock bindings
      dt-bindings: clock: Add sc7180 GCC clock binding
      clk: qcom: Add Global Clock controller (GCC) driver for SC7180
      dt-bindings: clock: Add YAML schemas for the QCOM RPMHCC clock bindings
      dt-bindings: clock: Introduce RPMHCC bindings for SC7180
      clk: qcom: clk-rpmh: Add support for RPMHCC for SC7180

Tero Kristo (14):
      clk: ti: clkctrl: fix setting up clkctrl clocks
      clk: ti: clkctrl: convert to use bit helper macros instead of bitops
      clk: ti: clkctrl: add new exported API for checking standby info
      dt-bindings: clk: add omap5 iva clkctrl definitions
      clk: ti: omap5: add IVA subsystem clkctrl data
      clk: ti: dra7xx: Drop idlest polling from IPU & DSP clkctrl clocks
      clk: ti: am43xx: drop idlest polling from pruss clkctrl clock
      clk: ti: am33xx: drop idlest polling from pruss clkctrl clock
      clk: ti: am33xx: drop idlest polling from gfx clock
      clk: ti: am43xx: drop idlest polling from gfx clock
      clk: ti: divider: cleanup _register_divider and ti_clk_get_div_table
      clk: ti: divider: cleanup ti_clk_parse_divider_data API
      clk: ti: divider: convert to use min,max,mask instead of width
      ARM: dts: omap3: fix DPLL4 M4 divider max value

Thierry Reding (8):
      dt-bindings: clock: tegra: Rename SOR0_LVDS to SOR0_OUT
      Merge branch 'for-5.5/clk-core' into for-5.5/clk
      Merge branch 'for-5.5/dt-bindings' into for-5.5/clk
      clk: tegra: Remove last remains of TEGRA210_CLK_SOR1_SRC
      clk: tegra: Move SOR0 implementation to Tegra124
      clk: tegra: Rename sor0_lvds to sor0_out
      clk: tegra: Reimplement SOR clock on Tegra124
      clk: tegra: Reimplement SOR clocks on Tegra210

Ulf Hansson (1):
      MAINTAINERS: Update section for Ux500 clock drivers

YueHaibing (18):
      clk: imx: clk-pll14xx: Make two variables static
      clk: meson: axg-audio: use devm_platform_ioremap_resource() to simplify code
      clk: ast2600: remove unused variable 'eclk_parent_names'
      clk: bcm2835: use devm_platform_ioremap_resource() to simplify code
      clk: hisilicon: use devm_platform_ioremap_resource() to simplify code
      clk: davinci: use devm_platform_ioremap_resource() to simplify code
      clk: mediatek: mt2712: use devm_platform_ioremap_resource() to simplify code
      clk: mediatek: mt6779: use devm_platform_ioremap_resource() to simplify code
      clk: mediatek: mt8183: use devm_platform_ioremap_resource() to simplify code
      clk: mediatek: mt7622: use devm_platform_ioremap_resource() to simplify code
      clk: mediatek: mt7629: use devm_platform_ioremap_resource() to simplify code
      clk: mediatek: mt6797: use devm_platform_ioremap_resource() to simplify code
      clk: axs10x: use devm_platform_ioremap_resource() to simplify code
      clk: s3c2410: use devm_platform_ioremap_resource() to simplify code
      clk: qcom: remove unneeded semicolon
      clk: tegra: Fix build error without CONFIG_PM_SLEEP
      clk: armada-xp: remove unused code
      clk: tegra: Use match_string() helper to simplify the code

Zhou Yanjie (2):
      dt-bindings: clock: Add X1000 bindings.
      clk: Ingenic: Add CGU driver for X1000.

 .../bindings/clock/amlogic,axg-audio-clkc.txt      |    3 +-
 .../bindings/clock/armada3700-periph-clock.txt     |    5 +-
 .../bindings/clock/bitmain,bm1880-clk.yaml         |   76 +
 .../devicetree/bindings/clock/imx7ulp-clock.txt    |    1 -
 .../devicetree/bindings/clock/ingenic,cgu.txt      |    1 +
 .../devicetree/bindings/clock/qcom,gcc.txt         |   94 -
 .../devicetree/bindings/clock/qcom,gcc.yaml        |  188 ++
 .../devicetree/bindings/clock/qcom,q6sstopcc.yaml  |   43 +
 .../devicetree/bindings/clock/qcom,rpmh-clk.txt    |   27 -
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |   49 +
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   13 +-
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |   60 -
 .../bindings/clock/renesas,rcar-usb2-clock-sel.txt |    2 +-
 MAINTAINERS                                        |    6 +-
 arch/arm/boot/dts/omap36xx-clocks.dtsi             |    4 +
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             |    2 +-
 drivers/clk/Kconfig                                |    7 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/at91/sckc.c                            |    3 +-
 drivers/clk/axs10x/i2s_pll_clock.c                 |    4 +-
 drivers/clk/axs10x/pll_clock.c                     |    7 +-
 drivers/clk/bcm/clk-bcm2835-aux.c                  |    4 +-
 drivers/clk/bcm/clk-bcm2835.c                      |    4 +-
 drivers/clk/clk-aspeed.c                           |   27 +-
 drivers/clk/clk-ast2600.c                          |   49 +-
 drivers/clk/clk-bd718x7.c                          |    1 +
 drivers/clk/clk-bm1880.c                           |  969 ++++++++
 drivers/clk/clk-composite.c                        |   13 +-
 drivers/clk/clk-divider.c                          |    2 +-
 drivers/clk/clk-fixed-rate.c                       |    2 +-
 drivers/clk/clk-gate.c                             |    2 +-
 drivers/clk/clk-gpio.c                             |    2 +-
 drivers/clk/clk-mux.c                              |    2 +-
 drivers/clk/clk.c                                  |   27 +-
 drivers/clk/davinci/pll.c                          |    4 +-
 drivers/clk/davinci/psc.c                          |    4 +-
 drivers/clk/hisilicon/clk-hi3660.c                 |   60 +-
 drivers/clk/hisilicon/clk-hi3670.c                 |  152 +-
 drivers/clk/hisilicon/clk-hi6220.c                 |    3 +-
 drivers/clk/hisilicon/reset.c                      |    4 +-
 drivers/clk/imgtec/clk-boston.c                    |    3 +-
 drivers/clk/imx/clk-imx6sll.c                      |    8 +-
 drivers/clk/imx/clk-imx6sx.c                       |   12 +-
 drivers/clk/imx/clk-imx6ul.c                       |    8 +-
 drivers/clk/imx/clk-imx7d.c                        |    4 +-
 drivers/clk/imx/clk-imx7ulp.c                      |    9 +-
 drivers/clk/imx/clk-imx8mm.c                       |  150 +-
 drivers/clk/imx/clk-imx8mn.c                       |  166 +-
 drivers/clk/imx/clk-imx8mq.c                       |   77 +-
 drivers/clk/imx/clk-pll14xx.c                      |   72 +-
 drivers/clk/imx/clk.h                              |    3 +
 drivers/clk/ingenic/Kconfig                        |   12 +-
 drivers/clk/ingenic/Makefile                       |    1 +
 drivers/clk/ingenic/tcu.c                          |    3 +-
 drivers/clk/ingenic/x1000-cgu.c                    |  274 +++
 drivers/clk/mediatek/clk-mt2712.c                  |    6 +-
 drivers/clk/mediatek/clk-mt6779.c                  |    3 +-
 drivers/clk/mediatek/clk-mt6797.c                  |    3 +-
 drivers/clk/mediatek/clk-mt7622.c                  |    6 +-
 drivers/clk/mediatek/clk-mt7629.c                  |    6 +-
 drivers/clk/mediatek/clk-mt8183.c                  |    6 +-
 drivers/clk/meson/axg-audio.c                      | 2025 ++++++++++------
 drivers/clk/meson/axg-audio.h                      |   21 +-
 drivers/clk/meson/g12a.c                           |   13 +-
 drivers/clk/meson/gxbb.c                           |    1 +
 drivers/clk/mvebu/ap-cpu-clk.c                     |    4 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |    6 +-
 drivers/clk/mvebu/armada-xp.c                      |   26 -
 drivers/clk/mvebu/cp110-system-controller.c        |    4 +-
 drivers/clk/pxa/clk-pxa27x.c                       |    1 +
 drivers/clk/qcom/Kconfig                           |   26 +
 drivers/clk/qcom/Makefile                          |    3 +
 drivers/clk/qcom/clk-rcg.h                         |    2 +-
 drivers/clk/qcom/clk-rcg2.c                        |    6 +-
 drivers/clk/qcom/clk-rpmh.c                        |   53 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |    3 +
 drivers/clk/qcom/common.c                          |    5 +-
 drivers/clk/qcom/gcc-msm8998.c                     |   72 +
 drivers/clk/qcom/gcc-sc7180.c                      | 2450 ++++++++++++++++++++
 drivers/clk/qcom/gcc-sdm845.c                      |   96 +-
 drivers/clk/qcom/gpucc-msm8998.c                   |  338 +++
 drivers/clk/qcom/q6sstop-qcs404.c                  |  223 ++
 drivers/clk/renesas/Kconfig                        |   34 +-
 drivers/clk/renesas/Makefile                       |    5 +-
 drivers/clk/renesas/clk-mstp.c                     |    4 +-
 drivers/clk/renesas/clk-rcar-gen2.c                |  457 ----
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |  327 +++
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   24 +-
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/rcar-gen2-cpg.c                |   25 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |   64 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |   14 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |    1 +
 drivers/clk/rockchip/clk-half-divider.c            |    3 +-
 drivers/clk/rockchip/clk-px30.c                    |   70 +-
 drivers/clk/samsung/clk-exynos5420.c               |   34 +-
 drivers/clk/samsung/clk-s3c2410-dclk.c             |    4 +-
 drivers/clk/samsung/clk.c                          |    3 +-
 drivers/clk/sprd/common.c                          |    6 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |   23 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |    4 -
 drivers/clk/tegra/Makefile                         |    2 +
 drivers/clk/tegra/clk-dfll.c                       |   56 +
 drivers/clk/tegra/clk-dfll.h                       |    2 +
 drivers/clk/tegra/clk-divider.c                    |   11 +
 drivers/clk/tegra/clk-emc.c                        |   12 +-
 drivers/clk/tegra/clk-id.h                         |    4 +-
 drivers/clk/tegra/clk-periph.c                     |   21 +
 drivers/clk/tegra/clk-pll-out.c                    |    9 +
 drivers/clk/tegra/clk-pll.c                        |   86 +-
 drivers/clk/tegra/clk-sdmmc-mux.c                  |   16 +
 drivers/clk/tegra/clk-super.c                      |   41 +
 drivers/clk/tegra/clk-tegra-fixed.c                |   15 +
 drivers/clk/tegra/clk-tegra-periph.c               |    8 -
 drivers/clk/tegra/clk-tegra-super-gen4.c           |    7 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |    1 +
 drivers/clk/tegra/clk-tegra124.c                   |   55 +-
 drivers/clk/tegra/clk-tegra20-emc.c                |  293 +++
 drivers/clk/tegra/clk-tegra20.c                    |   80 +-
 drivers/clk/tegra/clk-tegra210.c                   |  181 +-
 drivers/clk/tegra/clk-tegra30.c                    |   63 +-
 drivers/clk/tegra/clk.c                            |  112 +-
 drivers/clk/tegra/clk.h                            |   70 +
 drivers/clk/ti/adpll.c                             |   11 +-
 drivers/clk/ti/clk-33xx.c                          |    4 +-
 drivers/clk/ti/clk-43xx.c                          |    4 +-
 drivers/clk/ti/clk-44xx.c                          |    4 +-
 drivers/clk/ti/clk-54xx.c                          |   11 +-
 drivers/clk/ti/clk-7xx.c                           |    8 +-
 drivers/clk/ti/clkctrl.c                           |   45 +-
 drivers/clk/ti/clock.h                             |    7 +-
 drivers/clk/ti/divider.c                           |  282 +--
 drivers/clk/uniphier/clk-uniphier-core.c           |    3 +-
 include/dt-bindings/clock/aspeed-clock.h           |    2 +
 include/dt-bindings/clock/ast2600-clock.h          |    4 +
 include/dt-bindings/clock/axg-audio-clkc.h         |   10 +
 include/dt-bindings/clock/bm1880-clock.h           |   82 +
 include/dt-bindings/clock/imx7ulp-clock.h          |    1 +
 include/dt-bindings/clock/imx8mm-clock.h           |   19 +-
 include/dt-bindings/clock/imx8mn-clock.h           |   19 +-
 include/dt-bindings/clock/imx8mq-clock.h           |   24 +-
 include/dt-bindings/clock/omap5.h                  |    4 +
 include/dt-bindings/clock/px30-cru.h               |    2 +
 include/dt-bindings/clock/qcom,gcc-msm8998.h       |    6 +
 include/dt-bindings/clock/qcom,gcc-sc7180.h        |  155 ++
 include/dt-bindings/clock/qcom,q6sstopcc-qcs404.h  |   18 +
 include/dt-bindings/clock/r8a774b1-cpg-mssr.h      |   57 +
 include/dt-bindings/clock/r8a77961-cpg-mssr.h      |   65 +
 include/dt-bindings/clock/sun8i-h3-ccu.h           |    2 +-
 include/dt-bindings/clock/tegra124-car-common.h    |    3 +-
 include/dt-bindings/clock/tegra210-car.h           |    6 +-
 include/dt-bindings/clock/x1000-cgu.h              |   44 +
 include/dt-bindings/power/r8a774b1-sysc.h          |   26 +
 include/dt-bindings/power/r8a77961-sysc.h          |   32 +
 .../reset/amlogic,meson-g12a-audio-reset.h         |   15 +
 include/linux/clk-provider.h                       |    1 +
 include/linux/clk/tegra.h                          |   24 +
 include/linux/clk/ti.h                             |    3 +-
 158 files changed, 8943 insertions(+), 2446 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
 create mode 100644 drivers/clk/clk-bm1880.c
 create mode 100644 drivers/clk/ingenic/x1000-cgu.c
 create mode 100644 drivers/clk/qcom/gcc-sc7180.c
 create mode 100644 drivers/clk/qcom/gpucc-msm8998.c
 create mode 100644 drivers/clk/qcom/q6sstop-qcs404.c
 delete mode 100644 drivers/clk/renesas/clk-rcar-gen2.c
 create mode 100644 drivers/clk/renesas/r8a774b1-cpg-mssr.c
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
 create mode 100644 include/dt-bindings/clock/bm1880-clock.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7180.h
 create mode 100644 include/dt-bindings/clock/qcom,q6sstopcc-qcs404.h
 create mode 100644 include/dt-bindings/clock/r8a774b1-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/r8a77961-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/x1000-cgu.h
 create mode 100644 include/dt-bindings/power/r8a774b1-sysc.h
 create mode 100644 include/dt-bindings/power/r8a77961-sysc.h

-- 
Sent by a computer, using git, on the internet
