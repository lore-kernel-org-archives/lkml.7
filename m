Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA5C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D4A216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfFZNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:32:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57642 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfFZNcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:32:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A0DDE2009AA;
        Wed, 26 Jun 2019 15:32:29 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 92D002009A9;
        Wed, 26 Jun 2019 15:32:29 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E2E56205DB;
        Wed, 26 Jun 2019 15:32:28 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH 10/10] drm/mxsfb: Add support for horizontal stride
Date:   Wed, 26 Jun 2019 16:32:18 +0300
Message-Id: <1561555938-21595-11-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
References: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the eLCDIF block, there is another IP block, used in the past
for EPDC panels. Since the iMX.8mq doesn't have an EPDC connector, this
block is not documented, but we can use it to do additional operations
on the frame buffer.
In this case, we can use the pigeon registers from this IP block in
order to do horizontal crop on the frame buffer processed by the eLCDIF
block.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 79 +++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 26 ++++++++++++-
 drivers/gpu/drm/mxsfb/mxsfb_regs.h | 16 ++++++++
 3 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 02a5684..712494e 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -9,6 +9,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_helper.h>
@@ -430,15 +431,67 @@ void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 	clk_disable_unprepare(mxsfb->clk_axi);
 }
 
+void mxsfb_set_fb_hcrop(struct mxsfb_drm_private *mxsfb, u32 src_w, u32 fb_w)
+{
+	u32 mask_cnt, htotal, hcount;
+	u32 vdctrl2, vdctrl3, vdctrl4, transfer_count;
+	u32 pigeon_12_0, pigeon_12_1, pigeon_12_2;
+
+	if (src_w == fb_w) {
+		writel(0x0, mxsfb->base + HW_EPDC_PIGEON_12_0);
+		writel(0x0, mxsfb->base + HW_EPDC_PIGEON_12_1);
+
+		return;
+	}
+
+	transfer_count = readl(mxsfb->base + LCDC_V4_TRANSFER_COUNT);
+	hcount = TRANSFER_COUNT_GET_HCOUNT(transfer_count);
+
+	transfer_count &= ~TRANSFER_COUNT_SET_HCOUNT(0xffff);
+	transfer_count |= TRANSFER_COUNT_SET_HCOUNT(fb_w);
+	writel(transfer_count, mxsfb->base + LCDC_V4_TRANSFER_COUNT);
+
+	vdctrl2 = readl(mxsfb->base + LCDC_VDCTRL2);
+	htotal  = VDCTRL2_GET_HSYNC_PERIOD(vdctrl2);
+	htotal  += fb_w - hcount;
+	vdctrl2 &= ~VDCTRL2_SET_HSYNC_PERIOD(0x3ffff);
+	vdctrl2 |= VDCTRL2_SET_HSYNC_PERIOD(htotal);
+	writel(vdctrl2, mxsfb->base + LCDC_VDCTRL2);
+
+	vdctrl4 = readl(mxsfb->base + LCDC_VDCTRL4);
+	vdctrl4 &= ~SET_DOTCLK_H_VALID_DATA_CNT(0x3ffff);
+	vdctrl4 |= SET_DOTCLK_H_VALID_DATA_CNT(fb_w);
+	writel(vdctrl4, mxsfb->base + LCDC_VDCTRL4);
+
+	/* configure related pigeon registers */
+	vdctrl3  = readl(mxsfb->base + LCDC_VDCTRL3);
+	mask_cnt = GET_HOR_WAIT_CNT(vdctrl3) - 5;
+
+	pigeon_12_0 = PIGEON_12_0_SET_STATE_MASK(0x24)		|
+		      PIGEON_12_0_SET_MASK_CNT(mask_cnt)	|
+		      PIGEON_12_0_SET_MASK_CNT_SEL(0x6)		|
+		      PIGEON_12_0_POL_ACTIVE_LOW		|
+		      PIGEON_12_0_EN;
+	writel(pigeon_12_0, mxsfb->base + HW_EPDC_PIGEON_12_0);
+
+	pigeon_12_1 = PIGEON_12_1_SET_CLR_CNT(src_w) |
+		      PIGEON_12_1_SET_SET_CNT(0x0);
+	writel(pigeon_12_1, mxsfb->base + HW_EPDC_PIGEON_12_1);
+
+	pigeon_12_2 = 0x0;
+	writel(pigeon_12_2, mxsfb->base + HW_EPDC_PIGEON_12_2);
+}
+
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			       struct drm_plane_state *old_state)
 {
 	struct drm_simple_display_pipe *pipe = &mxsfb->pipe;
 	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_plane_state *state = pipe->plane.state;
 	struct drm_framebuffer *fb = pipe->plane.state->fb;
 	struct drm_framebuffer *old_fb = old_state->fb;
 	struct drm_pending_vblank_event *event;
-	dma_addr_t paddr;
+	u32 fb_addr, src_off, src_w, stride, cpp = 0;
 
 	spin_lock_irq(&crtc->dev->event_lock);
 	event = crtc->state->event;
@@ -453,15 +506,29 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	paddr = mxsfb_get_fb_paddr(mxsfb);
-	if (paddr) {
+	if (!fb || !old_fb)
+		return;
+
+	fb_addr = mxsfb_get_fb_paddr(mxsfb);
+	if (mxsfb->devdata->ipversion >= 4) {
+		cpp = fb->format->cpp[0];
+		src_off = (state->src_y >> 16) * fb->pitches[0] +
+			  (state->src_x >> 16) * cpp;
+		fb_addr += fb->offsets[0] + src_off;
+	}
+
+	if (fb_addr) {
 		clk_prepare_enable(mxsfb->clk_axi);
-		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
+		writel(fb_addr, mxsfb->base + mxsfb->devdata->next_buf);
 		clk_disable_unprepare(mxsfb->clk_axi);
 	}
 
-	if (!fb || !old_fb)
-		return;
+	if (mxsfb->devdata->ipversion >= 4 &&
+	    unlikely(drm_atomic_crtc_needs_modeset(state->crtc->state))) {
+		stride = DIV_ROUND_UP(fb->pitches[0], cpp);
+		src_w = state->src_w >> 16;
+		mxsfb_set_fb_hcrop(mxsfb, src_w, stride);
+	}
 
 	/*
 	 * TODO: Currently, we only support pixel format change, but we need
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index a164f4d..ffc4b0a 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -132,6 +132,7 @@ static int mxsfb_atomic_helper_check(struct drm_device *dev,
 		if (old_bpp != new_bpp)
 			new_state->mode_changed = true;
 	}
+
 	return ret;
 }
 
@@ -145,6 +146,25 @@ static const struct drm_mode_config_helper_funcs mxsfb_mode_config_helpers = {
 	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
 };
 
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
@@ -241,6 +261,7 @@ static void mxsfb_pipe_disable_vblank(struct drm_simple_display_pipe *pipe)
 }
 
 static struct drm_simple_display_pipe_funcs mxsfb_funcs = {
+	.check          = mxsfb_pipe_check,
 	.enable		= mxsfb_pipe_enable,
 	.disable	= mxsfb_pipe_disable,
 	.update		= mxsfb_pipe_update,
@@ -344,8 +365,9 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 
 	drm->mode_config.min_width	= MXSFB_MIN_XRES;
 	drm->mode_config.min_height	= MXSFB_MIN_YRES;
-	drm->mode_config.max_width	= max_res[0];
-	drm->mode_config.max_height	= max_res[1];
+	/* Add additional 16 pixels for possible strides */
+	drm->mode_config.max_width	= max_res[0] + 16;
+	drm->mode_config.max_height	= max_res[1] + 16;
 	drm->mode_config.funcs		= &mxsfb_mode_config_funcs;
 	drm->mode_config.helper_private	= &mxsfb_mode_config_helpers;
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
index 2583a69..54b0ed1 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
@@ -40,6 +40,11 @@
 #define LCDC_AS_BUF			0x220
 #define LCDC_AS_NEXT_BUF		0x230
 
+/* pigeon registers for crop */
+#define HW_EPDC_PIGEON_12_0		0xb00
+#define HW_EPDC_PIGEON_12_1		0xb10
+#define HW_EPDC_PIGEON_12_2		0xb20
+
 /* reg bit manipulation */
 #define REG_MASK(e, s) (((1 << ((e) - (s) + 1)) - 1) << (s))
 #define REG_PUT(x, e, s) (((x) << (s)) & REG_MASK(e, s))
@@ -121,6 +126,17 @@
 #define VDCTRL4_SYNC_SIGNALS_ON		BIT(18)
 #define SET_DOTCLK_H_VALID_DATA_CNT(x)	((x) & 0x3ffff)
 
+#define PIGEON_12_0_SET_STATE_MASK(x)	REG_PUT((x), 31, 24)
+#define PIGEON_12_0_SET_MASK_CNT(x)	REG_PUT((x), 23, 12)
+#define PIGEON_12_0_SET_MASK_CNT_SEL(x)	REG_PUT((x), 11,  8)
+#define PIGEON_12_0_SET_OFFSET(x)	REG_PUT((x),  7,  4)
+#define PIGEON_12_0_SET_INC_SEL(x)	REG_PUT((x),  3,  2)
+#define PIGEON_12_0_POL_ACTIVE_LOW	BIT(1)
+#define PIGEON_12_0_EN			BIT(0)
+
+#define PIGEON_12_1_SET_CLR_CNT(x)	REG_PUT((x), 31, 16)
+#define PIGEON_12_1_SET_SET_CNT(x)	REG_PUT((x), 15,  0)
+
 #define DEBUG0_HSYNC			(1 < 26)
 #define DEBUG0_VSYNC			(1 < 25)
 
-- 
2.7.4

