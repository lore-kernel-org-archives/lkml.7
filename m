Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3954CC04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172AA21743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfD3JqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:46:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48767 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726945AbfD3Jp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:45:27 -0400
X-UUID: a1c30d10bc484564b3e97412b8402b51-20190430
X-UUID: a1c30d10bc484564b3e97412b8402b51-20190430
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 583229787; Tue, 30 Apr 2019 17:45:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Apr 2019 17:45:19 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Apr 2019 17:45:19 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC V2 02/11] dt-bindings: soc: Add opp table on scpsys bindings
Date:   Tue, 30 Apr 2019 16:50:56 +0800
Message-ID: <1556614265-12745-3-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A0192DEC0B2A71B838B3E54F8F346560A9AFF8FE1F4F8B11C656FF1C2F1997332000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add opp table on scpsys dt-bindings for Mediatek SoC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index b4728ce..33df802 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -63,6 +63,10 @@ Optional properties:
 - mfg_2d-supply: Power supply for the mfg_2d power domain
 - mfg-supply: Power supply for the mfg power domain
 
+- operating-points-v2: Phandle to the OPP table for the Power domain.
+	Refer to Documentation/devicetree/bindings/power/power_domain.txt
+	and Documentation/devicetree/bindings/opp/opp.txt for more details
+
 Example:
 
 	scpsys: scpsys@10006000 {
@@ -75,6 +79,27 @@ Example:
 			 <&topckgen CLK_TOP_VENC_SEL>,
 			 <&topckgen CLK_TOP_VENC_LT_SEL>;
 		clock-names = "mfg", "mm", "venc", "venc_lt";
+		operating-points-v2 = <&dvfsrc_opp_table>;
+
+		dvfsrc_opp_table: opp-table {
+			compatible = "operating-points-v2-level";
+
+			dvfsrc_vol_min: opp1 {
+				opp,level = <MT8183_DVFSRC_LEVEL_1>;
+			};
+
+			dvfsrc_freq_medium: opp2 {
+				opp,level = <MT8183_DVFSRC_LEVEL_2>;
+			};
+
+			dvfsrc_freq_max: opp3 {
+				opp,level = <MT8183_DVFSRC_LEVEL_3>;
+			};
+
+			dvfsrc_vol_max: opp4 {
+				opp,level = <MT8183_DVFSRC_LEVEL_4>;
+			};
+		};
 	};
 
 Example consumer:
@@ -82,4 +107,21 @@ Example consumer:
 	afe: mt8173-afe-pcm@11220000 {
 		compatible = "mediatek,mt8173-afe-pcm";
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_AUDIO>;
+		operating-points-v2 = <&aud_opp_table>;
+	};
+
+	aud_opp_table: aud-opp-table {
+		compatible = "operating-points-v2";
+		opp1 {
+			opp-hz = /bits/ 64 <793000000>;
+			required-opps = <&dvfsrc_vol_min>;
+		};
+		opp2 {
+			opp-hz = /bits/ 64 <910000000>;
+			required-opps = <&dvfsrc_vol_max>;
+		};
+		opp3 {
+			opp-hz = /bits/ 64 <1014000000>;
+			required-opps = <&dvfsrc_vol_max>;
+		};
 	};
-- 
1.9.1

