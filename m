Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74301C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5227420843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfHNIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:22:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:64644 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNIWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:22:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 01:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,384,1559545200"; 
   d="scan'208";a="205418010"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2019 01:22:42 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 1/2] dt-bindings: serial: lantiq: Convert to YAML schema
Date:   Wed, 14 Aug 2019 16:22:34 +0800
Message-Id: <de9516442123202e02e195094bd04e8234feb2c9.1565770074.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
References: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
References: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the existing DT binding document for Lantiq SoC ASC serial controller
from txt format to YAML format.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/serial/lantiq_asc.txt      | 31 ----------
 .../devicetree/bindings/serial/lantiq_asc.yaml     | 70 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.yaml

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
deleted file mode 100644
index 40e81a5818f6..000000000000
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Lantiq SoC ASC serial controller
-
-Required properties:
-- compatible : Should be "lantiq,asc"
-- reg : Address and length of the register set for the device
-- interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
-  depends on the interrupt-parent interrupt controller.
-
-Optional properties:
-- clocks: Should contain frequency clock and gate clock
-- clock-names: Should be "freq" and "asc"
-
-Example:
-
-asc0: serial@16600000 {
-	compatible = "lantiq,asc";
-	reg = <0x16600000 0x100000>;
-	interrupt-parent = <&gic>;
-	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
-		<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
-		<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
-	clock-names = "freq", "asc";
-};
-
-asc1: serial@e100c00 {
-	compatible = "lantiq,asc";
-	reg = <0xE100C00 0x400>;
-	interrupt-parent = <&icu0>;
-	interrupts = <112 113 114>;
-};
diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
new file mode 100644
index 000000000000..9757f0a24232
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/lantiq_asc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq SoC ASC serial controller
+
+maintainers:
+  - Rahul Tanwar <rahul.tanwar@intel.com>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      items:
+        - const: lantiq,asc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+    items:
+      - description: tx or combined interrupt
+      - description: rx interrupt
+      - description: err interrupt
+
+  clocks:
+    description:
+      When present, first entry listed should contain phandle
+      to the frequency clock and second entry should contain
+      phandle to the gate clock.
+
+  clock-names:
+    items:
+      - const: freq
+      - const: asc
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+
+examples:
+  - |
+    asc0: serial@16600000 {
+            compatible = "lantiq,asc";
+            reg = <0x16600000 0x100000>;
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
+            clock-names = "freq", "asc";
+    };
+
+  - |
+    asc1: serial@e100c00 {
+            compatible = "lantiq,asc";
+            reg = <0xE100C00 0x400>;
+            interrupt-parent = <&icu0>;
+            interrupts = <112 113 114>;
+    };
+
+...
-- 
2.11.0

