Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C039C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E0C2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLTH2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:28:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:33860 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfLTH2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:28:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 23:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="366320984"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2019 23:28:31 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 1/2] dt-bindings: phy: Add YAML schemas for Intel Combo phy
Date:   Fri, 20 Dec 2019 15:28:27 +0800
Message-Id: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combo phy subsystem provides PHY support to number of
controllers, viz. PCIe, SATA and EMAC.
Adding YAML schemas for the same.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
new file mode 100644
index 000000000000..fc9cbad9dd88
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Combo phy Subsystem
+
+maintainers:
+  - Dilip Kota <eswara.kota@linux.intel.com>
+
+description: |
+  Intel combo phy subsystem supports PHYs for PCIe, EMAC and SATA
+  controllers. A single combo phy provides two PHY instances.
+
+properties:
+  $nodename:
+    pattern: "^combophy@[0-9]+$"
+
+  compatible:
+    items:
+      - const: intel,combo-phy
+      - const: simple-bus
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Index of Combo phy hardware instance.
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy
+      - const: core
+
+  intel,syscfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Chip configuration registers handle
+
+  intel,hsio:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: HSIO registers handle
+
+  intel,bid:
+    description: Index of HSIO bus
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 1
+
+  intel,cap-pcie-only:
+    description: |
+      This flag specifies capability of the combo phy.
+      If it is set, combo phy has only PCIe capability.
+      Else it has PCIe, XPCS and SATA PHY capabilities.
+    type: boolean
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^cb[0-9]phy@[0-9]+$":
+    type: object
+
+    properties:
+      compatible:
+        const: intel,phydev
+
+      "#phy-cells":
+        const: 0
+
+      reg:
+        description: Offset and size of pcie phy control registers
+
+      intel,phy-mode:
+        description: |
+          Configure the mode of the PHY.
+            0 - PCIe
+            1 - xpcs
+            2 - sata
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 0
+          - maximum: 2
+
+      clocks:
+        description: |
+          List of phandle and clock specifier pairs as listed
+          in clock-names property. Configure the clocks according
+          to the PHY mode.
+
+      resets:
+        description: |
+          reset handle according to the PHY mode.
+          See ../reset/reset.txt for details.
+
+    required:
+      - compatible
+      - reg
+      - "#phy-cells"
+      - clocks
+      - intel,phy-mode
+
+required:
+  - compatible
+  - cell-index
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - intel,syscfg
+  - intel,hsio
+  - intel,bid
+
+additionalProperties: false
+
+examples:
+  - |
+    combophy@0 {
+        compatible = "intel,combo-phy", "simple-bus";
+        cell-index = <0>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        resets = <&rcu0 0x50 6>,
+        	 <&rcu0 0x50 17>;
+        reset-names = "phy", "core";
+        intel,syscfg = <&sysconf>;
+        intel,hsio = <&hsiol>;
+        intel,bid = <0>;
+
+        cb0phy0:cb0phy@0 {
+            compatible = "intel,phydev";
+            #phy-cells = <0>;
+            reg = <0xd0a40000 0x1000>;
+            clocks = <&cgu0 1>;
+            resets = <&rcu0 0x50 23>;
+            intel,phy-mode = <0>;
+        };
+    };
+
+
-- 
2.11.0

