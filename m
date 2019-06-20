Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475FFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C814208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfFTHoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:44:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFTHof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:44:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D36F7300159E;
        Thu, 20 Jun 2019 07:44:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A18516013D;
        Thu, 20 Jun 2019 07:44:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0144E17512; Thu, 20 Jun 2019 09:44:25 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/6] drm/ttm: use gem reservation object
Date:   Thu, 20 Jun 2019 09:44:22 +0200
Message-Id: <20190620074424.1677-5-kraxel@redhat.com>
In-Reply-To: <20190620074424.1677-1-kraxel@redhat.com>
References: <20190620074424.1677-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 20 Jun 2019 07:44:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop ttm_resv from ttm_buffer_object, use the gem reservation object
(base._resv) instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/ttm/ttm_bo_api.h      |  1 -
 drivers/gpu/drm/ttm/ttm_bo.c      | 40 ++++++++++++++++++-------------
 drivers/gpu/drm/ttm/ttm_bo_util.c |  2 +-
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 72f6aeda619c..88aa7bf1b18a 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -235,7 +235,6 @@ struct ttm_buffer_object {
 	struct sg_table *sg;
 
 	struct reservation_object *resv;
-	struct reservation_object ttm_resv;
 	struct mutex wu_mutex;
 };
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index c7de667d482a..516eef3b76d5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -160,7 +160,8 @@ static void ttm_bo_release_list(struct kref *list_kref)
 	ttm_tt_destroy(bo->ttm);
 	atomic_dec(&bo->bdev->glob->bo_count);
 	dma_fence_put(bo->moving);
-	reservation_object_fini(&bo->ttm_resv);
+	if (!ttm_bo_uses_embedded_gem_object(bo))
+		reservation_object_fini(&bo->base._resv);
 	mutex_destroy(&bo->wu_mutex);
 	bo->destroy(bo);
 	ttm_mem_global_free(bdev->glob->mem_glob, acc_size);
@@ -438,14 +439,14 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 {
 	int r;
 
-	if (bo->resv == &bo->ttm_resv)
+	if (bo->resv == &bo->base._resv)
 		return 0;
 
-	BUG_ON(!reservation_object_trylock(&bo->ttm_resv));
+	BUG_ON(!reservation_object_trylock(&bo->base._resv));
 
-	r = reservation_object_copy_fences(&bo->ttm_resv, bo->resv);
+	r = reservation_object_copy_fences(&bo->base._resv, bo->resv);
 	if (r)
-		reservation_object_unlock(&bo->ttm_resv);
+		reservation_object_unlock(&bo->base._resv);
 
 	return r;
 }
@@ -456,8 +457,8 @@ static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
 	struct dma_fence *fence;
 	int i;
 
-	fobj = reservation_object_get_list(&bo->ttm_resv);
-	fence = reservation_object_get_excl(&bo->ttm_resv);
+	fobj = reservation_object_get_list(&bo->base._resv);
+	fence = reservation_object_get_excl(&bo->base._resv);
 	if (fence && !fence->ops->signaled)
 		dma_fence_enable_sw_signaling(fence);
 
@@ -490,11 +491,11 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
 	spin_lock(&glob->lru_lock);
 	ret = reservation_object_trylock(bo->resv) ? 0 : -EBUSY;
 	if (!ret) {
-		if (reservation_object_test_signaled_rcu(&bo->ttm_resv, true)) {
+		if (reservation_object_test_signaled_rcu(&bo->base._resv, true)) {
 			ttm_bo_del_from_lru(bo);
 			spin_unlock(&glob->lru_lock);
-			if (bo->resv != &bo->ttm_resv)
-				reservation_object_unlock(&bo->ttm_resv);
+			if (bo->resv != &bo->base._resv)
+				reservation_object_unlock(&bo->base._resv);
 
 			ttm_bo_cleanup_memtype_use(bo);
 			reservation_object_unlock(bo->resv);
@@ -515,8 +516,8 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
 
 		reservation_object_unlock(bo->resv);
 	}
-	if (bo->resv != &bo->ttm_resv)
-		reservation_object_unlock(&bo->ttm_resv);
+	if (bo->resv != &bo->base._resv)
+		reservation_object_unlock(&bo->base._resv);
 
 error:
 	kref_get(&bo->list_kref);
@@ -551,7 +552,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 	if (unlikely(list_empty(&bo->ddestroy)))
 		resv = bo->resv;
 	else
-		resv = &bo->ttm_resv;
+		resv = &bo->base._resv;
 
 	if (reservation_object_test_signaled_rcu(resv, true))
 		ret = 0;
@@ -631,7 +632,7 @@ static bool ttm_bo_delayed_delete(struct ttm_bo_device *bdev, bool remove_all)
 		kref_get(&bo->list_kref);
 		list_move_tail(&bo->ddestroy, &removed);
 
-		if (remove_all || bo->resv != &bo->ttm_resv) {
+		if (remove_all || bo->resv != &bo->base._resv) {
 			spin_unlock(&glob->lru_lock);
 			reservation_object_lock(bo->resv, NULL);
 
@@ -1332,9 +1333,16 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 		bo->resv = resv;
 		reservation_object_assert_held(bo->resv);
 	} else {
-		bo->resv = &bo->ttm_resv;
+		bo->resv = &bo->base._resv;
+	}
+	if (!ttm_bo_uses_embedded_gem_object(bo)) {
+		/*
+		 * bo.gem is not initialized, so we have to setup the
+		 * struct elements we want use regardless.  Should go
+		 * away once all users are switched over.
+		 */
+		reservation_object_init(&bo->base._resv);
 	}
-	reservation_object_init(&bo->ttm_resv);
 	atomic_inc(&bo->bdev->glob->bo_count);
 	drm_vma_node_reset(&bo->vma_node);
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 895d77d799e4..3d2617dd63e3 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -517,7 +517,7 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	kref_init(&fbo->base.kref);
 	fbo->base.destroy = &ttm_transfered_destroy;
 	fbo->base.acc_size = 0;
-	fbo->base.resv = &fbo->base.ttm_resv;
+	fbo->base.resv = &fbo->base.base._resv;
 	reservation_object_init(fbo->base.resv);
 	ret = reservation_object_trylock(fbo->base.resv);
 	WARN_ON(!ret);
-- 
2.18.1

