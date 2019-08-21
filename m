Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFDEC3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E5222CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfHUHHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:07:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:11736 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfHUHHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:07:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 00:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="178418939"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2019 00:06:59 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 1/2] dt-bindings: serial: lantiq: Convert to YAML schema
Date:   Wed, 21 Aug 2019 15:06:51 +0800
Message-Id: <b8e0fa2981176dba29cd8e29f14532501cf962b4.1566370151.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the existing DT binding document for Lantiq SoC ASC serial controller
from txt format to YAML format.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/serial/lantiq,asc.yaml     | 55 ++++++++++++++++++++++
 .../devicetree/bindings/serial/lantiq_asc.txt      | 31 ------------
 2 files changed, 55 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt

diff --git a/Documentation/devicetree/bindings/serial/lantiq,asc.yaml b/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
new file mode 100644
index 000000000000..72ea2a3d75c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/lantiq,asc.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/lantiq,asc.yaml#
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
+    enum:
+      - lantiq,asc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 3
+
+  clocks:
+    items:
+      - description: phandle to the frequency clock
+      - description: phandle to the gate clock
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
+...
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
-- 
2.11.0

