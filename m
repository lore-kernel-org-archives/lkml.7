Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C853ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215C22086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Etexy0V/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfJOQXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:23:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45307 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbfJOQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:23:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so24576976wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oyfsjm/f/3cTPX8e+fB49AEmLNgnRiE4f3MBNPIF/lE=;
        b=Etexy0V/KEWqggN7u8UaCF7I5tKAimc+kwBrSf/NWGcg/m0KxHUQ13yF0cGQgKRZsQ
         7LCtVyLDWNzFgZ7MQPvYrBu2bqkhX04dsPGcDJt29gEz1VivuN9p08c/mgoWzIkGaA0u
         6i99xQu3M87Oi+ojjpUuL4BVUirCPgSQaxTEEFBd6LCIgkZL4aP0JH4q+epKO9XkUopM
         6rvaP1Ay/Du21cRj2YpAc6LU3lPQX6Mt1fejEScmeTuptV4pN3Pl9Icpq/ZN7qB7gypm
         m38p/d8NfQe9Ho7274BzmHoHwmPK7m7H99R9rcMDPTM0Hh3QMIErAQPR7k+mmE0UCFE2
         Wj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oyfsjm/f/3cTPX8e+fB49AEmLNgnRiE4f3MBNPIF/lE=;
        b=akv00wP9HImEEGZLa0cL5JA+aDidM9SLcySZ/uLc89gj9y/tZbJkDzndy4CA2gc5wh
         dxl03e7x3MdB9R0aVoOJY4QT7v4fGWIJZ+FMFyb9fLuZdPjCgN4dGZiqyw9AA0ENYuwk
         qQ1zY05l1YnIv+oMgd8M6i7VHecz/362GAosvLbjjZkXWkYhd3BL/hw4kq3cugIn9BuZ
         PlRv9KRJiX1m9yHkbSO96TsQ/AdCzHvuFYn4TmkCy9uYny4Ul9Ep7BdB2JG2AV589GTv
         3nduaSvlObqRhVQ3xApUwdXp8irydAUmUB4uiocxWvvKzCsZlH8ngF1wV9tQEkKPSw8I
         1pOw==
X-Gm-Message-State: APjAAAXmJrTRDbVQh01rCarbRyahRTtGNzGpQjlIWG0bGgfgJHdE0Vdh
        B7seLzGuz8dOhbRLy3HhmozR+A==
X-Google-Smtp-Source: APXvYqxbKT9NYUCfzBHzh/67remSXoazRB0t8uyVEUGS4m1bVu0z9bJo3dDsrplJ9mEwDa0WUktFeQ==
X-Received: by 2002:a5d:4fcd:: with SMTP id h13mr28487052wrw.307.1571156591430;
        Tue, 15 Oct 2019 09:23:11 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x129sm41427605wmg.8.2019.10.15.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:23:10 -0700 (PDT)
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
Subject: [PATCH v2 4/6] dt-bindings: power: max77650: convert the binding document to yaml
Date:   Tue, 15 Oct 2019 18:22:58 +0200
Message-Id: <20191015162300.22024-5-brgl@bgdev.pl>
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

Convert the binding document for MAX77650 charger module to YAML.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 29 +------------
 .../power/supply/max77650-charger.yaml        | 42 +++++++++++++++++++
 2 files changed, 43 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
index e6d0fb6ff94e..fbab7d3ac8e3 100644
--- a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
@@ -1,28 +1 @@
-Battery charger driver for MAX77650 PMIC from Maxim Integrated.
-
-This module is part of the MAX77650 MFD device. For more details
-see Documentation/devicetree/bindings/mfd/max77650.txt.
-
-The charger is represented as a sub-node of the PMIC node on the device tree.
-
-Required properties:
---------------------
-- compatible:		Must be "maxim,max77650-charger"
-
-Optional properties:
---------------------
-- input-voltage-min-microvolt:	Minimum CHGIN regulation voltage. Must be one
-				of: 4000000, 4100000, 4200000, 4300000,
-				4400000, 4500000, 4600000, 4700000.
-- input-current-limit-microamp:	CHGIN input current limit (in microamps). Must
-				be one of: 95000, 190000, 285000, 380000,
-				475000.
-
-Example:
---------
-
-	charger {
-		compatible = "maxim,max77650-charger";
-		input-voltage-min-microvolt = <4200000>;
-		input-current-limit-microamp = <285000>;
-	};
+This file was moved to max77650-charger.yaml.
diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.yaml b/Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
new file mode 100644
index 000000000000..9dd0dad0f948
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/max77650-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery charger driver for MAX77650 PMIC from Maxim Integrated.
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+description: |
+  This module is part of the MAX77650 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+  The charger is represented as a sub-node of the PMIC node on the device tree.
+
+properties:
+  compatible:
+    const: maxim,max77650-charger
+
+  input-voltage-min-microvolt:
+    description:
+      Minimum CHGIN regulation voltage.
+    enum: [ 4000000, 4100000, 4200000, 4300000,
+            4400000, 4500000, 4600000, 4700000 ]
+
+  input-current-limit-microamp:
+    description:
+      CHGIN input current limit (in microamps).
+    enum: [ 95000, 190000, 285000, 380000, 475000 ]
+
+required:
+  - compatible
+
+examples:
+  - |
+    charger {
+        compatible = "maxim,max77650-charger";
+        input-voltage-min-microvolt = <4200000>;
+        input-current-limit-microamp = <285000>;
+    };
-- 
2.23.0

