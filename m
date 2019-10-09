Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB95ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F180021920
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbfJIWkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:40:40 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46371 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbfJIWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:40:13 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D0D55C0003;
        Wed,  9 Oct 2019 22:40:11 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/8] dt-bindings: mfd: atmel,at91rm9200-tcb: add sama5d2 compatible
Date:   Thu, 10 Oct 2019 00:40:00 +0200
Message-Id: <20191009224006.5021-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
References: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sama5d2 TC block TIMER_CLOCK1 is different from the at91sam9x5 one.
Instead of being MCK / 2, it is the TCB GCLK.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Cc: Rob Herring <robh+dt@kernel.org>

 .../bindings/mfd/atmel,at91rm9200-tcb.yaml    | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml
index 4d9247fc0593..4fc5bd34d38b 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - atmel,at91rm9200-tcb
           - atmel,at91sam9x5-tcb
+          - atmel,sama5d2-tcb
       - const: simple-mfd
       - const: syscon
 
@@ -38,12 +39,6 @@ properties:
       t1_clk and t2_clk if a clock per channel is available.
     minItems: 2
     maxItems: 4
-    items:
-      enum:
-        - t0_clk
-        - t1_clk
-        - t2_clk
-        - slow_clk
 
   clocks:
     minItems: 2
@@ -55,6 +50,35 @@ properties:
   '#size-cells':
     const: 0
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: atmel,sama5d2-tcb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: t0_clk
+            - const: gclk
+            - const: slow_clk
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 4
+        clock-names:
+          items:
+            enum:
+              - t0_clk
+              - t1_clk
+              - t2_clk
+              - slow_clk
+
 required:
   - compatible
   - reg
-- 
2.21.0

