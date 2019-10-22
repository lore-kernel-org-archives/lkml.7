Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B8ACA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EDE21872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbfJVNaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:30:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26819 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730981AbfJVNaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:30:20 -0400
X-UUID: fe6f9d5ca1904e649a664df5bf5a9507-20191022
X-UUID: fe6f9d5ca1904e649a664df5bf5a9507-20191022
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 522666648; Tue, 22 Oct 2019 21:30:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Oct 2019 21:30:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Oct 2019 21:30:13 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [RESEND, PATCH 1/1] arm: dts: mediatek: add mt7629 pwm support
Date:   Tue, 22 Oct 2019 21:30:01 +0800
Message-ID: <1571751001-28588-2-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571751001-28588-1-git-send-email-sam.shih@mediatek.com>
References: <1571751001-28588-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds pwm support for MT7629.
Used:
https://patchwork.kernel.org/patch/11160851/

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 arch/arm/boot/dts/mt7629.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
index 9608bc2ccb3f..24375fc5f936 100644
--- a/arch/arm/boot/dts/mt7629.dtsi
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -241,6 +241,21 @@
 			status = "disabled";
 		};
 
+		pwm: pwm@11006000 {
+			compatible = "mediatek,mt7629-pwm";
+			reg = <0x11006000 0x1000>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_PWM_SEL>,
+				 <&pericfg CLK_PERI_PWM_PD>,
+				 <&pericfg CLK_PERI_PWM1_PD>;
+			clock-names = "top", "main", "pwm1";
+			assigned-clocks = <&topckgen CLK_TOP_PWM_SEL>;
+			assigned-clock-parents =
+					<&topckgen CLK_TOP_UNIVPLL2_D4>;
+			num-pwms = <1>;
+			status = "disabled";
+		};
+
 		i2c: i2c@11007000 {
 			compatible = "mediatek,mt7629-i2c",
 				     "mediatek,mt2712-i2c";
-- 
2.17.1

