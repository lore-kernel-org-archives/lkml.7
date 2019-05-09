Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF62C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D09A217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557436527;
	bh=3DXNG2HeGUYZzttBKNKIMHbL7T0hpVzMTj0sEtNwOZY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nHQIvcKy4Kh3olb8EWmAsJekD0dAAeVwGWbrqXmZup2zUUpGO8eU7uOXcKt8/J6nu
	 UvFFquuSNi1nCj+rd3aA2T0QPdvHN1mz62ym7LwtFAF+4QBpQuFsF0ZXYuUI2UXi0Q
	 pG+vi7xPjG6Mjw/+vW+xMh8yeGLYRq+H40kpWSsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfEIVPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfEIVPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:15:13 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F72D217D7;
        Thu,  9 May 2019 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436511;
        bh=3DXNG2HeGUYZzttBKNKIMHbL7T0hpVzMTj0sEtNwOZY=;
        h=From:To:Cc:Subject:Date:From;
        b=j7HUsvZ5yjgL1CuaDor3p6WgprRgznO5/knMng5RSwzf8666viDD55dDn3pTe5fCQ
         e2F9xO4zoQw6hkDeDi8VSv+5d9NEAL+QxeNbMMt3vV/9tZMUi93ZT2ucJz8ItTF38Y
         KYv1Y6TrapsrYwQzgmSUmE9tevOhgtD0S7t49sFA=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Thu,  9 May 2019 14:15:10 -0700
Message-Id: <20190509211510.36920-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to c1157f60d72e8b20efc670cef28883832f42406c:

  Merge branch 'clk-parent-rewrite-1' into clk-next (2019-05-07 11:46:13 -0700)

----------------------------------------------------------------
We have a couple new features and changes in the core clk framework this time
around because we've finally gotten around to fixing some long standing issues.
There's still work to do though, so this PR is largely laying down the
foundation for all the driver changes to come in the next merge window.

The first problem we're alleviating is how parents of clks are specified. With
the new method, we should see lots of drivers migrate away from the current
design of string comparisons on the entire clk tree to a more direct method
where they can use clk_hw pointers or more localized names specified in DT or
via clkdev. This should reduce our reliance on string comparisons for all the
topology description logic that we've been using for years and hopefully speed
some things up while avoiding problems we have with generating clk names.

Beyond that we also got rid of the CLK_IS_BASIC flag because it wasn't really
helping anyone and we introduced big-endian versions of the basic clk types so
that we can get rid of clk_{readl,writel}(). Both of these are things that
driver developers have tried to use over the years that I typically bat away
during code reviews because they're not useful. It's great to see these two
things go away so maintainers can save time not worrying about these things.

On the driver side we got the usual collection of new SoC support and
non-critical fixes and updates to existing code. The big topics that stand out
are the new driver support for Mediatek MT8183 and MT8516 SoCs, Amlogic Meson8b
and G12a SoCs, and the SiFive FU540 SoC. The other patches in the driver pile
are mostly fixes for things that are being used for the first time or additions
for clks that couldn't be tested before because there wasn't a consumer driver
that exercised them. Details are below and also in the sub-maintainer tags.

Core:
 - Remove clk_readl() and introduce BE versions of basic clk types
 - Rewrite how clk parents can be specified to allow DT/clkdev lookups
 - Removal of the CLK_IS_BASIC clk flag
 - Framework documentation updates and fixes

New Drivers:
 - Support for STM32F769
 - AT91 sam9x60 PMC support
 - SiFive FU540 PRCI and PLL support
 - Qualcomm QCS404 CDSP clk support
 - Qualcomm QCS404 Turing clk support
 - Mediatek MT8183 clock support
 - Mediatek MT8516 clock support
 - Milbeaut M10V clk controller support
 - Support for Cirrus Logic Lochnagar clks

Updates:
 - Rework AT91 sckc DT bindings
 - Fix slow RC oscillator issue on sama5d3
 - Mark UFS clk as critical on Hi-Silicon hi3660 SoCs
 - Various static analysis fixes/finds and const markings
 - Video Engine (ECLK) support on Aspeed SoCs
 - Xilinx ZynqMP Versal platform support
 - Convert Xilinx ZynqMP driver to be struct oriented
 - Fixes for Rockchip rk3328 and rk3288 SoCs
 - Sub-type for Rockchip SoCs where mux and divider aren't a single register
 - Remove SNVS clock from i.MX7UPL clock driver and bindings
 - Improve i.MX5 clock driver for i.MX50 support
 - Addition of ADC clock definition for Exynos 5410 SoC (Odroid XU)
 - Export a new clock for the MBUS controller on the A13
 - Allwinner H6 fixes to support a finer clocking of the video and VPU engines
 - Add g12a support in the Amlogic axg audio clock controller
 - Add missing PCI USB clock on Rensas RZ/N1
 - Add Z2 (Cortex-A53) clocks on Rensas R-Car E3 and RZ/G2E
 - A new helper DIV64_U64_ROUND_CLOSEST() in <linux/math64.h>
 - VPU and Video Decoder clocks on Amlogic Meson8b
 - Finally remove the wrong ABP Meson8b clock id
 - Add Video Decoder, PCIe PLL, and CPU Clocks on Amlogic G12A
 - Re-expose SAR_ADC_SEL and CTS_OSCIN on Amlogic G12A AO clock controller
 - Un-expose some Amlogic AXG-Audio input clocks IDs

----------------------------------------------------------------
Abel Vesa (1):
      clk: imx: Remove unused imx_get_clk_hw_fixed

Alexandre Belloni (10):
      dt-bindings: clock: at91: new sckc bindings
      clk: at91: modernize sckc binding
      clk: at91: sckc: handle different RC startup time
      clk: at91: allow configuring peripheral PCR layout
      clk: at91: allow configuring generated PCR layout
      clk: at91: usb: Add sam9x60 support
      clk: at91: master: Add sam9x60 support
      clk: at91: add sam9x60 PLL driver
      dt-bindings: clk: at91: add bindings for SAM9X60 pmc
      clk: at91: add sam9x60 pmc driver

Anson Huang (5):
      clk: imx7ulp: remove snvs clock
      dt-bindings: clock: imx7ulp: remove SNVS clock
      clk: imx: correct i.MX7D AV PLL num/denom offset
      clk: imx: pllv4: add fractional-N pll support
      clk: imx: correct pfdv2 gate_bit/vld_bit operations

Bjorn Andersson (4):
      clk: qcom: gcc-qcs404: Add CDSP related clocks and resets
      dt-bindings: clock: Introduce Qualcomm Turing Clock controller
      clk: qcom: branch: Add AON clock ops
      clk: qcom: Add QCS404 TuringCC

Charles Keepax (2):
      clk: lochnagar: Add initial binding documentation
      clk: lochnagar: Add support for the Cirrus Logic Lochnagar

Chen-Yu Tsai (1):
      clk: sunxi-ng: a83t: Add pll-video0 as parent of csi-mclk

Colin Ian King (1):
      clk: mvebu: fix spelling mistake "gatable" -> "gateable"

Ding Xiang (1):
      clk: davinci: cfgchip: use PTR_ERR_OR_ZERO in da8xx_cfgchip_register_div4p5

Dmitry Osipenko (8):
      clk: tegra: Don't enable already enabled PLLs
      clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides divider
      clk: tegra124: Remove lock-enable bit from PLLM
      clk: tegra: emc: Don't enable EMC clock manually
      clk: tegra: emc: Support multiple RAM codes
      clk: tegra: emc: Fix EMC max-rate clamping
      clk: tegra: emc: Replace BUG() with WARN_ONCE()
      clk: tegra: divider: Mark Memory Controller clock as read-only

Douglas Anderson (4):
      clk: rockchip: Make rkpwm a critical clock on rk3288
      clk: rockchip: Fix video codec clocks on rk3288
      clk: rockchip: Turn on "aclk_dmac1" for suspend on rk3288
      clk: rockchip: undo several noc and special clocks as critical on rk3288

Eddie James (1):
      clk: Aspeed: Setup video engine clocking

Fabien Parent (4):
      dt-bindings: mediatek: topckgen: add support for MT8516
      dt-bindings: mediatek: infracfg: add support for MT8516
      dt-bindings: mediatek: apmixedsys: add support for MT8516
      clk: mediatek: add clock driver for MT8516

Finley Xiao (1):
      clk: rockchip: add a COMPOSITE_DIV_OFFSET clock-type

Gabriel Fernandez (2):
      clk: stm32: Introduce clocks of STM32F769 board
      clk: stm32mp1: Add ddrperfm clock

Gareth Williams (1):
      clk: renesas: r9a06g032: Add missing PCI USB clock

Geert Uytterhoeven (2):
      clk: renesas: rcar-gen3: Pass name/offset to cpg_sd_clk_register()
      clk: renesas: r7s9210: Always use readl()

Guido Günther (1):
      clk: imx8mq: Add dsi_ipg_div

Gustavo A. R. Silva (1):
      clk: imx: clk-pllv3: mark expected switch fall-throughs

Icenowy Zheng (1):
      clk: sunxi-ng: f1c100s: fix USB PHY gate bit offset

Jacky Bai (1):
      clk: imx: keep uart clock on during system boot

James Liao (1):
      clk: mediatek: Allow changing PLL rate when it is off

Jernej Skrabec (3):
      clk: sunxi-ng: Allow DE clock to set parent rate
      clk: sunxi-ng: h6: Preset hdmi-cec clock parent
      clk: sunxi-ng: h6: Allow video & vpu clocks to change parent rate

Jerome Brunet (4):
      dt-bindings: clock: axg-audio: unexpose controller inputs
      dt-bindings: clk: axg-audio: add g12a support
      clk: meson: axg_audio: replace prefix axg by aud
      clk: meson: axg-audio: don't register inputs in the onecell data

Jonas Gorski (8):
      clk: divider: add explicit big endian support
      clk: fractional-divider: add explicit big endian support
      clk: gate: add explicit big endian support
      clk: multiplier: add explicit big endian support
      clk: mux: add explicit big endian support
      powerpc/512x: mark clocks as big endian
      clk: core: remove powerpc special handling
      clk: core: replace clk_{readl,writel} with {readl,writel}

Jonas Karlman (1):
      clk: rockchip: fix wrong clock definitions for rk3328

Jonathan Neuschäfer (2):
      clk: imx5: Fix i.MX50 mainbus clock registers
      clk: imx5: Fix i.MX50 ESDHC clock registers

Kazuya Mizuguchi (2):
      clk: renesas: rcar-gen3: Correct parent clock of EHCI/OHCI
      clk: renesas: rcar-gen3: Correct parent clock of HS-USB

Krzysztof Kozlowski (3):
      clk: samsung: dt-bindings: Put CLK_UART3 in order
      clk: samsung: dt-bindings: Add ADC clock ID to Exynos5410
      clk: samsung: exynos5410: Add gate clock for ADC

Leo Yan (1):
      clk: hi3660: Mark clk_gate_ufs_subsys as critical

Leonard Crestez (1):
      clk: imx6sll: Fix mispelling uart4_serial as serail

Marc Gonzalez (1):
      clk: qcom: Skip halt checks on gcc_pcie_0_pipe_clk for 8998

Martin Blumenstingl (7):
      dt-bindings: clock: meson8b: drop the "ABP" clock definition
      dt-bindings: clock: meson8b: export the VPU clock
      dt-bindings: clock: meson8b: export the video decoder clocks
      clk: meson: meson8b: use a separate clock table for Meson8m2
      clk: meson: meson8b: add support for the GP_PLL clock on Meson8m2
      clk: meson: meson8b: add the VPU clock trees
      clk: meson: meson8b: add the video decoder clock trees

Matthias Kaehlcke (1):
      clk: rockchip: Limit use of USB PHY clock to USB on rk3288

Maxime Jourdan (3):
      dt-bindings: clk: g12a-clkc: add VDEC clock IDs
      clk: meson-g12a: add video decoder clocks
      clk: meson: axg-audio: add g12a support

Maxime Ripard (2):
      clk: sunxi: Add Kconfig options
      clk: sunxi-ng: sun5i: Export the MBUS clock

Michael Tretter (4):
      clk: zynqmp: fix kerneldoc of __zynqmp_clock_get_parents
      clk: zynqmp: do not export zynqmp_clk_register_* functions
      clk: zynqmp: fix check for fractional clock
      clk: zynqmp: use structs for clk query responses

Neil Armstrong (8):
      clk: meson-g12a: add cpu clock bindings
      clk: g12a-aoclk: re-export CLKID_AO_SAR_ADC_SEL clock id
      dt-bindings: clk: g12a-clkc: add PCIE PLL clock ID
      clk: meson: g12a: add cpu clocks
      clk: meson-pll: add reduced specific clk_ops for G12A PCIe PLL
      dt-bindings: clock: g12a-aoclk: expose CLKID_AO_CTS_OSCIN
      clk: meson-g12a: add PCIE PLL clocks
      Merge branch 'next/headers' into next/drivers

Nicholas Mc Guire (1):
      clk: ux500: add range to usleep_range

Nishad Kamdar (6):
      clk: actions: Use the correct style for SPDX License Identifier
      clk: davinci: Use the correct style for SPDX License Identifier
      clk: qcom: Use the correct style for SPDX License Identifier
      clk: renesas: Use the correct style for SPDX License Identifier
      clk: sprd: Use the correct style for SPDX License Identifier
      clk: sunxi-ng: Use the correct style for SPDX License Identifier

Owen Chen (3):
      clk: mediatek: Disable tuner_en before change PLL rate
      clk: mediatek: Add new clkmux register API
      clk: mediatek: Add configurable pcwibits and fmin to mtk_pll_data

Paul Cercueil (2):
      dt-bindings: clock: jz4725b-cgu: Add UDC PHY clock
      clk: ingenic: jz4725b: Add UDC PHY clock

Paul Walmsley (3):
      dt-bindings: clk: add documentation for the SiFive PRCI driver
      clk: analogbits: add Wide-Range PLL library
      clk: sifive: add a driver for the SiFive FU540 PRCI IP block

Peng Fan (1):
      clk: imx: pll14xx: drop unused variable

Rajan Vaja (2):
      drivers: clk: zynqmp: Allow zero divisor value
      drivers: clk: Update clock driver to handle clock attribute

Sergei Shtylyov (1):
      clk: renesas: r8a77980: Fix RPC-IF module clock's parent

Shawn Guo (1):
      clk: imx: rename clk-imx51-imx53.c to clk-imx5.c

Simon Horman (5):
      clk: renesas: rcar-gen3: Parameterise Z and Z2 clock offset
      clk: renesas: rcar-gen3: Remove CLK_TYPE_GEN3_Z2
      math64: New DIV64_U64_ROUND_CLOSEST helper
      clk: renesas: rcar-gen3: Support Z and Z2 clocks with high frequency parents
      clk: renesas: r8a774c0: Add Z2 clock

Stephen Boyd (38):
      clk: Collapse gpio clk kerneldoc
      clk: Document deprecated things
      clk: Document CLK_MUX_READ_ONLY mux flag
      clk: Document __clk_mux_determine_rate()
      clk: nxp: Drop 'flags' on fixed_rate clk macro
      clk: Remove 'flags' member of struct clk_fixed_rate
      clk: Document and simplify clk_core_get_rate_nolock()
      clk: highbank: Convert to CLK_IS_CRITICAL
      clk: Drop duplicate clk_register() documentation
      Merge tag 'meson-clk-5.2' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'clk-renesas-for-v5.2-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      clk: renesas: rcar-gen3: Remove unused variable
      Merge tag 'meson-clk-5.2-2' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'sunxi-clk-for-5.2' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'clk-v5.2-samsung' of https://git.kernel.org/.../snawrocki/clk into clk-samsung
      clkdev: Move clk creation outside of 'clocks_mutex'
      clk: Prepare for clk registration API that uses DT nodes
      driver core: Let dev_of_node() accept a NULL dev
      clk: Add of_clk_hw_register() API for early clk drivers
      clk: Allow parents to be specified without string names
      clk: Look for parents with clkdev based clk_lookups
      clk: Allow parents to be specified via clkspec index
      clk: fixed-factor: Let clk framework find parent
      clk: fixed-factor: Initialize clk_init_data on stack
      Merge tag 'clk-imx-5.2' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'clk-imx5-5.2' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'clk-imx7ulp-5.2' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'v5.2-rockchip-clk-1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      clk: at91: Mark struct clk_range as const
      clk: Remove CLK_IS_BASIC clk flag
      clk: Cache core in clk_fetch_parent_index() without names
      Merge branches 'clk-renesas', 'clk-qcom', 'clk-mtk', 'clk-milbeaut' and 'clk-imx' into clk-next
      Merge branches 'clk-doc', 'clk-more-critical', 'clk-meson' and 'clk-basic-be' into clk-next
      Merge branches 'clk-sa', 'clk-aspeed', 'clk-samsung', 'clk-ingenic' and 'clk-zynq' into clk-next
      Merge branches 'clk-hisi', 'clk-lochnagar', 'clk-allwinner', 'clk-rockchip' and 'clk-qoriq' into clk-next
      Merge branches 'clk-stm32f4', 'clk-tegra', 'clk-at91', 'clk-sifive-fu540' and 'clk-spdx' into clk-next
      Merge branch 'clk-ti' into clk-next
      Merge branch 'clk-parent-rewrite-1' into clk-next

Sugaya Taichi (2):
      dt-bindings: clock: milbeaut: add Milbeaut clock description
      clock: milbeaut: Add Milbeaut M10V clock controller

Takeshi Kihara (6):
      clk: renesas: rcar-gen3: Parameterise Z and Z2 clock fixed divisor
      clk: renesas: r8a77990: Add Z2 clock
      clk: renesas: rcar-gen3: Correct parent clock of SYS-DMAC
      clk: renesas: rcar-gen3: Correct parent clock of Audio-DMAC
      clk: renesas: rcar-gen3: Rename DRIF clocks
      clk: renesas: rcar-gen3: Fix cpg_sd_clock_round_rate() return value

Tero Kristo (4):
      clk: ti: export the omap2_clk_is_hw_omap call
      ARM: omap2+: hwmod: drop CLK_IS_BASIC flag usage
      clk: ti: dra7x: prevent non-existing clkctrl clocks from registering
      clk: ti: dra7: disable the RNG and TIMER12 clkctrl clocks on HS devices

Weiyi Lu (4):
      dt-bindings: ARM: Mediatek: Document bindings for MT8183
      clk: mediatek: Add dt-bindings for MT8183 clocks
      clk: mediatek: Add configurable pcw_chg_reg to mtk_pll_data
      clk: mediatek: Add MT8183 clock support

Yogesh Gaur (1):
      clk: qoriq: increase array size of cmux_to_group

Yuantian Tang (4):
      dt-bindings: qoriq-clock: add more PLL divider clocks support
      clk: qoriq: add more PLL divider clocks support
      clk: qoriq: Add ls1028a clock configuration
      dt-bindings: qoriq-clock: Add ls1028a chip compatible string

YueHaibing (1):
      clk: tegra: Make tegra_clk_super_mux_ops static

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    2 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt      |   22 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    2 +
 .../bindings/arm/mediatek/mediatek,ipu.txt         |   43 +
 .../bindings/arm/mediatek/mediatek,mcucfg.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    2 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |    1 +
 .../bindings/clock/amlogic,axg-audio-clkc.txt      |    3 +-
 .../devicetree/bindings/clock/at91-clock.txt       |   33 +-
 .../devicetree/bindings/clock/cirrus,lochnagar.txt |   93 ++
 .../devicetree/bindings/clock/milbeaut-clock.yaml  |   73 ++
 .../devicetree/bindings/clock/qcom,turingcc.txt    |   19 +
 .../devicetree/bindings/clock/qoriq-clock.txt      |    5 +-
 .../bindings/clock/sifive/fu540-prci.txt           |   46 +
 .../devicetree/bindings/clock/st,stm32-rcc.txt     |    6 +
 MAINTAINERS                                        |    6 +
 arch/arm/mach-omap2/clock.c                        |    3 +
 arch/arm/mach-omap2/omap_hwmod.c                   |    4 +-
 arch/mips/alchemy/common/clock.c                   |    2 +-
 arch/powerpc/platforms/512x/clock-commonclk.c      |    9 +-
 drivers/clk/Kconfig                                |   11 +
 drivers/clk/Makefile                               |    4 +
 drivers/clk/actions/owl-common.h                   |    2 +-
 drivers/clk/actions/owl-composite.h                |    2 +-
 drivers/clk/actions/owl-divider.h                  |    2 +-
 drivers/clk/actions/owl-factor.h                   |    2 +-
 drivers/clk/actions/owl-fixed-factor.h             |    2 +-
 drivers/clk/actions/owl-gate.h                     |    2 +-
 drivers/clk/actions/owl-mux.h                      |    2 +-
 drivers/clk/actions/owl-pll.h                      |    2 +-
 drivers/clk/actions/owl-reset.h                    |    2 +-
 drivers/clk/analogbits/Kconfig                     |    2 +
 drivers/clk/analogbits/Makefile                    |    3 +
 drivers/clk/analogbits/wrpll-cln28hpc.c            |  364 ++++++
 drivers/clk/at91/Makefile                          |    2 +
 drivers/clk/at91/at91sam9260.c                     |   14 +-
 drivers/clk/at91/at91sam9rl.c                      |    2 +-
 drivers/clk/at91/at91sam9x5.c                      |   11 +-
 drivers/clk/at91/clk-generated.c                   |   48 +-
 drivers/clk/at91/clk-master.c                      |    8 +-
 drivers/clk/at91/clk-peripheral.c                  |   46 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |  330 +++++
 drivers/clk/at91/clk-usb.c                         |   33 +-
 drivers/clk/at91/dt-compat.c                       |   12 +-
 drivers/clk/at91/pmc.h                             |   25 +-
 drivers/clk/at91/sam9x60.c                         |  307 +++++
 drivers/clk/at91/sama5d2.c                         |   12 +-
 drivers/clk/at91/sama5d4.c                         |   10 +-
 drivers/clk/at91/sckc.c                            |  134 +-
 drivers/clk/clk-aspeed.c                           |   42 +-
 drivers/clk/clk-composite.c                        |    2 +-
 drivers/clk/clk-divider.c                          |   26 +-
 drivers/clk/clk-fixed-factor.c                     |   57 +-
 drivers/clk/clk-fixed-rate.c                       |    2 +-
 drivers/clk/clk-fractional-divider.c               |   24 +-
 drivers/clk/clk-gate.c                             |   24 +-
 drivers/clk/clk-gpio.c                             |    2 +-
 drivers/clk/clk-highbank.c                         |   23 +-
 drivers/clk/clk-lochnagar.c                        |  336 +++++
 drivers/clk/clk-milbeaut.c                         |  663 ++++++++++
 drivers/clk/clk-multiplier.c                       |   22 +-
 drivers/clk/clk-mux.c                              |   24 +-
 drivers/clk/clk-pwm.c                              |    2 +-
 drivers/clk/clk-qoriq.c                            |   77 +-
 drivers/clk/clk-stm32f4.c                          |  307 ++++-
 drivers/clk/clk-stm32mp1.c                         |    3 +
 drivers/clk/clk-xgene.c                            |    6 +-
 drivers/clk/clk.c                                  |  392 ++++--
 drivers/clk/clk.h                                  |    2 +
 drivers/clk/clkdev.c                               |   25 +-
 drivers/clk/davinci/da8xx-cfgchip.c                |    4 +-
 drivers/clk/davinci/pll.h                          |    2 +-
 drivers/clk/davinci/psc.h                          |    2 +-
 drivers/clk/hisilicon/clk-hi3660.c                 |    6 +-
 drivers/clk/hisilicon/clk-hisi-phase.c             |    4 +-
 drivers/clk/imx/Makefile                           |    2 +-
 drivers/clk/imx/clk-divider-gate.c                 |   20 +-
 drivers/clk/imx/{clk-imx51-imx53.c => clk-imx5.c}  |   59 +-
 drivers/clk/imx/clk-imx6sll.c                      |   18 +-
 drivers/clk/imx/clk-imx7d.c                        |    4 +-
 drivers/clk/imx/clk-imx7ulp.c                      |    1 -
 drivers/clk/imx/clk-imx8mq.c                       |    1 +
 drivers/clk/imx/clk-pfdv2.c                        |   10 +-
 drivers/clk/imx/clk-pll14xx.c                      |    6 +-
 drivers/clk/imx/clk-pllv3.c                        |   31 +-
 drivers/clk/imx/clk-pllv4.c                        |   72 +-
 drivers/clk/imx/clk-sccg-pll.c                     |   12 +-
 drivers/clk/imx/clk.h                              |    6 +-
 drivers/clk/ingenic/jz4725b-cgu.c                  |    6 +
 drivers/clk/mediatek/Kconfig                       |   83 ++
 drivers/clk/mediatek/Makefile                      |   16 +-
 drivers/clk/mediatek/clk-gate.h                    |   14 +
 drivers/clk/mediatek/clk-mt8183-audio.c            |  105 ++
 drivers/clk/mediatek/clk-mt8183-cam.c              |   63 +
 drivers/clk/mediatek/clk-mt8183-img.c              |   63 +
 drivers/clk/mediatek/clk-mt8183-ipu0.c             |   56 +
 drivers/clk/mediatek/clk-mt8183-ipu1.c             |   56 +
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c          |   54 +
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c         |  123 ++
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |   54 +
 drivers/clk/mediatek/clk-mt8183-mm.c               |  111 ++
 drivers/clk/mediatek/clk-mt8183-vdec.c             |   67 +
 drivers/clk/mediatek/clk-mt8183-venc.c             |   59 +
 drivers/clk/mediatek/clk-mt8183.c                  | 1284 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8516.c                  |  815 +++++++++++++
 drivers/clk/mediatek/clk-mtk.h                     |    3 +
 drivers/clk/mediatek/clk-mux.c                     |  223 ++++
 drivers/clk/mediatek/clk-mux.h                     |   89 ++
 drivers/clk/mediatek/clk-pll.c                     |   87 +-
 drivers/clk/meson/axg-audio.c                      | 1219 +++++++++++--------
 drivers/clk/meson/axg-audio.h                      |   16 +-
 drivers/clk/meson/clk-pll.c                        |   26 +
 drivers/clk/meson/clk-pll.h                        |    1 +
 drivers/clk/meson/g12a-aoclk.h                     |    2 -
 drivers/clk/meson/g12a.c                           |  631 ++++++++++
 drivers/clk/meson/g12a.h                           |   31 +-
 drivers/clk/meson/meson8b.c                        |  734 ++++++++++-
 drivers/clk/meson/meson8b.h                        |   27 +-
 drivers/clk/mmp/clk-gate.c                         |    2 +-
 drivers/clk/mvebu/common.c                         |    2 +-
 drivers/clk/mvebu/cp110-system-controller.c        |    4 +-
 drivers/clk/nxp/clk-lpc18xx-ccu.c                  |    6 +-
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  |   24 +-
 drivers/clk/nxp/clk-lpc32xx.c                      |    7 +-
 drivers/clk/qcom/Kconfig                           |    6 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-branch.c                      |    6 +
 drivers/clk/qcom/clk-branch.h                      |    1 +
 drivers/clk/qcom/clk-regmap-mux-div.h              |    2 +-
 drivers/clk/qcom/gcc-msm8998.c                     |    2 +-
 drivers/clk/qcom/gcc-qcs404.c                      |   90 ++
 drivers/clk/qcom/turingcc-qcs404.c                 |  170 +++
 drivers/clk/renesas/r7s9210-cpg-mssr.c             |    3 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |   18 +-
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |    7 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |   41 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   35 +-
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |   33 +-
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |   25 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |    1 +
 drivers/clk/renesas/rcar-gen2-cpg.h                |    4 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |   71 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |    9 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |    4 +-
 drivers/clk/rockchip/clk-ddr.c                     |    2 +-
 drivers/clk/rockchip/clk-half-divider.c            |    6 +-
 drivers/clk/rockchip/clk-rk3288.c                  |   36 +-
 drivers/clk/rockchip/clk-rk3328.c                  |   18 +-
 drivers/clk/rockchip/clk.c                         |    9 +-
 drivers/clk/rockchip/clk.h                         |   23 +
 drivers/clk/samsung/clk-exynos5410.c               |    1 +
 drivers/clk/sifive/Kconfig                         |   18 +
 drivers/clk/sifive/Makefile                        |    1 +
 drivers/clk/sifive/fu540-prci.c                    |  626 ++++++++++
 drivers/clk/sprd/common.h                          |    2 +-
 drivers/clk/sprd/composite.h                       |    2 +-
 drivers/clk/sprd/div.h                             |    2 +-
 drivers/clk/sprd/gate.h                            |    2 +-
 drivers/clk/sprd/mux.h                             |    2 +-
 drivers/clk/sprd/pll.h                             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |    3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |   19 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.h               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun5i.h                   |    4 -
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |    5 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |    3 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |    2 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |    4 +-
 drivers/clk/sunxi/Kconfig                          |   43 +
 drivers/clk/sunxi/Makefile                         |   49 +-
 drivers/clk/tegra/clk-divider.c                    |    3 +-
 drivers/clk/tegra/clk-emc.c                        |   57 +-
 drivers/clk/tegra/clk-pll.c                        |   54 +-
 drivers/clk/tegra/clk-super.c                      |    2 +-
 drivers/clk/tegra/clk-tegra124.c                   |    7 +-
 drivers/clk/tegra/clk-tegra210.c                   |    6 +-
 drivers/clk/ti/clk-7xx-compat.c                    |    6 +-
 drivers/clk/ti/clk-7xx.c                           |    6 +-
 drivers/clk/ti/clkctrl.c                           |   17 +
 drivers/clk/ti/clock.h                             |    8 +-
 drivers/clk/ux500/clk-sysctrl.c                    |    3 +-
 drivers/clk/zynq/clkc.c                            |    6 +-
 drivers/clk/zynq/pll.c                             |   18 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |    1 -
 drivers/clk/zynqmp/clk-zynqmp.h                    |    6 -
 drivers/clk/zynqmp/clkc.c                          |  180 +--
 drivers/clk/zynqmp/divider.c                       |   17 +-
 drivers/pwm/pwm-meson.c                            |    2 +-
 include/dt-bindings/clock/axg-audio-clkc.h         |   30 +-
 include/dt-bindings/clock/exynos5410.h             |    3 +-
 include/dt-bindings/clock/g12a-aoclkc.h            |    2 +
 include/dt-bindings/clock/g12a-clkc.h              |    5 +
 include/dt-bindings/clock/imx7ulp-clock.h          |    1 -
 include/dt-bindings/clock/jz4725b-cgu.h            |    1 +
 include/dt-bindings/clock/meson8b-clkc.h           |    6 +-
 include/dt-bindings/clock/mt8183-clk.h             |  422 +++++++
 include/dt-bindings/clock/mt8516-clk.h             |  211 ++++
 include/dt-bindings/clock/qcom,gcc-qcs404.h        |    5 +
 include/dt-bindings/clock/qcom,turingcc-qcs404.h   |   15 +
 include/dt-bindings/clock/stm32fx-clock.h          |    7 +-
 include/dt-bindings/clock/sun5i-ccu.h              |    2 +-
 include/linux/clk-provider.h                       |  112 +-
 include/linux/clk/analogbits-wrpll-cln28hpc.h      |   79 ++
 include/linux/clk/at91_pmc.h                       |   12 +-
 include/linux/clk/ti.h                             |    2 +
 include/linux/device.h                             |    2 +-
 include/linux/math64.h                             |   13 +
 214 files changed, 11543 insertions(+), 1465 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,turingcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
 create mode 100644 drivers/clk/analogbits/Kconfig
 create mode 100644 drivers/clk/analogbits/Makefile
 create mode 100644 drivers/clk/analogbits/wrpll-cln28hpc.c
 create mode 100644 drivers/clk/at91/clk-sam9x60-pll.c
 create mode 100644 drivers/clk/at91/sam9x60.c
 create mode 100644 drivers/clk/clk-lochnagar.c
 create mode 100644 drivers/clk/clk-milbeaut.c
 rename drivers/clk/imx/{clk-imx51-imx53.c => clk-imx5.c} (94%)
 create mode 100644 drivers/clk/mediatek/clk-mt8183-audio.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu_adl.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu_conn.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183.c
 create mode 100644 drivers/clk/mediatek/clk-mt8516.c
 create mode 100644 drivers/clk/mediatek/clk-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mux.h
 create mode 100644 drivers/clk/qcom/turingcc-qcs404.c
 create mode 100644 drivers/clk/sifive/Kconfig
 create mode 100644 drivers/clk/sifive/Makefile
 create mode 100644 drivers/clk/sifive/fu540-prci.c
 create mode 100644 drivers/clk/sunxi/Kconfig
 create mode 100644 include/dt-bindings/clock/mt8183-clk.h
 create mode 100644 include/dt-bindings/clock/mt8516-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,turingcc-qcs404.h
 create mode 100644 include/linux/clk/analogbits-wrpll-cln28hpc.h

-- 
Sent by a computer through tubes
