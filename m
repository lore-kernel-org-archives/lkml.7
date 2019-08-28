Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD981C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7036122CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LGyBGBEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfH1OMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:12:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37007 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1OME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:12:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so2680934wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PUCl5D0Gm4Uq64Pr+MkW/ADRKqtUb4xY3QAm5fyAKQ=;
        b=LGyBGBEtUPklteFxDEaOAaN4tAt8ZRj8yz0GwBhOt6QLm/YmbSdbcyYEHQ5WYzSn4b
         QOFTj4zVbEfnNLzyJDW7q9hPjlj0rfRy+o+QbMnigd62jk2huUv9tdoHKyqM2L8+fxKi
         m+egqdC3Ds0TuzyEAkGsHfOOev7lMaG9hihRMFGcMzTbOzpD6F2P8c+SjVJwivvaklRn
         G/biflOBb9nZpxArd9T2JNPZaOXUa9BrennYVm91Vn+ZtS0jk7SGSTszv0LTmz9+7pud
         Lrj+02bNG2tFGgQ3+hz3JqQn3b0ugAyQKXaCCIPpR6+qnZF+LuGZFAY7Fff8BNoRPxdA
         h0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PUCl5D0Gm4Uq64Pr+MkW/ADRKqtUb4xY3QAm5fyAKQ=;
        b=nW8kISz1iG8VjbMy7pV5HN3MiYt0KIjxSLP4t8wh7iHBqHl0iqkdw3aNDXdf+dnRIV
         u+fzFoI3OsbErjXiblrTRo6+1RmxiUSHQ6EPWkWaKR8cG2ZtWewb6/IspqEpeXTNxfJR
         AjFhYkCF/XRIUw8EkFJHgV3UBcBb3E575rwCgftiU5CuLx6VLNUsK7IQUKh+8gSIgEOt
         DOxecOoLZcgEhT6cnTAq25e4JW/g8JN9jL4/rSPJcJu8L/K1nggUuyscSqDPNTZ6Udq2
         3tOOEFl/sMuJ/f+5WFm/w8FP9+Y7sMYgEC2gJx+6GmxNGnScG+KNU9uYgBg9f34pVZSG
         yb8Q==
X-Gm-Message-State: APjAAAWkYZnX2y9y1jOoT20FWmP+9sHqIP/u3ueNZyITAfi6DhfGN48f
        2kZhsk2RzUcFan7RUd63dsAG8WuOA5VKxQ==
X-Google-Smtp-Source: APXvYqzj0tx1W/tV167F75/hbgHs2gXGUcB7vebiboSdpSq61cHl1WlWeYp5umIAe6ejduMJDUyEBQ==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr4737683wrn.223.1567001521059;
        Wed, 28 Aug 2019 07:12:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a11sm2774838wrx.59.2019.08.28.07.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:11:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi
Date:   Wed, 28 Aug 2019 16:11:55 +0200
Message-Id: <20190828141157.15503-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828141157.15503-1-narmstrong@baylibre.com>
References: <20190828141157.15503-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare support of the Amlogic SM1 based Khadas VIM3, move the non-G12B
specific nodes (all except DVFS and Audio) to a new meson-khadas-vim3.dtsi

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |   1 +
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   | 355 -----------------
 .../amlogic/meson-g12b-s922x-khadas-vim3.dts  |   1 +
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 360 ++++++++++++++++++
 4 files changed, 362 insertions(+), 355 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
index 73128ed24361..3a6a1e0c1e32 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "meson-g12b-a311d.dtsi"
+#include "meson-khadas-vim3.dtsi"
 #include "meson-g12b-khadas-vim3.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 9c3ca2edc725..554863429aa6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -5,116 +5,9 @@
  * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
  */
 
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
-	model = "Khadas VIM3";
-
-	aliases {
-		serial0 = &uart_AO;
-		ethernet0 = &ethmac;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	adc-keys {
-		compatible = "adc-keys";
-		io-channels = <&saradc 2>;
-		io-channel-names = "buttons";
-		keyup-threshold-microvolt = <1710000>;
-
-		button-function {
-			label = "Function";
-			linux,code = <KEY_FN>;
-			press-threshold-microvolt = <10000>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		white {
-			label = "vim3:white:sys";
-			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "heartbeat";
-		};
-
-		red {
-			label = "vim3:red";
-			gpios = <&gpio_expander 5 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	emmc_pwrseq: emmc-pwrseq {
-		compatible = "mmc-pwrseq-emmc";
-		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
-	};
-
-	gpio-keys-polled {
-		compatible = "gpio-keys-polled";
-		poll-interval = <100>;
-
-		power-button {
-			label = "power";
-			linux,code = <KEY_POWER>;
-			gpios = <&gpio_ao GPIOAO_7 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	sdio_pwrseq: sdio-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
-		clocks = <&wifi32k>;
-		clock-names = "ext_clock";
-	};
-
-	dc_in: regulator-dc_in {
-		compatible = "regulator-fixed";
-		regulator-name = "DC_IN";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-	};
-
-	vcc_5v: regulator-vcc_5v {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_in>;
-
-		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
-		enable-active-high;
-	};
-
-	vcc_1v8: regulator-vcc_1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_3v3>;
-		regulator-always-on;
-	};
-
-	vcc_3v3: regulator-vcc_3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vsys_3v3>;
-		regulator-always-on;
-		/* FIXME: actually controlled by VDDCPU_B_EN */
-	};
-
 	vddcpu_a: regulator-vddcpu-a {
 		/*
 		 * MP8756GD Regulator.
@@ -153,62 +46,6 @@
 		regulator-always-on;
 	};
 
-	vddao_1v8: regulator-vddao_1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDDIO_AO1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vsys_3v3>;
-		regulator-always-on;
-	};
-
-	emmc_1v8: regulator-emmc_1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "EMMC_AO1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_3v3>;
-		regulator-always-on;
-	};
-
-	vsys_3v3: regulator-vsys_3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "VSYS_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_in>;
-		regulator-always-on;
-	};
-
-	usb_pwr: regulator-usb_pwr {
-		compatible = "regulator-fixed";
-		regulator-name = "USB_PWR";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc_5v>;
-
-		gpio = <&gpio GPIOA_6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	hdmi-connector {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_connector_in: endpoint {
-				remote-endpoint = <&hdmi_tx_tmds_out>;
-			};
-		};
-	};
-
-	wifi32k: wifi32k {
-		compatible = "pwm-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
-	};
-
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "G12A-KHADAS-VIM3";
@@ -269,20 +106,6 @@
 	status = "okay";
 };
 
-&cec_AO {
-	pinctrl-0 = <&cec_ao_a_h_pins>;
-	pinctrl-names = "default";
-	status = "disabled";
-	hdmi-phandle = <&hdmi_tx>;
-};
-
-&cecb_AO {
-	pinctrl-0 = <&cec_ao_b_h_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-	hdmi-phandle = <&hdmi_tx>;
-};
-
 &clkc_audio {
 	status = "okay";
 };
@@ -329,31 +152,6 @@
 	clock-latency = <50000>;
 };
 
-&ext_mdio {
-	external_phy: ethernet-phy@0 {
-		/* Realtek RTL8211F (0x001cc916) */
-		reg = <0>;
-		max-speed = <1000>;
-
-		interrupt-parent = <&gpio_intc>;
-		/* MAC_INTR on GPIOZ_14 */
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&ethmac {
-        pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
-        pinctrl-names = "default";
-        status = "okay";
-        phy-mode = "rgmii";
-        phy-handle = <&external_phy>;
-        amlogic,tx-delay-ns = <2>;
-};
-
-&frddr_a {
-	status = "okay";
-};
-
 &frddr_b {
 	status = "okay";
 };
@@ -362,46 +160,6 @@
 	status = "okay";
 };
 
-&hdmi_tx {
-	status = "okay";
-	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
-	pinctrl-names = "default";
-	hdmi-supply = <&vcc_5v>;
-};
-
-&hdmi_tx_tmds_port {
-	hdmi_tx_tmds_out: endpoint {
-		remote-endpoint = <&hdmi_connector_in>;
-	};
-};
-
-&i2c_AO {
-	status = "okay";
-	pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
-	pinctrl-names = "default";
-
-	gpio_expander: gpio-controller@20 {
-		compatible = "ti,tca6408";
-		reg = <0x20>;
-		vcc-supply = <&vcc_3v3>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	rtc@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-	};
-};
-
-&ir {
-	status = "okay";
-	pinctrl-0 = <&remote_input_ao_pins>;
-	pinctrl-names = "default";
-	linux,rc-map-name = "rc-khadas";
-};
-
 &pwm_ab {
 	pinctrl-0 = <&pwm_a_e_pins>;
 	pinctrl-names = "default";
@@ -418,81 +176,6 @@
 	status = "okay";
 };
 
-&pwm_ef {
-        status = "okay";
-        pinctrl-0 = <&pwm_e_pins>;
-        pinctrl-names = "default";
-};
-
-&saradc {
-	status = "okay";
-	vref-supply = <&vddao_1v8>;
-};
-
-/* SDIO */
-&sd_emmc_a {
-	status = "okay";
-	pinctrl-0 = <&sdio_pins>;
-	pinctrl-1 = <&sdio_clk_gate_pins>;
-	pinctrl-names = "default", "clk-gate";
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	bus-width = <4>;
-	cap-sd-highspeed;
-	sd-uhs-sdr50;
-	max-frequency = <100000000>;
-
-	non-removable;
-	disable-wp;
-
-	mmc-pwrseq = <&sdio_pwrseq>;
-
-	vmmc-supply = <&vsys_3v3>;
-	vqmmc-supply = <&vddao_1v8>;
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
-/* SD card */
-&sd_emmc_b {
-	status = "okay";
-	pinctrl-0 = <&sdcard_c_pins>;
-	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
-	pinctrl-names = "default", "clk-gate";
-
-	bus-width = <4>;
-	cap-sd-highspeed;
-	max-frequency = <50000000>;
-	disable-wp;
-
-	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&vsys_3v3>;
-	vqmmc-supply = <&vsys_3v3>;
-};
-
-/* eMMC */
-&sd_emmc_c {
-	status = "okay";
-	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
-	pinctrl-1 = <&emmc_clk_gate_pins>;
-	pinctrl-names = "default", "clk-gate";
-
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	max-frequency = <200000000>;
-	disable-wp;
-
-	mmc-pwrseq = <&emmc_pwrseq>;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&emmc_1v8>;
-};
-
 &tdmif_b {
 	status = "okay";
 };
@@ -504,41 +187,3 @@
 &tohdmitx {
 	status = "okay";
 };
-
-&uart_A {
-	status = "okay";
-	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-	pinctrl-names = "default";
-	uart-has-rtscts;
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
-		max-speed = <2000000>;
-		clocks = <&wifi32k>;
-		clock-names = "lpo";
-	};
-};
-
-&uart_AO {
-	status = "okay";
-	pinctrl-0 = <&uart_ao_a_pins>;
-	pinctrl-names = "default";
-};
-
-&usb2_phy0 {
-	phy-supply = <&dc_in>;
-};
-
-&usb2_phy1 {
-	phy-supply = <&usb_pwr>;
-};
-
-&usb3_pcie_phy {
-	phy-supply = <&usb_pwr>;
-};
-
-&usb {
-	status = "okay";
-	dr_mode = "peripheral";
-};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
index 6bcf972b8bfa..b73deb282120 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "meson-g12b-s922x.dtsi"
+#include "meson-khadas-vim3.dtsi"
 #include "meson-g12b-khadas-vim3.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
new file mode 100644
index 000000000000..8647da7d6609
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+
+/ {
+	model = "Khadas VIM3";
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 2>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "Function";
+			linux,code = <KEY_FN>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		white {
+			label = "vim3:white:sys";
+			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		red {
+			label = "vim3:red";
+			gpios = <&gpio_expander 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		power-button {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
+	dc_in: regulator-dc_in {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_IN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_in>;
+
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_3v3>;
+		regulator-always-on;
+		/* FIXME: actually controlled by VDDCPU_B_EN */
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vsys_3v3>;
+		regulator-always-on;
+	};
+
+	emmc_1v8: regulator-emmc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "EMMC_AO1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vsys_3v3: regulator-vsys_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSYS_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
+	usb_pwr: regulator-usb_pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+
+		gpio = <&gpio GPIOA_6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
+};
+
+&cec_AO {
+	pinctrl-0 = <&cec_ao_a_h_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cecb_AO {
+	pinctrl-0 = <&cec_ao_b_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ethmac {
+        pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+        pinctrl-names = "default";
+        status = "okay";
+        phy-mode = "rgmii";
+        phy-handle = <&external_phy>;
+        amlogic,tx-delay-ns = <2>;
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&vcc_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&i2c_AO {
+	status = "okay";
+	pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
+	pinctrl-names = "default";
+
+	gpio_expander: gpio-controller@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		vcc-supply = <&vcc_3v3>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+	};
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+	linux,rc-map-name = "rc-khadas";
+};
+
+&pwm_ef {
+        status = "okay";
+        pinctrl-0 = <&pwm_e_pins>;
+        pinctrl-names = "default";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddao_1v8>;
+};
+
+/* SDIO */
+&sd_emmc_a {
+	status = "okay";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	max-frequency = <100000000>;
+
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vsys_3v3>;
+	vqmmc-supply = <&vddao_1v8>;
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <50000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vsys_3v3>;
+	vqmmc-supply = <&vsys_3v3>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_1v8>;
+};
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb2_phy0 {
+	phy-supply = <&dc_in>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&usb_pwr>;
+};
+
+&usb3_pcie_phy {
+	phy-supply = <&usb_pwr>;
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "peripheral";
+};
-- 
2.22.0

