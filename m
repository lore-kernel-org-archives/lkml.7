Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7400AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 12:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A90120719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 12:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKWMJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 07:09:11 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:60106 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfKWMJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 07:09:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7E59CFB03;
        Sat, 23 Nov 2019 13:09:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BqkUEUH1Kz7V; Sat, 23 Nov 2019 13:09:06 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6C0AE489BF; Sat, 23 Nov 2019 13:08:02 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq: Add eLCDIF controller
Date:   Sat, 23 Nov 2019 13:08:02 +0100
Message-Id: <59793b1ae533636528942b2cec14ec68b9830fcf.1574510649.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the eLCDIF controller, "disabled" by default.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
With some minimal support on imx8mq we might as well add it to the DT

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 7f9319452b58..00aa63bfd816 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -448,6 +448,23 @@
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
 			};
 
+			lcdif: lcdif@30320000 {
+				compatible = "fsl,imx8mq-lcdif", "fsl,imx28-lcdif";
+				reg = <0x30320000 0x10000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_LCDIF_PIXEL>;
+				clock-names = "pix";
+				assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
+						  <&clk IMX8MQ_VIDEO_PLL1_BYPASS>,
+						  <&clk IMX8MQ_CLK_LCDIF_PIXEL>,
+						  <&clk IMX8MQ_VIDEO_PLL1>;
+				assigned-clock-parents = <&clk IMX8MQ_CLK_25M>,
+						  <&clk IMX8MQ_VIDEO_PLL1>,
+						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
+				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
+				status = "disabled";
+			};
+
 			iomuxc: iomuxc@30330000 {
 				compatible = "fsl,imx8mq-iomuxc";
 				reg = <0x30330000 0x10000>;
-- 
2.23.0

