Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5512C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17EE2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFUSxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:50 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:33392 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:53:49 -0400
X-Greylist: delayed 3192 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 14:53:49 EDT
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5LI0N5B077983;
        Sat, 22 Jun 2019 03:00:23 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Sat, 22 Jun 2019 03:00:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5LI0JBf077976
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 22 Jun 2019 03:00:23 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] ARM: dts: rockchip: add ethernet phy node for tinker board
Date:   Sat, 22 Jun 2019 03:00:17 +0900
Message-Id: <20190621180017.29646-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing mdio and ethernet PHY nodes for rk3328 ASUS
tinker board.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 293576869546..3190817e8d5d 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -117,6 +117,7 @@
 	assigned-clocks = <&cru SCLK_MAC>;
 	assigned-clock-parents = <&ext_gmac>;
 	clock_in_out = "input";
+	phy-handle = <&phy0>;
 	phy-mode = "rgmii";
 	phy-supply = <&vcc33_lan>;
 	pinctrl-names = "default";
@@ -127,6 +128,17 @@
 	tx_delay = <0x30>;
 	rx_delay = <0x10>;
 	status = "ok";
+
+	mdio0 {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
 };
 
 &gpu {
-- 
2.20.1

