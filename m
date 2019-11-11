Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96185214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKLrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:47:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43837 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfKKLrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:47:35 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1iU8AI-0000vA-On; Mon, 11 Nov 2019 12:47:26 +0100
Received: from mgr by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1iU8AH-0006hF-DX; Mon, 11 Nov 2019 12:47:25 +0100
From:   Michael Grzeschik <m.grzeschik@pengutronix.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx25: fix usbhost1 node
Date:   Mon, 11 Nov 2019 12:46:56 +0100
Message-Id: <20191111114655.9583-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb port represented by &usbhost1 uses an USB phy internal to the
SoC. We add the phy_type to the base dtsi so the board dts only have to
overwrite it if they use a different configuration. While at it we also
pin the usbhost port to host mode.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts | 2 --
 arch/arm/boot/dts/imx25-pdk.dts                        | 2 --
 arch/arm/boot/dts/imx25.dtsi                           | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index 0fde90df2b546..3f38c2e60a745 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -165,8 +165,6 @@
 };
 
 &usbhost1 {
-	phy_type = "serial";
-	dr_mode = "host";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 05cccd12624cb..fb66884d8a2fa 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -304,8 +304,6 @@
 };
 
 &usbhost1 {
-	phy_type = "serial";
-	dr_mode = "host";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 9a097ef014af5..7c7795b40ee0c 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -570,6 +570,8 @@
 				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy1>;
+				phy_type = "serial";
+				dr_mode = "host";
 				status = "disabled";
 			};
 
-- 
2.24.0.rc1

