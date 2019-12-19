Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C79C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02D92064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLSKYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:24:31 -0500
Received: from inva020.nxp.com ([92.121.34.13]:39014 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfLSKY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:24:28 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E6B11A0ABE;
        Thu, 19 Dec 2019 11:24:26 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EDE541A0426;
        Thu, 19 Dec 2019 11:24:20 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BD466402DF;
        Thu, 19 Dec 2019 18:24:13 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, maz@kernel.org, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, fugang.duan@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
Date:   Thu, 19 Dec 2019 18:21:04 +0800
Message-Id: <1576750865-14442-2-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576750865-14442-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1576750865-14442-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
found in the i.MX8 family SoCs.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../interrupt-controller/fsl,intmux.txt       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
new file mode 100644
index 000000000000..a9a16b5046c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
@@ -0,0 +1,28 @@
+Freescale INTMUX interrupt multiplexer
+
+Required properties:
+
+- compatible: Should be:
+	- "fsl,imx-intmux"
+- reg: Physical base address and size of registers.
+- interrupts: Should contain one parent interrupt line used to multiplex the
+  input interrupt sources.
+- clocks: Should contain one clock for entry in clock-names.
+- clock-names:
+   - "ipg": main logic clock
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value must be 1.
+
+Example:
+
+	intmux@37400000 {
+		compatible = "fsl,imx-intmux";
+		reg = <0x37400000 0x1000>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX8QM_CM40_IPG_CLK>;
+		clock-names = "ipg";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
-- 
2.17.1

