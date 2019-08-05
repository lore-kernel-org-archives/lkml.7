Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD82C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D176217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfHEOBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbfHEOB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE83F316D76A;
        Mon,  5 Aug 2019 14:01:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3920F27086;
        Mon,  5 Aug 2019 14:01:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9485C9D12; Mon,  5 Aug 2019 16:01:23 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        thomas@shipmail.org, bskeggs@redhat.com, tzimmermann@suse.de,
        ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 14/17] drm/nouveau: switch driver from bo->resv to bo->base.resv
Date:   Mon,  5 Aug 2019 16:01:16 +0200
Message-Id: <20190805140119.7337-15-kraxel@redhat.com>
In-Reply-To: <20190805140119.7337-1-kraxel@redhat.com>
References: <20190805140119.7337-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 05 Aug 2019 14:01:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/nouveau/dispnv50/wndw.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c    | 5 ++---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c   | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 283ff690350e..89f8e76a2d7d 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -457,7 +457,7 @@ nv50_wndw_prepare_fb(struct drm_plane *plane, struct drm_plane_state *state)
 		asyw->image.handle[0] = ctxdma->object.handle;
 	}
 
-	asyw->state.fence = reservation_object_get_excl_rcu(fb->nvbo->bo.resv);
+	asyw->state.fence = reservation_object_get_excl_rcu(fb->nvbo->bo.base.resv);
 	asyw->image.offset[0] = fb->nvbo->bo.offset;
 
 	if (wndw->func->prepare) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index abbbabd12241..99e391be9370 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -299,7 +299,6 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int align,
 			  type, &nvbo->placement,
 			  align >> PAGE_SHIFT, false, acc_size, sg,
 			  robj, nouveau_bo_del_ttm);
-	nvbo->bo.base.resv = nvbo->bo.resv;
 
 	if (ret) {
 		/* ttm will call nouveau_bo_del_ttm if it fails.. */
@@ -1325,7 +1324,7 @@ nouveau_bo_vm_cleanup(struct ttm_buffer_object *bo,
 {
 	struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
 	struct drm_device *dev = drm->dev;
-	struct dma_fence *fence = reservation_object_get_excl(bo->resv);
+	struct dma_fence *fence = reservation_object_get_excl(bo->base.resv);
 
 	nv10_bo_put_tile_region(dev, *old_tile, fence);
 	*old_tile = new_tile;
@@ -1656,7 +1655,7 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt *ttm)
 void
 nouveau_bo_fence(struct nouveau_bo *nvbo, struct nouveau_fence *fence, bool exclusive)
 {
-	struct reservation_object *resv = nvbo->bo.resv;
+	struct reservation_object *resv = nvbo->bo.base.resv;
 
 	if (exclusive)
 		reservation_object_add_excl_fence(resv, &fence->base);
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index d4964f3397a1..e5f249ab216a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -335,7 +335,7 @@ nouveau_fence_sync(struct nouveau_bo *nvbo, struct nouveau_channel *chan, bool e
 {
 	struct nouveau_fence_chan *fctx = chan->fence;
 	struct dma_fence *fence;
-	struct reservation_object *resv = nvbo->bo.resv;
+	struct reservation_object *resv = nvbo->bo.base.resv;
 	struct reservation_object_list *fobj;
 	struct nouveau_fence *f;
 	int ret = 0, i;
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index b1e4852810ed..c7368aa0bdec 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -887,7 +887,7 @@ nouveau_gem_ioctl_cpu_prep(struct drm_device *dev, void *data,
 		return -ENOENT;
 	nvbo = nouveau_gem_object(gem);
 
-	lret = reservation_object_wait_timeout_rcu(nvbo->bo.resv, write, true,
+	lret = reservation_object_wait_timeout_rcu(nvbo->bo.base.resv, write, true,
 						   no_wait ? 0 : 30 * HZ);
 	if (!lret)
 		ret = -EBUSY;
-- 
2.18.1

