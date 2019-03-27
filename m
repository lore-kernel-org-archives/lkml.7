Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B94FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABE72075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLrEjKom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbfC0GmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:42:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38917 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbfC0Gl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:41:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so2849589plb.6;
        Tue, 26 Mar 2019 23:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6CU5GNankmPguoZzxjj3EaOgeVhPRkptV2C8EGN/WZU=;
        b=iLrEjKomRP7Z7oKHRHluD3IrkSBKKiW78sPMpBYInx07RB5KqPU3LcLzbBU9TfHh05
         NhO70EkLh1p3hx6F2hJZk75ernuDGiwCun3HmLMlAps/mM4udQNFHhXOdNLkCtqYJhCZ
         kUuJa1xaSFsTfVkANf84TiHJzP149wrggzXTklh1U/w/Kxe7BU/5JZ6+0AQ+b+Jjr5lA
         JIu9iuBbvCq9uuTI9w62AL29HE76m+GhqN8KudIals8YjWBr9Yf8j/Rz/bDPmP7Tr2Le
         wvZ+kpfNtDQpOk5n2VnEY2mWUABg1nd6i8/7sXNEVkFpHeLqF7HPfR/H0NwJd+hVLE+/
         IikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CU5GNankmPguoZzxjj3EaOgeVhPRkptV2C8EGN/WZU=;
        b=KCwVtLJCT7yrU6JE7fo3Utq1yuzWJTjQ+zheEZmgnt7ZN6RHodRpkSBEqMfJI9nOrY
         K5+WDC+ybOZcex9ayAjRRsKq3Z/1vHIHc+xbbAG9EsTBANbWPs0B5XDc6J3Bz8+x4d+X
         TNte36FbNEC1jLqnftlIyYBzY9l28YpNFd+9ohPh/AdLxIeyWThc0/xx/TKnaZHdc0hB
         jXsZ4hHXCLAcomni0wsPeZc2MWFfX4/tR+PK0MegnW4eRS8jn+1EiI1ifCoMS1LU4Iui
         DLCueG3L/klQy+F4Xtot1Ki92S95Ov5QG58xwufFvtZx72R4UA4C0Fx2cGw1fBhuhv1o
         XQYQ==
X-Gm-Message-State: APjAAAXbsgdM03ZGOfSVMbNTnZbvshqH2DKZKxas9eQzJq9j4+E0hbTA
        B1MInHjhj9q4IE72Z66Gwag=
X-Google-Smtp-Source: APXvYqz1tyntUEjq9cPqsEIeJ1tic5ymfphXveLhiqBZCWcqOWJnDQM/2tUc5XJkNXmF2UEVSL5DfQ==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr17496821pld.58.1553668917327;
        Tue, 26 Mar 2019 23:41:57 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id q87sm2487054pfa.133.2019.03.26.23.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:41:56 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: Add support for ZII i.MX7 RPU2 board
Date:   Tue, 26 Mar 2019 23:41:50 -0700
Message-Id: <20190327064150.31549-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327064150.31549-1-andrew.smirnov@gmail.com>
References: <20190327064150.31549-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII's i.MX7 based Remote Peripheral Unit 2 (RPU2)
board.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/imx7d-zii-rpu2.dts | 936 +++++++++++++++++++++++++++
 2 files changed, 937 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-zii-rpu2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efefce8efa05..687222907154 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -586,6 +586,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-sdb.dtb \
 	imx7d-sdb-reva.dtb \
 	imx7d-sdb-sht11.dtb \
+	imx7d-zii-rpu2.dtb \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-warp.dtb
 dtb-$(CONFIG_SOC_IMX7ULP) += \
diff --git a/arch/arm/boot/dts/imx7d-zii-rpu2.dts b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
new file mode 100644
index 000000000000..6f36c7d9d214
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
@@ -0,0 +1,936 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
+ * Device tree file for ZII's RPU2 board
+ *
+ * RPU - Remote Peripheral Unit
+ *
+ * Copyright (C) 2019 Zodiac Inflight Innovations
+ */
+
+/dts-v1/;
+#include "imx7d.dtsi"
+
+/ {
+	model = "ZII RPU2 Board";
+	compatible = "zii,imx7d-rpu2", "fsl,imx7d";
+
+	chosen {
+		stdout-path = &uart1;
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
+
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan1_stby>;
+		regulator-name = "can1-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_stby>;
+		regulator-name = "can2-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_vref_1v8: regulator-vref-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "GEN_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_5p0v_main: regulator-5p0v-main {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_MAIN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	sound1 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Audio Output 1";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound1_codec>;
+		simple-audio-card,frame-master = <&sound1_codec>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPLEFT",
+			"Headphone Jack", "HPRIGHT",
+			"LEFTIN", "HPL",
+			"RIGHTIN", "HPR";
+		simple-audio-card,aux-devs = <&hpa1>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		sound1_codec: simple-audio-card,codec {
+			sound-dai = <&codec1>;
+			clocks = <&cs2000>;
+		};
+	};
+
+	sound2 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Audio Output 2";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound2_codec>;
+		simple-audio-card,frame-master = <&sound2_codec>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPLEFT",
+			"Headphone Jack", "HPRIGHT",
+			"LEFTIN", "HPL",
+			"RIGHTIN", "HPR";
+		simple-audio-card,aux-devs = <&hpa2>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		sound2_codec: simple-audio-card,codec {
+			sound-dai = <&codec2>;
+			clocks = <&cs2000>;
+		};
+	};
+
+	sound3 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Audio Output 3";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound3_codec>;
+		simple-audio-card,frame-master = <&sound3_codec>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPLEFT",
+			"Headphone Jack", "HPRIGHT",
+			"LEFTIN", "HPL",
+			"RIGHTIN", "HPR";
+		simple-audio-card,aux-devs = <&hpa3>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+
+		sound3_codec: simple-audio-card,codec {
+			sound-dai = <&codec3>;
+			clocks = <&cs2000>;
+		};
+	};
+
+	cs2000_ref: cs2000-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	cs2000_in_dummy: cs2000-in-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&adc2 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&cpu0 {
+	arm-supply = <&sw1a_reg>;
+};
+
+&clks {
+	assigned-clocks = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <884736000>;
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	status = "okay";
+
+	cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
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
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+
+	mdio1: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		switch: switch@0 {
+			compatible = "marvell,mv88e6085";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_switch>;
+			reg = <0>;
+			eeprom-length = <512>;
+			interrupt-parent = <&gpio1>;
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
+					label = "eth_cu_1000_1";
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "eth_cu_1000_2";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "pic";
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					label = "cpu";
+					ethernet = <&fec1>;
+					phy-mode = "rgmii-id";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					label = "gigabit_proc";
+					ethernet = <&fec2>;
+					phy-mode = "rgmii-id";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	assigned-clocks = <&clks IMX7D_ENET2_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET2_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	fsl,magic-packet;
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio1>;
+
+	gpio-line-names = "", "", "", "", "", "", "", "",
+			  "", "",
+			  "usb_1_en_b",
+			  "usb_2_en_b",
+			  "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "",
+			  "", "", "", "";
+};
+
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>;
+
+	gpio-line-names = "12v_out_en_1",
+			  "12v_out_en_2",
+			  "12v_out_en_3",
+			  "28v_out_en_5",
+			  "28v_out_en_1",
+			  "28v_out_en_2",
+			  "28v_out_en_3",
+			  "28v_out_en_4",
+			  "", "",
+			  "usb_3_en_b",
+			  "usb_4_en_b",
+			  "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "",
+			  "", "", "", "";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pfuze3000@8 {
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
+	cs2000: clkgen@4e {
+		compatible = "cirrus,cs2000-cp";
+		reg = <0x4e>;
+		#clock-cells = <0>;
+		clock-names = "clk_in", "ref_clk";
+		clocks = <&cs2000_in_dummy>, <&cs2000_ref>;
+		assigned-clocks = <&cs2000>;
+		assigned-clock-rates = <24000000>;
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
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	codec2: codec@18 {
+		compatible = "ti,tlv320dac3100";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_codec2>;
+		reg = <0x18>;
+		#sound-dai-cells = <0>;
+		HPVDD-supply = <&reg_3p3v>;
+		SPRVDD-supply = <&reg_3p3v>;
+		SPLVDD-supply = <&reg_3p3v>;
+		AVDD-supply = <&reg_3p3v>;
+		IOVDD-supply = <&reg_3p3v>;
+		DVDD-supply = <&vgen4_reg>;
+		gpio-reset = <&gpio1 6 GPIO_ACTIVE_LOW>;
+	};
+
+	hpa2: amp@60 {
+		compatible = "ti,tpa6130a2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpa2>;
+		reg = <0x60>;
+		power-gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
+		Vdd-supply = <&reg_5p0v_main>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	codec3: codec@18 {
+		compatible = "ti,tlv320dac3100";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_codec3>;
+		reg = <0x18>;
+		#sound-dai-cells = <0>;
+		HPVDD-supply = <&reg_3p3v>;
+		SPRVDD-supply = <&reg_3p3v>;
+		SPLVDD-supply = <&reg_3p3v>;
+		AVDD-supply = <&reg_3p3v>;
+		IOVDD-supply = <&reg_3p3v>;
+		DVDD-supply = <&vgen4_reg>;
+		gpio-reset = <&gpio1 7 GPIO_ACTIVE_LOW>;
+	};
+
+	hpa3: amp@60 {
+		compatible = "ti,tpa6130a2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpa3>;
+		reg = <0x60>;
+		power-gpio = <&gpio3 28 GPIO_ACTIVE_HIGH>;
+		Vdd-supply = <&reg_5p0v_main>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	codec1: codec@18 {
+		compatible = "ti,tlv320dac3100";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_codec1>;
+		reg = <0x18>;
+		#sound-dai-cells = <0>;
+		HPVDD-supply = <&reg_3p3v>;
+		SPRVDD-supply = <&reg_3p3v>;
+		SPLVDD-supply = <&reg_3p3v>;
+		AVDD-supply = <&reg_3p3v>;
+		IOVDD-supply = <&reg_3p3v>;
+		DVDD-supply = <&vgen4_reg>;
+		gpio-reset = <&gpio1 5 GPIO_ACTIVE_LOW>;
+	};
+
+	hpa1: amp@60 {
+		compatible = "ti,tpa6130a2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpa1>;
+		reg = <0x60>;
+		power-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>;
+		Vdd-supply = <&reg_5p0v_main>;
+	};
+};
+
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
+			  <&clks IMX7D_SAI1_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <36864000>;
+	status = "okay";
+};
+
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clks IMX7D_SAI2_ROOT_SRC>,
+			  <&clks IMX7D_SAI2_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <36864000>;
+	status = "okay";
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clks IMX7D_SAI3_ROOT_SRC>,
+			  <&clks IMX7D_SAI3_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <36864000>;
+	status = "okay";
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
+&usbotg1 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
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
+&snvs_rtc {
+	status = "disabled";
+};
+
+&snvs_pwrkey {
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
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC			0x1
+			MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0			0x1
+			MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1			0x1
+			MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2			0x1
+			MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3			0x1
+			MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL			0x1
+			MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC			0x1
+			MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0			0x1
+			MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1			0x1
+			MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2			0x1
+			MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3			0x1
+			MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL			0x1
+			MX7D_PAD_UART1_TX_DATA__ENET2_1588_EVENT0_OUT		0x1
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO12__FLEXCAN1_RX	0x59
+			MX7D_PAD_GPIO1_IO13__FLEXCAN1_TX	0x59
+		>;
+	};
+
+	pinctrl_flexcan1_stby: flexcan1stbygrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO08__GPIO1_IO8		0x59
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
+			MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x59
+		>;
+	};
+
+	pinctrl_flexcan2_stby: flexcan2stbygrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x59
+		>;
+	};
+
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x00
+			MX7D_PAD_GPIO1_IO11__GPIO1_IO11		0x00
+		>;
+	};
+
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x00
+			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x00
+			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x00
+			MX7D_PAD_EPDC_DATA03__GPIO2_IO3		0x03
+			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x03
+			MX7D_PAD_EPDC_DATA05__GPIO2_IO5		0x03
+			MX7D_PAD_EPDC_DATA06__GPIO2_IO6		0x03
+			MX7D_PAD_EPDC_DATA07__GPIO2_IO7		0x03
+			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x00
+			MX7D_PAD_EPDC_DATA11__GPIO2_IO11	0x00
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
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SDA__GPIO4_IO9		0x4000007f
+			MX7D_PAD_I2C1_SCL__GPIO4_IO8		0x4000007f
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
+			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x4000007f
+			MX7D_PAD_I2C2_SCL__GPIO4_IO10		0x4000007f
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
+			MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__GPIO4_IO13		0x4000007f
+			MX7D_PAD_I2C3_SCL__GPIO4_IO12		0x4000007f
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
+			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x4000007f
+			MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0x4000007f
+		>;
+	};
+
+	pinctrl_leds_debug: debuggrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x59
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX7D_PAD_SAI1_TX_BCLK__SAI1_TX_BCLK	0x1f
+			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
+			MX7D_PAD_SAI1_TX_DATA__SAI1_TX_DATA0	0x30
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_TX_BCLK__SAI2_TX_BCLK	0x1f
+			MX7D_PAD_SAI2_TX_SYNC__SAI2_TX_SYNC	0x1f
+			MX7D_PAD_SAI2_TX_DATA__SAI2_TX_DATA0	0x30
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__SAI3_TX_BCLK	0x1f
+			MX7D_PAD_UART3_CTS_B__SAI3_TX_SYNC	0x1f
+			MX7D_PAD_UART3_RTS_B__SAI3_TX_DATA0	0x30
+		>;
+	};
+
+	pinctrl_tpa1: tpa6130-1grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA21__GPIO3_IO26		0x40000038
+		>;
+	};
+
+	pinctrl_tpa2: tpa6130-2grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA22__GPIO3_IO27		0x40000038
+		>;
+	};
+
+	pinctrl_tpa3: tpa6130-3grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA23__GPIO3_IO28		0x40000038
+		>;
+	};
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
+	pinctrl_codec1: dac1grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x40000038
+		>;
+	};
+
+	pinctrl_codec2: dac2grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x40000038
+		>;
+	};
+
+	pinctrl_codec3: dac3grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x40000038
+		>;
+	};
+
+	pinctrl_switch: switchgrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x08
+		>;
+	};
+};
-- 
2.20.1

