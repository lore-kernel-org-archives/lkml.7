Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0024EECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34F221924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbfJAMc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:32:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44762 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731252AbfJAMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:32:26 -0400
X-UUID: a1a8f4deaff4417da60a6366a777b2d2-20191001
X-UUID: a1a8f4deaff4417da60a6366a777b2d2-20191001
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <mark-mc.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1956266554; Tue, 01 Oct 2019 20:32:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Oct 2019 20:32:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Oct 2019 20:32:18 +0800
From:   MarkLee <Mark-MC.Lee@mediatek.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rene van Dorst <opensource@vdorst.com>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, MarkLee <Mark-MC.Lee@mediatek.com>
Subject: [PATCH net 2/2] arm: dts: mediatek: Fix mt7629 dts to reflect the latest dt-binding
Date:   Tue, 1 Oct 2019 20:31:50 +0800
Message-ID: <20191001123150.23135-3-Mark-MC.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191001123150.23135-1-Mark-MC.Lee@mediatek.com>
References: <20191001123150.23135-1-Mark-MC.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Removes mediatek,physpeed property from dtsi that is useless in PHYLINK
* Set gmac0 to fixed-link sgmii 2.5Gbit mode
* Set gmac1 to gmii mode that connect to a internal gphy

Signed-off-by: MarkLee <Mark-MC.Lee@mediatek.com>
---
 arch/arm/boot/dts/mt7629-rfb.dts | 13 ++++++++++++-
 arch/arm/boot/dts/mt7629.dtsi    |  2 --
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mt7629-rfb.dts b/arch/arm/boot/dts/mt7629-rfb.dts
index 3621b7d2b22a..6bf1f7d8ddb5 100644
--- a/arch/arm/boot/dts/mt7629-rfb.dts
+++ b/arch/arm/boot/dts/mt7629-rfb.dts
@@ -66,9 +66,21 @@
 	pinctrl-1 = <&ephy_leds_pins>;
 	status = "okay";
 
+	gmac0: mac@0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		phy-mode = "sgmii";
+		fixed-link {
+			speed = <2500>;
+			full-duplex;
+			pause;
+		};
+	};
+
 	gmac1: mac@1 {
 		compatible = "mediatek,eth-mac";
 		reg = <1>;
+		phy-mode = "gmii";
 		phy-handle = <&phy0>;
 	};
 
@@ -78,7 +90,6 @@
 
 		phy0: ethernet-phy@0 {
 			reg = <0>;
-			phy-mode = "gmii";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
index 9608bc2ccb3f..867b88103b9d 100644
--- a/arch/arm/boot/dts/mt7629.dtsi
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -468,14 +468,12 @@
 			compatible = "mediatek,mt7629-sgmiisys", "syscon";
 			reg = <0x1b128000 0x3000>;
 			#clock-cells = <1>;
-			mediatek,physpeed = "2500";
 		};
 
 		sgmiisys1: syscon@1b130000 {
 			compatible = "mediatek,mt7629-sgmiisys", "syscon";
 			reg = <0x1b130000 0x3000>;
 			#clock-cells = <1>;
-			mediatek,physpeed = "2500";
 		};
 	};
 };
-- 
2.17.1

