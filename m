Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88441C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5172321783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTeOBG8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbfGRMQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:16:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46431 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRMQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:16:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so28415124wru.13;
        Thu, 18 Jul 2019 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdGksz9z0YmPPBbzabRDwijIlsxpnqgce1lHiKhjwHI=;
        b=RTeOBG8OEted6Ha8on4i1/VkFZO/PoHRuTTbjyTGGH/aO0lXQUHBd4q2AeN/YBT0I6
         TH3f7x5qoA0uB5z6vXlLWTn0OK1wwV9n4MAVnRmLRynip6rNRF/5XRDKcp0YQL9jKn7b
         IOZtxRdhZp7MMee4OPAI3ZhEEhOVxsf9nutiwBJWH5r7mKGbU+wWWFWpmeNkNA1aBWbp
         IvkOEzFa1JSp3Yg2rx7oe/fTzMyKke0UPf44Z8DfDLK57jel+FIlfhvTAhFlaarsrwcC
         kBoAECLGezon+ylWuql5G5jK64nXnRH8rKEqnrLyovArpDEgIK6Q8ulum2/Ufq0Q2h6F
         QV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdGksz9z0YmPPBbzabRDwijIlsxpnqgce1lHiKhjwHI=;
        b=qW/LjWkXafWPpB8jQAq2FgWTWEp3m2RekrixOwh98qFq+bHJCyh4EsMCiqcHmFNOcK
         2SmGGFZknUnU4eoeCov5KM0JjoC42P8q1BaXp+wFeiHeSwAwWOgppBv/bu0eLFQdEgi2
         gHsxR9hzPDDXmdA30aQpNpMISRn4mU5OG+VcV4avB8Bi7uWZ1Q41mZaowWMNH/GIuol+
         k6RuBS54VU+uiV5Q6zXMhC1cX/2Tn37y/8L4yblaXesUQyUxQnhNBNrLsIHFzayYMzun
         AHkJF7GIPRJ74O5XFnpBWLJI/HNUp3i/+saruH3Z0lTfW67THiwCkAyWMWuhto81hGSV
         +FdA==
X-Gm-Message-State: APjAAAVCBclgQYjbA60k3Bgq4DwVh5vPyQvhwqHHNig6Ki1jvPuGPQoD
        +0f297NqcMD1lPvMs2vP/xw=
X-Google-Smtp-Source: APXvYqzNMMMofS4JVWxuJnHA1S/DSMgzaw4sLp98e7N7xVKF6C+nEBxe/y5Guq+kCOM3uznfgGMmFw==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr51011456wrk.229.1563452211806;
        Thu, 18 Jul 2019 05:16:51 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id f17sm22897463wmf.27.2019.07.18.05.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 05:16:51 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        u.kleine-koenig@pengutronix.de, aisheng.dong@nxp.com,
        andradanciu1997@gmail.com, leoyang.li@nxp.com, festevam@gmail.com,
        sriram.dash@nxp.com, l.stach@pengutronix.de, pankaj.bansal@nxp.com,
        ping.bai@nxp.com, pramod.kumar_1@nxp.com, bhaskar.upadhaya@nxp.com,
        richard.hu@technexion.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: fsl: pico-pi: Add a device tree for the PICO-PI-IMX8M
Date:   Thu, 18 Jul 2019 15:16:27 +0300
Message-Id: <20190718121628.23991-2-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190718121628.23991-1-andradanciu1997@gmail.com>
References: <20190718121628.23991-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Hu <richard.hu@technexion.com>

The current level of support yields a working console and is able to boot
userspace from NFS or init ramdisk.

Additional subsystems that are active :
	- Ethernet
	- USB

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Richard Hu <richard.hu@technexion.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |   1 +
 arch/arm64/boot/dts/freescale/pico-pi-8m.dts | 417 +++++++++++++++++++++++++++
 2 files changed, 418 insertions(+)
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
index 000000000000..30f1d85119d0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/pico-pi-8m.dts
@@ -0,0 +1,417 @@
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
+	model = "TechNexion PICO-PI-8M";
+	compatible = "technexion,pico-pi-imx8m", "fsl,imx8mq";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_otg_vbus>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 14 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&iomuxc {
+	pinctrl_enet_3v3: enet3v3grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x19
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC		0x3
+			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO	0x23
+			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
+			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
+			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
+			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
+			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
+			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
+			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
+			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
+			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
+			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
+			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_otg_vbus: otgvbusgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14		0x19   /* USB OTG VBUS Enable */
+		>;
+	};
+
+	pinctrl_pmic: pmicirq {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
+			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x49
+			MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x49
+			MX8MQ_IOMUXC_UART4_RXD_UART2_DCE_CTS_B		0x49
+			MX8MQ_IOMUXC_UART4_TXD_UART2_DCE_RTS_B		0x49
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
+		>;
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
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
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

