Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93001CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B782222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505080AbfJRODU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:03:20 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46737 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439624AbfJRODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:03:18 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4403420008;
        Fri, 18 Oct 2019 14:03:15 +0000 (UTC)
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
Subject: [PATCH 2/2] ARM: dts: at91: add a common kizboxmini dtsi file
Date:   Fri, 18 Oct 2019 16:03:04 +0200
Message-Id: <20191018140304.31547-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018140304.31547-1-kamel.bouhara@bootlin.com>
References: <20191018140304.31547-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the Kizbox Mini boards into two board configuration, the
Kizboxmini Mother board and the Kizboxmini RailDIN board.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Kévin RAYMOND <k.raymond@overkiz.com>
Signed-off-by: Mickael GARDET <m.gardet@overkiz.com>
---
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/at91-kizboxmini-mb.dts      |  38 ++++
 arch/arm/boot/dts/at91-kizboxmini-rd.dts      |  54 ++++++
 arch/arm/boot/dts/at91-kizboxmini_common.dtsi | 166 ++++++++++++++++++
 4 files changed, 260 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-mb.dts
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-rd.dts
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini_common.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c976b72a4c94..6b3a65f3f6f8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -38,6 +38,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91-ariettag25.dtb \
 	at91-cosino_mega2560.dtb \
 	at91-kizboxmini.dtb \
+	at91-kizboxmini-mb.dtb \
+	at91-kizboxmini-rd.dtb \
 	at91-wb45n.dtb \
 	at91sam9g15ek.dtb \
 	at91sam9g25ek.dtb \
diff --git a/arch/arm/boot/dts/at91-kizboxmini-mb.dts b/arch/arm/boot/dts/at91-kizboxmini-mb.dts
new file mode 100644
index 000000000000..52921f547dd6
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizboxmini-mb.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2018 Overkiz SAS
+ *   Author: Mickael Gardet <m.gardet@overkiz.com>
+ *           Kévin Raymond <k.raymond@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizboxmini_common.dtsi"
+
+/ {
+	model = "Overkiz Kizbox Mini Mother Board";
+	compatible = "overkiz,kizboxmini-mb", "atmel,at91sam9g25",
+		     "atmel,at91sam9x5", "atmel,at91sam9";
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+	};
+
+	pwm_leds {
+		blue {
+			label = "pwm:blue:user";
+			pwms = <&pwm0 2 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "none";
+		};
+	};
+};
+
+&usb0 {
+	num-ports = <2>;
+};
+
+&rtc {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/at91-kizboxmini-rd.dts b/arch/arm/boot/dts/at91-kizboxmini-rd.dts
new file mode 100644
index 000000000000..1d2db8e16271
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizboxmini-rd.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2018 Overkiz SAS
+ *   Author: Mickael Gardet <m.gardet@overkiz.com>
+ *           Kévin Raymond <k.raymond@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizboxmini_common.dtsi"
+
+/ {
+	model = "Overkiz Kizbox Mini RailDIN";
+	compatible = "overkiz,kizboxmini-rd", "atmel,at91sam9g25",
+		     "atmel,at91sam9x5", "atmel,at91sam9";
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+		adc_op_clk {
+			status = "okay";
+		};
+	};
+};
+
+&pinctrl {
+	adc0 {
+		pinctrl_adc0_ad5: adc0_ad5-0 {
+			/* pull-up disable */
+			atmel,pins = <AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+};
+
+&usart0 {
+	status = "disabled";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&leds {
+	blue {
+		status = "okay";
+	};
+};
+
+&adc0 {
+	atmel,adc-vref = <2500>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_ad5>;
+	atmel,adc-channels-used = <0x0020>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/at91-kizboxmini_common.dtsi b/arch/arm/boot/dts/at91-kizboxmini_common.dtsi
new file mode 100644
index 000000000000..2598b776a278
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizboxmini_common.dtsi
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizboxmini.dts - Device Tree file for Overkiz Kizbox mini board
+ *
+ * Copyright (C) 2014-2018 Overkiz SAS
+ *   Author: Antoine Aubert <a.aubert@overkiz.com>
+ *           Gaël Portay <g.portay@overkiz.com>
+ *           Kévin Raymond <k.raymond@overkiz.com>
+ *           Dorian Rocipon <d.rocipon@overkiz.com>
+ */
+#include "at91sam9g25.dtsi"
+
+/ {
+	chosen {
+		bootargs = "ubi.mtd=ubi";
+		stdout-path = &dbgu;
+	};
+
+	memory {
+		reg = <0x20000000 0x8000000>;
+	};
+
+	clocks {
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+
+		adc_op_clk {
+			status = "disabled";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		prog {
+			label = "PB_PROG";
+			gpios = <&pioC 17 GPIO_ACTIVE_LOW>;
+			linux,code = <0x102>;
+			wakeup-source;
+		};
+
+		reset {
+			label = "PB_RST";
+			gpios = <&pioC 16 GPIO_ACTIVE_LOW>;
+			linux,code = <0x100>;
+			wakeup-source;
+		};
+	};
+
+	leds: pwm_leds {
+		compatible = "pwm-leds";
+
+		blue {
+			label = "pwm:blue:user";
+			pwms = <&pwm0 2 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "none";
+			status = "disabled";
+		};
+
+		green {
+			label = "pwm:green:user";
+			pwms = <&pwm0 0 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+
+		red {
+			label = "pwm:red:user";
+			pwms = <&pwm0 1 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&usart0 {
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "okay";
+};
+
+&macb0 {
+	phy-mode = "rmii";
+	status = "okay";
+};
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_pwm0_1
+		     &pinctrl_pwm0_pwm1_1
+		     &pinctrl_pwm0_pwm2_1>;
+	status = "okay";
+};
+
+&dbgu {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&adc0 {
+	status = "disabled";
+};
+
+&rtc {
+	status = "disabled";
+};
+
+&ebi {
+	pinctrl-0 = <&pinctrl_ebi_addr_nand
+			&pinctrl_ebi_data_0_7>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&nand_controller {
+	status = "okay";
+	pinctrl-0 = <&pinctrl_nand_oe_we
+		     &pinctrl_nand_cs
+		     &pinctrl_nand_rb>;
+	pinctrl-names = "default";
+
+	nand@3 {
+		reg = <0x3 0x0 0x800000>;
+		rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
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
+			ubi@20000 {
+				label = "ubi";
+				reg = <0x20000 0x7fe0000>;
+			};
+		};
+	};
+};
+
+&usb0 {
+	num-ports = <1>;
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
-- 
2.23.0

