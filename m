Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59A4C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BE021479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfFRVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:43:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35854 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRVnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:43:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id ACA1C285288
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 2/3] drm/rockchip: Add optional support for CRTC gamma LUT
Date:   Tue, 18 Jun 2019 18:34:05 -0300
Message-Id: <20190618213406.7667-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618213406.7667-1-ezequiel@collabora.com>
References: <20190618213406.7667-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional CRTC gamma LUT support, and enable it on RK3288.
This is currently enabled via a separate address resource,
which needs to be specified in the devicetree.

The address resource is required because on some SoCs, such as
RK3288, the LUT address is after the MMU address, and the latter
is supported by a different driver. This prevents the DRM driver
from requesting an entire register space.

The current implementation works for RGB 10-bit tables, as that
is what seems to work on RK3288.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
Changes from RFC:
* Request (an optional) address resource for the LUT.
* Drop support for RK3399, which doesn't seem to work
  out of the box and needs more research.
* Support pass-thru setting when GAMMA_LUT is NULL.
* Add a check for the gamma size, as suggested by Ilia.
* Move gamma setting to atomic_commit_tail, as pointed
  out by Jacopo/Laurent, is the correct way.
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   3 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 106 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   7 ++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
 4 files changed, 118 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 1c69066b6894..bf9ad6240971 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -16,6 +16,7 @@
 #include "rockchip_drm_fb.h"
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_psr.h"
+#include "rockchip_drm_vop.h"
 
 static int rockchip_drm_fb_dirty(struct drm_framebuffer *fb,
 				 struct drm_file *file,
@@ -128,6 +129,8 @@ rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
+	rockchip_drm_vop_gamma_set(old_state);
+
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
 
 	drm_atomic_helper_commit_planes(dev, old_state,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 12ed5265a90b..5b6edbe2673f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -137,6 +137,7 @@ struct vop {
 
 	uint32_t *regsbak;
 	void __iomem *regs;
+	void __iomem *lut_regs;
 
 	/* physical map length of vop register */
 	uint32_t len;
@@ -1153,6 +1154,94 @@ static void vop_wait_for_irq_handler(struct vop *vop)
 	synchronize_irq(vop->irq);
 }
 
+static bool vop_dsp_lut_is_enable(struct vop *vop)
+{
+	return vop_read_reg(vop, 0, &vop->data->common->dsp_lut_en);
+}
+
+static void vop_crtc_write_gamma_lut(struct vop *vop, struct drm_crtc *crtc)
+{
+	struct drm_color_lut *lut = crtc->state->gamma_lut->data;
+	int i;
+
+	for (i = 0; i < crtc->gamma_size; i++) {
+		u32 word;
+
+		word = (drm_color_lut_extract(lut[i].red, 10) << 20) |
+		       (drm_color_lut_extract(lut[i].green, 10) << 10) |
+			drm_color_lut_extract(lut[i].blue, 10);
+		writel(word, vop->lut_regs + i * 4);
+	}
+}
+
+static void vop_crtc_gamma_set(struct vop *vop, struct drm_crtc *crtc,
+			       struct drm_crtc_state *old_state)
+{
+	int idle, ret, i;
+
+	spin_lock(&vop->reg_lock);
+	VOP_REG_SET(vop, common, dsp_lut_en, 0);
+	vop_cfg_done(vop);
+	spin_unlock(&vop->reg_lock);
+
+	ret = readx_poll_timeout(vop_dsp_lut_is_enable, vop,
+			   idle, !idle, 5, 30 * 1000);
+	if (ret)
+		return;
+
+	spin_lock(&vop->reg_lock);
+
+	if (crtc->state->gamma_lut) {
+		if (!old_state->gamma_lut || (crtc->state->gamma_lut->base.id !=
+					      old_state->gamma_lut->base.id))
+			vop_crtc_write_gamma_lut(vop, crtc);
+	} else {
+		for (i = 0; i < crtc->gamma_size; i++) {
+			u32 word;
+
+			word = (i << 20) | (i << 10) | i;
+			writel(word, vop->lut_regs + i * 4);
+		}
+	}
+
+	VOP_REG_SET(vop, common, dsp_lut_en, 1);
+	vop_cfg_done(vop);
+	spin_unlock(&vop->reg_lock);
+}
+
+static int vop_crtc_atomic_check(struct drm_crtc *crtc,
+				   struct drm_crtc_state *crtc_state)
+{
+	struct vop *vop = to_vop(crtc);
+
+	if (vop->lut_regs && crtc_state->color_mgmt_changed &&
+	    crtc_state->gamma_lut) {
+		int len;
+
+		len = drm_color_lut_size(crtc_state->gamma_lut);
+		if (len != crtc->gamma_size) {
+			DRM_DEBUG_KMS("Invalid LUT size; got %d, expected %d\n",
+				      len, crtc->gamma_size);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+void rockchip_drm_vop_gamma_set(struct drm_atomic_state *state)
+{
+	struct drm_crtc_state *old_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
+		struct vop *vop = to_vop(crtc);
+
+		if (vop->lut_regs && crtc->state->color_mgmt_changed)
+			vop_crtc_gamma_set(vop, crtc, old_crtc_state);
+	}
+}
+
 static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
@@ -1205,6 +1294,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 
 static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
 	.mode_fixup = vop_crtc_mode_fixup,
+	.atomic_check = vop_crtc_atomic_check,
 	.atomic_flush = vop_crtc_atomic_flush,
 	.atomic_enable = vop_crtc_atomic_enable,
 	.atomic_disable = vop_crtc_atomic_disable,
@@ -1323,6 +1413,7 @@ static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.disable_vblank = vop_crtc_disable_vblank,
 	.set_crc_source = vop_crtc_set_crc_source,
 	.verify_crc_source = vop_crtc_verify_crc_source,
+	.gamma_set = drm_atomic_helper_legacy_gamma_set,
 };
 
 static void vop_fb_unref_worker(struct drm_flip_work *work, void *val)
@@ -1480,6 +1571,10 @@ static int vop_create_crtc(struct vop *vop)
 		goto err_cleanup_planes;
 
 	drm_crtc_helper_add(crtc, &vop_crtc_helper_funcs);
+	if (vop_data->lut_size) {
+		drm_mode_crtc_set_gamma_size(crtc, vop_data->lut_size);
+		drm_crtc_enable_color_mgmt(crtc, 0, false, vop_data->lut_size);
+	}
 
 	/*
 	 * Create drm_planes for overlay windows with possible_crtcs restricted
@@ -1776,6 +1871,17 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	if (IS_ERR(vop->regs))
 		return PTR_ERR(vop->regs);
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lut");
+	if (res) {
+		if (!vop_data->lut_size) {
+			DRM_DEV_ERROR(dev, "no gamma LUT size defined\n");
+			return -EINVAL;
+		}
+		vop->lut_regs = devm_ioremap_resource(dev, res);
+		if (IS_ERR(vop->lut_regs))
+			return PTR_ERR(vop->lut_regs);
+	}
+
 	vop->regsbak = devm_kzalloc(dev, vop->len, GFP_KERNEL);
 	if (!vop->regsbak)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 2149a889c29d..bd1bcd5a14e9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -7,6 +7,8 @@
 #ifndef _ROCKCHIP_DRM_VOP_H
 #define _ROCKCHIP_DRM_VOP_H
 
+#include <drm/drm_atomic.h>
+
 /*
  * major: IP major version, used for IP structure
  * minor: big feature change under same structure
@@ -67,6 +69,7 @@ struct vop_common {
 	struct vop_reg dither_down_mode;
 	struct vop_reg dither_down_en;
 	struct vop_reg dither_up;
+	struct vop_reg dsp_lut_en;
 	struct vop_reg gate_en;
 	struct vop_reg mmu_en;
 	struct vop_reg out_mode;
@@ -170,6 +173,7 @@ struct vop_data {
 	const struct vop_win_yuv2yuv_data *win_yuv2yuv;
 	const struct vop_win_data *win;
 	unsigned int win_size;
+	unsigned int lut_size;
 
 #define VOP_FEATURE_OUTPUT_RGB10	BIT(0)
 #define VOP_FEATURE_INTERNAL_RGB	BIT(1)
@@ -373,4 +377,7 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
 }
 
 extern const struct component_ops vop_component_ops;
+
+void rockchip_drm_vop_gamma_set(struct drm_atomic_state *state);
+
 #endif /* _ROCKCHIP_DRM_VOP_H */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 7b9c74750f6d..30d49eff3670 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -593,6 +593,7 @@ static const struct vop_common rk3288_common = {
 	.dither_down_en = VOP_REG(RK3288_DSP_CTRL1, 0x1, 2),
 	.pre_dither_down = VOP_REG(RK3288_DSP_CTRL1, 0x1, 1),
 	.dither_up = VOP_REG(RK3288_DSP_CTRL1, 0x1, 6),
+	.dsp_lut_en = VOP_REG(RK3288_DSP_CTRL1, 0x1, 0),
 	.data_blank = VOP_REG(RK3288_DSP_CTRL0, 0x1, 19),
 	.dsp_blank = VOP_REG(RK3288_DSP_CTRL0, 0x3, 18),
 	.out_mode = VOP_REG(RK3288_DSP_CTRL0, 0xf, 0),
@@ -641,6 +642,7 @@ static const struct vop_data rk3288_vop = {
 	.output = &rk3288_output,
 	.win = rk3288_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
+	.lut_size = 1024,
 };
 
 static const int rk3368_vop_intrs[] = {
-- 
2.20.1

