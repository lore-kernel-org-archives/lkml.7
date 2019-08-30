Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17571C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBCE22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfH3Hif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:38:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10953 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728129AbfH3Hic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:38:32 -0400
X-UUID: 4eee89582a4a4165bd72f1b0dae05ddf-20190830
X-UUID: 4eee89582a4a4165bd72f1b0dae05ddf-20190830
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2088797645; Fri, 30 Aug 2019 15:38:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 15:38:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 15:38:28 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 2/2] drm/mediatek: Bypass atomic helpers for cursor updates
Date:   Fri, 30 Aug 2019 15:38:19 +0800
Message-ID: <20190830073819.16566-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190830073819.16566-1-bibby.hsieh@mediatek.com>
References: <20190830073819.16566-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the driver to atomic helpers regressed cursor responsiveness,
because cursor updates need their own atomic commits, which have to be
serialized with other commits, that might include fence waits. To avoid
this, in certain conditions, we can bypass the atomic helpers for legacy
cursor update IOCTLs. Currently the conditions are:
 - no asynchronous mode setting commit pending,
 - no asynchronous commit that updates the cursor plane is pending.
With the above two conditions met, we know that the manual cursor state
update will not conflict with any scheduled update.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  | 41 ++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h  |  2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 34 ++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h   |  3 +
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 73 +++++++++++++++++++++++-
 5 files changed, 148 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 7697b40baac0..092e502ed27b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -40,7 +40,7 @@ struct mtk_drm_crtc {
 	struct drm_plane		*planes;
 	unsigned int			layer_nr;
 	bool				pending_planes;
-
+	bool                            cursor_update;
 	void __iomem			*config_regs;
 	const struct mtk_mmsys_reg_data *mmsys_reg_data;
 	struct mtk_disp_mutex		*mutex;
@@ -386,8 +386,45 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 			}
 		}
 		mtk_crtc->pending_planes = false;
-		mtk_atomic_state_put_queue(atomic_state);
+		if (!mtk_crtc->cursor_update)
+			mtk_atomic_state_put_queue(atomic_state);
+		mtk_crtc->cursor_update = false;
+	}
+}
+
+void mtk_drm_crtc_cursor_update(struct drm_crtc *crtc, struct drm_plane *plane,
+				struct drm_plane_state *plane_state)
+{
+	struct mtk_drm_private *priv = crtc->dev->dev_private;
+	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	const struct drm_plane_helper_funcs *plane_helper_funcs =
+			plane->helper_private;
+	int i;
+
+	if (!mtk_crtc->enabled)
+		return;
+
+	mutex_lock(&priv->hw_lock);
+	plane_helper_funcs->atomic_update(plane, plane_state);
+	for (i = 0; i < mtk_crtc->layer_nr; i++) {
+		struct drm_plane *plane = &mtk_crtc->planes[i];
+		struct mtk_plane_state *plane_state;
+
+		plane_state = to_mtk_plane_state(plane->state);
+		if (plane_state->pending.dirty) {
+			plane_state->pending.config = true;
+			plane_state->pending.dirty = false;
+		}
+	}
+	mtk_crtc->pending_planes = true;
+	mtk_crtc->cursor_update = true;
+
+	if (priv->data->shadow_register) {
+		mtk_disp_mutex_acquire(mtk_crtc->mutex);
+		mtk_crtc_ddp_config(crtc);
+		mtk_disp_mutex_release(mtk_crtc->mutex);
 	}
+	mutex_unlock(&priv->hw_lock);
 }
 
 static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
index fcc134eb00c9..46e903be68ec 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
@@ -19,5 +19,7 @@ void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *comp);
 int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			const enum mtk_ddp_comp_id *path,
 			unsigned int path_len);
+void mtk_drm_crtc_cursor_update(struct drm_crtc *crtc, struct drm_plane *plane,
+				struct drm_plane_state *plane_state);
 
 #endif /* MTK_DRM_CRTC_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b0308a3a7483..ca754b954c7c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -80,11 +80,36 @@ static int mtk_atomic_get_crtcs(struct drm_device *drm,
 				struct drm_atomic_state *state)
 {
 	struct mtk_drm_private *private = drm->dev_private;
-	uint32_t crtc_mask;
+	uint32_t crtc_mask, needs_modeset, has_cursor_plane;
+	struct drm_plane *plane;
+	struct drm_plane_state *plane_state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	int i;
 	int ret;
 
 	crtc_mask = mtk_atomic_crtc_mask(drm, state);
 
+	/*
+	 * Allow cursor updates unless there is a pending modeset or cursor
+	 * plane update.
+	 */
+	needs_modeset = 0;
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		if (crtc && drm_atomic_crtc_needs_modeset(crtc_state)) {
+			needs_modeset |= (1 << drm_crtc_index(crtc));
+			break;
+		}
+	}
+
+	has_cursor_plane = 0;
+	for_each_new_plane_in_state(state, plane, plane_state, i) {
+		if (crtc && plane->crtc && plane == plane->crtc->cursor) {
+			has_cursor_plane |= (1 << drm_crtc_index(crtc));
+			break;
+		}
+	}
+
 	/*
 	 * Wait for all pending updates to complete for the set of crtcs being
 	 * changed in this atomic commit
@@ -94,6 +119,8 @@ static int mtk_atomic_get_crtcs(struct drm_device *drm,
 			!(private->commit.crtcs & crtc_mask));
 	if (ret == 0)
 		private->commit.crtcs |= crtc_mask;
+
+	private->commit.flush_for_cursor |= needs_modeset | has_cursor_plane;
 	spin_unlock(&private->commit.crtcs_event.lock);
 
 	return ret;
@@ -112,6 +139,7 @@ static void mtk_atomic_put_crtcs(struct drm_device *drm,
 
 	spin_lock(&private->commit.crtcs_event.lock);
 	private->commit.crtcs &= ~crtc_mask;
+	private->commit.flush_for_cursor &= ~crtc_mask;
 	wake_up_all_locked(&private->commit.crtcs_event);
 	spin_unlock(&private->commit.crtcs_event.lock);
 }
@@ -160,6 +188,7 @@ static void mtk_atomic_wait_for_fences(struct drm_atomic_state *state)
 static void mtk_atomic_complete(struct drm_device *drm,
 				struct drm_atomic_state *state)
 {
+	struct mtk_drm_private *private = drm->dev_private;
 	mtk_atomic_wait_for_fences(state);
 	/*
 	 * Mediatek drm supports runtime PM, so plane registers cannot be
@@ -175,10 +204,12 @@ static void mtk_atomic_complete(struct drm_device *drm,
 	 *
 	 * See the kerneldoc entries for these three functions for more details.
 	 */
+	mutex_lock(&private->hw_lock);
 	drm_atomic_helper_commit_modeset_disables(drm, state);
 	drm_atomic_helper_commit_modeset_enables(drm, state);
 	drm_atomic_helper_commit_planes(drm, state,
 					DRM_PLANE_COMMIT_ACTIVE_ONLY);
+	mutex_unlock(&private->hw_lock);
 
 	drm_atomic_helper_wait_for_vblanks(drm, state);
 
@@ -462,6 +493,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	INIT_LIST_HEAD(&private->unreference.list);
 	spin_lock_init(&private->unreference.lock);
 	init_waitqueue_head(&private->commit.crtcs_event);
+	mutex_init(&private->hw_lock);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 0934f83b860d..4a4c989803d9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -50,6 +50,7 @@ struct mtk_drm_private {
 	struct {
 		uint32_t crtcs;
 		wait_queue_head_t crtcs_event;
+		uint32_t flush_for_cursor;
 	} commit;
 
 	struct drm_atomic_state *suspend_state;
@@ -58,6 +59,8 @@ struct mtk_drm_private {
 		struct list_head	list;
 		spinlock_t		lock;
 	} unreference;
+
+	struct mutex hw_lock;
 };
 
 extern struct platform_driver mtk_ddp_driver;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index f2ef83aed6f9..59dbdaf07425 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -7,6 +7,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_plane_helper.h>
 
 #include "mtk_drm_crtc.h"
@@ -69,8 +70,71 @@ static void mtk_drm_plane_destroy_state(struct drm_plane *plane,
 	kfree(to_mtk_plane_state(state));
 }
 
+static int mtk_plane_cursor_update(struct drm_plane *plane,
+				   struct drm_crtc *crtc,
+				   struct drm_framebuffer *fb,
+				   int crtc_x, int crtc_y,
+				   unsigned int crtc_w, unsigned int crtc_h,
+				   uint32_t src_x, uint32_t src_y,
+				   uint32_t src_w, uint32_t src_h)
+{
+	struct drm_plane_state *plane_state;
+	const struct drm_plane_helper_funcs *plane_helper_funcs =
+			plane->helper_private;
+	int ret;
+
+	plane_state = plane->funcs->atomic_duplicate_state(plane);
+
+	plane_state->crtc_x = crtc_x;
+	plane_state->crtc_y = crtc_y;
+	plane_state->crtc_h = crtc_h;
+	plane_state->crtc_w = crtc_w;
+	plane_state->src_x = src_x;
+	plane_state->src_y = src_y;
+	plane_state->src_h = src_h;
+	plane_state->src_w = src_w;
+
+	drm_atomic_set_fb_for_plane(plane_state, fb);
+
+	ret = plane_helper_funcs->atomic_check(plane, plane_state);
+	if (ret)
+		goto err_destroy;
+
+	swap(plane_state, plane->state);
+
+	mtk_drm_crtc_cursor_update(crtc, plane, plane_state);
+
+err_destroy:
+	plane->funcs->atomic_destroy_state(plane, plane_state);
+	return ret;
+}
+
+static int mtk_plane_update(struct drm_plane *plane,
+			    struct drm_crtc *crtc,
+			    struct drm_framebuffer *fb,
+			    int crtc_x, int crtc_y,
+			    unsigned int crtc_w, unsigned int crtc_h,
+			    uint32_t src_x, uint32_t src_y,
+			    uint32_t src_w, uint32_t src_h,
+			    struct drm_modeset_acquire_ctx *ctx)
+{
+	struct mtk_drm_private *private = plane->dev->dev_private;
+	uint32_t crtc_mask = (1 << drm_crtc_index(crtc));
+
+	if (crtc && plane == crtc->cursor &&
+	    plane->state->crtc == crtc &&
+	    !(private->commit.flush_for_cursor & crtc_mask))
+		return mtk_plane_cursor_update(plane, crtc, fb,
+				crtc_x, crtc_y, crtc_w, crtc_h,
+				src_x, src_y, src_w, src_h);
+
+	return drm_atomic_helper_update_plane(plane, crtc, fb,
+					      crtc_x, crtc_y, crtc_w, crtc_h,
+					      src_x, src_y, src_w, src_h, ctx);
+}
+
 static const struct drm_plane_funcs mtk_plane_funcs = {
-	.update_plane = drm_atomic_helper_update_plane,
+	.update_plane = mtk_plane_update,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_cleanup,
 	.reset = mtk_plane_reset,
@@ -90,7 +154,12 @@ static int mtk_plane_atomic_check(struct drm_plane *plane,
 	if (!state->crtc)
 		return 0;
 
-	crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
+	if (state->state)
+		crtc_state = drm_atomic_get_existing_crtc_state(state->state,
+								state->crtc);
+	else /* Special case for asynchronous cursor updates. */
+		crtc_state = state->crtc->state;
+
 	if (IS_ERR(crtc_state))
 		return PTR_ERR(crtc_state);
 
-- 
2.18.0

