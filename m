Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B1C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF91D21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfHVHcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:32:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:59989 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfHVHcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:32:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 00:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="378410923"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2019 00:32:17 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 1/2] dt-bindings: reset: Add YAML schemas for the Intel Reset controller
Date:   Thu, 22 Aug 2019 15:32:10 +0800
Message-Id: <c909a3a19a1c06ac3ed9e1c42da3193ff8e43b7a.1566454535.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML schemas for the reset controller on Intel
Lightening Mountain (LGM) SoC.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 .../bindings/reset/intel,syscon-reset.yaml         | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
new file mode 100644
index 000000000000..298c60085486
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/intel,syscon-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Lightening Mountain SoC System Reset Controller
+
+maintainers:
+  - Dilip Kota <eswara.kota@linux.intel.com>
+
+properties:
+  compatible:
+    allOf:
+      - items:
+          - enum:
+              - intel,rcu-lgm
+              - syscon
+
+  reg:
+    description: Reset controller register base address and size
+
+  intel,global-reset:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Global reset register offset and bit offset.
+
+  "#reset-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - intel,global-reset
+  - "#reset-cells"
+
+examples:
+  - |
+    rcu0: reset-controller@00000000 {
+        compatible = "intel,rcu-lgm", "syscon";
+        reg = <0x000000 0x80000>;
+        intel,global-reset = <0x10 30>;
+        #reset-cells = <2>;
+    };
+
+    pcie_phy0: pciephy@... {
+        ...
+        /* address offset: 0x10, bit offset: 12 */
+        resets = <&rcu0 0x10 12>;
+        ...
+    };
-- 
2.11.0

