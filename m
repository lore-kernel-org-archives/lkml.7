Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FC7205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfH1MnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:43:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:63868 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1MnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:43:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 05:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="183118364"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2019 05:43:21 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v2 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema for LGM SDXC PHY
Date:   Wed, 28 Aug 2019 20:43:14 +0800
Message-Id: <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190828124315.48448-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190828124315.48448-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add a YAML schema to use the host controller driver with the
SDXC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 52 ++++++++++++++++++++++
 .../devicetree/bindings/phy/intel,syscon.yaml      | 33 ++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/intel,syscon.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
new file mode 100644
index 000000000000..99647207b414
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
@@ -0,0 +1,52 @@
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
+allOf:
+  - $ref: "intel,syscon.yaml"
+
+description: Binding for SDXC PHY
+
+properties:
+  compatible:
+    const: intel,lgm-sdxc-phy
+
+  intel,syscon:
+    description: phandle to the sdxc through syscon
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - "#phy-cells"
+  - compatible
+  - intel,syscon
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    sdxc_phy: sdxc_phy {
+        compatible = "intel,lgm-sdxc-phy";
+        intel,syscon = <&sysconf>;
+        clocks = <&sdxc>;
+        clock-names = "sdxcclk";
+        #phy-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/phy/intel,syscon.yaml b/Documentation/devicetree/bindings/phy/intel,syscon.yaml
new file mode 100644
index 000000000000..d0b78805e49f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,syscon.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Syscon for eMMC/SDXC PHY Device Tree Bindings
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+properties:
+  compatible:
+    const: intel,syscon
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+   const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+examples:
+  - |
+    sysconf: chiptop@e0020000 {
+       compatible = "intel,syscon", "syscon";
+       reg = <0xe0020000 0x100>;
+       #reset-cells = <1>;
+    };
-- 
2.11.0

