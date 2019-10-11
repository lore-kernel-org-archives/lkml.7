Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF7ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49048206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfJKMuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:50:51 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:45759 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfJKMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:50:50 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2AEB910000B;
        Fri, 11 Oct 2019 12:50:46 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        =?UTF-8?q?K=C3=A9vin=20RAYMOND?= <k.raymond@overkiz.com>,
        Mickael GARDET <m.gardet@overkiz.com>
Subject: [PATCH 3/3] ARM: at91: add Overkiz KIZBOX3 board
Date:   Fri, 11 Oct 2019 14:50:22 +0200
Message-Id: <20191011125022.16329-4-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011125022.16329-1-kamel.bouhara@bootlin.com>
References: <20191011125022.16329-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common DT include file for the Kizbox3 boards.
Add the devicetree for the Kizbox3 HS board.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Kévin RAYMOND <k.raymond@overkiz.com>
Signed-off-by: Mickael GARDET <m.gardet@overkiz.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/at91-kizbox3-hs.dts      | 309 ++++++++++++++++
 arch/arm/boot/dts/at91-kizbox3_common.dtsi | 412 +++++++++++++++++++++
 3 files changed, 722 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-kizbox3-hs.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox3_common.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b21b3a64641a..3bda216c41be 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -46,6 +46,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91sam9x35ek.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2.dtb \
+	at91-kizbox3-hs.dtb \
 	at91-nattis-2-natte-2.dtb \
 	at91-sama5d27_som1_ek.dtb \
 	at91-sama5d2_ptc_ek.dtb \
diff --git a/arch/arm/boot/dts/at91-kizbox3-hs.dts b/arch/arm/boot/dts/at91-kizbox3-hs.dts
new file mode 100644
index 000000000000..8734e7f8939e
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox3-hs.dts
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizbox3-hs.dts - Device Tree file for Overkiz KIZBOX3-HS board
+ *
+ * Copyright (C) 2018 Overkiz SAS
+ *
+ * Authors: Dorian Rocipon <d.rocipon@overkiz.com>
+ *          Kevin Carli <k.carli@overkiz.com>
+ *          Mickael Gardet <m.gardet@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizbox3_common.dtsi"
+
+/ {
+	model = "Overkiz KIZBOX3-HS";
+	compatible = "overkiz,kizbox3-hs", "atmel,sama5d2", "atmel,sama5";
+
+	pwm_leds {
+		status = "okay";
+
+		red {
+			status = "okay";
+		};
+
+		green {
+			status = "okay";
+		};
+
+		blue {
+			status = "okay";
+		};
+
+		white {
+			status = "okay";
+		};
+	};
+
+	leds  {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led_red
+			     &pinctrl_led_white>;
+		status = "okay";
+
+		red {
+			label = "pio:red:user";
+			gpios = <&pioA PIN_PB1 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		white {
+			label = "pio:white:user";
+			gpios = <&pioA PIN_PB8 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default" , "default", "default",
+				"default", "default" ;
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+		pinctrl-1 = <&pinctrl_pio_rf &pinctrl_pio_wifi>;
+		pinctrl-2 = <&pinctrl_pio_io_boot
+			     &pinctrl_pio_io_reset
+			     &pinctrl_pio_io_test_radio>;
+		pinctrl-3 = <&pinctrl_pio_zbe_test_radio
+			     &pinctrl_pio_zbe_rst>;
+		pinctrl-4 = <&pinctrl_pio_input>;
+
+		SW1 {
+			label = "SW1";
+			gpios = <&pioA PIN_PA29 GPIO_ACTIVE_LOW>;
+			linux,code = <0x101>;
+			wakeup-source;
+		};
+
+		SW2 {
+			label = "SW2";
+			gpios = <&pioA PIN_PA18 GPIO_ACTIVE_LOW>;
+			linux,code = <0x102>;
+			wakeup-source;
+		};
+
+		SW3 {
+			label = "SW3";
+			gpios = <&pioA PIN_PA22 GPIO_ACTIVE_LOW>;
+			linux,code = <0x103>;
+			wakeup-source;
+		};
+
+		SW7 {
+			label = "SW7";
+			gpios = <&pioA PIN_PA26 GPIO_ACTIVE_LOW>;
+			linux,code = <0x107>;
+			wakeup-source;
+		};
+
+		SW8 {
+			label = "SW8";
+			gpios = <&pioA PIN_PA24 GPIO_ACTIVE_LOW>;
+			linux,code = <0x108>;
+			wakeup-source;
+		};
+	};
+
+	gpios {
+		compatible = "gpio";
+		status = "okay";
+
+		rf_on {
+			label = "rf on";
+			gpio = <&pioA PIN_PC19 GPIO_ACTIVE_HIGH>;
+			output;
+			init-low;
+		};
+
+		wifi_on {
+			label = "wifi on";
+			gpio = <&pioA PIN_PC20 GPIO_ACTIVE_HIGH>;
+			output;
+			init-low;
+		};
+
+		zbe_test_radio {
+			label = "zbe test radio";
+			gpio = <&pioA PIN_PB21 GPIO_ACTIVE_HIGH>;
+			output;
+			init-low;
+		};
+
+		zbe_rst {
+			label = "zbe rst";
+			gpio = <&pioA PIN_PB25 GPIO_ACTIVE_HIGH>;
+			output;
+			init-low;
+		};
+
+		io_reset {
+			label = "io reset";
+			gpio = <&pioA PIN_PB30 GPIO_ACTIVE_HIGH>;
+			output;
+			init-low;
+		};
+
+		io_test_radio {
+			label = "io test radio";
+			gpio = <&pioA PIN_PC9 GPIO_ACTIVE_HIGH>;
+			output;
+			init-low;
+		};
+
+		io_boot_0 {
+			label = "io boot 0";
+			gpio = <&pioA PIN_PC11 GPIO_ACTIVE_HIGH>;
+			output;
+			init-low;
+		};
+
+		io_boot_1 {
+			label = "io boot 1";
+			gpio = <&pioA PIN_PC17 GPIO_ACTIVE_HIGH>;
+			output;
+			init-low;
+		};
+
+		verbose_bootloader {
+			label = "verbose bootloader";
+			gpio = <&pioA PIN_PB11 GPIO_ACTIVE_HIGH>;
+			input;
+		};
+
+		 nail_bed_detection  {
+			label = "nail bed detection";
+			gpio = <&pioA PIN_PB12 GPIO_ACTIVE_HIGH>;
+			input;
+		};
+
+		 id_usba {
+			label = "id usba";
+			gpio = <&pioA PIN_PC0 GPIO_ACTIVE_LOW>;
+			input;
+		};
+	};
+};
+
+&pioA {
+	pinctrl_key_gpio_default: key_gpio_default {
+		pinmux=  <PIN_PA22__GPIO>,
+		<PIN_PA24__GPIO>,
+		<PIN_PA26__GPIO>,
+		<PIN_PA29__GPIO>,
+		<PIN_PA18__GPIO>;
+		bias-disable;
+		};
+
+	pinctrl_gpio {
+		pinctrl_pio_rf: gpio_rf {
+			pinmux = <PIN_PC19__GPIO>;
+			bias-disable;
+		};
+		pinctrl_pio_wifi: gpio_wifi {
+			pinmux = <PIN_PC20__GPIO>;
+			bias-disable;
+		};
+		pinctrl_pio_io_boot: gpio_io_boot {
+			pinmux =
+			<PIN_PC11__GPIO>,
+			<PIN_PC17__GPIO>;
+			bias-disable;
+		};
+		pinctrl_pio_io_test_radio: gpio_io_test_radio {
+			pinmux = <PIN_PC9__GPIO>;
+			bias-disable;
+		};
+		pinctrl_pio_zbe_test_radio: gpio_zbe_test_radio {
+			pinmux = <PIN_PB21__GPIO>;
+			bias-disable;
+		};
+		pinctrl_pio_zbe_rst: gpio_zbe_rst {
+			pinmux = <PIN_PB25__GPIO>;
+			bias-disable;
+		};
+		/* stm32 reset must be open drain (internal pull up) */
+		pinctrl_pio_io_reset: gpio_io_reset {
+			pinmux = <PIN_PB30__GPIO>;
+			bias-disable;
+			drive-open-drain = <1>;
+			output-low;
+		};
+		pinctrl_pio_input: gpio_input {
+			pinmux =
+			<PIN_PB11__GPIO>,
+			<PIN_PB12__GPIO>,
+			<PIN_PC0__GPIO>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_leds {
+		pinctrl_led_red: led_red {
+			pinmux = <PIN_PB1__GPIO>;
+			bias-disable;
+		};
+		pinctrl_led_white: led_white {
+			pinmux = <PIN_PB8__GPIO>;
+			bias-disable;
+		};
+	};
+};
+
+&adc {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&flx0 {
+	status = "okay";
+
+	uart5: serial@200  {
+			status = "okay";
+	};
+};
+
+&flx3 {
+	status = "okay";
+	uart6: serial@200 {
+		status = "okay";
+	};
+};
+
+&flx4 {
+	status = "okay";
+
+	i2c2: i2c@600 {
+		status = "okay";
+	};
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
new file mode 100644
index 000000000000..299e74d23184
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizbox3.dts - Device Tree Include file for Overkiz Kizbox 3
+ * family SoC boards
+ *
+ * Copyright (C) 2018 Overkiz SAS
+ *
+ * Authors: Dorian Rocipon <d.rocipon@overkiz.com>
+ *          Kevin Carli <k.carli@overkiz.com>
+ *          Mickael Gardet <m.gardet@overkiz.com>
+ */
+/dts-v1/;
+#include "sama5d2.dtsi"
+#include "sama5d2-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "Overkiz Kizbox3";
+	compatible = "overkiz,kizbox3", "atmel,sama5d2", "atmel,sama5";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+	};
+
+	chosen {
+		bootargs = "ubi.mtd=ubi";
+		stdout-path = "serial1:115200n8";
+	};
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
+	vdd_adc_vddana: supply_3v3_ana {
+		compatible = "regulator-fixed";
+		regulator-name = "adc-vddana";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vdd_adc_vref: supply_3v3_ref {
+		compatible = "regulator-fixed";
+		regulator-name = "adc-vref";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	pwm_leds {
+		compatible = "pwm-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pwm0_pwm_h0
+			     &pinctrl_pwm0_pwm_h1
+			     &pinctrl_pwm0_pwm_h2
+			     &pinctrl_pwm0_pwm_h3>;
+		status = "disabled";
+
+		red {
+			label = "pwm:red:user";
+			pwms = <&pwm0 0 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+			status = "disabled";
+		};
+
+		green {
+			label = "pwm:green:user";
+			pwms = <&pwm0 1 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+			status = "disabled";
+		};
+
+		blue {
+			label = "pwm:blue:user";
+			pwms = <&pwm0 2 10000000 0>;
+			max-brightness = <255>;
+			status = "disabled";
+		};
+
+		white {
+			label = "pwm:white:user";
+			pwms = <&pwm0 3 10000000 0>;
+			max-brightness = <255>;
+			status = "disabled";
+		};
+	};
+};
+
+&ebi {
+	status = "okay";
+};
+
+&nand_controller {
+	status = "okay";
+
+	nand@3 {
+		pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+		pinctrl-names = "default";
+		reg = <0x3 0x0 0x800000>;
+
+		atmel,rb = <0>;
+		nand-bus-width = <8>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+		nand-on-flash-bbt;
+		label = "atmel_nand";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			bootstrap@0 {
+				label = "bootstrap";
+				reg = <0x0 0x20000>;
+			};
+
+			u-boot@20000 {
+				label = "u-boot";
+				reg = <0x20000 0x140000>;
+			};
+
+			u-boot-factory@160000 {
+				label = "u-boot-factory";
+				reg = <0x160000 0x140000>;
+			};
+
+			ubi@2A0000 {
+				label = "ubi";
+				reg = <0x2A0000 0x7D60000>;
+			};
+		};
+
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&pioA {
+	pinctrl_ebi_nand_addr: ebi-addr-1 {
+		pinmux = <PIN_PA0__D0>,
+			<PIN_PA1__D1>,
+			<PIN_PA2__D2>,
+			<PIN_PA3__D3>,
+			<PIN_PA4__D4>,
+			<PIN_PA5__D5>,
+			<PIN_PA6__D6>,
+			<PIN_PA7__D7>,
+			<PIN_PA8__NWE_NANDWE>,
+			<PIN_PA9__NCS3>,
+			<PIN_PA10__A21_NANDALE>,
+			<PIN_PA11__A22_NANDCLE>,
+			<PIN_PA21__NANDRDY>;
+		bias-disable;
+	};
+
+	pinctrl_usart {
+		pinctrl_usart_0: usart0-0 {
+			pinmux = < PIN_PB26__URXD0>, <PIN_PB27__UTXD0>;
+			bias-disable;
+		};
+		pinctrl_usart_1: usart1-0 {
+			pinmux = < PIN_PD2__URXD1>, <PIN_PD3__UTXD1>;
+			bias-disable;
+		};
+		pinctrl_usart_2: usart2-0 {
+			pinmux = < PIN_PD4__URXD2>, <PIN_PD5__UTXD2>;
+			bias-disable;
+		};
+		pinctrl_usart_3: usart3-0 {
+			pinmux = < PIN_PC12__URXD3>, <PIN_PC13__UTXD3>;
+			bias-disable;
+		};
+		pinctrl_usart_4: usart4-0 {
+			pinmux = < PIN_PB3__URXD4>, <PIN_PB4__UTXD4>;
+			bias-disable;
+		};
+		pinctrl_flx0_default: flx0_usart_default {
+			pinmux = <PIN_PB28__FLEXCOM0_IO0>, //TX
+			<PIN_PB29__FLEXCOM0_IO1>; //RX
+			bias-disable;
+		};
+		pinctrl_flx3_default: flx3_usart_default {
+			pinmux = <PIN_PB22__FLEXCOM3_IO1>, //RX
+			<PIN_PB23__FLEXCOM3_IO0>; //TX
+			bias-disable;
+		};
+	};
+
+	pinctrl_flx4_default: flx4_i2c2_default {
+		pinmux = <PIN_PD12__FLEXCOM4_IO0>, //DATA
+		<PIN_PD13__FLEXCOM4_IO1>; //CLK
+		bias-disable;
+		drive-open-drain = <1>;
+	};
+
+	pinctrl_pwm0 {
+		pinctrl_pwm0_pwm_h0: pwm0_pwm_h0 {
+			pinmux = <PIN_PA30__PWMH0>;
+			bias-disable;
+		};
+		pinctrl_pwm0_pwm_h1: pwm0_pwmh1 {
+			pinmux = <PIN_PB0__PWMH1>;
+			bias-disable;
+		};
+		pinctrl_pwm0_pwm_h2: pwm0_pwm_h2 {
+			pinmux = <PIN_PB5__PWMH2>;
+			bias-disable;
+		};
+		pinctrl_pwm0_pwm_h3: pwm0_pwm_h3 {
+			pinmux = <PIN_PB7__PWMH3>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_adc {
+		pinctrl_adc2: adc2 {
+			pinmux = <PIN_PD21__GPIO>;
+			bias-disable;
+		};
+		pinctrl_adc3: adc3 {
+			pinmux = <PIN_PD22__GPIO>;
+			bias-disable;
+		};
+		pinctrl_adc4: adc4 {
+			pinmux = <PIN_PD23__GPIO>;
+			bias-disable;
+		};
+		pinctrl_adc5: adc5 {
+			pinmux = <PIN_PD24__GPIO>;
+			bias-disable;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart_0>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "disabled";
+};
+
+/* debug uart */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart_1>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart_2>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart_3>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "disabled";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart_4>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "disabled";
+};
+
+&flx0 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "disabled";
+
+	uart5: serial@200  {
+		compatible = "atmel,at91sam9260-usart";
+		reg = <0x200 0x400>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(11))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(12))>;
+		dma-names = "tx", "rx";
+		clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
+		clock-names = "usart";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx0_default>;
+		atmel,fifo-size = <32>;
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		status = "disabled";
+	};
+};
+
+&flx3 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "disabled";
+
+	uart6: serial@200 {
+		compatible = "atmel,at91sam9260-usart";
+		reg = <0x200 0x400>;
+		interrupts = <22 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(17))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(18))>;
+		dma-names = "tx", "rx";
+		clocks = <&pmc PMC_TYPE_PERIPHERAL 22>;
+		clock-names = "usart";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx3_default>;
+		atmel,fifo-size = <32>;
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		status = "disabled";
+	};
+};
+
+&flx4 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "disabled";
+
+	i2c2: i2c@600 {
+		compatible = "atmel,sama5d2-i2c";
+		reg = <0x600 0x200>;
+		interrupts = <23 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(19))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(20))>;
+		dma-names = "tx", "rx";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx4_default>;
+		atmel,fifo-size = <16>;
+		status = "disabled";
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&shutdown_controller {
+	atmel,shdwc-debouncer = <976>;
+	atmel,wakeup-rtc-timer;
+
+	input@0 {
+		reg = <0>;
+		atmel,wakeup-type = "low";
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&adc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc2
+		     &pinctrl_adc3
+		     &pinctrl_adc4
+		     &pinctrl_adc5>;
+
+	vddana-supply = <&vdd_adc_vddana>;
+	vref-supply = <&vdd_adc_vref>;
+	status = "disabled";
+};
+
+&securam {
+	export;
+
+	/* export overkiz u-boot mode/version and factory */
+	uboot@1400 {
+		reg = <0x1400 0x20>;
+		export;
+	};
+};
-- 
2.23.0

