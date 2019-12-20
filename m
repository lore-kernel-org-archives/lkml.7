Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA4C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FC324680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLTHkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:40:43 -0500
Received: from inva021.nxp.com ([92.121.34.21]:39238 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfLTHkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:40:41 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7381920079B;
        Fri, 20 Dec 2019 08:40:39 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4972020045F;
        Fri, 20 Dec 2019 08:40:33 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8CDE04030B;
        Fri, 20 Dec 2019 15:40:25 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, fugang.duan@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 1/2] dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
Date:   Fri, 20 Dec 2019 15:37:10 +0800
Message-Id: <1576827431-31942-2-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
for i.MX8 family SoCs.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../interrupt-controller/fsl,intmux.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
new file mode 100644
index 000000000000..3ebe9cac5f20
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
@@ -0,0 +1,36 @@
+Freescale INTMUX interrupt multiplexer
+
+Required properties:
+
+- compatible: Should be:
+   - "fsl,imx-intmux"
+- reg: Physical base address and size of registers.
+- interrupts: Should contain the parent interrupt lines (up to 8) used to
+  multiplex the input interrupts.
+- clocks: Should contain one clock for entry in clock-names.
+- clock-names:
+   - "ipg": main logic clock
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value must be 2.
+   - the 1st cell: hardware interrupt number
+   - the 2nd cell: channel index, value must smaller than channels used
+
+Optional properties:
+
+- fsl,intmux_chans: The number of channels used for interrupt source. The
+  Maximum value is 8. If this property is not set in DT then driver uses
+  1 channel by default.
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

