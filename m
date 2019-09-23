Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2592FC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CAF20578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbfIWOOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:14:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56864 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732495AbfIWOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:14:28 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CA141A02EB;
        Mon, 23 Sep 2019 16:14:26 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F44F1A0262;
        Mon, 23 Sep 2019 16:14:26 +0200 (CEST)
Received: from fsr-ub1664-121.ea.freescale.net (fsr-ub1664-121.ea.freescale.net [10.171.82.171])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DCA1820613;
        Mon, 23 Sep 2019 16:14:25 +0200 (CEST)
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     agx@sigxcpu.org, l.stach@pengutronix.de,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
Date:   Mon, 23 Sep 2019 17:13:19 +0300
Message-Id: <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the node for iMX8MQ Display Controller Subsystem.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 52aae34..d4aa778 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -871,6 +871,31 @@
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
+
+			dcss: dcss@0x32e00000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "nxp,imx8mq-dcss";
+				reg = <0x32e00000 0x2D000>, <0x32e2f000 0x1000>;
+				interrupts = <6>, <8>, <9>;
+				interrupt-names = "ctx_ld", "ctxld_kick", "vblank";
+				interrupt-parent = <&irqsteer>;
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
+					 <&clk IMX8MQ_VIDEO2_PLL_OUT>,
+					 <&clk IMX8MQ_CLK_DISP_DTRC>;
+				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
+				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
+						  <&clk IMX8MQ_CLK_DISP_RTRM>,
+						  <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
+				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_CLK_27M>;
+				assigned-clock-rates = <800000000>,
+							   <400000000>;
+				status = "disabled";
+			};
 		};
 
 		gpu: gpu@38000000 {
-- 
2.7.4

