Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFF9C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5556721BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfGXMi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:38:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51328 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfGXMiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:38:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FB2C20026B;
        Wed, 24 Jul 2019 14:38:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FECC200265;
        Wed, 24 Jul 2019 14:38:52 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 40BB2205D8;
        Wed, 24 Jul 2019 14:38:51 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Will Deacon <will@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Li <Frank.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFCv3 1/3] dt-bindings: devfreq: Add initial bindings for i.MX
Date:   Wed, 24 Jul 2019 15:38:44 +0300
Message-Id: <93df6e7d81a404a43af684e2f96bdb6561ed87fe.1563971855.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1563971855.git.leonard.crestez@nxp.com>
References: <cover.1563971855.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1563971855.git.leonard.crestez@nxp.com>
References: <cover.1563971855.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial dt bindings for the interconnects inside i.MX chips.
Multiple external IPs are involved but SOC integration means the
software controllable interfaces are very similar.

This is initially only for imx8mm but add an "fsl,imx-bus" fallback
similar to exynos-bus.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 .../devicetree/bindings/devfreq/imx.yaml      | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml

diff --git a/Documentation/devicetree/bindings/devfreq/imx.yaml b/Documentation/devicetree/bindings/devfreq/imx.yaml
new file mode 100644
index 000000000000..87f90cddfd29
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/imx.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/imx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic i.MX bus frequency device
+
+maintainers:
+  - Leonard Crestez <leonard.crestez@nxp.com>
+
+description: |
+  The i.MX SoC family has multiple buses for which clock frequency (and sometimes
+  voltage) can be adjusted.
+
+  Some of those buses expose register areas mentioned in the memory maps as GPV
+  ("Global Programmers View") but not all. Access to this area might be denied for
+  normal world.
+
+  The buses are based on externally licensed IPs such as ARM NIC-301 and Arteris
+  FlexNOC but DT bindings are specific to the integration of these bus
+  interconnect IPs into imx SOCs.
+ 
+properties:
+  reg:
+    maxItems: 1
+    description: GPV area
+
+  compatible:
+    contains:
+      enum:
+       - fsl,imx8m-noc
+       - fsl,imx8m-nic
+       - fsl,imx8m-ddrc
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    ddrc: dram-controller@3d400000 {
+            compatible = "fsl,imx8mm-ddrc";
+            reg = <0x3d400000 0x400000>;
+            clocks = <&clk IMX8MM_CLK_DRAM>;
+            operating-points-v2 = <&ddrc_opp_table>;
+    };
+
+  - |
+    noc: noc@32700000 {
+            compatible = "fsl,imx8mm-noc";
+            reg = <0x32700000 0x100000>;
+            clocks = <&clk IMX8MM_CLK_NOC>;
+            operating-points-v2 = <&noc_opp_table>;
+    };
-- 
2.17.1

