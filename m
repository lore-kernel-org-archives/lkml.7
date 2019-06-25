Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BE1C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FB4214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcNfQghe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfFYMe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:34:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56276 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfFYMe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:34:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so2631582wmj.5;
        Tue, 25 Jun 2019 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CC4YE86QtOg4NxoeCs2Jrma7W56DR7TN4ZywVRYX0TY=;
        b=CcNfQghezl4a6aeE43mpBy2cypM9gm0r7xrnXROurnilyPdkS1kmtv/eetb2oVqYwq
         rGXx7TRHL4qR1PJzlK6U843sbuXp12BXHlbViMOx8Fv46mYu1oMiLP0azGMLTdm7ST2t
         rejfYTTx3HW5z11eBlbVv7QduqYCwpCpZhGR5ReysZgsv6vs+7y443trE4KVRoGDKCl3
         me5TsO9Tf7v1qEJ1V4rW9SO0KFc44CXYMrS2w6RneSvUTPX/rdzmyHgfEwyZW/c95oLK
         vifdpRgMLFGkZ5FXB7/2YQam5RUjZRVpu23gAgraIYIP5TFFO4FlCXpKJFXejOLkw1M1
         5ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CC4YE86QtOg4NxoeCs2Jrma7W56DR7TN4ZywVRYX0TY=;
        b=Zat6hIxzaQtt+dxmaeOpWhuuhBrzY8LqZbFt3ebZDn1hj+0BcLalHGmDoDMsMsrAcN
         BvM5wB3Mq+r/fzP3inY78Ic1l7xesYvZPZs+eP160NnRkkglbooqWEm05Yr3dPh9Xj9F
         7Pw4kkmQ8AVbfEyCrIyzpfO/IcK4zBneSj/T6utAg6D7r8qxspRj5vSSZavOFX82MKHR
         eO1gV1FjmJp4LGc3FlZRUg59yuQsrzSe4ARbxzZq8JagaBB+xp6FZH/uxovHw8tHFd/8
         KSZFq2oZ6vA7y8bCTypbVy4CVATpfrCgmobapJN3R/d3VsJiq8HTpbOv1m60NxOUxKCb
         Vnew==
X-Gm-Message-State: APjAAAWg4Oscei974U22x8Bk0FiYYuS3w1+0Xi3e1AfYw5Pro4LLPxiD
        IPvMSPzkVAjx+fQMhUOH/cCc81aB4rIgBw==
X-Google-Smtp-Source: APXvYqylxpnjkG+TJmazS8HIvgK6sK0v9PRkBdWxXaH9fJEuKPxQlriZmfGHzMs+B+rXkpXHuy80SA==
X-Received: by 2002:a1c:c583:: with SMTP id v125mr18666160wmf.158.1561466062750;
        Tue, 25 Jun 2019 05:34:22 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id j132sm1732006wmj.21.2019.06.25.05.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 05:34:22 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, festevam@gmail.com, aisheng.dong@nxp.com,
        l.stach@pengutronix.de, angus@akkea.ca, vabhav.sharma@nxp.com,
        pankaj.bansal@nxp.com, bhaskar.upadhaya@nxp.com, ping.bai@nxp.com,
        manivannan.sadhasivam@linaro.org, richard.hu@technexion.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, linux-imx@nxp.com,
        daniel.baluta@nxp.com
Subject: [PATCH v2] arm64: dts: fsl: pico-pi: Add a device tree for the PICO-PI-IMX8M
Date:   Tue, 25 Jun 2019 15:34:07 +0300
Message-Id: <20190625123407.15888-1-andradanciu1997@gmail.com>
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
Changes since v1:
 - renamed wandboard-pi-8m.dts to pico-pi-8m.dts
 - removed pinctrl_csi1, pinctrl_wifi_ctrl
 - used generic name for pmic
 - removed gpo node
 - delete regulator-virtuals node
 - remove always-on property from buck1-8 and ldo3-7
 - remove pmic-buck-uses-i2c-dvs property for buck1-4

 arch/arm64/boot/dts/freescale/Makefile       |   1 +
 arch/arm64/boot/dts/freescale/pico-pi-8m.dts | 458 +++++++++++++++++++++++++++
 2 files changed, 459 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/pico-pi-8m.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index c043aca66572..538422903e8a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -26,3 +26,4 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
+dtb-$(CONFIG_ARCH_MXC) += pico-pi-8m.dtb
diff --git a/arch/arm64/boot/dts/freescale/pico-pi-8m.dts b/arch/arm64/boot/dts/freescale/pico-pi-8m.dts
new file mode 100644
index 000000000000..23422c8fc43f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/pico-pi-8m.dts
@@ -0,0 +1,458 @@
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
+	model = "PICO-PI-8M";
+	compatible = "wand,imx8mq-pico-pi", "fsl,imx8mq";
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
+	pmic: pmic@4b {
+		reg = <0x4b>;
+		compatible = "rohm,bd71837";
+		/* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
+		pinctrl-0 = <&pinctrl_pmic>;
+		gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;
+
+		regulators {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			buck1: BUCK1 {
+				regulator-name = "buck1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <1250>;
+				rohm,dvs-run-voltage = <900000>;
+				rohm,dvs-idle-voltage = <850000>;
+				rohm,dvs-suspend-voltage = <800000>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "buck2";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <1250>;
+				rohm,dvs-run-voltage = <1000000>;
+				rohm,dvs-idle-voltage = <900000>;
+			};
+
+			buck3: BUCK3 {
+				regulator-name = "buck3";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				rohm,dvs-run-voltage = <1000000>;
+			};
+
+			buck4: BUCK4 {
+				regulator-name = "buck4";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				rohm,dvs-run-voltage = <1000000>;
+			};
+
+			buck5: BUCK5 {
+				regulator-name = "buck5";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "buck6";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+			};
+
+			buck7: BUCK7 {
+				regulator-name = "buck7";
+				regulator-min-microvolt = <1605000>;
+				regulator-max-microvolt = <1995000>;
+				regulator-boot-on;
+			};
+
+			buck8: BUCK8 {
+				regulator-name = "buck8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "ldo1";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "ldo2";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "ldo3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "ldo4";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "ldo5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+			};
+
+			ldo6: LDO6 {
+				regulator-name = "ldo6";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+
+			ldo7: LDO7 {
+				regulator-name = "ldo7";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
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

