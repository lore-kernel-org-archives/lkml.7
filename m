Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E83BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC0223400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfIDFxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:53:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:57623 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDFxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:53:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 22:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="334093636"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 03 Sep 2019 22:53:49 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v5 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
Date:   Wed,  4 Sep 2019 13:53:43 +0800
Message-Id: <20190904055344.25512-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add a YAML schema to use the host controller driver with the
eMMC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
changes in v5:
  - earlier Review-by tag given by Rob
  - rework done with syscon parent node.

changes in v4:
  - As per Rob's review: validate 5.2 and 5.3
  - drop unrelated items.

changes in v3:
  - resolve 'make dt_binding_check' warnings

changes in v2:
  As per Rob Herring review comments, the following updates
 - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
 - filename is the compatible string plus .yaml
 - LGM: Lightning Mountain
 - update maintainer
 - add intel,syscon under property list
 - keep one example instead of two
---
 .../bindings/phy/intel,lgm-emmc-phy.yaml           | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
new file mode 100644
index 000000000000..8f6ac8b3da42
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+description: Bindings for eMMC PHY on Intel's Lightning Mountain SoC, syscon
+  node is used to reference the base address of eMMC phy registers.
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
+      const: intel,lgm-emmc-phy
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
+      emmc-phy: emmc-phy {
+        compatible = "intel,lgm-emmc-phy";
+        reg = <0x00a8 0x4>,
+              <0x00ac 0x4>,
+              <0x00b0 0x4>,
+              <0x00b4 0x4>;
+        clocks = <&emmc>;
+        clock-names = "emmcclk";
+        #phy-cells = <0>;
+      };
+    };
+...
-- 
2.11.0

