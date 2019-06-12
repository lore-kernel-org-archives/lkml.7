Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFE6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277432080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvSF1zZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfFLHz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:55:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47057 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfFLHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:55:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so9142200pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dX8ayxbG6dv3ymS6EHBWk6+IbbfEAXYHv1SHsYeWqgY=;
        b=yvSF1zZk6pvNg3yFSmYEkBkETtB1a1JUR6L7bc1OTd/8jnUDx8NpWPT+rMvSSxmler
         bAa3EkGpAMX/kK/42QdaOAs0fZoppiIq5RbF0NdfvKZt4tu/cVvpB2NmsQiv2TIp1YAs
         bjHEbIPH1T2yhCQTobs8pQpHJxCYgZBQTuiFdLJLs6N/bv9MHC3LstILSi7dH+SvrUZN
         IuVUCuEC2db48RsElxYwBeIbSM2kqmPsNIeImGzlgPuaOjFnqMARqk6e62uk42LsUiwb
         vCWlA3zMDijl5Kz44kxGMPxD+BtjOJ6TOffTTsj/BwA+6v90GgDJRTnuDUMWnEzqvYbb
         +ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dX8ayxbG6dv3ymS6EHBWk6+IbbfEAXYHv1SHsYeWqgY=;
        b=FtdiQVO+M8+991FyjQvN6pGm6PNDIQnACszny4sMM0ISn3bRK0bAHokMJsVt4VquWG
         bWEMoJ+o0Fmxo35GzU/YIYS/+fVTeq2PoXNx1cI/hc1xXnFpHEbaozfdS2Mb/VnLFikC
         /scyMAlOjSt8/R05vf+bzCagxm0WcPRRXIGsYkLSXOaBqkV4PaNb4PqT8aMOPtTkdjhe
         TTpT238aTYQXaNguf7nWp7YxOThHrCs0oYhFpkHkLVzEBOgyZpABtLzZkcEev4uYUK3X
         +Y6xHclgyTpm17TfFuY3t87qWNSezRsIuTD1RbJmJ5F1/KqXlJIz3vbQTGNC2SiKo9uu
         vYVA==
X-Gm-Message-State: APjAAAUiPtRWoVcPHdkbHVlFGu1+onnXpPshz2+DhPJpxhfdUshTSP0r
        Iz3ta05L47mRyWAoPF3MahK1
X-Google-Smtp-Source: APXvYqy9brcyJa9cOLqSc4S85FGB54wo9ovBp6MNXHxx9AHNw51a1v1EA4T5P76BseRnHvE/D7bdwg==
X-Received: by 2002:a65:668e:: with SMTP id b14mr19917390pgw.407.1560326126600;
        Wed, 12 Jun 2019 00:55:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:894:d456:15b5:9ca9:e3ec:c06a])
        by smtp.gmail.com with ESMTPSA id b15sm16846399pfi.141.2019.06.12.00.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 00:55:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 4/4] ARM: dts: Add Avenger96 devicetree support based on STM32MP157A
Date:   Wed, 12 Jun 2019 13:24:51 +0530
Message-Id: <20190612075451.8643-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
References: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Avenger96 board based on STM32MP157A MPU
from ST Micro. This board is one of the 96Boards Consumer Edition board
from Arrow Electronics and has the following features:

SoC: STM32MP157AAC
PMIC: STPMIC1A
RAM: 1024 Mbyte @ 533MHz
Storage: eMMC v4.51: 8 Gbyte
         microSD Socket: UHS-1 v3.01
Ethernet Port: 10/100/1000 Mbit/s, IEEE 802.3 Compliant
Wireless: WiFi 5 GHz & 2.4GHz IEEE 802.11a/b/g/n/ac
          Bluetooth®v4.2 (BR/EDR/BLE)
USB: 2x Type A (USB 2.0) Host and 1x Micro B (USB 2.0) OTG
Display: HDMI: WXGA (1366x768)@ 60 fps, HDMI 1.4
LED: 4x User LED, 1x WiFi LED, 1x BT LED

More information about this board can be found in 96Boards website:
https://www.96boards.org/product/avenger96/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/stm32mp157a-avenger96.dts | 321 ++++++++++++++++++++
 2 files changed, 322 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-avenger96.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dab2914fa293..918c85c227b5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -975,6 +975,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32746g-eval.dtb \
 	stm32h743i-eval.dtb \
 	stm32h743i-disco.dtb \
+	stm32mp157a-avenger96.dtb \
 	stm32mp157a-dk1.dtb \
 	stm32mp157c-dk2.dtb \
 	stm32mp157c-ed1.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
new file mode 100644
index 000000000000..9d00be78010f
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright (C) Linaro Ltd 2019 - All Rights Reserved
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+/dts-v1/;
+
+#include "stm32mp157c.dtsi"
+#include "stm32mp157-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/st,stpmic1.h>
+
+/ {
+	model = "Arrow Electronics STM32MP157A Avenger96 board";
+	compatible = "arrow,stm32mp157a-avenger96", "st,stm32mp157";
+
+	aliases {
+		ethernet0 = &ethernet0;
+		mmc0 = &sdmmc1;
+		serial0 = &uart4;
+		serial1 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@c0000000 {
+		device_type = "memory";
+		reg = <0xc0000000 0x40000000>;
+	};
+
+	led {
+		compatible = "gpio-leds";
+		led1 {
+			label = "green:user1";
+			gpios = <&gpioz 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led2 {
+			label = "green:user2";
+			gpios = <&gpiof 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+
+		led3 {
+			label = "green:user3";
+			gpios = <&gpiog 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+			default-state = "off";
+		};
+
+		led4 {
+			label = "green:user3";
+			gpios = <&gpiog 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			panic-indicator;
+		};
+
+		led5 {
+			label = "yellow:wifi";
+			gpios = <&gpioz 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		led6 {
+			label = "blue:bt";
+			gpios = <&gpioz 6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+	};
+};
+
+&ethernet0 {
+	status = "okay";
+	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
+	pinctrl-1 = <&ethernet0_rgmii_pins_sleep_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rgmii";
+	max-speed = <1000>;
+	phy-handle = <&phy0>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@7 {
+			reg = <7>;
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_b>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_b1 &i2c2_pins_b2>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	pmic: stpmic@33 {
+		compatible = "st,stpmic1";
+		reg = <0x33>;
+		interrupts-extended = <&exti 55 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		status = "okay";
+
+		st,main-control-register = <0x04>;
+		st,vin-control-register = <0xc0>;
+		st,usb-control-register = <0x30>;
+
+		regulators {
+			compatible = "st,stpmic1-regulators";
+
+			ldo1-supply = <&v3v3>;
+			ldo2-supply = <&v3v3>;
+			ldo3-supply = <&vdd_ddr>;
+			ldo5-supply = <&v3v3>;
+			ldo6-supply = <&v3v3>;
+			pwr_sw1-supply = <&bst_out>;
+			pwr_sw2-supply = <&bst_out>;
+
+			vddcore: buck1 {
+				regulator-name = "vddcore";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			vdd_ddr: buck2 {
+				regulator-name = "vdd_ddr";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			vdd: buck3 {
+				regulator-name = "vdd";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				st,mask_reset;
+				regulator-initial-mode = <0>;
+				regulator-over-current-protection;
+			};
+
+			v3v3: buck4 {
+				regulator-name = "v3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+				regulator-initial-mode = <0>;
+			};
+
+			vdda: ldo1 {
+				regulator-name = "vdda";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <2900000>;
+				interrupts = <IT_CURLIM_LDO1 0>;
+				interrupt-parent = <&pmic>;
+			};
+
+			v2v8: ldo2 {
+				regulator-name = "v2v8";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				interrupts = <IT_CURLIM_LDO2 0>;
+				interrupt-parent = <&pmic>;
+			};
+
+			vtt_ddr: ldo3 {
+				regulator-name = "vtt_ddr";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <750000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			vdd_usb: ldo4 {
+				regulator-name = "vdd_usb";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				interrupts = <IT_CURLIM_LDO4 0>;
+				interrupt-parent = <&pmic>;
+			};
+
+			vdd_sd: ldo5 {
+				regulator-name = "vdd_sd";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <2900000>;
+				interrupts = <IT_CURLIM_LDO5 0>;
+				interrupt-parent = <&pmic>;
+				regulator-boot-on;
+			};
+
+			v1v8: ldo6 {
+				regulator-name = "v1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				interrupts = <IT_CURLIM_LDO6 0>;
+				interrupt-parent = <&pmic>;
+				regulator-enable-ramp-delay = <300000>;
+			};
+
+			vref_ddr: vref_ddr {
+				regulator-name = "vref_ddr";
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			bst_out: boost {
+				regulator-name = "bst_out";
+				interrupts = <IT_OCP_BOOST 0>;
+				interrupt-parent = <&pmic>;
+			};
+
+			vbus_otg: pwr_sw1 {
+				regulator-name = "vbus_otg";
+				interrupts = <IT_OCP_OTG 0>;
+				interrupt-parent = <&pmic>;
+				regulator-active-discharge;
+			};
+
+			vbus_sw: pwr_sw2 {
+				regulator-name = "vbus_sw";
+				interrupts = <IT_OCP_SWOUT 0>;
+				interrupt-parent = <&pmic>;
+				regulator-active-discharge;
+			};
+		};
+
+		onkey {
+			compatible = "st,stpmic1-onkey";
+			interrupts = <IT_PONKEY_F 0>, <IT_PONKEY_R 1>;
+			interrupt-names = "onkey-falling", "onkey-rising";
+			status = "okay";
+		};
+
+		watchdog {
+			compatible = "st,stpmic1-wdt";
+			status = "disabled";
+		};
+	};
+};
+
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&rng1 {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	broken-cd;
+	st,sig-dir;
+	st,neg-edge;
+	st,use-ckin;
+	bus-width = <4>;
+	vmmc-supply = <&vdd_sd>;
+	status = "okay";
+};
+
+&uart4 {
+	/* On Low speed expansion header */
+	label = "LS-UART1";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_b>;
+	status = "okay";
+};
+
+&uart7 {
+	/* On Low speed expansion header */
+	label = "LS-UART0";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart7_pins_a>;
+	status = "okay";
+};
-- 
2.17.1

