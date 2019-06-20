Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36075C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A720675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnZ/koNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfFTNeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:34:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43908 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfFTNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:34:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so3035667wru.10;
        Thu, 20 Jun 2019 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f91FKm6IArK6QXXJVE4klnrFyZz3Ypo44ZU+rqXi8Lg=;
        b=AnZ/koNzDwHLE6y7+JMBDFldY1CbipLdbUHoLK4RC8wSQ8I5Y6ZSAMNSkARyr/YYX8
         6In8Vkye0EwEhS64XL9FGqGlrF/p9JKWsqUePu+OizJCByQW5mbiblk9A/LcXD3amFE7
         bN5WzL7DtSIai4rxyuZSE3mksyyQtbmNqHh+dtE339+xhCEjsMxLHvC6a53h5AuLOMCS
         XqOLMownfYoLoIxN/bXay47xApQvzIOXpXvp5H7jbtZAZmfRojaMomCm5tFX0M6kfTSE
         grat2W3d2tmpMbQkU9boTp6q4snQHqM6guXKjiMH2/Iv/0nbu53aavFbb2dUOvr9fbmY
         IM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f91FKm6IArK6QXXJVE4klnrFyZz3Ypo44ZU+rqXi8Lg=;
        b=NrVVLri7sGnWRuBfc/CUfUItfeCRX9eG+lofeUPQVwtkLqcsK1nXSX1Qd6glPvfQTP
         1RzCDo6td3VmgCwaQCIMRY6vy3+en2okhmXK+Sv4saMyGCqzfhL4iK9yXb+S52pKlOyS
         UMlEw2anoYGF1zGxUNrGs2bkC44E4v/4KltnhzxEWBtS9j4mKPYM2yHw7TERzvxerx3W
         3kLGPsyLCkHc1l9LguihaGIN87/atNcOtaz4yqIqWHsKccA57U0pLYTjpWm2pNAVEWbE
         ffwlnmREUL/osDxDH0MaObBx/JeGG51KIru1Oay80OW/8d8VlmFDza53hxD+UYzvBh+l
         P9qQ==
X-Gm-Message-State: APjAAAXRlXTR0VZfVeiMWxeBiRiT0PEbJkQnQtc90ItCUVVLMKGAzhlF
        2RIkPpWi96oSd/+ZMmXba7E=
X-Google-Smtp-Source: APXvYqzuIsgMUGYKHA5sk5h7l5wLNaCLWKfqAldOyYEsBj6WFbCg+Kud14Ih+6bJYZWIQNnNQapy0Q==
X-Received: by 2002:a5d:51d1:: with SMTP id n17mr35255912wrv.52.1561037649897;
        Thu, 20 Jun 2019 06:34:09 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id i128sm1972290wmi.16.2019.06.20.06.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:34:09 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, aisheng.dong@nxp.com, sriram.dash@nxp.com,
        pramod.kumar_1@nxp.com, bhaskar.upadhaya@nxp.com,
        vabhav.sharma@nxp.com, pankaj.bansal@nxp.com,
        richard.hu@technexion.com, l.stach@pengutronix.de,
        ping.bai@nxp.com, manivannan.sadhasivam@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com
Subject: [RFC PATCH] arm64: dts: fsl: wandboard: Add a device tree for the PICO-PI-IMX8M
Date:   Thu, 20 Jun 2019 16:32:52 +0300
Message-Id: <20190620133252.31373-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Hu <richard.hu@technexion.com>

The current level of support yields a working console and is able to boot
userspace from an initial ramdisk copied via u-boot in RAM.

Additional subsystems that are active :
	- Ethernet
	- USB

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Richard Hu <richard.hu@technexion.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 I am using pico-pi-8mxm board to work on my project for Google Summer of Code.
 This is based on patches from https://github.com/wandboard-org.

 arch/arm64/boot/dts/freescale/Makefile       |   1 +
 arch/arm64/boot/dts/freescale/wand-pi-8m.dts | 590 +++++++++++++++++++++++++++
 2 files changed, 591 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/wand-pi-8m.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 984554343c83..5904d6a8a033 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -23,3 +23,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
+dtb-$(CONFIG_ARCH_MXC) += wand-pi-8m.dtb
diff --git a/arch/arm64/boot/dts/freescale/wand-pi-8m.dts b/arch/arm64/boot/dts/freescale/wand-pi-8m.dts
new file mode 100644
index 000000000000..9f7121014722
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/wand-pi-8m.dts
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 Wandboard, Org.
+ * Copyright 2017 NXP
+ *
+ * Author: Richard Hu <hakahu@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mq.dtsi"
+
+/ {
+	model = "WAND-PI-8M";
+	compatible = "wand,imx8mq-wand-pi", "fsl,imx8mq";
+
+	chosen {
+		bootargs = "console=ttymxc0,115200 earlycon=ec_imx6q,0x30860000,115200";
+		stdout-path = &uart1;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_otg_vbus: usb_otg_vbus {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_otg_vbus>;
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 14 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	regulator-virtuals {
+		compatible = "simple-bus";
+
+		virt-buck1 {
+			compatible = "regulator-virtual";
+			virtual-supply = "buck1";
+		};
+		virt-buck2 {
+			compatible = "regulator-virtual";
+			virtual-supply = "buck2";
+		};
+		virt-buck3 {
+			compatible = "regulator-virtual";
+			virtual-supply = "buck3";
+		};
+		virt-buck4 {
+			compatible = "regulator-virtual";
+			virtual-supply = "buck4";
+		};
+		virt-buck5 {
+			compatible = "regulator-virtual";
+			virtual-supply = "buck5";
+		};
+		virt-buck6 {
+			compatible = "regulator-virtual";
+			virtual-supply = "buck6";
+		};
+		virt-buck7 {
+			compatible = "regulator-virtual";
+			virtual-supply = "buck7";
+		};
+		virt-buck8 {
+			compatible = "regulator-virtual";
+			virtual-supply = "buck8";
+		};
+		virt-ldo1 {
+			compatible = "regulator-virtual";
+			virtual-supply = "ldo1";
+		};
+		virt-ldo2 {
+			compatible = "regulator-virtual";
+			virtual-supply = "ldo2";
+		};
+		virt-ldo3 {
+			compatible = "regulator-virtual";
+			virtual-supply = "ldo3";
+		};
+		virt-ldo4 {
+			compatible = "regulator-virtual";
+			virtual-supply = "ldo4";
+		};
+		virt-ldo5 {
+			compatible = "regulator-virtual";
+			virtual-supply = "ldo5";
+		};
+		virt-ldo6 {
+			compatible = "regulator-virtual";
+			virtual-supply = "ldo6";
+		};
+		virt-ldo7 {
+			compatible = "regulator-virtual";
+			virtual-supply = "ldo7";
+		};
+	};
+
+	gpio-edm {
+		compatible = "gpio-edm";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_ctrl>;
+
+		gpio_wifi_wl_reg_on {
+			label = "WL_REG_ON";
+			gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+			dir   = "out";
+		};
+
+		gpio_wifi_pwr_en {
+			label = "WIFI_PWR_EN";
+			gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
+			dir   = "out";
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+
+	wand-pi-8m {
+		pinctrl_otg_vbus: otgvbusgrp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14		0x19   /* USB OTG VBUS Enable */
+			>;
+		};
+
+		pinctrl_csi1: csi1grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_NAND_DATA01_GPIO3_IO7		0x19   /* CSI P1 PWDN */
+				MX8MQ_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x19   /* CSI nRST */
+				MX8MQ_IOMUXC_GPIO1_IO15_CCMSRCGPCMIX_CLKO2	0x59
+			>;
+		};
+
+		pinctrl_enet_3v3: enet3v3grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x19
+			>;
+		};
+
+		pinctrl_fec1: fec1grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC		0x3
+				MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO	0x23
+				MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
+				MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
+				MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
+				MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
+				MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
+				MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
+				MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
+				MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
+				MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
+				MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
+				MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+				MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+				MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x19
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
+				MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL			0x4000007f
+				MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA			0x4000007f
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
+				MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x49
+				MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x49
+				MX8MQ_IOMUXC_UART4_RXD_UART2_DCE_CTS_B		0x49
+				MX8MQ_IOMUXC_UART4_TXD_UART2_DCE_RTS_B		0x49
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
+				MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
+				MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
+				MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
+				MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
+				MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
+				MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
+				MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
+				MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
+				MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
+				MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
+			>;
+		};
+
+		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+			fsl,pins = <
+				MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
+				MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
+				MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
+				MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
+				MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
+				MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
+				MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
+				MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
+				MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
+				MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
+				MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
+			>;
+		};
+
+		pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+			fsl,pins = <
+				MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
+				MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
+				MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
+				MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
+				MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
+				MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
+				MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
+				MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
+				MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
+				MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
+				MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
+			>;
+		};
+
+		pinctrl_usdhc2_gpio: usdhc2grpgpio {
+			fsl,pins = <
+				MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
+				MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
+				MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
+				MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
+				MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
+				MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
+				MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+			>;
+		};
+
+		pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+			fsl,pins = <
+				MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
+				MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
+				MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
+				MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
+				MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
+				MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
+				MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+			>;
+		};
+
+		pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+			fsl,pins = <
+				MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
+				MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
+				MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
+				MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
+				MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
+				MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
+				MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+			>;
+		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
+			>;
+		};
+
+		pinctrl_pmic: pmicirq {
+			fsl,pins = <
+				MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
+			>;
+		};
+
+		pinctrl_wifi_ctrl: wifi_ctrlgrp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_NAND_ALE_GPIO3_IO0		0x19 /* WL_REG_ON */
+				MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15	0x19 /* WIFI_PWR_EN */
+			>;
+		};
+
+		pinctrl_tusb320_irq: tusb320_irqgrp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_NAND_DATA00_GPIO3_IO6	0x41
+			>;
+		};
+
+		pinctrl_typec_ss_sel: typec_ss_selgrp {
+			fsl,pins = <
+				MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5		0x19
+			>;
+		};
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1 &pinctrl_enet_3v3>;
+	phy-mode = "rgmii-id";
+	pinctrl-assert-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			at803x,led-act-blind-workaround;
+			at803x,eee-disabled;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	typec_tusb320:tusb320@47 {
+		compatible = "ti,tusb320";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tusb320_irq &pinctrl_typec_ss_sel>;
+		reg = <0x47>;
+		vbus-supply = <&reg_usb_otg_vbus>;
+		ss-sel-gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+		tusb320,int-gpio = <&gpio3 6 GPIO_ACTIVE_LOW>;
+		tusb320,select-mode = <0>;
+		tusb320,dfp-power = <0>;
+	};
+
+	pmic: bd71837@4b {
+		reg = <0x4b>;
+		compatible = "rohm,bd71837";
+		/* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
+		pinctrl-0 = <&pinctrl_pmic>;
+		gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;
+
+		bd71837,pmic-buck1-uses-i2c-dvs;
+		bd71837,pmic-buck1-dvs-voltage = <900000>, <850000>, <800000>; /* VDD_SOC: Run-Idle-Suspend */
+		bd71837,pmic-buck2-uses-i2c-dvs;
+		bd71837,pmic-buck2-dvs-voltage = <1000000>, <900000>, <0>; /* VDD_ARM: Run-Idle */
+		bd71837,pmic-buck3-uses-i2c-dvs;
+		bd71837,pmic-buck3-dvs-voltage = <1000000>, <0>, <0>; /* VDD_GPU: Run */
+		bd71837,pmic-buck4-uses-i2c-dvs;
+		bd71837,pmic-buck4-dvs-voltage = <1000000>, <0>, <0>; /* VDD_VPU: Run */
+
+		gpo {
+			rohm,drv = <0x0C>;	/* 0b0000_1100 all gpos with cmos output mode */
+		};
+
+		regulators {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			buck1_reg: regulator@0 {
+				reg = <0>;
+				regulator-compatible = "buck1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+			};
+
+			buck2_reg: regulator@1 {
+				reg = <1>;
+				regulator-compatible = "buck2";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+			};
+
+			buck3_reg: regulator@2 {
+				reg = <2>;
+				regulator-compatible = "buck3";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4_reg: regulator@3 {
+				reg = <3>;
+				regulator-compatible = "buck4";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5_reg: regulator@4 {
+				reg = <4>;
+				regulator-compatible = "buck5";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6_reg: regulator@5 {
+				reg = <5>;
+				regulator-compatible = "buck6";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck7_reg: regulator@6 {
+				reg = <6>;
+				regulator-compatible = "buck7";
+				regulator-min-microvolt = <1605000>;
+				regulator-max-microvolt = <1995000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck8_reg: regulator@7 {
+				reg = <7>;
+				regulator-compatible = "buck8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: regulator@8 {
+				reg = <8>;
+				regulator-compatible = "ldo1";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: regulator@9 {
+				reg = <9>;
+				regulator-compatible = "ldo2";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: regulator@10 {
+				reg = <10>;
+				regulator-compatible = "ldo3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: regulator@11 {
+				reg = <11>;
+				regulator-compatible = "ldo4";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5_reg: regulator@12 {
+				reg = <12>;
+				regulator-compatible = "ldo5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo6_reg: regulator@13 {
+				reg = <13>;
+				regulator-compatible = "ldo6";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo7_reg: regulator@14 {
+				reg = <14>;
+				regulator-compatible = "ldo7";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&uart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	extcon = <&typec_tusb320>;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&A53_0 {
+	operating-points = <
+		/* kHz    uV */
+		1500000 1000000
+		1300000 1000000
+		1000000 900000
+		800000  900000
+	>;
+};
-- 
2.11.0

