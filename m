Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E975C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2206F2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfGSKTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:19:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53950 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfGSKTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:19:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 54E871A0144;
        Fri, 19 Jul 2019 12:19:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE9E51A0046;
        Fri, 19 Jul 2019 12:18:59 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 51F78402CF;
        Fri, 19 Jul 2019 18:18:54 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, robh+dt@kernel.org
Cc:     leoyang.li@nxp.com, Wen He <wen.he_1@nxp.com>
Subject: [v2 1/4] dt-bindings: display: Add DT bindings for LS1028A HDP-TX PHY.
Date:   Fri, 19 Jul 2019 18:09:39 +0800
Message-Id: <20190719100942.12016-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentmation for the HDP-TX PHY controller. The describes
which could be found on NXP Layerscape ls1028a platform.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
change in v2:
        - correction the node name.

 .../devicetree/bindings/display/fsl,hdp.txt   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/fsl,hdp.txt

diff --git a/Documentation/devicetree/bindings/display/fsl,hdp.txt b/Documentation/devicetree/bindings/display/fsl,hdp.txt
new file mode 100644
index 000000000000..53ca08337587
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/fsl,hdp.txt
@@ -0,0 +1,56 @@
+NXP Layerscpae ls1028a HDP-TX PHY Controller
+============================================
+
+The following bindings describe the Cadence HDP TX PHY on ls1028a that
+offer multi-protocol support of standars such as eDP and Displayport,
+supports for 25-600MHz pixel clock and up to 4k2k at 60MHz resolution.
+The HDP transmitter is a Cadence HDP TX controller IP with a companion
+PHY IP.
+
+Required properties:
+  - compatible:   Should be "fsl,ls1028a-dp" for ls1028a.
+  - reg:          Physical base address and size of the block of registers used
+  by the processor.
+  - interrupts:   HDP hotplug in/out detect interrupt number
+  - clocks:       A list of phandle + clock-specifier pairs, one for each entry
+  in 'clock-names'
+  - clock-names:  A list of clock names. It should contain:
+      - "clk_ipg": inter-Integrated circuit clock
+      - "clk_core": for the Main Display TX controller clock
+      - "clk_pxl": for the pixel clock feeding the output PLL of the processor
+      - "clk_pxl_mux": for the high PerfPLL bypass clock
+      - "clk_pxl_link": for the link rate pixel clock
+      - "clk_apb": for the APB interface clock
+      - "clk_vif": for the Video pixel clock
+
+Required sub-nodes:
+  - port: The HDP connection to an encoder output port. The connection
+    is modelled using the OF graph bindings specified in
+    Documentation/devicetree/bindings/graph.txt
+
+
+Example:
+
+/ {
+        ...
+
+        hdptx0: display@f200000 {
+                compatible = "fsl,ls1028a-dp";
+		reg = <0x0 0xf1f0000 0x0 0xffff>,
+		    <0x0 0xf200000 0x0 0xfffff>;
+                interrupts = <0 221 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sysclk>, <&hdpclk>, <&dpclk>,
+                         <&dpclk>, <&dpclk>, <&pclk>, <&dpclk>;
+		clock-names = "clk_ipg", "clk_core", "clk_pxl",
+                              "clk_pxl_mux", "clk_pxl_link", "clk_apb",
+                              "clk_vif";
+
+		port {
+			dp1_output: endpoint {
+				remote-endpoint = <&dp0_input>;
+			};
+		};
+        };
+
+        ...
+};
-- 
2.17.1

