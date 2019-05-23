Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79A3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2192175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558619347;
	bh=klsTxGUx/77tyYi70S6c30cYI6nZQkFLOxEf1NPfpgs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VV/rGQkiVJMllwXe6PV7+aRXZzGTwlCWR9nM59OQg+ZW9ZmbXaXIhm05E6cEpz214
	 a0OrkXv7It25EVyjChSlEavshXQJtK8UPbh/z/wRUU0J4dT6bfIOOaP36VZk3p3POv
	 KciCjh9QeoU54cEkYZZAORWxFPx5nbnc8W52WqXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfEWNtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:49:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44922 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbfEWNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=apcyAboxe792qh3AK3njxXGriXNQtjXi9uWRFsMGTuc=; b=HzuGuk9gdzeU
        58v4d18AC9cG9wxDQJllBW6PDBT7GB9RpreCTPKlWrFXmJNZWSYqS1NyUOWQxI2vEY+yoQhIaXHuz
        gkIOjwM1e/MQw0Q1Sll6uHHV1X7x0oEZ+zIX9wZA45G7N0PZDKafXV11gsdhcctFvSiEWXZdLGVFy
        cBytc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTo5d-0000EY-F9; Thu, 23 May 2019 13:49:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4A60E1126D27; Thu, 23 May 2019 14:49:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: Convert gpio-regulator to json-schema" to the regulator tree
In-Reply-To: <20190521212031.12982-2-robh@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190523134900.4A60E1126D27@debutante.sirena.org.uk>
Date:   Thu, 23 May 2019 14:49:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Convert gpio-regulator to json-schema

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 673e401effe9dfd655f2d16588248f4c043361ce Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Tue, 21 May 2019 16:20:30 -0500
Subject: [PATCH] regulator: Convert gpio-regulator to json-schema

Convert the gpio-regulator binding to DT schema format using
json-schema.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/gpio-regulator.txt     |  57 ---------
 .../bindings/regulator/gpio-regulator.yaml    | 118 ++++++++++++++++++
 2 files changed, 118 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/gpio-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/gpio-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
deleted file mode 100644
index dd25e73b5d79..000000000000
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-GPIO controlled regulators
-
-Required properties:
-- compatible		: Must be "regulator-gpio".
-- regulator-name	: Defined in regulator.txt as optional, but required
-			  here.
-- gpios			: Array of one or more GPIO pins used to select the
-			  regulator voltage/current listed in "states".
-- states		: Selection of available voltages/currents provided by
-			  this regulator and matching GPIO configurations to
-			  achieve them. If there are no states in the "states"
-			  array, use a fixed regulator instead.
-
-Optional properties:
-- enable-gpios		: GPIO used to enable/disable the regulator.
-			  Warning, the GPIO phandle flags are ignored and the
-			  GPIO polarity is controlled solely by the presence
-			  of "enable-active-high" DT property. This is due to
-			  compatibility with old DTs.
-- enable-active-high	: Polarity of "enable-gpio" GPIO is active HIGH.
-			  Default is active LOW.
-- gpios-states		: On operating systems, that don't support reading back
-			  gpio values in output mode (most notably linux), this
-			  array provides the state of GPIO pins set when
-			  requesting them from the gpio controller. Systems,
-			  that are capable of preserving state when requesting
-			  the lines, are free to ignore this property.
-			  0: LOW, 1: HIGH. Default is LOW if nothing else
-			  is specified.
-- startup-delay-us	: Startup time in microseconds.
-- regulator-type	: Specifies what is being regulated, must be either
-			  "voltage" or "current", defaults to voltage.
-
-Any property defined as part of the core regulator binding defined in
-regulator.txt can also be used.
-
-Example:
-
-	mmciv: gpio-regulator {
-		compatible = "regulator-gpio";
-
-		regulator-name = "mmci-gpio-supply";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2600000>;
-		regulator-boot-on;
-
-		enable-gpios = <&gpio0 23 0x4>;
-		gpios = <&gpio0 24 0x4
-			 &gpio0 25 0x4>;
-		states = <1800000 0x3
-			  2200000 0x2
-			  2600000 0x1
-			  2900000 0x0>;
-
-		startup-delay-us = <100000>;
-		enable-active-high;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
new file mode 100644
index 000000000000..9d3b28417fb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/gpio-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO controlled regulators
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+description:
+  Any property defined as part of the core regulator binding, defined in
+  regulator.txt, can also be used.
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: regulator-gpio
+
+  regulator-name: true
+
+  enable-gpios:
+    description: GPIO to use to enable/disable the regulator.
+      Warning, the GPIO phandle flags are ignored and the GPIO polarity is
+      controlled solely by the presence of "enable-active-high" DT property.
+      This is due to compatibility with old DTs.
+    maxItems: 1
+
+  gpios:
+    description: Array of one or more GPIO pins used to select the regulator
+      voltage/current listed in "states".
+    minItems: 1
+    maxItems: 8  # Should be enough...
+
+  gpios-states:
+    description: |
+      On operating systems, that don't support reading back gpio values in
+      output mode (most notably linux), this array provides the state of GPIO
+      pins set when requesting them from the gpio controller. Systems, that are
+      capable of preserving state when requesting the lines, are free to ignore
+      this property.
+        0: LOW
+        1: HIGH
+      Default is LOW if nothing else is specified.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - maxItems: 8
+        items:
+          enum: [ 0, 1 ]
+          default: 0
+
+  states:
+    description: Selection of available voltages/currents provided by this
+      regulator and matching GPIO configurations to achieve them. If there are
+      no states in the "states" array, use a fixed regulator instead.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-matrix
+      - maxItems: 8
+        items:
+          items:
+            - description: Voltage in microvolts
+            - description: GPIO group state value
+
+  startup-delay-us:
+    description: startup time in microseconds
+
+  enable-active-high:
+    description: Polarity of "enable-gpio" GPIO is active HIGH. Default is
+      active LOW.
+    type: boolean
+
+  gpio-open-drain:
+    description:
+      GPIO is open drain type. If this property is missing then default
+      assumption is false.
+    type: boolean
+
+  regulator-type:
+    description: Specifies what is being regulated.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/string
+      - enum:
+          - voltage
+          - current
+        default: voltage
+
+required:
+  - compatible
+  - regulator-name
+  - gpios
+  - states
+
+examples:
+  - |
+    gpio-regulator {
+      compatible = "regulator-gpio";
+
+      regulator-name = "mmci-gpio-supply";
+      regulator-min-microvolt = <1800000>;
+      regulator-max-microvolt = <2600000>;
+      regulator-boot-on;
+
+      enable-gpios = <&gpio0 23 0x4>;
+      gpios = <&gpio0 24 0x4
+        &gpio0 25 0x4>;
+      states = <1800000 0x3>,
+        <2200000 0x2>,
+        <2600000 0x1>,
+        <2900000 0x0>;
+
+      startup-delay-us = <100000>;
+      enable-active-high;
+    };
+...
-- 
2.20.1

