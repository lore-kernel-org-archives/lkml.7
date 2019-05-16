Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE2C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F302166E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Tzxd9Fb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEPGnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 02:43:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42286 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfEPGnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 02:43:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id 145so1042976pgg.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPpSkhHoBou4kaD+9koKwzOH+9Z9DK3AP55tDCDHm3Q=;
        b=Tzxd9Fb/2xqOd1fAxeKayn4yNbesUWVDLNAMS74X0zLJW61tVGYPXiEunL74LijbLR
         rXWFWxSVtHtsQqpJoZB0u16/17lWG+50wE4zo4YKrhwx+wIJqg5gNipWIDOyxY2bZdB2
         Okrx5YMrZ5gO0PMdFdZiVae16AuZPzC+V+NrFaOVEbDfmJHqMBPsA1CXC81xpf7eDnDF
         8OOFxzpH4We6LwVsd39jQoDOghqIKFsPx5KdAwVKMQ0eWoiluYbC6kWsVc9Kc+6CCeis
         v97u1ivnDSTxH51P+MJU51LjR7znB2JmU9YjmIRARsLkt9/1kNgqLpfUiVjXjisPcd7z
         OEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPpSkhHoBou4kaD+9koKwzOH+9Z9DK3AP55tDCDHm3Q=;
        b=eDbaeQCZ8DGiBW4nt0K/f5lopk7M6Tf1+ie9iBcJHrMk+Ngo43odObFx2BVkKHBWmk
         JSfXI7x6tqDk6odekIpAlHdaHfTkgEXNhHRjmGxhRCco9PnSIhVaZjITipc/ClJoqMqf
         qypvTzqHzwTXpeUE68V9GUOQZQN1DOzgq5knX1i0Q8r6dVPqdnbCWJThR7cxJV7RFt4P
         WJd63CyrwECZif22/KkUzIJPNhB0TErj8bxYjTALOFZaGbVMzX+IpVVDQ+64TKQ3TzcN
         Ejny0+FrHU5fBcKrw/K0qhkqB0Gjth8Z5CHMPFpS0s8knUAd1uqh+s3bBiq6ofHU4qqz
         7Zaw==
X-Gm-Message-State: APjAAAXB/f1RVK+dyEtepUEOAheVPy9RWscaGQEflvnMyzY9fj5UKJR7
        /7/EKe4AoRzxQ/oPbjYbJgUkMA==
X-Google-Smtp-Source: APXvYqxyo/zB0p64q8sSyEI9kMbqzICLldQIE3jBePW6KzvReZ+oIi2No8yjoZxfd/b20QG1OEmYmg==
X-Received: by 2002:a62:aa15:: with SMTP id e21mr52302921pff.140.1557989010826;
        Wed, 15 May 2019 23:43:30 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id w194sm11196050pfd.56.2019.05.15.23.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 23:43:29 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/4] ARM: Device-tree updates
Date:   Wed, 15 May 2019 23:43:02 -0700
Message-Id: <20190516064304.24057-3-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190516064304.24057-1-olof@lixom.net>
References: <20190516064304.24057-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides new bindings and additional descriptions of hardware blocks for
various SoCs and boards, the main new contents here is:

SoCs:
- Intel Agilex (SoCFPGA)
- NXP i.MX8MM (Quad Cortex-A53 with media/graphics focus)

New boards:
- Allwinner:
+ RerVision H3-DVK (H3)
+ Oceanic 5205 5inMFD (H6)
+ Beelink GS2 (H6)
+ Orange Pi 3 (H6)
- Rockchip:
+ Orange Pi RK3399
+ Nanopi NEO4
+ Veyron-Mighty Chromebook variant
- Amlogic:
+ SEI Robotics SEI510
- ST Micro:
+ stm32mp157a discovery1
+ stm32mp157c discovery2
- NXP:
+ Eckelmann ci4x10 (i.MX6DL)
+ i.MX8MM EVK (i.MX8MM)
+ ZII i.MX7 RPU2 (i.MX7)
+ ZII SPB4 (VF610)
+ Zii Ultra (i.MX8M)
+ TQ TQMa7S (i.MX7Solo)
+ TQ TQMa7D (i.MX7Dual)
+ Kobo Aura (i.MX50)
+ Menlosystems M53 (i.MX53)j
- Nvidia:
+ Jetson Nano (Tegra T210)


Conflicts:

Documentation/devicetree/bindings/vendor-prefixes.txt:
 - Add/add conflict, keep both.

----------------------------------------------------------------

The following changes since commit 965fea54c865948fe748fc9eaea8ba5023520161:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

for you to fetch changes up to 6cbc4d88ad208d6f5b9567bac2fff038e1bbfa77:

  Merge tag 'bitmain-soc-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/linux-bitmain into arm/dt

----------------------------------------------------------------

Abel Vesa (3):
      arm64: dts: imx8mq: Add the clocks and the latencies for the A53 cores
      arm64: dts: imx8mq: Add the buck vdd_arm regulator
      arm64: dts: imx8mq: Add the opp table and cores opp properties

Adam Ford (3):
      ARM: dts: imx6qdl: Enable fsl,sec-v4.0-pwrkey
      ARM: dts: imx6q-logicpd: Enable Analog audio capture
      ARM: dts: imx6q-logicpd: Shutdown LCD regulator during suspend

Alexander Kurz (3):
      ARM: dts: i.MX50: Add i2c, mmc and spi aliases
      ARM: dts: i.MX6SL: Add i2c and mmc aliases
      ARM: dts: i.MX35: Add i2c and mmc aliases

Alexandre Belloni (4):
      ARM: dts: sama5d{2,4}: use SPDX-License-Identifier
      ARM: dts: at91sam9xe: use SPDX-License-Identifier
      ARM: dts: atmel boards: use SPDX-License-Identifier
      ARM: dts: at91-vinco: use SPDX-License-Identifier

Alexandre Torgue (2):
      ARM: dts: stm32: add initial support of stm32mp157a-dk1 board
      ARM: dts: stm32: add initial support of stm32mp157c-dk2 board

Alexis Ballier (4):
      arm64: dts: rockchip: Add support for the Orange Pi RK3399 board.
      arm64: dts: rockchip: Fix clock names and add missing supplies for bluetooth on rk3399-orangepi
      arm64: dts: rockchip: Specify vid supply for the rk3399-orangepi compass (AK09911)
      arm64: dts: rockchip: Add the fusb typec manager to rk3399-orangepi

Alison Wang (2):
      arm64: dts: ls1028a: Add Audio DT nodes
      arm64: dts: ls1028a: Add pmu dt nodes

Amit Kucheria (17):
      dt-bindings: iio: adc: Add binding for ADC on pms405 PMIC
      arm64: dts: msm8998: thermal: split address space into two
      arm64: dts: msm8998: efficiency is not valid property
      arm64: dts: msm8916: thermal: Add sensor for modem
      arm64: dts: msm8996: thermal: Add temperature sensors near major peripherals
      arm64: dts: msm8998: thermal: Fix the cpu sensor numbers
      arm64: dts: msm8998: thermal: Fix the gpu sensor number
      arm64: dts: msm8998: thermal: GPU has two sensors, add the second
      arm64: dts: msm8998: thermal: Add temperature sensors near major peripherals
      arm64: dts: sdm845: thermal: Add temperature sensors near major peripherals
      arm64: dts: msm8998: thermal: Make trip names consistent
      arm64: dts: msm8916: thermal: Make trip names consistent
      arm64: dts: msm8996: thermal: Make trip names consistent
      arm64: dts: msm8916: thermal: Convert camera trip type to hot
      arm64: dts: msm8998-mtp: thermal: Remove skin and battery thermal zones
      arm64: dts: msm8998: thermal: Fix number of supported sensors
      arm64: dts: msm8998: thermal: Restrict thermal zone name length to under 20

Andreas Kemnade (1):
      ARM: dts: sun8i: h3: bluetooth for Banana Pi M2 Zero board

Andrew F. Davis (5):
      ARM: dts: am43xx-epos-evm: Add matrix keypad as wakeup source
      ARM: dts: omap2420-n810: Use new CODEC reset pin name
      ARM: dts: mx6qdl-zii-rdu2: Use new CODEC reset pin name
      ARM: dts: imx6qdl-gw5903: Use new CODEC reset pin name
      ARM: dts: imx6qdl-var-dart: Use new CODEC reset pin name

Andrey Smirnov (26):
      dt-bindings: arm: fsl: Add supported ZII VF610 boards to DT schema
      dt-bindings: arm: fsl: Add support for ZII VF610 SPB4
      ARM: dts: vf610: Add ZII SPB4 board
      ARM: dts: vf610-zii-cfu1: Disable NOR flash/SPI controller
      ARM: dts: imx7d: Specify viewport count for PCIE block
      ARM: dts: imx6qdl: Specify viewport count for PCIE block
      ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock to SDMA
      ARM: dts: imx6sx: Specify IMX6SX_CLK_IPG as "ipg" clock to SDMA
      ARM: dts: imx7d: Specify IMX7D_CLK_IPG as "ipg" clock to SDMA
      ARM: dts: imx6ul: Specify IMX6UL_CLK_IPG as "ipg" clock to SDMA
      ARM: dts: imx6sll: Specify IMX6SLL_CLK_IPG as "ipg" clock to SDMA
      ARM: dts: imx6sx: Specify IMX6SX_CLK_IPG as "ahb" clock to SDMA
      ARM: dts: imx53: Specify IMX5_CLK_IPG as "ahb" clock to SDMA
      ARM: dts: imx51: Specify IMX5_CLK_IPG as "ahb" clock to SDMA
      ARM: dts: imx50: Specify IMX5_CLK_IPG as "ahb" clock to SDMA
      arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
      arm64: dts: imx8mq: Add a node for SRC IP block
      arm64: dts: imx8mq: Combine PCIE power domains
      arm64: dts: imx8mq: Add nodes for PCIe IP blocks
      arm64: dts: imx8mq-evk: Enable PCIE0 interface
      dt-bindings: arm: fsl: Add support for ZII i.MX7 RPU2 board
      ARM: dts: Add support for ZII i.MX7 RPU2 board
      ARM: dts: vf610-zii-dev: Mark i2c0 SCL as GPIO_OPEN_DRAIN
      ARM: dts: vf610-zii-dev-rev-b: Specify CS as GPIO_ACTIVE_LOW in spi0
      ARM: dts: imx7s: Specify #io-channel-cells in ADC nodes
      dt-bindings: iio: imx7d-adc: Add #io-channel-cells to required

Andrzej Hajda (2):
      arm64: dts: exynos: configure GSCALER related clocks on TM2
      arm64: dts: exynos: add DSD/GSD clocks to DECONs and GSCALERs of Exynos5433

Andy Gross (1):
      Merge branch 'arm64-thermal-for-5.2' into arm64-for-5.2

Angus Ainslie (Purism) (3):
      arm64: dts: imx8mq: enable the multi sensor TMU
      arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma compatible string
      arm64: dts: imx8mq: Change ahb clock for imx8mq

Anson Huang (14):
      arm64: dts: imx8qxp: add cpu opp table
      dt-bindings: firmware: imx-scu: remove unused resources from scu resource table
      dt-bindings: firmware: imx-scu: add new resources to scu resource table
      arm64: dts: imx8mq: add clock for GPIO node
      ARM: dts: imx7ulp: add mmdc support
      ARM: dts: imx: make MMDC node name generic
      ARM: dts: imx6qdl: Improve mmdc1 node
      dt-bindings: memory-controllers: freescale: add MMDC binding doc
      ARM: dts: imx7ulp: add ocotp support
      arm64: dts: imx8qxp: add system controller watchdog support
      ARM: dts: imx6sll: add cooling-cells for cpu-freq cooling device
      ARM: dts: imx6dl-sabreauto: update opp table for auto part
      dt-bindings: fsl: scu: add general interrupt support
      arm64: dts: imx8qxp: enable scu general irq channel

Archit Taneja (3):
      arm64: dts: msm8996: Add display smmu node
      arm64: qcom: msm8996.dtsi: Add Display nodes
      arm64: dts: apq8096-db820c: Add HDMI display support

Benjamin Drung (1):
      ARM: dts: exynos: Fix spelling mistake of EXYNOS5420

Biju Das (8):
      arm64: dts: renesas: r8a774c0-cat874: add RTC support
      dt-bindings: Add vendor prefix for Silicon Linux.
      ARM: dts: r8a77470: Add USB PHY DT support
      ARM: dts: iwg23s-sbc: Enable USB Phy[01]
      ARM: dts: r8a77470: Add USB2.0 Host (EHCI/OHCI) device
      ARM: dts: iwg23s-sbc: Enable USB USB2.0 Host
      ARM: dts: r8a77470: Add HSUSB device nodes
      ARM: dts: iwg23s-sbc: Enable HS-USB

Bjorn Andersson (6):
      arm64: dts: qcom: qcs404: Fix regulator supply names
      arm64: dts: qcom: qcs404: Fix voltages l3
      arm64: dts: qcom: qcs404-evb: Enable uart3 and add Bluetooth
      arm64: dts: qcom: sdm845: Update reserved memory map
      arm64: dts: qcom: sdm845: Define rmtfs memory
      arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes

Boris Brezillon (1):
      ARM: dts: at91: sama5d2_xplained: Add proper regulator states for suspend-to-mem

Brian Masney (8):
      ARM: dts: qcom: apq8064: add gpio-ranges
      ARM: dts: qcom: mdm9615: add gpio-ranges
      ARM: dts: qcom: msm8660: add gpio-ranges
      ARM: dts: qcom: pma8084: add gpio-ranges
      arm64: dts: qcom: pm8005: add gpio-ranges
      arm64: dts: qcom: pm8998: add gpio-ranges
      arm64: dts: qcom: pmi8994: add gpio-ranges
      arm64: dts: qcom: pmi8998: add gpio-ranges

Bruno Thomsen (6):
      dt-bindings: add vendor prefix for TQ Systems GmbH
      dt-bindings: arm: add TQ boards
      ARM: dts: tq imx7 common board support
      ARM: dts: tq imx7s board support
      ARM: dts: tq imx7d board support
      ARM: dts: bugfix tqma7 soft reset issue

Cao Van Dong (6):
      arm64: dts: renesas: r8a7795: Add CMT device nodes
      arm64: dts: renesas: r8a77965: Add CMT device nodes
      arm64: dts: renesas: r8a77990: Add CMT device nodes
      ARM: dts: r8a77470: Add HSCIF support
      ARM: dts: r8a77470: Add PWM support
      ARM: dts: r8a77470: Add VIN support

Carlo Caione (1):
      arm64: dts: imx8mq: Add on-chip OTP controller node

Chen-Yu Tsai (3):
      ARM: dts: sunxi: h3/h5: Add device node for SID
      ARM: dts: sun8i: a83t: Add I2C2 pinmux setting for PE pins
      ARM: dts: sun8i: a83t: Enable USB OTG controller on some boards

Chris Packham (1):
      ARM: dts: armada-38x: add interrupts for watchdog

Christian Hewitt (1):
      arm64: dts: meson-gxm: Add Mali-T820 node

Christian Lamparter (1):
      ARM: dts: qcom: ipq4019: enlarge PCIe BAR range

Christina Quast (38):
      ARM: dts: am33xx: Added macros for numeric pinmux addresses
      ARM: dts: am33xx: Added AM33XX_PADCONF macro
      ARM: dts: am335x: bone-common: Replaced register offsets with defines
      ARM: dts: am335x: boneblack-common: Replaced register offsets with defines
      ARM: dts: am335x: boneblack-wireless: Replaced register offsets with defines
      ARM: dts: am335x: pocketbeagle: Replaced register offsets with defines
      ARM: dts: am335x: baltos-ir2110: Replaced register offsets with defines
      ARM: dts: am335x: baltos-ir3220: Replaced register offsets with defines
      ARM: dts: am335x: baltos-ir5221: Replaced register offsets with defines
      ARM: dts: am335x: baltos-leds: Replaced register offsets with defines
      ARM: dts: am335x: baltos: Replaced register offsets with defines
      ARM: dts: am335x: base0033: Replaced register offsets with defines
      ARM: dts: am335x: bonegreen-wireless: Replaced register offsets with defines
      ARM: dts: am335x: boneblue: Replaced register offsets with defines
      ARM: dts: am335x: bonegreen-common: Replaced register offsets with defines
      ARM: dts: am335x: chiliboard: Replaced register offsets with defines
      ARM: dts: am335x: chilisom: Replaced register offsets with defines
      ARM: dts: am335x: cm-t335: Replaced register offsets with defines
      ARM: dts: am335x: evm: Replaced register offsets with defines
      ARM: dts: am335x: evmsk: Replaced register offsets with defines
      ARM: dts: am335x: icev2: Replaced register offsets with defines
      ARM: dts: am335x: igep0033: Replaced register offsets with defines
      ARM: dts: am335x: lxm: Replaced register offsets with defines
      ARM: dts: am335x: moxa-uc-2100-common: Replaced register offsets with defines
      ARM: dts: am335x: moxa-uc-2101: Replaced register offsets with defines
      ARM: dts: am335x: moxa-uc-8100-me-t: Replaced register offsets with defines
      ARM: dts: am335x: nano: Replaced register offsets with defines
      ARM: dts: am335x: osd3358-sm-red: Replaced register offsets with defines
      ARM: dts: am335x: osd335x-common: Replaced register offsets with defines
      ARM: dts: am335x: pcm-953: Replaced register offsets with defines
      ARM: dts: am335x: pdu001: Replaced register offsets with defines
      ARM: dts: am335x: pepper: Replaced register offsets with defines
      ARM: dts: am335x: phycore-som: Replaced register offsets with defines
      ARM: dts: am335x: sancloud-bbe: Replaced register offsets with defines
      ARM: dts: am335x: sbc-t335: Replaced register offsets with defines
      ARM: dts: am335x: shc: Replaced register offsets with defines
      ARM: dts: am335x: sl50: Replaced register offsets with defines
      ARM: dts: am335x: wega: Replaced register offsets with defines

Christoph Muellner (3):
      arm64: dts: rockchip: Disable DCMDs on RK3399's eMMC controller.
      arm64: dts: rockchip: Define drive-impedance-ohm for RK3399's emmc-phy.
      arm64: dts: rockchip: Decrease emmc-phy's drive impedance on rk3399-puma

Chuanhong Guo (1):
      arm64: dts: meson-gxl-s905d-phicomm-n1: add status LED

Clément Péron (4):
      arm64: dts: allwinner: h6: move MMC pinctrl to dtsi
      dt-bindings: vendor-prefixes: add AZW
      arm64: dts: allwinner: h6: Introduce Beelink GS1 board
      dt-bindings: arm: sunxi: Add Beelink GS1 board

Daniel Baluta (5):
      arm64: dts: imx8mq: Add SDMA nodes
      arm64: dts: imx8mq: Add SAI2 node
      arm64: dts: imx8mq-evk: Enable audio codec wm8524
      bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma compatbile string
      arm64: dts: imx8qxp: Add lpuart1/lpuart2/lpuart3 nodes

David Summers (1):
      ARM: dts: rockchip: Enable WiFi on rk3288-tinker

Dinh Nguyen (4):
      ARM: dts: socfpga: enable MMC highspeed support
      arm64: dts: stratix10: enable MMC highspeed support
      arm64: dts: stratix10: increase QSPI max frequency to 100MHz
      arm64: dts: agilex: Add initial support for Intel's Agilex SoCFPGA

Dmitry Osipenko (1):
      ARM: tegra: Add ACTMON support on Tegra30

Douglas Anderson (10):
      ARM: dts: rockchip: Fix gic/efuse sort ordering for rk3288
      dt-bindings: ARM: dts: rockchip: Add rk3288-veyron-jerry rev 10-15
      ARM: dts: rockchip: Add rk3288-veyron-jerry rev 10-15
      ARM: dts: rockchip: Add dvs-gpios to rk3288-veyron-jerry
      ARM: dts: rockchip: Add vdd_logic to rk3288-veyron
      dt-bindings: ARM: dts: rockchip: Add bindings for rk3288-veyron-mighty
      ARM: dts: rockchip: Add device tree for rk3288-veyron-mighty
      ARM: dts: rockchip: Add DDR retention/poweroff to rk3288-veyron hogs
      ARM: dts: rockchip: vcc33_ccd off in suspend for rk3288-veyron-chromebook
      ARM: dts: rockchip: vdd_gpu off in suspend for rk3288-veyron

Eddie James (2):
      ARM: dts: aspeed: witherspoon: Enable vhub
      ARM: dts: aspeed-g5: Add video engine

Edward A. James (1):
      ARM: dts: aspeed: witherspoon: Update BMC partitioning

Erin Lo (1):
      dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183

Evan Green (1):
      arm64: dts: sdm845: Add UFS PHY reset

Ezequiel Garcia (2):
      arm64: dts: rockchip: enable mali on Rock Pi 4
      arm64: dts: rockchip: enable mali on rock960 boards

Fabien Dessenne (3):
      ARM: dts: stm32: add IPCC mailbox support on STM32MP157c
      ARM: dts: stm32: enable IPCC mailbox support on STM32MP157c-ed1
      ARM: dts: stm32: enable IPCC mailbox support on STM32MP157a-dk1

Fabien Parent (4):
      dt-bindings: wdog: mtk-wdt: add support for MT851
      dt-bindings: timer: mtk-timer: add support for MT8516
      dt-bindings: serial: mtk-uart: add support for MT8516
      dt-bindings: irq: mtk,sysirq: add support for MT8516

Fabio Estevam (7):
      ARM: dts: vf610-zii: Disable SNVS RTC
      ARM: dts: vf610-zii-ssmb-spu3: Disable watchdog
      ARM: dts: vf610-zii: Remove 'max-brightness' property
      arm64: dts: imx8mq: Move the opp table out of bus node
      arm64: dts: imx8mq: Move thermal-zones out of bus node
      ARM: dts: imx: Switch Zii dts to SPDX identifier
      ARM: dts: imx: Use generic node names for Zii dts

Fabrice Gasnier (3):
      ARM: dts: stm32: Add clock on stm32mp157c syscfg
      ARM: dts: stm32: Add romem and temperature calibration on stm32mp157c
      ARM: dts: stm32: Add romem and temperature calibration on stm32f429

Fabrizio Castro (10):
      arm64: dts: renesas: r8a774c0: Fix cpu nodes style
      arm64: dts: renesas: cat875: Add CAN support
      arm64: dts: renesas: r8a774c0-cat874: Add LEDs support
      arm64: dts: renesas: r8a774c0-cat874: Add RWDT support
      arm64: dts: renesas: r8a774a1: Add clkp2 clock to CAN nodes
      arm64: dts: renesas: r8a774c0: Add CANFD support
      arm64: dts: renesas: r8a774c0: Add clkp2 clock to CAN nodes
      ARM: dts: r8a77470: Add DU support
      ARM: dts: iwg23s-sbc: Add HDMI support
      arm64: dts: renesas: cat874: Add USB-HOST support

Frieder Schrempf (2):
      ARM: dts: ls1021a: Remove unused properties from QSPI node
      arm64: dts: fsl: Remove unused properties from FSL QSPI nodes

Gabriel Fernandez (1):
      ARM: dts: stm32: Enable STM32F769 clock driver

Geert Uytterhoeven (6):
      arm64: dts: renesas: r8a77990: ebisu: Add GPIO expander
      arm64: dts: renesas: r8a77990: Fix SPDX license identifier style
      dt-bindings: power: r8a77965: Remove non-existent A3IR power domain
      ARM: dts: ape6evm: Add NOR FLASH
      ARM: dts: rskrza1: Add I2C support
      ARM: dts: rskrza1: Add remaining LEDs

Georgi Djakov (1):
      arm64: dts: sdm845: Include the interconnect resources DT header

Guillaume La Roque (1):
      arm64: dts: meson-g12a-x96-max: add regulators

Harald Geyer (1):
      arm64: dts: allwinner: a64: teres-i: enable backlight

Harini Katakam (1):
      arm64: zynqmp: dt: Add TI PHY quirk

Heiko Stuebner (2):
      arm64: dts: rockchip: bulk convert gpios to their constant counterparts
      ARM: dts: rockchip: bulk convert gpios to their constant counterparts

Horia Geantă (1):
      arm64: dts: ls1043a: add crypto node alias also for qds

Igor Opaniuk (1):
      ARM: tegra: Convert to SPDX license tags for Tegra124 Apalis

Jacky Bai (3):
      dt-bindings: arm: imx: Add the soc binding for imx8mm
      arm64: dts: imx: Add i.mx8mm dtsi support
      arm64: dts: imx: Add i.mx8mm evk basic dts support

Jacopo Mondi (1):
      arm64: dts: renesas: r8a77980: Add "renesas,id" to VIN

Jagan Teki (8):
      arm64: dts: allwinner: a64-amarula-relic: Add STLM75 sensor
      dt-bindings: Add vendor prefix for oceanic
      arm64: allwinner: a64: Add Oceanic 5205 5inMFD initial support
      arm64: dts: rockchip: Add Nanopi NEO4 initial support
      arm64: dts: rockchip: Rename vcc_sys into vcc5v0_sys on rk3399-rock960
      arm64: dts: rockchip: Add 12V DCIN regulator to rk3399-ficus
      arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
      arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node

Jernej Skrabec (1):
      arm64: dts: allwinner: h6: Add Video Engine node

Jerome Brunet (7):
      arm64: dts: meson: g12a: add secure monitor
      arm64: dts: meson: g12a: add efuse
      arm64: dts: meson: g12a: add pinctrl support controllers
      arm64: dts: meson: g12a: add uart_ao_a pinctrl
      arm64: dts: meson: g12a: add reset controller
      arm64: dts: meson-g12a-sei510: add regulators
      arm64: dts: meson-g12a-u200: add regulators

Jiada Wang (3):
      arm64: dts: renesas: r8a7796: remove unneeded sound #address/size-cells
      arm64: dts: renesas: r8a77965: add SSIU support for sound
      arm64: dts: renesas: use extended audio dmac register

Joel Stanley (4):
      ARM: dts: aspeed: ast2500: Update flash layout
      ARM: dts: aspeed-g5: Add resets and clocks to GFX node
      ARM: dts: aspeed: Enable the GFX IP
      ARM: dts: aspeed: Add RTC node

Johan Jonker (2):
      ARM: dts: rockchip: remove disable-wp from rv1108-elgin-r1 emmc node
      ARM: dts: rockchip: enable vop0 and hdmi nodes to rk3066a-mk808

John Stultz (2):
      arm64: dts: hi3660: Add dma to uart nodes
      arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask

Jolly Shah (1):
      include: dt-binding: clock: Rename zynqmp header file

Jon Hunter (1):
      arm64: tegra: Add supply for temperature sensor on P2888

Jonas Karlman (6):
      ARM: dts: rockchip: Enable HDMI CEC on rk3288-tinker-s
      ARM: dts: rockchip: add grf reference in rk3288 tsadc node
      arm64: dts: rockchip: enable HDMI CEC on rk3328
      arm64: dts: rockchip: fix regulator name on rk3328-rock64
      arm64: dts: rockchip: add leds node on rk3328-rock64
      arm64: dts: rockchip: add ir-receiver node on rk3328-rock64

Jonathan Neuschäfer (4):
      ARM: dts: imx50: Add PHY node for usbotg and adjust clocks
      dt-bindings: Add vendor prefix for Rakuten Kobo, Inc.
      dt-bindings: arm: fsl: Add i.MX50 based boards
      ARM: dts: imx50: Add Kobo Aura DTS

Jordan Crouse (2):
      arm64: dts: msm8996: Add graphics smmu node
      arm64: dts: Add Adreno GPU definitions

Jorge Ramirez-Ortiz (2):
      arm64: dts: qcom: pms405: add spmi regulators
      arm64: dts: qcom: qcs404-evb: add spmi regulators

Joseph Lo (6):
      arm64: tegra: Fix timer node for Tegra210
      arm64: tegra: Add CPU idle states properties for Tegra210
      arm64: tegra: Enable CPU idle support for Jetson TX1
      arm64: tegra: Enable CPU idle support for Smaug
      arm64: tegra: Enable CPU idle support for Shield
      arm64: tegra: Add L2 cache topology to Tegra210

Kabir Sahane (1):
      ARM: dts: am43xx-epos-evm: Keep DCDC5 and DCDC6 always on

Kamil Konieczny (1):
      arm64: dts: exynos: Add SlimSSS to Exynos5433

Katsuhiro Suzuki (4):
      arm64: dts: rockchip: add #sound-dai-cells to HDMI of rk3328
      arm64: dts: rockchip: enable hdmi audio out for rk3399-rockpro64
      arm64: dts: rockchip: fix cts, rts pin assign of UART3 for rk3399
      arm64: dts: rockchip: fix IO domain voltage setting of APIO5 on rockpro64

Kazuya Mizuguchi (1):
      arm64: dts: renesas: r8a77995: draak: Fix EthernetAVB phy mode to rgmii

Kevin Hilman (2):
      Merge tag 'meson-clk-headers-5.2' of git://github.com/BayLibre/clk-meson into v5.2/dt64
      Merge branch 'reset/meson-g12a' of git://git.pengutronix.de/pza/linux into v5.2/dt64

Khasim Syed Mohammed (2):
      arm64: dts: qcom: qcs404: Remove default setting of controlled-remotely for BAM DMA
      arm64: dts: qcom: qcs404-evb: Change the compatible to distinguish platforms

Kishon Vijay Abraham I (1):
      ARM: dts: dra7: Add properties to enable PCIe x2 lane mode

Krzysztof Kozlowski (20):
      ARM: dts: exynos: Use ADC for Exynos4x12 on Exynos4412
      ARM: dts: exynos: Document regulator used by ADC on Odroid U3
      ARM: dts: exynos: Use stdout path property on Arndale Octa board
      ARM: dts: exynos: Add unused PMIC regulators on Arndale Octa board
      ARM: dts: exynos: Add CPU cooling on Arndale Octa
      ARM: dts: exynos: Order nodes alphabetically in Arndale Octa
      ARM: dts: exynos: Enable ADC on Arndale Octa
      ARM: dts: exynos: Adjust ldo23 and ldo27 to lower levels on Arndale Octa
      ARM: dts: exynos: Add support for UHS-I SD cards on Arndale Octa
      ARM: dts: exynos: Extend the eMMC node on Arndale Octa
      ARM: dts: exynos: Always enable necessary APIO_1V8 and ABB_1V8 regulators on Arndale Octa
      ARM: dts: exynos: Use stdout-path property instead of console in bootargs
      ARM: dts: exynos: Remove console argument from bootargs
      ARM: dts: exynos: Move pmu and timer nodes out of soc
      ARM: dts: exynos: Remove unneeded address/size cells from fixed-clock on Exynos3250
      ARM: dts: exynos: Move fixed-clocks out of soc on Exynos3250
      ARM: dts: exynos: Properly override node to use MDMA0 on Universal C210
      ARM: dts: s5pv210: Fix camera clock provider on Goni board
      arm64: dts: exynos: Move pmu and timer nodes out of soc
      arm64: dts: exynos: Move fixed-clocks out of soc

Laurent Pinchart (3):
      arm64: dts: renesas: r8a77990: ebisu: Enable LVDS1 encoder
      arm64: dts: renesas: r8a77995: draak: Enable LVDS1 encoder
      arm64: dts: renesas: salvator-common: Add GPIO keys support

Lei YU (1):
      ARM: dts: aspeed: palmetto: Fix flash_memory region

Leonard Crestez (2):
      arm64: dts: imx8qxp-mek: Add i2c1 with pca9646
      arm64: dts: imx8mm: Add cpufreq properties

Leonidas P. Papadakos (4):
      arm64: dts: rockchip: give some life to the rk3328-roc-cc leds
      arm64: dts: rockchip: add rk3328-roc-cc cpu-supply entries for all cpu nodes
      arm64: dts: rockchip: eMMC additions for rk3328-roc-cc
      arm64: dts: rockchip: enable display nodes on rk3328-roc-cc

Linus Walleij (3):
      ARM: dts: ux500: Add Mali-400
      ARM: dts: Ux500: Add MCDE and Samsung display
      ARM: dts: gemini: Indent DIR-685 partition table

Lucas Stach (7):
      ARM: dts: imx6: RDU2: add switch watchdog device
      ARM: dts: imx6: RDU2: manage backlight from panel
      arm64: dts: imx8mq: fix higher CPU operating point
      arm64: dts: imx: add Zii Ultra board support
      arm64: dts: imx8mq: add GPU node
      arm64: dts: fsl: imx8mq-evk: link regulator to GPU domain
      arm64: dts: imx8mq: fix GPU clock frequency

Ludovic Barre (6):
      ARM: dts: stm32: add sdmmc1 support on stm32h743
      ARM: dts: stm32: add sdmmc1 support on stm32h743i eval board
      ARM: dts: stm32: add sdmmc1 support on stm32h743i disco board
      ARM: dts: stm32: add sdmmc1 support on stm32mp157c
      ARM: dts: stm32: add sdmmc1 support on stm32mp157c ed1 board
      ARM: dts: stm32: add sdmmc1 support on stm32mp157a dk1 board

Magnus Damm (5):
      arm64: dts: renesas: Update Ebisu and Draak bootargs
      ARM: dts: kzm9d: Add rw parameter to bootargs
      ARM: dts: bockw: Reorder bootargs
      ARM: dts: marzen: Add rw to bootargs and use ip=dhcp
      ARM: dts: ape6evm: Reorder bootargs

Manivannan Sadhasivam (11):
      arm64: dts: freescale: Enable PCI-E controller for Oxalis board
      dt-bindings: reset: Add HI3670 reset controller binding
      arm64: dts: hisilicon: hi3670: Add reset controller support
      dt-bindings: mmc: Add HI3670 MMC controller binding
      arm64: dts: hisilicon: hi3670: Add MMC controller support
      arm64: dts: hisilicon: hikey970: Add SD and WiFi support
      arm64: dts: hisilicon: hi3670: Add UFS controller support
      arm64: dts: bitmain: Add GPIO support for BM1880 SoC
      arm64: dts: bitmain: Add GPIO Line names for Sophon Edge board
      arm64: dts: bitmain: Add pinctrl support for BM1880 SoC
      arm64: dts: bitmain: Add UART pinctrl support for Sophon Edge

Mans Rullgard (5):
      ARM: dts: sun7i: add pinctrl for missing uart mux options
      ARM: dts: sun7i: add pinctrl for CAN in PA bank
      ARM: dts: sun7i: add pinctrl for EMAC in PH bank
      ARM: dts: sun7i: add /omit-if-no-ref/ tags to pin group nodes
      ARM: dts: sun7i: fix typos in uart pin mux

Marc Gonzalez (5):
      dt-bindings: ufs: Add msm8998 compatible string
      arm64: dts: qcom: msm8998: Allow UFSHC driver to set-load
      arm64: dts: qcom: msm8998: Add UFS nodes
      arm64: dts: msm8998: Add UFS phy reset
      arm64: dts: qcom: msm8998: Fix blsp2_i2c5 address

Marc Zyngier (1):
      arm64: dts: rockchip: Add capacity-dmips-mhz attributes to rk3399

Marco Felsch (1):
      ARM: dts: pfla02: prepare storage devices to add paritions

Marek Vasut (8):
      arm64: dts: renesas: r8a77995: draak: Enable CAN0, CAN1
      ARM: dts: r8a7792: blanche: Add IIC3 and DA9063 PMIC node
      ARM: dts: alt: Add DA9063 PMIC node
      of: Add vendor prefix for Menlo Systems GmbH
      ARM: dts: alt: Enable USB support
      dt-bindings: arm: fsl: Add devicetree binding for M53 Menlo board.
      ARM: dts: imx53: Rename M53 SoM touchscreen node
      ARM: dts: imx53: Add Menlosystems M53 board

Martin Blumenstingl (6):
      ARM: dts: meson8: add the internal clock measurer
      ARM: dts: meson8b: add the internal clock measurer
      ARM: dts: meson8b: odroidc1: add the GPIO line names
      ARM: dts: meson: add support for the RTC
      ARM: dts: meson8b: ec100: enable the RTC
      ARM: dts: meson8b: odroid-c1: prepare support for the RTC

Matthias Kaehlcke (9):
      ARM: dts: rockchip: Remove unnecessary setting of UART0 SCLK rate on veyron
      ARM: dts: rockchip: Add BT_EN to the power sequence for veyron
      ARM: dts: rockchip: Add dynamic-power-coefficient for rk3288
      arm64: dts: qcom: pm8998: Use ADC temperature to temp-alarm node
      arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
      arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs
      arm64: dts: sdm845: Add CPU topology
      arm64: dts: sdm845: Add CPU capacity values
      ARM: dts: qcom-apq8064: Set 'cxo_board' as ref clock of the DSI PHY

Maxime Ripard (53):
      arm64: dts: allwinner: a64: Add cross links for the mixers
      arm64: dts: allwinner: a64: Fix the TCON output clock
      arm64: dts: allwinner: a64: Fix display pipeline endpoints
      arm64: dts: allwinner: a64: Add missing PIO clocks
      arm64: dts: allwinner: Fix pinctrl node names
      ARM: dts: sunxi: h3/h5: Remove stale pinctrl-names entry
      ARM: dts: sun8i: h3: Refactor the pinctrl node names
      ARM: dts: sun8i: a83t: Add cross links for the mixers
      ARM: dts: sun5i: Fix display pipeline endpoint warnings in DTC
      ARM: dts: sun5i: Fix Display Engine DTC warnings
      ARM: dts: sun6i: Fix Display Engine DTC warnings
      ARM: dts: sun8i: a23/a33: Fix Display Engine DTC warnings
      ARM: dts: sun8i: v3s: Fix Display Engine DTC warnings
      ARM: dts: sun8i: a83t: Fix Display Engine DTC warnings
      ARM: dts: sun8i: r40: Fix Display Engine DTC warnings
      ARM: dts: sun9i: Fix Display Engine DTC warnings
      ARM: dts: sun9i: Add missing unit address
      dt-bindings: Add YAML description for Allwinner boards
      ARM: dts: sun8i: a33: Add default address and size cells to the DSI node
      ARM: dts: sun8i: a23/a33: Add R_I2C Controller
      dt-bindings: arm: Remove the CPU compatible documentation
      ARM: dts: sun9i: optimus: Fix fixed-regulators
      ARM: dts: sun5i: lichee-pi one: Remove stale pinctrl-names entry
      ARM: dts: sunxi: Fix GIC compatible
      ARM: dts: sunxi: Switch to new GPIOs properties for i2c-gpio
      ARM: sunxi: Fix the USB PHY ID detect GPIO properties
      ARM: sunxi: Fix the USB PHY VBUS detect GPIO properties
      ARM: dts: sunxi: Fix the TCON output clock
      ARM: dts: sun8i: tbs-a711: Fix typo in regulators
      ARM: sunxi: dts: Split USB PHY cells into an array
      ARM: dts: sun8i: r40: Fix AHCI reset-names property
      ARM: dts: sun8i: r40: Remove useless AHCI properties
      ARM: dts: sunxi: Remove pinctrl size-cells property
      ARM: dts: sun8i: A23/A33: Fix pinctrl node names
      ARM: dts: sunxi: Add default dr_mode
      ARM: dts: sun8i: h3: Add default dr_mode
      arm64: dts: allwinner: a64: Add default dr_mode
      arm64: dts: allwinner: a64: Fix the Codec I2S binding
      ARM: dts: sun9i: Remove deprecated pinctrl properties
      ARM: dts: sunxi: Conform to DT spec for NAND controller
      ARM: dts: sunxi: Remove useless address and size cells
      ARM: dts: sunxi: Remove pinctrl groups setting bias
      ARM: dts: sunxi: Remove useless pinctrl nodes
      ARM: dts: sun5i: Add the MBUS controller
      ARM: dts: sunxi: Remove useless phy-names from EHCI and OHCI
      ARM: dts: sunxi: h3/h5: Remove useless phy-names from EHCI and OHCI
      arm64: dts: allwinner: Remove useless phy-names from EHCI and OHCI
      ARM: dts: sun4i: protab2: Remove stale pinctrl-names entry
      ARM: dts: sun4i: lime: Fix the USB PHY ID detect GPIO properties
      ARM: dts: sun6i: i7: Remove useless property
      ARM: dts: sun5i: Reorder pinctrl nodes
      arm64: dts: allwinner: Fix DE2 bus node name
      ARM: dts: sun8i: mapleboard: Remove cd-inverted

Mike Erdahl (1):
      ARM: dts: am43xx-epos-evm: Keep DCDC3 regulator on in suspend to memory

Miquel Raynal (1):
      ARM: dts: sunxi: Improve A33 NAND transfers by using DMA

Neil Armstrong (25):
      vendor-prefixes: Add prefix for Shenzhen SEI Robotics Co., Ltd
      arm64: dts: Add SEI Robotics SEI510 Board
      arm64: dts: meson-g12a: Add AO Secure node
      arm64: dts: meson-gxm-nexbox-a1: Enable USB
      arm64: dts: meson: g12a: Add AO Clock + Reset Controller support
      arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
      arm64: dts: meson-g12a-u200: add uart_AO pinctrl
      arm64: dts: meson-g12a-sei510: add uart_AO pinctrl
      arm64: dts: meson-g12a-x96-max: add uart_AO pinctrl
      arm64: dts: meson-g12a-x96-max: Enable BT Module
      arm64: dts: meson-g12a: Add CMA reserved memory
      dt-bindings: gpu: mali-midgard: Add resets property
      dt-bindings: power: amlogic, meson-gx-pwrc: Add G12A compatible
      arm64: dts: meson: g12a: Add SAR ADC node
      arm64: dts: meson: g12a: Add G12A USB nodes
      arm64: dts: meson: g12a: Add mali-g31 gpu node
      arm64: dts: meson-g12a-sei510: Add ADC Key and BT support
      arm64: dts: meson-g12a-sei510: Enable USB
      arm64: dts: meson-g12a-u200: Enable USB
      arm64: dts: meson-g12a-x96-max: Enable USB
      arm64: dts: meson-g12a: Add VPU and HDMI related nodes
      arm64: dts: meson-g12a: Add AO-CEC nodes
      arm64: dts: meson-g12a-x96-max: Add support for Video Display
      arm64: dts: meson-g12a-sei510: Add support for Video Display
      arm64: dts: meson-g12a-u200: Add support for Video Display

Nicolas Ferre (1):
      ARM: dts: at91: sama5d2: add labels to soc dtsi for derivative boards

Niklas Söderlund (2):
      arm64: dts: renesas: r8a774c0: Remove invalid compatible value for CSI40
      arm64: dts: renesas: r8a77990: Remove invalid compatible value for CSI40

Olivier Moysan (2):
      ARM: dts: stm32: add spdifrx support on stm32mp157c
      ARM: dts: stm32: add spdfirx pins to stm32mp157c

Olof Johansson (43):
      Merge tag 'amlogic-dt64' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'amlogic-dt' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'v5.2-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.2-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'renesas-arm64-dt-for-v5.2' of https://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'aspeed-5.2-devicetree' of git://git.kernel.org/.../joel/aspeed into arm/dt
      Merge tag 'stm32-dt-for-v5.2-1' of git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'samsung-dt-5.2' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'samsung-dt64-5.2' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'zynqmp-dt-for-v5.2' of https://github.com/Xilinx/linux-xlnx into arm/dt
      Merge tag 'hisi-arm64-dt-for-5.2' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'omap-for-v5.2/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'omap-for-v5.2/dt-ti-sysc-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'ux500-dts-v5.2-armsoc' of git://git.kernel.org/.../linusw/linux-stericsson into arm/dt
      Merge tag 'socfpga_dts_updates_for_v5.2' of git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge tag 'omap-for-v5.2/dt-am3-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'tegra-for-5.2-arm-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.2-arm64-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'sunxi-dt-for-5.2' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'sunxi-dt64-for-5.2' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'sunxi-h3-h5-for-5.2' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'renesas-arm64-dt2-for-v5.2' of https://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.2' of https://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.2' of https://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'amlogic-dt-2' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'amlogic-dt64-2' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'imx-bindings-5.2' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.2' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'qcom-arm64-for-5.2' of git://git.kernel.org/.../agross/linux into arm/dt
      Merge tag 'qcom-dts-for-5.2' of git://git.kernel.org/.../agross/linux into arm/dt
      Merge branch 'at91-dt' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'mvebu-dt-5.2-1' of git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'mvebu-dt64-5.2-1' of git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'v5.1-next-dts64' of https://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'v5.2-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.2-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'qcom-dts-for-5.2-1' of git://git.kernel.org/.../agross/linux into arm/dt
      Merge tag 'qcom-arm64-for-5.2-1' of git://git.kernel.org/.../agross/linux into arm/dt
      Merge tag 'samsung-dt-5.2-2' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'samsung-dt64-5.2-2' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'lpc32xx-dt-for-5.2' of https://github.com/vzapolskiy/linux-lpc32xx into arm/dt
      Merge tag 'imx-dt64-5.2' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'bitmain-soc-5.2' of git://git.kernel.org/.../mani/linux-bitmain into arm/dt

Ondrej Jirman (11):
      ARM: dts: sun8i: tbs-a711: Enable bluetooth
      ARM: dts: sun8i: a83t: Add nodes for UART2-UART4
      ARM: dts: sun8i: a83t: Add missing cooling device properties for CPUs
      ARM: dts: sun8i: tbs-a711: Add node for BMA250 accelerometer
      ARM: dts: sun8i: a83t: Add UART2 PB pins
      ARM: dts: sun8i: a83t: Add missing CPU clock references
      ARM: dts: sun8i: tbs-a711: Enable UART2 (for NEO-6M GPS module)
      ARM: dts: sun8i: tbs-a711: Add support for volume keys input
      dt-bindings: sunxi: Add compatible for OrangePi 3 board
      arm64: dts: allwinner: h6: Add Orange Pi 3 DTS
      arm64: dts: allwinner: h6: Add MMC1 pins

Pablo Greco (1):
      ARM: dts: sun8i: v40: bananapi-m2-berry: Sort device node dereferences.

Pascal Paillet (2):
      ARM: dts: stm32: add stpmic1 support on stm32mp157c ed1 board
      ARM: dts: stm32: add stpmic1 support on stm32mp157a dk1 board

Paul Kocialkowski (1):
      ARM: dts: sun8i-h3: Add support for the RerVision H3-DVK board

Peng Fan (2):
      arm64: dts: imx8qxp: fix mbox-cells
      arm64: dts: imx8qxp: add lsio_mu2 node

Peng Ma (2):
      arm64: dts: ls1028a: Corrected the SATA ecc address
      arm64: dts: lx2160a: add sata node support

Pierre-Jean Texier (1):
      ARM: dts: imx7s-warp: PMIC swbst boot-on/always-on

Priit Laes (1):
      ARM: dts: sun7i: olimex-lime2: Add regulators for GPIO banks

Quentin Schulz (1):
      ARM: dtsi: axp81x: add USB power supply node

Rajan Vaja (1):
      dt-bindings: xilinx: Separate clock binding from firmware doc

Rajendra Nayak (1):
      arm64: dts: sdm845: Include rpmpd DT header

Ran Wang (1):
      arm64: dts: lx2160a: add cpu idle support

Robin Murphy (3):
      arm64: dts: rockchip: Add PWM fan for NanoPC-T4
      arm64: dts: rockchip: Add nanopi4 ethernet phy
      dt-bindings: hwmon (pwm-fan) Remove dead "cooling-*-state" properties

Roger Quadros (2):
      dt-binding: arm: omap: Add information for AM5748
      ARM: dts: dra7: Separate AM57 dtsi files

Rui Miguel Silva (5):
      ARM: dts: imx7s: add mipi phy power domain
      ARM: dts: imx7s: add multiplexer controls
      ARM: dts: imx7s: Add video mux, csi and mipi_csi
      ARM: dts: imx7s-warp: add csi and mipi_csi node
      ARM: dts: imx7s-warp: add ov2680 sensor node

Ryder Lee (2):
      dt-bindings: mediatek: update bindings for MT7629 SoC
      dt-bindings: soc: fix a typo for MT7623A

Sameer Pujar (1):
      arm64: tegra: Enable aconnect, ADMA and AGIC on Jetson TX1

Seiya Wang (2):
      arm64: dts: mt8173: correct cpu type of cpu2 and cpu3 to cortex-a72
      arm64: dts: mt8173: add pmu nodes for mt8173

Simon Horman (1):
      arm64: dts: renesas: ebisu: Add PMIC DDR0 Backup Power config

Sowjanya Komatineni (2):
      arm64: tegra: Fix default tap and trim values
      arm64: tegra: Enable command queue for Tegra186 SDMMC4

Srinivas Kandagatla (1):
      arm64: dts: db820c: Add sound card support

Stuart Menefy (4):
      ARM: dts: exynos: Use bustop PLL as the source for MMC clocks on Exynos5260
      ARM: dts: exynos: Add high speed I2C ports for Exynos5260
      ARM: dts: exynos: Add interrupts for dedicated EINTs on Exynos5260
      ARM: dts: exynos: Fix interrupt for shared EINTs on Exynos5260

Sylwester Nawrocki (2):
      ARM: dts: exynos: Fix audio routing on Odroid XU3
      ARM: dts: exynos: Fix audio (microphone) routing on Odroid XU3

Takeshi Kihara (5):
      arm64: dts: renesas: ebisu: Fix adv7482 hexadecimal register address
      arm64: dts: renesas: ebisu: Enable VIN5
      arm64: dts: renesas: r8a77990-ebisu: Add BD9571 PMIC
      arm64: dts: renesas: salvator-common: Sort node label
      arm64: dts: renesas: r8a77965: Remove reg-names of display node

Tao Ren (1):
      ARM: dts: aspeed: cmm: enable iio-hwmon-adc

Thierry Reding (11):
      arm64: tegra: jetson-tx1: Move PLL power supplies to XUSB pad controller
      arm64: tegra: smaug: Move PLL power supplies to XUSB pad controller
      arm64: tegra: Add NVIDIA Jetson Nano Developer Kit support
      ARM: tegra: Remove gratuitous parentheses in SPDX license identifier
      ARM: tegra: apalis: Move PLL power supplies to XUSB pad controller
      ARM: tegra: jetson-tk1: Move PLL power supplies to XUSB pad controller
      ARM: tegra: nyan: Move PLL power supplies to XUSB pad controller
      ARM: tegra: venice2: Move PLL power supplies to XUSB pad controller
      arm64: tegra: Add XUSB and pad controller on Tegra186
      arm64: tegra: Enable XUSB on P2771
      arm64: tegra: Remove regulator hacks on Jetson TX2

Thomas Schreiber (1):
      arm64: dts: clearfog-gt-8k: add wlan_disable signal hog

Tim Harvey (2):
      ARM: dts: imx: Add TDA19971 HDMI Receiver to GW551x
      ARM: dts: imx: Add TDA19971 HDMI Receiver to GW54xx

Tony Lindgren (3):
      ARM: dts: Add common mcpdm dts file for omap4
      ARM: dts: Add l4 abe interconnect hierarchy and ti-sysc data for omap4
      ARM: dts: Add l4 abe interconnect hierarchy and ti-sysc data for omap5

Uwe Kleine-König (2):
      dt-bindings: arm: fsl: Add devicetree binding for Eckelmann ci4x10
      ARM: dts: Add devicetree for Eckelmann ci4x10

Vijay Khemka (1):
      ARM: dts: aspeed: tiogapass: Enable VUART

Vinod Koul (2):
      arm64: dts: qcom: qcs404: Add Ethernet node
      arm64: dts: qcom: qcs404: Enable ethernet for EVB-4000

Vladimir Zapolskiy (5):
      ARM: dts: lpc32xx: change hexadecimal values to lower case
      ARM: dts: lpc32xx: disable I2S controllers by default
      ARM: dts: lpc32xx: disable MAC controller by default
      ARM: dts: lpc32xx: add address and size cell values to SPI controller nodes
      ARM: dts: lpc32xx: use SPDX license identifier

Yangtao Li (1):
      arm64: dts: allwinner: h6: Add device node for SID

Yannick Fertré (5):
      ARM: dts: stm32: add power supply of otm8009a on stm32mp157c-dk2
      ARM: dts: stm32: add I2C sleep pins muxing on stm32mp157
      ARM: dts: stm32: add ltdc pins muxing on stm32mp157
      ARM: dts: stm32: add cec pins muxing on stm32mp157
      ARM: dts: stm32: enable cec on stm32mp157a-dk1 board

Yinbo Zhu (1):
      ARM: dts: ls1021a-qds: enable esdhc controller

Youlin Wang (1):
      arm64: dts: hi3660: Add hisi asp dma device

Yunfei Dong (1):
      arm64: dts: Using standard CCF interface to set vcodec clk

Zheng Yang (1):
      ARM: dts: rockchip: add rk3066 hdmi nodes

Zhiyong Tao (1):
      arm64: dts: mt8183: add pinctrl file

Ziping Chen (1):
      ARM: dts: sunxi: Add R_LRADC support for A83T


 .../devicetree/bindings/arm/amlogic.txt         |    1 +
 .../bindings/arm/freescale/fsl,scu.txt          |   29 +-
 Documentation/devicetree/bindings/arm/fsl.yaml  |   36 +
 .../devicetree/bindings/arm/omap/omap.txt       |    6 +
 .../devicetree/bindings/arm/rockchip.yaml       |   25 +-
 Documentation/devicetree/bindings/arm/sunxi.txt |   23 -
 .../devicetree/bindings/arm/sunxi.yaml          |  807 +++++++++++++
 .../bindings/clock/xlnx,zynqmp-clk.txt          |   63 +
 .../devicetree/bindings/dma/fsl-imx-sdma.txt    |    1 +
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt    |   54 +-
 .../bindings/gpu/arm,mali-midgard.txt           |   14 +
 .../devicetree/bindings/hwmon/pwm-fan.txt       |    2 -
 .../devicetree/bindings/iio/adc/imx7d-adc.txt   |    2 +
 .../bindings/iio/adc/qcom,spmi-vadc.txt         |    1 +
 .../interrupt-controller/mediatek,sysirq.txt    |    7 +-
 .../bindings/memory-controllers/fsl/mmdc.txt    |   35 +
 .../devicetree/bindings/mmc/k3-dw-mshc.txt      |    2 +
 .../bindings/power/amlogic,meson-gx-pwrc.txt    |    4 +-
 .../bindings/reset/hisilicon,hi3660-reset.txt   |    7 +-
 .../devicetree/bindings/serial/mtk-uart.txt     |    4 +-
 .../devicetree/bindings/soc/mediatek/scpsys.txt |    5 +-
 .../bindings/timer/mediatek,mtk-timer.txt       |    1 +
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt   |    1 +
 .../devicetree/bindings/vendor-prefixes.txt     |    7 +
 arch/arm/boot/dts/Makefile                      |   13 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts      |   16 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts      |   38 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      |   42 +-
 arch/arm/boot/dts/am335x-baltos-leds.dtsi       |    6 +-
 arch/arm/boot/dts/am335x-baltos.dtsi            |  140 +--
 arch/arm/boot/dts/am335x-base0033.dts           |   48 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi       |  116 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi  |   54 +-
 arch/arm/boot/dts/am335x-boneblack-wireless.dts |   28 +-
 arch/arm/boot/dts/am335x-boneblue.dts           |  104 +-
 arch/arm/boot/dts/am335x-bonegreen-common.dtsi  |    4 +-
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts |   28 +-
 arch/arm/boot/dts/am335x-chiliboard.dts         |   66 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi          |   34 +-
 arch/arm/boot/dts/am335x-cm-t335.dts            |  190 ++-
 arch/arm/boot/dts/am335x-evm.dts                |  234 ++--
 arch/arm/boot/dts/am335x-evmsk.dts              |  292 ++---
 arch/arm/boot/dts/am335x-icev2.dts              |  116 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi          |   40 +-
 arch/arm/boot/dts/am335x-lxm.dts                |  120 +-
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi    |   42 +-
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts       |   24 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts  |  116 +-
 arch/arm/boot/dts/am335x-nano.dts               |  140 +--
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts     |  168 +--
 arch/arm/boot/dts/am335x-osd335x-common.dtsi    |    4 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi           |   74 +-
 arch/arm/boot/dts/am335x-pdu001.dts             |  170 +--
 arch/arm/boot/dts/am335x-pepper.dts             |  200 ++--
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |   60 +-
 arch/arm/boot/dts/am335x-pocketbeagle.dts       |   56 +-
 arch/arm/boot/dts/am335x-sancloud-bbe.dts       |   62 +-
 arch/arm/boot/dts/am335x-sbc-t335.dts           |  152 +--
 arch/arm/boot/dts/am335x-shc.dts                |  226 ++--
 arch/arm/boot/dts/am335x-sl50.dts               |  208 ++--
 arch/arm/boot/dts/am335x-wega.dtsi              |   68 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |   11 +
 arch/arm/boot/dts/am5718.dtsi                   |   32 +
 arch/arm/boot/dts/am571x-idk.dts                |    2 +-
 arch/arm/boot/dts/am5728.dtsi                   |   33 +
 arch/arm/boot/dts/am572x-idk.dts                |    5 +-
 arch/arm/boot/dts/am5748.dtsi                   |   33 +
 arch/arm/boot/dts/am574x-idk.dts                |    4 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |    2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts       |    2 +-
 arch/arm/boot/dts/armada-38x.dtsi               |    2 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts        |   21 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts   |    6 +
 .../boot/dts/aspeed-bmc-facebook-tiogapass.dts  |    5 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts   |    4 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts    |    8 +
 .../arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |   52 +-
 arch/arm/boot/dts/aspeed-g4.dtsi                |    6 +
 arch/arm/boot/dts/aspeed-g5.dtsi                |   20 +
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi       |   39 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts     |   39 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |   93 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts     |   39 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts            |   39 +-
 arch/arm/boot/dts/at91-vinco.dts                |   39 +-
 arch/arm/boot/dts/at91sam9260ek.dts             |   39 +-
 arch/arm/boot/dts/at91sam9xe.dtsi               |   39 +-
 arch/arm/boot/dts/axp81x.dtsi                   |    4 +
 arch/arm/boot/dts/dra7-l4.dtsi                  |    6 +-
 arch/arm/boot/dts/dra7.dtsi                     |    2 +
 arch/arm/boot/dts/emev2-kzm9d.dts               |    2 +-
 arch/arm/boot/dts/exynos3250.dtsi               |   72 +-
 arch/arm/boot/dts/exynos4.dtsi                  |   14 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |    4 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |    4 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |    4 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |   21 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |    7 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |    3 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |    4 +-
 arch/arm/boot/dts/exynos4412-trats2.dts         |    3 +-
 arch/arm/boot/dts/exynos4412.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    3 +-
 arch/arm/boot/dts/exynos5250.dtsi               |   40 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi       |   16 +
 arch/arm/boot/dts/exynos5260-xyref5260.dts      |    2 +-
 arch/arm/boot/dts/exynos5260.dtsi               |   82 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts       |    2 -
 arch/arm/boot/dts/exynos5410-smdk5410.dts       |    2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  364 +++++-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    3 +-
 arch/arm/boot/dts/exynos5420.dtsi               |    2 +-
 .../boot/dts/exynos5422-odroidxu3-audio.dtsi    |    5 +-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |    2 -
 arch/arm/boot/dts/exynos54xx.dtsi               |   38 +-
 arch/arm/boot/dts/gemini-dlink-dir-685.dts      |   82 +-
 arch/arm/boot/dts/imx35.dtsi                    |    6 +
 arch/arm/boot/dts/imx50-kobo-aura.dts           |  258 ++++
 arch/arm/boot/dts/imx50.dtsi                    |   23 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts            |   38 +-
 arch/arm/boot/dts/imx51.dtsi                    |    2 +-
 arch/arm/boot/dts/imx53-m53.dtsi                |    2 +-
 arch/arm/boot/dts/imx53-m53menlo.dts            |  311 +++++
 arch/arm/boot/dts/imx53.dtsi                    |    2 +-
 arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi   |    4 +-
 arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts   |  381 ++++++
 arch/arm/boot/dts/imx6dl-sabreauto.dts          |   15 +
 arch/arm/boot/dts/imx6q-gw54xx.dts              |  105 ++
 arch/arm/boot/dts/imx6q-logicpd.dts             |    4 +-
 arch/arm/boot/dts/imx6q-zii-rdu2.dts            |   38 +-
 arch/arm/boot/dts/imx6qdl-emcon.dtsi            |    2 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi           |   29 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi           |  138 +++
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi    |    4 +-
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi         |    2 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         |   50 +-
 arch/arm/boot/dts/imx6qdl.dtsi                  |   18 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts           |   38 +-
 arch/arm/boot/dts/imx6sl.dtsi                   |   11 +-
 arch/arm/boot/dts/imx6sll.dtsi                  |    3 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |    4 +-
 arch/arm/boot/dts/imx6ul.dtsi                   |    4 +-
 arch/arm/boot/dts/imx7-mba7.dtsi                |  550 +++++++++
 arch/arm/boot/dts/imx7-tqma7.dtsi               |  249 ++++
 arch/arm/boot/dts/imx7d-mba7.dts                |  119 ++
 arch/arm/boot/dts/imx7d-tqma7.dtsi              |   11 +
 arch/arm/boot/dts/imx7d-zii-rpu2.dts            |  941 +++++++++++++++
 arch/arm/boot/dts/imx7d.dtsi                    |    1 +
 arch/arm/boot/dts/imx7s-mba7.dts                |   18 +
 arch/arm/boot/dts/imx7s-tqma7.dtsi              |   11 +
 arch/arm/boot/dts/imx7s-warp.dts                |   61 +
 arch/arm/boot/dts/imx7s.dtsi                    |   98 +-
 arch/arm/boot/dts/imx7ulp.dtsi                  |   12 +
 arch/arm/boot/dts/lpc3250-ea3250.dts            |    1 +
 arch/arm/boot/dts/lpc3250-phy3250.dts           |    3 +-
 arch/arm/boot/dts/lpc32xx.dtsi                  |   38 +-
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts     |    1 -
 arch/arm/boot/dts/ls1021a-qds.dts               |    4 +
 arch/arm/boot/dts/ls1021a.dtsi                  |    1 -
 arch/arm/boot/dts/meson.dtsi                    |    9 +
 arch/arm/boot/dts/meson8.dtsi                   |   10 +
 arch/arm/boot/dts/meson8b-ec100.dts             |   14 +
 arch/arm/boot/dts/meson8b-odroidc1.dts          |   66 ++
 arch/arm/boot/dts/meson8b.dtsi                  |   10 +
 arch/arm/boot/dts/omap2420-n810.dts             |    2 +-
 arch/arm/boot/dts/omap4-duovero.dtsi            |   21 +-
 arch/arm/boot/dts/omap4-l4-abe.dtsi             |  501 ++++++++
 arch/arm/boot/dts/omap4-mcpdm.dtsi              |   44 +
 arch/arm/boot/dts/omap4-panda-common.dtsi       |   21 +-
 arch/arm/boot/dts/omap4-sdp.dts                 |   21 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi       |   21 +-
 arch/arm/boot/dts/omap4.dtsi                    |  192 +--
 arch/arm/boot/dts/omap5-board-common.dtsi       |    8 +-
 arch/arm/boot/dts/omap5-l4-abe.dtsi             |  447 +++++++
 arch/arm/boot/dts/omap5.dtsi                    |  115 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi             |    6 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi             |    4 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi             |    1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi             |    1 +
 arch/arm/boot/dts/qcom-pma8084.dtsi             |    1 +
 arch/arm/boot/dts/r7s72100-rskrza1.dts          |   46 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |   29 +-
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts       |  123 ++
 arch/arm/boot/dts/r8a77470.dtsi                 |  313 +++++
 arch/arm/boot/dts/r8a7778-bockw.dts             |    2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |    2 +-
 arch/arm/boot/dts/r8a7792-blanche.dts           |   20 +
 arch/arm/boot/dts/r8a7792.dtsi                  |   18 +
 arch/arm/boot/dts/r8a7794-alt.dts               |   47 +
 arch/arm/boot/dts/rk3036-kylin.dts              |   10 +-
 arch/arm/boot/dts/rk3036.dtsi                   |  136 +--
 arch/arm/boot/dts/rk3066a-marsboard.dts         |    2 +-
 arch/arm/boot/dts/rk3066a-mk808.dts             |   37 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts          |   26 +-
 arch/arm/boot/dts/rk3066a.dtsi                  |  239 ++--
 arch/arm/boot/dts/rk3188-px3-evb.dts            |    4 +-
 arch/arm/boot/dts/rk3188-radxarock.dts          |   14 +-
 arch/arm/boot/dts/rk3188.dtsi                   |  210 ++--
 arch/arm/boot/dts/rk322x.dtsi                   |  170 +--
 arch/arm/boot/dts/rk3288-evb-act8846.dts        |    4 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               |   26 +-
 arch/arm/boot/dts/rk3288-fennec.dts             |   10 +-
 arch/arm/boot/dts/rk3288-firefly-beta.dts       |    4 +-
 .../boot/dts/rk3288-firefly-reload-core.dtsi    |   10 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts     |   36 +-
 arch/arm/boot/dts/rk3288-firefly.dts            |    4 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi           |   38 +-
 arch/arm/boot/dts/rk3288-miqi.dts               |   28 +-
 arch/arm/boot/dts/rk3288-phycore-rdk.dts        |   28 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi       |   30 +-
 arch/arm/boot/dts/rk3288-r89.dts                |   14 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |    4 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts       |   18 +-
 arch/arm/boot/dts/rk3288-tinker-s.dts           |    5 +
 arch/arm/boot/dts/rk3288-tinker.dtsi            |   67 +-
 .../boot/dts/rk3288-veyron-analog-audio.dtsi    |    8 +-
 arch/arm/boot/dts/rk3288-veyron-brain.dts       |    8 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |   25 +-
 arch/arm/boot/dts/rk3288-veyron-jaq.dts         |   14 +-
 arch/arm/boot/dts/rk3288-veyron-jerry.dts       |   23 +-
 arch/arm/boot/dts/rk3288-veyron-mickey.dts      |    6 +-
 arch/arm/boot/dts/rk3288-veyron-mighty.dts      |   34 +
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |   24 +-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts       |    6 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi      |   16 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts      |   14 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi            |   91 +-
 arch/arm/boot/dts/rk3288-vyasa.dts              |    6 +-
 arch/arm/boot/dts/rk3288.dtsi                   |  317 ++---
 arch/arm/boot/dts/rv1108-elgin-r1.dts           |    1 -
 arch/arm/boot/dts/rv1108.dtsi                   |  138 +--
 arch/arm/boot/dts/s5pv210-goni.dts              |    2 +-
 arch/arm/boot/dts/s5pv210.dtsi                  |    6 +-
 arch/arm/boot/dts/sama5d2.dtsi                  |   45 +-
 arch/arm/boot/dts/sama5d36ek_cmp.dts            |   39 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi           |   39 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi           |   39 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |   39 +-
 .../boot/dts/socfpga_arria10_socdk_sdmmc.dts    |    1 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi               |   74 +-
 arch/arm/boot/dts/ste-href-stuib.dtsi           |   13 +
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi      |   13 +
 arch/arm/boot/dts/stm32f429.dtsi                |   13 +
 arch/arm/boot/dts/stm32f769-disco.dts           |    4 +
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi        |   68 ++
 arch/arm/boot/dts/stm32h743.dtsi                |   14 +
 arch/arm/boot/dts/stm32h743i-disco.dts          |   20 +
 arch/arm/boot/dts/stm32h743i-eval.dts           |   23 +-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi       |  269 +++++
 arch/arm/boot/dts/stm32mp157a-dk1.dts           |  250 ++++
 arch/arm/boot/dts/stm32mp157c-dk2.dts           |   76 ++
 arch/arm/boot/dts/stm32mp157c-ed1.dts           |  175 ++-
 arch/arm/boot/dts/stm32mp157c.dtsi              |   56 +
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts |   20 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      |   10 +-
 .../arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts |   20 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts    |   20 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts           |   20 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       |   20 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts    |   72 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts       |   12 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  |   18 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         |   12 +-
 .../arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts |   20 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                |   11 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts    |   10 +-
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |   10 +-
 .../dts/sun5i-a13-empire-electronix-d709.dts    |   20 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts        |   12 +-
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts    |    5 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts |   18 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts       |   20 +-
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts       |   11 +-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts        |   16 +-
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts        |    4 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts             |    4 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts             |   14 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi |   20 +-
 arch/arm/boot/dts/sun5i.dtsi                    |   66 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts        |   14 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts     |   16 +-
 arch/arm/boot/dts/sun6i-a31-i7.dts              |    1 -
 arch/arm/boot/dts/sun6i-a31.dtsi                |   22 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts        |    2 +-
 .../boot/dts/sun6i-reference-design-tablet.dtsi |   12 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        |   10 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |   12 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts       |   12 +-
 .../boot/dts/sun7i-a20-olimex-som204-evb.dts    |    4 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  |   18 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   24 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   18 +-
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts   |   12 +-
 arch/arm/boot/dts/sun7i-a20-orangepi.dts        |   12 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts   |   12 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        |   12 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts  |   12 +-
 .../arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts |   12 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                |  125 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   74 +-
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts       |    6 +
 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts       |    7 +
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts  |   11 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                |   20 +-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts    |   12 +
 .../arm/boot/dts/sun8i-a83t-cubietruck-plus.dts |   12 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts       |   73 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi               |  111 +-
 .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts |   20 +-
 .../boot/dts/sun8i-h2-plus-orangepi-zero.dts    |    2 +-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts       |    6 +-
 arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts |    7 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts   |    3 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts        |    2 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts   |    2 +-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi          |   25 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts       |   34 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts    |   27 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     |   25 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts      |   27 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts    |    9 -
 .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts   |    3 +-
 arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts    |  114 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                 |    4 +
 arch/arm/boot/dts/sun8i-q8-common.dtsi          |   18 +-
 .../boot/dts/sun8i-r16-nintendo-nes-classic.dts |    2 -
 arch/arm/boot/dts/sun8i-r16-parrot.dts          |   12 +-
 arch/arm/boot/dts/sun8i-r40.dtsi                |   13 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi |   12 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts   |    2 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                |   13 +-
 .../boot/dts/sun8i-v40-bananapi-m2-berry.dts    |   36 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts     |   15 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts         |    4 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                |   84 +-
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi   |    7 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi              |   50 +-
 .../arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi |    4 +-
 arch/arm/boot/dts/tegra124-apalis-emc.dtsi      |   39 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |   40 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |    2 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     |    9 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi          |   45 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |    5 +
 arch/arm/boot/dts/tegra124-nyan.dtsi            |    5 +
 arch/arm/boot/dts/tegra124-venice2.dts          |    5 +
 arch/arm/boot/dts/tegra30.dtsi                  |   11 +
 arch/arm/boot/dts/vf610-zii-cfu1.dts            |   26 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts       |   57 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts       |   49 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi            |    6 +-
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts        |   14 +-
 arch/arm/boot/dts/vf610-zii-spb4.dts            |  359 ++++++
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts        |    5 +-
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts       |   17 +-
 arch/arm64/Kconfig.platforms                    |    5 +
 arch/arm64/boot/dts/Makefile                    |    1 +
 arch/arm64/boot/dts/allwinner/Makefile          |    3 +
 .../dts/allwinner/sun50i-a64-amarula-relic.dts  |   65 +
 .../sun50i-a64-oceanic-5205-5inmfd.dts          |   68 ++
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts  |    2 -
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts   |   13 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |   75 +-
 .../sun50i-h5-emlid-neutis-n5-devboard.dts      |    3 +-
 .../allwinner/sun50i-h5-emlid-neutis-n5.dtsi    |    1 -
 .../allwinner/sun50i-h5-nanopi-neo-plus2.dts    |    5 +-
 .../dts/allwinner/sun50i-h5-nanopi-neo2.dts     |    2 +-
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts    |    4 +-
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts  |    4 +-
 .../allwinner/sun50i-h5-orangepi-zero-plus.dts  |    2 +-
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts |    3 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi    |    4 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts     |  260 ++++
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts |  215 ++++
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi  |    2 -
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   |    4 -
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |   41 +-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts |    3 +-
 arch/arm64/boot/dts/amlogic/Makefile            |    1 +
 .../boot/dts/amlogic/meson-g12a-sei510.dts      |  185 +++
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  147 +++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts     |  140 +++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     |  465 ++++++++
 .../dts/amlogic/meson-gxl-s905d-phicomm-n1.dts  |   10 +
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts    |    4 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi      |   27 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts     |  143 +++
 arch/arm64/boot/dts/bitmain/bm1880.dtsi         |   68 ++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  |    6 +
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts   |    6 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |   83 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   57 +-
 arch/arm64/boot/dts/freescale/Makefile          |    3 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts   |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi  |    2 +-
 .../boot/dts/freescale/fsl-ls1028a-qds.dts      |   62 +
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts      |   63 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi  |   64 +-
 .../boot/dts/freescale/fsl-ls1043a-rdb.dts      |    1 -
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |    2 -
 .../boot/dts/freescale/fsl-lx2160a-qds.dts      |   16 +
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts      |   16 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi  |   69 ++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts    |  235 ++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi       |  733 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts    |  129 ++
 .../dts/freescale/imx8mq-zii-ultra-rmb3.dts     |   95 ++
 .../dts/freescale/imx8mq-zii-ultra-zest.dts     |   24 +
 .../boot/dts/freescale/imx8mq-zii-ultra.dtsi    |  725 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       |  309 ++++-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts   |   95 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |   89 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       |   20 +-
 .../boot/dts/hisilicon/hi3670-hikey970.dts      |   75 ++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi       |   62 +
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi    |  115 ++
 arch/arm64/boot/dts/intel/Makefile              |    1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi   |  444 +++++++
 .../boot/dts/intel/socfpga_agilex_socdk.dts     |   75 ++
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts  |   13 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |   35 +-
 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h   | 1120 ++++++++++++++++++
 arch/arm64/boot/dts/nvidia/Makefile             |    1 +
 .../boot/dts/nvidia/tegra186-p2771-0000.dts     |  115 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi  |   42 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi        |  140 ++-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi  |    1 +
 .../boot/dts/nvidia/tegra194-p2972-0000.dts     |    2 -
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi  |    6 +
 .../boot/dts/nvidia/tegra210-p2371-2180.dts     |   12 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi  |    5 +
 arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi  |    6 +
 .../boot/dts/nvidia/tegra210-p3450-0000.dts     |  650 ++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts   |   12 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi        |   41 +-
 .../boot/dts/qcom/apq8096-db820c-pins.dtsi      |   52 +
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi |    8 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi    |  121 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |   46 +-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi      |   43 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |  558 ++++++++-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi       |   60 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi           |  315 ++++-
 arch/arm64/boot/dts/qcom/pm8005.dtsi            |    1 +
 arch/arm64/boot/dts/qcom/pm8998.dtsi            |    3 +
 arch/arm64/boot/dts/qcom/pmi8994.dtsi           |    1 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi           |    1 +
 arch/arm64/boot/dts/qcom/pms405.dtsi            |   11 +
 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts    |    3 +-
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts    |   85 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi        |   95 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi            |   23 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts         |    8 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |  427 ++++++-
 arch/arm64/boot/dts/renesas/cat875.dtsi         |   22 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi       |   12 +-
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts |   62 +
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi       |   44 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        |   72 +-
 .../boot/dts/renesas/r8a7796-salvator-x.dts     |    1 +
 .../boot/dts/renesas/r8a7796-salvator-xs.dts    |    1 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        |   13 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       |  324 ++++-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       |   16 +
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts  |   53 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |   74 +-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts  |   32 +-
 .../arm64/boot/dts/renesas/salvator-common.dtsi |   73 +-
 arch/arm64/boot/dts/rockchip/Makefile           |    2 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts       |    4 +-
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts     |    2 +-
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts  |   53 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts  |   33 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        |    7 +-
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi    |   34 +-
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts |    8 +-
 .../boot/dts/rockchip/rk3368-lion-haikou.dts    |   14 +-
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi   |   10 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts |   46 +-
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts |    6 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts     |   36 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        |  240 ++--
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts     |    6 +-
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts   |   18 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts |    2 +-
 .../dts/rockchip/rk3399-gru-chromebook.dtsi     |   14 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts      |    8 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi   |   68 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    |   56 +-
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts      |   69 +-
 .../boot/dts/rockchip/rk3399-nanopi-neo4.dts    |   50 +
 .../arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi |   27 +-
 .../arm64/boot/dts/rockchip/rk3399-orangepi.dts |  790 ++++++++++++
 .../boot/dts/rockchip/rk3399-puma-haikou.dts    |   12 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi   |   21 +-
 .../boot/dts/rockchip/rk3399-rock-pi-4.dts      |    5 +
 .../arm64/boot/dts/rockchip/rk3399-rock960.dtsi |   77 +-
 .../boot/dts/rockchip/rk3399-rockpro64.dts      |    6 +-
 .../boot/dts/rockchip/rk3399-sapphire.dtsi      |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |  314 ++---
 .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts |    1 +
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts      |    1 +
 .../boot/dts/xilinx/zynqmp-zcu102-revB.dts      |    1 +
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts      |    1 +
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts      |    1 +
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts      |    1 +
 .../{xlnx,zynqmp-clk.h => xlnx-zynqmp-clk.h}    |   26 +-
 include/dt-bindings/firmware/imx/rsrc.h         |   25 +-
 include/dt-bindings/pinctrl/am33xx.h            |  130 +-
 include/dt-bindings/pinctrl/omap.h              |    1 +
 include/dt-bindings/power/r8a77965-sysc.h       |    1 -
 513 files changed, 23982 insertions(+), 6172 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sunxi.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
 create mode 100644 arch/arm/boot/dts/am5718.dtsi
 create mode 100644 arch/arm/boot/dts/am5728.dtsi
 create mode 100644 arch/arm/boot/dts/am5748.dtsi
 create mode 100644 arch/arm/boot/dts/imx50-kobo-aura.dts
 create mode 100644 arch/arm/boot/dts/imx53-m53menlo.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts
 create mode 100644 arch/arm/boot/dts/imx7-mba7.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-tqma7.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-mba7.dts
 create mode 100644 arch/arm/boot/dts/imx7d-tqma7.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-zii-rpu2.dts
 create mode 100644 arch/arm/boot/dts/imx7s-mba7.dts
 create mode 100644 arch/arm/boot/dts/imx7s-tqma7.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-l4-abe.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-mcpdm.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-l4-abe.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-mighty.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-dk1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-dk2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-spb4.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
 create mode 100644 arch/arm64/boot/dts/intel/Makefile
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
 rename include/dt-bindings/clock/{xlnx,zynqmp-clk.h => xlnx-zynqmp-clk.h} (85%)
