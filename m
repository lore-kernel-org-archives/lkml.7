Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53322C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33716222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfIZIZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:25:14 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:33036 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIZIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:25:12 -0400
Received: from localhost (unknown [192.168.167.193])
        by lucky1.263xmail.com (Postfix) with ESMTP id 95CCE43BB3;
        Thu, 26 Sep 2019 16:25:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24701T140118476191488S1569486296531843_;
        Thu, 26 Sep 2019 16:25:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <bc20040257b92962ff88520f61809994>
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
Subject: [PATCH v2 3/3] drm/rockchip: Add support 10bit yuv format
Date:   Thu, 26 Sep 2019 16:24:49 +0800
Message-Id: <1569486289-152061-4-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support 10bit yuv format display for rockchip some socs,
include:
    RK3288/RK3228/RK3328/RK3368/RK3399

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 16 ++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ce74218..4b87d88 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -249,6 +249,21 @@ static bool has_rb_swapped(uint32_t format)
 	}
 }
 
+static bool is_10bit_yuv(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV12_10:
+	case DRM_FORMAT_NV21_10:
+	case DRM_FORMAT_NV16_10:
+	case DRM_FORMAT_NV61_10:
+	case DRM_FORMAT_NV24_10:
+	case DRM_FORMAT_NV42_10:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static u32 rockchip_vop_get_offset(struct drm_plane_state *state, u8 plane)
 {
 	const struct drm_format_info *info;
@@ -913,6 +928,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
 		VOP_WIN_SET(vop, win, uv_vir, DIV_ROUND_UP(fb->pitches[1], 4));
 		VOP_WIN_SET(vop, win, uv_mst, dma_addr);
+		VOP_WIN_SET(vop, win, fmt_10, is_10bit_yuv(fb->format->format));
 
 		for (i = 0; i < NUM_YUV2YUV_COEFFICIENTS; i++) {
 			VOP_WIN_YUV2YUV_COEFFICIENT_SET(vop,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 2149a889..adc2b0b5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -133,6 +133,7 @@ struct vop_win_phy {
 	struct vop_reg gate;
 	struct vop_reg format;
 	struct vop_reg rb_swap;
+	struct vop_reg fmt_10;
 	struct vop_reg act_info;
 	struct vop_reg dsp_info;
 	struct vop_reg dsp_st;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index d1494be..732e535 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -544,6 +544,7 @@ static const struct vop_win_phy rk3288_win01_data = {
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
+	.fmt_10 = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 4),
 	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
 	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3288_WIN0_DSP_INFO, 0x0fff0fff, 0),
@@ -674,6 +675,7 @@ static const struct vop_win_phy rk3368_win01_data = {
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.enable = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3368_WIN0_CTRL0, 0x7, 1),
+	.fmt_10 = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 4),
 	.rb_swap = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 12),
 	.x_mir_en = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 21),
 	.y_mir_en = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 22),
-- 
2.7.4



