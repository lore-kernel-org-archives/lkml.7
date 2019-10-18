Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22533CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0106921925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410429AbfJROHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:07:54 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:39319 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410336AbfJROHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:07:51 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 04AF920000A;
        Fri, 18 Oct 2019 14:07:48 +0000 (UTC)
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
Subject: [PATCH 2/2] ARM: at91: add support for SmartKiz board
Date:   Fri, 18 Oct 2019 16:06:58 +0200
Message-Id: <20191018140658.31703-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018140658.31703-1-kamel.bouhara@bootlin.com>
References: <20191018140658.31703-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree for the Overkiz's SmartKiz board.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Kévin RAYMOND <k.raymond@overkiz.com>
Signed-off-by: Mickael GARDET <m.gardet@overkiz.com>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/at91-smartkiz.dts | 112 ++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-smartkiz.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6b3a65f3f6f8..12a6b8c6b27e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -40,6 +40,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91-kizboxmini.dtb \
 	at91-kizboxmini-mb.dtb \
 	at91-kizboxmini-rd.dtb \
+	at91-smartkiz.dtb \
 	at91-wb45n.dtb \
 	at91sam9g15ek.dtb \
 	at91sam9g25ek.dtb \
diff --git a/arch/arm/boot/dts/at91-smartkiz.dts b/arch/arm/boot/dts/at91-smartkiz.dts
new file mode 100644
index 000000000000..dae7e7b68462
--- /dev/null
+++ b/arch/arm/boot/dts/at91-smartkiz.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2018 Overkiz SAS
+ *   Author: Mickael Gardet <m.gardet@overkiz.com>
+ *           Kévin Raymond <k.raymond@overkiz.com>
+ *           Dorian Rocipon <d.rocipon@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizboxmini_common.dtsi"
+
+/ {
+	model = "Overkiz SmartKiz";
+	compatible = "overkiz,smartkiz", "atmel,at91sam9g25",
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
+
+	aliases {
+		serial5 = &uart0;
+	};
+
+	pio_keys {
+		hk_reset {
+			label = "HK_RESET";
+			gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+		};
+
+		power_rf {
+			label = "POWER_RF";
+			gpios = <&pioA 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		power_wifi {
+			label = "POWER_WIFI";
+			gpios = <&pioA 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&pinctrl {
+	i2c1 {
+		pinctrl_i2c1: i2c1-0 {
+			atmel,pins =
+				<AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_PULL_UP
+				AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	adc0 {
+		pinctrl_adc0_ad0: adc0_ad0-0 {
+			/* pull-up disable */
+			atmel,pins = <AT91_PIOB 11 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+		pinctrl_adc0_ad5: adc0_ad5-0 {
+			/* pull-up disable */
+			atmel,pins = <AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+		pinctrl_adc0_ad6: adc0_ad6-0 {
+			/* pull-up disable */
+			atmel,pins = <AT91_PIOB 17 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+		pinctrl_adc0_ad11: adc0_ad11-0 {
+			/* pull-up disable */
+			atmel,pins = <AT91_PIOB 10 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+};
+
+&i2c1 {
+	dmas = <0>, <0>;
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "disabled";
+};
+
+&macb0 {
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
+	pinctrl-0 = <
+		&pinctrl_adc0_ad0
+		&pinctrl_adc0_ad5
+		&pinctrl_adc0_ad6
+		&pinctrl_adc0_ad11
+	>;
+	atmel,adc-channels-used = <0x0861>;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
-- 
2.23.0

