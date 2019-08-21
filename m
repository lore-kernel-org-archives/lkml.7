Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6905C3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9D822D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfHUKRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:17:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44618 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfHUKQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:16:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 15C6D1A02E7;
        Wed, 21 Aug 2019 12:16:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0888E1A01DF;
        Wed, 21 Aug 2019 12:16:19 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 595C220612;
        Wed, 21 Aug 2019 12:16:18 +0200 (CEST)
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
Subject: [PATCH v3 04/15] drm/mxsfb: Reset vital registers for a proper initialization
Date:   Wed, 21 Aug 2019 13:15:44 +0300
Message-Id: <1566382555-12102-5-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the registers, like LCDC_CTRL, CTRL2_OUTSTANDING_REQS and
CTRL1_RECOVERY_ON_UNDERFLOW needs to be properly cleared/initialized
for a better start and stop routine.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index b69ace8..5e44f57 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -127,6 +127,10 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
 
+	if (mxsfb->devdata->ipversion >= 4)
+		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
+		       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
 
@@ -136,12 +140,19 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 	writel(reg, mxsfb->base + LCDC_VDCTRL4);
 
 	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_SET);
+	writel(CTRL1_RECOVERY_ON_UNDERFLOW, mxsfb->base + LCDC_CTRL1 + REG_SET);
 }
 
 static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 {
 	u32 reg;
 
+	if (mxsfb->devdata->ipversion >= 4)
+		writel(CTRL2_OUTSTANDING_REQS(0x7),
+		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
+
+	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
+
 	/*
 	 * Even if we disable the controller here, it will still continue
 	 * until its FIFOs are running out of data
@@ -295,6 +306,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 	dma_addr_t paddr;
 
 	mxsfb_enable_axi_clk(mxsfb);
+	writel(0, mxsfb->base + LCDC_CTRL);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
 
 	/* Write cur_buf as well to avoid an initial corrupt frame */
-- 
2.7.4

