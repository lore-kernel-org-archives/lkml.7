Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD484C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17E420678
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKZIfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:35:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:18783 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfKZIff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:35:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 00:35:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="408588394"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2019 00:35:32 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     robh@kernel.org, p.zabel@pengutronix.de,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v4 1/2] dt-bindings: reset: Add YAML schemas for the Intel Reset controller
Date:   Tue, 26 Nov 2019 16:35:17 +0800
Message-Id: <4193fef447c220406ab39225eb3eb66025734cd3.1574755533.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML schemas for the reset controller on Intel
Gateway SoC.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
Changes on v4:
	Address Rob review comments
	  Drop oneOf and items for 'compatible'
	  Add maxItems for 'reg' and 'intel,global-reset'

Changes on v3:
	Fix DTC warnings
	Add support to legacy xrx200 SoC
	Change file name to intel,rcu-gw.yaml

 .../devicetree/bindings/reset/intel,rcu-gw.yaml    | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml

diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
new file mode 100644
index 000000000000..246dea8a2ec9
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/intel,rcu-gw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System Reset Controller on Intel Gateway SoCs
+
+maintainers:
+  - Dilip Kota <eswara.kota@linux.intel.com>
+
+properties:
+  compatible:
+    enum:
+      - intel,rcu-lgm
+      - intel,rcu-xrx200
+
+  reg:
+    description: Reset controller registers.
+    maxItems: 1
+
+  intel,global-reset:
+    description: Global reset register offset and bit offset.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - maxItems: 2
+
+  "#reset-cells":
+    minimum: 2
+    maximum: 3
+    description: |
+      First cell is reset request register offset.
+      Second cell is bit offset in reset request register.
+      Third cell is bit offset in reset status register.
+      Reset cell count is 2 in the case of bit offset in
+      reset request and reset status registers is same.
+      Whereas 3 if bit offset differs.
+
+required:
+  - compatible
+  - reg
+  - intel,global-reset
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    rcu0: reset-controller@e0000000 {
+        compatible = "intel,rcu-lgm";
+        reg = <0xe0000000 0x20000>;
+        intel,global-reset = <0x10 30>;
+        #reset-cells = <2>;
+    };
+
+    pwm: pwm@e0d00000 {
+        status = "disabled";
+        compatible = "intel,lgm-pwm";
+        reg = <0xe0d00000 0x30>;
+        clocks = <&cgu0 1>;
+        #pwm-cells = <2>;
+        resets = <&rcu0 0x30 21>;
+    };
-- 
2.11.0

