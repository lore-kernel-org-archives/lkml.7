Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB37CA9ED2
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3D9214B2
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572796884;
	bh=ltTqN0B/R+pEdxmuWRoWrrtTRWlzTt6eMa88sa/Ypxg=;
	h=From:To:Subject:Date:List-ID:From;
	b=pWdlnTGde6TD5NzaLkoZVJb9XfFN8gc1Yh7PNSgmYfkCNv8yKwweO9rfJb40nogmq
	 GE2433+dYNC7jEd72gpA46DDvOJyDK4qJ93lQe2gv6yL97O26+Z3fsdDvhNbzuyAzH
	 LLu99gs8JGwLn5eWq1j0E4rMiX0RPjuBCKKLUcCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfKCQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfKCQBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:01:22 -0500
Received: from localhost.localdomain (unknown [194.230.155.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7EFF2080F;
        Sun,  3 Nov 2019 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572796880;
        bh=ltTqN0B/R+pEdxmuWRoWrrtTRWlzTt6eMa88sa/Ypxg=;
        h=From:To:Subject:Date:From;
        b=tcbzxuzQGDpk0C/tC0ODHIP4kdGJKYY6eQibJ8pKdl5w9T0UnJxtbMQlY/qUFTDXA
         hN2U3poojPG6MWlyaLnI41p/x2hfibLXKer+RYk//46HaYgf7R63Ez2g2HuXI9lQWo
         U/iiHBmQeh9dOfq08FeJe4OPpwJowfHh/nsq3UGE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: Convert Samsung UART bindings to json-schema
Date:   Sun,  3 Nov 2019 17:01:12 +0100
Message-Id: <20191103160112.10764-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung S3C/S5P/Exynos Serial/UART bindings to DT schema format
using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Simplify 'clock-names' patters after Rob's suggestions,
2. Add description to 'interrupts',
3. Remove 'uniqueItems' where not needed,
4. Remove aliases from example.
---
 .../bindings/mfd/samsung,exynos5433-lpass.txt |   2 +-
 .../bindings/serial/samsung_uart.txt          |  58 ---------
 .../bindings/serial/samsung_uart.yaml         | 118 ++++++++++++++++++
 3 files changed, 119 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.yaml

diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
index d759da606f75..30ea27c3936d 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
+++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
@@ -18,7 +18,7 @@ an optional sub-node. For "samsung,exynos5433-lpass" compatible this includes:
 UART, SLIMBUS, PCM, I2S, DMAC, Timers 0...4, VIC, WDT 0...1 devices.
 
 Bindings of the sub-nodes are described in:
-  ../serial/samsung_uart.txt
+  ../serial/samsung_uart.yaml
   ../sound/samsung-i2s.txt
   ../dma/arm-pl330.txt
 
diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
deleted file mode 100644
index e85f37ec33f0..000000000000
--- a/Documentation/devicetree/bindings/serial/samsung_uart.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Samsung's UART Controller
-
-The Samsung's UART controller is used for interfacing SoC with serial
-communicaion devices.
-
-Required properties:
-- compatible: should be one of following:
-  - "samsung,exynos4210-uart" -  Exynos4210 SoC,
-  - "samsung,s3c2410-uart" - compatible with ports present on S3C2410 SoC,
-  - "samsung,s3c2412-uart" - compatible with ports present on S3C2412 SoC,
-  - "samsung,s3c2440-uart" - compatible with ports present on S3C2440 SoC,
-  - "samsung,s3c6400-uart" - compatible with ports present on S3C6400 SoC,
-  - "samsung,s5pv210-uart" - compatible with ports present on S5PV210 SoC.
-
-- reg: base physical address of the controller and length of memory mapped
-  region.
-
-- interrupts: a single interrupt signal to SoC interrupt controller,
-  according to interrupt bindings documentation [1].
-
-- clock-names: input names of clocks used by the controller:
-  - "uart" - controller bus clock,
-  - "clk_uart_baudN" - Nth baud base clock input (N = 0, 1, ...),
-    according to SoC User's Manual (only N = 0 is allowedfor SoCs without
-    internal baud clock mux).
-- clocks: phandles and specifiers for all clocks specified in "clock-names"
-  property, in the same order, according to clock bindings documentation [2].
-
-[1] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Optional properties:
-- samsung,uart-fifosize: The fifo size supported by the UART channel
-
-Note: Each Samsung UART should have an alias correctly numbered in the
-"aliases" node, according to serialN format, where N is the port number
-(non-negative decimal integer) as specified by User's Manual of respective
-SoC.
-
-Example:
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-	};
-
-Example:
-	uart1: serial@7f005400 {
-		compatible = "samsung,s3c6400-uart";
-		reg = <0x7f005400 0x100>;
-		interrupt-parent = <&vic1>;
-		interrupts = <6>;
-		clock-names = "uart", "clk_uart_baud2",
-				"clk_uart_baud3";
-		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
-				<&clocks SCLK_UART>;
-		samsung,uart-fifosize = <16>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
new file mode 100644
index 000000000000..9d2ce347875b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/samsung_uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S3C, S5P and Exynos SoC UART Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+description: |+
+  Each Samsung UART should have an alias correctly numbered in the "aliases"
+  node, according to serialN format, where N is the port number (non-negative
+  decimal integer) as specified by User's Manual of respective SoC.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - samsung,s3c2410-uart
+          - samsung,s3c2412-uart
+          - samsung,s3c2440-uart
+          - samsung,s3c6400-uart
+          - samsung,s5pv210-uart
+          - samsung,exynos4210-uart
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 5
+
+  clock-names:
+    description: N = 0 is allowed for SoCs without internal baud clock mux.
+    minItems: 2
+    maxItems: 5
+    items:
+      - const: uart
+      - pattern: '^clk_uart_baud[0-3]$'
+      - pattern: '^clk_uart_baud[0-3]$'
+      - pattern: '^clk_uart_baud[0-3]$'
+      - pattern: '^clk_uart_baud[0-3]$'
+
+  interrupts:
+    description: RX interrupt and optionally TX interrupt.
+    minItems: 1
+    maxItems: 2
+
+  samsung,uart-fifosize:
+    description: The fifo size supported by the UART channel.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [16, 64, 256]
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s3c2410-uart
+              - samsung,s5pv210-uart
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 3
+        clock-names:
+          minItems: 2
+          maxItems: 3
+          items:
+            - const: uart
+            - pattern: '^clk_uart_baud[0-1]$'
+            - pattern: '^clk_uart_baud[0-1]$'
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos4210-uart
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+          items:
+            - const: uart
+            - const: clk_uart_baud0
+
+examples:
+  - |
+    #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
+
+    uart0: serial@7f005000 {
+        compatible = "samsung,s3c6400-uart";
+        reg = <0x7f005000 0x100>;
+        interrupt-parent = <&vic1>;
+        interrupts = <5>;
+        clock-names = "uart", "clk_uart_baud2",
+                      "clk_uart_baud3";
+        clocks = <&clocks PCLK_UART0>, <&clocks PCLK_UART0>,
+                 <&clocks SCLK_UART>;
+        samsung,uart-fifosize = <16>;
+    };
-- 
2.17.1

