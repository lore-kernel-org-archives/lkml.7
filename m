Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD16C3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C197233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHUKQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:16:32 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45022 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfHUKQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:16:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D7641A01DF;
        Wed, 21 Aug 2019 12:16:27 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 410131A0045;
        Wed, 21 Aug 2019 12:16:27 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 91F8C205D3;
        Wed, 21 Aug 2019 12:16:26 +0200 (CEST)
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
Subject: [PATCH v3 15/15] drm/mxsfb: Add support for live pixel format change
Date:   Wed, 21 Aug 2019 13:15:55 +0300
Message-Id: <1566382555-12102-16-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This IP requires full stop and re-start when changing display timings,
but we can change the pixel format while running.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 317575e..5607fc0 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -494,6 +494,7 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_plane_state *new_state = pipe->plane.state;
 	struct drm_framebuffer *fb = pipe->plane.state->fb;
+	struct drm_framebuffer *old_fb = state->fb;
 	struct drm_pending_vblank_event *event;
 	u32 fb_addr, src_off, src_w, stride, cpp = 0;
 
@@ -510,7 +511,7 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	if (!fb)
+	if (!fb || !old_fb)
 		return;
 
 	fb_addr = mxsfb_get_fb_paddr(mxsfb);
@@ -533,4 +534,17 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 		src_w = new_state->src_w >> 16;
 		mxsfb_set_fb_hcrop(mxsfb, src_w, stride);
 	}
+
+	if (old_fb->format->format != fb->format->format) {
+		struct drm_format_name_buf old_fmt_buf;
+		struct drm_format_name_buf new_fmt_buf;
+
+		DRM_DEV_DEBUG_DRIVER(crtc->dev->dev,
+				"Switching pixel format: %s -> %s\n",
+				drm_get_format_name(old_fb->format->format,
+						    &old_fmt_buf),
+				drm_get_format_name(fb->format->format,
+						    &new_fmt_buf));
+		mxsfb_set_pixel_fmt(mxsfb, true);
+	}
 }
-- 
2.7.4

