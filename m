Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3C1233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfHUKQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:16:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45772 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbfHUKQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:16:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 552A3200241;
        Wed, 21 Aug 2019 12:16:24 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 481CA200005;
        Wed, 21 Aug 2019 12:16:24 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98DB920612;
        Wed, 21 Aug 2019 12:16:23 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] drm/mxsfb: Update mxsfb to support LCD reset
Date:   Wed, 21 Aug 2019 13:15:51 +0300
Message-Id: <1566382555-12102-12-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eLCDIF controller has control pin for the external LCD reset pin.
Add support for it and assert this pin in enable and de-assert it in
disable.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 14 ++++++++++----
 drivers/gpu/drm/mxsfb/mxsfb_regs.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 1be29f5..a4ba368 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -224,9 +224,12 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
 
-	if (mxsfb->devdata->ipversion >= 4)
+	if (mxsfb->devdata->ipversion >= 4) {
 		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
 		       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		/* Assert LCD Reset bit */
+		writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+	}
 
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
@@ -244,11 +247,14 @@ static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 {
 	u32 reg;
 
-	if (mxsfb->devdata->ipversion >= 4)
+	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
+
+	if (mxsfb->devdata->ipversion >= 4) {
 		writel(CTRL2_OUTSTANDING_REQS(0x7),
 		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
-
-	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
+		/* De-assert LCD Reset bit */
+		writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
+	}
 
 	/*
 	 * Even if we disable the controller here, it will still continue
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
index dc4daa0..0f63ba1 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
@@ -108,6 +108,8 @@
 #define CTRL2_LINE_PATTERN_BGR	5
 #define CTRL2_LINE_PATTERN_CLR	7
 
+#define CTRL2_LCD_RESET			BIT(0)
+
 #define TRANSFER_COUNT_SET_VCOUNT(x)	REG_PUT((x), 31, 16)
 #define TRANSFER_COUNT_GET_VCOUNT(x)	REG_GET((x), 31, 16)
 #define TRANSFER_COUNT_SET_HCOUNT(x)	REG_PUT((x), 15, 0)
-- 
2.7.4

