Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A6C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91E52464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="v2Xuc5g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfLESFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:05:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45558 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLESFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:05:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id w7so1547678plz.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXoQB2qmHbi/jNzmTpC9y+iAJSs/SvRJ/73njKDgaBw=;
        b=v2Xuc5g/Wj9YBq+gPSvGha+JBcKICvVzFZDu9IgTYiX0PUgtsJwc/C8UsYvH41FtUc
         nxUfmN9BZgl6j8ZvPqxkoPnhrhV9w2FaM4T52pxPytH+aMA1c+omzvi6urK9wKxeQkNV
         emLKQyAa7IpYWcjnck9NduHL43TbMKh1E5r6nnUdp8lk9c85eQ3pg0IIcCmyULBKyXKx
         pTOoHWtfTNKTZ06Z7sSVxhBr7u5w2ldToP6VahSiq/Q2ckuSj+kMu+F76wzhCrHz/sxx
         iLWSr/XjZGIj0kDUWtkcAhzppxs14w/NudU3hymUNQAaillXyirazX9YdgktHMEZKj79
         b5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXoQB2qmHbi/jNzmTpC9y+iAJSs/SvRJ/73njKDgaBw=;
        b=auqhB6mAgFwGmB4XDLV6+kgBR7G9WnrxwRpY5xLdN/s/fJnpUaANkqn6rTqhJaBQvm
         Gr3gdVqW5p35tndlJ4WQg53eRez5rZY/71Uxk+txAsmfdn92oVxcyvmBEwhI//dE03ZS
         t/DviMkvBnWE/z/7RNfYduUYUL2XNe5tHtc7KXDCBFL9WSLjBM7llC6+sdRhJOYL5eQX
         svx3d3cKCV7g6SQM6UzIesgNdNFKST2naD+SWpzawXDTxZHCM27cBNT1d4UsEMRwitZ7
         vfnOALx5lh2h7SHQdoiKdaya/tlKWCPy40EwOm1g2kVjU3bQ4/ohPqn8pc0GtqsjvHsT
         dALA==
X-Gm-Message-State: APjAAAU/KyLbu9sP/JTj2vPpAm+OjFWz0VVtcG5eqWarbf9Ro7o2hR1Y
        569zNgT++0hihfy5Ogg5V5kD6Xty7blDSw==
X-Google-Smtp-Source: APXvYqy+WBhlfls6LG7hRHbNcS6TD1sqXPYMjThj1+57IQwzV4YfaOhWnuDaZsLvFNk6EWuu3N7jCw==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr10439832pln.125.1575569114472;
        Thu, 05 Dec 2019 10:05:14 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id s22sm386918pjr.5.2019.12.05.10.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:05:12 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/4] ARM: Device-tree updates
Date:   Thu,  5 Dec 2019 10:04:52 -0800
Message-Id: <20191205180453.14056-3-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20191205180453.14056-1-olof@lixom.net>
References: <20191205180453.14056-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As always, the bulk of updates. Some of the news this cycle:

New SoC descriptions:
- Broadcom BCM2711
- Amlogic Meson A1 and G12
- Freescale S32V234
- Marvell Armada AP807/AP807-quad and CP115
- Realtek RTD1293 and RTD1296
- Rockchip RK3308

New boards and platforms:
- Allwinner: NanoPi Duo2
- Amlogic: Ugoos am6
- Atmel at91: Overkiz Kizbox2/4
- Broadcom: RPi4, Luxul XWC-2000
- Marvell: New Espressobin flavor
- NXP: i.MX8MN LPDDR4 EVK, i.MX8QXP Colibri, S32V234 EVB, Netronix
  E60K02 and Kobo Clara HD, Kontron N6311 and N6411, OPOS6UL and
  OPOS6ULDev
- Renesas: Salvator-XS
- Rockchip: Beelink A1 (rk3308), rk3308 eval boards, rk3399-roc-pc


Conflicts:
Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml: move/move.
Delete both comment lines with arm,mali-t62{4,8}

arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi: add/add. Keep new
contents from both sides.

arch/arm64/boot/dts/amlogic/meson-sm1.dtsi: add/add. Keep new contents
from both sides.

----------------------------------------------------------------

The following changes since commit e1dfbb4a8470456359ee68c3db0b490fa0d1b076:

  Merge branch 'arm/drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

for you to fetch changes up to 5f1f15283419ded3e16617ac0b79abc6f2b73bba:

  Merge tag 'omap-for-v5.5/dt-late-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/dt

----------------------------------------------------------------

Adam Ford (5):
      ARM: dts: logicpd-torpedo-baseboard: Reduce video regulator chatter
      ARM: dts: logicpd-torpedo-37xx-devkit-28: Reference new DRM panel
      ARM: dts: logicpd-torpedo: Disable Bluetooth Serial DMA
      ARM: dts: logicpd-torpedo-37xx-devkit: Increase camera pixel clock
      ARM: dts: logicpd-torpedo: Disable USB Host

Alexander Filippov (1):
      ARM: dts: vesnin: Add power_green led

Alexandre Torgue (4):
      ARM: dts: stm32: fix memory nodes to match with DT validation tool
      ARM: dts: stm32: fix joystick node on stm32f746 and stm32mp157c eval boards
      ARM: dts: stm32: remove usb phy-names entries on stm32mp157c-ev1
      ARM: dts: stm32: fix regulator-sd_switch node on stm32mp157c-ed1 board

Alistair Francis (1):
      arm64: dts: sun50i: sopine-baseboard: Expose serial1, serial2 and serial3

Amit Kucheria (7):
      arm64: dts: qcs404: thermal: Add interrupt support
      arm64: dts: msm8998: thermal: Add interrupt support
      arm64: dts: msm8996: thermal: Add interrupt support
      arm64: dts: sdm845: thermal: Add interrupt support
      arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
      ARM: dts: msm8974: thermal: Add interrupt support
      ARM: dts: msm8974: thermal: Add thermal zones for each sensor

Anand Moon (6):
      arm64: dts: meson: odroid-c2: p5v0 is the main 5V power input
      arm64: dts: meson: odroid-c2: Add missing linking regulator to usb bus
      arm64: dts: meson: odroid-c2: Disable usb_otg bus to avoid power failed warning
      arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0 regulator
      arm64: dts: meson: odroid-c2: Add missing regulator linked to VDDIO_AO3V3 regulator
      arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI supply

Anatolij Gustschin (1):
      ARM: dts: imx6qdl-wandboard: add ethernet PHY description

Andre Przywara (1):
      arm64: dts: allwinner: a64: Re-add PMU node

Andreas Färber (11):
      dt-bindings: arm: realtek: Tidy up conversion to json-schema
      dt-bindings: arm: realtek: Document RTD1293 and Synology DS418j
      arm64: dts: realtek: Change dual-license from MIT to BSD
      arm64: dts: realtek: Add RTD1293 and Synology DS418j
      dt-bindings: arm: realtek: Document RTD1296 and Synology DS418
      arm64: dts: realtek: Add RTD1296 and Synology DS418
      arm64: dts: realtek: Add oscillator for RTD129x
      arm64: dts: realtek: Add watchdog node for RTD129x
      dt-bindings: reset: Add Realtek RTD1295
      arm64: dts: realtek: Add RTD129x reset controller nodes
      arm64: dts: realtek: Add RTD129x UART resets

Andreas Kemnade (3):
      dt-bindings: arm: fsl: add compatible string for Kobo Clara HD
      ARM: dts: add Netronix E60K02 board common file
      ARM: dts: imx: add devicetree for Kobo Clara HD

Andrew Jeffery (7):
      ARM: dts: ast2600-evb: eMMC configuration
      ARM: dts: aspeed-g6: Fix EMMC function in pinctrl dtsi
      ARM: dts: aspeed-g6: Add pinctrl properties to MDIO nodes
      ARM: dts: ast2600-evb: Add pinmux properties for enabled MACs
      ARM: dts: aspeed: Migrate away from aspeed, g[45].* compatibles
      ARM: dts: aspeed: Add RCLK to MAC clocks for RMII interfaces
      ARM: dts: tacoma: Hog LPC pinmux

Andrey Smirnov (7):
      ARM: dts: vf610-zii-scu4-aib: Drop "rs485-rts-delay" property
      ARM: dts: imx6qdl-zii-rdu2: Fix accelerometer interrupt-names
      ARM: dts: imx6qdl-zii-rdu2: Specify supplies for accelerometer
      arm64: dts: zii-ultra: Fix regulator-vsd-3v3's vin-supply
      arm64: dts: zii-ultra: Fix regulator-3p3-main's name
      arm64: dts: zii-ultra: Add node for accelerometer
      arm64: dts: zii-ultra: Add node for switch watchdog

Andy Yan (6):
      dt-bindings: Add doc about rk3308 General Register Files
      arm64: dts: rockchip: Add core dts for RK3308 SOC
      dt-bindings: Add doc for rk3308-evb
      arm64: dts: rockchip: Add basic dts for RK3308 EVB
      dt-bindings: Add doc for Firefly ROC-RK3308-CC board
      arm64: dts: rockchip: Add devicetree for board roc-rk3308-cc

Anson Huang (35):
      ARM: dts: imx7ulp: Add wdog1 node
      arm64: dts: imx8mn-ddr4-evk: Enable GPIO LED
      arm64: dts: imx8mn: Add "fsl,imx8mq-src" as src's fallback compatible
      arm64: dts: imx8mn: Add system counter node
      arm64: dts: imx8mn: Enable cpu-idle driver
      arm64: dts: imx8mm: Remove incorrect fallback compatible for ocotp
      arm64: dts: imx8mn: Use "fsl,imx8mm-ocotp" as ocotp's fallback compatible
      ARM: dts: imx7d: Correct speed grading fuse settings
      ARM: dts: imx7d: Add opp-suspend property
      arm64: dts: imx8mm-evk: Adjust i2c nodes following alphabetical sort
      arm64: dts: imx8mm-evk: Add i2c3 support
      arm64: dts: imx8mm-evk: Enable pca6416 on i2c3 bus
      arm64: dts: imx8mq-evk: Adjust nodes following alphabetical sort
      arm64: dts: imx8mn-ddr4-evk: Move iomuxc node to end of file
      arm64: dts: imx8qxp: Add scu key node
      arm64: dts: imx8qxp-mek: Enable scu key
      arm64: dts: imx8mq-evk: VDD_ARM power rail is always ON
      ARM: dts: imx7ulp: Move usdhc clocks assignment to board DT
      dt-bindings: arm: imx: Add the i.MX8MN LPDDR4 EVK board
      ARM: dts: imx6q: Add missing cooling device properties for CPUs
      ARM: dts: imx6dl: Add missing cooling device properties for CPUs
      ARM: dts: imx7d: Add missing cooling device properties for CPUs
      ARM: dts: imx6ul: Disable gpt2 by default
      ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO regulator
      ARM: dts: imx6ul-14x14-evk: Fix the magnetometer node name
      ARM: dts: imx6ul-14x14-evk: Assign power supplies for magnetometer
      arm64: dts: imx8qxp: Move usdhc clocks assignment to board DT
      arm64: dts: imx8mq: Move usdhc clocks assignment to board DT
      arm64: dts: imx8mm: Move usdhc clocks assignment to board DT
      arm64: dts: imx8mn: Move usdhc clocks assignment to board DT
      arm64: dts: imx8mn: Create EVK dtsi file for common use
      arm64: dts: imx8mn: Add LPDDR4 EVK board support
      arm64: dts: imx8mm: Remove duplicated machine compatible
      arm64: dts: imx8mn: Remove duplicated machine compatible
      ARM: dts: imx7ulp-evk: Use APLL_PFD1 as usdhc's clock source

Ben Peled (1):
      dt-bindings: ap80x: replace AP806 with AP80x

Benjamin Gaignard (3):
      ARM: dts: stm32: remove useless interrupt from dsi node for stm32f469
      ARM: dts: stm32: remove useless dma-ranges property for stm32f429
      ARM: dts: stm32: remove useless dma-ranges property for stm32f469

Biju Das (37):
      arm64: dts: renesas: r8a774c0: Create thermal zone to support IPA
      arm64: dts: renesas: r8a774c0: Add dynamic power coefficient
      arm64: dts: renesas: Initial r8a774b1 SoC device tree
      arm64: dts: renesas: Add HiHope RZ/G2N main board support
      dt-bindings: arm: renesas: Document RZ/G2N SoC DT bindings
      dt-bindings: arm: renesas: Add HopeRun RZ/G2N boards
      dt-bindings: power: rcar-sysc: Document r8a774b1 sysc
      dt-bindings: reset: rcar-rst: Document r8a774b1 reset module
      arm64: dts: renesas: r8a774a1: Remove audio port node
      arm64: dts: renesas: r8a774b1-hihope-rzg2n: Enable HS400 mode
      arm64: dts: renesas: r8a774b1: Add SYS-DMAC device nodes
      arm64: dts: renesas: r8a774b1: Add SCIF and HSCIF nodes
      arm64: dts: renesas: r8a774b1: Add GPIO device nodes
      arm64: dts: renesas: r8a774b1: Add Ethernet AVB node
      arm64: dts: renesas: Add HiHope RZ/G2N sub board support
      arm64: dts: renesas: r8a774b1: Add OPPs table for cpu devices
      arm64: dts: renesas: r8a774b1: Add RZ/G2N thermal support
      arm64: dts: renesas: r8a774b1: Add CMT device nodes
      arm64: dts: renesas: r8a774b1: Add TMU device nodes
      arm64: dts: renesas: r8a774b1: Add SDHI support
      arm64: dts: renesas: r8a774b1: Add I2C and IIC-DVFS support
      arm64: dts: renesas: r8a774b1: Add IPMMU device nodes
      arm64: dts: renesas: r8a774b1: Add FCPF and FCPV instances
      arm64: dts: renesas: r8a774b1: Add VSP instances
      arm64: dts: renesas: r8a774b1: Tie SYS-DMAC to IPMMU-DS0/1
      arm64: dts: renesas: r8a774b1: Connect Ethernet-AVB to IPMMU-DS0
      arm64: dts: renesas: hihope-common: Move du clk properties out of common dtsi
      arm64: dts: renesas: r8a774b1: Add DU device to DT
      arm64: dts: renesas: r8a774b1: Add HDMI encoder instance
      arm64: dts: renesas: r8a774b1-hihope-rzg2n: Add display clock properties
      arm64: dts: renesas: r8a774b1: Add FDP1 device nodes
      arm64: dts: renesas: r8a774b1: Add PWM device nodes
      arm64: dts: renesas: hihope-rzg2-ex: Enable backlight
      arm64: dts: renesas: hihope-rzg2-ex: Add LVDS support
      arm64: dts: renesas: Add support for Advantech idk-1110wr LVDS panel
      arm64: dts: renesas: r8a774b1: Add Sound and Audio DMAC device nodes
      arm64: dts: renesas: r8a774b1: Add VIN and CSI-2 support

Bjorn Andersson (3):
      arm64: dts: qcom: c630: Enable adsp, cdsp and mpss
      arm64: dts: qcom: sdm845: Add APSS watchdog node
      arm64: dts: qcom: db845c: Enable LVS 1 and 2

Brad Bishop (7):
      ARM: dts: aspeed-g6: Add lpc devices
      ARM: dts: Add 128MiB OpenBMC flash layout
      ARM: dts: aspeed: Add Rainier system
      ARM: dts: aspeed: rainier: Add mac devices
      ARM: dts: aspeed: rainier: Add i2c devices
      ARM: dts: aspeed: rainier: Add i2c devices
      ARM: dts: aspeed: rainier: Enable VUART1

Brandon Wyman (1):
      ARM: dts: aspeed: rainier: gpio-keys for PSU presence

Brian Masney (1):
      ARM: dts: qcom: pm8941: add 5vs2 regulator node

Carlo Caione (1):
      arm64: dts: meson: Link nvmem and secure-monitor nodes

Cheng-Yi Chiang (2):
      ARM: dts: rockchip: Add HDMI support to rk3288-veyron-analog-audio
      ARM: dts: rockchip: Add HDMI audio support to rk3288-veyron-mickey

Chicago Duan (1):
      ARM: dts: aspeed: fp5280g2: Add LED configuration

Chris Packham (4):
      ARM: dts: armada-xp: enable L2 cache parity and ecc on db-xc3-24g4xg
      ARM: dts: mvebu: add sdram controller node to Armada-38x
      ARM: dts: armada-xp: add label to sdram-controller node
      ARM: dts: bcm: HR2: add label to sp805 watchdog

Christian Hewitt (11):
      dt-bindings: Add vendor prefix for Ugoos
      dt-bindings: arm: amlogic: Add support for the Ugoos AM6
      arm64: dts: meson-g12b-ugoos-am6: add initial device-tree
      arm64: dts: meson-gxl-s905x-khadas-vim: fix gpio-keys-polled node
      arm64: dts: meson-gxl-s905x-khadas-vim: fix uart_A bluetooth node
      arm64: dts: meson-gxm-khadas-vim2: fix uart_A bluetooth node
      arm64: dts: meson: libretech-ac: update model description
      dt-bindings: arm: amlogic: update libretech-cc compatible
      arm64: dts: meson: libretech-cc: update model and compatible
      arm64: dts: meson-gxm-vega-s96: set rc-vega-s9x ir keymap
      arm64: dts: meson-gxbb-vega-s95: set rc-vega-s9x ir keymap

Clément Péron (3):
      arm64: dts: allwinner: Add ARM Mali GPU node for H6
      arm64: dts: allwinner: Add mali GPU supply for H6 boards
      arm64: allwinner: h6: Enable GPU node for Tanix TX6

Corentin Labbe (9):
      ARM64: dts: amlogic: adds crypto hardware node
      dt-bindings: crypto: Add DT bindings documentation for sun8i-ce Crypto Engine
      ARM: dts: sun8i: R40: add crypto engine node
      ARM: dts: sun8i: H3: Add Crypto Engine node
      arm64: dts: allwinner: sun50i: Add Crypto Engine node on A64
      arm64: dts: allwinner: sun50i: Add crypto engine node on H5
      arm64: dts: allwinner: sun50i: Add Crypto Engine node on H6
      ARM: dts: sun8i: a83t: Add Security System node
      ARM: dts: sun9i: a80: Add Security System node

Cédric Le Goater (4):
      ARM: dts: aspeed-g6: Add FMC and SPI devices
      ARM: dts: aspeed: rainier: Enable FMC and SPI devices
      ARM: dts: ast2600-evb: Enable FMC and SPI devices
      ARM: dts: aspeed: Add "spi-max-frequency" property

Dan Haab (1):
      ARM: dts: BCM5301X: Add DT for Luxul XWC-2000

Dehui Sun (2):
      dt-bindings: mediatek: update bindings for MT8183 systimer
      arm64: dts: mt8183: add systimer0 device node

Dien Pham (2):
      arm64: dts: r8a7795: Add cpuidle support for CA53 cores
      arm64: dts: r8a7796: Add cpuidle support for CA53 cores

Dinh Nguyen (2):
      ARM: dts: arria10: Modify QSPI read_delay for Arria10
      arm64: agilex: enable USB and LEDs on agilex devkit

Dmitry Osipenko (16):
      dt-bindings: regulator: Document regulators coupling of NVIDIA Tegra20/30 SoCs
      dt-bindings: memory: tegra30: Convert to Tegra124 YAML
      dt-bindings: memory: Add binding for NVIDIA Tegra30 Memory Controller
      dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory Controller
      ARM: tegra: Connect SMMU with Video Decoder Engine on Tegra30
      ARM: tegra: nyan-big: Add timings for RAM codes 4 and 6
      ARM: tegra: Add External Memory Controller node on Tegra30
      ARM: tegra: Add Tegra20 CPU clock
      ARM: tegra: Add Tegra30 CPU clock
      ARM: tegra: Add CPU Operating Performance Points for Tegra20
      ARM: tegra: Add CPU Operating Performance Points for Tegra30
      ARM: tegra: paz00: Set up voltage regulators for DVFS
      ARM: tegra: paz00: Add CPU Operating Performance Points
      ARM: tegra: trimslice: Add CPU Operating Performance Points
      ARM: tegra: cardhu-a04: Set up voltage regulators for DVFS
      ARM: tegra: cardhu-a04: Add CPU Operating Performance Points

Douglas Anderson (1):
      ARM: dts: rockchip: Add cpu id to rk3288 efuse node

Eddie James (2):
      ARM: dts: aspeed: tacoma: Enable I2C busses
      ARM: dts: aspeed: tacoma: Add gpio-key definitions

Eddy Petrișor (1):
      dt-bindings: arm: fsl: Add the S32V234-EVB board

Eugen Hristev (3):
      ARM: dts: at91: sama5d27_som1_ek: add mmc capabilities for SDMMC0
      ARM: dts: at91: sama5d2_xplained: add analog and digital filter for i2c
      ARM: dts: at91: sama5d4_xplained: add digital filter for i2c

Ezequiel Garcia (1):
      ARM: dts: rockchip: Add RK3288 VOP gamma LUT address

Fabio Estevam (10):
      ARM: dts: imx: Replace "simple-bus" with "simple-mfd" for anatop
      ARM: dts: imx6ul-phytec-phycore-som: Add missing unit name
      ARM: dts: imx6qdl-gw551x: Do not use 'simple-audio-card,dai-link'
      ARM: dts: vf610-zii-scu4-aib: Remove internal debug network interfaces
      ARM: dts: imx6q-gw54xx: Do not use 'simple-audio-card,dai-link'
      ARM: dts: imx53-qsb: Use DRM bindings for the Seiko 43WVF1G panel
      arm64: dts: ls1028a-qds: Remove unnecessary #address-cells/#size-cells
      arm64: dts: ls1028a: Move thermal-zone out of SoC
      arm64: dts: ls1028a: Fix tmu unit address
      arm64: dts: imx8mn-evk: Remove invalid Atheros properties

Fabrice Gasnier (5):
      ARM: dts: stm32: Enable VREFBUF on stm32mp157a-dk1
      ARM: dts: stm32: add ADC pins used on stm32mp157a-dk1
      ARM: dts: stm32: enable ADC support on stm32mp157a-dk1
      ARM: dts: stm32: Add DAC pins used on stm32mp157c-ed1
      ARM: dts: stm32: Add DAC support to stm32mp157c-ed1

Fabrizio Castro (11):
      dt-bindings: timer: renesas: tmu: Document r8a774a1 bindings
      arm64: dts: renesas: r8a774b1: Add RWDT node
      arm64: dts: renesas: r8a774b1: Add all MSIOF nodes
      arm64: dts: renesas: r8a774b1: Add PCIe device nodes
      arm64: dts: renesas: hihope-rzg2-ex: Let the board specific DT decide about pciec1
      arm64: dts: renesas: r8a774b1: Add USB2.0 phy and host (EHCI/OHCI) device nodes
      arm64: dts: renesas: r8a774b1: Add USB-DMAC and HSUSB device nodes
      arm64: dts: renesas: r8a774b1: Add USB3.0 device nodes
      arm64: dts: renesas: r8a774b1: Add INTC-EX device node
      arm64: dts: renesas: r8a774b1: Add CAN and CAN FD support
      arm64: dts: renesas: r8a774b1: Add SATA controller node

Faiz Abbas (3):
      arm64: dts: ti: j721e-main: Add SDHCI nodes
      arm64: dts: ti: j721e-common-proc-board: Add Support for eMMC and SD card
      arm64: dts: ti: k3-am654-base-board: Add disable-wp for mmc0

Fancy Fang (1):
      ARM: dts: imx7ulp: remove mipi pll clock node

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-dt-next-2019-10-15' into devicetree/next

Frank Hartung (1):
      arm64: dts: meson: Add capacity-dmips-mhz attributes to G12B

Frieder Schrempf (9):
      ARM: dts: imx6ul-kontron-n6310: Move common SoM nodes to a separate file
      ARM: dts: Add support for two more Kontron SoMs N6311 and N6411
      ARM: dts: imx6ul-kontron-n6310-s: Disable the snvs-poweroff driver
      ARM: dts: imx6ul-kontron-n6310-s: Move common nodes to a separate file
      ARM: dts: Add support for two more Kontron evalkit boards 'N6311 S' and 'N6411 S'
      ARM: dts: imx6ul-kontron-n6x1x: Add 'chosen' node with 'stdout-path'
      ARM: dts: imx6ul-kontron-n6x1x-s: Add vbus-supply and overcurrent polarity to usb nodes
      ARM: dts: imx6ul-kontron-n6x1x-s: Remove an obsolete comment and fix indentation
      dt-bindings: arm: fsl: Add more Kontron i.MX6UL/ULL compatibles

Geert Uytterhoeven (15):
      ARM: dts: gose: Replace spaces by TABs
      ARM: dts: lager: Replace spaces by TABs
      dt-bindings: arm: renesas: Add R-Car M3-N ULCB with Kingfisher
      ARM: dts: imx53: Spelling s/configration/configuration/
      dt-bindings: arm: renesas: Document R-Car M3-W+ SoC DT bindings
      dt-bindings: arm: renesas: Add Salvator-XS board with R-Car M3-W+
      dt-bindings: reset: rcar-rst: Document r8a77961 support
      dt-bindings: power: rcar-sysc: Document r8a77961 support
      Merge tag 'renesas-r8a77961-dt-binding-defs-tag' into renesas-arm64-dt-for-v5.5
      arm64: dts: renesas: Prepare for rename of ARCH_R8A7796 to ARCH_R8A77960
      arm64: dts: renesas: Add Renesas R8A77961 SoC support
      arm64: dts: renesas: Add support for Salvator-XS with R-Car M3-W+
      arm64: dts: lg1312: DT fix s/#interrupts-cells/#interrupt-cells/
      arm64: dts: lg1313: DT fix s/#interrupts-cells/#interrupt-cells/
      ARM: dts: atlas7: Fix "debounce-interval" property misspelling

Georgi Djakov (1):
      arm64: dts: qcs404: Add interconnect provider DT nodes

Georgii Staroselskii (1):
      arm64: dts: allwinner: bluetooth for Emlid Neutis N5

Gilles DOFFE (1):
      ARM: dts: imx6qdl-rex: add gpio expander pca9535

Grygorii Strashko (6):
      ARM: dts: keystone-clocks: add input fixed clocks
      ARM: dts: k2e-clocks: add input ext. fixed clocks tsipclka/b
      ARM: dts: k2e-netcp: add cpts refclk_mux node
      ARM: dts: k2hk-netcp: add cpts refclk_mux node
      ARM: dts: k2l-netcp: add cpts refclk_mux node
      ARM: configs: keystone: enable cpts

Grzegorz Jaszczyk (7):
      dt-bindings: marvell: Declare the CN913x SoC compatibles
      arm64: dts: marvell: Add AP806-dual cache description
      arm64: dts: marvell: Add AP806-quad cache description
      arm64: dts: marvell: Add AP807-quad cache description
      arm64: dts: marvell: Add support for Marvell CN9130-DB
      arm64: dts: marvell: Add support for Marvell CN9131-DB
      arm64: dts: marvell: Add support for Marvell CN9132-DB

Guido Günther (1):
      arm64: dts: imx8mq: Enable gpu passive throttling

Guillaume La Roque (4):
      arm64: dts: meson: g12: add temperature sensor
      arm64: dts: meson: g12: Add minimal thermal zone
      arm64: dts: meson: g12a: add cooling properties
      arm64: dts: meson: g12b: add cooling properties

Heiko Stuebner (18):
      arm64: dts: rockchip: fix iface clock-name on px30 iommus
      arm64: dts: rockchip: remove static xin32k from px30
      arm64: dts: rockchip: remove px30 emmc_pwren pinctrl
      arm64: dts: rockchip: add default px30 emmc pinctrl
      arm64: dts: rockchip: fix the px30-evb power tree
      arm64: dts: rockchip: add emmc-powersequence to px30-evb
      arm64: dts: rockchip: move px30-evb console output to uart 5
      arm64: dts: rockchip: remove unused pin settings from px30
      arm64: dts: rockchip: document explicit px30 cru dependencies
      arm64: dts: rockchip: add px30-evb i2c1 devices
      dt-bindings: document PX30 usb2phy General Register Files
      arm64: dts: rockchip: add missing #msi-cells to rk3399
      arm64: dts: rockchip: add cr50 tpm to rk3399-gru scarlet and bob
      arm64: dts: rockchip: add px30 otp controller
      arm64: dts: rockchip: enable gpu on rk3399-puma
      arm64: dts: rockchip: remove px30 default optee node
      arm64: dts: rockchip: add usb2phy for px30
      arm64: dts: rockchip: enable usb2phy on px30-evb

Hongwei Zhang (1):
      ARM: dts: aspeed-g5: Add SGPIO description

Icenowy Zheng (1):
      arm64: dts: allwinner: h6: add USB3 device nodes

Jacopo Mondi (2):
      arm64: dts: renesas: Add LIF channel indices to vsps properties
      arm64: dts: renesas: rcar-gen3: Add CMM units

Jagan Teki (2):
      arm64: dts: rockchip: Rename vcc12v_sys into dc_12v for roc-rk3399-pc
      arm64: dts: rockchip: Fix roc-rk3399-pc regulator input rails

Jeffrey Hugo (5):
      arm64: dts: qcom: msm8998: Add blsp1 BAM
      arm64: dts: qcom: msm8998: Add blsp1_uart3
      arm64: dts: qcom: msm8998-mtp: Enable bluetooth
      arm64: dts: qcom: msm8998-clamshell: Enable bluetooth
      arm64: dts: qcom: msm8998-clamshell: Remove retention idle state

Jernej Skrabec (4):
      arm64: dts: allwinner: a64: orangepi-win: Enable audio codec
      dt-bindings: bus: sunxi: Add H3 MBUS compatible
      ARM: dts: sunxi: h3/h5: Add MBUS controller node
      dts: arm: sun8i: h3: Enable deinterlace unit

Jerome Brunet (9):
      arm64: dts: meson: sm1: set gpio interrupt controller compatible
      arm64: dts: meson: axg: fix audio fifo reg size
      arm64: dts: meson: g12: fix audio fifo reg size
      arm64: dts: meson: g12: add a g12 layer
      arm64: dts: meson: g12: factor the power domain.
      arm64: dts: meson: g12: move audio bus out of g12-common
      arm64: dts: meson: g12a: add audio devices resets
      arm64: dts: meson: sm1: add audio devices
      arm64: dts: meson: sei610: enable audio

Jianxin Pan (3):
      dt-bindings: arm: amlogic: add A1 bindings
      dt-bindings: arm: amlogic: add Amlogic AD401 bindings
      arm64: dts: add support for A1 based Amlogic AD401

Jinu Thomas (2):
      ARM: dts: aspeed: rainier: Add i2c eeproms
      ARM: dts: aspeed: rainier: Fix i2c eeprom size

Joakim Zhang (1):
      arm64: dts: imx8mn: add ddr pmu node

Joel Stanley (16):
      ARM: dts: aspeed-g6: Add i2c buses
      ARM: dts: aspeed-g6: Add VUART descriptions
      ARM: dts: aspeed: Add Tacoma machine
      ARM: dts: aspeed: tacoma: Enable FMC and SPI devices
      ARM: dts: aspeed: ast2600evb: Use custom flash layout
      ARM: dts: aspeed-g6: Describe FSI masters
      ARM: dts: aspeed: tacoma: Enable FMC and SPI devices
      Merge branch 'aspeed-clk-for-v5.5'
      ARM: dts: aspeed-g6: Fix i2c clock source
      ARM: dts: aspeed-g6: Add remaining UARTs
      ARM: dts: aspeed: tacoma: Add UART1 and workaround
      ARM: dts: ast2600evb: Enable UART workaround
      ARM: dts: aspeed: tacoma: Add host FSI description
      ARM: dts: aspeed: tacoma: Use 64MB for firmware memory
      ARM: dts: aspeed: ast2600evb: Enable i2c buses
      ARM: dts: aspeed-g6: Add timer description

Johan Jonker (3):
      ARM: dts: rockchip: remove some tabs and spaces from dtsi files
      arm64: dts: rockchip: restyle rockchip,pins on rk3399-rock-pi-4
      include: dt-bindings: rockchip: mark RK_FUNC defines as deprecated

Jon Hunter (2):
      arm64: tegra: Fix 'active-low' warning for Jetson TX1 regulator
      arm64: tegra: Fix 'active-low' warning for Jetson Xavier regulator

Jorge Ramirez-Ortiz (2):
      arm64: dts: qcom: qcs404: add sleep clk fixed rate oscillator
      arm64: dts: qcom: qcs404: add the watchdog node

Josef Friedl (1):
      arm: dts: mt6323: add keys, power-controller, rtc and codec

Kamel Bouhara (6):
      ARM: dts: at91: sama5d2: add an rtc label for derived boards
      dt-bindings: Add vendor prefix for Overkiz SAS
      dt-bindings: arm: at91: Document Kizbox3 HS board binding
      ARM: dts: at91: add Overkiz KIZBOX3 board
      dt-bindings: arm: at91: Document Kizbox2-2 board binding
      ARM: dts: at91: add a dts and dtsi file for kizbox2 based boards

Karl Palsson (3):
      ARM: dts: sunxi: h3/h5: add missing uart2 rts/cts pins
      ARM: dts: sun8i: add FriendlyARM NanoPi Duo2
      dt-bindings: arm: sunxi: add FriendlyARM NanoPi Duo2

Katsuhiro Suzuki (1):
      arm64: dts: rockchip: add analog audio nodes on rk3399-rockpro64

Kevin Hilman (2):
      Merge branch 'reset/meson-sm1-bindings' of git://git.pengutronix.de/git/pza/linux into v5.5/dt64-redo
      Merge tag 'clk-meson-dt-v5.5-1' of git://github.com/BayLibre/clk-meson into v5.5/dt64-redo

Khiem Nguyen (2):
      arm64: dts: r8a7795: Add cpuidle support for CA57 cores
      arm64: dts: r8a7796: Add cpuidle support for CA57 cores

Kieran Bingham (1):
      arm64: dts: renesas: r8a77970: Fix PWM3

Konstantin Porotchkin (1):
      arm64: dts: marvell: Prepare the introduction of AP807 based SoCs

Krzysztof Kozlowski (14):
      arm64: dts: exynos: Rename Multi Core Timer node to "timer" on Exynos5433
      ARM: dts: exynos: Rename Multi Core Timer node to "timer"
      ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos4210
      ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos4412
      ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos5250
      ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos54xx
      ARM: dts: exynos: Use defines for MCT interrupt GIC SPI/PPI specifier
      ARM: dts: exynos: Rename power domain nodes to "power-domain" in Exynos4
      ARM: dts: exynos: Rename SysRAM node to "sram"
      dt-bindings: memory-controllers: exynos5422-dmc: Correct example syntax and memory region
      ARM: dts: dove: Rename "sa-sram" node to "sram"
      ARM: dts: am: Rename "ocmcram" node to "sram"
      ARM: dts: omap: Rename "ocmcram" node to "sram"
      ARM: dts: imx: Rename "iram" node to "sram"

Lihua Yao (1):
      ARM: dts: s3c64xx: Fix init order of clock providers

Loic Poulain (1):
      arm64: dts: apq8096-db820c: Increase load on l21 for SDCARD

Lubomir Rintel (11):
      dt-bindings: arm: cpu: Add Marvell MMP3 SMP enable method
      dt-bindings: arm: Convert Marvell MMP board/soc bindings to json-schema
      dt-bindings: arm: mrvl: Document MMP3 compatible string
      dt-bindings: mrvl,intc: Add a MMP3 interrupt controller
      dt-bindings: phy-mmp3-usb: Add bindings
      ARM: dts: mmp3: Add MMP3 SoC dts file
      ARM: dts: mmp3: add Dell Wyse 3020 machine
      ARM: dts: mmp3: Add a name to /clocks node
      ARM: dts: mmp3: Fix /soc/watchdog node name
      ARM: dts: mmp3-dell-ariel: Add a name to /memory node
      ARM: dts: mmp3-dell-ariel: Add a serial point alias

Luca Weiss (3):
      ARM: dts: msm8974-FP2: Drop unused card-detect pin
      ARM: dts: msm8974-FP2: Increase load on l20 for sdhci
      ARM: dts: msm8974-FP2: add reboot-mode node

Lukasz Luba (9):
      dt-bindings: ddr: Rename lpddr2 directory
      dt-bindings: ddr: Add bindings for LPDDR3 memories
      dt-bindings: memory-controllers: Add Exynos5422 DMC device description
      ARM: dts: exynos: Add syscon compatible to clock controller on Exynos542x
      ARM: dts: exynos: Add DMC device to Exynos5422 and Odroid XU3-family boards
      dt-bindings: ddr: Add bindings for Samsung LPDDR3 memories
      dt-bindings: memory-controllers: exynos5422-dmc: Add interrupt mode
      ARM: dts: exynos: Extend mapped region for DMC on Exynos5422
      ARM: dts: exynos: Add interrupts to DMC controller in Exynos5422

Lukasz Majewski (1):
      ARM: dts: Disable DMA support on the BK4 vf610 device's fsl_lpuart

Maciej Falkowski (4):
      arm64: dts: exynos: Swap clock order of sysmmu on Exynos5433
      arm64: dts: exynos: Split phandle in dmas property on Exynos5433
      ARM: dts: exynos: Remove obsolete IRQ lines on Exynos3250
      ARM: dts: exynos: Split phandle in dmas property

Magnus Damm (1):
      ARM: dts: emev2: Add whitespace for GPIO nodes

Manivannan Sadhasivam (3):
      arm64: dts: actions: Add MMC controller support for S900
      arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
      ARM: dts: Add RDA8810PL GPIO controllers

Marcel Ziswiler (4):
      dt-bindings: arm: fsl: add nxp based toradex apalis/colibri bindings
      dt-bindings: arm: fsl: add nxp based toradex colibri-imx8x bindings
      ARM: dts: vf-colibri: fix typo in top-level module compatible
      arm64: dts: freescale: add initial support for colibri imx8x

Marek Behún (1):
      arm64: dts: armada-3720-turris-mox: add firmware node

Marek Szyprowski (4):
      arm64: dts: exynos: Move GPU under /soc node for Exynos5433
      arm64: dts: exynos: Move GPU under /soc node for Exynos7
      arm64: dts: exynos: Revert "Remove unneeded address space mapping for soc node"
      ARM: dts: exynos: Add support ARM architected timers on Exynos5

Marek Vasut (1):
      ARM: dts: imx6q-dhcom: Enable CAN in board DTS

Markus Kueffner (1):
      ARM: dts: imx6qdl-udoo: Add Pincfgs for OTG

Markus Reichl (5):
      arm64: dts: rockchip: Add LED nodes on rk3399-roc-pc
      arm64: dts: rockchip: Add nodes for buttons on rk3399-roc-pc
      arm64: dts: rockchip: Add vcc_sys enable pin on rk3399-roc-pc
      arm64: dts: rockchip: Rework voltage supplies for regulators on rk3399-roc-pc
      arm64: dts: rockchip: Split rk3399-roc-pc for with and without mezzanine board.

Matthias Kaehlcke (1):
      ARM: dts: rockchip: Use interpolated brightness tables for veyron

Max Krummenacher (2):
      ARM: dts: imx6ull-colibri: reduce v_batt current in power off
      ARM: dts: imx6ull: improve can templates

Maxime Ripard (4):
      ARM: dts: sun9i: Add missing watchdog clocks
      ARM: dts: sun5i: olinuxino micro: Fix AT24 node name
      ARM: dts: sun6i: Remove useless reset-names
      arm64: dts: allwinner: h6: Remove useless reset name

Michael Srba (1):
      arm64: dts: msm8916-samsung-a2015: add tactile buttons and hall sensor

Michal Vokáč (3):
      ARM: dts: imx6dl-yapp4: Enable the MPR121 touchkey controller on Hydra
      ARM: dts: imx6dl-yapp4: Enable UART2
      ARM: dts: imx6dl-yapp4: Enable the I2C3 bus on all board variants

Miquel Raynal (12):
      arm64: dts: marvell: Enumerate the first AP806 syscon
      arm64: dts: marvell: Add AP806-dual missing CPU clocks
      MAINTAINERS: Add new Marvell CN9130-based files to track
      arm64: dts: marvell: Move clocks to AP806 specific file
      dt-bindings: marvell: Convert the SoC compatibles description to YAML
      arm64: dts: marvell: Add support for AP807/AP807-quad
      arm64: dts: marvell: Fix CP110 NAND controller node multi-line comment alignment
      arm64: dts: marvell: Prepare the introduction of CP115
      arm64: dts: marvell: Drop PCIe I/O ranges from CP11x file
      arm64: dts: marvell: Externalize PCIe macros from CP11x file
      arm64: dts: marvell: Add support for CP115
      arm64: dts: marvell: Add support for Marvell CN9130 SoC support

Mylène Josserand (1):
      ARM: dts: sun8i: a83t: a711: Add touchscreen node

Nagarjuna Kristam (3):
      arm64: tegra: Enable XUSB pad controller on Jetson TX2
      arm64: tegra: Enable SMMU for XUSB host on Tegra186
      arm64: tegra: Enable XUSB host controller on Jetson TX2

Nava kishore Manne (3):
      arm64: zynqmp: Add support for zynqmp fpga manager
      arm64: zynqmp: Label whole PL part as fpga_full region
      arm64: zynqmp: Add support for zynqmp nvmem firmware driver

Neil Armstrong (23):
      arm64: dts: meson-g12a-sei510: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-g12a-x96-max: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gx-p23x-q20x: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxbb-nanopi-k2: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxbb-nexbox-a95x: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxbb-p20x: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxbb-vega-s95: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxbb-wetek: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxl-s805x-p241: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxl-s905x-nexbox-a95x: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxl-s905x-p212: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxm-khadas-vim2: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-gxm-rbox-pro: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-sm1-sei610: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-g12b-khadas-vim3: add keep-power-in-suspend property in SDIO node
      arm64: dts: meson-g12a: Add PCIe node
      arm64: dts: khadas-vim3: add commented support for PCIe
      arm64: dts: meson-g12: add support for simplefb
      arm64: dts: meson-g12a: fix gpu irq order
      arm64: dts: meson-gxm: fix gpu irq order
      arm64: dts: meson-g12b-odroid-n2: add missing amlogic, s922x compatible
      arm64: dts: meson-gx: cec node should be disabled by default
      arm64: dts: meson-gx: fix i2c compatible

Nikita Travkin (2):
      arm64: dts: msm8916-longcheer-l8150: Enable WCNSS for WiFi and BT
      arm64: dts: msm8916-longcheer-l8150: Add Volume buttons

Oliver Graute (1):
      dt-bindings: arm: fsl: Document Variscite i.MX6q devicetree

Olivier Moysan (1):
      ARM: dts: stm32: add hdmi audio support to stm32mp157a-dk1 board

Olof Johansson (46):
      Merge tag 'renesas-arm-dt-for-v5.5-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-arm64-dt-for-v5.5-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.5-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'v5.5-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.5-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'samsung-dt-5.5' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'samsung-dt64-5.5' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'samsung-dt-dmc-5.5' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'mmp-dt-for-v5.5' of git://git.kernel.org/.../lkundrak/linux-mmp into arm/dt
      Merge tag 'actions-arm64-dt-for-v5.5' of git://git.kernel.org/.../mani/linux-actions into arm/dt
      Merge tag 'arm-soc/for-5.5/devicetree' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'omap-for-v5.5/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'omap-for-v5.5/ti-sysc-drop-pdata-v2-signed-take2' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'juno-update-5.5' of git://git.kernel.org/.../sudeep.holla/linux into arm/dt
      Merge tag 'stm32-dt-for-v5.5-1' of git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'socfpga_dts_updates_for_v5.5' of git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge branch 'for_5.5/keystone-dts' of git://git.kernel.org/.../ssantosh/linux-keystone into arm/dt
      Merge tag 'realtek-arm64-dt-for-5.5' of git://git.kernel.org/.../afaerber/linux-realtek into arm/dt
      Merge tag 'hisi-arm64-dt-for-5.5' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'omap-for-v5.5/prm-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'renesas-arm64-dt-for-v5.5-tag2' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.5-tag2' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'sunxi-dt-for-5.5-1' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'tegra-for-5.5-dt-bindings' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.5-arm-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.5-arm64-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'mvebu-dt-5.5-1' of git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'mvebu-dt64-5.5-1' of git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'sunxi-fixes-for-5.4-3' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'sunxi-dt-for-5.5-2' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'imx-bindings-5.5' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.5' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-5.5' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-tmu-5.5' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'qcom-arm64-for-5.5' of git://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'qcom-dts-for-5.5' of git://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'zynqmp-dt-for-v5.5' of https://github.com/Xilinx/linux-xlnx into arm/dt
      Merge tag 'aspeed-5.5-devicetree' of git://git.kernel.org/.../joel/aspeed into arm/dt
      Merge tag 'at91-5.5-dt' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'ti-k3-soc-for-v5.5' of git://git.kernel.org/.../kristo/linux into arm/dt
      Merge tag 'v5.5-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.5-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'amlogic-dt64' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'v5.4-next-dts' of https://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'v5.4-next-dts64' of https://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'omap-for-v5.5/dt-late-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt

Ondrej Jirman (3):
      arm64: dts: allwinner: h6: Add pin configs for uart1
      arm64: dts: allwinner: orange-pi-3: Enable UART1 / Bluetooth
      arm64: dts: allwinner: orange-pi-3: Enable USB 3.0 host support

Ooi, Joyce (2):
      arm64: dts: agilex: add QSPI support for Intel Agilex
      arm64: dts: altera: update QSPI reg addresses for Stratix10

Pascal Paillet (4):
      ARM: dts: stm32: add PWR regulators support on stm32mp157
      ARM: dts: stm32: change default minimal buck1 value on stm32mp157
      ARM: dts: stm32: Fix active discharge usage on stm32mp157
      ARM: dts: stm32: disable active-discharge for vbus_otg on stm32mp157a-avenger96

Peter Chen (1):
      ARM: dts: imx6ul-14x14-evk.dtsi: configure USBOTG1 ID pinctrl

Peter Geis (2):
      dt-bindings: clean up rockchip grf binding document
      arm64: dts: rockchip: fix sdmmc detection on boot on rk3328-roc-cc

Peter Griffin (1):
      arm64: dts: hisilicon: Add Mali-450 MP4 GPU DT entry

Philippe Schenker (11):
      ARM: dts: imx7-colibri: Add touch controllers
      ARM: dts: imx6qdl-colibri: Add missing pin declaration in iomuxc
      ARM: dts: imx6qdl-apalis: Add sleep state to can interfaces
      ARM: dts: imx6-apalis: Add touchscreens used on Toradex eval boards
      ARM: dts: imx6-colibri: Add missing pinmuxing to Toradex eval board
      ARM: dts: imx6ull-colibri: Add sleep mode to fec
      ARM: dts: imx6ull-colibri: Add watchdog
      ARM: dts: imx6ull-colibri: Add general wakeup key used on Colibri
      ARM: dts: imx*(colibri|apalis): add missing recovery modes to i2c
      ARM: dts: vf-colibri: add recovery mode to i2c
      ARM: tegra: Add stmpe-adc DT node to Toradex T30 modules

Rajan Vaja (1):
      arm64: zynqmp: Add firmware DT node

Rashmica Gupta (1):
      ARM: dts: aspeed-g6: Add gpio devices

Richard Gong (1):
      arm64: dts: agilex: add service layer, fpga manager and fpga region

Rob Clark (1):
      arm64: dts: qcom: sdm845-cheza: delete zap-shader

Robert Marko (1):
      ARM: dts: qcom: ipq4019: Add SDHCI controller node

Robin Murphy (6):
      arm64: dts: rockchip: Enable nanopi4 HDMI audio
      arm64: dts: rockchip: Update nanopi4 phy reset properties
      arm64: dts: juno: add GPU subsystem
      arm64: dts: rockchip: Add RK3328 audio pipelines
      dt-bindings: ARM: rockchip: Add Beelink A1
      arm64: dts: rockchip: Add Beelink A1

Roger Quadros (2):
      arm64: dts: ti: k3-j721e-main: add USB controller nodes
      arm64: dts: ti: k3-j721e-common-proc-board: Add USB ports

Rogerio Pimentel da Silva (1):
      arm64: dts: imx8mq-evk: Add remote control

Russell King (1):
      arm64: dts: mark lx2160a esdhc controllers dma coherent

S.j. Wang (1):
      arm64: dts: imx8mm-evk: Assigned clocks for audio plls

Sai Prakash Ranjan (1):
      arm64: dts: qcom: msm8998: Disable coresight by default

Sebastian Reichel (2):
      ARM: dts: LogicPD Torpedo: Add WiLink UART node
      ARM: dts: IGEP: Add WiLink UART node

Simon Horman (1):
      dt-bindings: arm: renesas: Convert 'renesas,prr' to json-schema

Sowjanya Komatineni (3):
      arm64: tegra: Enable wake from deep sleep on RTC alarm
      arm64: tegra: Add Jetson TX1 SC7 timings
      arm64: tegra: Add Jetson Nano SC7 timings

Stefan Agner (2):
      ARM: dts: imx7-colibri: add GPIO wakeup key
      ARM: dts: imx7-colibri: fix 1.8V/UHS support

Stefan Wahren (7):
      ARM: dts: bcm283x: Remove simple-bus from fixed clocks
      ARM: dts: bcm283x: Remove brcm,bcm2835-pl011 compatible
      ARM: dts: bcm283x: Move BCM2835/6/7 specific to bcm2835-common.dtsi
      dt-bindings: arm: Convert BCM2835 board/soc bindings to json-schema
      dt-bindings: arm: bcm2835: Add Raspberry Pi 4 to DT schema
      ARM: dts: Add minimal Raspberry Pi 4 support
      arm64: dts: broadcom: Add reference to RPi 4 B

Stephan Gerhold (2):
      arm64: dts: msm8916-samsung-a2015: Enable WCNSS for WiFi and BT
      arm64: dts: msm8916-samsung-a5u: Override iris compatible

Stephen Boyd (1):
      arm64: dts: qcom: sdm845: Use UFS reset gpio instead of pinctrl

Stoica Cosmin-Stefan (1):
      arm64: dts: fsl: Add device tree for S32V234-EVB

Suman Anna (4):
      arm64: dts: ti: k3-am65-main: Add mailbox cluster nodes
      arm64: dts: ti: k3-am65-base-board: Add IPC sub-mailbox nodes for R5Fs
      arm64: dts: ti: k3-j721e-main: Add mailbox cluster nodes
      arm64: dts: ti: k3-j721e-common-proc-board: Add IPC sub-mailbox nodes

Sylwester Nawrocki (3):
      ARM: dts: exynos: Add "syscon" compatible string to chipid node on Exynos5
      ARM: dts: exynos: Add samsung,asv-bin property to Odroid XU3 Lite
      ARM: dts: exynos: Add audio support (WM1811 CODEC boards) to Arndale board

Sébastien Szymanski (11):
      dt-bindings: arm: Document Armadeus SoM and Dev boards devicetree binding
      ARM: dts: opos6ul/opos6uldev: rework device tree to support i.MX6ULL
      ARM: dts: imx6qdl-{apf6, apf6dev}: switch boards to SPDX identifier
      ARM: dts: imx6qdl-{apf6, apf6dev}: remove container node around pinctrl nodes
      ARM: dts: imx6qdl-apf6: add phy to fec
      ARM: dts: imx6qdl-apf6: add flow control to uart2
      ARM: dts: imx6qdl-apf6: fix WiFi
      ARM: dts: imx6qdl-apf6dev: add RTC support
      ARM: dts: imx6qdl-apf6dev: rename usb-h1-vbus regulator to 5V
      ARM: dts: imx6qdl-apf6dev: add backlight support
      ARM: dts: imx6qdl-apf6dev: use DRM bindings

Tao Ren (4):
      ARM: dts: aspeed: Common dtsi for Facebook AST2500 Network BMCs
      ARM: dts: aspeed: cmm: Use common dtsi
      ARM: dts: aspeed: minipack: Use common dtsi
      ARM: dts: aspeed: yamp: Use common dtsi

Tero Kristo (5):
      ARM: dts: dra7: add PRM nodes
      ARM: dts: omap4: add PRM nodes
      ARM: dts: am33xx: Add PRM data
      ARM: dts: am43xx: Add PRM data
      ARM: dts: omap5: Add PRM data

Thara Gopinath (1):
      soc: qcom: Invert the cooling states for the aoss warming devices

Thierry Reding (20):
      Merge branch 'for-5.5/dt-bindings'
      ARM: tegra: Add SOR0_OUT clock on Tegra124
      ARM: tegra: Add eDP power supplies on Venice2
      Merge branch 'for-5.5/dt-bindings'
      arm64: tegra: Add CPU and cache topology for Tegra194
      arm64: tegra: Add unit-address for CBB on Tegra194
      arm64: tegra: Add unit-address for ACONNECT on Tegra194
      arm64: tegra: Fix base address for SOR1 on Tegra194
      arm64: tegra: Hook up edp interrupt on Tegra210 SOCTHERM
      arm64: tegra: Fix compatible string for EQOS on Tegra194
      arm64: tegra: Add ethernet alias on Jetson AGX Xavier
      arm64: tegra: Enable SMMU for VIC on Tegra186
      arm64: tegra: Add SOR0_OUT clock on Tegra210
      arm64: tegra: Enable DP support on Jetson Nano
      arm64: tegra: Fix compatible for SOR1
      arm64: tegra: Enable DP support on Jetson TX2
      arm64: tegra: p2888: Rename regulators for consistency
      arm64: tegra: Enable DisplayPort on Jetson AGX Xavier
      arm64: tegra: Add blank lines for better readability
      arm64: tegra: Add PMU on Tegra210

Tomasz Maciej Nowak (1):
      arm64: dts: marvell: add ESPRESSObin variants

Tony Lindgren (39):
      ARM: dts: omap4-droid4: Allow 300mA current for USB peripherals
      ARM: dts: Add minimal support for Droid Bionic xt875
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 gpio
      ARM: dts: Drop custom hwmod property for omap4 gpio
      ARM: dts: Drop custom hwmod property for omap5 gpio
      ARM: OMAP2+: Drop legacy platform data for dra7 mailbox
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 mailbox
      ARM: OMAP2+: Drop legacy platform data for omap4 mailbox
      ARM: OMAP2+: Drop legacy platform data for omap5 mailbox
      ARM: dts: Drop custom hwmod property for omap5 mcspi
      ARM: OMAP2+: Drop legacy platform data for omap5 mcspi
      ARM: dts: Drop custom hwmod property for am33xx uart
      ARM: dts: Drop custom hwmod property for am4 uart
      ARM: dts: Drop custom hwmod property for omap5 uart
      ARM: dts: Drop custom hwmod property for am3 i2c
      ARM: dts: Drop custom hwmod property for am4 i2c
      ARM: dts: Drop custom hwmod property for omap5 i2c
      ARM: dts: Drop custom hwmod property for am3 mmc
      ARM: dts: Drop custom hwmod property for am4 mmc
      ARM: dts: Drop custom hwmod property for omap5 mmc
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 wdt
      ARM: OMAP2+: Drop legacy platform data for dra7 wdt
      ARM: OMAP2+: Drop legacy platform data for omap5 wdt
      ARM: OMAP2+: Drop legacy platform data for omap4 mcbsp
      ARM: OMAP2+: Drop legacy platform data for omap5 mcbsp
      ARM: OMAP2+: Drop legacy platform data for am4 hdq1w
      ARM: OMAP2+: Drop legacy platform data for dra7 hdq1w
      ARM: OMAP2+: Drop legacy platform data for omap4 hdq1w
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 rng
      ARM: OMAP2+: Drop legacy platform data for dra7 rng
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 mcasp
      ARM: OMAP2+: Drop legacy platform data for omap4 mcasp
      ARM: OMAP2+: Drop legacy platform data for musb on omap4
      ARM: dts: Probe am335x musb with ti-sysc
      ARM: dts: Drop pointless status changing for am3 musb
      ARM: OMAP2+: Drop legacy platform data for am335x musb
      Merge branch 'omap-for-v5.5/droid4' into omap-for-v5.5/dt
      ARM: dts: Configure omap3 rng
      Merge branch 'rng' into omap-for-v5.5/dt

Torsten Duwe (2):
      arm64: dts: allwinner: a64: enable ANX6345 bridge on Teres-I
      dt-bindings: Add ANX6345 DP/eDP transmitter binding

Vidya Sagar (1):
      arm64: tegra: Assume no CLKREQ presence by default

Walter Schweizer (1):
      ARM: dts: kirkwood: synology: Fix rs5c372 RTC entry

Wen He (2):
      arm64: dts: ls1028a: Update the clock providers for the Mali DP500
      arm64: dts: ls1028a: Update #clock-cells of dpclk node

Yannick Fertré (2):
      ARM: dts: stm32: move ltdc pinctrl on stm32mp157a dk1 board
      ARM: dts: stm32: add focaltech touchscreen on stm32mp157c-dk2 board

Yegor Yefremov (3):
      ARM: dts: add DTS for NetCAN Plus devices
      ARM: dts: add DTS for NetCom Plus 1xx and 2xx device series
      ARM: dts: add DTS for NetCom Plus 4xx and 8xx device series

Yinbo Zhu (1):
      arm64: dts: enable otg mode for dwc3 usb ip on layerscape

Yoshihiro Shimoda (1):
      arm64: dts: renesas: Add iommus to R-Car Gen3 SDHI/MMC nodes

Yuantian Tang (1):
      arm64: dts: lx2160a: add tmu device node


 .../devicetree/bindings/arm/amlogic.yaml        |    9 +-
 .../devicetree/bindings/arm/atmel-at91.yaml     |   14 +
 .../devicetree/bindings/arm/bcm/bcm2835.yaml    |   54 +
 .../bindings/arm/bcm/brcm,bcm2835.txt           |   67 -
 Documentation/devicetree/bindings/arm/cpus.yaml |    1 +
 Documentation/devicetree/bindings/arm/fsl.yaml  |   58 +-
 ...ntroller.txt => ap80x-system-controller.txt} |   14 +-
 .../bindings/arm/marvell/armada-7k-8k.txt       |   24 -
 .../bindings/arm/marvell/armada-7k-8k.yaml      |   61 +
 .../devicetree/bindings/arm/mrvl/mrvl.txt       |   14 -
 .../devicetree/bindings/arm/mrvl/mrvl.yaml      |   35 +
 .../devicetree/bindings/arm/realtek.yaml        |   27 +-
 .../devicetree/bindings/arm/renesas,prr.txt     |   20 -
 .../devicetree/bindings/arm/renesas,prr.yaml    |   35 +
 .../devicetree/bindings/arm/renesas.yaml        |   20 +
 .../devicetree/bindings/arm/rockchip.yaml       |   19 +-
 .../devicetree/bindings/arm/sunxi.yaml          |    5 +
 .../bindings/arm/sunxi/sunxi-mbus.txt           |    1 +
 .../bindings/clock/rockchip,px30-cru.txt        |    5 +
 .../bindings/crypto/allwinner,sun8i-ce.yaml     |   88 +
 .../bindings/{lpddr2 => ddr}/lpddr2-timings.txt |    0
 .../bindings/{lpddr2 => ddr}/lpddr2.txt         |    2 +-
 .../devicetree/bindings/ddr/lpddr3-timings.txt  |   58 +
 .../devicetree/bindings/ddr/lpddr3.txt          |  101 +
 .../bindings/display/bridge/anx6345.yaml        |  102 +
 .../bindings/gpu/arm,mali-midgard.yaml          |    5 +-
 .../bindings/interrupt-controller/mrvl,intc.txt |   14 +-
 .../memory-controllers/exynos5422-dmc.txt       |   84 +
 .../memory-controllers/nvidia,tegra124-mc.yaml  |  152 +
 .../memory-controllers/nvidia,tegra30-emc.yaml  |  336 +
 .../memory-controllers/nvidia,tegra30-mc.txt    |  123 -
 .../memory-controllers/nvidia,tegra30-mc.yaml   |  167 +
 .../devicetree/bindings/phy/phy-mmp3-usb.txt    |   13 +
 .../bindings/power/renesas,rcar-sysc.txt        |    2 +
 .../nvidia,tegra-regulators-coupling.txt        |   65 +
 .../devicetree/bindings/reset/renesas,rst.txt   |    2 +
 .../devicetree/bindings/soc/rockchip/grf.txt    |   18 +-
 .../bindings/timer/mediatek,mtk-timer.txt       |    1 +
 .../devicetree/bindings/timer/renesas,tmu.txt   |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml    |    4 +
 MAINTAINERS                                     |    3 +-
 arch/arm/boot/dts/Makefile                      |   19 +-
 arch/arm/boot/dts/am335x-baltos.dtsi            |   12 -
 arch/arm/boot/dts/am335x-bone-common.dtsi       |   22 -
 arch/arm/boot/dts/am335x-boneblue.dts           |   22 -
 arch/arm/boot/dts/am335x-chiliboard.dts         |   18 -
 arch/arm/boot/dts/am335x-cm-t335.dts            |   20 -
 arch/arm/boot/dts/am335x-evm.dts                |   25 -
 arch/arm/boot/dts/am335x-evmsk.dts              |   25 -
 arch/arm/boot/dts/am335x-guardian.dts           |   22 -
 arch/arm/boot/dts/am335x-igep0033.dtsi          |   25 -
 arch/arm/boot/dts/am335x-lxm.dts                |   22 -
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi    |   17 -
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts  |   22 -
 arch/arm/boot/dts/am335x-netcan-plus-1xx.dts    |   87 +
 arch/arm/boot/dts/am335x-netcom-plus-2xx.dts    |   95 +
 arch/arm/boot/dts/am335x-netcom-plus-8xx.dts    |  115 +
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts     |   22 -
 arch/arm/boot/dts/am335x-pcm-953.dtsi           |   25 -
 arch/arm/boot/dts/am335x-pdu001.dts             |   28 -
 arch/arm/boot/dts/am335x-pepper.dts             |   20 -
 arch/arm/boot/dts/am335x-pocketbeagle.dts       |   22 -
 arch/arm/boot/dts/am335x-regor.dtsi             |   21 -
 arch/arm/boot/dts/am335x-shc.dts                |   17 -
 arch/arm/boot/dts/am335x-sl50.dts               |   22 -
 arch/arm/boot/dts/am335x-wega.dtsi              |   26 -
 arch/arm/boot/dts/am33xx-l4.dtsi                |   27 +-
 arch/arm/boot/dts/am33xx.dtsi                   |   99 +-
 arch/arm/boot/dts/am3517.dtsi                   |    6 +
 arch/arm/boot/dts/am4372.dtsi                   |   33 +-
 arch/arm/boot/dts/am437x-l4.dtsi                |   23 -
 arch/arm/boot/dts/armada-38x.dtsi               |    5 +
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi       |    2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts   |    5 +
 arch/arm/boot/dts/armada-xp.dtsi                |    2 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts        |    2 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts        |  137 +-
 .../dts/aspeed-bmc-arm-stardragon4800-rep2.dts  |    3 +
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts   |   66 +-
 .../boot/dts/aspeed-bmc-facebook-minipack.dts   |   59 +-
 .../boot/dts/aspeed-bmc-facebook-tiogapass.dts  |    3 +
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts  |   65 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts    |  972 +++
 .../arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts |   58 +-
 .../arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts |    3 +
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts  |    3 +
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts   |    3 +
 .../arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts |    3 +
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts    |    3 +
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts     |    3 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts   |    2 +
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts    |    5 +
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts      |    3 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts     | 1195 +++
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts     |    4 +
 .../arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |    7 +-
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts      |    5 +
 .../boot/dts/aspeed-bmc-portwell-neptune.dts    |    6 +
 arch/arm/boot/dts/aspeed-g4.dtsi                |    4 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                |   26 +-
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi        |    9 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                |  587 +-
 .../dts/ast2500-facebook-netbmc-common.dtsi     |   96 +
 arch/arm/boot/dts/at91-kizbox2-2.dts            |   26 +
 arch/arm/boot/dts/at91-kizbox2-common.dtsi      |  258 +
 arch/arm/boot/dts/at91-kizbox2.dts              |  244 -
 arch/arm/boot/dts/at91-kizbox3-hs.dts           |  309 +
 arch/arm/boot/dts/at91-kizbox3_common.dtsi      |  412 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts     |    1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |    6 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts     |    1 +
 arch/arm/boot/dts/atlas7-evb.dts                |    2 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                  |    2 +-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts           |  123 +
 arch/arm/boot/dts/bcm2711.dtsi                  |  844 ++
 arch/arm/boot/dts/bcm2835-common.dtsi           |  194 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |    4 -
 arch/arm/boot/dts/bcm2835.dtsi                  |    1 +
 arch/arm/boot/dts/bcm2836.dtsi                  |    1 +
 arch/arm/boot/dts/bcm2837.dtsi                  |    1 +
 .../boot/dts/bcm283x-rpi-usb-peripheral.dtsi    |    7 +
 arch/arm/boot/dts/bcm283x.dtsi                  |  190 +-
 arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts   |   53 +
 arch/arm/boot/dts/dove.dtsi                     |    2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  |   16 -
 arch/arm/boot/dts/dra7.dtsi                     |   51 +
 arch/arm/boot/dts/e60k02.dtsi                   |  306 +
 arch/arm/boot/dts/emev2.dtsi                    |    4 +
 arch/arm/boot/dts/exynos3250.dtsi               |   13 +-
 arch/arm/boot/dts/exynos4.dtsi                  |   14 +-
 arch/arm/boot/dts/exynos4210.dtsi               |   27 +-
 arch/arm/boot/dts/exynos4412.dtsi               |   25 +-
 arch/arm/boot/dts/exynos5.dtsi                  |    4 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |   27 +-
 arch/arm/boot/dts/exynos5250.dtsi               |   41 +-
 arch/arm/boot/dts/exynos5260.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5410.dtsi               |    6 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |    4 +
 arch/arm/boot/dts/exynos5420.dtsi               |   90 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |  117 +
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts |    4 +
 arch/arm/boot/dts/exynos54xx.dtsi               |   46 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |    4 +
 arch/arm/boot/dts/exynos5800.dtsi               |    2 +-
 arch/arm/boot/dts/imx27.dtsi                    |    2 +-
 arch/arm/boot/dts/imx31.dtsi                    |    2 +-
 arch/arm/boot/dts/imx51.dtsi                    |    2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi         |   44 +-
 arch/arm/boot/dts/imx53-usbarmory.dts           |    2 +-
 arch/arm/boot/dts/imx6dl-apf6dev.dts            |   49 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts    |   39 +
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi      |   28 +-
 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts        |    8 +-
 arch/arm/boot/dts/imx6dl.dtsi                   |    1 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts         |   13 +
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts   |   13 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts        |   13 +
 arch/arm/boot/dts/imx6q-apf6dev.dts             |   49 +-
 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts          |    8 +
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi          |    2 -
 arch/arm/boot/dts/imx6q-gw54xx.dts              |   19 +-
 arch/arm/boot/dts/imx6q.dtsi                    |    3 +
 arch/arm/boot/dts/imx6qdl-apalis.dtsi           |   57 +-
 arch/arm/boot/dts/imx6qdl-apf6.dtsi             |  200 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi          |  424 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi          |   35 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi           |   19 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi              |   19 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi             |   14 +
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi        |   10 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         |    7 +-
 arch/arm/boot/dts/imx6sl.dtsi                   |    2 +-
 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts      |  324 +
 arch/arm/boot/dts/imx6sll.dtsi                  |    2 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |    2 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |   28 +-
 arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi   |  148 +
 .../arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi |  338 +
 arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts    |  405 +-
 arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi |   95 +-
 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts    |   16 +
 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi |   40 +
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi   |  418 +
 .../dts/imx6ul-kontron-n6x1x-som-common.dtsi    |  109 +
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi           |  195 +-
 arch/arm/boot/dts/imx6ul-opos6uldev.dts         |  382 +-
 .../arm/boot/dts/imx6ul-phytec-phycore-som.dtsi |    2 +-
 arch/arm/boot/dts/imx6ul.dtsi                   |    3 +-
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi  |   14 +
 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi  |    2 +-
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi     |    2 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi          |   64 +-
 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts   |   16 +
 .../arm/boot/dts/imx6ull-kontron-n6411-som.dtsi |   40 +
 arch/arm/boot/dts/imx6ull-opos6ul.dtsi          |    6 +
 arch/arm/boot/dts/imx6ull-opos6uldev.dts        |   42 +
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi     |   38 +
 arch/arm/boot/dts/imx7-colibri.dtsi             |   30 +-
 arch/arm/boot/dts/imx7d.dtsi                    |    6 +-
 arch/arm/boot/dts/imx7s.dtsi                    |    2 +-
 arch/arm/boot/dts/imx7ulp-evk.dts               |    2 +
 arch/arm/boot/dts/imx7ulp.dtsi                  |   31 +-
 arch/arm/boot/dts/keystone-clocks.dtsi          |   27 +
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi      |   20 +
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi       |   21 +-
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi      |   20 +-
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi       |   20 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi        |    2 +-
 .../boot/dts/logicpd-torpedo-37xx-devkit-28.dts |   20 +-
 .../boot/dts/logicpd-torpedo-37xx-devkit.dts    |   14 +
 .../arm/boot/dts/logicpd-torpedo-baseboard.dtsi |    1 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi      |    5 +
 arch/arm/boot/dts/mmp3-dell-ariel.dts           |   94 +
 arch/arm/boot/dts/mmp3.dtsi                     |  527 ++
 arch/arm/boot/dts/motorola-mapphone-common.dtsi |  786 ++
 arch/arm/boot/dts/mt6323.dtsi                   |   27 +
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts      |    8 +
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts      |    8 +
 arch/arm/boot/dts/omap3-n900.dts                |    5 +
 arch/arm/boot/dts/omap3.dtsi                    |   25 +
 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi |    2 +-
 arch/arm/boot/dts/omap4-droid-bionic-xt875.dts  |    9 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts        |  777 +-
 arch/arm/boot/dts/omap4-l4-abe.dtsi             |    4 -
 arch/arm/boot/dts/omap4-l4.dtsi                 |   16 +-
 arch/arm/boot/dts/omap4.dtsi                    |   28 +-
 arch/arm/boot/dts/omap5-l4-abe.dtsi             |    3 -
 arch/arm/boot/dts/omap5-l4.dtsi                 |   30 -
 arch/arm/boot/dts/omap5.dtsi                    |   28 +-
 arch/arm/boot/dts/openbmc-flash-layout-128.dtsi |   32 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi             |   12 +
 .../arm/boot/dts/qcom-msm8974-fairphone-fp2.dts |   22 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi             |  103 +
 arch/arm/boot/dts/qcom-pm8941.dtsi              |   10 +
 arch/arm/boot/dts/r8a7790-lager.dts             |    8 +-
 arch/arm/boot/dts/r8a7793-gose.dts              |  110 +-
 arch/arm/boot/dts/rda8810pl.dtsi                |   48 +
 arch/arm/boot/dts/rk3036.dtsi                   |    4 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |    8 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi            |   14 +-
 .../boot/dts/rk3288-veyron-analog-audio.dtsi    |    1 +
 arch/arm/boot/dts/rk3288-veyron-edp.dtsi        |   35 +-
 arch/arm/boot/dts/rk3288-veyron-jaq.dts         |   35 +-
 arch/arm/boot/dts/rk3288-veyron-mickey.dts      |    7 +
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |   35 +-
 arch/arm/boot/dts/rk3288-veyron-tiger.dts       |   35 +-
 arch/arm/boot/dts/rk3288.dtsi                   |    7 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts          |    4 +
 arch/arm/boot/dts/s3c6410-smdk6410.dts          |    4 +
 arch/arm/boot/dts/sama5d2.dtsi                  |    2 +-
 .../arm/boot/dts/socfpga_arria10_socdk_qspi.dts |    2 +-
 arch/arm/boot/dts/stm32429i-eval.dts            |    3 +-
 arch/arm/boot/dts/stm32746g-eval.dts            |    3 +-
 arch/arm/boot/dts/stm32f429-disco.dts           |    2 +-
 arch/arm/boot/dts/stm32f469-disco.dts           |    3 +-
 arch/arm/boot/dts/stm32f469.dtsi                |    1 -
 arch/arm/boot/dts/stm32f746-disco.dts           |    2 +-
 arch/arm/boot/dts/stm32f769-disco.dts           |    2 +-
 arch/arm/boot/dts/stm32h743i-disco.dts          |    2 +-
 arch/arm/boot/dts/stm32h743i-eval.dts           |    2 +-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi       |   28 +
 arch/arm/boot/dts/stm32mp157a-avenger96.dts     |    8 +-
 arch/arm/boot/dts/stm32mp157a-dk1.dts           |   77 +-
 arch/arm/boot/dts/stm32mp157c-dk2.dts           |   21 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts           |   41 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts           |    3 -
 arch/arm/boot/dts/stm32mp157c.dtsi              |   23 +
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |    2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                |    1 -
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts       |   16 +
 arch/arm/boot/dts/sun8i-a83t.dtsi               |    9 +
 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts      |  174 +
 arch/arm/boot/dts/sun8i-h3.dtsi                 |   22 +
 arch/arm/boot/dts/sun8i-r40.dtsi                |    9 +
 arch/arm/boot/dts/sun9i-a80.dtsi                |   11 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi              |   14 +
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi    | 7917 ++++++++++++++----
 arch/arm/boot/dts/tegra124-venice2.dts          |    3 +
 arch/arm/boot/dts/tegra124.dtsi                 |    3 +-
 .../arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi |  201 +
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi          |  302 +
 arch/arm/boot/dts/tegra20-paz00.dts             |   41 +-
 arch/arm/boot/dts/tegra20-trimslice.dts         |   11 +
 arch/arm/boot/dts/tegra20.dtsi                  |    2 +
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi      |   22 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi           |   22 +-
 arch/arm/boot/dts/tegra30-cardhu-a04.dts        |   48 +
 arch/arm/boot/dts/tegra30-colibri.dtsi          |   22 +-
 .../arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi |  801 ++
 arch/arm/boot/dts/tegra30-cpu-opp.dtsi          | 1202 +++
 arch/arm/boot/dts/tegra30.dtsi                  |   14 +
 arch/arm/boot/dts/vf-colibri.dtsi               |   12 +-
 arch/arm/boot/dts/vf500-colibri.dtsi            |    2 +-
 arch/arm/boot/dts/vf610-bk4.dts                 |    4 +
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts        |   12 -
 arch/arm/configs/keystone_defconfig             |    1 +
 .../omap_hwmod_33xx_43xx_common_data.h          |    9 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c    |   32 -
 .../omap_hwmod_33xx_43xx_ipblock_data.c         |  231 -
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c      |   58 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c      |   48 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      |  343 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c      |  317 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |  431 -
 .../boot/dts/actions/s900-bubblegum-96.dts      |   62 +
 arch/arm64/boot/dts/actions/s900.dtsi           |   45 +
 .../dts/allwinner/sun50i-a64-orangepi-win.dts   |   29 +
 .../allwinner/sun50i-a64-sopine-baseboard.dts   |   25 +
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts   |   45 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |   18 +
 .../allwinner/sun50i-h5-emlid-neutis-n5.dtsi    |   13 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi    |    9 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts     |    6 +
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts |   33 +
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi  |    6 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   |    6 +
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts  |    4 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |   66 +-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts |    4 +-
 arch/arm64/boot/dts/amlogic/Makefile            |    2 +
 arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts  |   30 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi       |  130 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi      |   13 +-
 .../boot/dts/amlogic/meson-g12-common.dtsi      |  422 +-
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi      |  392 +
 .../boot/dts/amlogic/meson-g12a-sei510.dts      |    3 +
 .../boot/dts/amlogic/meson-g12a-x96-max.dts     |    3 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     |   33 +-
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts   |    2 +-
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts   |  557 ++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi     |   26 +-
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi    |    3 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi       |   10 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts   |    3 +
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts |    3 +
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts    |   73 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi |    3 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   |    4 +
 .../boot/dts/amlogic/meson-gxbb-wetek.dtsi      |    3 +
 .../amlogic/meson-gxl-s805x-libretech-ac.dts    |    2 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts   |    3 +
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts  |    7 +-
 .../amlogic/meson-gxl-s905x-libretech-cc.dts    |    5 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts |    3 +
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi  |    3 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi      |   10 +
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts  |    6 +
 .../boot/dts/amlogic/meson-gxm-rbox-pro.dts     |    3 +
 .../boot/dts/amlogic/meson-gxm-vega-s96.dts     |    4 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi      |    6 +-
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi     |    3 +
 .../arm64/boot/dts/amlogic/meson-sm1-sei610.dts |  208 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi      |  340 +
 arch/arm64/boot/dts/arm/juno-base.dtsi          |   27 +
 arch/arm64/boot/dts/broadcom/Makefile           |    3 +-
 .../arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts |    2 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |  168 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   28 +-
 arch/arm64/boot/dts/freescale/Makefile          |    4 +
 .../boot/dts/freescale/fsl-ls1028a-qds.dts      |    2 -
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts      |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi  |   83 +-
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts      |    4 +
 .../boot/dts/freescale/fsl-ls1088a-rdb.dts      |    1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi  |  110 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts    |  151 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi       |   15 +-
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts      |  231 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts    |   30 +
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi   |  249 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi       |   40 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts    |   65 +-
 .../dts/freescale/imx8mq-hummingboard-pulse.dts |    2 +
 .../dts/freescale/imx8mq-librem5-devkit.dts     |    4 +
 .../boot/dts/freescale/imx8mq-nitrogen.dts      |    2 +
 .../arm64/boot/dts/freescale/imx8mq-pico-pi.dts |    4 +
 .../arm64/boot/dts/freescale/imx8mq-sr-som.dtsi |    2 +
 .../boot/dts/freescale/imx8mq-zii-ultra.dtsi    |   40 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       |   17 +-
 arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts |    4 +
 .../dts/freescale/imx8qxp-colibri-eval-v3.dts   |   15 +
 .../dts/freescale/imx8qxp-colibri-eval-v3.dtsi  |   62 +
 .../boot/dts/freescale/imx8qxp-colibri.dtsi     |  598 ++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts   |    8 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |   13 +-
 arch/arm64/boot/dts/freescale/s32v234-evb.dts   |   25 +
 arch/arm64/boot/dts/freescale/s32v234.dtsi      |  139 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |   38 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi   |   32 +
 .../boot/dts/intel/socfpga_agilex_socdk.dts     |   58 +
 arch/arm64/boot/dts/lg/lg1312.dtsi              |    2 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi              |    2 +-
 arch/arm64/boot/dts/marvell/Makefile            |    3 +
 .../marvell/armada-3720-espressobin-emmc.dts    |   42 +
 .../marvell/armada-3720-espressobin-v7-emmc.dts |   59 +
 .../dts/marvell/armada-3720-espressobin-v7.dts  |   36 +
 .../dts/marvell/armada-3720-espressobin.dts     |  184 +-
 .../dts/marvell/armada-3720-espressobin.dtsi    |  177 +
 .../boot/dts/marvell/armada-3720-turris-mox.dts |    8 +
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi    |   28 +-
 .../boot/dts/marvell/armada-8040-mcbin.dtsi     |    3 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi    |   56 +-
 .../boot/dts/marvell/armada-ap806-dual.dtsi     |   23 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi     |   42 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi   |  456 +-
 .../boot/dts/marvell/armada-ap807-quad.dtsi     |   93 +
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi   |   29 +
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi   |  444 +
 arch/arm64/boot/dts/marvell/armada-common.dtsi  |    4 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi   |  575 +-
 arch/arm64/boot/dts/marvell/armada-cp115.dtsi   |   12 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi   |  568 ++
 arch/arm64/boot/dts/marvell/cn9130-db.dts       |  403 +
 arch/arm64/boot/dts/marvell/cn9130.dtsi         |   37 +
 arch/arm64/boot/dts/marvell/cn9131-db.dts       |  202 +
 arch/arm64/boot/dts/marvell/cn9132-db.dts       |  221 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi        |    9 +
 .../boot/dts/nvidia/tegra186-p2771-0000.dts     |   12 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi        |    4 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi  |   36 +-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts     |   33 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |  171 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi  |    7 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi  |    2 +-
 .../boot/dts/nvidia/tegra210-p3450-0000.dts     |   35 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi        |   25 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi    |    2 +
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts   |   55 +
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi  |   80 +
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts   |    6 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |    4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |    4 +
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi |   54 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi       |   82 +
 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi      |   13 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi           |   84 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi            |   41 +
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi      |   53 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts      |   12 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |   12 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts   |   14 +
 arch/arm64/boot/dts/realtek/Makefile            |    5 +
 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts  |   30 +
 arch/arm64/boot/dts/realtek/rtd1293.dtsi        |   51 +
 .../boot/dts/realtek/rtd1295-zidoo-x9s.dts      |    3 +-
 arch/arm64/boot/dts/realtek/rtd1295.dtsi        |    3 +-
 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts   |   30 +
 arch/arm64/boot/dts/realtek/rtd1296.dtsi        |   65 +
 arch/arm64/boot/dts/realtek/rtd129x.dtsi        |   50 +-
 arch/arm64/boot/dts/renesas/Makefile            |    6 +
 arch/arm64/boot/dts/renesas/hihope-common.dtsi  |   28 +-
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi |   51 +-
 .../dts/renesas/r8a774a1-hihope-rzg2m-ex.dts    |    4 +
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m.dts  |   11 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi       |   13 +-
 .../dts/renesas/r8a774b1-hihope-rzg2n-ex.dts    |   15 +
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n.dts  |   41 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi       | 2627 ++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi       |   20 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi    |    2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        |   73 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        |   65 +-
 .../boot/dts/renesas/r8a77961-salvator-xs.dts   |   31 +
 arch/arm64/boot/dts/renesas/r8a77961.dtsi       |  723 ++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       |   35 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi       |    5 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       |    3 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |   24 +
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       |   22 +
 .../rzg2-advantech-idk-1110wr-panel.dtsi        |   41 +
 arch/arm64/boot/dts/rockchip/Makefile           |    4 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts       |  321 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi          |  157 +-
 arch/arm64/boot/dts/rockchip/rk3308-evb.dts     |  230 +
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts  |  188 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi        | 1739 ++++
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts      |  359 +
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts  |    1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        |   32 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts |   10 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi   |   10 +
 .../arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi |   14 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi   |    5 +
 .../dts/rockchip/rk3399-roc-pc-mezzanine.dts    |   72 +
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts  |  670 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi |  767 ++
 .../boot/dts/rockchip/rk3399-rock-pi-4.dts      |   18 +-
 .../boot/dts/rockchip/rk3399-rockpro64.dts      |   28 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |    1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |  108 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |   59 +
 .../boot/dts/ti/k3-j721e-common-proc-board.dts  |  162 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       |  218 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi            |    2 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi          |   29 +
 drivers/soc/qcom/qcom_aoss.c                    |    8 +-
 include/dt-bindings/pinctrl/rockchip.h          |    8 +-
 include/dt-bindings/reset/realtek,rtd1295.h     |  111 +
 498 files changed, 37590 insertions(+), 10500 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
 rename Documentation/devicetree/bindings/arm/marvell/{ap806-system-controller.txt => ap80x-system-controller.txt} (91%)
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
 create mode 100644 arch/arm/boot/dts/am335x-netcan-plus-1xx.dts
 create mode 100644 arch/arm/boot/dts/am335x-netcom-plus-2xx.dts
 create mode 100644 arch/arm/boot/dts/am335x-netcom-plus-8xx.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
 create mode 100644 arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-common.dtsi
 delete mode 100644 arch/arm/boot/dts/at91-kizbox2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox3-hs.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox3_common.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2711.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2835-common.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
 create mode 100644 arch/arm/boot/dts/e60k02.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-opos6ul.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-opos6uldev.dts
 create mode 100644 arch/arm/boot/dts/mmp3-dell-ariel.dts
 create mode 100644 arch/arm/boot/dts/mmp3.dtsi
 create mode 100644 arch/arm/boot/dts/motorola-mapphone-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-droid-bionic-xt875.dts
 create mode 100644 arch/arm/boot/dts/openbmc-flash-layout-128.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
 create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-cpu-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-a1.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32v234-evb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32v234.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap807.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp115.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1293.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77961-salvator-xs.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77961.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2-advantech-idk-1110wr-panel.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-a1.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
 create mode 100644 include/dt-bindings/reset/realtek,rtd1295.h
