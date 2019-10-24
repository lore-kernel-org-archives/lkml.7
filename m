Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB458CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F1920679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2+lAKHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502918AbfJXOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:43:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46658 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502818AbfJXOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:43:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id q21so3902749plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UyzF1SLTXdW82PANfnQmEU0yBYvloiErfUOIU8MNuAU=;
        b=J2+lAKHwGA/WlhKBBMc7voAbFXdmxspO0U4G2K/CvuUURep5Zm/Zq5pBI7+adh/6h7
         6aAH3LNbZXBWwSDg4815WZ4i3sK/mio7KnyehBskv9WduhTQWgzkU+r1rVoR+Gst8/gL
         qke6GNMNoiL6aeWPGLOecKQigw8y+BDjtmOEo9errIP86AWr9qVCWZTS8FAAf1QUMuAV
         ktow87ahZyGVZ9dJphtw4IW++pTpgOydqqo8A3pnrEWMm4slk/6tGaxTfdCMlJI6b+Ea
         4iPHaeb50mR+bBoP4z6IWt43wW5GzDTILWUVBizQc/tbPIcudhWF+4fpgcBxGpERkliu
         kPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UyzF1SLTXdW82PANfnQmEU0yBYvloiErfUOIU8MNuAU=;
        b=aV+c9dwkhNlS37stnfCC2YhHDUUA8VcCaXpH/ojfvAiaQDcf9dPdpQrB0wS6KaxXOt
         W8UfukejBvNfpjemWB17PG6dST/sqzm0wcVuVXj7OqhpVdiFz/AjcIQ1hvuA1qHjXZ/n
         6PTmJnc63mhTzOzuw54xCcTwCfsGffd2yUlWMHXrD1c2/pMGBatprh1BsfM6wc99xuIJ
         em09DhgmvBIXWFseDehe4vlvEwnd2kLKT2cqRUCdmGHEhTm15/DcBGS7g5xWjrNuJmpO
         CkGjCA7Wu0TH1DbQex+gtFCW3suqiHyKq5X2tGtavm+tv6JVx2nRdje1Fiv5ob0ERIG9
         bvqA==
X-Gm-Message-State: APjAAAVy9iiWEoR7rw64M/zs7WNG5/FLpBCyl+98nntn6Yp1UA14BOID
        iTHhoeX5E5cehJT31CEmkYRo
X-Google-Smtp-Source: APXvYqymgnvYa7DcaoNmVIzHdONKxOXH3dMC83Y4BWdT8HIw6b8CboEV+06G3Fz+fGa5rSa7EJwzAQ==
X-Received: by 2002:a17:902:8a8c:: with SMTP id p12mr15843262plo.208.1571928189902;
        Thu, 24 Oct 2019 07:43:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:997:a0de:81a:ea25:468a:5918])
        by smtp.gmail.com with ESMTPSA id 193sm29059810pfc.59.2019.10.24.07.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 07:43:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] arm64: dts: freescale: Add devicetree support for Thor96 board
Date:   Thu, 24 Oct 2019 20:12:34 +0530
Message-Id: <20191024144235.3182-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Thor96 board from Einfochips. This board is
one of the 96Boards Consumer Edition platform powered by the NXP
i.MX8MQ SoC.

Following are the features supported currently:

1. uSD
2. WiFi/BT
3. Ethernet
4. EEPROM (M24256)
5. NOR Flash (W25Q256JW)
6. 2xUSB3.0 ports and 1xUSB2.0 port at HS expansion

More information about this board can be found in Arrow website:
https://www.arrow.com/en/products/i.imx8-thor96/arrow-development-tools

Link to 96Boards CE Specification: https://linaro.co/ce-specification

Signed-off-by: Darshak Patel <darshak.patel@einfochips.com>
[Mani: cleaned up for upstream]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mq-thor96.dts      | 581 ++++++++++++++++++
 2 files changed, 582 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 93fce8f0c66d..dec1662019be 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts b/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
new file mode 100644
index 000000000000..e1adf24c2602
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 Einfochips
+ * Copyright 2019 Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include "imx8mq.dtsi"
+
+/ {
+	model = "Einfochips i.MX8MQ Thor96";
+	compatible = "einfochips,imx8mq-thor96", "fsl,imx8mq";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000 0 0x80000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		user-led1 {
+			label = "green:user1";
+			gpios = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user-led2 {
+			label = "green:user2";
+			gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+		};
+
+		user-led3 {
+			label = "green:user3";
+			gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+			default-state = "off";
+		};
+
+		user-led4 {
+			label = "green:user4";
+			gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan-active-led {
+			label = "yellow:wlan";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt-active-led {
+			label = "blue:bt";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
+
+	reg_usdhc1_vmmc: reg-usdhc1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_usdhc1_vqmmc: reg-usdhc1-vqmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8_EXT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_usdhc2_vmmc: reg-usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vqmmc: reg-usdhc2-vqmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "NVCC_SD2";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_reg_on>;
+		gpio = <&gpio3 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* LS-SPI0 */
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+	phy-handle = <&ethphy>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+		};
+	};
+};
+
+/* LS-I2C0 */
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@8 {
+		compatible = "fsl,pfuze100";
+		reg = <0x8>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3ab {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+/* LS-I2C1 */
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+/* HS-I2C2 */
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+/* HS-I2C3 */
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+};
+
+&pgc_gpu {
+	power-supply = <&sw1a_reg>;
+};
+
+&pgc_vpu {
+	power-supply = <&sw1c_reg>;
+};
+
+&qspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <100000000>;
+		reg = <0>;
+	};
+};
+
+/* Debug UART */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MQ_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MQ_CLK_25M>;
+	status = "okay";
+};
+
+/* LS-UART0 */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clk IMX8MQ_CLK_UART2>;
+	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		device-wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_bt_gpios>;
+	};
+};
+
+/* LS-UART1 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clk IMX8MQ_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
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
+/* SDIO */
+&usdhc1 {
+	#address-cells = <0x1>;
+	#size-cells = <0x0>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	vmmc-supply = <&reg_usdhc1_vmmc>;
+	vqmmc-supply = <&reg_usdhc1_vqmmc>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	no-sd;
+	no-emmc;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* uSD */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	no-sdio;
+	no-emmc;
+	disable-wp;
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
+&iomuxc {
+	pinctrl_bt_gpios: btgpiosgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x19
+			MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14		0x19
+			MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5			0x19
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x16
+			MX8MQ_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x16
+			MX8MQ_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x16
+			MX8MQ_IOMUXC_ECSPI2_SS0_ECSPI2_SS0		0x16
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x4
+			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x24
+			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1c
+			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1c
+			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1c
+			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1c
+			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1c
+			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1c
+			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
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
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI2_RXFS_GPIO4_IO21		0x19
+			MX8MQ_IOMUXC_SAI2_RXC_GPIO4_IO22		0x19
+			MX8MQ_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
+			MX8MQ_IOMUXC_SAI3_RXC_GPIO4_IO29		0x19
+			MX8MQ_IOMUXC_SAI1_RXC_GPIO4_IO1			0x19
+			MX8MQ_IOMUXC_SAI1_RXFS_GPIO4_IO0		0x19
+		>;
+	};
+
+	pinctrl_qspi0: qspi0grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x82
+			MX8MQ_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x82
+			MX8MQ_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x82
+			MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x82
+			MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x82
+			MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x82
+
+		>;
+	};
+
+	pinctrl_reg_usdhc2: regusdhc2grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
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
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX		0x49
+			MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX		0x49
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
+			MX8MQ_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x85
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
+			MX8MQ_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x85
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
+			MX8MQ_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x85
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
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
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x8c
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcc
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xcc
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xcc
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xcc
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xcc
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x9c
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xdc
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xdc
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xdc
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xdc
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xdc
+			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xcc
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
+		>;
+	};
+
+	pinctrl_wifi_reg_on: wifiregongrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_NAND_CE2_B_GPIO3_IO3		0x17059
+		>;
+	};
+};
-- 
2.17.1

