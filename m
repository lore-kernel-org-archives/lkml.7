Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48365ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3132064B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502248AbfJQMYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:24:37 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58851 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfJQMYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:24:36 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C7E4A100017;
        Thu, 17 Oct 2019 12:24:31 +0000 (UTC)
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
Subject: [PATCH 2/2] ARM: dts: at91: add a common kizbox2 dtsi file
Date:   Thu, 17 Oct 2019 14:24:18 +0200
Message-Id: <20191017122418.18855-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017094028.14259-1-kamel.bouhara@bootlin.com>
References: <20191017094028.14259-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three different boards available depending on the PCB
(3 antennas support and several revison). Add a dtsi file to share
common binding between all kizbox2 boards.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Kévin RAYMOND <k.raymond@overkiz.com>
Signed-off-by: Mickael GARDET <m.gardet@overkiz.com>
---
 arch/arm/boot/dts/Makefile                 |   6 +-
 arch/arm/boot/dts/at91-kizbox.dts          | 173 +++++++-------
 arch/arm/boot/dts/at91-kizbox2-0.dts       |  17 ++
 arch/arm/boot/dts/at91-kizbox2-1.dts       |  22 ++
 arch/arm/boot/dts/at91-kizbox2-2.dts       |  26 +++
 arch/arm/boot/dts/at91-kizbox2-3.dts       |  30 +++
 arch/arm/boot/dts/at91-kizbox2-rev2.dts    |  34 +++
 arch/arm/boot/dts/at91-kizbox2.dts         | 244 -------------------
 arch/arm/boot/dts/at91-kizbox2_common.dtsi | 258 +++++++++++++++++++++
 9 files changed, 477 insertions(+), 333 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-0.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-1.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-3.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-rev2.dts
 delete mode 100644 arch/arm/boot/dts/at91-kizbox2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2_common.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3bda216c41be..c976b72a4c94 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -45,7 +45,11 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91sam9x25ek.dtb \
 	at91sam9x35ek.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
-	at91-kizbox2.dtb \
+	at91-kizbox2-0.dtb \
+	at91-kizbox2-1.dtb \
+	at91-kizbox2-2.dtb \
+	at91-kizbox2-rev2.dtb \
+	at91-kizbox2-3.dtb \
 	at91-kizbox3-hs.dtb \
 	at91-nattis-2-natte-2.dtb \
 	at91-sama5d27_som1_ek.dtb \
diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 90996eaf73b2..9eb1ea750159 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -28,85 +28,6 @@
 		};
 	};
 
-	ahb {
-		apb {
-			tcb0: timer@fffa0000 {
-				timer@0 {
-					compatible = "atmel,tcb-timer";
-					reg = <0>, <1>;
-				};
-
-				timer@2 {
-					compatible = "atmel,tcb-timer";
-					reg = <2>;
-				};
-			};
-
-			macb0: ethernet@fffc4000 {
-				phy-mode = "mii";
-				pinctrl-0 = <&pinctrl_macb_rmii
-				             &pinctrl_macb_rmii_mii_alt>;
-				status = "okay";
-			};
-
-			usart3: serial@fffd0000 {
-				status = "okay";
-			};
-
-			dbgu: serial@fffff200 {
-				status = "okay";
-			};
-
-			watchdog@fffffd40 {
-				timeout-sec = <15>;
-				atmel,max-heartbeat-sec = <16>;
-				atmel,min-heartbeat-sec = <0>;
-				status = "okay";
-			};
-		};
-
-		usb0: ohci@500000 {
-			num-ports = <1>;
-			status = "okay";
-		};
-
-		ebi: ebi@10000000 {
-			status = "okay";
-
-			nand_controller: nand-controller {
-				status = "okay";
-				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
-				pinctrl-names = "default";
-
-				nand@3 {
-					reg = <0x3 0x0 0x800000>;
-					rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
-					nand-bus-width = <8>;
-					nand-ecc-mode = "soft";
-					nand-on-flash-bbt;
-					label = "atmel_nand";
-
-					partitions {
-						compatible = "fixed-partitions";
-						#address-cells = <1>;
-						#size-cells = <1>;
-
-						bootstrap@0 {
-							label = "bootstrap";
-							reg = <0x0 0x20000>;
-						};
-
-						ubi@20000 {
-							label = "ubi";
-							reg = <0x20000 0x7fe0000>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -127,15 +48,6 @@
 		};
 	};
 
-	i2c-gpio-0 {
-		status = "okay";
-
-		rtc: pcf8563@51 {
-			compatible = "nxp,pcf8563";
-			reg = <0x51>;
-		};
-	};
-
 	pwm_leds {
 		compatible = "pwm-leds";
 
@@ -179,3 +91,88 @@
 			     &pinctrl_tcb1_tiob0>;
 	};
 };
+
+&tcb0 {
+	timer@0 {
+		compatible = "atmel,tcb-timer";
+		reg = <0>, <1>;
+	};
+
+	timer@2 {
+		compatible = "atmel,tcb-timer";
+		reg = <2>;
+	};
+};
+
+&ebi {
+	status = "okay";
+};
+
+&nand_controller {
+	status = "okay";
+	pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+	pinctrl-names = "default";
+
+	nand@3 {
+		reg = <0x3 0x0 0x800000>;
+		rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+		nand-bus-width = <8>;
+		nand-ecc-mode = "soft";
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
+&macb0 {
+	phy-mode = "mii";
+	pinctrl-0 = <&pinctrl_macb_rmii
+		     &pinctrl_macb_rmii_mii_alt>;
+	status = "okay";
+};
+
+&usart3 {
+	status = "okay";
+};
+
+&dbgu {
+	status = "okay";
+};
+
+&watchdog {
+	timeout-sec = <15>;
+	atmel,max-heartbeat-sec = <16>;
+	atmel,min-heartbeat-sec = <0>;
+	status = "okay";
+};
+
+&usb0 {
+	num-ports = <1>;
+	status = "okay";
+};
+
+&i2c-gpio-0 {
+	status = "okay";
+
+	rtc: pcf8563@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/at91-kizbox2-0.dts b/arch/arm/boot/dts/at91-kizbox2-0.dts
new file mode 100644
index 000000000000..fd3f81fc0526
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox2-0.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizbox2-0.dts - Device Tree file for the Kizbox 2 board
+ *
+ * Copyright (C) 2015 Overkiz SAS
+ *
+ * Authors: Antoine Aubert <a.aubert@overkiz.com>
+ *          Kévin Raymond <k.raymond@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizbox2_common.dtsi"
+
+/ {
+	model = "Overkiz Kizbox 2 Mother Board";
+	compatible = "overkiz,kizbox2-0", "atmel,sama5d31",
+		     "atmel,sama5d3", "atmel,sama5";
+};
diff --git a/arch/arm/boot/dts/at91-kizbox2-1.dts b/arch/arm/boot/dts/at91-kizbox2-1.dts
new file mode 100644
index 000000000000..00b26b5be466
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox2-1.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizbox2-1.dts - Device Tree file for the Kizbox 2 with one
+ * head board
+ *
+ * Copyright (C) 2015 Overkiz SAS
+ *
+ * Authors: Antoine Aubert <a.aubert@overkiz.com>
+ *          Kévin Raymond <k.raymond@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizbox2_common.dtsi"
+
+/ {
+	model = "Overkiz Kizbox 2 with one head";
+	compatible = "overkiz,kizbox2-1", "atmel,sama5d31",
+		     "atmel,sama5d3", "atmel,sama5";
+};
+
+&usart1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/at91-kizbox2-2.dts b/arch/arm/boot/dts/at91-kizbox2-2.dts
new file mode 100644
index 000000000000..7251c14878cd
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox2-2.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizbox2-2.dts - Device Tree file for the Kizbox2 with
+ * two head board
+ *
+ * Copyright (C) 2015 Overkiz SAS
+ *
+ * Authors: Antoine Aubert <a.aubert@overkiz.com>
+ *	    Kévin Raymond <k.raymond@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizbox2_common.dtsi"
+
+/ {
+	model = "Overkiz Kizbox 2 with two heads";
+	compatible = "overkiz,kizbox2-2", "atmel,sama5d31",
+		     "atmel,sama5d3", "atmel,sama5";
+};
+
+&usart1 {
+	status = "okay";
+};
+
+&usart2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/at91-kizbox2-3.dts b/arch/arm/boot/dts/at91-kizbox2-3.dts
new file mode 100644
index 000000000000..004854eae512
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox2-3.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizbox2-3.dts - Device Tree file for the Kizbox2 with three
+ * heads board
+ *
+ * Copyright (C) 2015 Overkiz SAS
+ *
+ * Authors: Antoine Aubert <a.aubert@overkiz.com>
+ *          Kévin Raymond <k.raymond@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizbox2_common.dtsi"
+
+/ {
+	model = "Overkiz Kizbox 2 with three heads";
+	compatible = "overkiz,kizbox2-3", "atmel,sama5d31",
+		     "atmel,sama5d3", "atmel,sama5";
+};
+
+&usart0 {
+	status = "okay";
+};
+
+&usart1 {
+	status = "okay";
+};
+
+&usart2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/at91-kizbox2-rev2.dts b/arch/arm/boot/dts/at91-kizbox2-rev2.dts
new file mode 100644
index 000000000000..00d7185e186a
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox2-rev2.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizbox2-rev2.dts - Device Tree file for the Kizbox2 rev2 with
+ * two heads board
+ *
+ * Copyright (C) 2017 Overkiz SAS
+ *
+ * Author: Kévin Raymond <k.raymond@overkiz.com>
+ */
+/dts-v1/;
+#include "at91-kizbox2_common.dtsi"
+
+/ {
+	model = "Overkiz Kizbox 2 Rev 2 with two heads";
+	compatible = "overkiz,kizbox2-rev2", "atmel,sama5d31",
+		     "atmel,sama5d3", "atmel,sama5";
+
+	ahb {
+		gpio_keys {
+			user {
+				status = "disabled";
+			};
+		};
+	};
+};
+
+&usart1 {
+	status = "okay";
+};
+
+&usart2 {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/at91-kizbox2.dts b/arch/arm/boot/dts/at91-kizbox2.dts
deleted file mode 100644
index 86d821884bd4..000000000000
--- a/arch/arm/boot/dts/at91-kizbox2.dts
+++ /dev/null
@@ -1,244 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * at91-kizbox2.dts - Device Tree file for Overkiz Kizbox 2 board
- *
- * Copyright (C) 2014 Gaël PORTAY <g.portay@overkiz.com>
- */
-/dts-v1/;
-#include "sama5d31.dtsi"
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	model = "Overkiz Kizbox 2";
-	compatible = "overkiz,kizbox2", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
-
-	chosen {
-		bootargs = "ubi.mtd=ubi";
-		stdout-path = &dbgu;
-	};
-
-	memory {
-		reg = <0x20000000 0x10000000>;
-	};
-
-	clocks {
-		slow_xtal {
-			clock-frequency = <32768>;
-		};
-
-		main_xtal {
-			clock-frequency = <12000000>;
-		};
-	};
-
-	ahb {
-		apb {
-			i2c1: i2c@f0018000 {
-				status = "okay";
-
-				pmic: act8865@5b {
-					compatible = "active-semi,act8865";
-					reg = <0x5b>;
-					status = "okay";
-
-					regulators {
-						vcc_1v8_reg: DCDC_REG1 {
-							regulator-name = "VCC_1V8";
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <1800000>;
-							regulator-always-on;
-						};
-
-						vcc_1v2_reg: DCDC_REG2 {
-							regulator-name = "VCC_1V2";
-							regulator-min-microvolt = <1200000>;
-							regulator-max-microvolt = <1200000>;
-							regulator-always-on;
-						};
-
-						vcc_3v3_reg: DCDC_REG3 {
-							regulator-name = "VCC_3V3";
-							regulator-min-microvolt = <3300000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-
-						vddfuse_reg: LDO_REG1 {
-							regulator-name = "FUSE_2V5";
-							regulator-min-microvolt = <2500000>;
-							regulator-max-microvolt = <2500000>;
-						};
-
-						vddana_reg: LDO_REG2 {
-							regulator-name = "VDDANA";
-							regulator-min-microvolt = <3300000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-
-						vled_reg: LDO_REG3 {
-							regulator-name = "VLED";
-							regulator-min-microvolt = <3300000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-
-						v3v8_rf_reg: LDO_REG4 {
-							regulator-name = "V3V8_RF";
-							regulator-min-microvolt = <3800000>;
-							regulator-max-microvolt = <3800000>;
-							regulator-always-on;
-						};
-					};
-				};
-			};
-
-			tcb0: timer@f0010000 {
-				timer@0 {
-					compatible = "atmel,tcb-timer";
-					reg = <0>;
-				};
-
-				timer@1 {
-					compatible = "atmel,tcb-timer";
-					reg = <1>;
-				};
-			};
-
-			usart0: serial@f001c000 {
-				status = "okay";
-			};
-
-			usart1: serial@f0020000 {
-				status = "okay";
-			};
-
-			pwm0: pwm@f002c000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_pwm0_pwmh0_1
-					     &pinctrl_pwm0_pwmh1_1
-					     &pinctrl_pwm0_pwmh2_0>;
-				status = "okay";
-			};
-
-			adc0: adc@f8018000 {
-				atmel,adc-vref = <3333>;
-				status = "okay";
-			};
-
-			usart2: serial@f8020000 {
-				status = "okay";
-			};
-
-			macb1: ethernet@f802c000 {
-				phy-mode = "rmii";
-				status = "okay";
-			};
-
-			dbgu: serial@ffffee00 {
-				status = "okay";
-			};
-
-			watchdog@fffffe40 {
-				status = "okay";
-			};
-		};
-
-		usb1: ohci@600000 {
-			status = "okay";
-		};
-
-		usb2: ehci@700000 {
-			status = "okay";
-		};
-
-		ebi: ebi@10000000 {
-			pinctrl-0 = <&pinctrl_ebi_nand_addr>;
-			pinctrl-names = "default";
-			status = "okay";
-
-			nand_controller: nand-controller {
-				status = "okay";
-
-				nand@3 {
-					reg = <0x3 0x0 0x2>;
-					atmel,rb = <0>;
-					nand-bus-width = <8>;
-					nand-ecc-mode = "hw";
-					nand-ecc-strength = <4>;
-					nand-ecc-step-size = <512>;
-					nand-on-flash-bbt;
-					label = "atmel_nand";
-
-					partitions {
-						compatible = "fixed-partitions";
-						#address-cells = <1>;
-						#size-cells = <1>;
-
-						bootstrap@0 {
-							label = "bootstrap";
-							reg = <0x0 0x20000>;
-						};
-
-						ubi@20000 {
-							label = "ubi";
-							reg = <0x20000 0x7fe0000>;
-						};
-					};
-				};
-			};
-		};
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		prog {
-			label = "PB_PROG";
-			gpios = <&pioE 27 GPIO_ACTIVE_LOW>;
-			linux,code = <0x102>;
-			wakeup-source;
-		};
-
-		reset {
-			label = "PB_RST";
-			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
-			linux,code = <0x100>;
-			wakeup-source;
-		};
-
-		user {
-			label = "PB_USER";
-			gpios = <&pioE 31 GPIO_ACTIVE_HIGH>;
-			linux,code = <0x101>;
-			wakeup-source;
-		};
-	};
-
-	pwm_leds {
-		compatible = "pwm-leds";
-
-		blue {
-			label = "pwm:blue:user";
-			pwms = <&pwm0 2 10000000 0>;
-			max-brightness = <255>;
-			linux,default-trigger = "default-on";
-		};
-
-		green {
-			label = "pwm:green:user";
-			pwms = <&pwm0 1 10000000 0>;
-			max-brightness = <255>;
-			linux,default-trigger = "default-on";
-		};
-
-		red {
-			label = "pwm:red:user";
-			pwms = <&pwm0 0 10000000 0>;
-			max-brightness = <255>;
-			linux,default-trigger = "default-on";
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/at91-kizbox2_common.dtsi b/arch/arm/boot/dts/at91-kizbox2_common.dtsi
new file mode 100644
index 000000000000..b8f644e4cf22
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox2_common.dtsi
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-kizbox2_common.dtsi - Device Tree Include file for
+ * Overkiz Kizbox 2 family SoC
+ *
+ * Copyright (C) 2014-2018 Overkiz SAS
+ *
+ * Authors: Antoine Aubert <a.aubert@overkiz.com>
+ *          Gaël Portay <g.portay@overkiz.com>
+ *          Kévin Raymond <k.raymond@overkiz.com>
+ */
+#include "sama5d31.dtsi"
+
+/ {
+	chosen {
+		bootargs = "ubi.mtd=ubi";
+		stdout-path = &dbgu;
+	};
+
+	memory {
+		reg = <0x20000000 0x10000000>;
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
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		prog {
+			label = "PB_PROG";
+			gpios = <&pioE 27 GPIO_ACTIVE_LOW>;
+			linux,code = <0x102>;
+			wakeup-source;
+		};
+
+		reset {
+			label = "PB_RST";
+			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
+			linux,code = <0x100>;
+			wakeup-source;
+		};
+
+		user {
+			label = "PB_USER";
+			gpios = <&pioE 31 GPIO_ACTIVE_HIGH>;
+			linux,code = <0x101>;
+			wakeup-source;
+		};
+	};
+
+	pwm_leds {
+		compatible = "pwm-leds";
+
+		blue {
+			label = "pwm:blue:user";
+			pwms = <&pwm0 2 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "none";
+		};
+
+		green {
+			label = "pwm:green:user";
+			pwms = <&pwm0 1 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+
+		red {
+			label = "pwm:red:user";
+			pwms = <&pwm0 0 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	pmic: act8865@5b {
+		compatible = "active-semi,act8865";
+		reg = <0x5b>;
+		status = "okay";
+
+		regulators {
+			vcc_1v8_reg: DCDC_REG1 {
+				regulator-name = "VCC_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			vcc_1v2_reg: DCDC_REG2 {
+				regulator-name = "VCC_1V2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			vcc_3v3_reg: DCDC_REG3 {
+				regulator-name = "VCC_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vddfuse_reg: LDO_REG1 {
+				regulator-name = "FUSE_2V5";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+			};
+
+			vddana_reg: LDO_REG2 {
+				regulator-name = "VDDANA";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vled_reg: LDO_REG3 {
+				regulator-name = "VLED";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			v3v8_rf_reg: LDO_REG4 {
+				regulator-name = "V3V8_RF";
+				regulator-min-microvolt = <3800000>;
+				regulator-max-microvolt = <3800000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&usart0 {
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "disabled";
+};
+
+&usart1 {
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "disabled";
+};
+
+&usart2 {
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "disabled";
+};
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_pwmh0_1
+		     &pinctrl_pwm0_pwmh1_1
+		     &pinctrl_pwm0_pwmh2_0>;
+	status = "okay";
+};
+
+&adc0 {
+	atmel,adc-vref = <3333>;
+	status = "okay";
+};
+
+&macb1 {
+	phy-mode = "rmii";
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
+&ebi {
+	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&nand_controller {
+	status = "okay";
+
+	nand@3 {
+		reg = <0x3 0x0 0x2>;
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
+			ubi@20000 {
+				label = "ubi";
+				reg = <0x20000 0x7fe0000>;
+			};
+		};
+	};
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+// WMBUS (inverted with IO in the latest schematic)
+&pinctrl_usart0 {
+	atmel,pins =
+		<AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+		 AT91_PIOD 18 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+		 AT91_PIOE 2 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;
+};
+
+// RTS
+&pinctrl_usart1 {
+	atmel,pins =
+		<AT91_PIOB 28 AT91_PERIPH_A AT91_PINCTRL_NONE
+		 AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+		 AT91_PIOE 7 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;
+};
+
+// IO (inverted with WMBUS in the latest schematic)
+&pinctrl_usart2 {
+	atmel,pins =
+		<AT91_PIOE 25 AT91_PERIPH_B AT91_PINCTRL_NONE
+		 AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_PULL_UP
+		 AT91_PIOE 8 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;
+};
-- 
2.23.0

