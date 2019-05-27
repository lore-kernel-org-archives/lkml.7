Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058FDC28CBF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA8921744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfE0JFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:05:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31019 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726691AbfE0JFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:05:43 -0400
X-UUID: ac4d7903a2d842ef9a7cced47deaeb51-20190527
X-UUID: ac4d7903a2d842ef9a7cced47deaeb51-20190527
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 535520483; Mon, 27 May 2019 17:05:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 27 May 2019 17:05:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 27 May 2019 17:05:20 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        Michael Mei <michael.mei@mediatek.com>
Subject: [PATCH v11 6/6] arm64: dts: mt8183: add efuse and Mediatek Chip id node to read
Date:   Mon, 27 May 2019 17:04:47 +0800
Message-ID: <1558947887-31084-7-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
References: <1558947887-31084-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BC6772C244BE5BC8E09530FE258C73FF60A08144B109D9253A4ADFC41D8847CA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Mei <michael.mei@mediatek.com>

support for reading chip ID and efuse

Signed-off-by: Michael Mei <michael.mei@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
This patch is based on this patch:
https://patchwork.kernel.org/patch/10953029/
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 2e3063f..c2749c4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -156,6 +156,15 @@
 		compatible = "simple-bus";
 		ranges;
 
+		soc_data: soc_data@8000000 {
+			compatible = "mediatek,mt8183-efuse",
+				     "mediatek,efuse";
+			reg = <0 0x08000000 0 0x0010>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@c000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <4>;
@@ -369,6 +378,12 @@
 			#clock-cells = <1>;
 		};
 
+		efuse: efuse@11f10000 {
+			compatible = "mediatek,mt8183-efuse",
+				     "mediatek,efuse";
+			reg = <0 0x11f10000 0 0x1000>;
+		};
+
 		mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
-- 
1.8.1.1.dirty

