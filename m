Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D37C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2162075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKKJD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:03:56 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:40286 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727050AbfKKJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:03:54 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xAB939Qg060876
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 11 Nov 2019 17:03:10 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.88) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 11 Nov 2019 17:03:28
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 2/5] dt-bindings: serial: Convert sprd-uart to json-schema
Date:   Mon, 11 Nov 2019 17:02:27 +0800
Message-ID: <20191111090230.3402-3-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.88]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com xAB939Qg060876
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Convert the sprd-uart binding to DT schema using json-schema.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/serial/sprd-uart.txt  | 32 ---------
 .../devicetree/bindings/serial/sprd-uart.yaml | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
deleted file mode 100644
index 9607dc616205..000000000000
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* Spreadtrum serial UART
-
-Required properties:
-- compatible: must be one of:
-  * "sprd,sc9836-uart"
-  * "sprd,sc9860-uart", "sprd,sc9836-uart"
-
-- reg: offset and length of the register set for the device
-- interrupts: exactly one interrupt specifier
-- clock-names: Should contain following entries:
-  "enable" for UART module enable clock,
-  "uart" for UART clock,
-  "source" for UART source (parent) clock.
-- clocks: Should contain a clock specifier for each entry in clock-names.
-  UART clock and source clock are optional properties, but enable clock
-  is required.
-
-Optional properties:
-- dma-names: Should contain "rx" for receive and "tx" for transmit channels.
-- dmas: A list of dma specifiers, one for each entry in dma-names.
-
-Example:
-	uart0: serial@0 {
-		compatible = "sprd,sc9860-uart",
-			     "sprd,sc9836-uart";
-		reg = <0x0 0x100>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-		dma-names = "rx", "tx";
-		dmas = <&ap_dma 19>, <&ap_dma 20>;
-		clock-names = "enable", "uart", "source";
-		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
new file mode 100644
index 000000000000..0cc4668a9b9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/sprd-uart.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Spreadtrum serial UART
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sprd,sc9860-uart
+          - const: sprd,sc9836-uart
+      - const: sprd,sc9836-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    description: "enable" for UART module enable clock, "uart" for UART
+      clock, "source" for UART source (parent) clock.
+    items:
+      - const: enable
+      - const: uart
+      - const: source
+
+  dmas:
+    minItems: 1
+    maxItems: 2
+
+  dma-names:
+    minItems: 1
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    serial@0 {
+      compatible = "sprd,sc9860-uart", "sprd,sc9836-uart";
+      reg = <0x0 0x100>;
+      interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+      dma-names = "rx", "tx";
+      dmas = <&ap_dma 19>, <&ap_dma 20>;
+      clock-names = "enable", "uart", "source";
+      clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
+    };
+
+...
-- 
2.20.1


