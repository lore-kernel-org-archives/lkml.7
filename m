Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80330C16A69
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE312182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558473637;
	bh=VSv+LMF57kTYmD/2jaLoht/0vcYyyN+yEf1/Z76LJA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QHZGPUaSJusnk9Ahh0RyIXu+YPopMCEUm1TvdJUp/TRnVn2HJzVU87eh2AK4kyQ8x
	 yU52o9gL9aoOVf9S6J0ylUkHa89MLqb6NJw/m1X3XF/55RVmoWc843GyCMASR3fyfD
	 jqfG77i3EBybeNwuJv9NpZzE794deeRnwLEq9XVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfEUVUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:20:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42205 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfEUVUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:20:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id w9so12156196oic.9;
        Tue, 21 May 2019 14:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohQFTgMMLwtzJyoURDl0Jg9MM3ofsM/G0HILwpPhwVs=;
        b=mDYIP3YxPmnQy1/uDtUNvIZOXpld8tF05bFqegwgJU6gduQhVyQva1QXOMuvkr511L
         kwMp3CB0gtlX37bX13NM5O5g2bFTsPhOEW0T+b4QqI915ggwNDZlZG8u2If+V4879RjW
         +3faNrpQv5mUO005ureOUv/r8LgsOs8/Y7Ms2t2fUc09hLsjjMvLRF2fbUyTUja+vitQ
         gxLk+KeuaIIlhHMk6h/MhbviFyfCRBL+yPgy/a/kyL2UARu1Z6PKryrynLvhziXTq1M8
         Psrf8Zb9qnySI/X72JkO/+1GuKk/48UA6fEGWrcGoWtwrxyuBfFp26ti0WPVQpdm0zpT
         ib7Q==
X-Gm-Message-State: APjAAAWHMxQRpZewXW+vZE8C3R/y3ESzfHHrsBe1AQ6y41Ytl1dIOzkp
        dszdYaBuQtDCZAvcqcsjngZks+g=
X-Google-Smtp-Source: APXvYqykJ+/80zeE9FPye0CIaSUoGAB3CaTSqv0cqUZp+A5u3C1Z48rEg8uq4fdgU6epwsuVtwkMxw==
X-Received: by 2002:aca:d6d0:: with SMTP id n199mr4713837oig.51.1558473634575;
        Tue, 21 May 2019 14:20:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y3sm7510534oto.58.2019.05.21.14.20.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 14:20:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/3] dt-bindings: regulator: Convert gpio-regulator to json-schema
Date:   Tue, 21 May 2019 16:20:30 -0500
Message-Id: <20190521212031.12982-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521212031.12982-1-robh@kernel.org>
References: <20190521212031.12982-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the gpio-regulator binding to DT schema format using
json-schema.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
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

