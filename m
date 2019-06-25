Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F71BC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C62205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfFYI1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:27:30 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:47682 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfFYI12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:27:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 64EF2FB04;
        Tue, 25 Jun 2019 10:27:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vZ3hhI6je8_5; Tue, 25 Jun 2019 10:27:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 18B2148D55; Tue, 25 Jun 2019 10:27:22 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mq: Add MIPI D-PHY
Date:   Tue, 25 Jun 2019 10:27:20 +0200
Message-Id: <613eef8ee6fd427a2fb5eb91865e71f3ee6bded6.1561451144.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1561451144.git.agx@sigxcpu.org>
References: <cover.1561451144.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the Mixel MIPI D-PHY, "disabled" by default.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d09b808eff87..891ee7578c2d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -728,6 +728,19 @@
 				status = "disabled";
 			};
 
+			dphy: dphy@30a00300 {
+				compatible = "fsl,imx8mq-mipi-dphy";
+				reg = <0x30a00300 0x100>;
+				clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+				clock-names = "phy_ref";
+				assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+				assigned-clock-parents = <&clk IMX8MQ_VIDEO_PLL1_OUT>;
+				assigned-clock-rates = <24000000>;
+				#phy-cells = <0>;
+				power-domains = <&pgc_mipi>;
+				status = "disabled";
+			};
+
 			i2c1: i2c@30a20000 {
 				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
 				reg = <0x30a20000 0x10000>;
-- 
2.20.1

