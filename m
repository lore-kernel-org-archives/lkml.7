Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76104C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4332077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552501713;
	bh=2UcA8pybyiK/lkT31PO2c2bfpUZOn1giKY7DPHW21Jc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Hu3y1xVtyaCOGoLKMQ+HRL+KO3/vgG5+pPE/07ut3KMCjjaPpgzRwlaSEJOJNqa+2
	 sfUXPlMFITB+07eo9EF45elEE54H4U6QQF6tEVwdomd2DNG9Wug4B47V4Fdr8sxWL1
	 KgLnDp+rm/MNMuiuq54W7cjVremA9PwlN8pOxD8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCMS2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfCMS2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:28:30 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463F02075C;
        Wed, 13 Mar 2019 18:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552501707;
        bh=2UcA8pybyiK/lkT31PO2c2bfpUZOn1giKY7DPHW21Jc=;
        h=From:To:Cc:Subject:Date:From;
        b=fCwOM9txZ6+21gj+p82r72GszDrGKezHsoLPxjySI/d7GJCVt/SdAzFVnwoMANx3Y
         ZeqSw0JvtKZA1tpP+Xlpu6Jkad1ny18gfDe085pHHUxAb3J+xGq/ecHB8rYqC0ALRt
         k30ufkmuSTQrplvlLKK8J+A8GC74T3GrRzCF+umQ=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Wed, 13 Mar 2019 11:28:26 -0700
Message-Id: <20190313182826.71926-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

  Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 010d5166bbe95523e8584f3caca9f1bbeac9ea6e:

  dt-bindings: clock: imx8mq: Fix numbering overlaps and gaps (2019-03-12 13:40:10 -0700)

----------------------------------------------------------------
We have a fairly balanced mix of clk driver updates and clk framework
updates this time around. It's the usual pile of new drivers for new
hardware out there and the normal small fixes and updates, but then we
have some core framework changes too.

In the core framework, we introduce support for a clk_get_optional() API
to get clks that may not always be populated and a way to devm manage clkdev
lookups registered by provider drivers. We also do some refactoring to simplify
the interface between clkdev and the common clk framework so we can reuse the DT
parsing and clk_get() path in provider drivers in the future. This work will
continue in the next few cycles while we convert how providers specify clk
parents.

On the driver side, the biggest part of the dirstat is the Amlogic clk driver
that got support for the G12A SoC. It dominates with almost half the overall
diff, while the second largest part of the diff is in the i.MX clk driver
that gained support for imx8mm SoCs. After that, we have the Actions Semiconductor
and Qualcomm drivers rounding out the big part of the dirstat because they both
got new hardware support for SoCs. The rest is just various updates and non-critical
fixes for existing drivers.

Core:
 - Convert a few clk bindings to JSON schema format
 - Add a {devm_}clk_get_optional() API
 - Add devm_clk_hw_register_clkdev() API to manage clkdev lookups
 - Start rewriting clk parent registration and supporting device links
   by moving around code that supports clk_get() and DT parsing of the
   'clocks' property

New Drivers:
 - Add Qualcomm MSM8998 RPM managed clks
 - IPA clk support on Qualcomm RPMh clk controllers
 - Actions Semi S500 SoC clk support
 - Support for fixed rate clks populated from an MMIO register
 - Add RPC (QSPI/HyperFLASH) clocks on Renesas R-Car V3H
 - Add TMU (timer) clocks on Renesas RZ/G2E
 - Add Amlogic G12A Always-On Clock Controller
 - Add 32k clock generation for Amlogic AXG
 - Add support for the Mali GPU clocks on Amlogic Meson8
 - Add Amlogic G12A EE clock controller driver
 - Add missing CANFD clocks on Renesas RZ/G2M and RZ/G2E
 - Add i.MX8MM SoC clk driver support

Removed Drivers:
 - Remove clps711x driver as the board support is gone

Updates:
 - 3rd ECO fix for Mediatek MT2712 SoCs
 - Updates for Qualcomm MSM8998 GCC clks
 - Random static analysis fixes for clk drivers
 - Support for sleeping gpios in the clk-gpio type
 - Minor fixes for STM32MP1 clk driver (parents, critical flag, etc.)
 - Split LCDC into two clks on the Marvell MMP2 SoC
 - Various DT of_node refcount fixes
 - Get rid of CLK_IS_BASIC from TI code (yay!)
 - TI Autoidle clk support
 - Fix Amlogic Meson8 APB clock ID name
 - Claim input clocks through DT for Amlogic AXG and GXBB
 - Correct the DU (display unit) parent clock on Renesas RZ/G2E
 - Exynos5433 IMEM CMU crypto clk support (SlimSS)
 - Fix for the PLL-MIPI on the Allwinner A23
 - Fix Rockchip rk3328 PLL rate calculation
 - Add SET_RATE_PARENT flag on display clk of Rockhip rk3066
 - i.MX SCU clk driver clk_set_parent() and cpufreq support

----------------------------------------------------------------
Abel Vesa (8):
      clk: imx: Make parent_names const pointer in composite-8m
      clk: imx: Make parents const pointer in mux wrappers
      clk: imx8mq: Make parent names arrays const pointers
      clk: imx: imx8mq: Fix the rate propagation for arm pll
      dt-bindings: imx8mq-clock: Add the missing ARM clock
      clk: imx8mq: Add the missing ARM clock
      clk: imx: Refactor entire sccg pll clk
      dt-bindings: clock: imx8mq: Fix numbering overlaps and gaps

Aisheng Dong (2):
      clk: imx: scu: add fallback compatible string support
      clk: imx: scu: add set parent support

Alexander Shiyan (1):
      clk: clps711x: Remove board support

Andreas Kemnade (3):
      clk: ti: add a usecount for autoidle
      clk: ti: check clock type before doing autoidle ops
      ARM: OMAP2+: hwmod: disable ick autoidling when a hwmod requires that

Andy Shevchenko (1):
      clk: x86: Move clk-lpss.h to platform_data/x86

Anson Huang (2):
      clk: imx: scu: add cpu frequency scaling support
      clk: imx8mq: add GPIO clocks to clock tree

Bai Ping (3):
      clk: imx: Add PLLs driver for imx8mm soc
      dt-bindings: imx: Add clock binding doc for imx8mm
      clk: imx: Add clock driver support for imx8mm

Biju Das (1):
      clk: renesas: r8a774c0: Add TMU clock

Bjorn Andersson (1):
      clk: qcom: gcc-sdm845: Define parent of PCIe PIPE clocks

Carlo Caione (1):
      clk: imx8mq: Add missing M4 clocks

Chen-Yu Tsai (1):
      clk: sunxi-ng: sun8i-a23: Enable PLL-MIPI LDOs when ungating it

Dan Carpenter (1):
      clk: qoriq: Improve an error message

David Dai (1):
      clk: qcom: clk-rpmh: Add IPA clock support

Edgar Bernardi Righi (1):
      dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU

Fabio Estevam (2):
      clk: imx8mq: Fix the CLKO2 source select list
      clk: imx8mq: Add support for the CLKO1 clock

Fabrizio Castro (4):
      clk: renesas: r8a774c0: Add missing CANFD clock
      clk: renesas: r8a774a1: Add missing CANFD clock
      clk: renesas: r8a774c0: Fix LAST_DT_CORE_CLK
      clk: renesas: r8a774a1: Fix LAST_DT_CORE_CLK

Finley Xiao (1):
      clk: rockchip: add CLK_SET_RATE_PARENT for rk3066 lcdc dclks

Gabriel Fernandez (8):
      clk: stm32mp1: parent clocks update
      clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel clocks
      clk: stm32mp1: set ck_csi as critical clock
      clk: stm32mp1: fix mcu divider table
      clk: stm32mp1: fix HSI divider flag
      clk: stm32mp1: remove unnecessary CLK_DIVIDER_ALLOW_ZERO flag
      clk: stm32mp1: fix bit width of hse_rtc divider
      dt-bindings: clock: remove unused definition for stm32mp1

Geert Uytterhoeven (1):
      clk: renesas: r8a774c0: Correct parent clock of DU

Gustavo A. R. Silva (2):
      clk: imx: imx7ulp: use struct_size() in kzalloc()
      clk: samsung: s3c2443: Mark expected switch fall-through

Jan Kotas (2):
      dt-bindings: clk: Add bindings for Fixed MMIO clock
      clk: Add Fixed MMIO clock driver

Jasper Mattsson (3):
      clk: mediatek: Add MUX_FLAGS macro
      clk: mediatek: Add flags to mtk_gate
      clk: mediatek: Mark bus and DRAM related clocks as critical

Jeffrey Hugo (5):
      clk: qcom: Add CLK_SET_RATE_PARENT for 8998 branch clocks
      clk: qcom: Add missing freq for usb30_master_clk on 8998
      clk: qcom: Skip halt checks on gcc_usb3_phy_pipe_clk for 8998
      clk: qcom: smd: Add support for MSM8998 rpm clocks
      clk: qcom: Make common clk_hw registrations

Jerome Brunet (14):
      dt-bindings: clk: meson: add ao slow clock path ids
      clk: meson: clean-up clock registration
      clk: meson: add dual divider clock driver
      clk: meson: gxbb-ao: replace cec-32k with the dual divider
      clk: meson: axg-ao: add 32k generation subtree
      clk: meson: gxbb: claim clock controller input clock from DT
      clk: meson: axg: claim clock controller input clock from DT
      clk: meson: ao-clkc: claim clock controller input clocks from DT
      clk: export some clk_hw function symbols for module drivers
      clk: meson: use CONFIG_ARCH_MESON to enter meson clk directory
      clk: meson: axg-audio does not require syscon
      clk: meson: rework and clean drivers dependencies
      clk: meson: pll: update driver for the g12a
      clk: meson: factorise meson64 peripheral clock controller drivers

Jian Hu (2):
      dt-bindings: clk: meson: add g12a periph clock controller bindings
      clk: meson: g12a: add peripheral clock controller

Kamil Konieczny (5):
      clk: samsung: dt-bindings: Add Exynos5433 IMEM CMU clock IDs
      clk: samsung: exynos5433: Fix definition of CLK_ACLK_IMEM_{200, 266} clocks
      clk: samsung: exynos5433: Fix name typo in sssx
      clk: samsung: dt-bindings: Document Exynos5433 IMEM CMU
      clk: samsung: exynos5433: Add selected IMEM clocks

Katsuhiro Suzuki (2):
      clk: rockchip: fix frac settings of GPLL clock for rk3328
      clk: fractional-divider: check parent rate only if flag is set

Krzysztof Kozlowski (2):
      clk: samsung: exynos5: Fix possible NULL pointer exception on platform_device_alloc() failure
      clk: samsung: exynos5: Fix kfree() of const memory on setting driver_override

Kunihiko Hayashi (1):
      clk: uniphier: Fix update register for CPU-gear

Kuninori Morimoto (1):
      clk: fixup default index for of_clk_get_by_name()

Lubomir Rintel (2):
      dt-bindings: marvell,mmp2: Add clock id for the LCDC clock
      clk: mmp2: separate LCDC peripheral clk form the display clock

Manivannan Sadhasivam (2):
      clk: actions: Add configurable PLL delay
      clk: actions: Add clock driver for S500 SoC

Martin Blumenstingl (4):
      clk: meson: meson8b: use a separate clock table for Meson8
      clk: meson: meson8b: add the GPU clock tree
      dt-bindings: clock: meson8b: add APB clock definition
      clk: meson: meson8b: fix the naming of the APB clocks

Matteo Croce (1):
      clk: samsung: fix typo

Matti Vaittinen (3):
      clkdev: add managed clkdev lookup registration
      clk: clk-max77686: Clean clkdev lookup leak and use devm
      clk: clk-st: avoid clkdev lookup leak at remove

Michael Grzeschik (1):
      clk: imx5: add imx5_SCC2_IPG_GATE

Michał Mirosław (2):
      clk: at91: enable AUDIOPLL as source for PCKx on SAMA5D2
      clk: at91: optimize clk_round_rate() for AUDIO_PLL

Miquel Raynal (1):
      clk: core: clarify the check for runtime PM

Neil Armstrong (2):
      dt-bindings: clk: add G12A AO Clock and Reset Bindings
      clk: meson: Add G12A AO Clock + Reset Controller

Nicolas Ferre (1):
      clk: at91: programmable: remove unneeded register read

Paul Cercueil (3):
      clk: ingenic: jz4740: Fix gating of UDC clock
      clk: ingenic: Fix round_rate misbehaving with non-integer dividers
      clk: ingenic: Fix doc of ingenic_cgu_div_info

Phil Edworthy (2):
      clk: Add comment about __of_clk_get_by_name() error values
      clk: Add (devm_)clk_get_optional() functions

Rob Herring (2):
      dt-bindings: clock: Convert fixed-clock binding to json-schema
      dt-bindings: clock: Convert fixed-factor-clock to json-schema

Seiya Wang (1):
      clk: mediatek: correct cpu clock name for MT8173 SoC

Sergei Shtylyov (4):
      clk: renesas: rcar-gen3: Factor out cpg_reg_modify()
      clk: renesas: rcar-gen3: Add spinlock
      clk: renesas: rcar-gen3: Add RPC clocks
      clk: renesas: r8a77980: Add RPC clocks

Stephen Boyd (23):
      clk: socfpga: Don't have get_parent for single parent ops
      Merge tag 'clk-renesas-for-v5.1-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'v5.1-rockchip-clk1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      Merge tag 'clk-v5.1-samsung' of https://git.kernel.org/.../snawrocki/clk into clk-samsung
      Merge tag 'sunxi-clk-for-5.1' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'tags/meson-clk-5.1' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'meson-clk-5.1-2' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'clk-renesas-for-v5.1-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'ti-clk-for-5.1' of git://git.kernel.org/.../kristo/linux into clk-ti
      clk: imx: imx8mm: Mark init function __init
      clk: Combine __clk_get() and __clk_create_clk()
      clk: Introduce of_clk_get_hw_from_clkspec()
      clk: Inform the core about consumer devices
      clk: Move of_clk_*() APIs into clk.c from clkdev.c
      Merge branches 'clk-of-refcount', 'clk-mmio-fixed-clock', 'clk-remove-clps', 'clk-socfpga-parent' and 'clk-struct-size' into clk-next
      Merge branches 'clk-optional', 'clk-devm-clkdev-register', 'clk-allwinner', 'clk-meson' and 'clk-renesas' into clk-next
      Merge branches 'clk-imx', 'clk-samsung', 'clk-ti', 'clk-uniphier-gear' and 'clk-mmp2-lcdc' into clk-next
      Merge branches 'clk-qcom-rpmh', 'clk-gpio-sleep', 'clk-stm32mp1', 'clk-qcom-qcs404' and 'clk-actions-s500' into clk-next
      Merge branches 'clk-qcom-msm8998', 'clk-fractional-parent', 'clk-x86-mv' and 'clk-SA-fixes' into clk-next
      Merge branches 'clk-ingenic', 'clk-mtk-mux', 'clk-qcom-sdm845-pcie', 'clk-mtk-crit' and 'clk-mtk' into clk-next
      Merge branch 'clk-at91' into clk-next
      Merge branches 'clk-typo', 'clk-json-schema', 'clk-mtk-2712-eco' and 'clk-rockchip' into clk-next
      Merge branch 'clk-parent-rewrite' (early part) into clk-next

Taniya Das (2):
      clk: qcom: clk-rcg2: Introduce a cfg offset for RCGs
      clk: qcom: gcc-qcs404: Add cfg_offset for blsp1_uart3 clock

Tero Kristo (4):
      clk: ti: move clk_hw_omap list handling under generic part of the driver
      clk: ti: add new API for checking if a provided clock is an OMAP clock
      clk: ti: remove usage of CLK_IS_BASIC
      clk: ti: generalize the init sequence of clk_hw_omap clocks

Thomas Petazzoni (1):
      clk: clk-gpio: add support for sleeping GPIOs in gpio-gate-clk

Tony Lindgren (2):
      clk: clk-twl6040: Fix imprecise external abort for pdmclk
      clk: ti: clkctrl: Fix clkdm_name regression for TI_CLK_CLKCTRL_COMPAT

Vinod Koul (1):
      clk: qcom: remove empty lines in clk-rcg.h

Weiyi Lu (2):
      dt-bindings: clock: add clock for MT2712
      clk: mediatek: update clock driver of MT2712

Yangtao Li (14):
      clk: highbank: fix refcount leak in hb_clk_init()
      clk: qoriq: fix refcount leak in clockgen_init()
      clk: ti: fix refcount leak in ti_dt_clocks_register()
      clk: socfpga: fix refcount leak
      clk: samsung: exynos4: fix refcount leak in exynos4_get_xom()
      clk: imx6q: fix refcount leak in imx6q_clocks_init()
      clk: imx6sx: fix refcount leak in imx6sx_clocks_init()
      clk: imx7d: fix refcount leak in imx7d_clocks_init()
      clk: vf610: fix refcount leak in vf610_clocks_init()
      clk: armada-370: fix refcount leak in a370_clk_init()
      clk: kirkwood: fix refcount leak in kirkwood_clk_init()
      clk: armada-xp: fix refcount leak in axp_clk_init()
      clk: mv98dx3236: fix refcount leak in mv98dx3236_clk_init()
      clk: dove: fix refcount leak in dove_clk_init()

YueHaibing (3):
      clk: tegra: dfll: Fix debugfs_simple_attr.cocci warnings
      clk: mediatek: fix platform_no_drv_owner.cocci warnings
      clk: ingenic: Remove set but not used variable 'enable'

chunhui dai (2):
      clk: mediatek: add MUX_GATE_FLAGS_2
      clk: mediatek: using CLK_MUX_ROUND_CLOSEST for the clock of dpi1_sel

 .../devicetree/bindings/clock/actions,owl-cmu.txt  |    7 +-
 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |    1 +
 .../bindings/clock/amlogic,gxbb-clkc.txt           |    1 +
 .../devicetree/bindings/clock/exynos5433-clock.txt |   23 +
 .../devicetree/bindings/clock/fixed-clock.txt      |   23 -
 .../devicetree/bindings/clock/fixed-clock.yaml     |   44 +
 .../bindings/clock/fixed-factor-clock.txt          |   28 -
 .../bindings/clock/fixed-factor-clock.yaml         |   56 +
 .../devicetree/bindings/clock/fixed-mmio-clock.txt |   24 +
 .../devicetree/bindings/clock/imx8mm-clock.txt     |   29 +
 .../devicetree/bindings/clock/qcom,rpmcc.txt       |    1 +
 Documentation/driver-model/devres.txt              |    2 +
 arch/arm/mach-omap2/omap_hwmod.c                   |   16 +-
 drivers/acpi/acpi_lpss.c                           |    2 +-
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    3 +-
 drivers/clk/actions/Kconfig                        |    5 +
 drivers/clk/actions/Makefile                       |    1 +
 drivers/clk/actions/owl-pll.c                      |    2 +-
 drivers/clk/actions/owl-pll.h                      |   30 +-
 drivers/clk/actions/owl-s500.c                     |  525 +++++
 drivers/clk/at91/clk-audio-pll.c                   |    9 +-
 drivers/clk/at91/clk-programmable.c                |    3 -
 drivers/clk/at91/sama5d2.c                         |    3 +-
 drivers/clk/clk-clps711x.c                         |   61 +-
 drivers/clk/clk-devres.c                           |   11 +
 drivers/clk/clk-fixed-mmio.c                       |  101 +
 drivers/clk/clk-fractional-divider.c               |    2 +-
 drivers/clk/clk-gpio.c                             |   39 +-
 drivers/clk/clk-highbank.c                         |    1 +
 drivers/clk/clk-max77686.c                         |   28 +-
 drivers/clk/clk-qoriq.c                            |    5 +-
 drivers/clk/clk-stm32mp1.c                         |   37 +-
 drivers/clk/clk-twl6040.c                          |   53 +-
 drivers/clk/clk.c                                  |  262 ++-
 drivers/clk/clk.h                                  |   23 +-
 drivers/clk/clkdev.c                               |  231 +-
 drivers/clk/imx/Kconfig                            |    6 +
 drivers/clk/imx/Makefile                           |    4 +-
 drivers/clk/imx/clk-composite-8m.c                 |    2 +-
 drivers/clk/imx/clk-imx51-imx53.c                  |    1 +
 drivers/clk/imx/clk-imx6q.c                        |    1 +
 drivers/clk/imx/clk-imx6sx.c                       |    1 +
 drivers/clk/imx/clk-imx7d.c                        |    1 +
 drivers/clk/imx/clk-imx7ulp.c                      |   16 +-
 drivers/clk/imx/clk-imx8mm.c                       |  675 ++++++
 drivers/clk/imx/clk-imx8mq.c                       |  254 +--
 drivers/clk/imx/clk-imx8qxp.c                      |    1 +
 drivers/clk/imx/clk-pll14xx.c                      |  392 ++++
 drivers/clk/imx/clk-sccg-pll.c                     |  514 ++++-
 drivers/clk/imx/clk-scu.c                          |  123 +-
 drivers/clk/imx/clk-scu.h                          |   16 +-
 drivers/clk/imx/clk-vf610.c                        |    1 +
 drivers/clk/imx/clk.h                              |   38 +-
 drivers/clk/ingenic/cgu.c                          |   13 +-
 drivers/clk/ingenic/cgu.h                          |    2 +-
 drivers/clk/ingenic/jz4740-cgu.c                   |    2 +-
 drivers/clk/mediatek/clk-gate.c                    |    4 +-
 drivers/clk/mediatek/clk-gate.h                    |    3 +-
 drivers/clk/mediatek/clk-mt2701.c                  |    4 +-
 drivers/clk/mediatek/clk-mt2712.c                  |    9 +-
 drivers/clk/mediatek/clk-mt6797.c                  |   68 +-
 drivers/clk/mediatek/clk-mt8173.c                  |    4 +-
 drivers/clk/mediatek/clk-mtk.c                     |    4 +-
 drivers/clk/mediatek/clk-mtk.h                     |   29 +-
 drivers/clk/meson/Kconfig                          |  101 +-
 drivers/clk/meson/Makefile                         |   29 +-
 drivers/clk/meson/axg-aoclk.c                      |  193 +-
 drivers/clk/meson/axg-aoclk.h                      |   13 +-
 drivers/clk/meson/axg-audio.c                      |    5 +-
 drivers/clk/meson/axg.c                            |   69 +-
 drivers/clk/meson/clk-dualdiv.c                    |  138 ++
 drivers/clk/meson/clk-dualdiv.h                    |   33 +
 drivers/clk/meson/clk-input.c                      |    7 +-
 drivers/clk/meson/clk-input.h                      |   19 +
 drivers/clk/meson/clk-mpll.c                       |   12 +-
 drivers/clk/meson/clk-mpll.h                       |   30 +
 drivers/clk/meson/clk-phase.c                      |   75 +-
 drivers/clk/meson/clk-phase.h                      |   26 +
 drivers/clk/meson/clk-pll.c                        |  216 +-
 drivers/clk/meson/clk-pll.h                        |   49 +
 drivers/clk/meson/clk-regmap.c                     |    5 +
 drivers/clk/meson/clk-regmap.h                     |   20 +
 drivers/clk/meson/clk-triphase.c                   |   68 -
 drivers/clk/meson/clkc.h                           |  127 --
 drivers/clk/meson/g12a-aoclk.c                     |  454 ++++
 drivers/clk/meson/g12a-aoclk.h                     |   34 +
 drivers/clk/meson/g12a.c                           | 2359 ++++++++++++++++++++
 drivers/clk/meson/g12a.h                           |  175 ++
 drivers/clk/meson/gxbb-aoclk-32k.c                 |  193 --
 drivers/clk/meson/gxbb-aoclk.c                     |  268 ++-
 drivers/clk/meson/gxbb-aoclk.h                     |   20 +-
 drivers/clk/meson/gxbb.c                           |  296 ++-
 drivers/clk/meson/meson-aoclk.c                    |   54 +-
 drivers/clk/meson/meson-aoclk.h                    |   13 +-
 drivers/clk/meson/meson-eeclk.c                    |   63 +
 drivers/clk/meson/meson-eeclk.h                    |   25 +
 drivers/clk/meson/meson8b.c                        |  374 +++-
 drivers/clk/meson/meson8b.h                        |   11 +-
 drivers/clk/meson/parm.h                           |   46 +
 drivers/clk/meson/sclk-div.c                       |   10 +-
 drivers/clk/meson/{clkc-audio.h => sclk-div.h}     |   16 +-
 drivers/clk/meson/vid-pll-div.c                    |   10 +-
 drivers/clk/meson/vid-pll-div.h                    |   20 +
 drivers/clk/mmp/clk-of-mmp2.c                      |    5 +-
 drivers/clk/mvebu/armada-370.c                     |    4 +-
 drivers/clk/mvebu/armada-xp.c                      |    4 +-
 drivers/clk/mvebu/dove.c                           |    8 +-
 drivers/clk/mvebu/kirkwood.c                       |    2 +
 drivers/clk/mvebu/mv98dx3236.c                     |    4 +-
 drivers/clk/qcom/clk-rcg.h                         |    5 +-
 drivers/clk/qcom/clk-rcg2.c                        |   24 +-
 drivers/clk/qcom/clk-rpmh.c                        |  146 ++
 drivers/clk/qcom/clk-smd-rpm.c                     |   63 +
 drivers/clk/qcom/common.c                          |    8 +
 drivers/clk/qcom/common.h                          |    2 +
 drivers/clk/qcom/gcc-ipq8074.c                     |   10 +-
 drivers/clk/qcom/gcc-mdm9615.c                     |   11 +-
 drivers/clk/qcom/gcc-msm8996.c                     |   10 +-
 drivers/clk/qcom/gcc-msm8998.c                     |   61 +-
 drivers/clk/qcom/gcc-qcs404.c                      |   10 +-
 drivers/clk/qcom/gcc-sdm660.c                      |   11 +-
 drivers/clk/qcom/gcc-sdm845.c                      |    5 +
 drivers/clk/qcom/mmcc-msm8996.c                    |   10 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    4 +-
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |   15 +-
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |    8 +
 drivers/clk/renesas/rcar-gen3-cpg.c                |  147 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |    4 +
 drivers/clk/rockchip/clk-rk3188.c                  |    4 +-
 drivers/clk/rockchip/clk-rk3328.c                  |   12 +-
 drivers/clk/samsung/clk-exynos4.c                  |    1 +
 drivers/clk/samsung/clk-exynos5-subcmu.c           |   13 +-
 drivers/clk/samsung/clk-exynos5433.c               |   38 +-
 drivers/clk/samsung/clk-s3c2443.c                  |    2 +-
 drivers/clk/samsung/clk.h                          |    2 +-
 drivers/clk/socfpga/clk-gate.c                     |   22 +-
 drivers/clk/socfpga/clk-pll-a10.c                  |    1 +
 drivers/clk/socfpga/clk-pll.c                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |    2 +-
 drivers/clk/tegra/clk-dfll.c                       |   18 +-
 drivers/clk/ti/adpll.c                             |    2 +-
 drivers/clk/ti/apll.c                              |    4 +-
 drivers/clk/ti/autoidle.c                          |  101 +-
 drivers/clk/ti/clk.c                               |   80 +-
 drivers/clk/ti/clkctrl.c                           |    4 +-
 drivers/clk/ti/clock.h                             |    5 +-
 drivers/clk/ti/clockdomain.c                       |    2 +-
 drivers/clk/ti/divider.c                           |    2 +-
 drivers/clk/ti/dpll.c                              |   11 +-
 drivers/clk/ti/dpll3xxx.c                          |    2 +-
 drivers/clk/ti/gate.c                              |    2 +-
 drivers/clk/ti/interface.c                         |    4 +-
 drivers/clk/ti/mux.c                               |    2 +-
 drivers/clk/uniphier/clk-uniphier-cpugear.c        |    2 +-
 drivers/clk/x86/clk-lpt.c                          |    2 +-
 drivers/clk/x86/clk-st.c                           |    3 +-
 include/dt-bindings/clock/actions,s500-cmu.h       |   78 +
 include/dt-bindings/clock/axg-aoclkc.h             |    7 +-
 include/dt-bindings/clock/exynos5433.h             |    8 +-
 include/dt-bindings/clock/g12a-aoclkc.h            |   34 +
 include/dt-bindings/clock/g12a-clkc.h              |  135 ++
 include/dt-bindings/clock/gxbb-aoclkc.h            |    7 +
 include/dt-bindings/clock/imx5-clock.h             |    3 +-
 include/dt-bindings/clock/imx8mm-clock.h           |  244 ++
 include/dt-bindings/clock/imx8mq-clock.h           |  215 +-
 include/dt-bindings/clock/marvell,mmp2.h           |    1 +
 include/dt-bindings/clock/meson8b-clkc.h           |    1 +
 include/dt-bindings/clock/mt2712-clk.h             |    3 +-
 include/dt-bindings/clock/mt8173-clk.h             |    3 +-
 include/dt-bindings/clock/qcom,rpmcc.h             |   10 +
 include/dt-bindings/clock/qcom,rpmh.h              |    1 +
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h      |    1 +
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h      |    1 +
 include/dt-bindings/clock/stm32mp1-clks.h          |    3 -
 include/dt-bindings/reset/g12a-aoclkc.h            |   18 +
 include/linux/clk-provider.h                       |    3 +
 include/linux/clk.h                                |   36 +
 include/linux/clk/ti.h                             |    1 +
 include/linux/clkdev.h                             |    4 +
 include/linux/platform_data/{ => x86}/clk-lpss.h   |    0
 181 files changed, 9562 insertions(+), 1742 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/fixed-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mm-clock.txt
 create mode 100644 drivers/clk/actions/owl-s500.c
 create mode 100644 drivers/clk/clk-fixed-mmio.c
 create mode 100644 drivers/clk/imx/clk-imx8mm.c
 create mode 100644 drivers/clk/imx/clk-pll14xx.c
 create mode 100644 drivers/clk/meson/clk-dualdiv.c
 create mode 100644 drivers/clk/meson/clk-dualdiv.h
 create mode 100644 drivers/clk/meson/clk-input.h
 create mode 100644 drivers/clk/meson/clk-mpll.h
 create mode 100644 drivers/clk/meson/clk-phase.h
 create mode 100644 drivers/clk/meson/clk-pll.h
 delete mode 100644 drivers/clk/meson/clk-triphase.c
 delete mode 100644 drivers/clk/meson/clkc.h
 create mode 100644 drivers/clk/meson/g12a-aoclk.c
 create mode 100644 drivers/clk/meson/g12a-aoclk.h
 create mode 100644 drivers/clk/meson/g12a.c
 create mode 100644 drivers/clk/meson/g12a.h
 delete mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c
 create mode 100644 drivers/clk/meson/meson-eeclk.c
 create mode 100644 drivers/clk/meson/meson-eeclk.h
 create mode 100644 drivers/clk/meson/parm.h
 rename drivers/clk/meson/{clkc-audio.h => sclk-div.h} (54%)
 create mode 100644 drivers/clk/meson/vid-pll-div.h
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h
 create mode 100644 include/dt-bindings/clock/imx8mm-clock.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
 rename include/linux/platform_data/{ => x86}/clk-lpss.h (100%)

-- 
Sent by a computer through tubes
