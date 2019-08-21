Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F13C3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91741233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfHUKRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:17:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44698 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbfHUKQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:16:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 959841A0417;
        Wed, 21 Aug 2019 12:16:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DBCC1A0045;
        Wed, 21 Aug 2019 12:16:20 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CB81B20612;
        Wed, 21 Aug 2019 12:16:19 +0200 (CEST)
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
Subject: [PATCH v3 06/15] drm/mxsfb: Update mxsfb with additional pixel formats
Date:   Wed, 21 Aug 2019 13:15:46 +0300
Message-Id: <1566382555-12102-7-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since version 4 of eLCDIF, there are some registers that can do
transformations on the input data, like re-arranging the pixel
components. By doing that, we can support more pixel formats.
This patch adds support for X/ABGR and RGBX/A. Although, the local alpha
is not supported by eLCDIF, the alpha pixel formats were added to the
supported pixel formats but it will be ignored. This was necessary since
there are systems (like Android) that requires such pixel formats.

Also, add support for the following pixel formats:
            16 bpp: RG16 ,BG16, XR15, XB15, AR15, AB15

Set the bus format based on input from the user and panel
capabilities.
Save the bus format in crtc->mode.private_flags, so the bridge can
use it.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 147 ++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  |  30 ++++++--
 drivers/gpu/drm/mxsfb/mxsfb_drv.h  |   3 +-
 drivers/gpu/drm/mxsfb/mxsfb_regs.h |  15 ++++
 4 files changed, 163 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 5e44f57..1be29f5 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -43,14 +43,17 @@ static u32 set_hsync_pulse_width(struct mxsfb_drm_private *mxsfb, u32 val)
 }
 
 /* Setup the MXSFB registers for decoding the pixels out of the framebuffer */
-static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb)
+static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb, bool update)
 {
 	struct drm_crtc *crtc = &mxsfb->pipe.crtc;
 	struct drm_device *drm = crtc->dev;
 	const u32 format = crtc->primary->state->fb->format->format;
-	u32 ctrl, ctrl1;
+	u32 ctrl = 0, ctrl1 = 0;
+	bool bgr_format = true;
+	struct drm_format_name_buf format_name_buf;
 
-	ctrl = CTRL_BYPASS_COUNT | CTRL_MASTER;
+	if (!update)
+		ctrl = CTRL_BYPASS_COUNT | CTRL_MASTER;
 
 	/*
 	 * WARNING: The bus width, CTRL_SET_BUS_WIDTH(), is configured to
@@ -59,64 +62,158 @@ static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb)
 	 * to arbitrary value. This limitation should not pose an issue.
 	 */
 
-	/* CTRL1 contains IRQ config and status bits, preserve those. */
-	ctrl1 = readl(mxsfb->base + LCDC_CTRL1);
-	ctrl1 &= CTRL1_CUR_FRAME_DONE_IRQ_EN | CTRL1_CUR_FRAME_DONE_IRQ;
+	if (!update) {
+		/* CTRL1 contains IRQ config and status bits, preserve those. */
+		ctrl1 = readl(mxsfb->base + LCDC_CTRL1);
+		ctrl1 &= CTRL1_CUR_FRAME_DONE_IRQ_EN | CTRL1_CUR_FRAME_DONE_IRQ;
+	}
+
+	DRM_DEV_DEBUG_DRIVER(drm->dev, "Setting up %s mode\n",
+			     drm_get_format_name(format, &format_name_buf));
+
+	/* Do some clean-up that we might have from a previous mode */
+	ctrl &= ~CTRL_SHIFT_DIR(1);
+	ctrl &= ~CTRL_SHIFT_NUM(0x3f);
+	if (mxsfb->devdata->ipversion >= 4)
+		writel(CTRL2_ODD_LINE_PATTERN(CTRL2_LINE_PATTERN_CLR) |
+		       CTRL2_EVEN_LINE_PATTERN(CTRL2_LINE_PATTERN_CLR),
+		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
 
 	switch (format) {
-	case DRM_FORMAT_RGB565:
-		dev_dbg(drm->dev, "Setting up RGB565 mode\n");
+	case DRM_FORMAT_BGR565: /* BG16 */
+		if (mxsfb->devdata->ipversion < 4)
+			goto err;
+		writel(CTRL2_ODD_LINE_PATTERN(CTRL2_LINE_PATTERN_BGR) |
+			CTRL2_EVEN_LINE_PATTERN(CTRL2_LINE_PATTERN_BGR),
+			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		/* Fall through */
+	case DRM_FORMAT_RGB565: /* RG16 */
+		ctrl |= CTRL_SET_WORD_LENGTH(0);
+		ctrl &= ~CTRL_DF16;
+		ctrl1 |= CTRL1_SET_BYTE_PACKAGING(0xf);
+		break;
+	case DRM_FORMAT_XBGR1555: /* XB15 */
+	case DRM_FORMAT_ABGR1555: /* AB15 */
+		if (mxsfb->devdata->ipversion < 4)
+			goto err;
+		writel(CTRL2_ODD_LINE_PATTERN(CTRL2_LINE_PATTERN_BGR) |
+			CTRL2_EVEN_LINE_PATTERN(CTRL2_LINE_PATTERN_BGR),
+			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		/* Fall through */
+	case DRM_FORMAT_XRGB1555: /* XR15 */
+	case DRM_FORMAT_ARGB1555: /* AR15 */
 		ctrl |= CTRL_SET_WORD_LENGTH(0);
+		ctrl |= CTRL_DF16;
 		ctrl1 |= CTRL1_SET_BYTE_PACKAGING(0xf);
 		break;
-	case DRM_FORMAT_XRGB8888:
-		dev_dbg(drm->dev, "Setting up XRGB8888 mode\n");
+	case DRM_FORMAT_RGBX8888: /* RX24 */
+	case DRM_FORMAT_RGBA8888: /* RA24 */
+		/* RGBX - > 0RGB */
+		ctrl |= CTRL_SHIFT_DIR(1);
+		ctrl |= CTRL_SHIFT_NUM(8);
+		bgr_format = false;
+		/* Fall through */
+	case DRM_FORMAT_XBGR8888: /* XB24 */
+	case DRM_FORMAT_ABGR8888: /* AB24 */
+		if (bgr_format) {
+			if (mxsfb->devdata->ipversion < 4)
+				goto err;
+			writel(CTRL2_ODD_LINE_PATTERN(CTRL2_LINE_PATTERN_BGR) |
+			       CTRL2_EVEN_LINE_PATTERN(CTRL2_LINE_PATTERN_BGR),
+			       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		}
+		/* Fall through */
+	case DRM_FORMAT_XRGB8888: /* XR24 */
+	case DRM_FORMAT_ARGB8888: /* AR24 */
 		ctrl |= CTRL_SET_WORD_LENGTH(3);
 		/* Do not use packed pixels = one pixel per word instead. */
 		ctrl1 |= CTRL1_SET_BYTE_PACKAGING(0x7);
 		break;
 	default:
-		dev_err(drm->dev, "Unhandled pixel format %08x\n", format);
-		return -EINVAL;
+		goto err;
 	}
 
-	writel(ctrl1, mxsfb->base + LCDC_CTRL1);
-	writel(ctrl, mxsfb->base + LCDC_CTRL);
+	if (update) {
+		writel(ctrl, mxsfb->base + LCDC_CTRL + REG_SET);
+		writel(ctrl1, mxsfb->base + LCDC_CTRL1 + REG_SET);
+	} else {
+		writel(ctrl, mxsfb->base + LCDC_CTRL);
+		writel(ctrl1, mxsfb->base + LCDC_CTRL1);
+	}
 
 	return 0;
+
+err:
+	DRM_DEV_ERROR(drm->dev, "Unhandled pixel format: %s\n",
+		      drm_get_format_name(format, &format_name_buf));
+
+	return -EINVAL;
+}
+
+static u32 get_bus_format_from_bpp(u32 bpp)
+{
+	switch (bpp) {
+	case 16:
+		return MEDIA_BUS_FMT_RGB565_1X16;
+	case 18:
+		return MEDIA_BUS_FMT_RGB666_1X18;
+	case 24:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	default:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	}
 }
 
 static void mxsfb_set_bus_fmt(struct mxsfb_drm_private *mxsfb)
 {
 	struct drm_crtc *crtc = &mxsfb->pipe.crtc;
+	unsigned int bits_per_pixel = crtc->primary->state->fb->format->depth;
 	struct drm_device *drm = crtc->dev;
 	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
-	u32 reg;
-
-	reg = readl(mxsfb->base + LCDC_CTRL);
+	int num_bus_formats = mxsfb->connector->display_info.num_bus_formats;
+	const u32 *bus_formats = mxsfb->connector->display_info.bus_formats;
+	u32 reg = 0;
+	int i = 0;
+
+	/* match the user requested bus_format to one supported by the panel */
+	if (num_bus_formats) {
+		u32 user_bus_format = get_bus_format_from_bpp(bits_per_pixel);
+
+		bus_format = bus_formats[0];
+		for (i = 0; i < num_bus_formats; i++) {
+			if (user_bus_format == bus_formats[i]) {
+				bus_format = user_bus_format;
+				break;
+			}
+		}
+	}
 
-	if (mxsfb->connector->display_info.num_bus_formats)
-		bus_format = mxsfb->connector->display_info.bus_formats[0];
+	/*
+	 * CRTC will dictate the bus format via private_flags[16:1]
+	 * and private_flags[0] will signal a bus format change
+	 */
+	crtc->mode.private_flags &= ~0x1FFFF; /* clear bus format */
+	crtc->mode.private_flags |= (bus_format << 1); /* set bus format */
+	crtc->mode.private_flags |= 0x1; /* bus format change indication*/
 
 	DRM_DEV_DEBUG_DRIVER(drm->dev, "Using bus_format: 0x%08X\n",
 			     bus_format);
 
-	reg &= ~CTRL_BUS_WIDTH_MASK;
 	switch (bus_format) {
 	case MEDIA_BUS_FMT_RGB565_1X16:
-		reg |= CTRL_SET_BUS_WIDTH(STMLCDIF_16BIT);
+		reg = CTRL_SET_BUS_WIDTH(STMLCDIF_16BIT);
 		break;
 	case MEDIA_BUS_FMT_RGB666_1X18:
-		reg |= CTRL_SET_BUS_WIDTH(STMLCDIF_18BIT);
+		reg = CTRL_SET_BUS_WIDTH(STMLCDIF_18BIT);
 		break;
 	case MEDIA_BUS_FMT_RGB888_1X24:
-		reg |= CTRL_SET_BUS_WIDTH(STMLCDIF_24BIT);
+		reg = CTRL_SET_BUS_WIDTH(STMLCDIF_24BIT);
 		break;
 	default:
 		dev_err(drm->dev, "Unknown media bus format %d\n", bus_format);
 		break;
 	}
-	writel(reg, mxsfb->base + LCDC_CTRL);
+	writel(reg, mxsfb->base + LCDC_CTRL + REG_SET);
 }
 
 static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
@@ -238,7 +335,7 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	/* Clear the FIFOs */
 	writel(CTRL1_FIFO_CLEAR, mxsfb->base + LCDC_CTRL1 + REG_SET);
 
-	err = mxsfb_set_pixel_fmt(mxsfb);
+	err = mxsfb_set_pixel_fmt(mxsfb, false);
 	if (err)
 		return;
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 9dc69b7..2743975 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -43,6 +43,27 @@ enum mxsfb_devtype {
 	MXSFB_V4,
 };
 
+/*
+ * When adding new formats, make sure to update the num_formats from
+ * mxsfb_devdata below.
+ */
+static const u32 mxsfb_formats[] = {
+	/* MXSFB_V3 */
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGB565,
+	/* MXSFB_V4 */
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_BGR565
+};
+
 static const struct mxsfb_devdata mxsfb_devdata[] = {
 	[MXSFB_V3] = {
 		.transfer_count	= LCDC_V3_TRANSFER_COUNT,
@@ -52,6 +73,7 @@ static const struct mxsfb_devdata mxsfb_devdata[] = {
 		.hs_wdth_mask	= 0xff,
 		.hs_wdth_shift	= 24,
 		.ipversion	= 3,
+		.num_formats	= 3,
 	},
 	[MXSFB_V4] = {
 		.transfer_count	= LCDC_V4_TRANSFER_COUNT,
@@ -61,14 +83,10 @@ static const struct mxsfb_devdata mxsfb_devdata[] = {
 		.hs_wdth_mask	= 0x3fff,
 		.hs_wdth_shift	= 18,
 		.ipversion	= 4,
+		.num_formats	= ARRAY_SIZE(mxsfb_formats),
 	},
 };
 
-static const uint32_t mxsfb_formats[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_RGB565
-};
-
 static struct mxsfb_drm_private *
 drm_pipe_to_mxsfb_drm_private(struct drm_simple_display_pipe *pipe)
 {
@@ -244,7 +262,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 	}
 
 	ret = drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
-			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
+			mxsfb_formats, mxsfb->devdata->num_formats, NULL,
 			mxsfb->connector);
 	if (ret < 0) {
 		dev_err(drm->dev, "Cannot setup simple display pipe\n");
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index 0b65b51..8fb65d3 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -16,6 +16,7 @@ struct mxsfb_devdata {
 	unsigned int	 hs_wdth_mask;
 	unsigned int	 hs_wdth_shift;
 	unsigned int	 ipversion;
+	unsigned int	 num_formats;
 };
 
 struct mxsfb_drm_private {
@@ -42,6 +43,6 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb);
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb);
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb);
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
-			       struct drm_plane_state *state);
+			       struct drm_plane_state *old_state);
 
 #endif /* __MXSFB_DRV_H__ */
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
index 9fcb1db..dc4daa0 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
@@ -44,6 +44,11 @@
 #define REG_PUT(x, h, l) (((x) << (l)) & GENMASK(h, l))
 #define REG_GET(x, h, l) (((x) & GENMASK(h, l)) >> (l))
 
+#define SWIZZLE_LE		0 /* Little-Endian or No swap */
+#define SWIZZLE_BE		1 /* Big-Endian or swap all */
+#define SWIZZLE_HWD		2 /* Swap half-words */
+#define SWIZZLE_HWD_BYTE	3 /* Swap bytes within each half-word */
+
 #define CTRL_SFTRST			BIT(31)
 #define CTRL_CLKGATE			BIT(30)
 #define CTRL_SHIFT_DIR(x)		REG_PUT((x), 26, 26)
@@ -93,6 +98,16 @@
 #define REQ_8	3
 #define REQ_16	4
 
+#define CTRL2_ODD_LINE_PATTERN(x)	REG_PUT((x), 18, 16)
+#define CTRL2_EVEN_LINE_PATTERN(x)	REG_PUT((x), 14, 12)
+#define CTRL2_LINE_PATTERN_RGB	0
+#define CTRL2_LINE_PATTERN_RBG	1
+#define CTRL2_LINE_PATTERN_GBR	2
+#define CTRL2_LINE_PATTERN_GRB	3
+#define CTRL2_LINE_PATTERN_BRG	4
+#define CTRL2_LINE_PATTERN_BGR	5
+#define CTRL2_LINE_PATTERN_CLR	7
+
 #define TRANSFER_COUNT_SET_VCOUNT(x)	REG_PUT((x), 31, 16)
 #define TRANSFER_COUNT_GET_VCOUNT(x)	REG_GET((x), 31, 16)
 #define TRANSFER_COUNT_SET_HCOUNT(x)	REG_PUT((x), 15, 0)
-- 
2.7.4

