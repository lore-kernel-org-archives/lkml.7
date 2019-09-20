Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A1C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A572086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569015646;
	bh=gt7NyV2+qmPTPyby8Ulc88XHhs7NX82dWHp04aptmrM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZPY9LOq72GcfUjubi/K+0Q3Tc/Fa0qplRrcPqJ4hfJA0/1R079Hp+CcP7+nG33ftV
	 O45rTdE3wdGU8TnimgWhDmewfeyojEn6XoISZ+sMqJH40cPj+E5NMVsbLCNSMs+MGg
	 J9ymQi1wycfK0qPHVTyOWm3g8EGOMJyLeVxkGry0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392500AbfITVkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392025AbfITVkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:40:45 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D752086A;
        Fri, 20 Sep 2019 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569015643;
        bh=gt7NyV2+qmPTPyby8Ulc88XHhs7NX82dWHp04aptmrM=;
        h=From:To:Cc:Subject:Date:From;
        b=g43hoH5axeyX/lStT/DSrdMYqWmG54c1HYb2I8DDLoxmaNUNVrhookcnabKEa9Pm5
         fOCnf068D2JceSNrniNZbW+N0pTUO4jKMSE08rU7FodSq63inuA6DZhfnQVwQRbt41
         yh+LwZOh2QbQ4hYbmslSjwAyqiYDfkigIcE+1fEc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Fri, 20 Sep 2019 14:40:42 -0700
Message-Id: <20190920214042.261378-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cda4569137b90f200bee4922d894ca49d4188681:

  dt-bindings: clk: meson: add sm1 periph clock controller bindings (2019-08-26 11:00:15 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to ebd47c8434064687ab6641e837144e0a3ea3872d:

  Merge branches 'clk-bulk-fix', 'clk-at91' and 'clk-sprd' into clk-next (2019-09-19 15:31:59 -0700)

----------------------------------------------------------------
We have a small collection of core framework updates this time, mostly around
clk registration by clk providers and debugfs "nice to haves" for rate
constraints. I'll highlight that we're now setting the clk_init_data pointer
inside struct clk_hw to NULL during clk_register(), which may break some
drivers that thought they could use that pointer during normal operations. That
change has been sitting in next for a while now but maybe something is still
broken. We'l see. Other than that the core framework changes aren't invasive
and they're fixing bugs, simplifying, and making things better.

On the clk driver side we got the usual addition of new SoC support, new
features for existing drivers, and bug fixes scattered throughout. The biggest
diffstat is the Amlogic driver that gained CPU clk support in addition to
migrating to the new way of specifying clk parents. After that the Qualcomm,
i.MX, Mediatek, and Rockchip clk drivers got support for various new SoCs and
clock controllers from those vendors.

Core:
 - Drop NULL checks in clk debugfs
 - Add min/max rates to clk debugfs
 - Set clk_init_data pointer inside clk_hw to NULL after registration
 - Make clk_bulk_get_all() return an 'id' corresponding to clock-names
 - Evict parents from parent cache when they're unregistered

New Drivers:
 - Add clock driver for i.MX8MN SoCs
 - Support aspeed AST2600 SoCs
 - Support for Mediatek MT6779 SoCs
 - Support qcom SM8150 GCC and RPMh clks
 - Support qcom QCS404 WCSS clks
 - Add CPU clock support for Armada 7K/8K (specifically AP806 and AP807)
 - Addition of clock driver for Rockchip rk3308 SoCs

Updates:
 - Add regulator support to the cdce925 clk driver
 - Add support for Raspberry Pi 4 bcm2711 SoCs
 - Add SDIO gate support to aspeed driver
 - Add missing of_node_put() calls in various clk drivers
 - Migrate Amlogic driver to new clock parent description method
 - Add DVFS support to Amlogic Meson g12
 - Add Amlogic Meson g12a reset support to the axg audio clock controller
 - Add sm1 support to the Amlogic Meson g12a clock controller
 - Switch i.MX8MM clock driver to platform driver
 - Add Hifi4 DSP related clocks for i.MX8QXP SoC
 - Fix Audio PLL setting and parent clock for USB
 - Misc i.MX8 clock driver improvements and corrections
 - Set floor ops for Qualcomm SD clks so that rounding works
 - Fix "always-on" Clock Domains on Renesas R-Car M1A, RZ/A1, RZ/A2, and RZ/N1
 - Enable the Allwinner V3 SoC and fix the i2s clock for H6

----------------------------------------------------------------
Abel Vesa (3):
      clk: imx: Remove unused clk based API
      clk: imx8mm: Switch to platform driver
      clk: imx8mq: Mark AHB clock as critical

Andrey Smirnov (1):
      clk: Constify struct clk_bulk_data * where possible

Anson Huang (10):
      clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
      clk: imx8mm: Fix typo of pwm3 clock's mux option #4
      clk: imx8mm: GPT1 clock mux option #5 should be sys_pll1_80m
      clk: imx7ulp: Make sure earlycon's clock is enabled
      clk: imx: Remove unused function statement
      clk: imx8mn: Keep uart clocks on for early console
      clk: imx8mm: Unregister clks when of_clk_add_provider failed
      clk: imx8mq: Unregister clks when of_clk_add_provider failed
      clk: imx8mn: Add missing rate_count assignment for each PLL structure
      clk: imx8mn: Add necessary frequency support for ARM PLL table

Ben Peled (3):
      clk: mvebu: ap80x-cpu: add AP807 CPU clock support
      clk: mvebu: ap806: Prepare the introduction of AP807 clock support
      clk: mvebu: ap80x: add AP807 clock support

Bjorn Andersson (1):
      clk: Make clk_bulk_get_all() return a valid "id"

Christine Gharzuzi (1):
      clk: mvebu: ap806-cpu: prepare mapping of AP807 CPU clock

Chunfeng Yun (2):
      dt-bindings: clock: mediatek: add pericfg for MT8183
      clk: mediatek: add pericfg clocks for MT8183

Chunyan Zhang (1):
      clk: sprd: add missing kfree

Colin Ian King (1):
      clk: Si5341/Si5340: remove redundant assignment to n_den

Deepak Katragadda (3):
      clk: qcom: clk-alpha-pll: Add support for Trion PLLs
      dt-bindings: clock: Document gcc bindings for SM8150
      clk: qcom: gcc: Add global clock controller driver for SM8150

Eugen Hristev (3):
      clk: at91: fix update bit maps on CFG_MOR write
      clk: at91: select parent if main oscillator or bypass is enabled
      clk: at91: allow 24 Mhz clock as input for PLL

Fancy Fang (1):
      clk: imx8mm: rename 'share_count_dcss' to 'share_count_disp'

Finley Xiao (3):
      dt-bindings: Add bindings for rk3308 clock controller
      clk: rockchip: Add dt-binding header for rk3308
      clk: rockchip: Add clock controller for the rk3308

Fuqian Huang (1):
      clk/ti: Use kmemdup rather than duplicating its implementation

Geert Uytterhoeven (4):
      clk: renesas: rcar-usb2-clock-sel: Use devm_platform_ioremap_resource() helper
      clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for clock domain
      clk: renesas: r9a06g032: Set GENPD_FLAG_ALWAYS_ON for clock domain
      clk: renesas: cpg-mssr: Set GENPD_FLAG_ALWAYS_ON for clock domain

Govind Singh (2):
      clk: qcom: Add WCSS gcc clock control for QCS404
      clk: qcom: define probe by index API as common API

Gregory CLEMENT (4):
      dt-bindings: ap806: add the cluster clock node in the syscon file
      clk: mvebu: add helper file for Armada AP and CP clocks
      clk: mvebu: add CPU clock driver for Armada 7K/8K
      clk: mvebu: ap806: Fix clock name for the cluster

Icenowy Zheng (4):
      clk: sunxi-ng: v3s: add the missing PLL_DDR1
      dt-bindings: clk: sunxi-ccu: add compatible string for V3 CCU
      clk: sunxi-ng: v3s: add missing clock slices for MMC2 module clocks
      clk: sunxi-ng: v3s: add Allwinner V3 support

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Allow I2S to change parent rate

Jerome Brunet (3):
      Merge branch 'v5.4/dt' into v5.4/drivers
      clk: meson: axg-audio: add g12a reset support
      Merge branch 'v5.4/dt' into v5.4/drivers

Joel Stanley (3):
      clk: aspeed: Add SDIO gate
      clk: aspeed: Move structures to header
      clk: Add support for AST2600 SoC

Jorge Ramirez-Ortiz (1):
      clk: qcom: fix QCS404 TuringCC regmap

Leonard Crestez (6):
      clk: Add clk_min/max_rate entries in debugfs
      clk: Assert prepare_lock in clk_core_get_boundaries
      clk: imx8mq: Fix sys3 pll references
      clk: imx8mm: Fix incorrect parents
      clk: imx8mn: Fix incorrect parents
      clk: imx8mn: Add GIC clock

Li Jun (2):
      clk: imx8mm: correct the usb1_ctrl parent to be usb_bus
      clk: imx8mq: set correct parent for usb ctrl clocks

Lubomir Rintel (1):
      clk: remove extra ---help--- tags in Kconfig

Manivannan Sadhasivam (1):
      clk: actions: Fix factor clk struct member access

Marc Gonzalez (1):
      clk: qcom: msm8916: Don't build by default

Markus Elfring (1):
      clk: Use seq_puts() in possible_parent_show()

Masahiro Yamada (1):
      clk: add include guard to clk-conf.h

Miquel Raynal (3):
      dt-bindings: ap80x: Document AP807 CPU clock compatible
      dt-bindings: ap806: Document AP807 clock compatible
      clk: mvebu: ap806: be more explicit on what SaR is

Nathan Huckleberry (2):
      clk: rockchip: Fix -Wunused-const-variable in rv1108 clk driver
      clk: qoriq: Fix -Wunused-const-variable

Neil Armstrong (3):
      clk: meson: g12a: add support for SM1 GP1 PLL
      clk: meson: g12a: add support for SM1 DynamIQ Shared Unit clock
      clk: meson: g12a: add support for SM1 CPU 1, 2 & 3 clocks

Nishka Dasgupta (5):
      clk: versatile: Add of_node_put() in cm_osc_setup()
      clk: davinci: pll: Add of_node_put() in of_davinci_pll_init()
      clk: st: clk-flexgen: Add of_node_put() in st_of_flexgen_setup()
      clk: ti: dm814x: Add of_node_put() to prevent memory leak
      clk: spear: Make structure i2s_sclk_masks constant

Omri Itach (1):
      clk: mvebu: ap806: add AP-DCLK (hclk) to system controller driver

Paul Cercueil (2):
      clk: ingenic/jz4740: Fix "pll half" divider not read/written properly
      clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro

Peng Fan (7):
      clk: imx: imx8mm: fix audio pll setting
      clk: imx8mn: fix int pll clk gate
      clk: imx: imx8mn: fix audio pll setting
      clk: imx: pll14xx: avoid glitch when set rate
      clk: imx: clk-pll14xx: unbypass PLL by default
      clk: imx: imx8mm: fix pll mux bit
      clk: imx: imx8mn: fix pll mux bit

Phil Reid (2):
      dt-bindings: clock: cdce925: Add regulator documentation
      clk: clk-cdce925: Add regulator support

Rishi Gupta (1):
      clk: Remove extraneous 'for' word in comments

Simon Horman (1):
      dt-bindings: clk: emev2: Rename bindings documentation file

Stefan Wahren (4):
      dt-bindings: bcm2835-cprman: Add bcm2711 support
      clk: bcm2835: Introduce SoC specific clock registration
      clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support
      clk: bcm2835: Mark PLLD_PER as CRITICAL

Stephen Boyd (33):
      Merge tag 'clk-meson-v5.4-1' of https://github.com/BayLibre/clk-meson into clk-meson
      clk: actions: Don't reference clk_init_data after registration
      clk: lochnagar: Don't reference clk_init_data after registration
      clk: meson: axg-audio: Don't reference clk_init_data after registration
      clk: qcom: Don't reference clk_init_data after registration
      clk: sirf: Don't reference clk_init_data after registration
      clk: socfpga: Don't reference clk_init_data after registration
      clk: sprd: Don't reference clk_init_data after registration
      phy: ti: am654-serdes: Don't reference clk_init_data after registration
      clk: socfpga: deindent code to proper indentation
      clk: milbeaut: Don't reference clk_init_data after registration
      clk: zx296718: Don't reference clk_init_data after registration
      rtc: sun6i: Don't reference clk_init_data after registration
      clk: qcom: Remove error prints from DFS registration
      clk: ti: Don't reference clk_init_data after registration
      clk: sunxi: Don't call clk_hw_get_name() on a hw that isn't registered
      clk: Overwrite clk_hw::init with NULL during clk_register()
      clk: composite: Drop unused clk.h include
      Merge tag 'clk-meson-v5.4-2' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'clk-imx-5.4' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'sunxi-clk-for-5.4-1' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'clk-renesas-for-v5.4-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'v5.4-rockchip-clk1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      clk: Document of_parse_clkspec() some more
      clk: qcom: gcc-sdm845: Use floor ops for sdcc clks
      clk: Evict unregistered clks from parent caches
      clk: Drop !clk checks in debugfs dumping
      Merge branches 'clk-aspeed', 'clk-unused', 'clk-of-node-put', 'clk-const-bulk-data' and 'clk-debugfs' into clk-next
      Merge branches 'clk-qcom', 'clk-mtk', 'clk-armada', 'clk-ingenic' and 'clk-meson' into clk-next
      Merge branches 'clk-init-destroy', 'clk-doc', 'clk-imx' and 'clk-allwinner' into clk-next
      Merge branches 'clk-renesas', 'clk-rockchip', 'clk-const' and 'clk-simplify' into clk-next
      Merge branches 'clk-cdce-regulator', 'clk-bcm', 'clk-evict-parent-cache' and 'clk-actions' into clk-next
      Merge branches 'clk-bulk-fix', 'clk-at91' and 'clk-sprd' into clk-next

Taniya Das (2):
      clk: qcom: gcc: Use floor ops for SDCC clocks
      clk: qcom: rcg: Return failure for RCG update

Vinod Koul (7):
      clk: qcom: clk-alpha-pll: Remove unnecessary cast
      clk: qcom: clk-alpha-pll: Remove post_div_table checks
      clk: qcom: gcc-qcs404: Use floor ops for sdcc clks
      dt-bindings: clock: Document the parent clocks
      clk: qcom: clk-rpmh: Convert to parent data scheme
      dt-bindings: clock: Document SM8150 rpmh-clock compatible
      clk: qcom: clk-rpmh: Add support for SM8150

Weiyi Lu (2):
      clk: mediatek: Register clock gate with device
      clk: mediatek: Runtime PM support for MT8183 mcucfg clock provider

YueHaibing (2):
      clk: st: clkgen-fsyn: remove unused variable 'st_quadfs_fs660c32_ops'
      clk: st: clkgen-pll: remove unused variable 'st_pll3200c32_407_a0'

kbuild test robot (1):
      clk: fix devm_platform_ioremap_resource.cocci warnings

mtk01761 (3):
      dt-bindings: mediatek: bindings for MT6779 clk
      clk: mediatek: Add dt-bindings for MT6779 clocks
      clk: mediatek: Add MT6779 clock support

yong.liang (1):
      clk: reset: Modify reset-controller driver

 .../arm/marvell/ap806-system-controller.txt        |   42 +-
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,ipesys.txt      |   22 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |    1 +
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |    1 +
 .../bindings/clock/brcm,bcm2835-cprman.txt         |    4 +-
 .../devicetree/bindings/clock/imx8mn-clock.yaml    |  112 +
 .../devicetree/bindings/clock/qcom,gcc.txt         |   21 +
 .../devicetree/bindings/clock/qcom,rpmh-clk.txt    |    7 +-
 .../{emev2-clock.txt => renesas,emev2-smu.txt}     |    0
 .../bindings/clock/rockchip,rk3308-cru.txt         |   60 +
 .../devicetree/bindings/clock/ti,cdce925.txt       |    4 +
 drivers/clk/Kconfig                                |    9 -
 drivers/clk/Makefile                               |    1 +
 drivers/clk/actions/owl-common.c                   |    5 +-
 drivers/clk/actions/owl-factor.c                   |    7 +-
 drivers/clk/at91/clk-main.c                        |   12 +-
 drivers/clk/at91/sama5d2.c                         |    2 +-
 drivers/clk/bcm/clk-bcm2835.c                      |  138 +-
 drivers/clk/bcm/clk-bcm63xx-gate.c                 |    4 +-
 drivers/clk/clk-aspeed.c                           |   78 +-
 drivers/clk/clk-aspeed.h                           |   82 +
 drivers/clk/clk-ast2600.c                          |  704 ++++
 drivers/clk/clk-bulk.c                             |    5 +-
 drivers/clk/clk-cdce925.c                          |   34 +
 drivers/clk/clk-composite.c                        |    1 -
 drivers/clk/clk-lochnagar.c                        |    2 +-
 drivers/clk/clk-milbeaut.c                         |    2 +-
 drivers/clk/clk-qoriq.c                            |    2 +-
 drivers/clk/clk-si5341.c                           |    1 -
 drivers/clk/clk.c                                  |  175 +-
 drivers/clk/davinci/pll.c                          |    5 +-
 drivers/clk/imx/Kconfig                            |    6 +
 drivers/clk/imx/Makefile                           |    1 +
 drivers/clk/imx/clk-imx7ulp.c                      |   31 +
 drivers/clk/imx/clk-imx8mm.c                       |  141 +-
 drivers/clk/imx/clk-imx8mn.c                       |  648 ++++
 drivers/clk/imx/clk-imx8mq.c                       |  131 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |    5 +
 drivers/clk/imx/clk-pll14xx.c                      |   27 +-
 drivers/clk/imx/clk.c                              |    8 +
 drivers/clk/imx/clk.h                              |   43 +-
 drivers/clk/ingenic/jz4725b-cgu.c                  |    2 +-
 drivers/clk/ingenic/jz4740-cgu.c                   |   11 +-
 drivers/clk/ingenic/jz4770-cgu.c                   |    2 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |    2 +-
 drivers/clk/mediatek/Kconfig                       |   56 +
 drivers/clk/mediatek/Makefile                      |    9 +
 drivers/clk/mediatek/clk-gate.c                    |    5 +-
 drivers/clk/mediatek/clk-gate.h                    |    3 +-
 drivers/clk/mediatek/clk-mt6779-aud.c              |  117 +
 drivers/clk/mediatek/clk-mt6779-cam.c              |   66 +
 drivers/clk/mediatek/clk-mt6779-img.c              |   58 +
 drivers/clk/mediatek/clk-mt6779-ipe.c              |   60 +
 drivers/clk/mediatek/clk-mt6779-mfg.c              |   55 +
 drivers/clk/mediatek/clk-mt6779-mm.c               |  113 +
 drivers/clk/mediatek/clk-mt6779-vdec.c             |   67 +
 drivers/clk/mediatek/clk-mt6779-venc.c             |   58 +
 drivers/clk/mediatek/clk-mt6779.c                  | 1315 +++++++
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |    7 +-
 drivers/clk/mediatek/clk-mt8183.c                  |   44 +
 drivers/clk/mediatek/clk-mtk.c                     |   16 +-
 drivers/clk/mediatek/clk-mtk.h                     |    8 +
 drivers/clk/mediatek/reset.c                       |   56 +-
 drivers/clk/meson/Kconfig                          |   11 +-
 drivers/clk/meson/Makefile                         |    2 +-
 drivers/clk/meson/axg-aoclk.c                      |   63 +-
 drivers/clk/meson/axg-audio.c                      |  351 +-
 drivers/clk/meson/axg-audio.h                      |    1 +
 drivers/clk/meson/axg.c                            |  207 +-
 drivers/clk/meson/clk-cpu-dyndiv.c                 |   73 +
 drivers/clk/meson/clk-cpu-dyndiv.h                 |   20 +
 drivers/clk/meson/clk-input.c                      |   49 -
 drivers/clk/meson/clk-input.h                      |   19 -
 drivers/clk/meson/clk-regmap.h                     |   12 +-
 drivers/clk/meson/g12a-aoclk.c                     |   81 +-
 drivers/clk/meson/g12a.c                           | 2232 +++++++++---
 drivers/clk/meson/g12a.h                           |   24 +-
 drivers/clk/meson/gxbb-aoclk.c                     |   55 +-
 drivers/clk/meson/gxbb.c                           |  657 ++--
 drivers/clk/meson/meson-aoclk.c                    |   37 -
 drivers/clk/meson/meson-aoclk.h                    |    8 -
 drivers/clk/meson/meson-eeclk.c                    |   10 -
 drivers/clk/meson/meson-eeclk.h                    |    2 -
 drivers/clk/meson/meson8b.c                        |  710 ++--
 drivers/clk/mvebu/Kconfig                          |    8 +
 drivers/clk/mvebu/Makefile                         |    2 +
 drivers/clk/mvebu/ap-cpu-clk.c                     |  356 ++
 drivers/clk/mvebu/ap806-system-controller.c        |  178 +-
 drivers/clk/mvebu/armada_ap_cp_helper.c            |   30 +
 drivers/clk/mvebu/armada_ap_cp_helper.h            |   11 +
 drivers/clk/mvebu/cp110-system-controller.c        |   32 +-
 drivers/clk/qcom/Kconfig                           |    9 +-
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  236 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    7 +
 drivers/clk/qcom/clk-rcg2.c                        |   10 +-
 drivers/clk/qcom/clk-rpmh.c                        |   42 +-
 drivers/clk/qcom/common.c                          |   20 +
 drivers/clk/qcom/common.h                          |    2 +
 drivers/clk/qcom/gcc-ipq8074.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8998.c                     |    4 +-
 drivers/clk/qcom/gcc-qcs404.c                      |   34 +-
 drivers/clk/qcom/gcc-sdm660.c                      |    2 +-
 drivers/clk/qcom/gcc-sdm845.c                      |    4 +-
 drivers/clk/qcom/gcc-sm8150.c                      | 3588 ++++++++++++++++++++
 drivers/clk/qcom/lpasscc-sdm845.c                  |   23 +-
 drivers/clk/qcom/turingcc-qcs404.c                 |    2 +-
 drivers/clk/renesas/clk-mstp.c                     |    3 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |    3 +-
 drivers/clk/renesas/rcar-usb2-clock-sel.c          |    4 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |    3 +-
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-rk3308.c                  |  955 ++++++
 drivers/clk/rockchip/clk-rv1108.c                  |    1 -
 drivers/clk/rockchip/clk.h                         |   13 +
 drivers/clk/sirf/clk-common.c                      |   12 +-
 drivers/clk/socfpga/clk-gate.c                     |   24 +-
 drivers/clk/socfpga/clk-periph-a10.c               |    7 +-
 drivers/clk/spear/spear1340_clock.c                |    2 +-
 drivers/clk/sprd/common.c                          |    5 +-
 drivers/clk/sprd/pll.c                             |    2 +
 drivers/clk/st/clk-flexgen.c                       |    1 +
 drivers/clk/st/clkgen-fsyn.c                       |    1 -
 drivers/clk/st/clkgen-pll.c                        |   13 -
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |    8 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |  250 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h               |    6 +-
 drivers/clk/sunxi-ng/ccu_common.c                  |    5 +-
 drivers/clk/ti/apll.c                              |    9 +-
 drivers/clk/ti/clk-814x.c                          |    1 +
 drivers/clk/ti/dpll.c                              |   13 +-
 drivers/clk/versatile/clk-versatile.c              |    1 +
 drivers/clk/zte/clk-zx296718.c                     |  109 +-
 drivers/phy/ti/phy-am654-serdes.c                  |    4 +-
 drivers/rtc/rtc-sun6i.c                            |    2 +-
 include/dt-bindings/clock/ast2600-clock.h          |  113 +
 include/dt-bindings/clock/bcm2835.h                |    2 +
 include/dt-bindings/clock/imx8-clock.h             |    6 +-
 include/dt-bindings/clock/imx8mn-clock.h           |  216 ++
 include/dt-bindings/clock/mt6779-clk.h             |  436 +++
 include/dt-bindings/clock/mt8183-clk.h             |    4 +
 include/dt-bindings/clock/qcom,gcc-qcs404.h        |    3 +
 include/dt-bindings/clock/qcom,gcc-sm8150.h        |  243 ++
 include/dt-bindings/clock/rk3308-cru.h             |  387 +++
 include/dt-bindings/clock/sun8i-v3s-ccu.h          |    4 +
 .../dt-bindings/reset-controller/mt8183-resets.h   |   81 +
 include/dt-bindings/reset/sun8i-v3s-ccu.h          |    3 +
 include/linux/clk-provider.h                       |    4 +-
 include/linux/clk.h                                |   17 +-
 include/linux/clk/clk-conf.h                       |    5 +
 160 files changed, 15011 insertions(+), 1922 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
 rename Documentation/devicetree/bindings/clock/{emev2-clock.txt => renesas,emev2-smu.txt} (100%)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.txt
 create mode 100644 drivers/clk/clk-aspeed.h
 create mode 100644 drivers/clk/clk-ast2600.c
 create mode 100644 drivers/clk/imx/clk-imx8mn.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779.c
 create mode 100644 drivers/clk/meson/clk-cpu-dyndiv.c
 create mode 100644 drivers/clk/meson/clk-cpu-dyndiv.h
 delete mode 100644 drivers/clk/meson/clk-input.c
 delete mode 100644 drivers/clk/meson/clk-input.h
 create mode 100644 drivers/clk/mvebu/ap-cpu-clk.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.h
 create mode 100644 drivers/clk/qcom/gcc-sm8150.c
 create mode 100644 drivers/clk/rockchip/clk-rk3308.c
 create mode 100644 include/dt-bindings/clock/ast2600-clock.h
 create mode 100644 include/dt-bindings/clock/imx8mn-clock.h
 create mode 100644 include/dt-bindings/clock/mt6779-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8150.h
 create mode 100644 include/dt-bindings/clock/rk3308-cru.h
 create mode 100644 include/dt-bindings/reset-controller/mt8183-resets.h

-- 
Sent by a computer through tubes
