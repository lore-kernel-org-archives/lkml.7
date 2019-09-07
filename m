Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303FC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 11:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EC4208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 11:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567856153;
	bh=VOxfcQzwaHM0XiCY/XXEfAZTtrIlO4ZRE/buwNFjUxw=;
	h=From:To:Subject:Date:List-ID:From;
	b=TIwHwiCVNQS2FLMR/Owlgya92q2F0jY2fvHvva+ytN7Eyj5gElhjMcO8l0+y+wNOy
	 yzyaBCurKZ+dUXAv5Afcjof+RdxK5TglgzXcOoeFg7zzMLt0paU9aK5YMtFk4Z8ZoN
	 MEZEZUes29xi/JGSNOoTWtlbWZ7dS4Vvct5H/inI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391537AbfIGLfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 07:35:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfIGLfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 07:35:52 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DAC7218AF;
        Sat,  7 Sep 2019 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567856150;
        bh=VOxfcQzwaHM0XiCY/XXEfAZTtrIlO4ZRE/buwNFjUxw=;
        h=From:To:Subject:Date:From;
        b=ejMPHeZ+1HnqQoRFodV1DvPkSbS+FqzcmIxBykf0WA1uM+9HbpjaRmMlaOpC9cJgL
         ZVOfVsg+SYi50sBYI2nOlLJZ4cYLNyb3CTrLZrjEl4huwCmVRExS83gOS/25v6oqRn
         p38pReB5ObKwZwQoK7QIUNdasAocnM3c68oh4ZX8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: sram: Convert SRAM bindings to json-schema
Date:   Sat,  7 Sep 2019 13:35:41 +0200
Message-Id: <20190907113542.4096-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert generic mmio-sram bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/sram/sram.txt         |  80 ----------
 .../devicetree/bindings/sram/sram.yaml        | 138 ++++++++++++++++++
 2 files changed, 138 insertions(+), 80 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/sram.txt
 create mode 100644 Documentation/devicetree/bindings/sram/sram.yaml

diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
deleted file mode 100644
index e98908bd4227..000000000000
--- a/Documentation/devicetree/bindings/sram/sram.txt
+++ /dev/null
@@ -1,80 +0,0 @@
-Generic on-chip SRAM
-
-Simple IO memory regions to be managed by the genalloc API.
-
-Required properties:
-
-- compatible : mmio-sram or atmel,sama5d2-securam
-
-- reg : SRAM iomem address range
-
-Reserving sram areas:
----------------------
-
-Each child of the sram node specifies a region of reserved memory. Each
-child node should use a 'reg' property to specify a specific range of
-reserved memory.
-
-Following the generic-names recommended practice, node names should
-reflect the purpose of the node. Unit address (@<address>) should be
-appended to the name.
-
-Required properties in the sram node:
-
-- #address-cells, #size-cells : should use the same values as the root node
-- ranges : standard definition, should translate from local addresses
-           within the sram to bus addresses
-
-Optional properties in the sram node:
-
-- no-memory-wc : the flag indicating, that SRAM memory region has not to
-                 be remapped as write combining. WC is used by default.
-
-Required properties in the area nodes:
-
-- reg : iomem address range, relative to the SRAM range
-
-Optional properties in the area nodes:
-
-- compatible : standard definition, should contain a vendor specific string
-               in the form <vendor>,[<device>-]<usage>
-- pool : indicates that the particular reserved SRAM area is addressable
-         and in use by another device or devices
-- export : indicates that the reserved SRAM area may be accessed outside
-           of the kernel, e.g. by bootloader or userspace
-- protect-exec : Same as 'pool' above but with the additional
-		 constraint that code wil be run from the region and
-		 that the memory is maintained as read-only, executable
-		 during code execution. NOTE: This region must be page
-		 aligned on start and end in order to properly allow
-		 manipulation of the page attributes.
-- label : the name for the reserved partition, if omitted, the label
-          is taken from the node name excluding the unit address.
-- clocks : a list of phandle and clock specifier pair that controls the
-	   single SRAM clock.
-
-Example:
-
-sram: sram@5c000000 {
-	compatible = "mmio-sram";
-	reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
-
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0 0x5c000000 0x40000>;
-
-	smp-sram@100 {
-		compatible = "socvendor,smp-sram";
-		reg = <0x100 0x50>;
-	};
-
-	device-sram@1000 {
-		reg = <0x1000 0x1000>;
-		pool;
-	};
-
-	exported@20000 {
-		reg = <0x20000 0x20000>;
-		export;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
new file mode 100644
index 000000000000..0821cdb4cef9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sram/sram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic on-chip SRAM
+
+maintainers:
+  - FIXME <who@should.it.be>
+
+description: |+
+  Simple IO memory regions to be managed by the genalloc API.
+
+  Each child of the sram node specifies a region of reserved memory. Each
+  child node should use a 'reg' property to specify a specific range of
+  reserved memory.
+
+  Following the generic-names recommended practice, node names should
+  reflect the purpose of the node. Unit address (@<address>) should be
+  appended to the name.
+
+properties:
+  $nodename:
+    pattern: "^sram(@.*)?"
+
+  compatible:
+    items:
+      - enum:
+          - mmio-sram
+          - atmel,sama5d2-securam
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    description: Should use the same values as the root node.
+
+  "#size-cells":
+    description: Should use the same values as the root node.
+
+  ranges:
+    description:
+      Should translate from local addresses within the sram to bus addresses.
+
+  no-memory-wc:
+    description:
+      The flag indicating, that SRAM memory region has not to be remapped
+      as write combining. WC is used by default.
+    type: boolean
+
+  # TODO: additionalProperties: false
+
+patternProperties:
+  "^([a-z]*-)?sram@[a-f0-9]$":
+    type: object
+    description:
+      Each child of the sram node specifies a region of reserved memory.
+    properties:
+      reg:
+        description:
+          IO mem address range, relative to the SRAM range.
+
+      compatible:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          Should contain a vendor specific string in the form
+          <vendor>,[<device>-]<usage>
+
+      pool:
+        description:
+          Indicates that the particular reserved SRAM area is addressable
+          and in use by another device or devices.
+        type: boolean
+
+      export:
+        description:
+          Indicates that the reserved SRAM area may be accessed outside
+          of the kernel, e.g. by bootloader or userspace.
+        type: boolean
+
+      protect-exec:
+        description: |
+          Same as 'pool' above but with the additional constraint that code
+          will be run from the region and that the memory is maintained as
+          read-only, executable during code execution. NOTE: This region must
+          be page aligned on start and end in order to properly allow
+          manipulation of the page attributes.
+        type: boolean
+
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          The name for the reserved partition, if omitted, the label is taken
+          from the node name excluding the unit address.
+
+      clocks:
+        description:
+          A list of phandle and clock specifier pair that controls the
+          single SRAM clock.
+
+      # TODO: additionalProperties: false
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+examples:
+  - |
+    sram: sram@5c000000 {
+      compatible = "mmio-sram";
+      reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x5c000000 0x40000>;
+
+      smp-sram@100 {
+        compatible = "socvendor,smp-sram";
+        reg = <0x100 0x50>;
+      };
+
+      device-sram@1000 {
+        reg = <0x1000 0x1000>;
+        pool;
+      };
+
+      exported@20000 {
+        reg = <0x20000 0x20000>;
+        export;
+      };
+    };
-- 
2.17.1

