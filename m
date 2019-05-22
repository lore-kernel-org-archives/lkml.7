Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61533C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2288D2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0pNbEcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfEVNQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:16:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfEVNQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:16:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id g69so1073069plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7/8TA+cL55vqgUwtOrO0zHU6pqvlEdQLUD7j6Bw+RPg=;
        b=k0pNbEcZp7ieluuZsCz2EagVFfTzW96e1hLqT9PzejMqQDJl1mk+Oa2Kft17vEmhwZ
         LSjkPku4MzjnYA2G49hMaA4s5nXwLvdeBy8ijlAJ5/lQgKjbDeOUlwMjeRVRB/zdhD9l
         VE0GSXP0El50Gd2PIWzmO1VjDA8H7MT/jKFZf79stLDssdXoRem0a7Gs1x3ZB/nlirWI
         rwwXBoxaCL78nhUo6cP+iQKH6LhXbQ6eCkYpKdia+Q8XxpgzAopCtf3lMHVkSdh6CB7H
         /7B48/SqIh3R9uhVgHX5ERtIm/vEE0skhKQyBFc7Ia+76ZdfwZ8hrcI0O2qouI3+DXCf
         ANlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7/8TA+cL55vqgUwtOrO0zHU6pqvlEdQLUD7j6Bw+RPg=;
        b=HtwhC53DGGgSz+CSlUEBmyzOJCyF0L1ZUHH9JHDQt5kDOOhlj05QavQXTK6bxJNlFe
         GCFtythVuCxtAFTxhfz133ccLm43Ko42s46Tl69QPRBdnI8M3MswTHwgDjFXcOPi6DIk
         3tUHRpGK6PS+b24dVqoSXJ1Odma6jc+5JDFcuj5pg1kFCn2XCXU1thtLiiw93HEaiQbd
         Q/XVn00lLZDisva3eYiRuprZC4hAe1cVerBjsSCCKY/ZigeO8L5m05w78rlT0jeZyr29
         Rbl9+oNyT4LhZXqqh6y9zUnwuV6J0OADkT9q1JPM4I13WU9qGwIeEk7BheE6BoUAqAgY
         oCuA==
X-Gm-Message-State: APjAAAUpQlwPSsZ55VbOvFfR9zMH0W9WzRABirHQ/JGvvKR1hY02oUFT
        Lwq3vOIs384fF9b8URoivL8n
X-Google-Smtp-Source: APXvYqyAianOUOrL7PBqYiT72NPkqQ6o1gkPvTNFOrvrjw/jk75u75Rg8BQ5fiaKFGl7S//VbFdNRQ==
X-Received: by 2002:a17:902:2884:: with SMTP id f4mr61837102plb.230.1558530991083;
        Wed, 22 May 2019 06:16:31 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c4:1ab0:ac45:9c21:7eb3:888a])
        by smtp.gmail.com with ESMTPSA id b7sm22273565pgq.71.2019.05.22.06.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 06:16:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbrobinson@gmail.com,
        yossi@novtech.com, nazik@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] ARM: dts: Add support for 96Boards Meerkat96 board
Date:   Wed, 22 May 2019 18:45:50 +0530
Message-Id: <20190522131550.9034-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522131550.9034-1-manivannan.sadhasivam@linaro.org>
References: <20190522131550.9034-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for 96Boards Meerkat96 board from Novtech. This
board is one of the Consumer Edition boards of the 96Boards family based
on i.MX7D SoC. Following are the currently supported features of the
board:

* uSD
* WiFi/BT
* USB

More information about this board can be found in 96Boards product page:
https://www.96boards.org/product/imx7-96/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/imx7d-meerkat96.dts | 396 ++++++++++++++++++++++++++
 2 files changed, 397 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-meerkat96.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f4f5aeaf3298..3018a763dbd1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -579,6 +579,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
 	imx7d-colibri-eval-v3.dtb \
+	imx7d-meerkat96.dtb \
 	imx7d-nitrogen7.dtb \
 	imx7d-pico-hobbit.dtb \
 	imx7d-pico-pi.dtb \
diff --git a/arch/arm/boot/dts/imx7d-meerkat96.dts b/arch/arm/boot/dts/imx7d-meerkat96.dts
new file mode 100644
index 000000000000..7898d27340f6
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-meerkat96.dts
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include "imx7d.dtsi"
+
+/ {
+	model = "96Boards Meerkat96 Board";
+	compatible = "novtech,imx7d-meerkat96", "fsl,imx7d";
+
+	chosen {
+		stdout-path = &uart6;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512MB */
+	};
+
+	reg_wlreg_on: regulator-wlreg_on {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wlreg_on>;
+		regulator-name = "wlreg_on";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100>;
+		gpio = <&gpio6 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	sw1a_reg: sw1a {
+		regulator-name = "sw1a_reg";
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1475000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-ramp-delay = <6250>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led1 {
+			label = "green:user1";
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led2 {
+			label = "green:user2";
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+
+		led3 {
+			label = "green:user3";
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "mmc1";
+			default-state = "off";
+		};
+
+		led4 {
+			label = "green:user4";
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			panic-indicator;
+		};
+
+		led@5 {
+			label = "yellow:wlan";
+			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		led@6 {
+			label = "blue:bt";
+			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&sw1a_reg>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7 &pinctrl_bt_gpios>;
+	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	fsl,uart-has-rtscts;
+	fsl,dte-mode;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		device-wakeup-gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio4 17 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	keep-power-in-suspend;
+	tuning-step = <2>;
+	vmmc-supply = <&reg_3p3v>;
+	no-1-8-v;
+	broken-cd;
+	status = "okay";
+};
+
+&usdhc3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	non-removable;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	vmmc-supply = <&reg_wlreg_on>;
+	vqmmc-supply =<&reg_3p3v>;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wlan_irq>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+	};
+};
+
+&iomuxc {
+	imx7d-sdb {
+		pinctrl_bt_gpios: bt_gpios {
+			fsl,pins = <
+				MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x59
+				MX7D_PAD_ECSPI1_MOSI__GPIO4_IO17	0x1f
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
+				MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
+				MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX7D_PAD_ENET1_RGMII_RD1__I2C3_SDA	0x4000007f
+				MX7D_PAD_ENET1_RGMII_RD0__I2C3_SCL	0x4000007f
+			>;
+		};
+
+		pinctrl_i2c4: i2c4grp {
+			fsl,pins = <
+				MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
+				MX7D_PAD_SAI1_RX_SYNC__I2C4_SCL		0x4000007f
+			>;
+		};
+
+		pinctrl_lcdif: lcdifgrp {
+			fsl,pins = <
+				MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+				MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+				MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+				MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+				MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+				MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+				MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+				MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+				MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+				MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+				MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+				MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+				MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+				MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+				MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+				MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+				MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
+				MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+				MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+				MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+				MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+				MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+				MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
+				MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+				MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+				MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+				MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+				MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+				MX7D_PAD_LCD_RESET__LCD_RESET		0x79
+			>;
+		};
+
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59
+				MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x59
+				MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x59
+				MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x59
+				MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x59
+				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59
+			>;
+		};
+
+		pinctrl_tda998x: hdmigrp-1 {
+			fsl,pins = <
+				MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x59
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
+				MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
+			>;
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <
+				MX7D_PAD_SD3_DATA4__UART3_DCE_RX	0x79
+				MX7D_PAD_SD3_DATA5__UART3_DCE_TX	0x79
+				MX7D_PAD_SD3_DATA6__UART3_DCE_RTS	0x79
+				MX7D_PAD_SD3_DATA7__UART3_DCE_CTS	0x79
+			>;
+		};
+
+		pinctrl_uart6: uart6grp {
+			fsl,pins = <
+				MX7D_PAD_SD1_CD_B__UART6_DCE_RX		0x79
+				MX7D_PAD_SD1_WP__UART6_DCE_TX		0x79
+			>;
+		};
+
+		pinctrl_uart7: uart7grp {
+			fsl,pins = <
+				MX7D_PAD_ECSPI2_SCLK__UART7_DTE_TX	0x79
+				MX7D_PAD_ECSPI2_MOSI__UART7_DTE_RX	0x79
+				MX7D_PAD_ECSPI2_MISO__UART7_DTE_CTS	0x79
+				MX7D_PAD_ECSPI2_SS0__UART7_DTE_RTS	0x79
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
+				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
+				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
+				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
+				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
+				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
+			>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
+				MX7D_PAD_SD3_CLK__SD3_CLK		0x0D
+				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
+				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
+				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
+				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
+			>;
+		};
+
+		pinctrl_wlreg_on: wlreg_on {
+			fsl,pins = <
+				MX7D_PAD_SAI1_TX_DATA__GPIO6_IO15	0x19
+			>;
+		};
+
+		pinctrl_wlan_irq: wlan_irq {
+			fsl,pins = <
+				MX7D_PAD_SAI1_TX_SYNC__GPIO6_IO14	0x19
+			>;
+		};
+	};
+};
-- 
2.17.1

