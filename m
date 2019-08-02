Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53CEC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ACB2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbfHBFWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732712AbfHBFWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:22:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2969CB59A0;
        Fri,  2 Aug 2019 05:22:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D25760922;
        Fri,  2 Aug 2019 05:22:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7B3AC9D7F; Fri,  2 Aug 2019 07:22:49 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 07/17] drm/ttm: use gem reservation object
Date:   Fri,  2 Aug 2019 07:22:37 +0200
Message-Id: <20190802052247.18427-8-kraxel@redhat.com>
In-Reply-To: <20190802052247.18427-1-kraxel@redhat.com>
References: <20190802052247.18427-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 02 Aug 2019 05:22:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop ttm_resv from ttm_buffer_object, use the gem reservation object
(base._resv) instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/drm/ttm/ttm_bo_api.h      |  1 -
 drivers/gpu/drm/ttm/ttm_bo.c      | 39 ++++++++++++++++++-------------
 drivers/gpu/drm/ttm/ttm_bo_util.c |  2 +-
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 082550cac92c..fa050f0328ab 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -235,7 +235,6 @@ struct ttm_buffer_object {
 	struct sg_table *sg;
 
 	struct reservation_object *resv;
-	struct reservation_object ttm_resv;
 	struct mutex wu_mutex;
 };
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 58c403eda04e..36738f1a486d 100644
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
 
@@ -1332,9 +1333,15 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 		bo->resv = resv;
 		reservation_object_assert_held(bo->resv);
 	} else {
-		bo->resv = &bo->ttm_resv;
+		bo->resv = &bo->base._resv;
+	}
+	if (!ttm_bo_uses_embedded_gem_object(bo)) {
+		/*
+		 * bo.gem is not initialized, so we have to setup the
+		 * struct elements we want use regardless.
+		 */
+		reservation_object_init(&bo->base._resv);
 	}
-	reservation_object_init(&bo->ttm_resv);
 	atomic_inc(&bo->bdev->glob->bo_count);
 	drm_vma_node_reset(&bo->vma_node);
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 9f918b992f7e..05fbcaf6a3f2 100644
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

