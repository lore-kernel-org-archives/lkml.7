Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC12EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AF12064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfD3RQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:16:00 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:48955 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfD3RQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:16:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 648BAFB03;
        Tue, 30 Apr 2019 19:15:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5nOpYID4nRbN; Tue, 30 Apr 2019 19:15:56 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0F37F4027E; Tue, 30 Apr 2019 19:15:56 +0200 (CEST)
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
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mq: Add a node for irqsteer
Date:   Tue, 30 Apr 2019 19:15:55 +0200
Message-Id: <72b64db0a3ae682d1c6f435fecf7876de2f57bc3.1556644355.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the irqsteer interrupt controller found on the iMX8MQ
SoC.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

---
Changes from v1 as per comments from Lucas Stach
* Drop interrupt-parent
* Move compatible stings to a single line

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 2cc939cfbd75..311f536d3bbf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -798,6 +798,25 @@
 			};
 		};
 
+		bus@32c00000 { /* AIPS4 */
+			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x32c00000 0x32c00000 0x400000>;
+
+			irqsteer: interrupt-controller@32e2d000 {
+				compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
+				reg = <0x32e2d000 0x1000>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+				clock-names = "ipg";
+				fsl,channel = <0>;
+				fsl,num-irqs = <64>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
 		gpu: gpu@38000000 {
 			compatible = "vivante,gc";
 			reg = <0x38000000 0x40000>;
-- 
2.20.1

