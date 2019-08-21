Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA838C3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DC32332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfHUKL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:11:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:27940 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfHUKLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:11:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 03:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="172733736"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2019 03:11:22 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v3 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
Date:   Wed, 21 Aug 2019 18:11:17 +0800
Message-Id: <20190821101118.42774-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
 .../bindings/phy/intel,lgm-emmc-phy.yaml           | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
new file mode 100644
index 000000000000..9342e33d8b02
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -0,0 +1,59 @@
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
+  syscon:
+    items:
+      $ref: "/schemas/types.yaml#definitions/phandle"
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
+  - ref
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

