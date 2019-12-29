Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B83C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2814207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="MBpU0JGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfL2NPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 08:15:37 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:37857 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfL2NPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 08:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7oOpo2inSu8WG7brh9iGn0I2sFswOBV0OELwq4Ouxes=; b=MBpU0JGChDgAiVF4Hqa2gGwx5Y
        AsjSDG90e7mJa404xFDi/Tx+kV8MDWdkcAcBbtGcLzRHP8/dZdLyUrOZlyR3Sg54F2UhNWtCMq2gS
        sKkhWvNjNOh9BFm6pUCQ9Nv8H//DOK45PX7+oPW8/yk3ayR237CgroUGpSp5nFS0e+HdVdG1gjat3
        2+wbhHpGN0f2WTkdlvLpA/p8VYUQ451i00MFlSedMv21JkyfMfy/U1Du3oniv4nG4j22GP9Mimfcc
        1xGM46tsnnUIx/JtFwde90DqxOJSqQZMSy9KtKz3fi12H03Ak0PM7xKziYgSRTVJXPayVN91+KTN6
        +kCng0AA==;
Received: from puh7.kyla.fi ([82.130.43.239] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aapo.vienamo@iki.fi>)
        id 1ilYPl-0003b7-EB; Sun, 29 Dec 2019 15:15:25 +0200
From:   Aapo Vienamo <aapo.vienamo@iki.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Aapo Vienamo <aapo.vienamo@iki.fi>
Subject: [PATCH] ARM: mxs: Enable usbphy1 and usb1 on apx4devkit DTS
Date:   Sun, 29 Dec 2019 15:15:03 +0200
Message-Id: <20191229131503.20843-1-aapo.vienamo@iki.fi>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 82.130.43.239
X-SA-Exim-Mail-From: aapo.vienamo@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB host port on the APx4 development board.

Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>
---
 arch/arm/boot/dts/imx28-apx4devkit.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 3a184d13887b..f00d201ce242 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -183,6 +183,12 @@ auart2: serial@8006e000 {
 				pinctrl-0 = <&auart2_2pins_a>;
 				status = "okay";
 			};
+
+			usbphy1: usbphy@8007e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&usb1_pins_a>;
+				status = "okay";
+			};
 		};
 	};
 
@@ -193,6 +199,10 @@ mac0: ethernet@800f0000 {
 			pinctrl-0 = <&mac0_pins_a>;
 			status = "okay";
 		};
+
+		usb1: usb@80090000 {
+		      status = "okay";
+		};
 	};
 
 	regulators {
-- 
2.24.1

