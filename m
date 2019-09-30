Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE2BC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9238E21920
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569858270;
	bh=1kdbnX7TO0/qLagVQ8yuRxQAY82sAoc3bewWd9/ZJ/w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xjzdKqz0DliqRpTWsOgVYG6tWth6kOK8M5wV6gUlzF8ddPruOOD+bxNvaoFwCa1c1
	 TpFJfVxjXEs4l4j0p+J1mQqMLe3NfBQxrcIdq3tntynXc3b8OoAFsclHyorvQA2jq2
	 gbJC8QeOzu2V5khAJRzNNeLUo+tAbCt2MWbiIT90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfI3Poa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfI3Po3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:44:29 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49C1206BB;
        Mon, 30 Sep 2019 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569858268;
        bh=1kdbnX7TO0/qLagVQ8yuRxQAY82sAoc3bewWd9/ZJ/w=;
        h=From:To:Cc:Subject:Date:From;
        b=vqhtTTd+DyJLZz3bwFsKEtSp21IqK/em5bD7T3hFuhhQXMrWmc1dpGY6BmK5OL16U
         +bPEwsGELbZFFpAoEEoboFZUIsroVDJo8MXfKgIGuhRJPtRXidwutvZ+yJE8EHTsJw
         u1GOpPt1Q1CiHkRPrFH1OgYJNiSZIwddQgkVBekI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 1/2] dt-bindings: timer: Convert Exynos MCT bindings to json-schema
Date:   Mon, 30 Sep 2019 17:44:17 +0200
Message-Id: <20190930154418.4884-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos Soc Multi Core Timer bindings to DT schema format
using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v4:
1. Do not mention interrupts-extended in the bindings (old bindings
   mentioned only interrupts).

Changes since v3:
1. Use interrupts-extended instead of interrupts-map in example.

Changes since v1:
1. Indent example with four spaces (more readable),
2. Rename nodes in example to timer,
3. Remove mct-map subnode.
---
 .../bindings/timer/samsung,exynos4210-mct.txt |  88 --------------
 .../timer/samsung,exynos4210-mct.yaml         | 107 ++++++++++++++++++
 2 files changed, 107 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
 create mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
deleted file mode 100644
index 8f78640ad64c..000000000000
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
+++ /dev/null
@@ -1,88 +0,0 @@
-Samsung's Multi Core Timer (MCT)
-
-The Samsung's Multi Core Timer (MCT) module includes two main blocks, the
-global timer and CPU local timers. The global timer is a 64-bit free running
-up-counter and can generate 4 interrupts when the counter reaches one of the
-four preset counter values. The CPU local timers are 32-bit free running
-down-counters and generate an interrupt when the counter expires. There is
-one CPU local timer instantiated in MCT for every CPU in the system.
-
-Required properties:
-
-- compatible: should be "samsung,exynos4210-mct".
-  (a) "samsung,exynos4210-mct", for mct compatible with Exynos4210 mct.
-  (b) "samsung,exynos4412-mct", for mct compatible with Exynos4412 mct.
-
-- reg: base address of the mct controller and length of the address space
-  it occupies.
-
-- interrupts: the list of interrupts generated by the controller. The following
-  should be the order of the interrupts specified. The local timer interrupts
-  should be specified after the four global timer interrupts have been
-  specified.
-
-	0: Global Timer Interrupt 0
-	1: Global Timer Interrupt 1
-	2: Global Timer Interrupt 2
-	3: Global Timer Interrupt 3
-	4: Local Timer Interrupt 0
-	5: Local Timer Interrupt 1
-	6: ..
-	7: ..
-	i: Local Timer Interrupt n
-
-  For MCT block that uses a per-processor interrupt for local timers, such
-  as ones compatible with "samsung,exynos4412-mct", only one local timer
-  interrupt might be specified, meaning that all local timers use the same
-  per processor interrupt.
-
-Example 1: In this example, the IP contains two local timers, using separate
-	   interrupts, so two local timer interrupts have been specified,
-	   in addition to four global timer interrupts.
-
-	mct@10050000 {
-		compatible = "samsung,exynos4210-mct";
-		reg = <0x10050000 0x800>;
-		interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
-			     <0 42 0>, <0 48 0>;
-	};
-
-Example 2: In this example, the timer interrupts are connected to two separate
-	   interrupt controllers. Hence, an interrupt-map is created to map
-	   the interrupts to the respective interrupt controllers.
-
-	mct@101c0000 {
-		compatible = "samsung,exynos4210-mct";
-		reg = <0x101C0000 0x800>;
-		interrupt-parent = <&mct_map>;
-		interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
-
-		mct_map: mct-map {
-			#interrupt-cells = <1>;
-			#address-cells = <0>;
-			#size-cells = <0>;
-			interrupt-map = <0 &gic 0 57 0>,
-					<1 &gic 0 69 0>,
-					<2 &combiner 12 6>,
-					<3 &combiner 12 7>,
-					<4 &gic 0 42 0>,
-					<5 &gic 0 48 0>;
-		};
-	};
-
-Example 3: In this example, the IP contains four local timers, but using
-	   a per-processor interrupt to handle them. Either all the local
-	   timer interrupts can be specified, with the same interrupt specifier
-	   value or just the first one.
-
-	mct@10050000 {
-		compatible = "samsung,exynos4412-mct";
-		reg = <0x10050000 0x800>;
-
-		/* Both ways are possible in this case. Either: */
-		interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
-			     <0 42 0>;
-		/* or: */
-		interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
-			     <0 42 0>, <0 42 0>, <0 42 0>, <0 42 0>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
new file mode 100644
index 000000000000..3e26fd5e235a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/samsung,exynos4210-mct.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Multi Core Timer (MCT)
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |+
+  The Samsung's Multi Core Timer (MCT) module includes two main blocks, the
+  global timer and CPU local timers. The global timer is a 64-bit free running
+  up-counter and can generate 4 interrupts when the counter reaches one of the
+  four preset counter values. The CPU local timers are 32-bit free running
+  down-counters and generate an interrupt when the counter expires. There is
+  one CPU local timer instantiated in MCT for every CPU in the system.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4210-mct
+      - samsung,exynos4412-mct
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Interrupts should be put in specific order. This is, the local timer
+      interrupts should be specified after the four global timer interrupts
+      have been specified:
+      0: Global Timer Interrupt 0
+      1: Global Timer Interrupt 1
+      2: Global Timer Interrupt 2
+      3: Global Timer Interrupt 3
+      4: Local Timer Interrupt 0
+      5: Local Timer Interrupt 1
+      6: ..
+      7: ..
+      i: Local Timer Interrupt n
+      For MCT block that uses a per-processor interrupt for local timers, such
+      as ones compatible with "samsung,exynos4412-mct", only one local timer
+      interrupt might be specified, meaning that all local timers use the same
+      per processor interrupt.
+    minItems: 5               # 4 Global + 1 local
+    maxItems: 20              # 4 Global + 16 local
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+examples:
+  - |
+    // In this example, the IP contains two local timers, using separate
+    // interrupts, so two local timer interrupts have been specified,
+    // in addition to four global timer interrupts.
+
+    timer@10050000 {
+        compatible = "samsung,exynos4210-mct";
+        reg = <0x10050000 0x800>;
+        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
+                     <0 42 0>, <0 48 0>;
+    };
+
+  - |
+    // In this example, the timer interrupts are connected to two separate
+    // interrupt controllers. Hence, an interrupts-extended is needed.
+
+    timer@101c0000 {
+        compatible = "samsung,exynos4210-mct";
+        reg = <0x101C0000 0x800>;
+        interrupts-extended = <&gic 0 57 0>,
+                              <&gic 0 69 0>,
+                              <&combiner 12 6>,
+                              <&combiner 12 7>,
+                              <&gic 0 42 0>,
+                              <&gic 0 48 0>;
+    };
+
+  - |
+    // In this example, the IP contains four local timers, but using
+    // a per-processor interrupt to handle them. Only one first local
+    // interrupt is specified.
+
+    timer@10050000 {
+        compatible = "samsung,exynos4412-mct";
+        reg = <0x10050000 0x800>;
+
+        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
+                     <0 42 0>;
+    };
+
+  - |
+    // In this example, the IP contains four local timers, but using
+    // a per-processor interrupt to handle them. All the local timer
+    // interrupts are specified.
+
+    timer@10050000 {
+        compatible = "samsung,exynos4412-mct";
+        reg = <0x10050000 0x800>;
+
+        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
+                     <0 42 0>, <0 42 0>, <0 42 0>, <0 42 0>;
+    };
-- 
2.17.1

