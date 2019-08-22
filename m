Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F8C3A5A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0E5216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfHVCS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:18:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37128 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731190AbfHVCSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:18:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 738A32005B5;
        Thu, 22 Aug 2019 04:18:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC4D82005B4;
        Thu, 22 Aug 2019 04:18:45 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F407740296;
        Thu, 22 Aug 2019 10:18:38 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
Subject: [v3 1/2] dt/bindings: clk: Add YAML schemas for LS1028A Display Clock bindings
Date:   Thu, 22 Aug 2019 10:08:46 +0800
Message-Id: <20190822020847.10159-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to Display
output interface. Add a YAML schema for this.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/fsl,plldig.yaml | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,plldig.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
new file mode 100644
index 000000000000..32274e94aafc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/fsl,plldig.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP QorIQ Layerscape LS1028A Display PIXEL Clock Binding
+
+maintainers:
+  - Wen He <wen.he_1@nxp.com>
+
+description: |
+  NXP LS1028A has a clock domain PXLCLK0 used for the Display output
+  interface in the display core, as implemented in TSMC CLN28HPM PLL.
+  which generate and offers pixel clocks to Display.
+
+properties:
+  compatible:
+    const: fsl,ls1028a-plldig
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+examples:
+  # Display PIXEL Clock node:
+  - |
+    dpclk: clock-display@f1f0000 {
+        compatible = "fsl,ls1028a-plldig";
+        reg = <0x0 0xf1f0000 0x0 0xffff>;
+        #clock-cells = <0>;
+        clocks = <&osc_27m>;
+    };
+
+...
-- 
2.17.1

