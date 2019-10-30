Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39199CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1768320717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfJ3IMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:12:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:19426 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3IMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:12:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 01:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="351233369"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2019 01:12:00 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
Date:   Wed, 30 Oct 2019 16:11:54 +0800
Message-Id: <20191030081155.29947-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191030081155.29947-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20191030081155.29947-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add dt-bindings documentation for Cadence-QSPI controller to support
spi based flash memories.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 .../devicetree/bindings/spi/cadence,qspi.yaml      | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
new file mode 100644
index 000000000000..295501f01e5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cadence,qspi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence QSPI Flash Controller support
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+description: |
+  Add support for the Cadence QSPI controller,This controller is
+  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
+  has been tested On Intel's LGM SoC.
+
+properties:
+  compatible:
+    const: cadence,qspi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clocks-names:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+examples:
+  - |
+    spi@ec000000 {
+          compatible = "cadence,qspi";
+          reg = <0xec000000 0x100>;
+          clocks = <&cgu0 LGM_CLK_QSPI>, <&cgu0 LGM_GCLK_QSPI>;
+          clock-names = "qspi";
+          resets = <&rcu0 0x10 1>;
+          reset-names = "qspi";
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          flash: flash@1 {
+              compatible = "spi-nand", "jedec, spi-nor";
+              reg = <1>;
+              spi-max-frequency = <10000000>;
+          };
+    };
+
-- 
2.11.0

