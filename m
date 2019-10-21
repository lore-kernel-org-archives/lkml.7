Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE291CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9EB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfJUJyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:54:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:59071 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfJUJyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:54:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 02:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209297070"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2019 02:54:42 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v6 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
Date:   Mon, 21 Oct 2019 17:54:35 +0800
Message-Id: <20191021095436.50303-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191021095436.50303-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20191021095436.50303-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add a YAML schema to use the host controller driver with the
eMMC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
---
 .../bindings/phy/intel,lgm-emmc-phy.yaml           | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
new file mode 100644
index 000000000000..bc1285be31f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -0,0 +1,63 @@
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
+      items:
+       - const: intel,lgm-syscon
+       - const: intel,lgm-emmc-phy
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
+        reg = <0x00a8 0x10>;
+        clocks = <&emmc>;
+        clock-names = "emmcclk";
+        #phy-cells = <0>;
+      };
+    };
+...
-- 
2.11.0

