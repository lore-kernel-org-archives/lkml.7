Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6686721881
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfHZWxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:53:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41469 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfHZWwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2NqN-0006ln-5R; Tue, 27 Aug 2019 00:52:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE5631C0DD7;
        Tue, 27 Aug 2019 00:52:10 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:10 -0000
From:   tip-bot2 for Maxime Ripard <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Convert Allwinner A10 Timer to
 a schema
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685993061.1282.7365267831454567798.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a08bda2d27f271aacc92b75f4f260d3136cf6f58
Gitweb:        https://git.kernel.org/tip/a08bda2d27f271aacc92b75f4f260d3136cf6f58
Author:        Maxime Ripard <maxime.ripard@bootlin.com>
AuthorDate:    Mon, 22 Jul 2019 10:12:19 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

dt-bindings: timer: Convert Allwinner A10 Timer to a schema

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
 Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt      | 19 +------------------
 2 files changed, 76 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
new file mode 100644
index 0000000..7292a42
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
index 3da9d51..0000000
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
