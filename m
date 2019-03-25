Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C315720700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQTnU/Sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfCYSXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:23:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33073 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbfCYSXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:23:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so7007115pgk.0;
        Mon, 25 Mar 2019 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnu5IPNh5Nyc9ArnKhPoWL0t434SH69X54flKiftGTw=;
        b=pQTnU/ShISho1dHvTN08M5O9vwRTUdA/w8DGyNmbIyeXBtHZCV8E8Tu3oc/bwMZxci
         fIM2eVcXlLMpWZW5Ez5kA/XS1gX1Ddg1472f2wk0FC1Bkm8oO7YSvKGoQmQxolbBSgp2
         5/J0yxpMQMlcv8mzpU1ksphVtS+fzH91myvOHzorT+Kz/57W1sDv3CctegVdCnkdPMLG
         9sc0KNl1hei3ddApTfhw5sPGR3fjAmCFtmdMIUmrc+pL1Sl5KVplz4cqWGeLtSGU7SJK
         a7mhFtqmIQZUmojS2yBEYRNnEVN8XRPJlqqn7UYPy9Is4GcWrg153o5Q3BasHlouYaQ/
         l+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnu5IPNh5Nyc9ArnKhPoWL0t434SH69X54flKiftGTw=;
        b=QT6SHunJD6YofGtX4fgnP/7PbO2q1YXKjqIh+vYQb3lmaQRoLk9s2PRpwzLZW/mdV6
         WavpzKb4JuJlVfyX6Tp7F2aDOJj6NCk42KJVU+/3LaJD85Gc7kDHJrCNQVELRlnItSiy
         0i7JvETB9qS2ILXSfQngvW7XON9EL+lKrBoz/A/aADDG2camLPUOfprhk1pXm8tUBMZw
         dTjnIeRmS5LiNpa6kCA34QnwEWXS+yUjauxvdhKgdHCjr0bEIcMOshF+0LrLUXTPFlBI
         1zaGQYA7+cELbRTAZ3/PfpshrshfJ1Dj862fKAo1LEqWhPHplDc/bHOfFbd1kTiKejYM
         KGUg==
X-Gm-Message-State: APjAAAWQ6nd73ErDwDks+kxX62D+27WOKNamCDnu+2rhlJzo61PkBHLn
        8ui/m1rltk0Y5q1VybyEcc4=
X-Google-Smtp-Source: APXvYqzRTVxvq+0blSorOxgC+Xhg3aZQkacc3yTbqxyT7QDkQ/aXS8lxbCZ3wWmnigDQJKar3A07uA==
X-Received: by 2002:a63:6881:: with SMTP id d123mr24372659pgc.10.1553538185613;
        Mon, 25 Mar 2019 11:23:05 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h19sm23603315pfd.130.2019.03.25.11.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:23:04 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v3 3/3] ARM: dts: vf610: Add ZII SPB4 board
Date:   Mon, 25 Mar 2019 11:22:43 -0700
Message-Id: <20190325182243.16788-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325182243.16788-1-andrew.smirnov@gmail.com>
References: <20190325182243.16788-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Tree for VF610 based Zodiac Seat Power Box.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-imx@nxp.com
---

Changes since [v2]:

    - Collected Reviewed-by from Fabio

    - Fixed whitespace problems

    - Added patches for DT schema

Changes since [v1]:

    - Change Makefile diff to keep entries in alphabetical order

    - Various node name changes


[v2] lkml.kernel.org/r/20190313070224.30124-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20190311184928.25988-1-andrew.smirnov@gmail.com


 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/vf610-zii-spb4.dts | 359 +++++++++++++++++++++++++++
 2 files changed, 360 insertions(+)
 create mode 100644 arch/arm/boot/dts/vf610-zii-spb4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f4f5aeaf3298..efefce8efa05 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -606,6 +606,7 @@ dtb-$(CONFIG_SOC_VF610) += \
 	vf610-zii-dev-rev-b.dtb \
 	vf610-zii-dev-rev-c.dtb \
 	vf610-zii-scu4-aib.dtb \
+	vf610-zii-spb4.dtb \
 	vf610-zii-ssmb-dtu.dtb \
 	vf610-zii-ssmb-spu3.dtb
 dtb-$(CONFIG_ARCH_MXS) += \
diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
new file mode 100644
index 000000000000..9dde83ccb9d1
--- /dev/null
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
+ * Device tree file for ZII's SPB4 board
+ *
+ * SPB - Seat Power Box
+ *
+ * Copyright (C) 2019 Zodiac Inflight Innovations
+ */
+
+/dts-v1/;
+#include "vf610.dtsi"
+
+/ {
+	model = "ZII VF610 SPB4 Board";
+	compatible = "zii,vf610spb4", "zii,vf610dev", "fsl,vf610";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pinctrl_leds_debug>;
+		pinctrl-names = "default";
+
+		led-debug {
+			label = "zii:green:debug1";
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_vcc_3v3_mcu: regulator-vcc-3v3-mcu {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_mcu";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&adc0 {
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
+};
+
+&adc1 {
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
+};
+
+&dspi1 {
+	bus-num = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dspi1>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&edma0 {
+	status = "okay";
+};
+
+&edma1 {
+	status = "okay";
+};
+
+&esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc0>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	keep-power-in-suspend;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <4>;
+	no-sdio;
+	status = "okay";
+};
+
+&fec1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	status = "okay";
+
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+
+	mdio1: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		switch0: switch0@0 {
+			compatible = "marvell,mv88e6190";
+			pinctrl-0 = <&pinctrl_gpio_switch0>;
+			pinctrl-names = "default";
+			reg = <0>;
+			eeprom-length = <65536>;
+			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "cpu";
+					ethernet = <&fec1>;
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "eth_cu_1000_1";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "eth_cu_1000_2";
+				};
+
+				port@3 {
+					reg = <3>;
+					label = "eth_cu_1000_3";
+				};
+
+				port@4 {
+					reg = <4>;
+					label = "eth_cu_1000_4";
+				};
+
+				port@5 {
+					reg = <5>;
+					label = "eth_cu_1000_5";
+				};
+
+				port@6 {
+					reg = <6>;
+					label = "eth_cu_1000_6";
+				};
+			};
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	status = "okay";
+
+	io-expander@22 {
+		compatible = "nxp,pca9554";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		label = "nameplate";
+	};
+
+	eeprom@52 {
+		compatible = "atmel,24c04";
+		reg = <0x52>;
+	};
+};
+
+&snvsrtc {
+	status = "disabled";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
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
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&wdoga5 {
+       status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_dspi1: dspi1grp {
+		fsl,pins = <
+			VF610_PAD_PTD5__DSPI1_CS0		0x1182
+			VF610_PAD_PTD4__DSPI1_CS1		0x1182
+			VF610_PAD_PTC6__DSPI1_SIN		0x1181
+			VF610_PAD_PTC7__DSPI1_SOUT		0x1182
+			VF610_PAD_PTC8__DSPI1_SCK		0x1182
+		>;
+	};
+
+	pinctrl_esdhc0: esdhc0grp {
+		fsl,pins = <
+			VF610_PAD_PTC0__ESDHC0_CLK		0x31ef
+			VF610_PAD_PTC1__ESDHC0_CMD		0x31ef
+			VF610_PAD_PTC2__ESDHC0_DAT0		0x31ef
+			VF610_PAD_PTC3__ESDHC0_DAT1		0x31ef
+			VF610_PAD_PTC4__ESDHC0_DAT2		0x31ef
+			VF610_PAD_PTC5__ESDHC0_DAT3		0x31ef
+			VF610_PAD_PTD23__ESDHC0_DAT4		0x31ef
+			VF610_PAD_PTD22__ESDHC0_DAT5		0x31ef
+			VF610_PAD_PTD21__ESDHC0_DAT6		0x31ef
+			VF610_PAD_PTD20__ESDHC0_DAT7		0x31ef
+		>;
+	};
+
+	pinctrl_esdhc1: esdhc1grp {
+		fsl,pins = <
+			VF610_PAD_PTA24__ESDHC1_CLK		0x31ef
+			VF610_PAD_PTA25__ESDHC1_CMD		0x31ef
+			VF610_PAD_PTA26__ESDHC1_DAT0		0x31ef
+			VF610_PAD_PTA27__ESDHC1_DAT1		0x31ef
+			VF610_PAD_PTA28__ESDHC1_DATA2		0x31ef
+			VF610_PAD_PTA29__ESDHC1_DAT3		0x31ef
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			VF610_PAD_PTA6__RMII_CLKIN		0x30d1
+			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
+			VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
+			VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
+			VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
+			VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
+			VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
+			VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
+			VF610_PAD_PTC16__ENET_RMII1_TXD0	0x30d2
+			VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
+		>;
+	};
+
+	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
+		fsl,pins = <
+			VF610_PAD_PTE2__GPIO_107		0x31c2
+			VF610_PAD_PTB28__GPIO_98		0x219d
+		>;
+	};
+
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			VF610_PAD_PTB14__I2C0_SCL		0x37ff
+			VF610_PAD_PTB15__I2C0_SDA		0x37ff
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			VF610_PAD_PTB16__I2C1_SCL		0x37ff
+			VF610_PAD_PTB17__I2C1_SDA		0x37ff
+		>;
+	};
+
+	pinctrl_leds_debug: pinctrl-leds-debug {
+		fsl,pins = <
+			VF610_PAD_PTD3__GPIO_82			0x31c2
+		>;
+	};
+
+	pinctrl_uart0: uart0grp {
+		fsl,pins = <
+			VF610_PAD_PTB10__UART0_TX		0x21a2
+			VF610_PAD_PTB11__UART0_RX		0x21a1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			VF610_PAD_PTB23__UART1_TX		0x21a2
+			VF610_PAD_PTB24__UART1_RX		0x21a1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			VF610_PAD_PTD0__UART2_TX		0x21a2
+			VF610_PAD_PTD1__UART2_RX		0x21a1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			VF610_PAD_PTA30__UART3_TX		0x21a2
+			VF610_PAD_PTA31__UART3_RX		0x21a1
+		>;
+	};
+};
-- 
2.20.1

