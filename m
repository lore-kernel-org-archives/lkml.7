Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F8ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526B720872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eZOy7J2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbfJOQXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:23:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52415 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbfJOQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:23:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so21555629wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5B5AkAQGi4DNKyHv7fhvAOLB86h889/P7BfszQY5c4=;
        b=eZOy7J2IO2HWDqq09vENTThSZi5vPpMlD7l5AKRvV+cYtbJ1ZcMswyrzdSm86HC42s
         jJyPjN99mftKfl1KK53lNJPl9dDdXq90BMed/I6d7tdIJHLtcYu5eNzFnvN+uXE7i+lD
         YqQ9kHqlp5eh97O/cqk5jL/bJ8Y2qanAgPRhOhZIwmG9QrIUZLJlsb7tiddKDdMpKeTf
         ks0ISe77XXkeGFPrXoq+BxHN+bEgRhkL5KdKbNey2Gls8+QUQVjZwnH0LntE1w56TTPj
         eZJ2xQ+d/sRURoZ/MZ+ls7i378TmmHLD0Fg8Q2Ef40Lf1trRCIepaVAPSYLHvjH7b5Xa
         kIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5B5AkAQGi4DNKyHv7fhvAOLB86h889/P7BfszQY5c4=;
        b=uk8ws4KUfedabACltKejAUfKw4+GFj0nJwADSoD2bwmS2yA5cG78LldnP+xbgZcbxL
         iFlY5We+qYPE4RDdIBt5qC1Rq0AlT1Z78Vz54TUjT7ZlddWLT78nIwkglZsLEfzMV/e/
         MlEbtjLlnd50RzP2mxCQLpEljSTaM5toQPH6gVovv4SieYEsaJD6DtGR8C+ipNSfoc6S
         ozGz41Gvmp7mNkw9WspT+hGvNnZFBT7OdffgqvKtTf7L1aTQ91jZDoAKIiy4awXDIBba
         cZOXx+eRgabhC4R8hkCokCp+6QcseOM7z5HSquwUZ3fANefJmejUAZBOp8uX7+gloZ7W
         XtMg==
X-Gm-Message-State: APjAAAVWO733wcT0mEsSmiwoeVxNUdSeP2OxfG859KkYP1S3kyf4ouCo
        sZclxrnRDmW2BWCNdRZrfNVw0Q==
X-Google-Smtp-Source: APXvYqyHK5TFwV9xIejPU5dtBpGW5WxVyh8AU6LufLjB7nMCfCxfgYwQacJucrroFYP9OyvU2koHMg==
X-Received: by 2002:a1c:7219:: with SMTP id n25mr19497225wmc.33.1571156590048;
        Tue, 15 Oct 2019 09:23:10 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x129sm41427605wmg.8.2019.10.15.09.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:23:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/6] dt-bindings: regulator: max77650: convert the binding document to yaml
Date:   Tue, 15 Oct 2019 18:22:57 +0200
Message-Id: <20191015162300.22024-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015162300.22024-1-brgl@bgdev.pl>
References: <20191015162300.22024-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for MAX77650 regulator module to YAML.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/regulator/max77650-regulator.txt | 42 +--------------
 .../regulator/max77650-regulator.yaml         | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
index f1cbe813c30f..39686610589c 100644
--- a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
@@ -1,41 +1 @@
-Regulator driver for MAX77650 PMIC from Maxim Integrated.
-
-This module is part of the MAX77650 MFD device. For more details
-see Documentation/devicetree/bindings/mfd/max77650.txt.
-
-The regulator controller is represented as a sub-node of the PMIC node
-on the device tree.
-
-The device has a single LDO regulator and a SIMO buck-boost regulator with
-three independent power rails.
-
-Required properties:
---------------------
-- compatible:		Must be "maxim,max77650-regulator"
-
-Each rail must be instantiated under the regulators subnode of the top PMIC
-node. Up to four regulators can be defined. For standard regulator properties
-refer to Documentation/devicetree/bindings/regulator/regulator.txt.
-
-Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sbb2".
-
-Example:
---------
-
-	regulators {
-		compatible = "maxim,max77650-regulator";
-
-		max77650_ldo: regulator@0 {
-			regulator-compatible = "ldo";
-			regulator-name = "max77650-ldo";
-			regulator-min-microvolt = <1350000>;
-			regulator-max-microvolt = <2937500>;
-		};
-
-		max77650_sbb0: regulator@1 {
-			regulator-compatible = "sbb0";
-			regulator-name = "max77650-sbb0";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <1587500>;
-		};
-	};
+This file has been moved to max77650-regulator.yaml.
diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
new file mode 100644
index 000000000000..c0d986948ac8
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/max77650-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator driver for MAX77650 PMIC from Maxim Integrated.
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+description: |
+  This module is part of the MAX77650 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  The device has a single LDO regulator and a SIMO buck-boost regulator with
+  three independent power rails.
+
+properties:
+  compatible:
+    const: maxim,max77650-regulator
+
+patternProperties:
+  "^regulator@[0-3]$":
+    $ref: "regulator.yaml#"
+
+required:
+  - compatible
+
+examples:
+  - |
+    regulators {
+        compatible = "maxim,max77650-regulator";
+
+        max77650_ldo: regulator@0 {
+            regulator-compatible = "ldo";
+            regulator-name = "max77650-ldo";
+            regulator-min-microvolt = <1350000>;
+            regulator-max-microvolt = <2937500>;
+        };
+
+        max77650_sbb0: regulator@1 {
+            regulator-compatible = "sbb0";
+            regulator-name = "max77650-sbb0";
+            regulator-min-microvolt = <800000>;
+            regulator-max-microvolt = <1587500>;
+        };
+    };
-- 
2.23.0

