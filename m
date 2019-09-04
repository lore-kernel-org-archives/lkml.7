Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44BFC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E9523401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfIDG1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:27:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:43295 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIDG1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:27:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 23:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="266548282"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 03 Sep 2019 23:27:21 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v3 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema for LGM SDXC PHY
Date:   Wed,  4 Sep 2019 14:27:18 +0800
Message-Id: <20190904062719.37462-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add a YAML schema to use the host controller driver with the
SDXC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 changes in v3:
   - Rob's review comments addressed and updated the patch
   - merged syscon and sdxc yaml file as single file after discussion

 changes in v2:
   - As per Rob's review comment syscon node entry added instead of reference
   - splitted two patches one for syscon and another for sdxc phy
---
 .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
new file mode 100644
index 000000000000..dfdedcf10f3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,lgm-sdxc-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Lightning Mountain(LGM) SDXC PHY Device Tree Bindings
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+description: Bindings for SDXC PHY on Intel's Lightning Mountain SoC, syscon
+  node is used to reference the base address of SDXC phy registers.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: intel,lgm-syscon
+
+    reg:
+      maxItems: 1
+
+  required:
+    - compatible
+    - reg
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    contains:
+      const: intel,lgm-sdxc-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    sysconf: chiptop@e0200000 {
+      compatible = "intel,lgm-syscon";
+      reg = <0xe0200000 0x100>;
+
+      sdxc-phy: sdxc-phy {
+        compatible = "intel,lgm-sdxc-phy";
+        reg = <0x0080 0x4>,
+              <0x0084 0x4>,
+              <0x0088 0x4>,
+              <0x008c 0x4>;
+        clocks = <&sdxc>;
+        clock-names = "sdxcclk";
+        #phy-cells = <0>;
+      };
+    };
+...
-- 
2.11.0

