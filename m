Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A9FCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3321C2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571674444;
	bh=AhhIphrZsU3paG9gZNMFHkP/psYcmn6qJp+VffmvIEY=;
	h=From:To:Subject:Date:List-ID:From;
	b=zgnNyeKp25ift1vFgOA49T9dlbHqucu0Z+wk3a0ba0pWWAaAfMG32iojVvNuz7JeK
	 VIjCvx29YLhYTvDEDz9/1lZ0yWwwIN7iDHuhToJJfVQwKEovfEwwUtdAc97pIaQqyP
	 duf/gRf0tGmN6AeIpdGmjP8u3T+dUuTJoTo4XHwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfJUQOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfJUQOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:14:03 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42C6205C9;
        Mon, 21 Oct 2019 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674441;
        bh=AhhIphrZsU3paG9gZNMFHkP/psYcmn6qJp+VffmvIEY=;
        h=From:To:Subject:Date:From;
        b=r5WmYoWArKeRJ9JBETnn7vJcPTlYi52FsWKlrAUMdMO/o9LqGXBVmt1G+fUs2Nvy6
         lbx5ERpAc5JcZtjkg8fOfXHDiioPKCTHP9vRt0fBdX/WCigfWGMDKNQPjNfoYHfWsU
         unkDVSkO5xu3hdACaUTcmR2Bp168UNbGO3UzWyEQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v4 1/7] dt-bindings: sram: Convert SRAM bindings to json-schema
Date:   Mon, 21 Oct 2019 18:13:45 +0200
Message-Id: <20191021161351.20789-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert generic mmio-sram bindings to DT schema format using
json-schema.  Require the address/size cells to be 1, not equal to root
node.  This also fixes the check for clocks property to be in main root
node instead of children.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Integrate Samsung SRAM bindings here,
2. Move 'clocks' one level up (error in previous bindings),
3. Add 'additionalProperties: false',
4. Fix names of children in examples,
5. Fix children nodes address pattern,
6. Address other review comments

Changes since v2:
1. Add Rob as maintainer,
2. Use "contains" for compatible,
3. Fix address and size cells to 1,
4. Add maxitems to reg under children,
5. Remove unneeded string type from label.

Changes since v1:
1. Indent example with four spaces (more readable).
---
 .../devicetree/bindings/sram/sram.txt         |  80 ----------
 .../devicetree/bindings/sram/sram.yaml        | 137 ++++++++++++++++++
 2 files changed, 137 insertions(+), 80 deletions(-)
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
index 000000000000..d338fcaa21ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sram/sram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic on-chip SRAM
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
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
+    contains:
+      enum:
+        - mmio-sram
+        - atmel,sama5d2-securam
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      A list of phandle and clock specifier pair that controls the single
+      SRAM clock.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
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
+patternProperties:
+  "^([a-z]*-)?sram@[a-f0-9]+$":
+    type: object
+    description:
+      Each child of the sram node specifies a region of reserved memory.
+    properties:
+      compatible:
+        description:
+          Should contain a vendor specific string in the form
+          <vendor>,[<device>-]<usage>
+
+      reg:
+        description:
+          IO mem address range, relative to the SRAM range.
+        maxItems: 1
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
+        description:
+          The name for the reserved partition, if omitted, the label is taken
+          from the node name excluding the unit address.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    sram@5c000000 {
+        compatible = "mmio-sram";
+        reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x5c000000 0x40000>;
+
+        smp-sram@100 {
+            compatible = "socvendor,smp-sram";
+            reg = <0x100 0x50>;
+        };
+
+        device-sram@1000 {
+            reg = <0x1000 0x1000>;
+            pool;
+        };
+
+        exported-sram@20000 {
+            reg = <0x20000 0x20000>;
+            export;
+        };
+    };
-- 
2.17.1

