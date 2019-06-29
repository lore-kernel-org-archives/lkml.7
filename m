Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E926DC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59DA217D4
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfF2KbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:31:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34926 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfF2KbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:31:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 76E101A05B9;
        Sat, 29 Jun 2019 12:31:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A438D1A028A;
        Sat, 29 Jun 2019 12:31:01 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A94E94030F;
        Sat, 29 Jun 2019 18:30:49 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, angus@akkea.ca,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/2] arm64: dts: imx8mq: Correct OPP table according to latest datasheet
Date:   Sat, 29 Jun 2019 18:21:57 +0800
Message-Id: <20190629102157.8026-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190629102157.8026-1-Anson.Huang@nxp.com>
References: <20190629102157.8026-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

According to latest datasheet (Rev.1, 10/2018) from below links,
in the consumer datasheet, 1.5GHz is mentioned as highest opp but
depends on speed grading fuse, and in the industrial datasheet,
1.3GHz is mentioned as highest opp but depends on speed grading
fuse. 1.5GHz and 1.3GHz opp use same voltage, so no need for
consumer part to support 1.3GHz opp, with same voltage, CPU should
run at highest frequency in order to go into idle as quick as
possible, this can save power.

That means for consumer part, 1GHz/1.5GHz are supported, for
industrial part, 800MHz/1.3GHz are supported, and then check the
speed grading fuse to limit the highest CPU frequency further.
Correct the market segment bits in opp table to make them work
according to datasheets.

https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQIEC.pdf
https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQCEC.pdf

Fixes: 12629c5c3749 ("arm64: dts: imx8mq: Add cpu speed grading and all OPPs")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- remove the comment to avoid any confusion.
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9d99191..477c523 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -169,15 +169,14 @@
 		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1000000>;
-			opp-supported-hw = <0xc>, <0x7>;
+			opp-supported-hw = <0xc>, <0x4>;
 			clock-latency-ns = <150000>;
 		};
 
 		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1000000>;
-			/* Consumer only but rely on speed grading */
-			opp-supported-hw = <0x8>, <0x7>;
+			opp-supported-hw = <0x8>, <0x3>;
 			clock-latency-ns = <150000>;
 		};
 	};
-- 
2.7.4

