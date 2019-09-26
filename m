Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A94CC47E48
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C24C222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfIZIZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:25:11 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:43254 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfIZIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:25:10 -0400
Received: from localhost (unknown [192.168.167.193])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8A99668135;
        Thu, 26 Sep 2019 16:25:07 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24701T140118476191488S1569486296531843_;
        Thu, 26 Sep 2019 16:25:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1af4b4c1788e9f87dccb81098897a452>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     maarten.lankhorst@linux.intel.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/rockchip: Add rockchip_vop_get_offset to get offset
Date:   Thu, 26 Sep 2019 16:24:48 +0800
Message-Id: <1569486289-152061-3-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rockchip_vop_get_offset to get offset, this can compatible legacy
and block_h/w format describe.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 61 ++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 2f821c5..ce74218 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -249,6 +249,56 @@ static bool has_rb_swapped(uint32_t format)
 	}
 }
 
+static u32 rockchip_vop_get_offset(struct drm_plane_state *state, u8 plane)
+{
+	const struct drm_format_info *info;
+	struct drm_rect *src = &state->src;
+	struct drm_framebuffer *fb = state->fb;
+	u32 format = fb->format->format;
+	u8 h_div = 1, v_div = 1;
+	u32 block_w, block_h, block_size, block_start_y, num_hblocks;
+	u32 sample_x, sample_y;
+	u32 offset;
+
+	info = drm_format_info(format);
+	if (!info || plane >= info->num_planes)
+		return 0;
+
+	if (plane > 0) {
+		h_div = fb->format->hsub;
+		v_div = fb->format->vsub;
+	}
+
+	switch (format) {
+	case DRM_FORMAT_NV12_10:
+	case DRM_FORMAT_NV21_10:
+	case DRM_FORMAT_NV16_10:
+	case DRM_FORMAT_NV61_10:
+	case DRM_FORMAT_NV24_10:
+	case DRM_FORMAT_NV42_10:
+		block_w = drm_format_info_block_width(fb->format, plane);
+		block_h = drm_format_info_block_height(fb->format, plane);
+		block_size = fb->format->char_per_block[plane];
+
+		sample_x = (src->x1 >> 16) / h_div;
+		sample_y = (src->y1 >> 16) / v_div;
+		block_start_y = (sample_y / block_h) * block_h;
+		num_hblocks = sample_x / block_w;
+
+		offset = fb->pitches[plane] * block_start_y;
+		offset += block_size * num_hblocks;
+
+		break;
+	default:
+		offset = (src->x1 >> 16) * fb->format->cpp[plane] / h_div;
+		offset += (src->y1 >> 16) * fb->pitches[plane] / v_div;
+
+		break;
+	}
+
+	return offset;
+}
+
 static enum vop_data_format vop_convert_format(uint32_t format)
 {
 	switch (format) {
@@ -832,8 +882,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
 	dsp_st = dsp_sty << 16 | (dsp_stx & 0xffff);
 
-	offset = (src->x1 >> 16) * fb->format->cpp[0];
-	offset += (src->y1 >> 16) * fb->pitches[0];
+	offset = rockchip_vop_get_offset(state, 0);
 	dma_addr = rk_obj->dma_addr + offset + fb->offsets[0];
 
 	/*
@@ -857,16 +906,10 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		    (state->rotation & DRM_MODE_REFLECT_X) ? 1 : 0);
 
 	if (is_yuv) {
-		int hsub = fb->format->hsub;
-		int vsub = fb->format->vsub;
-		int bpp = fb->format->cpp[1];
-
 		uv_obj = fb->obj[1];
 		rk_uv_obj = to_rockchip_obj(uv_obj);
 
-		offset = (src->x1 >> 16) * bpp / hsub;
-		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
-
+		offset = rockchip_vop_get_offset(state, 1);
 		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
 		VOP_WIN_SET(vop, win, uv_vir, DIV_ROUND_UP(fb->pitches[1], 4));
 		VOP_WIN_SET(vop, win, uv_mst, dma_addr);
-- 
2.7.4



