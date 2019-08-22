Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC7C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E8922CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbfHVLK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:10:27 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35686 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388073AbfHVLK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:10:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 74D5AFB03;
        Thu, 22 Aug 2019 13:10:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DPGs_PT9whdo; Thu, 22 Aug 2019 13:10:24 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 739494014F; Thu, 22 Aug 2019 13:10:23 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: imx8mq: Add mux controller to iomuxc_gpr
Date:   Thu, 22 Aug 2019 13:10:23 +0200
Message-Id: <fa3b1df7fc5e74f375df5de53061d1a93d154b51.1566471985.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1566471985.git.agx@sigxcpu.org>
References: <cover.1566471985.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only mux controls the MIPI DSI input selection.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 4fdd60f2c51e..3f3594d9485c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -440,8 +440,15 @@
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr",
+					     "syscon", "simple-mfd";
 				reg = <0x30340000 0x10000>;
+
+				mux: mux-controller {
+					compatible = "mmio-mux";
+					#mux-control-cells = <1>;
+					mux-reg-masks = <0x34 0x00000004>; /* MIPI_MUX_SEL */
+				};
 			};
 
 			ocotp: ocotp-ctrl@30350000 {
-- 
2.20.1

