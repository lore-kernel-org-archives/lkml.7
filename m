Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2D7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5D322CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfHTKbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:31:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:35241 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbfHTKbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:31:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 03:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="183159415"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 20 Aug 2019 03:31:36 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v2 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
Date:   Tue, 20 Aug 2019 18:31:32 +0800
Message-Id: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
changes in v2:
  As per Rob Herring review comments, the following updates
 - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
 - filename is the compatible string plus .yaml
 - LGM: Lightning Mountain
 - update maintainer
 - add intel,syscon under property list
 - keep one example instead of two
---
 .../bindings/phy/intel,lgm-emmc-phy.yaml           | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
new file mode 100644
index 000000000000..ec177573aca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -0,0 +1,72 @@
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
+
+description:
+  -  Add a new compatible to use the host controller driver with the
+     eMMC PHY on Intel's Lightning Mountain SoC.
+
+$ref: /schemas/types.yaml#definitions/phandle
+  description:
+    - It also requires a "syscon" node with compatible = "intel,lgm-chiptop",
+      "syscon" to access the eMMC PHY register.
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    const: intel,lgm-emmc-phy
+
+  reg:
+    maxItems: 1
+
+  intel,syscon:
+    items:
+      - description:
+         - |
+           e-MMC phy module should include the following properties
+           * reg, Access the e-MMC, get the base address from syscon.
+           * reset, reset the e-MMC module.
+
+  clocks:
+    items:
+      - description: e-MMC phy module clock
+
+  clock-names:
+    items:
+      - const: emmcclk
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    emmc_phy: emmc_phy {
+        compatible = "intel,lgm-emmc-phy";
+        reg = <0xe0020000 0x100>;
+        intel,syscon = <&sysconf>;
+        clocks = <&emmc>;
+        clock-names = "emmcclk";
+        #phy-cells = <0>;
+    };
+
+...
-- 
2.11.0

