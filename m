Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269BDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF47E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393051AbfJYFiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 01:38:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5554 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393008AbfJYFix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:38:53 -0400
X-UUID: 1c1ad6368989436e8fe9507eb69c7957-20191025
X-UUID: 1c1ad6368989436e8fe9507eb69c7957-20191025
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1106138998; Fri, 25 Oct 2019 13:38:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 25 Oct 2019 13:38:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 25 Oct 2019 13:38:43 +0800
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
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH] drm/mediatek: covert to helper nonblocking atomic commit
Date:   Fri, 25 Oct 2019 13:38:41 +0800
Message-ID: <20191025053843.16808-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to commit state asynchronously, we change
.atomic_commit to drm_atomic_helper_commit().

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 11 ++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 86 ++-----------------------
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  7 --
 3 files changed, 16 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index b97eb5f58483..b07dc9b59ca3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -317,6 +317,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 {
 	struct drm_device *drm = mtk_crtc->base.dev;
+	struct drm_crtc *crtc = &mtk_crtc->base;
 	int i;
 
 	DRM_DEBUG_DRIVER("%s\n", __func__);
@@ -340,6 +341,13 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 	mtk_disp_mutex_unprepare(mtk_crtc->mutex);
 
 	pm_runtime_put(drm->dev);
+
+	if (crtc->state->event && !crtc->state->active) {
+		spin_lock_irq(&crtc->dev->event_lock);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
 }
 
 static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
@@ -456,12 +464,15 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 	if (mtk_crtc->event && state->base.event)
 		DRM_ERROR("new event while there is still a pending event\n");
 
+	spin_lock_irq(&crtc->dev->event_lock);
 	if (state->base.event) {
 		state->base.event->pipe = drm_crtc_index(crtc);
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+		WARN_ON(mtk_crtc->event);
 		mtk_crtc->event = state->base.event;
 		state->base.event = NULL;
 	}
+	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
 static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 6588dc6dd5e3..16e5771d182e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -36,89 +36,14 @@
 #define DRIVER_MAJOR 1
 #define DRIVER_MINOR 0
 
-static void mtk_atomic_schedule(struct mtk_drm_private *private,
-				struct drm_atomic_state *state)
-{
-	private->commit.state = state;
-	schedule_work(&private->commit.work);
-}
-
-static void mtk_atomic_complete(struct mtk_drm_private *private,
-				struct drm_atomic_state *state)
-{
-	struct drm_device *drm = private->drm;
-
-	drm_atomic_helper_wait_for_fences(drm, state, false);
-
-	/*
-	 * Mediatek drm supports runtime PM, so plane registers cannot be
-	 * written when their crtc is disabled.
-	 *
-	 * The comment for drm_atomic_helper_commit states:
-	 *     For drivers supporting runtime PM the recommended sequence is
-	 *
-	 *     drm_atomic_helper_commit_modeset_disables(dev, state);
-	 *     drm_atomic_helper_commit_modeset_enables(dev, state);
-	 *     drm_atomic_helper_commit_planes(dev, state,
-	 *                                     DRM_PLANE_COMMIT_ACTIVE_ONLY);
-	 *
-	 * See the kerneldoc entries for these three functions for more details.
-	 */
-	drm_atomic_helper_commit_modeset_disables(drm, state);
-	drm_atomic_helper_commit_modeset_enables(drm, state);
-	drm_atomic_helper_commit_planes(drm, state,
-					DRM_PLANE_COMMIT_ACTIVE_ONLY);
-
-	drm_atomic_helper_wait_for_vblanks(drm, state);
-
-	drm_atomic_helper_cleanup_planes(drm, state);
-	drm_atomic_state_put(state);
-}
-
-static void mtk_atomic_work(struct work_struct *work)
-{
-	struct mtk_drm_private *private = container_of(work,
-			struct mtk_drm_private, commit.work);
-
-	mtk_atomic_complete(private, private->commit.state);
-}
-
-static int mtk_atomic_commit(struct drm_device *drm,
-			     struct drm_atomic_state *state,
-			     bool async)
-{
-	struct mtk_drm_private *private = drm->dev_private;
-	int ret;
-
-	ret = drm_atomic_helper_prepare_planes(drm, state);
-	if (ret)
-		return ret;
-
-	mutex_lock(&private->commit.lock);
-	flush_work(&private->commit.work);
-
-	ret = drm_atomic_helper_swap_state(state, true);
-	if (ret) {
-		mutex_unlock(&private->commit.lock);
-		drm_atomic_helper_cleanup_planes(drm, state);
-		return ret;
-	}
-
-	drm_atomic_state_get(state);
-	if (async)
-		mtk_atomic_schedule(private, state);
-	else
-		mtk_atomic_complete(private, state);
-
-	mutex_unlock(&private->commit.lock);
-
-	return 0;
-}
+static const struct drm_mode_config_helper_funcs mtk_drm_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
 
 static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
 	.fb_create = mtk_drm_mode_fb_create,
 	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = mtk_atomic_commit,
+	.atomic_commit = drm_atomic_helper_commit,
 };
 
 static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
@@ -265,6 +190,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	drm->mode_config.max_width = 4096;
 	drm->mode_config.max_height = 4096;
 	drm->mode_config.funcs = &mtk_drm_mode_config_funcs;
+	drm->mode_config.helper_private = &mtk_drm_mode_config_helpers;
 
 	ret = component_bind_all(drm->dev, drm);
 	if (ret)
@@ -540,8 +466,6 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	if (!private)
 		return -ENOMEM;
 
-	mutex_init(&private->commit.lock);
-	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index b6a82728d563..9f4ce60174f6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -46,13 +46,6 @@ struct mtk_drm_private {
 	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
 	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
 	const struct mtk_mmsys_driver_data *data;
-
-	struct {
-		struct drm_atomic_state *state;
-		struct work_struct work;
-		struct mutex lock;
-	} commit;
-
 	struct drm_atomic_state *suspend_state;
 
 	bool dma_parms_allocated;
-- 
2.18.0

