Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9672FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FB020989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfEJLI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:08:57 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49983 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfEJLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:08:57 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 462351C000D;
        Fri, 10 May 2019 11:08:52 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 1/6] drm/rockchip: Change the scl_vop_cal_scl_fac to pass drm_format_info
Date:   Fri, 10 May 2019 13:08:46 +0200
Message-Id: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip VOP driver has a function, scl_vop_cal_scl_fac, that will
lookup the drm_format_info structure from the fourcc passed to it by its
caller.

However, its only caller already derefences the drm_format_info structure
it has access to to retrieve that fourcc. Change the prototype of that
function to pass the drm_format_info structure directly, removing the need
for an extra lookup.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 20a9c296d027..9c0d6b367709 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -315,14 +315,13 @@ static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
 
 static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 			     uint32_t src_w, uint32_t src_h, uint32_t dst_w,
-			     uint32_t dst_h, uint32_t pixel_format)
+			     uint32_t dst_h, const struct drm_format_info *info)
 {
 	uint16_t yrgb_hor_scl_mode, yrgb_ver_scl_mode;
 	uint16_t cbcr_hor_scl_mode = SCALE_NONE;
 	uint16_t cbcr_ver_scl_mode = SCALE_NONE;
-	int hsub = drm_format_horz_chroma_subsampling(pixel_format);
-	int vsub = drm_format_vert_chroma_subsampling(pixel_format);
-	const struct drm_format_info *info;
+	int hsub = drm_format_horz_chroma_subsampling(info->format);
+	int vsub = drm_format_vert_chroma_subsampling(info->format);
 	bool is_yuv = false;
 	uint16_t cbcr_src_w = src_w / hsub;
 	uint16_t cbcr_src_h = src_h / vsub;
@@ -331,8 +330,6 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	uint32_t val;
 	int vskiplines;
 
-	info = drm_format_info(pixel_format);
-
 	if (info->is_yuv)
 		is_yuv = true;
 
@@ -856,7 +853,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	if (win->phy->scl)
 		scl_vop_cal_scl_fac(vop, win, actual_w, actual_h,
 				    drm_rect_width(dest), drm_rect_height(dest),
-				    fb->format->format);
+				    fb->format);
 
 	VOP_WIN_SET(vop, win, act_info, act_info);
 	VOP_WIN_SET(vop, win, dsp_info, dsp_info);

base-commit: a802303934b3bd4df6e2fc8bf2e4ebced1c37556
-- 
git-series 0.9.1
