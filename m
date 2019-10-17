Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E9FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D52082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nXztOB+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408017AbfJQHND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:13:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33878 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407964AbfJQHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:12:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so6318737wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 00:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JhZXgpu4dUNgUWOnAT62hGIKmc/tHNXrxRtuYvr7w8=;
        b=nXztOB+NJP5/6TCNuxLNs7RYMG808oSa92A/hRXfjUGd8gGnl++eh3yqOqjCtoVjVo
         rsAsmLoaR31LpGitvJk1e2nrwnDV2OAoe3QZz+o7rj+OSZiCVqgdXbHo917SAldplXQ4
         Kl6q8CH/Jnh8eAK9LJIUVQHgcK4t3e+11svGbAaqs8qLx+qN0LTTBG7DA9wA0VGGrHli
         4o1Ht+uscXr/qEL+B0lD4w3tVSt0FgdIc4JoEQpyGowdSB2Fu8PGXJ2nKsHWNtUj8TEp
         X4qgdiqeMdWuqf3UNReQWZEP+rakPyrxNxUxJd5FSaK5hP4c9FiJsIdhsB8Hq/9nCuIP
         Y4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JhZXgpu4dUNgUWOnAT62hGIKmc/tHNXrxRtuYvr7w8=;
        b=JP/0Fm2ltgWsLzJkZlP0eBlgzcTzOuk/CALiUT5HRyGy53ahjvkKWkKuylzZxqOhZS
         neIPb/MVk+co/onGStUtddqR2CcfgYgzALFYYXE1OU94GUBO0Wo3ar9mJDQ5NWCCpvOD
         KpoYObB6ibOMNqhdONBWtCjzNVgt7rkxNU+C8KItxsGy9pSP3KRjzECYrBzpSUOgd53C
         2eFBhMh/XANYIE65FXArQ9pM+YEO5iqOejiMU1TH4me+Gcx7woK4WlDy4HYoJ0onS2tm
         X4XAa1Pb+g4mKVgpAGGbmsFlG50k6kJMlkaEl7apATOFXy6WPo8U5dNOJHdBGrufd/bg
         v4ig==
X-Gm-Message-State: APjAAAWFj5yG8KRdMnzUvnctooy67Ca8jMj9tPduPRy3Mhv/a5kc9b2H
        hYv/qr38JNlCBQmVeWWpB/Xajw==
X-Google-Smtp-Source: APXvYqy1lyxMrIzO5yCkzKi/iR0u4zrnr6xf4R0o/Tonlq4e8EEQqu+rPTeRA96JRjUBhsVmWrgkaw==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr1479817wmb.55.1571296364946;
        Thu, 17 Oct 2019 00:12:44 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n22sm1156689wmk.19.2019.10.17.00.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 00:12:44 -0700 (PDT)
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
Subject: [PATCH v3 4/6] dt-bindings: power: max77650: convert the binding document to yaml
Date:   Thu, 17 Oct 2019 09:12:32 +0200
Message-Id: <20191017071234.8719-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017071234.8719-1-brgl@bgdev.pl>
References: <20191017071234.8719-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for MAX77650 charger module to YAML.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
 .../power/supply/max77650-charger.txt         | 28 ---------------
 .../power/supply/max77650-charger.yaml        | 34 +++++++++++++++++++
 2 files changed, 34 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
deleted file mode 100644
index e6d0fb6ff94e..000000000000
--- a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
+++ /dev/null
@@ -1,28 +0,0 @@
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
diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.yaml b/Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
new file mode 100644
index 000000000000..a48054cc87cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
@@ -0,0 +1,34 @@
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
-- 
2.23.0

