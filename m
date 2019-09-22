Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9345DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A20820882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179485;
	bh=x3CIsCXcVinP9qVLbt8vSkv0DvTQeBfbKhDw/hdnX+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nHuz/2szgJ/fQscrYw5yiI079q1cN0OBBmdBR2CA8uZlEQqTkMB7M9m66j4JtHbSe
	 fXhFjtV2Fz+8vPVM/dgzIDd7UIGWmJSFu4WPACvouTxgl9hodUQz0nvqkNppPY0S6W
	 FVQ6es+uG7Ru0hI8CzMVTTef5MPypZWP2lEbQw2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfIVTLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408241AbfIVS6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:58:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9331021D7F;
        Sun, 22 Sep 2019 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178709;
        bh=x3CIsCXcVinP9qVLbt8vSkv0DvTQeBfbKhDw/hdnX+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbsGXuUtUHSQQgXDHPr/bVXpFZHrV4Vdl9D5Mx3uING/JIYePQBLs6fud+IWxAjS9
         VyU+c3hr0P9EeA0vOrf3OaPgF7UlQPYlxaYuN97tsE6Y0vnI5R/RZirw5qJhPijhAk
         0i+XP7Tvgte2y/nUP2z5AWmTG+bTxaLVa0NLebws=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 44/89] ARM: dts: imx7d: cl-som-imx7: make ethernet work again
Date:   Sun, 22 Sep 2019 14:56:32 -0400
Message-Id: <20190922185717.3412-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: André Draszik <git@andred.net>

[ Upstream commit 9846a4524ac90b63496580b7ad50674b40d92a8f ]

Recent changes to the atheros at803x driver caused
ethernet to stop working on this board.
In particular commit 6d4cd041f0af
("net: phy: at803x: disable delay only for RGMII mode")
and commit cd28d1d6e52e
("net: phy: at803x: Disable phy delay for RGMII mode")
fix the AR8031 driver to configure the phy's (RX/TX)
delays as per the 'phy-mode' in the device tree.

This now prevents ethernet from working on this board.

It used to work before those commits, because the
AR8031 comes out of reset with RX delay enabled, and
the at803x driver didn't touch the delay configuration
at all when "rgmii" mode was selected, and because
arch/arm/mach-imx/mach-imx7d.c:ar8031_phy_fixup()
unconditionally enables TX delay.

Since above commits ar8031_phy_fixup() also has no
effect anymore, and the end-result is that all delays
are disabled in the phy, no ethernet.

Update the device tree to restore functionality.

Signed-off-by: André Draszik <git@andred.net>
CC: Ilya Ledvich <ilya@compulab.co.il>
CC: Igor Grinberg <grinberg@compulab.co.il>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: NXP Linux Team <linux-imx@nxp.com>
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 3cc1fb9ce4418..60a28281d3d16 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -43,7 +43,7 @@
 			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 	fsl,magic-packet;
 	status = "okay";
@@ -69,7 +69,7 @@
 			  <&clks IMX7D_ENET2_TIME_ROOT_CLK>;
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 	fsl,magic-packet;
 	status = "okay";
-- 
2.20.1

