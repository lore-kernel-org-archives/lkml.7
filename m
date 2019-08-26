Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535FAC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1748A2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6sh4qDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfHZUoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:44:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34162 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbfHZUoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:44:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so16621613wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fw7X0u9RSVpb9YP6GvJgpnhL1eZP3GnuovkdNKVahNQ=;
        b=l6sh4qDylt4FBGKZbeZbgdchgf+Ftcthdvk7xzUqt1v1xshu0jydYLG40UO/b9oXc4
         qsqbemoS4PVcuf0R1a+fcHbHXAJQe9PO5cq8UIcT7hRO8CxZSTmign0nSdfQhUu7fiZs
         Ms4ELGQ8eo5W1GDUT3mW3f57i3861kIE7zKLLD814esraGpUpxp8a1SNweInJCPEGwy6
         oD0q5ysgRBsCv1Qtksz98fu14zSZCdrq1hvnkz2RGUf5Oq3tqjIN2Rq4CGqrB20NHFwl
         UN4pC8rK2b/aqkRqY8aVpzUxULN2VbdJ1xSSPUls0YzvKhNNNg9ogsc4C72ylII9owiF
         IMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fw7X0u9RSVpb9YP6GvJgpnhL1eZP3GnuovkdNKVahNQ=;
        b=OsymPg9MNsR8fVUiFytNytZx/ZvawYPKxWuVpBeVGJIou5nW6uPL0dNBHSvmOs2e17
         d34qn8B2jkPGTb6eVgrmxqBxfQBje9PnJWWJEfT7Uma5ZL0CfhSGtxUPZG9x11K+WbEn
         tew2QcnllQ06PY2GdIyGS9xAE2FgxTWLHBl7qJBk2UaVQHR7zN1x/6RcY17A4tPJpfBH
         qzftGMI/qJ0hg0XQgWhLvRtL7PAvxuoxDwoCNlnXIPQoryAD5lDv/UXJmymO6o+hD2RS
         s6ryFWF8Fqf373/bax7kB3AdG1tLzC2WmsX2SWsjMipR5MZmr1QeTfgDUefr4eCi1RkG
         2JKw==
X-Gm-Message-State: APjAAAX5AbDAx4snnmd6a+syejGIrgaBXagI/3RBHxvKf2XN5RBx+Wmy
        r6pqAHZ7U1aY/aWZTIasZD9Ytg==
X-Google-Smtp-Source: APXvYqzj79VdjmpatQooDLN5wdRSkNJ6Zpyso4T8UmaJwAtECyLsZt/J81BWLl/nWJE/nyibmLpEWg==
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr23996401wrw.228.1566852281822;
        Mon, 26 Aug 2019 13:44:41 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:44:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 02/20] dt-bindings: timer: Convert Allwinner A10 Timer to a schema
Date:   Mon, 26 Aug 2019 22:43:49 +0200
Message-Id: <20190826204407.17759-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The older Allwinner SoCs have a Timer supported in Linux, with a matching
Device Tree binding.

While the original binding only mentions one interrupt, the timer actually
has 6 of them.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../timer/allwinner,sun4i-a10-timer.yaml      | 76 +++++++++++++++++++
 .../bindings/timer/allwinner,sun4i-timer.txt  | 19 -----
 2 files changed, 76 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
new file mode 100644
index 000000000000..7292a424092c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/allwinner,sun4i-a10-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 Timer Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun4i-a10-timer
+      - allwinner,suniv-f1c100s-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      List of timers interrupts
+
+  clocks:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          items:
+            const: allwinner,sun4i-a10-timer
+
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          items:
+            const: allwinner,suniv-f1c100s-timer
+
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer {
+        compatible = "allwinner,sun4i-a10-timer";
+        reg = <0x01c20c00 0x400>;
+        interrupts = <22>,
+                     <23>,
+                     <24>,
+                     <25>,
+                     <67>,
+                     <68>;
+        clocks = <&osc>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
deleted file mode 100644
index 3da9d515c03a..000000000000
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Allwinner A1X SoCs Timer Controller
-
-Required properties:
-
-- compatible : should be one of the following:
-              "allwinner,sun4i-a10-timer"
-              "allwinner,suniv-f1c100s-timer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : The interrupt of the first timer
-- clocks: phandle to the source clock (usually a 24 MHz fixed clock)
-
-Example:
-
-timer {
-	compatible = "allwinner,sun4i-a10-timer";
-	reg = <0x01c20c00 0x400>;
-	interrupts = <22>;
-	clocks = <&osc>;
-};
-- 
2.17.1

