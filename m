Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D86BC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3CB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 03:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfHSDoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 23:44:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:23556 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfHSDoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 23:44:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 20:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="195443446"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2019 20:44:19 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v1 1/2] dt-bindings: phy: intel-emmc-phy: Add new compatible for LGM eMMC PHY
Date:   Mon, 19 Aug 2019 11:44:15 +0800
Message-Id: <20190819034416.45192-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add a new compatible to use the host controller driver with the
eMMC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 .../bindings/phy/intel-lgm-emmc-phy.yaml           | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml
new file mode 100644
index 000000000000..52156ff091ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel-lgm-emmc-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel LGM e-MMC PHY Device Tree Bindings
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+
+intel,syscon:
+   $ref: /schemas/types.yaml#definitions/phandle
+   description:
+    - |
+      e-MMC phy module connected through chiptop. Phandle to a node that can
+      contain the following properties
+        * reg, Access the e-MMC, get the base address from syscon.
+        * reset, reset the e-MMC module.
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
+    sysconf: chiptop@e0020000 {
+        compatible = "intel,chiptop-lgm", "syscon";
+        reg = <0xe0020000 0x100>;
+        #reset-cells = <1>;
+     };
+
+  - |
+    emmc_phy: emmc_phy {
+        compatible = "intel,lgm-emmc-phy";
+        intel,syscon = <&sysconf>;
+        clocks = <&emmc>;
+        clock-names = "emmcclk";
+        #phy-cells = <0>;
+    };
+
+...
-- 
2.11.0

