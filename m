Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C34C76198
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBF82084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Zd3QF6LM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbfGSXy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 19:54:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfGSXyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 19:54:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so15111779pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+ba5sTgnEo24FEvAEuJiBf+D8fvYqWS+HejvWftA0o=;
        b=Zd3QF6LMFZeaOADjK/y0IZtCC4PlGOcWL35ke41E2dq3FueJvtbYmBSNtaTeKo4nkr
         4ML8DTPTT+Zu4Tok5HCN3Ose5zcUv2/j7PcL5gF0E7QLbtzfEbT4JGDEythjA8mmVyXL
         gGAGyYgDSjd/IOM+ueJDUtdBsfrWy6GXh5gZGSpOAqlMENhaSkMAeDvGbVDho7uV30Ss
         JtoyBDRbqJoRJDs5vS5VOew3KYZUaGd0CbToD6QGlYq+bCz14jiOb2srLeGl7nyq6ZDQ
         JJqhGFVXgvHHq7RoKo1G8/b9pDXCnxct80lGb/ndafU7zdxrMldnvoj4uPxv27ZVTXaq
         S7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+ba5sTgnEo24FEvAEuJiBf+D8fvYqWS+HejvWftA0o=;
        b=UDILtKXUqji21iucDDxG7gLr5anLYvBKuITSvbowXw84IjuaUx2BAToAiC8lQLvdyC
         GBSkZyj4tiIrNSnt5X0MQVXPRHKOVke2VwwMKXHIBiYsHCeEanb9oXbjbFjvF7pAgYT9
         dDud6NyPojOGOh6umcC/FC06EZ87T7EGEE5W0NvXsZj0E0Mb7GoejNzyfi4JfFk46VfX
         bJo8P6DjT2jDoU/kzsQknAzBn8guxq4dn/en7558tYBHCZBtxvwtVvxYbv5iqVTdZ0Ja
         66LGhywc7GnQYAOI6wQS6WKLmVqQjtSFrIPH/hctbv/NEvhHMasVYRof2NuUBOyFTeD1
         xl5g==
X-Gm-Message-State: APjAAAUHLyhWWLT+wCRelwQgHDsirQajF47MMR/AWe8pt1YE8+hZnSP7
        Xt+pUbFJr1xgPcCxknrMXkw=
X-Google-Smtp-Source: APXvYqxPn876rQWum3XxCB1vHkZM6Bu2RAwJp0jiAm/xdkKpoool1MVjgx6KVPGvB5X8Pg0GmcErAw==
X-Received: by 2002:a65:5687:: with SMTP id v7mr57843223pgs.263.1563580492593;
        Fri, 19 Jul 2019 16:54:52 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id v184sm31975215pfb.82.2019.07.19.16.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 16:54:51 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/4] ARM: Device-tree updates
Date:   Fri, 19 Jul 2019 16:54:33 -0700
Message-Id: <20190719235434.13214-4-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20190719235434.13214-1-olof@lixom.net>
References: <20190719235434.13214-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We continue to see a lot of new material. I've highlighted some of it
below, but there's been more beyond that as well.

One of the sweeping changes is that many boards have seen their ARM Mali
GPU devices added to device trees, since the DRM drivers have now been
merged.

So, with the caveat that I have surely missed several great
contributions, here's a collection of the material this time around:

New SoCs:

- Mediatek mt8183 (4x Cortex-A73 + 4x Cortex-A53)

- TI J721E (2x Cortex-A72 + 3x Cortex-R5F + 3 DSPs + MMA)

- Amlogic G12B (4x Cortex-A73 + 2x Cortex-A53)

New Boards / platforms:

- Aspeed BMC support for a number of new server platforms

- Kontron SMARC SoM (several i.MX6 versions)

- Novtech's Meerkat96 (i.MX7)

- ST Micro Avenger96 board

- Hardkernel ODROID-N2 (Amlogic G12B)

- Purism Librem5 devkit (i.MX8MQ)

- Google Cheza (Qualcomm SDM845)

- Qualcomm Dragonboard 845c (Qualcomm SDM845)

- Hugsun X99 TV Box (Rockchip RK3399)

- Khadas Edge/Edge-V/Captain (Rockchip RK3399)

Updated / expanded boards and platforms:

- Renesas r7s9210 has a lot of new peripherals added

- Polish and fixes for Rockchip-based Chromebooks

- Amlogic G12A has a lot of peripherals added

- Nvidia Jetson Nano sees various fixes and improvements, and is now at
feature parity with TX1

----------------------------------------------------------------

The following changes since commit 93d1bdc918e069d800537516c64ec334e15bd9f5:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

for you to fetch changes up to f90b8fda3a9d72a9422ea80ae95843697f94ea4a:

  ARM: dts: gemini: Set DIR-685 SPI CS as active low

----------------------------------------------------------------

Adam Ford (1):
      ARM: dts: Add LCD type 28 support to LogicPD Torpedo DM3730 devkit

Adriana Kobylak (2):
      ARM: dts: aspeed: Add Swift BMC machine
      ARM: dts: aspeed: swift: Add pca9539 devices

Akash Gajjar (1):
      arm64: dts: rockchip: add WiFi+BT support on ROCK Pi4 board

Alan Tull (1):
      ARM: dts: socfpga: add ltc2497 on arria10 devkit

Alexander Filippov (1):
      ARM: dts: aspeed: Add YADRO VESNIN BMC

Alexandre Belloni (5):
      ARM: dts: at91sam9261ek: remove unused chosen nodes
      ARM: dts: at91: at91sam9x5: switch to new sckc bindings
      ARM: dts: at91: at91sam9g45: switch to new sckc bindings
      ARM: dts: at91: at91sam9rl: switch to new sckc bindings
      ARM: dts: at91: sama5d3: switch to new sckc bindings

Alexandre Torgue (1):
      ARM: dts: stm32: use dedicated files to manage stm32mp157 packages

Amelie Delaunay (5):
      ARM: dts: stm32: add STMFX support on stm32746g-eval
      ARM: dts: stm32: add joystick support on stm32746g-eval
      ARM: dts: stm32: add orange and blue leds on stm32746g-eval
      ARM: dts: stm32: add STMFX support on stm32mp157c-ev1
      ARM: dts: stm32: add joystick support on stm32mp157c-ev1

Amit Kucheria (10):
      arm64: dts: sdm845: Fix up CPU topology
      arm64: dts: qcom: pms405: calibrate the VADC correctly
      arm64: dts: qcom: pms405: Rename adc outputs as per schematics
      arm64: dts: qcom: msm8916: Add entry-method property for the idle-states node
      arm64: dts: qcom: msm8916: Use more generic idle state names
      arm64: dts: qcom: msm8996: Add PSCI cpuidle low power states
      arm64: dts: msm8996: Add proper capacity scaling for the cpus
      arm64: dts: qcom: msm8998: Add PSCI cpuidle low power states
      arm64: dts: qcom: qcs404: Add tsens controller
      arm64: dts: qcom: qcs404: Add thermal zones for each sensor

Andrew Peng (1):
      ARM: dts: aspeed: Adding Lenovo Hr630 BMC

Andrey Smirnov (4):
      ARM: dts: vf610-zii-dev: Fix incorrect UART2 pin assignment
      ARM: dts: vf610-zii-dev: Add QSPI node
      ARM: dts: imx7d-zii-rpu2: Fix incorrrect 'stdout-path'
      ARM: dts: imx7d-zii-rpu2: Drop unused pinmux entries

Andy Gross (2):
      arm64: dts: qcom-qcs404: Add reset-cells to GCC node
      arm64: qcom: qcs404: Add reset-cells to GCC node

Angus Ainslie (Purism) (6):
      arm64: dts: fsl: imx8mq: add the snvs power key node
      dt-bindings: Add an entry for Purism SPC
      dt-bindings: arm: fsl: Add the imx8mq boards
      arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
      arm64: dts: librem5: Limit the USB to 5V
      arm64: dts: librem5: enable the SNVS power key

Anson Huang (27):
      ARM: dts: imx6sl: Assign corresponding clocks instead of dummy clock
      ARM: dts: imx6qdl: Assign corresponding clocks instead of dummy clock
      ARM: dts: imx7ulp: Add tpm pwm support
      ARM: dts: imx7ulp-evk: Add backlight support
      ARM: dts: imx6ul: add clock-frequency to CPU node
      ARM: dts: imx6qdl-sabresd: Assign corresponding power supply for LDOs
      ARM: dts: imx7d-sdb: Assign corresponding power supply for LDOs
      ARM: dts: imx6sl-evk: Assign corresponding power supply for LDOs
      ARM: dts: imx6sll-evk: Assign corresponding power supply for vdd3p0
      ARM: dts: imx6sx-sdb: Assign corresponding power supply for LDOs
      arm64: dts: imx8mq: Remove unnecessary blank lines
      arm64: dts: imx8mq: Add gpio alias
      arm64: dts: imx8qxp: Add gpio alias
      arm64: dts: imx8mm: add clock for GPIO node
      arm64: dts: imx8mm: add clock for SNVS RTC node
      arm64: dts: imx8mq: add clock for SNVS RTC node
      arm64: dts: imx8qxp: Move watchdog node into scu node
      ARM: dts: imx7d-sdb: Make SW2's voltage fixed
      arm64: dts: imx8mm: Move gic node into soc node
      arm64: dts: imx8mq-evk: Enable SNVS power key
      arm64: dts: imx8mm: Enable SNVS power key according to board design
      ARM: dts: imx6qdl: Enable SNVS power key according to board design
      ARM: dts: imx6sx: Enable SNVS power key according to board design
      ARM: dts: imx6ul: Enable SNVS power key according to board design
      ARM: dts: imx6sll: Enable SNVS power key according to board design
      ARM: dts: imx7s: Enable SNVS power key according to board design
      ARM: dts: imx6sll: Enable SNVS poweroff according to board design

Ash Hughes (1):
      ARM: dts: armada: netgear-rn104: Add LCD to RN104 dts.

Baolin Wang (1):
      arm64: dts: sprd: Add Spreadtrum SD host controller support

Bartosz Golaszewski (1):
      ARM: dts: da850-evm: enable cpufreq

Baruch Siach (1):
      arm64: dts: marvell: clearfog-gt-8k: set SFP power limit

Ben Ho (1):
      arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and Makefile

Benjamin Herrenschmidt (1):
      ARM: dts: aspeed: Add Power9 and Power9 CFAM description

Biju Das (22):
      arm64: dts: renesas: r8a774a1: Add VSP instances
      arm64: dts: renesas: r8a774a1: Add DU device to DT
      arm64: dts: renesas: r8a774a1: Add FDP1 instance
      arm64: dts: renesas: r8a774a1: Tie SYS-DMAC to IPMMU-DS0/1
      arm64: dts: renesas: r8a774a1: Tie Audio-DMAC to IPMMU-MP
      arm64: dts: renesas: r8a774a1: Connect Ethernet-AVB to IPMMU-DS0
      arm64: dts: renesas: cat874: Add WLAN support
      arm64: dts: renesas: cat874: Add BT support
      arm64: dts: renesas: Add HiHope RZ/G2M main board support
      arm64: dts: renesas: hihope-common: Add pincontrol support to scif2/scif clock
      arm64: dts: renesas: Add HiHope RZ/G2M sub board support
      arm64: dts: renesas: r8a774a1: Add PCIe device nodes
      arm64: dts: renesas: hihope-common: Declare pcie bus clock
      arm64: dts: renesas: hihope-rzg2-ex: Enable PCIe support
      arm64: dts: renesas: hihope-common: Add RWDT support
      arm64: dts: renesas: cat874: Enable USB3.0 host/peripheral device node
      arm64: dts: renesas: cat874: Enable usb role switch support
      arm64: dts: renesas: hihope-common: Enable USB3.0
      arm64: dts: renesas: r8a774a1: Add CPU topology on r8a774a1 SoC
      arm64: dts: renesas: r8a774a1: Add CPU capacity-dmips-mhz
      arm64: dts: renesas: r8a774a1: Create thermal zone to support IPA
      arm64: dts: renesas: r8a774a1: Add dynamic power coefficient

Bjorn Andersson (14):
      arm64: dts: qcom: sdm845-mtp: Make USB1 peripheral
      arm64: dts: qcom: qcs404: Add turingcc node
      arm64: dts: qcom: qcs404-evb: Mark CDSP clocks protected
      arm64: dts: qcom: qcs404: Add TCSR node
      arm64: dts: qcom: qcs404: Fully describe the CDSP
      arm64: dts: qcom: qcs404: Move lpass and q6 into soc
      arm64: dts: qcom: qcs404: Add rpmpd node
      arm64: dts: qcom: Add AOSS QMP node
      arm64: dts: qcom: msm8996: Stop using legacy clock names
      arm64: dts: qcom: qcs404: Add PCIe related nodes
      arm64: dts: qcom: qcs404-evb: Enable PCIe
      arm64: dts: qcom: Add Dragonboard 845c
      arm64: dts: qcom: msm8996: Correct apr-domain property
      arm64: dts: qcom: msm8996: Enable SMMUs

Brian Masney (3):
      ARM: dts: qcom: msm8974-hammerhead: add support for backlight
      ARM: dts: msm8974: add display support
      ARM: dts: qcom: msm8974-hammerhead: add support for display

Caesar Wang (1):
      ARM: dts: rockchip: fix PWM clock found on RK3288 Socs

Cao Van Dong (4):
      arm64: dts: renesas: r8a7796: Add TPU support
      arm64: dts: renesas: r8a77965: Add TPU support
      arm64: dts: renesas: r8a7795: Add TPU support
      dt-bindings: timer: renesas, cmt: Document r8a779{5|65|90} CMT support

Chen-Yu Tsai (4):
      arm64: dts: allwinner: axp803: add USB power supply node
      arm64: dts: allwinner: a64: bananapi-m64: Enable PMIC USB power supply
      ARM: dts: sun8i: a83t: Add device node for CSI (Camera Sensor Interface)
      arm64: dts: allwinner: h6: Pine H64: Add interrupt line for RTC

Chris Brandt (14):
      ARM: dts: r7s9210: Add RSPI
      ARM: dts: r7s9210: Add Ethernet support
      ARM: dts: r7s9210: Add RIIC support
      ARM: dts: r7s9210: Add SDHI support
      ARM: dts: rza2mevb: Add Ethernet support
      ARM: dts: rza2mevb: Add SDHI support
      ARM: dts: rza2mevb: add ethernet aliases
      ARM: dts: r7s9210: Add USB clock
      ARM: dts: rza2mevb: Add 48MHz USB clock
      ARM: dts: r7s9210: Add USB Host support
      ARM: dts: r7s9210: Add USB Device support
      ARM: dts: rza2mevb: Add USB Host support
      ARM: dts: r7s9210: Add IRQC device node
      ARM: dts: rza2mevb: Add input switch

Christian Hewitt (4):
      arm64: dts: meson-gxm-khadas-vim2: fix gpio-keys-polled node
      arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support
      arm64: dts: meson-gxbb-wetek: enable SARADC
      arm64: dts: meson-gxbb-wetek: enable bluetooth

Christophe Roullier (1):
      ARM: dts: stm32: replace rgmii mode with rgmii-id on stm32mp15 boards

Chuanhua Han (1):
      arm64: dts: ls1028a: fix watchdog device node

Clément Péron (3):
      dt-bindings: watchdog: add Allwinner H6 watchdog
      arm64: dts: allwinner: h6: add watchdog node
      arm64: dts: allwinner: h6: add r_watchog node

Daniel Baluta (3):
      arm64: dts: imx8mm: Add SAI nodes
      arm64: dts: imx8mm-evk: Enable audio codec wm8524
      arm64: dts: imx8qxp: Add lsio_mu13 node

Daniel Lezcano (2):
      arm64: dts: rockchip: Fix multiple thermal zones conflict in rk3399.dtsi
      arm64: dts: rockchip: Define values for the IPA governor for rock960

Daniel Mack (5):
      ARM: pxa3xx: dts: Add defines for pinctrl-single,bias-pull{up,down}
      ARM: pxa: raumfeld-controller: fix 'dock detect' GPIO key
      ARM: pxa: raumfeld-controller: add pinctrl for charger pins
      ARM: pxa: raumfeld-common: fix comments in gpio_keys pinctrl node
      ARM: dts: pxa300-raumfeld-speaker-one: add channel output mapping for STA320

Daniel Schultz (1):
      ARM: dts: am335x-phycore-som: Add emmc node

David Lechner (4):
      ARM: dts: da850: add cpu node and operating points to DT
      ARM: dts: da850-lego-ev3: enable cpufreq
      ARM: dts: da850-lcdk: enable cpufreq
      ARM: davinci_all_defconfig: Enable CPUFREQ_DT

Dien Pham (4):
      arm64: dts: renesas: r8a7795: Create thermal zone to support IPA
      arm64: dts: renesas: r8a7796: Create thermal zone to support IPA
      arm64: dts: renesas: r8a77965: Create thermal zone to support IPA
      arm64: dts: renesas: r8a77990: Create thermal zone to support IPA

Dinh Nguyen (3):
      ARM: dts: socfpga: use the "altr,socfpga-stmmac-a10-s10" binding
      arm64: dts: stratix10: use the "altr,socfpga-stmmac-a10-s10" binding
      ARM: dts: arria10: Add EMAC OCP reset property

Douglas Anderson (12):
      ARM: dts: rockchip: Remove bogus 'i2s_clk_out' from rk3288-veyron-mickey
      ARM: dts: rockchip: Make rk3288-veyron-mickey's emmc work again
      ARM: dts: rockchip: Make rk3288-veyron-minnie run at hs200
      ARM: dts: rockchip: Add pin names for rk3288-veyron-minnie
      ARM: dts: rockchip: Add pin names for rk3288-veyron-jerry
      ARM: dts: rockchip: Mark that the rk3288 timer might stop in suspend
      ARM: dts: rockchip: Add pin names for rk3288-veyron jaq, mickey, speedy
      ARM: dts: rockchip: Switch to builtin HDMI DDC bus on rk3288-veyron
      ARM: dts: rockchip: Add unwedge pinctrl entries for dw_hdmi on rk3288
      ARM: dts: rockchip: Add HDMI i2c unwedging for rk3288-veyron
      ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up signal on veyron
      ARM: dts: rockchip: Configure BT_DEV_WAKE in on rk3288-veyron

Eddie James (1):
      ARM: dts: aspeed: Enable video engine on romulus and wtherspoon

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: Update DWC3 modules on RK3399 SoCs

Erin Lo (1):
      arm64: dts: mt8183: add spi node

Evan Green (1):
      arm64: dts: msm8996: Add UFS PHY reset controller

Ezequiel Garcia (1):
      arm64: dts: rockchip: Enable HDMI audio on Rock Pi

Fabio Estevam (3):
      arm64: dts: imx8mm: Pass a unit name for the 'soc' node
      arm64: dts: imx8mm: Pass the 'ranges' property
      arm64: dts: imx8mm: Move usbphy out of soc node

Fabrizio Castro (20):
      arm64: dts: renesas: cat874: Add HDMI video support
      arm64: dts: renesas: cat874: Add HDMI audio
      dt-bindings: arm: renesas: Add HopeRun RZ/G2[M] boards
      dt-bindings: Add vendor prefix for HopeRun
      arm64: dts: renesas: r8a774a1: Add operating points
      arm64: dts: renesas: hihope-common: Add uSD and eMMC
      arm64: dts: renesas: r8a774a1: Add CMT device nodes
      arm64: dts: renesas: r8a774a1: Add TMU device nodes
      dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
      dt-bindings: can: rcar_can: Add r8a774c0 support
      arm64: dts: renesas: r8a774a1: Fix USB 2.0 clocks
      arm64: dts: renesas: hihope-common: Add USB 2.0 support
      dt-bindings: can: rcar_canfd: document r8a774c0 support
      arm64: dts: renesas: hihope-common: Add LEDs support
      dt-bindings: display: renesas: Add r8a774a1 support
      arm64: dts: renesas: r8a774a1: Add HDMI encoder instance
      arm64: dts: renesas: hihope-common: Add HDMI support
      arm64: dts: renesas: hihope-common: Remove "label" from LEDs
      ARM: dts: iwg20d-q7-common: Fix SDHI1 VccQ regularor
      ARM: dts: iwg23s-sbc: Fix SDHI2 VccQ regulator

Florian Fainelli (8):
      Merge tag 'tags/bcm2835-dt-next-2019-06-01' into devicetree/next
      ARM: dts: Fix BCM7445 DTC warnings
      ARM: dts: Cygnus: Fix most DTC W=1 warnings
      ARM: dts: bcm-mobile: Fix most DTC W=1 warnings
      ARM: dts: BCM53573: Fix DTC W=1 warnings
      ARM: dts: BCM63xx: Fix DTC W=1 warnings
      ARM: dts: NSP: Fix the bulk of W=1 DTC warnings
      ARM: dts: BCM5301X: Fix most DTC W=1 warnings

Frank Li (1):
      arm64: dts: imx8qxp: added ddr performance monitor nodes

Geert Uytterhoeven (2):
      ARM: dts: r7s72100: Add IRQC device node
      ARM: dts: rskrza1: Add input switches

Guido Günther (1):
      arm64: dts: imx8mq: Add a node for irqsteer

Guillaume La Roque (2):
      arm64: dts: meson: g12a: add i2c nodes
      arm64: dts: meson-g12a-x96-max: add support for sdcard and emmc

Harald Geyer (1):
      arm64: dts: allwinner: a64: Enable audio on Teres-I

Heiko Stuebner (2):
      Merge branch 'v5.3-shared/clk-ids' into v5.3-armsoc/dts32
      Merge branch 'v5.3-shared/clk-ids' into v5.3-armsoc/dts64

Heinrich Schuchardt (1):
      arm64: dts: marvell: mcbin: enlarge PCI memory window

Helen Koike (1):
      arm64: dts: rockchip: fix isp iommu clocks and power domain

Hongwei Zhang (1):
      ARM: dts: aspeed: Add Microsoft Olympus BMC

Horia Geantă (1):
      arm64: dts: ls1028a: add crypto node

Hsin-Yi, Wang (1):
      arm64: dts: mt8183: add capacity-dmips-mhz

Hugues Fruchet (3):
      ARM: dts: stm32: add DCMI camera interface support on stm32mp157c
      ARM: dts: stm32: add DCMI pins to stm32mp157c
      ARM: dts: stm32: enable OV5640 camera on stm32mp157c-ev1 board

Icenowy Zheng (2):
      arm64: dts: allwinner: h6: add PIO VCC bank supplies for Pine H64
      arm64: dts: allwinner: a64: Add pinmux for RGB666 LCD

Igor Opaniuk (1):
      ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1

Jagan Teki (3):
      arm64: dts: allwinner: a64: move I2C pinctrl to dtsi
      arm64: dts: allwinner: a64-amarula-relic: Add GT5663 CTP node
      arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable GT911 CTP

Jernej Skrabec (3):
      arm64: dts: allwinner: a64: orangepi-win: Add wifi and bluetooth nodes
      ARM: dts: sun8i-h3: Fix wifi in Beelink X2 DT
      arm64: dts: allwinner: h6: Add DMA node

Jerome Brunet (35):
      arm64: dts: meson: libretech-cc: set eMMC as removable
      arm64: dts: meson: libretech-cc: switch eMMC to 1.8v
      arm64: dts: meson: fix mmc pin bias
      arm64: dts: meson: fix mmc v2 chips max frequencies
      arm64: dts: meson: vim2: add missing clk-gate pinctrl
      arm64: dts: meson: vim2: remove sd hs and hs400 modes from emmc
      arm64: dts: meson: sei510: consistently order nodes
      arm64: dts: meson: u200: consistently order nodes
      arm64: dts: meson: nanopi k2: add sd DDR50
      arm64: dts: meson: odroid-c2: add missing mmc modes
      arm64: dts: meson: g12a: add mmc nodes
      arm64: dts: meson: u200: add sd and emmc
      arm64: dts: meson: sei510: add sd and emmc
      arm64: dts: meson: g12a: set uart_ao clocks
      arm64: dts: meson: u200: enable i2c busses
      arm64: dts: meson: sei510: enable i2c3
      arm64: dts: meson: g12a: add audio clock controller
      arm64: dts: meson: g12a: add audio memory arbitrer
      arm64: dts: meson: g12a: add audio fifos
      arm64: dts: meson: g12a: add tdm
      arm64: dts: meson: g12a: add spdifouts
      arm64: dts: meson: g12a: add pdm
      arm64: dts: meson: g12a: add spdifin
      arm64: dts: meson: g12a: enable hdmi_tx sound dai provider
      arm64: dts: meson: sei510: add bluetooth supplies
      arm64: dts: meson: g12a: add tohdmitx
      arm64: dts: meson: g12a: add ethernet mac controller
      arm64: dts: meson: g12a: add ethernet pinctrl definitions
      arm64: dts: meson: g12a: add mdio multiplexer
      arm64: dts: meson: u200: add internal network
      arm64: dts: meson: sei510: add network support
      arm64: dts: meson: add dwmac-3.70a to ethmac compatible list
      arm64: dts: meson: g12a: add SDIO controller
      arm64: dts: meson: sei510: add sound card
      arm64: dts: meson: g12a: sort sdio nodes correctly

Jianqun Xu (1):
      arm64: dts: rockchip: add core dtsi file for RK3399Pro SoCs

Joel Stanley (1):
      ARM: dts: aspeed: Rename flash-controller nodes

John Keeping (1):
      ARM: dts: rockchip: fix pwm-cells for rk3288's pwm3

John Stultz (1):
      arm64: dts: qcom: pm8998: Use qcom,pm8998-pon binding for second gen pon

John Wang (1):
      ARM: dts: aspeed: Add Inspur fp5280g2 BMC machine

Jon Hunter (3):
      arm64: tegra: Fix AGIC register range
      arm64: tegra: Update Jetson TX1 GPU regulator timings
      arm64: tegra: Fix Jetson Nano GPU regulator

Jonathan Marek (1):
      ARM: dts: qcom: msm8974-hammerhead: add touchscreen support

Jordan Crouse (2):
      arm64: dts: sdm845: Add gpu and gmu device nodes
      arm64: dts: sdm845: Add zap shader region for GPU

Jorge Ramirez-Ortiz (1):
      arm64: dts: qcom: qcs404-evb: fix vdd_apc supply

Joseph Lo (1):
      arm64: tegra: Add CPU cache topology for Tegra186

Justin Swartz (2):
      ARM: dts: rockchip: fix vop iommu-cells on rk322x
      ARM: dts: rockchip: add display nodes for rk322x

Katsuhiro Suzuki (1):
      arm64: dts: rockchip: add PCIe nodes on rk3399-rockpro64

Keerthy (3):
      arm64: dts: ti: am6-wakeup: Add gpio node
      arm64: dts: ti: am6-main: Add gpio nodes
      arm64: dts: ti: am654-base-board: Add gpio_keys node

Kevin Hilman (2):
      Merge tag 'clk-meson-5.2-1-fixes' of https://github.com/BayLibre/clk-meson into v5.3/dt64
      Merge tag 'asoc-tohdmitx' of https://git.kernel.org/.../broonie/sound into HEAD

Kishon Vijay Abraham I (6):
      arm64: dts: k3-am6: Add "socionext,synquacer-pre-its" property to gic_its
      arm64: dts: k3-am6: Add mux-controller DT node required for muxing SERDES
      arm64: dts: k3-am6: Add SERDES DT node
      arm64: dts: k3-am6: Add PCIe Root Complex DT node
      arm64: dts: k3-am6: Add PCIe Endpoint DT node
      arm64: dts: ti: am654-base-board: Disable SERDES and PCIe

Konstantin Porotchkin (1):
      arm64: dts: marvell: Disable AP I2C on Armada-8040-DB

Krzysztof Kozlowski (16):
      ARM: dts: exynos: Move CPU OPP tables out of SoC node on Exynos5420
      ARM: dts: exynos: Raise maximum buck regulator voltages on Arndale Octa
      ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU
      ARM: dts: exynos: Add PMU interrupt affinity to Exynos4 boards
      ARM: dts: exynos: Fix language typo and indentation
      ARM: dts: exynos: Disable unused buck10 regulator on Odroid HC1 board
      ARM: dts: exynos: Add regulator suspend configuration to Arndale Octa board
      ARM: dts: exynos: Add regulator suspend configuration to Odroid XU3/XU4/HC1 family
      ARM: dts: exynos: Use proper regulator for eMMC memory on Arndale Octa
      arm64: dts: exynos: Add GPU/Mali T760 node to Exynos5433
      arm64: dts: exynos: Add GPU/Mali T760 node to Exynos7
      dt-bindings: gpu: mali: Add Samsung compatibles for Midgard and Utgard
      ARM: dts: exynos: Add GPU/Mali 400 node to Exynos3250
      ARM: dts: exynos: Add GPU/Mali 400 node to Exynos4
      ARM: dts: exynos: Adjust buck[78] regulators to supported values on Odroid XU3 family
      ARM: dts: exynos: Adjust buck[78] regulators to supported values on Arndale Octa

Laurent Pinchart (1):
      arm64: dts: renesas: r8a7799[05]: Point LVDS0 to its companion LVDS1

Leo Yan (10):
      ARM: dts: imx7s: Update coresight DT bindings
      arm64: dts: juno: update coresight DT bindings
      ARM: dts: vexpress-v2p-ca15_a7: update coresight DT bindings
      arm64: dts: qcom-msm8916: Update coresight DT bindings
      ARM: dts: qcom-apq8064: Update coresight DT bindings
      ARM: dts: qcom-msm8974: Update coresight DT bindings
      arm64: dts: hi6220: Update coresight DT bindings
      ARM: dts: hip04: Update coresight DT bindings
      arm64: dts: sc9836: Update coresight DT bindings
      arm64: dts: sc9860: Update coresight DT bindings

Leonard Crestez (4):
      arm64: dts: imx8mm-evk: Add BD71847 PMIC
      arm64: dts: imx8mm: Add cpu speed grading and all OPPs
      arm64: dts: imx8mq: Add cpu speed grading and all OPPs
      ARM: dts: imx7d: Update cpufreq OPP table

Leonidas P. Papadakos (1):
      arm64: dts: rockchip: enable rk3328 watchdog clock

Linus Walleij (6):
      ARM: dts: integrator: specify AFS partition
      ARM: dts: versatile: specify AFS partition
      ARM: dts: realview: specify AFS partition
      ARM: dts: vexpress: specify AFS partition
      arm64: dts: juno: set the right partition type for NOR flash
      ARM: dts: gemini: Set DIR-685 SPI CS as active low

Lokesh Vutla (5):
      arm64: dts: ti: k3-am654: Update compatible for dmsc
      arm64: dts: ti: k3-am654: Add interrupt controllers in main domain
      arm64: dts: ti: k3-am654: Add interrupt controllers in wakeup domain
      arm64: dts: ti: k3-j721e: Add interrupt controllers in main domain
      arm64: dts: ti: k3-j721e: Add interrupt controllers in wakeup domain

Luca Weiss (3):
      dt-bindings: input: sun4i-lradc-keys: Add A64 compatible
      arm64: dts: allwinner: a64: Add lradc node
      ARM: dts: msm8974-FP2: Add vibration motor

Ludovic Barre (2):
      ARM: dts: stm32: add pinctrl sleep config for qspi on stm32mp157c-ev1
      ARM: dts: stm32: add jedec compatible for nor flash on stm32mp157c-ev1

Lukas Wunner (1):
      ARM: bcm283x: Enable DMA support for SPI controller

Magnus Damm (3):
      arm64: dts: renesas: Use ip=on for bootargs
      ARM: dts: renesas: Use ip=on for bootargs
      ARM: dts: r8a7792: Add CMT0 and CMT1 to r8a7792

Manikanta Maddireddy (1):
      arm64: tegra: Add PEX DPD states as pinctrl properties

Manivannan Sadhasivam (8):
      arm64: dts: rockchip: Enable SPI0 and SPI4 on Rock960
      arm64: dts: rockchip: Enable SPI1 on Ficus
      dt-bindings: arm: Document 96Boards Meerkat96 devicetree binding
      ARM: dts: Add support for 96Boards Meerkat96 board
      ARM: dts: stm32: Add missing pinctrl definitions for STM32MP157
      dt-bindings: arm: stm32: Convert STM32 SoC bindings to DT schema
      dt-bindings: arm: stm32: Document Avenger96 devicetree binding
      ARM: dts: stm32: Add Avenger96 devicetree support based on STM32MP157A

Marc Gonzalez (2):
      arm64: dts: qcom: msm8998: Add ANOC1 SMMU node
      arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes

Marek Szyprowski (2):
      ARM: dts: exynos: Fix imprecise abort on Mali GPU probe on Exynos4210
      ARM: dts: exynos: Move Mali400 GPU node to "/soc"

Marek Vasut (12):
      ARM: dts: imx53: Update UART configuration on M53Menlo
      ARM: dts: imx53: Update USB configuration on M53Menlo
      ARM: dts: imx53: Add ethernet PHY reset on M53Menlo
      ARM: dts: imx53: Select netdev trigger for Yellow LED on M53Menlo
      ARM: dts: imx53: Add power GPIOs on M53Menlo
      ARM: dts: imx53: Add GPIO beeper on M53Menlo
      ARM: dts: imx53: Add GPIO line names on M53Menlo
      ARM: dts: imx53: Update pinmux settings on M53Menlo
      ARM: dts: r8a779x: Configure PMIC IRQ pinmux
      ARM: dts: imx53: Bind CPLD on M53Menlo
      dt-bindings: can: rcar_canfd: document r8a77965 support
      dt-bindings: can: rcar_canfd: document r8a77990 support

Martin Blumenstingl (14):
      arm64: dts: amlogic: remove ethernet-phy-idAAAA.BBBB compatible strings
      ARM: dts: meson8: add the canvas module
      ARM: dts: meson8m2: update the offset of the canvas module
      ARM: dts: meson8b: add the canvas module
      ARM: dts: meson8m2: mxiii-plus: rename the DCDC2 regulator
      ARM: dts: meson8m2: mxiii-plus: add the supply for the Mali GPU
      ARM: dts: meson8b: mxq: improve support for the TRONFY MXQ S805
      arm64: dts: meson: g12a: add the GPIO interrupt controller
      arm64: dts: meson: g12a: x96-max: fix the Ethernet PHY reset line
      arm64: dts: meson: use the generic Ethernet PHY reset GPIO bindings
      arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY reset line
      arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY interrupt line
      arm64: dts: meson: g12a: x96-max: add the Ethernet PHY interrupt line
      ARM: dts: meson: switch to the generic Ethernet PHY reset bindings

Masahiro Yamada (3):
      ARM: dts: uniphier: update to new Denali NAND binding
      arm64: dts: uniphier: update to new Denali NAND binding
      arm64: dts: uniphier: add reserved-memory for secure memory

Matthias Kaehlcke (10):
      ARM: dts: rockchip: raise CPU trip point temperature for veyron to 100 degC
      ARM: dts: rockchip: raise GPU trip point temperatures for veyron
      ARM: dts: raise GPU trip point temperature for speedy to 80 degC
      ARM: dts: rockchip: Add #cooling-cells entry for rk3288 GPU
      ARM: dts: rockchip: Use GPU as cooling device for the GPU thermal zone of the rk3288
      ARM: dts: rockchip: remove GPU 500 MHz OPP on rk3288
      ARM: dts: rockchip: Use the GPU to cool CPU thermal zone of veyron mickey
      ARM: dts: rockchip: Configure the GPU thermal zone for mickey
      ARM: dts: rockchip: Split GPIO keys for veyron into multiple devices
      Revert "ARM: dts: rockchip: set PWM delay backlight settings for Minnie"

Maxim Sloyko (1):
      ARM: dts: aspeed: zaius: add Infineon and Intersil regulators

Maxime Jourdan (1):
      arm64: dts: meson: sei510: add max98357a DAC

Maxime Ripard (12):
      dt-bindings: bus: Convert Allwinner RSB to a schema
      ARM: dts: sun6i: Add default address and size cells for SPI
      ARM: dts: sunxi: h3/h5: Fix GPIO regulator state array
      ARM: dts: sun8i: a711: Change LRADC node names to avoid warnings
      ARM: dts: sun7i: icnova-swac: Fix the model vendor
      ARM: dts: gr8-evb: Fix RTC vendor
      ARM: dts: sun6i: Fix RTC node
      ARM: dts: sun6i: Add external crystals accuracy
      ARM: dts: sun8i: v3s: Fix the RTC node
      ARM: dts: sun8i: v3s: Add external crystals accuracy
      ARM: dts: sun8i: r40: Change the RTC compatible
      dt-bindings: pwm: Convert Allwinner PWM to a schema

Michael Grzeschik (1):
      ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC SoM Support

Michael Mei (1):
      arm64: dts: mt8183: add efuse and Mediatek Chip id node to read

Miquel Raynal (3):
      arm64: dts: marvell: Change core numbering in AP806 thermal-node
      arm64: dts: marvell: Enable AP806 thermal throttling with CPUfreq
      arm64: dts: marvell: armada-7040-db: Add USB current regulators

Neil Armstrong (33):
      arm64: dts: meson-g12a: Add PWM nodes
      arm64: dts: meson-g12a: Add IR nodes
      arm64: dts: meson-g12a-x96-max: enable IR decoder
      arm64: dts: meson-g12a-u200: enable IR decoder
      ARM: dts: meson: update with SPDX Licence identifier
      ARM: dts: meson6-atv1200: update with SPDX Licence identifier
      ARM: dts: meson6: update with SPDX Licence identifier
      ARM: dts: meson8-minix-neo-x8: update with SPDX Licence identifier
      ARM: dts: meson8: update with SPDX Licence identifier
      ARM: dts: meson8b-mxq: update with SPDX Licence identifier
      ARM: dts: meson8b-odroidc1: update with SPDX Licence identifier
      ARM: dts: meson8b: update with SPDX Licence identifier
      arm64: dts: meson: g12a: add drive-strength hdmi ddc pins
      arm64: dts: meson: g12a: add drive strength for eth pins
      arm64: dts: meson: g12a: Add hwrng node
      arm64: dts: meson-g12a-x96-max: Add Gigabit Ethernet Support
      arm64: dts: meson-gxbb-vega-s95: fix regulators
      arm64: dts: meson-gxbb-vega-s95: add HDMI nodes
      arm64: dts: meson-gxbb-vega-s95: enable CEC
      arm64: dts: meson-gxbb-vega-s95: enable SARADC
      arm64: dts: meson-gxbb-vega-s95: fix WiFi/BT module support
      arm64: dts: meson-gxbb-vega-s95: add ethernet PHY interrupt
      dt-bindings: arm: amlogic: add G12B bindings
      dt-bindings: arm: amlogic: add Odroid-N2 binding
      arm64: dts: meson: Add minimal support for Odroid-N2
      arm64: dts: meson-g12a-x96-max: Enable Wifi SDIO Module
      arm64: dts: meson-g12a-sei510: Enable Wifi SDIO module
      arm64: dts: meson-g12a-sei510: add 32k clock to bluetooth node
      arm64: dts: meson-g12a-x96-max: add 32k clock to bluetooth node
      arm64: dts: meson-g12a-sei510: bump bluetooth bus speed to 2Mbaud/s
      arm64: dts: meson-g12a-x96-max: bump bluetooth bus speed to 2Mbaud/s
      arm64: dts: meson-g12b-odroid-n2: add sound card
      arm64: dts: meson-g12a-x96-max: add sound card

Nick Xie (1):
      arm64: dts: rockchip: Add support for Khadas Edge/Edge-V/Captain boards

Nicolin Chen (1):
      arm64: tegra: Add INA3221 channel info for Jetson TX2

Niklas Cassel (5):
      arm64: dts: qcom: qcs404-evb: fix l3 min voltage
      arm64: dts: qcom: qcs404-evb: increase s3 max voltage
      arm64: dts: qcom: qcs404: Add PSCI cpuidle low power states
      arm64: dts: msm8996: fix PSCI entry-latency-us
      arm64: dts: qcom: qcs404: Add missing space for cooling-cells property

Nishanth Menon (6):
      dt-bindings: arm: ti: Add bindings for J721E SoC
      dt-bindings: serial: 8250_omap: Add compatible for J721E UART controller
      arm64: dts: ti: Add Support for J721E SoC
      soc: ti: Add Support for J721E SoC config option
      arm64: dts: ti: Add support for J721E Common Processor Board
      arm64: defconfig: Enable TI's J721E SoC platform

Olivier Moysan (5):
      ARM: dts: stm32: add sai support on stm32mp157c
      ARM: dts: stm32: add sai pins muxing on stm32mp157
      ARM: dts: stm32: add i2s support on stm32mp157c
      ARM: dts: stm32: add i2s pins muxing on stm32mp157
      ARM: dts: stm32: add sai id registers to stm32mp157c

Olof Johansson (48):
      Merge tag 'integrator-dts-v5.3-arm-soc' of git://git.kernel.org/.../linusw/linux-integrator into arm/dt
      Merge tag 'v5.3-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.3-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'arm-soc/for-5.3/devicetree-arm64' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'omap-for-v5.3/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'omap-for-v5.3/ti-sysc-dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'juno-updates-5.3' of git://git.kernel.org/.../sudeep.holla/linux into arm/dt
      Merge tag 'vexpress-updates-5.3' of git://git.kernel.org/.../sudeep.holla/linux into arm/dt
      Merge tag 'samsung-dt-5.3' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'socfpga_dts_updates_for_v5.3' of git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge tag 'ti-k3-soc-for-v5.3' of git://git.kernel.org/.../kristo/linux into arm/dt
      Merge tag 'arm-soc/for-5.3/devicetree-v2' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'hisi-arm64-dt-for-5.3' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'hisi-arm32-dt-for-5.3' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'qcom-arm64-for-5.3' of git://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'qcom-dts-for-5.3' of git://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'aspeed-5.3-devicetree' of git://git.kernel.org/.../joel/aspeed into arm/dt
      Merge tag 'davinci-for-v5.3/dt' of git://git.kernel.org/.../nsekhar/linux-davinci into arm/dt
      Merge tag 'amlogic-dt' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'sunxi-dt-for-5.3-201906210807' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'sunxi-dt64-for-5.3-201906210808' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'sunxi-h3-h5-for-5.3-201906210812' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.3' of https://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.3' of https://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'renesas-arm64-dt-for-v5.3' of https://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'mvebu-dt-5.3-1' of git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'mvebu-dt64-5.3-1' of git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'stm32-dt-for-v5.3-1' of git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'tegra-for-5.3-arm64-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'at91-5.3-dt' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'pxa-dt-5.3' of https://github.com/rjarzmik/linux into arm/dt
      Merge tag 'imx-bindings-5.3' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-clkdep-5.3' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.3' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-5.3' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'amlogic-dt64' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'v5.2-next-dts64' of https://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'uniphier-dt-v5.3' of git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'uniphier-dt64-v5.3' of git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'samsung-dt-5.3-2' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'samsung-dt64-5.3' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'qcom-arm64-for-5.3-2' of git://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'qcom-dts-for-5.3-2' of git://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'sprd-dt-v5.3-rc1' of https://github.com/lyrazhang/linux into arm/dt
      Merge tag 'v5.3-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.3-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'sunxi-dt64-for-5.3-round-2' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'samsung-dt-5.3-3' of https://git.kernel.org/.../krzk/linux into arm/dt

Pablo Greco (7):
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Add GPIO pin-bank regulator supplies
      ARM: dts: sun8i: v40: bananapi-m2-berry: Add GPIO pin-bank regulator supplies
      ARM: dts: sun8i: v40: bananapi-m2-berry: Enable GMAC ethernet controller
      ARM: dts: sun8i: v40: bananapi-m2-berry: Enable HDMI output
      ARM: dts: sun8i: v40: bananapi-m2-berry: Enable AHCI
      ARM: dts: sun8i: v40: bananapi-m2-berry: Add Bluetooth device node
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Remove regulator-always-on

Patrick Venture (2):
      ARM: dts: aspeed: Add aspeed-p2a-ctrl node
      ARM: dts: aspeed: quanta-q71: Enable p2a node

Peng Fan (1):
      arm64: dts: imx: add i.MX8QXP ocotp support

Peng Ma (3):
      arm64: dts: ls1028a: Enable sata.
      dt-bindings: fsl-qdma: Add LS1028A qDMA bindings
      arm64: dts: fsl: ls1028a: Add qDMA node

Peter Chen (2):
      ARM: dts: imx7ulp: add imx7ulp USBOTG1 support
      ARM: dts: imx7ulp-evk: enable USBOTG1 support

Peter Geis (1):
      arm64: dts: rockchip: improve rk3328-roc-cc rgmii performance.

Peter Robinson (3):
      ARM: dts: imx6sx-udoo: Use the correct style for SPDX License Identifier
      ARM: dts: imx6sx-udoo-neo: enable i2c-2 and i2c-4 for onboard sensors
      ARM: dts: imx6sx-udoo-neo: add bluetooth config to uart3

Pierre-Yves MORDRET (3):
      ARM: dts: stm32: Add Vivante GPU support on STM32MP157c
      ARM: dts: stm32: enable Vivante GPU support on stm32mp157c-ed1 board
      ARM: dts: stm32: enable Vivante GPU support on stm32mp157a-dk1 board

Pramod Kumar (1):
      arm64: dts: stingray: Add Stingray Thermal DT support.

Priit Laes (2):
      ARM: dts: sun7i: olimex-lime2: Enable ac and power supplies
      ARM: dts: imx6qdl-kontron-samx6i: Add iMX6-based Kontron SMARC-sAMX6i module

Raju P.L.S.S.S.N (1):
      arm64: dts: qcom: sdm845: Add PSCI cpuidle low power states

Ran Wang (1):
      arm64: dts: ls1028a: Add USB dt nodes

Rayagonda Kokatanur (1):
      arm64: dts: Stingray: Add NIC i2c device node

Rob Clark (1):
      arm64: dts: qcom: sdm845-cheza: add initial cheza dt

Rob Herring (8):
      dt-bindings: arm: amlogic: Move 'amlogic, meson-gx-ao-secure' binding to its own file
      dt-bindings: arm: Convert Amlogic board/soc bindings to json-schema
      ARM: dts: imx: Avoid colliding 'display' node and property names
      dt-bindings: arm: Convert MediaTek board/soc bindings to json-schema
      dt-bindings: arm: Move Emtrion i.MX6 board bindings to schema
      dt-bindings: arm: fsl: Add back missing i.MX7ULP binding
      dt-bindings: arm: fsl: Add missing schemas for i.MX1/31/35
      dt-bindings: arm: Convert Atmel board/soc bindings to json-schema

Robert Lippert (2):
      ARM: dts: aspeed: zaius: update 12V brick I2C address
      ARM: dts: aspeed: zaius: fixed I2C bus numbers for pcie slots

Robin Murphy (1):
      arm64: dts: renesas: r8a774c0: Clean up CPU compatibles

Roger Quadros (1):
      arm64: dts: ti: k3-am65: Add MSMC RAM ranges in interconnect node

Russell King (1):
      arm64: dts: marvell: add missing #interrupt-cells property

Sameer Pujar (2):
      arm64: tegra: Add ACONNECT, ADMA and AGIC nodes
      arm64: tegra: Enable ACONNECT, ADMA and AGIC

Shawn Guo (2):
      arm64: dts: imx8qxp: sort alias alphabetically
      arm64: dts: imx8qxp: sort LSIO subsystem devices

Sibi Sankar (2):
      arm64: dts: qcom: msm8998: Add rpmpd node
      arm64: dts: qcom: sdm845: Add Q6V5 MSS node

Simon Horman (5):
      arm64: dts: renesas: draak: Remove unnecessary index from vin4 port
      arm64: dts: renesas: r8a7795: Add dynamic power coefficient
      arm64: dts: renesas: r8a7796: Add dynamic power coefficient
      arm64: dts: renesas: r8a77965: Add dynamic power coefficient
      arm64: dts: renesas: r8a77990: Add dynamic power coefficient

Simon Shields (1):
      ARM: dts: exynos: Add flash support to Galaxy S3 boards

Spyridon Papageorgiou (1):
      arm64: dts: renesas: ulcb-kf: Add support for TI WL1837

Srinath Mannam (1):
      arm64: dts: Add USB DT nodes for Stingray SoC

Steve Longerbeam (2):
      ARM: dts: imx53: Add capture-subsystem device
      ARM: dts: imx53-smd: Add OV5642 video capture support

Sudeep Holla (2):
      arm: dts: vexpress-v2p-ca15_a7: disable NOR flash node by default
      ARM: dts: vexpress: set the right partition type for NOR flash

Suman Anna (5):
      arm64: dts: ti: k3-am65: Add MCU SRAM ranges in interconnect nodes
      arm64: dts: ti: k3-am65-mcu: Add the MCU RAM node
      arm64: dts: ti: k3-am65: Add R5F ranges in interconnect nodes
      arm64: dts: ti: k3-j721e-main: Add Main NavSS Interrupt controller node
      arm64: dts: ti: k3-j721e: Add the MCU SRAM node

Sébastien Szymanski (1):
      ARM: dts: imx6ul: Add PXP node

Takeshi Kihara (2):
      arm64: dts: renesas: ebisu: Remove renesas, no-ether-link property
      arm64: dts: renesas: r8a77990: Fix register range of display node

Tao Ren (2):
      ARM: dts: aspeed: cmm: enable ehci host controllers
      ARM: dts: aspeed: Add Facebook YAMP BMC

Teresa Remmet (5):
      ARM: dts: am335x phytec boards: Remove regulator node
      ARM: dts: am335x-phycore-som: Enable gpmc node in dts files
      ARM: dts: am335x-pcm-953: Update user led names
      ARM: dts: am335x-pcm-953: Remove eth phy delay
      ARM: dts: Add support for phyBOARD-REGOR-AM335x

Thierry Reding (18):
      arm64: tegra: Use TEGRA186_ prefix for GPIOs
      dt-bindings: tegra186-gpio: Remove unused definitions
      arm64: tegra: Clarify that P2771 is the Jetson TX2 Developer Kit
      arm64: tegra: Clarify that P3310 is the Jetson TX2
      arm64: tegra: Clarify that P2888 is the Jetson AGX Xavier
      arm64: tegra: Make DT model property consistent
      arm64: tegra: Add VCC supply for GPIO expanders on Jetson TX2
      arm64: tegra: Add pin control states for I2C on Tegra186
      arm64: tegra: Mark architected timer as always on
      arm64: tegra: Don't use architected timer for suspend on Tegra210
      arm64: tegra: Add ID EEPROM for Jetson TX1 module
      arm64: tegra: Add ID EEPROM for Jetson TX1 Developer Kit
      arm64: tegra: Add ID EEPROM for Jetson TX2 module
      arm64: tegra: Add ID EEPROM for Jetson TX2 Developer Kit
      arm64: tegra: Add ID EEPROMs on Jetson Nano
      arm64: tegra: Enable CPU sleep on Jetson Nano
      arm64: tegra: Enable PWM on Jetson Nano
      arm64: tegra: Sort device tree nodes alphabetically

Tomasz Maciej Nowak (1):
      arm64: dts: armada-3720-espressobin: correct spi node

Tony Lindgren (3):
      ARM: dts: Drop legacy custom hwmods property for omap4 uart
      ARM: dts: Drop legacy custom hwmods property for omap4 mmc
      Merge branch 'baltos' into omap-for-v5.3/dt

Vicente Bergas (1):
      arm64: dts: rockchip: Fix USB3 Type-C on rk3399-sapphire

Vidya Sagar (2):
      arm64: tegra: Add P2U and PCIe controller nodes to Tegra194 DT
      arm64: tegra: Enable PCIe slots in P2972-0000 board

Vinod Koul (1):
      arm64: dts: qcom: qcs404-evb: Fix typo

Vivek Unune (1):
      arm64: dts: rockchip: Add support for Hugsun X99 TV Box

Vladimir Oltean (1):
      ARM: dts: Introduce the NXP LS1021A-TSN board

Wanglai Shi (1):
      arm64: dts: hi3660: Add CoreSight support

Wen He (1):
      arm64: dts: ls1028a: Add properties for Mali DP500 node

Yannick Fertré (3):
      ARM: dts: stm32: Add I2C 1 config for stm32mp157a-dk1
      ARM: dts: stm32: enable display on stm32mp157c-dk1 board
      ARM: dts: stm32: add power supply of rm68200 on stm32mp157c-ev1

Yegor Yefremov (2):
      ARM: dts: am335x-baltos: Fix PHY mode for ethernet
      ARM: dts: am335x-baltos: add support for MMC1 CD pin

Yoshihiro Kaneko (1):
      ARM: dts: rza2mevb: sort nodes of rza2mevb board

Yoshihiro Shimoda (1):
      arm64: dts: renesas: Revise usb2_phy nodes and phys properties

Yuantian Tang (1):
      arm64: dts: ls1028a: Add temperature sensor node

Zhiyong Tao (2):
      arm64: dts: mt8183: add pinctrl device node
      arm64: dts: mt8183: Add auxadc device node


 .../devicetree/bindings/arm/amlogic.txt         |  142 --
 .../devicetree/bindings/arm/amlogic.yaml        |  144 ++
 .../arm/amlogic/amlogic,meson-gx-ao-secure.txt  |   28 +
 .../devicetree/bindings/arm/atmel-at91.txt      |   73 -
 .../devicetree/bindings/arm/atmel-at91.yaml     |  134 ++
 .../devicetree/bindings/arm/emtrion.txt         |   12 -
 Documentation/devicetree/bindings/arm/fsl.yaml  |   44 +
 .../devicetree/bindings/arm/mediatek.txt        |   89 -
 .../devicetree/bindings/arm/mediatek.yaml       |   91 +
 .../devicetree/bindings/arm/omap/omap.txt       |    3 +
 .../devicetree/bindings/arm/renesas.yaml        |    8 +
 .../devicetree/bindings/arm/rockchip.yaml       |   13 +
 .../devicetree/bindings/arm/stm32/stm32.txt     |   10 -
 .../devicetree/bindings/arm/stm32/stm32.yaml    |   31 +
 .../devicetree/bindings/arm/sunxi.yaml          |    2 +-
 Documentation/devicetree/bindings/arm/ti/k3.txt |    3 +
 .../bindings/bus/allwinner,sun8i-a23-rsb.yaml   |   79 +
 .../devicetree/bindings/bus/sunxi-rsb.txt       |   47 -
 .../bindings/display/bridge/renesas,dw-hdmi.txt |    4 +-
 .../devicetree/bindings/dma/fsl-qdma.txt        |    1 +
 .../bindings/gpu/arm,mali-midgard.txt           |    1 +
 .../devicetree/bindings/gpu/arm,mali-utgard.txt |    1 +
 .../bindings/input/sun4i-lradc-keys.txt         |    1 +
 .../devicetree/bindings/net/can/rcar_can.txt    |   13 +-
 .../devicetree/bindings/net/can/rcar_canfd.txt  |   16 +-
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml   |   57 +
 .../devicetree/bindings/pwm/pwm-sun4i.txt       |   24 -
 .../devicetree/bindings/serial/omap_serial.txt  |    1 +
 .../devicetree/bindings/timer/renesas,cmt.txt   |    6 +
 .../devicetree/bindings/vendor-prefixes.yaml    |    6 +
 arch/arm/boot/dts/Makefile                      |   10 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts      |   14 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts      |   14 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      |   13 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi           |   22 +-
 arch/arm/boot/dts/am335x-phycore-rdk.dts        |    4 +
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |   47 +-
 arch/arm/boot/dts/am335x-regor-rdk.dts          |   24 +
 arch/arm/boot/dts/am335x-regor.dtsi             |  223 +++
 arch/arm/boot/dts/am335x-wega-rdk.dts           |    4 +
 arch/arm/boot/dts/am335x-wega.dtsi              |   16 +-
 arch/arm/boot/dts/arm-realview-eb.dtsi          |    6 +
 arch/arm/boot/dts/arm-realview-pb1176.dts       |    6 +
 arch/arm/boot/dts/arm-realview-pb11mp.dts       |    6 +
 arch/arm/boot/dts/arm-realview-pbx.dtsi         |    6 +
 arch/arm/boot/dts/armada-370-netgear-rn104.dts  |   14 +
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts   |    8 +
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts  |  160 ++
 .../arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts |  846 ++++++++
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts   |  566 ++++++
 .../boot/dts/aspeed-bmc-microsoft-olympus.dts   |  207 ++
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts    |    2 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts   |   22 +
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts    |   14 +
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts      |  966 +++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts     |  224 +++
 .../arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |   14 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts      |  123 +-
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts    |    5 +
 arch/arm/boot/dts/aspeed-g4.dtsi                |    8 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                |   11 +-
 arch/arm/boot/dts/at91-wb50n.dtsi               |    2 +-
 arch/arm/boot/dts/at91sam9261ek.dts             |    8 -
 arch/arm/boot/dts/at91sam9g45.dtsi              |   25 +-
 arch/arm/boot/dts/at91sam9rl.dtsi               |   25 +-
 arch/arm/boot/dts/at91sam9x5.dtsi               |   23 +-
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi         |   12 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi               |    6 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                  |    9 +-
 arch/arm/boot/dts/bcm11351.dtsi                 |   12 +-
 arch/arm/boot/dts/bcm21664-garnet.dts           |    2 +-
 arch/arm/boot/dts/bcm21664.dtsi                 |   10 +-
 arch/arm/boot/dts/bcm23550-sparrow.dts          |    2 +-
 arch/arm/boot/dts/bcm23550.dtsi                 |    8 +-
 arch/arm/boot/dts/bcm28155-ap.dts               |    2 +-
 arch/arm/boot/dts/bcm283x.dtsi                  |    2 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts     |    4 +-
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts     |    4 +-
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |    4 +-
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts |    4 +-
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts |    4 +-
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts    |    4 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts    |    4 +-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |    2 -
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts  |    4 +-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts   |    4 +-
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts     |    4 +-
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts   |    4 +-
 .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts    |    4 +-
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts   |    4 +-
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts   |    4 +-
 .../boot/dts/bcm47081-tplink-archer-c5-v2.dts   |    4 +-
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts   |    4 +-
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts |    4 +-
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts   |    4 +-
 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts   |    4 +-
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts   |    4 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts   |    4 +-
 .../arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts |    4 +-
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts    |    4 +-
 arch/arm/boot/dts/bcm47094-phicomm-k3.dts       |    4 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts   |    4 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts    |    4 +-
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts        |    4 +-
 arch/arm/boot/dts/bcm5301x.dtsi                 |   10 +-
 arch/arm/boot/dts/bcm53573.dtsi                 |    2 +-
 arch/arm/boot/dts/bcm63138.dtsi                 |    9 +-
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts      |    2 +-
 arch/arm/boot/dts/bcm7445.dtsi                  |    8 +-
 arch/arm/boot/dts/bcm911360_entphn.dts          |    2 -
 arch/arm/boot/dts/bcm947189acdbmr.dts           |    4 +-
 arch/arm/boot/dts/bcm953012er.dts               |    4 +-
 arch/arm/boot/dts/bcm953012k.dts                |    2 +-
 arch/arm/boot/dts/bcm958522er.dts               |    2 +-
 arch/arm/boot/dts/bcm958525er.dts               |    2 +-
 arch/arm/boot/dts/bcm958525xmc.dts              |    2 +-
 arch/arm/boot/dts/bcm958622hr.dts               |    2 +-
 arch/arm/boot/dts/bcm958623hr.dts               |    2 +-
 arch/arm/boot/dts/bcm958625hr.dts               |    2 +-
 arch/arm/boot/dts/bcm958625k.dts                |    2 +-
 arch/arm/boot/dts/bcm963138dvt.dts              |    2 +-
 arch/arm/boot/dts/bcm988312hr.dts               |    2 +-
 arch/arm/boot/dts/da850-evm.dts                 |   13 +
 arch/arm/boot/dts/da850-lcdk.dts                |   36 +
 arch/arm/boot/dts/da850-lego-ev3.dts            |   30 +
 arch/arm/boot/dts/da850.dtsi                    |   50 +
 arch/arm/boot/dts/emev2-kzm9d.dts               |    2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi        |    5 +
 arch/arm/boot/dts/exynos3250-monk.dts           |    5 +
 arch/arm/boot/dts/exynos3250-rinato.dts         |    5 +
 arch/arm/boot/dts/exynos3250.dtsi               |   33 +
 arch/arm/boot/dts/exynos4.dtsi                  |   16 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |    5 +
 arch/arm/boot/dts/exynos4210-trats.dts          |    4 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    5 +
 arch/arm/boot/dts/exynos4210.dtsi               |   51 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi     |   32 +
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi |    5 +
 arch/arm/boot/dts/exynos4412-midas.dtsi         |    5 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    5 +
 arch/arm/boot/dts/exynos4412-prime.dtsi         |    7 +
 arch/arm/boot/dts/exynos4412.dtsi               |   49 +
 arch/arm/boot/dts/exynos5410-odroidxu.dts       |    5 +
 arch/arm/boot/dts/exynos5410.dtsi               |    6 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  102 +-
 arch/arm/boot/dts/exynos5420.dtsi               |  234 ++-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |  108 +-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |    6 +
 arch/arm/boot/dts/exynos54xx.dtsi               |    9 +
 arch/arm/boot/dts/gemini-dlink-dir-685.dts      |    2 +-
 arch/arm/boot/dts/hip04.dtsi                    |   18 +-
 arch/arm/boot/dts/ibm-power9-dual.dtsi          |  248 +++
 arch/arm/boot/dts/imx53-m53menlo.dts            |  266 ++-
 arch/arm/boot/dts/imx53-smd.dts                 |   73 +
 arch/arm/boot/dts/imx53.dtsi                    |   12 +
 arch/arm/boot/dts/imx6dl-kontron-samx6i.dtsi    |   12 +
 arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi     |   36 +
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi   |  815 ++++++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |   16 +
 arch/arm/boot/dts/imx6qdl.dtsi                  |   11 +-
 arch/arm/boot/dts/imx6sl-evk.dts                |   12 +
 arch/arm/boot/dts/imx6sl.dtsi                   |   12 +-
 arch/arm/boot/dts/imx6sll-evk.dts               |   12 +
 arch/arm/boot/dts/imx6sll.dtsi                  |    2 +
 arch/arm/boot/dts/imx6sx-sdb-reva.dts           |   16 +
 arch/arm/boot/dts/imx6sx-sdb.dts                |   16 +
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts     |   39 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts  |   47 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts      |   47 +-
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi          |   89 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |    7 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |    4 +
 arch/arm/boot/dts/imx6ul-geam.dts               |    2 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi             |    2 +-
 arch/arm/boot/dts/imx6ul.dtsi                   |   14 +
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi  |   11 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi          |    6 +
 arch/arm/boot/dts/imx6ull.dtsi                  |    7 +
 arch/arm/boot/dts/imx7d-meerkat96.dts           |  375 ++++
 arch/arm/boot/dts/imx7d-sdb.dts                 |   16 +-
 arch/arm/boot/dts/imx7d-zii-rpu2.dts            |   16 +-
 arch/arm/boot/dts/imx7d.dtsi                    |   16 +-
 arch/arm/boot/dts/imx7s.dtsi                    |   11 +-
 arch/arm/boot/dts/imx7ulp-evk.dts               |   55 +
 arch/arm/boot/dts/imx7ulp.dtsi                  |   38 +
 arch/arm/boot/dts/integrator.dtsi               |    3 +
 arch/arm/boot/dts/iwg20d-q7-common.dtsi         |    2 +-
 .../boot/dts/logicpd-torpedo-37xx-devkit-28.dts |   32 +
 arch/arm/boot/dts/ls1021a-tsn.dts               |  289 +++
 arch/arm/boot/dts/meson.dtsi                    |   44 +-
 arch/arm/boot/dts/meson6-atv1200.dts            |   44 +-
 arch/arm/boot/dts/meson6.dtsi                   |   44 +-
 arch/arm/boot/dts/meson8-minix-neo-x8.dts       |   39 +-
 arch/arm/boot/dts/meson8.dtsi                   |   64 +-
 arch/arm/boot/dts/meson8b-ec100.dts             |    9 +-
 arch/arm/boot/dts/meson8b-mxq.dts               |  182 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts          |   51 +-
 arch/arm/boot/dts/meson8b.dtsi                  |   64 +-
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts       |   17 +-
 arch/arm/boot/dts/meson8m2.dtsi                 |   10 +
 arch/arm/boot/dts/omap4-l4.dtsi                 |    9 -
 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi   |    6 +-
 .../arm/boot/dts/pxa300-raumfeld-controller.dts |   21 +-
 .../boot/dts/pxa300-raumfeld-speaker-one.dts    |    3 +
 arch/arm/boot/dts/pxa3xx.dtsi                   |    8 +
 arch/arm/boot/dts/qcom-apq8064.dtsi             |    4 +-
 .../arm/boot/dts/qcom-msm8974-fairphone-fp2.dts |    6 +
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts  |  156 ++
 arch/arm/boot/dts/qcom-msm8974.dtsi             |  138 +-
 arch/arm/boot/dts/r7s72100-genmai.dts           |    2 +-
 arch/arm/boot/dts/r7s72100-rskrza1.dts          |   38 +
 arch/arm/boot/dts/r7s72100.dtsi                 |   19 +
 arch/arm/boot/dts/r7s9210-rza2mevb.dts          |  161 +-
 arch/arm/boot/dts/r7s9210.dtsi                  |  286 +++
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |    2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |    2 +-
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts          |    2 +-
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts     |    2 +-
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts          |    2 +-
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts       |    4 +-
 arch/arm/boot/dts/r8a7778-bockw.dts             |    2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |    2 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |    9 +-
 arch/arm/boot/dts/r8a7790-stout.dts             |    9 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    9 +-
 arch/arm/boot/dts/r8a7791-porter.dts            |    9 +-
 arch/arm/boot/dts/r8a7792-blanche.dts           |    9 +-
 arch/arm/boot/dts/r8a7792-wheat.dts             |    2 +-
 arch/arm/boot/dts/r8a7792.dtsi                  |   34 +
 arch/arm/boot/dts/r8a7793-gose.dts              |    9 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |    2 +-
 arch/arm/boot/dts/r8a7794-silk.dts              |    2 +-
 arch/arm/boot/dts/rk322x.dtsi                   |   85 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |   29 +-
 arch/arm/boot/dts/rk3288-veyron-jaq.dts         |  207 ++
 arch/arm/boot/dts/rk3288-veyron-jerry.dts       |  207 ++
 arch/arm/boot/dts/rk3288-veyron-mickey.dts      |  234 ++-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |  256 ++-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts       |    2 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts      |  219 +++
 arch/arm/boot/dts/rk3288-veyron.dtsi            |   76 +-
 arch/arm/boot/dts/rk3288.dtsi                   |   30 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |   27 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts              |    2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi          |   21 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi    |   19 +
 arch/arm/boot/dts/stm32746g-eval.dts            |   66 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi       |  246 +++
 arch/arm/boot/dts/stm32mp157a-avenger96.dts     |  321 +++
 arch/arm/boot/dts/stm32mp157a-dk1.dts           |   70 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts           |   18 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts           |  125 +-
 arch/arm/boot/dts/stm32mp157c.dtsi              |  180 ++
 arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi    |   90 +
 arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi    |   62 +
 arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi    |   78 +
 arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi    |   62 +
 arch/arm/boot/dts/sun5i-gr8-evb.dts             |    2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                |   25 +-
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts     |    3 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |    8 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts       |    4 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi               |   29 +
 .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts |    3 +-
 .../boot/dts/sun8i-h2-plus-orangepi-zero.dts    |    3 +-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts       |    4 +
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     |    3 +-
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts    |    7 +-
 arch/arm/boot/dts/sun8i-r40.dtsi                |    3 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                |   13 +-
 .../boot/dts/sun8i-v40-bananapi-m2-berry.dts    |  123 ++
 .../boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi   |    3 +-
 arch/arm/boot/dts/uniphier-ld4-ref.dts          |    4 +
 arch/arm/boot/dts/uniphier-ld4.dtsi             |    4 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts         |    4 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts         |    4 +
 arch/arm/boot/dts/uniphier-pro4.dtsi            |    2 +
 arch/arm/boot/dts/uniphier-pro5.dtsi            |    4 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi            |    4 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts         |    4 +
 arch/arm/boot/dts/uniphier-sld8.dtsi            |    4 +-
 arch/arm/boot/dts/versatile-ab.dts              |    3 +
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi         |    5 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi             |    3 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts      |   13 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi            |   52 +-
 arch/arm/configs/davinci_all_defconfig          |    1 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi       |    6 +
 .../dts/allwinner/sun50i-a64-amarula-relic.dts  |   25 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts   |    7 +-
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts     |    6 -
 .../sun50i-a64-oceanic-5205-5inmfd.dts          |   23 +
 .../dts/allwinner/sun50i-a64-orangepi-win.dts   |   23 +
 .../boot/dts/allwinner/sun50i-a64-pine64.dts    |    2 -
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts   |   44 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |   22 +
 .../sun50i-h5-emlid-neutis-n5-devboard.dts      |    3 +-
 .../allwinner/sun50i-h5-nanopi-neo-plus2.dts    |    3 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   |   12 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |   28 +
 .../boot/dts/altera/socfpga_stratix10.dtsi      |   10 +-
 arch/arm64/boot/dts/amlogic/Makefile            |    1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts  |    4 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi      |   35 +-
 .../boot/dts/amlogic/meson-g12a-sei510.dts      |  401 +++-
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  122 +-
 .../boot/dts/amlogic/meson-g12a-x96-max.dts     |  257 +++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     | 1825 +++++++++++++++++-
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts   |  386 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi     |   82 +
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi    |    4 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi       |    4 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts   |   15 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts |   10 +-
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts    |   15 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts |    9 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi |    2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   |  106 +-
 .../boot/dts/amlogic/meson-gxbb-wetek.dtsi      |   37 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     |   35 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts   |    2 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts   |   13 +-
 .../amlogic/meson-gxl-s905x-libretech-cc.dts    |   14 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts |    2 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi  |    4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi      |   35 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts  |   38 +-
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts    |   12 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts  |   13 +-
 .../boot/dts/amlogic/meson-gxm-rbox-pro.dts     |   14 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi          |    6 +-
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi       |    4 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi   |    4 +-
 .../dts/broadcom/stingray/stingray-usb.dtsi     |   72 +
 .../boot/dts/broadcom/stingray/stingray.dtsi    |  108 ++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  |    5 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |   51 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |    5 +
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   11 +
 arch/arm64/boot/dts/freescale/Makefile          |    1 +
 .../boot/dts/freescale/fsl-ls1028a-qds.dts      |   20 +
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts      |   20 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi  |  136 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts    |  190 ++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi       |  151 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts    |    4 +
 .../dts/freescale/imx8mq-librem5-devkit.dts     |  809 ++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       |   62 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |  134 +-
 .../boot/dts/hisilicon/hi3660-coresight.dtsi    |  456 +++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       |    2 +
 .../boot/dts/hisilicon/hi6220-coresight.dtsi    |    6 +-
 .../dts/marvell/armada-3720-espressobin.dts     |   18 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts  |   28 +
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts  |    1 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts  |    7 +-
 .../boot/dts/marvell/armada-8040-mcbin.dtsi     |    2 +
 .../boot/dts/marvell/armada-ap806-dual.dtsi     |    2 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi     |    5 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi   |  118 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi   |    2 +
 arch/arm64/boot/dts/mediatek/Makefile           |    1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts     |  140 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi        |  447 +++++
 .../boot/dts/nvidia/tegra186-p2771-0000.dts     |   75 +-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi  |   53 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi        |  176 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi  |    4 +-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts     |   55 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |  509 +++++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi  |   16 +-
 .../boot/dts/nvidia/tegra210-p2371-2180.dts     |   13 +
 .../boot/dts/nvidia/tegra210-p3450-0000.dts     |   52 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi        |   22 +-
 arch/arm64/boot/dts/qcom/Makefile               |    4 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |   17 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |   59 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi           |  185 ++
 arch/arm64/boot/dts/qcom/pm8998.dtsi            |    2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi            |   20 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi        |   43 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi            |  636 +++++-
 arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dts    |  238 +++
 arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dts    |  238 +++
 arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dts    |  174 ++
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi      | 1326 +++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts      |  557 ++++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts         |    4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |  283 ++-
 arch/arm64/boot/dts/renesas/Makefile            |    2 +
 arch/arm64/boot/dts/renesas/hihope-common.dtsi  |  325 ++++
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi |   63 +
 .../dts/renesas/r8a774a1-hihope-rzg2m-ex.dts    |   15 +
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m.dts  |   26 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi       |  527 ++++-
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts |  246 ++-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi       |   12 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        |   93 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        |   71 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       |   45 +-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts  |    2 +-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts  |    3 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |   32 +-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts  |    9 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       |   10 +-
 .../arm64/boot/dts/renesas/salvator-common.dtsi |    2 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi        |   49 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi           |    2 +-
 arch/arm64/boot/dts/rockchip/Makefile           |    4 +
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts  |    4 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        |    1 +
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts   |    6 +
 .../boot/dts/rockchip/rk3399-hugsun-x99.dts     |  733 +++++++
 .../dts/rockchip/rk3399-khadas-edge-captain.dts |   27 +
 .../boot/dts/rockchip/rk3399-khadas-edge-v.dts  |   27 +
 .../boot/dts/rockchip/rk3399-khadas-edge.dts    |   13 +
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi   |  804 ++++++++
 .../boot/dts/rockchip/rk3399-rock-pi-4.dts      |  101 +
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts |   49 +
 .../boot/dts/rockchip/rk3399-rockpro64.dts      |   18 +
 .../boot/dts/rockchip/rk3399-sapphire.dtsi      |    5 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |   23 +-
 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi     |   22 +
 .../boot/dts/socionext/uniphier-ld11-global.dts |    4 +
 .../arm64/boot/dts/socionext/uniphier-ld11.dtsi |   15 +-
 .../arm64/boot/dts/socionext/uniphier-ld20.dtsi |   15 +-
 .../boot/dts/socionext/uniphier-pxs3-ref.dts    |    4 +
 .../arm64/boot/dts/socionext/uniphier-pxs3.dtsi |   15 +-
 arch/arm64/boot/dts/sprd/sc9836.dtsi            |    2 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi            |    8 +-
 arch/arm64/boot/dts/sprd/whale2.dtsi            |   35 +
 arch/arm64/boot/dts/ti/Makefile                 |    2 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |  201 ++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         |    8 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      |   28 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi             |    8 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |   51 +
 .../boot/dts/ti/k3-j721e-common-proc-board.dts  |   50 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       |  243 +++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |   90 +
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi     |   29 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi            |  177 ++
 arch/arm64/configs/defconfig                    |    1 +
 drivers/soc/ti/Kconfig                          |    5 +
 include/dt-bindings/gpio/tegra186-gpio.h        |   41 -
 445 files changed, 26661 insertions(+), 2403 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/sunxi-rsb.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
 create mode 100644 arch/arm/boot/dts/am335x-regor-rdk.dts
 create mode 100644 arch/arm/boot/dts/am335x-regor.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
 create mode 100644 arch/arm/boot/dts/ibm-power9-dual.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-kontron-samx6i.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-meerkat96.dts
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
 create mode 100644 arch/arm/boot/dts/ls1021a-tsn.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-avenger96.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-db845c.dts
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-common.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e.dtsi
