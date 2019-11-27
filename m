Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86413C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D0D20885
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfK0KPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:15:54 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40930 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfK0KPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:15:54 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 012771A003F;
        Wed, 27 Nov 2019 11:15:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7764F1A06B9;
        Wed, 27 Nov 2019 11:15:47 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9C18A402CF;
        Wed, 27 Nov 2019 18:15:41 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [v10 1/2] dt/bindings: clk: Add YAML schemas for LS1028A Display Clock bindings
Date:   Wed, 27 Nov 2019 18:15:24 +0800
Message-Id: <20191127101525.44516-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to Display
output interface. Add a YAML schema for this.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
change in v10:
        - Add optional feild 'vco-frequency'.

 .../devicetree/bindings/clock/fsl,plldig.yaml | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,plldig.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
new file mode 100644
index 000000000000..ee5b5c61a471
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
@@ -0,0 +1,54 @@
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
+  vco-frequency:
+     $ref: '/schemas/types.yaml#/definitions/uint32'
+     description: Optional for VCO frequency of the PLL in Hertz.
+        The VCO frequency of this PLL cannot be changed during runtime
+        only at startup. Therefore, the output frequencies are very
+        limited and might not even closely match the requested frequency.
+        To work around this restriction the user may specify its own
+        desired VCO frequency for the PLL. The frequency has to be in the
+        range of 650000000 to 1300000000.
+        If not set, the default frequency is 1188000000.
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

