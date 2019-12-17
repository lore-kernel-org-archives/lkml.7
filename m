Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4577C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A776207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLQIsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:48:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41603 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQIsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:48:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so9957456ljc.8;
        Tue, 17 Dec 2019 00:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/yM9keizFdtD/Zu9RS0J8ft9ySY9Rw4HNUoAZC/cPow=;
        b=qNXb/m2tG+SgLQlIO5wOzX5QaAWUUZzj8ofGL6BrX1oMlynYSbqe0YRuVlZSGoW6ri
         7fm7j4njPC5Al51MXjo7b4lh75HJPEpW1yl+mTCz34N8QQNuI6ZNovkpIG6z+XiwOJsb
         fz8+C1Soac3Qh1f9waTW62ZAkuv77WtwxIM0PlQM4t59Iqkee4legLyubwToTUmZeayH
         mWF7I5tHk28c1w5Lv8ecj6rBEvTqBy2Pl6yTg4ThmprzBFASyZiatc8WAtY5Gqvh//J/
         Snb2al069Rqx0kTpCO4jwwHfGckHpIzw7Uuiby4YuSplMUbrZl5pf+aSbrErTs/lMX8E
         HLRg==
X-Gm-Message-State: APjAAAVC9d6dXDc8Qm8GTQ2fMp8RzmEf4tNcl18dZJpBM3j2cf5F4wgB
        Wjgyo8xarKmc2LAElf5KZrM=
X-Google-Smtp-Source: APXvYqySsdAwrEc2QXrE5Qohd5iThtwAPEsVl3wUvCAHKSmVd1lUsJ6yQa28z+gS7Wq3sewmBOHolQ==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr2284610ljg.149.1576572517592;
        Tue, 17 Dec 2019 00:48:37 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d25sm12104234ljj.51.2019.12.17.00.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 00:48:36 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:48:24 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: bd718x7: Yamlify and add BD71850
Message-ID: <20191217084824.GA26539@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
the binding document to two separate documents (own for BD71837 and BD71847)
as they have different amount of regulators. This way we can better enforce
the node name check for regulators. ROHM is also providing BD71850 - which
is almost identical to BD71847 - main difference is some initial regulator
states. The BD71850 can be driven by same driver and it has same buck/LDO
setup as BD71847 - add it to BD71847 binding document and introduce
compatible for it.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Oh dear how bad I am with yaml...

Lee, I think the support series for BD71828 included some changes
to drivers/mfd/rohm-bd718x7.c - I will add BD71850 compatible to next
version of that series in order to avoid conflicts. Does that work
for you?

 .../bindings/mfd/rohm,bd71837-pmic.txt        |  90 --------
 .../bindings/mfd/rohm,bd71837-pmic.yaml       | 198 ++++++++++++++++++
 .../bindings/mfd/rohm,bd71847-pmic.yaml       | 181 ++++++++++++++++
 .../regulator/rohm,bd71837-regulator.txt      | 162 --------------
 .../regulator/rohm,bd71837-regulator.yaml     | 103 +++++++++
 .../regulator/rohm,bd71847-regulator.yaml     |  97 +++++++++
 6 files changed, 579 insertions(+), 252 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
deleted file mode 100644
index f22d74c7a8db..000000000000
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+++ /dev/null
@@ -1,90 +0,0 @@
-* ROHM BD71837 and BD71847 Power Management Integrated Circuit bindings
-
-BD71837MWV and BD71847MWV are programmable Power Management ICs for powering
-single-core, dual-core, and quad-core SoCs such as NXP-i.MX 8M. They are
-optimized for low BOM cost and compact solution footprint. BD71837MWV
-integrates 8 Buck regulators and 7 LDOs. BD71847MWV contains 6 Buck regulators
-and 6 LDOs.
-
-Datasheet for BD71837 is available at:
-https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
-Datasheet for BD71847 is available at:
-https://www.rohm.com/datasheet/BD71847AMWV/bd71847amwv-e
-
-Required properties:
- - compatible		: Should be "rohm,bd71837" for bd71837
-				    "rohm,bd71847" for bd71847.
- - reg			: I2C slave address.
- - interrupt-parent	: Phandle to the parent interrupt controller.
- - interrupts		: The interrupt line the device is connected to.
- - clocks		: The parent clock connected to PMIC. If this is missing
-			  32768 KHz clock is assumed.
- - #clock-cells		: Should be 0.
- - regulators:		: List of child nodes that specify the regulators.
-			  Please see ../regulator/rohm,bd71837-regulator.txt
-
-Optional properties:
-- clock-output-names	: Should contain name for output clock.
-- rohm,reset-snvs-powered : Transfer BD718x7 to SNVS state at reset.
-
-The BD718x7 supports two different HW states as reset target states. States
-are called as SNVS and READY. At READY state all the PMIC power outputs go
-down and OTP is reload. At the SNVS state all other logic and external
-devices apart from the SNVS power domain are shut off. Please refer to NXP
-i.MX8 documentation for further information regarding SNVS state. When a
-reset is done via SNVS state the PMIC OTP data is not reload. This causes
-power outputs that have been under SW control to stay down when reset has
-switched power state to SNVS. If reset is done via READY state the power
-outputs will be returned to HW control by OTP loading. Thus the reset
-target state is set to READY by default. If SNVS state is used the boot
-crucial regulators must have the regulator-always-on and regulator-boot-on
-properties set in regulator node.
-
-- rohm,short-press-ms	: Short press duration in milliseconds
-- rohm,long-press-ms	: Long press duration in milliseconds
-
-Configure the "short press" and "long press" timers for the power button.
-Values are rounded to what hardware supports (500ms multiple for short and
-1000ms multiple for long). If these properties are not present the existing
-configuration (from bootloader or OTP) is not touched.
-
-Example:
-
-	/* external oscillator node */
-	osc: oscillator {
-		compatible = "fixed-clock";
-		#clock-cells = <1>;
-		clock-frequency  = <32768>;
-		clock-output-names = "osc";
-	};
-
-	pmic: pmic@4b {
-		compatible = "rohm,bd71837";
-		reg = <0x4b>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <29 GPIO_ACTIVE_LOW>;
-		interrupt-names = "irq";
-		#clock-cells = <0>;
-		clocks = <&osc 0>;
-		clock-output-names = "bd71837-32k-out";
-		rohm,reset-snvs-powered;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-			// [...]
-		};
-	};
-
-	/* Clock consumer node */
-	rtc@0 {
-		compatible = "company,my-rtc";
-		clock-names = "my-clock";
-		clocks = <&pmic>;
-	};
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
new file mode 100644
index 000000000000..3a6d408aebbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,bd71837-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD71837 Power Management Integrated Circuit bindings
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  BD71837MWV is programmable Power Management ICs for powering single-core,
+  dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for low
+  BOM cost and compact solution footprint. BD71837MWV  integrates 8 Buck
+  regulators and 7 LDOs.
+  Datasheet for BD71837 is available at
+  https://www.rohm.com/products/power-management/power-management-ic-for-system/industrial-consumer-applications/nxp-imx/bd71837amwv-product
+
+properties:
+  compatible:
+    const: rohm,bd71837
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+# The BD718x7 supports two different HW states as reset target states. States
+# are called as SNVS and READY. At READY state all the PMIC power outputs go
+# down and OTP is reload. At the SNVS state all other logic and external
+# devices apart from the SNVS power domain are shut off. Please refer to NXP
+# i.MX8 documentation for further information regarding SNVS state. When a
+# reset is done via SNVS state the PMIC OTP data is not reload. This causes
+# power outputs that have been under SW control to stay down when reset has
+# switched power state to SNVS. If reset is done via READY state the power
+# outputs will be returned to HW control by OTP loading. Thus the reset
+# target state is set to READY by default. If SNVS state is used the boot
+# crucial regulators must have the regulator-always-on and regulator-boot-on
+# properties set in regulator node.
+
+  rohm,reset-snvs-powered:
+    description: |
+      Transfer PMIC to SNVS state at reset
+    type: boolean
+
+# Configure the "short press" and "long press" timers for the power button.
+# Values are rounded to what hardware supports (500ms multiple for short and
+# 1000ms multiple for long). If these properties are not present the existing
+# configuration (from bootloader or OTP) is not touched.
+
+  rohm,short-press-ms:
+    description:
+      Short press duration in milliseconds
+
+  rohm,long-press-ms:
+    description:
+      Long press duration in milliseconds
+
+  regulators:
+    $ref: ../regulator/rohm,bd71837-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - "#clock-cells"
+  - regulators
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    #
+
+    i2c {
+      pmic: pmic@4b {
+            compatible = "rohm,bd71837";
+            reg = <0x4b>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+            #clock-cells = <0>;
+            clocks = <&osc 0>;
+            clock-output-names = "bd71837-32k-out";
+            rohm,reset-snvs-powered;
+
+            regulators {
+                buck1: BUCK1 {
+                    regulator-name = "buck1";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1250>;
+                    rohm,dvs-run-voltage = <900000>;
+                    rohm,dvs-idle-voltage = <850000>;
+                    rohm,dvs-suspend-voltage = <800000>;
+                };
+                buck2: BUCK2 {
+                    regulator-name = "buck2";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1250>;
+                    rohm,dvs-run-voltage = <1000000>;
+                    rohm,dvs-idle-voltage = <900000>;
+                };
+                buck3: BUCK3 {
+                    regulator-name = "buck3";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-boot-on;
+                    rohm,dvs-run-voltage = <1000000>;
+                };
+                buck4: BUCK4 {
+                    regulator-name = "buck4";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-boot-on;
+                    rohm,dvs-run-voltage = <1000000>;
+                };
+                buck5: BUCK5 {
+                    regulator-name = "buck5";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-boot-on;
+                };
+                buck6: BUCK6 {
+                    regulator-name = "buck6";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                };
+                buck7: BUCK7 {
+                    regulator-name = "buck7";
+                    regulator-min-microvolt = <1605000>;
+                    regulator-max-microvolt = <1995000>;
+                    regulator-boot-on;
+                };
+                buck8: BUCK8 {
+                    regulator-name = "buck8";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1400000>;
+                };
+
+                ldo1: LDO1 {
+                    regulator-name = "ldo1";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                };
+                ldo2: LDO2 {
+                    regulator-name = "ldo2";
+                    regulator-min-microvolt = <900000>;
+                    regulator-max-microvolt = <900000>;
+                    regulator-boot-on;
+                };
+                ldo3: LDO3 {
+                    regulator-name = "ldo3";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+                ldo4: LDO4 {
+                    regulator-name = "ldo4";
+                    regulator-min-microvolt = <900000>;
+                    regulator-max-microvolt = <1800000>;
+                };
+                ldo5: LDO5 {
+                    regulator-name = "ldo5";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+                ldo6: LDO6 {
+                    regulator-name = "ldo6";
+                    regulator-min-microvolt = <900000>;
+                    regulator-max-microvolt = <1800000>;
+                };
+                ldo7_reg: LDO7 {
+                    regulator-name = "ldo7";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
new file mode 100644
index 000000000000..16e72257edbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,bd71847-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD71847 and BD71850 Power Management Integrated Circuit bindings
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  BD71847AMWV and BD71850MWV are programmable Power Management ICs for powering
+  single-core,  dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is
+  optimized for low BOM cost and compact solution footprint. BD71847MWV and
+  BD71850MWV integrate 6 Buck regulators and 6 LDOs.
+  Datasheets are available at
+  https://www.rohm.com/products/power-management/power-management-ic-for-system/industrial-consumer-applications/nxp-imx/bd71847amwv-product
+  https://www.rohm.com/products/power-management/power-management-ic-for-system/industrial-consumer-applications/nxp-imx/bd71850mwv-product
+
+properties:
+  compatible:
+    enum:
+      - rohm,bd71847
+      - rohm,bd71850
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+# The BD71847 abd BD71850 support two different HW states as reset target
+# states. States are called as SNVS and READY. At READY state all the PMIC
+# power outputs go down and OTP is reload. At the SNVS state all other logic
+# and external devices apart from the SNVS power domain are shut off. Please
+# refer to NXP i.MX8 documentation for further information regarding SNVS
+# state. When a reset is done via SNVS state the PMIC OTP data is not reload.
+# This causes power outputs that have been under SW control to stay down when
+# reset has switched power state to SNVS. If reset is done via READY state the
+# power outputs will be returned to HW control by OTP loading. Thus the reset
+# target state is set to READY by default. If SNVS state is used the boot
+# crucial regulators must have the regulator-always-on and regulator-boot-on
+# properties set in regulator node.
+
+  rohm,reset-snvs-powered:
+    description:
+      Transfer PMIC to SNVS state at reset.
+    type: boolean
+
+# Configure the "short press" and "long press" timers for the power button.
+# Values are rounded to what hardware supports (500ms multiple for short and
+# 1000ms multiple for long). If these properties are not present the existing
+# configuration (from bootloader or OTP) is not touched.
+
+  rohm,short-press-ms:
+    description:
+      Short press duration in milliseconds
+
+  rohm,long-press-ms:
+    description:
+      Long press duration in milliseconds
+
+  regulators:
+    $ref: ../regulator/rohm,bd71847-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - "#clock-cells"
+  - regulators
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+      pmic: pmic@4b {
+            compatible = "rohm,bd71847";
+            reg = <0x4b>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+            #clock-cells = <0>;
+            clocks = <&osc 0>;
+            clock-output-names = "bd71847-32k-out";
+            rohm,reset-snvs-powered;
+
+            regulators {
+                buck1: BUCK1 {
+                    regulator-name = "buck1";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1250>;
+                    rohm,dvs-run-voltage = <900000>;
+                    rohm,dvs-idle-voltage = <850000>;
+                    rohm,dvs-suspend-voltage = <800000>;
+                };
+                buck2: BUCK2 {
+                    regulator-name = "buck2";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1250>;
+                    rohm,dvs-run-voltage = <1000000>;
+                    rohm,dvs-idle-voltage = <900000>;
+                };
+                buck3: BUCK3 {
+                    regulator-name = "buck3";
+                    regulator-min-microvolt = <550000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-boot-on;
+                };
+                buck4: BUCK4 {
+                    regulator-name = "buck4";
+                    regulator-min-microvolt = <2600000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                };
+                buck5: BUCK5 {
+                    regulator-name = "buck5";
+                    regulator-min-microvolt = <1605000>;
+                    regulator-max-microvolt = <1995000>;
+                    regulator-boot-on;
+                };
+                buck8: BUCK6 {
+                    regulator-name = "buck6";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1400000>;
+                };
+
+                ldo1: LDO1 {
+                    regulator-name = "ldo1";
+                    regulator-min-microvolt = <1600000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                };
+                ldo2: LDO2 {
+                    regulator-name = "ldo2";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <900000>;
+                    regulator-boot-on;
+                };
+                ldo3: LDO3 {
+                    regulator-name = "ldo3";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+                ldo4: LDO4 {
+                    regulator-name = "ldo4";
+                    regulator-min-microvolt = <900000>;
+                    regulator-max-microvolt = <1800000>;
+                };
+                ldo5: LDO5 {
+                    regulator-name = "ldo5";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+                ldo6: LDO6 {
+                    regulator-name = "ldo6";
+                    regulator-min-microvolt = <900000>;
+                    regulator-max-microvolt = <1800000>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
deleted file mode 100644
index cbce62c22b60..000000000000
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
+++ /dev/null
@@ -1,162 +0,0 @@
-ROHM BD71837 and BD71847 Power Management Integrated Circuit regulator bindings
-
-Required properties:
- - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7" for
-                   BD71837. For BD71847 names should be "buck1", ..., "buck6"
-		   and "ldo1", ..., "ldo6"
-
-List of regulators provided by this controller. BD71837 regulators node
-should be sub node of the BD71837 MFD node. See BD71837 MFD bindings at
-Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
-Regulator nodes should be named to BUCK_<number> and LDO_<number>. The
-definition for each of these nodes is defined using the standard
-binding for regulators at
-Documentation/devicetree/bindings/regulator/regulator.txt.
-Note that if BD71837 starts at RUN state you probably want to use
-regulator-boot-on at least for BUCK6 and BUCK7 so that those are not
-disabled by driver at startup. LDO5 and LDO6 are supplied by those and
-if they are disabled at startup the voltage monitoring for LDO5/LDO6 will
-cause PMIC to reset.
-
-The valid names for BD71837 regulator nodes are:
-BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, BUCK7, BUCK8
-LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7
-
-The valid names for BD71847 regulator nodes are:
-BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6
-LDO1, LDO2, LDO3, LDO4, LDO5, LDO6
-
-Optional properties:
-- rohm,dvs-run-voltage		: PMIC default "RUN" state voltage in uV.
-				  See below table for bucks which support this.
-- rohm,dvs-idle-voltage		: PMIC default "IDLE" state voltage in uV.
-				  See below table for bucks which support this.
-- rohm,dvs-suspend-voltage	: PMIC default "SUSPEND" state voltage in uV.
-				  See below table for bucks which support this.
-- Any optional property defined in bindings/regulator/regulator.txt
-
-Supported default DVS states:
-
-BD71837:
-buck	| dvs-run-voltage	| dvs-idle-voltage	| dvs-suspend-voltage
------------------------------------------------------------------------------
-1	| supported		| supported		| supported
-----------------------------------------------------------------------------
-2	| supported		| supported		| not supported
-----------------------------------------------------------------------------
-3	| supported		| not supported		| not supported
-----------------------------------------------------------------------------
-4	| supported		| not supported		| not supported
-----------------------------------------------------------------------------
-rest	| not supported		| not supported		| not supported
-
-BD71847:
-buck	| dvs-run-voltage	| dvs-idle-voltage	| dvs-suspend-voltage
------------------------------------------------------------------------------
-1	| supported		| supported		| supported
-----------------------------------------------------------------------------
-2	| supported		| supported		| not supported
-----------------------------------------------------------------------------
-rest	| not supported		| not supported		| not supported
-
-Example:
-regulators {
-	buck1: BUCK1 {
-		regulator-name = "buck1";
-		regulator-min-microvolt = <700000>;
-		regulator-max-microvolt = <1300000>;
-		regulator-boot-on;
-		regulator-always-on;
-		regulator-ramp-delay = <1250>;
-		rohm,dvs-run-voltage = <900000>;
-		rohm,dvs-idle-voltage = <850000>;
-		rohm,dvs-suspend-voltage = <800000>;
-	};
-	buck2: BUCK2 {
-		regulator-name = "buck2";
-		regulator-min-microvolt = <700000>;
-		regulator-max-microvolt = <1300000>;
-		regulator-boot-on;
-		regulator-always-on;
-		regulator-ramp-delay = <1250>;
-		rohm,dvs-run-voltage = <1000000>;
-		rohm,dvs-idle-voltage = <900000>;
-	};
-	buck3: BUCK3 {
-		regulator-name = "buck3";
-		regulator-min-microvolt = <700000>;
-		regulator-max-microvolt = <1300000>;
-		regulator-boot-on;
-		rohm,dvs-run-voltage = <1000000>;
-	};
-	buck4: BUCK4 {
-		regulator-name = "buck4";
-		regulator-min-microvolt = <700000>;
-		regulator-max-microvolt = <1300000>;
-		regulator-boot-on;
-		rohm,dvs-run-voltage = <1000000>;
-	};
-	buck5: BUCK5 {
-		regulator-name = "buck5";
-		regulator-min-microvolt = <700000>;
-		regulator-max-microvolt = <1350000>;
-		regulator-boot-on;
-	};
-	buck6: BUCK6 {
-		regulator-name = "buck6";
-		regulator-min-microvolt = <3000000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-	};
-	buck7: BUCK7 {
-		regulator-name = "buck7";
-		regulator-min-microvolt = <1605000>;
-		regulator-max-microvolt = <1995000>;
-		regulator-boot-on;
-	};
-	buck8: BUCK8 {
-		regulator-name = "buck8";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1400000>;
-	};
-
-	ldo1: LDO1 {
-		regulator-name = "ldo1";
-		regulator-min-microvolt = <3000000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-	};
-	ldo2: LDO2 {
-		regulator-name = "ldo2";
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <900000>;
-		regulator-boot-on;
-	};
-	ldo3: LDO3 {
-		regulator-name = "ldo3";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-	ldo4: LDO4 {
-		regulator-name = "ldo4";
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <1800000>;
-	};
-	ldo5: LDO5 {
-		regulator-name = "ldo5";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-	ldo6: LDO6 {
-		regulator-name = "ldo6";
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <1800000>;
-	};
-	ldo7_reg: LDO7 {
-		regulator-name = "ldo7";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
-
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
new file mode 100644
index 000000000000..a323b1696eee
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/rohm,bd71837-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD71837 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  List of regulators provided by this controller. BD71837 regulators node
+  should be sub node of the BD71837 MFD node. See BD71837 MFD bindings at
+  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
+  Regulator nodes should be named to BUCK_<number> and LDO_<number>. The
+  definition for each of these nodes is defined using the standard
+  binding for regulators at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+  Note that if BD71837 starts at RUN state you probably want to use
+  regulator-boot-on at least for BUCK6 and BUCK7 so that those are not
+  disabled by driver at startup. LDO5 and LDO6 are supplied by those and
+  if they are disabled at startup the voltage monitoring for LDO5/LDO6 will
+  cause PMIC to reset.
+
+#The valid names for BD71837 regulator nodes are:
+#BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, BUCK7, BUCK8
+#LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7
+
+patternProperties:
+  "^LDO[1-7]$":
+    type: object
+    allOf:
+      - $ref: regulator.yaml#
+    description:
+      Properties for single LDO regulator.
+
+    properties:
+      regulator-name:
+        pattern: "^ldo[1-7]$"
+        description:
+          should be "ldo1", ..., "ldo7"
+
+  "^BUCK[1-8]$":
+    type: object
+    allOf:
+      - $ref: regulator.yaml#
+    description:
+      Properties for single BUCK regulator.
+
+    properties:
+      regulator-name:
+        pattern: "^buck[1-8]$"
+        description:
+          should be "buck1", ..., "buck8"
+
+      rohm,dvs-run-voltage:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 1300000
+        description:
+          PMIC default "RUN" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+
+      rohm,dvs-idle-voltage:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 1300000
+        description:
+          PMIC default "IDLE" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+
+      rohm,dvs-suspend-voltage:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 1300000
+        description:
+          PMIC default "SUSPEND" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+
+        # Supported default DVS states:
+        #
+        # BD71837:
+        # buck | dvs-run-voltage | dvs-idle-voltage | dvs-suspend-voltage
+        # ----------------------------------------------------------------
+        # 1    | supported       | supported        | supported
+        # ----------------------------------------------------------------
+        # 2    | supported       | supported        | not supported
+        # ----------------------------------------------------------------
+        # 3    | supported       | not supported    | not supported
+        # ----------------------------------------------------------------
+        # 4    | supported       | not supported    | not supported
+        # ----------------------------------------------------------------
+        # rest | not supported   | not supported    | not supported
+
+
+    required:
+      - regulator-name
+  additionalProperties: false
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
new file mode 100644
index 000000000000..526fd00bcb16
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/rohm,bd71847-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD71847 and BD71850 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  List of regulators provided by this controller. BD71847 regulators node
+  should be sub node of the BD71847 MFD node. See BD71847 MFD bindings at
+  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+  Regulator nodes should be named to BUCK_<number> and LDO_<number>. The
+  definition for each of these nodes is defined using the standard
+  binding for regulators at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+  Note that if BD71847 starts at RUN state you probably want to use
+  regulator-boot-on at least for BUCK5. LDO6 is supplied by it and it must
+  not be disabled by driver at startup. If BUCK5 is disabled at startup the
+  voltage monitoring for LDO5/LDO6 can cause PMIC to reset.
+
+#The valid names for BD71847 regulator nodes are:
+#BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6
+#LDO1, LDO2, LDO3, LDO4, LDO5, LDO6
+
+patternProperties:
+  "^LDO[1-6]$":
+    type: object
+    allOf:
+      - $ref: regulator.yaml#
+    description:
+      Properties for single LDO regulator.
+
+    properties:
+      regulator-name:
+        pattern: "^ldo[1-6]$"
+        description:
+          should be "ldo1", ..., "ldo6"
+
+  "^BUCK[1-6]$":
+    type: object
+    allOf:
+      - $ref: regulator.yaml#
+    description:
+      Properties for single BUCK regulator.
+
+    properties:
+      regulator-name:
+        pattern: "^buck[1-6]$"
+        description:
+          should be "buck1", ..., "buck6"
+
+      rohm,dvs-run-voltage:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 1300000
+        description:
+          PMIC default "RUN" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+
+      rohm,dvs-idle-voltage:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 1300000
+        description:
+          PMIC default "IDLE" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+
+      rohm,dvs-suspend-voltage:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 1300000
+        description:
+          PMIC default "SUSPEND" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+
+        # Supported default DVS states:
+        #
+        # BD71847:
+        # buck | dvs-run-voltage | dvs-idle-voltage | dvs-suspend-voltage
+        # ----------------------------------------------------------------
+        # 1    | supported       | supported        | supported
+        # ----------------------------------------------------------------
+        # 2    | supported       | supported        | not supported
+        # ----------------------------------------------------------------
+        # rest | not supported   | not supported    | not supported
+
+    required:
+      - regulator-name
+  additionalProperties: false
+additionalProperties: false

base-commit: d1eef1c619749b2a57e514a3fa67d9a516ffa919
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
