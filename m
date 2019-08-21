Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C92DC3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3112332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfHUKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:16:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44698 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbfHUKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:16:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CF7441A0411;
        Wed, 21 Aug 2019 12:16:22 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C23301A0304;
        Wed, 21 Aug 2019 12:16:22 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0917420612;
        Wed, 21 Aug 2019 12:16:21 +0200 (CEST)
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
Subject: [PATCH v3 09/15] drm/mxsfb: Add max-memory-bandwidth property for MXSFB
Date:   Wed, 21 Aug 2019 13:15:49 +0300
Message-Id: <1566382555-12102-10-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of stability issues, we may want to limit the maximum bandwidth
required by the MXSFB (eLCDIF) driver.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 48 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index f51c8a3..deb5e2b 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -161,6 +161,49 @@ static const struct drm_mode_config_helper_funcs mxsfb_mode_config_helpers = {
 	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
 };
 
+enum drm_mode_status mxsfb_pipe_mode_valid(struct drm_crtc *crtc,
+					   const struct drm_display_mode *mode)
+{
+	struct drm_simple_display_pipe *pipe =
+		container_of(crtc, struct drm_simple_display_pipe, crtc);
+	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	u32 bpp;
+	u64 bw;
+
+	if (!pipe->plane.state->fb)
+		bpp = 32;
+	else
+		bpp = pipe->plane.state->fb->format->depth;
+
+	bw = mode->crtc_clock * 1000;
+	bw = bw * mode->hdisplay * mode->vdisplay * (bpp / 8);
+	bw = div_u64(bw, mode->htotal * mode->vtotal);
+
+	if (mxsfb->max_bw && (bw > mxsfb->max_bw))
+		return MODE_BAD;
+
+	return MODE_OK;
+}
+
+static int mxsfb_pipe_check(struct drm_simple_display_pipe *pipe,
+			    struct drm_plane_state *plane_state,
+			    struct drm_crtc_state *crtc_state)
+{
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
+
+	/* force 'mode_changed' when fb pitches changed, since
+	 * the pitch related registers configuration of LCDIF
+	 * can not be done when LCDIF is running.
+	 */
+	if (old_fb && likely(!crtc_state->mode_changed)) {
+		if (old_fb->pitches[0] != fb->pitches[0])
+			crtc_state->mode_changed = true;
+	}
+
+	return 0;
+}
+
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
@@ -251,6 +294,8 @@ static void mxsfb_pipe_disable_vblank(struct drm_simple_display_pipe *pipe)
 }
 
 static struct drm_simple_display_pipe_funcs mxsfb_funcs = {
+	.mode_valid	= mxsfb_pipe_mode_valid,
+	.check          = mxsfb_pipe_check,
 	.enable		= mxsfb_pipe_enable,
 	.disable	= mxsfb_pipe_disable,
 	.update		= mxsfb_pipe_update,
@@ -290,6 +335,9 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 	if (IS_ERR(mxsfb->clk_disp_axi))
 		mxsfb->clk_disp_axi = NULL;
 
+	of_property_read_u32(drm->dev->of_node, "max-memory-bandwidth",
+			     &mxsfb->max_bw);
+
 	ret = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index 8fb65d3..a178173 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -32,6 +32,8 @@ struct mxsfb_drm_private {
 	struct drm_connector		*connector;
 	struct drm_panel		*panel;
 	struct drm_bridge		*bridge;
+
+	u32				max_bw;
 };
 
 int mxsfb_setup_crtc(struct drm_device *dev);
-- 
2.7.4

