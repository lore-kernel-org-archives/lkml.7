Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606E5C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371A12087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCKXKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:10:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfCKXKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:10:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E4A3B15C;
        Mon, 11 Mar 2019 23:10:12 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 12 Mar 2019 10:09:37 +1100
Subject: [PATCH 2/2] staging: mt7621-dts: update ethernet settings.
Cc:     devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>
Message-ID: <155234577702.4958.16102949327222755790.stgit@noble.brown>
In-Reply-To: <155234569479.4958.3984850739390042194.stgit@noble.brown>
References: <155234569479.4958.3984850739390042194.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ethernet in mt7621 is now supported by
 drivers/net/ethernet/mediatek/

which provides support for the integrated switch through DSA.

This requires some devicetree changes, and particularly allows
a board dts to identify which switch ports are present.

The second CPU interface - gmac1 - doesn't work yet, so the device
tree information may not be correct.  The phy (which is present on the
gnubee-pc2) can negotiate and report connection speed etc, but no
traffic flows.

The gnubee-pc1 has two network ports which are 'black' and 'blue'.
There are connected to switch ports 0 and 4 respectively.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-dts/gbpc1.dts   |   29 ++++++-------
 drivers/staging/mt7621-dts/mt7621.dtsi |   73 +++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/mt7621-dts/gbpc1.dts b/drivers/staging/mt7621-dts/gbpc1.dts
index b73385540216..250c15ace2a7 100644
--- a/drivers/staging/mt7621-dts/gbpc1.dts
+++ b/drivers/staging/mt7621-dts/gbpc1.dts
@@ -117,22 +117,6 @@
 	status = "okay";
 };
 
-&ethernet {
-	//mtd-mac-address = <&factory 0xe000>;
-	gmac1: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-handle = <&phy1>;
-	};
-
-	mdio-bus {
-		phy1: ethernet-phy@1 {
-			reg = <1>;
-			phy-mode = "rgmii";
-		};
-	};
-};
-
 &pinctrl {
 	state_default: pinctrl0 {
 		gpio {
@@ -141,3 +125,16 @@
 		};
 	};
 };
+
+&switch0 {
+	ports {
+		port@0 {
+			label = "ethblack";
+			status = "ok";
+		};
+		port@4 {
+			label = "ethblue";
+			status = "ok";
+		};
+	};
+};
diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index 6aff3680ce4b..17020e24abd2 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -372,16 +372,83 @@
 
 		mediatek,ethsys = <&ethsys>;
 
-		mediatek,switch = <&gsw>;
 
+		gmac0: mac@0 {
+			compatible = "mediatek,eth-mac";
+			reg = <0>;
+			phy-mode = "rgmii";
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+				pause;
+			};
+		};
+		gmac1: mac@1 {
+			compatible = "mediatek,eth-mac";
+			reg = <1>;
+			status = "off";
+			phy-mode = "rgmii";
+			phy-handle = <&phy5>;
+		};
 		mdio-bus {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			phy1f: ethernet-phy@1f {
-				reg = <0x1f>;
+			phy5: ethernet-phy@5 {
+				reg = <5>;
 				phy-mode = "rgmii";
 			};
+
+			switch0: switch0@0 {
+				compatible = "mediatek,mt7621";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				mediatek,mcm;
+				resets = <&rstctrl 2>;
+				reset-names = "mcm";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+					port@0 {
+						status = "off";
+						reg = <0>;
+						label = "lan0";
+					};
+					port@1 {
+						status = "off";
+						reg = <1>;
+						label = "lan1";
+					};
+					port@2 {
+						status = "off";
+						reg = <2>;
+						label = "lan2";
+					};
+					port@3 {
+						status = "off";
+						reg = <3>;
+						label = "lan3";
+					};
+					port@4 {
+						status = "off";
+						reg = <4>;
+						label = "lan4";
+					};
+					port@6 {
+						reg = <6>;
+						label = "cpu";
+						ethernet = <&gmac0>;
+						phy-mode = "trgmii";
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+				};
+			};
 		};
 	};
 


