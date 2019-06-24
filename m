Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67A4C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7638720645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3VAE4e1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbfFXSbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:31:20 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35942 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfFXSbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:31:19 -0400
Received: by mail-pf1-f178.google.com with SMTP id r7so8023032pfl.3;
        Mon, 24 Jun 2019 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIT3CZNSSWKjxMNRbK6JlK9GmP6CKA4SHJl57jzkIdE=;
        b=i3VAE4e1gEbSzMM5N8B9JMnNpYkoAgTrKSIgxKkDbWWrUDNKqq6GSXs9LZRv65P9jk
         U27AodmgxbGiw7kAA59wE/euAgEtIFDMG66dGnZCbR5j/M+SZlWZFGPw7nNcDXmRa4+0
         Q11otlJknUW4mnwBSx3VMdFwdE5q+7/NC18jymB73VBh5wMa3pfX2rqGNfLlTPFXRJRH
         lHSMDrcznIolwQbQmCxl4iajZGc16QSqYV8xG7oaTikxZzVC6sneGIaBjpd52f2DVUb1
         i6KnMOOY2JeyI37Ansy7TbFf0b34vfJWyPYHSAWLCas3nQLwATlOeqjA0WMQMWxEmvIo
         bATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIT3CZNSSWKjxMNRbK6JlK9GmP6CKA4SHJl57jzkIdE=;
        b=NLxoDBjEcUmf8Q+GXRjsO2b7nSHRKd9vcYlVSvD0hUxNg6oTsbnmzcf39X0SH2SnOz
         cwC60XbbrNla1kkYcOYZ0xY/iXVYv8NSC2/vd1NqkJ98RNWM6xoC/jsPRIxrvwshtrEZ
         d1q9WF5dfqKNQsmVwNgRgJE1gHo7u6tiPvsUry1+0P86blQQwftzOUJpt1E72Q++L+q6
         vgumwMT6W/W+acnbPsl9NHQY3rB5E0EsiZGE0iAeMmkCRVupHBqTj00EmyO0MgczhfnB
         RaCtpMeS/Qt9l5gV7XVhkIT/3+GbYAb60mR0XmnBaXejg3gA5M+m8p2FdTnW/7Lu97Vt
         PgSw==
X-Gm-Message-State: APjAAAX4rQi2O+Tg70OusEguVj9gjAcVYJQyeF7rhdLo7MXqoPAX/suS
        6BbYYlJPDbeWSDSO/I+cgbE=
X-Google-Smtp-Source: APXvYqzjbL/1XgbouBNbiAgZnGMyxdROzhtGWIwinrAx7dwNeF93kOpAVEE9eRUT2zwpOAFpyNzRyA==
X-Received: by 2002:a63:514e:: with SMTP id r14mr5209028pgl.71.1561401077946;
        Mon, 24 Jun 2019 11:31:17 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id p15sm206601pjf.27.2019.06.24.11.31.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 11:31:17 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] ARM: dts: Add ZII support for ZII i.MX7 RMU2 board
Date:   Mon, 24 Jun 2019 11:30:43 -0700
Message-Id: <20190624183044.30240-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII's i.MX7 based Remote Modem Unit 2 (RMU2) board.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Bob Langer <Bob.Langer@zii.aero>
Cc: Liang Pan <Liang.Pan@zii.aero>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---

Changes since [v2]:

    - Drop pmic label

    - Rename phy -> ethernet-phy

    - Drop snvs_pwrkey configuration
    
    - Move snvs_rtc up, to keep things alphabetical
    
    - Rename debuggrp -> ledsgrp

    - Collected Reviewed-by from Fabio

Changes since [v1]:

    - Added missing #address-cells and #size-cells

    - Replaced reset-gpio -> reset-gpios


[v1] lore.kernel.org/r/20190614080317.16850-1-andrew.smirnov@gmail.com
[v2] lore.kernel.org/r/20190617153025.12120-1-andrew.smirnov@gmail.com

 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/imx7d-zii-rmu2.dts | 357 +++++++++++++++++++++++++++
 2 files changed, 358 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-zii-rmu2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5559028b770e..516e2912236d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -593,6 +593,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-sdb.dtb \
 	imx7d-sdb-reva.dtb \
 	imx7d-sdb-sht11.dtb \
+	imx7d-zii-rmu2.dtb \
 	imx7d-zii-rpu2.dtb \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-mba7.dtb \
diff --git a/arch/arm/boot/dts/imx7d-zii-rmu2.dts b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
new file mode 100644
index 000000000000..2b8d6cc45a53
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device tree file for ZII's RMU2 board
+ *
+ * RMU - Remote Modem Unit
+ *
+ * Copyright (C) 2019 Zodiac Inflight Innovations
+ */
+
+/dts-v1/;
+#include <dt-bindings/thermal/thermal.h>
+#include "imx7d.dtsi"
+
+/ {
+	model = "ZII RMU2 Board";
+	compatible = "zii,imx7d-rmu2", "fsl,imx7d";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pinctrl_leds_debug>;
+		pinctrl-names = "default";
+
+		debug {
+			label = "zii:green:debug1";
+			gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&cpu0 {
+	arm-supply = <&sw1a_reg>;
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&fec1_phy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fec1_phy: ethernet-phy@0 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_enet1_phy_reset>,
+				    <&pinctrl_enet1_phy_interrupt>;
+			reg = <0>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
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
+	pmic@8 {
+		compatible = "fsl,pfuze3000";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1a {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1b {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1475000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
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
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vldo2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vccsd {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: v33 {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vldo3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vldo4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+	};
+
+	eeprom@52 {
+		compatible = "atmel,24c04";
+		reg = <0x52>;
+	};
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	assigned-clocks = <&clks IMX7D_UART4_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu2";
+		current-speed = <1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		watchdog {
+			compatible = "zii,rave-sp-watchdog";
+		};
+
+		eeprom@a3 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa3 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "main-eeprom";
+		};
+	};
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	no-1-8-v;
+	no-sdio;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	no-sdio;
+	no-sd;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
+&wdog1 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI1_SCLK__ECSPI1_SCLK	0x2
+			MX7D_PAD_ECSPI1_MOSI__ECSPI1_MOSI	0x2
+			MX7D_PAD_ECSPI1_MISO__ECSPI1_MISO	0x2
+			MX7D_PAD_ECSPI1_SS0__GPIO4_IO19         0x59
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CD_B__ENET1_MDIO				0x3
+			MX7D_PAD_SD2_WP__ENET1_MDC				0x3
+			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC		0x1
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0		0x1
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1		0x1
+			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2		0x1
+			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3		0x1
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL		0x1
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC		0x1
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0		0x1
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1		0x1
+			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2		0x1
+			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3		0x1
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL		0x1
+		>;
+	};
+
+	pinctrl_enet1_phy_reset: enet1phyresetgrp {
+		fsl,pins = <
+			MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x14
+
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
+			MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
+		>;
+	};
+
+	pinctrl_leds_debug: ledsgrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x59
+		>;
+	};
+
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX7D_PAD_UART2_RX_DATA__UART2_DCE_RX	0x79
+			MX7D_PAD_UART2_TX_DATA__UART2_DCE_TX	0x79
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_DATA0__UART4_DCE_RX	0x79
+			MX7D_PAD_SD2_DATA1__UART4_DCE_TX	0x79
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x19
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x19
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
+			MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x59
+		>;
+	};
+};
+
+&iomuxc_lpsr {
+	pinctrl_enet1_phy_interrupt: enet1phyinterruptgrp {
+		fsl,phy = <
+			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x08
+		>;
+	};
+};
-- 
2.21.0

