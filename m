Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26EEC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B0620880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfHBFXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:23:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732740AbfHBFWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:22:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B32C307D988;
        Fri,  2 Aug 2019 05:22:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DF1819C68;
        Fri,  2 Aug 2019 05:22:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 64A709D12; Fri,  2 Aug 2019 07:22:50 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/17] drm/ttm: switch ttm core from bo->resv to bo->base.resv
Date:   Fri,  2 Aug 2019 07:22:40 +0200
Message-Id: <20190802052247.18427-11-kraxel@redhat.com>
In-Reply-To: <20190802052247.18427-1-kraxel@redhat.com>
References: <20190802052247.18427-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 05:22:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/drm/ttm/ttm_bo_driver.h        | 12 ++--
 drivers/gpu/drm/ttm/ttm_bo.c           | 96 +++++++++++++-------------
 drivers/gpu/drm/ttm/ttm_bo_util.c      | 16 ++---
 drivers/gpu/drm/ttm/ttm_bo_vm.c        |  6 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c | 20 +++---
 drivers/gpu/drm/ttm/ttm_tt.c           |  2 +-
 6 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index c9b8ba492f24..5b54e3254d13 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -654,14 +654,14 @@ static inline int __ttm_bo_reserve(struct ttm_buffer_object *bo,
 		if (WARN_ON(ticket))
 			return -EBUSY;
 
-		success = reservation_object_trylock(bo->resv);
+		success = reservation_object_trylock(bo->base.resv);
 		return success ? 0 : -EBUSY;
 	}
 
 	if (interruptible)
-		ret = reservation_object_lock_interruptible(bo->resv, ticket);
+		ret = reservation_object_lock_interruptible(bo->base.resv, ticket);
 	else
-		ret = reservation_object_lock(bo->resv, ticket);
+		ret = reservation_object_lock(bo->base.resv, ticket);
 	if (ret == -EINTR)
 		return -ERESTARTSYS;
 	return ret;
@@ -745,10 +745,10 @@ static inline int ttm_bo_reserve_slowpath(struct ttm_buffer_object *bo,
 	WARN_ON(!kref_read(&bo->kref));
 
 	if (interruptible)
-		ret = ww_mutex_lock_slow_interruptible(&bo->resv->lock,
+		ret = ww_mutex_lock_slow_interruptible(&bo->base.resv->lock,
 						       ticket);
 	else
-		ww_mutex_lock_slow(&bo->resv->lock, ticket);
+		ww_mutex_lock_slow(&bo->base.resv->lock, ticket);
 
 	if (likely(ret == 0))
 		ttm_bo_del_sub_from_lru(bo);
@@ -773,7 +773,7 @@ static inline void ttm_bo_unreserve(struct ttm_buffer_object *bo)
 	else
 		ttm_bo_move_to_lru_tail(bo, NULL);
 	spin_unlock(&bo->bdev->glob->lru_lock);
-	reservation_object_unlock(bo->resv);
+	reservation_object_unlock(bo->base.resv);
 }
 
 /*
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index cd3a179a7e25..4d43a241e7eb 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -173,7 +173,7 @@ static void ttm_bo_add_mem_to_lru(struct ttm_buffer_object *bo,
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_mem_type_manager *man;
 
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 
 	if (!list_empty(&bo->lru))
 		return;
@@ -244,7 +244,7 @@ static void ttm_bo_bulk_move_set_pos(struct ttm_lru_bulk_move_pos *pos,
 void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
 			     struct ttm_lru_bulk_move *bulk)
 {
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 
 	ttm_bo_del_from_lru(bo);
 	ttm_bo_add_to_lru(bo);
@@ -277,8 +277,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 		if (!pos->first)
 			continue;
 
-		reservation_object_assert_held(pos->first->resv);
-		reservation_object_assert_held(pos->last->resv);
+		reservation_object_assert_held(pos->first->base.resv);
+		reservation_object_assert_held(pos->last->base.resv);
 
 		man = &pos->first->bdev->man[TTM_PL_TT];
 		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
@@ -292,8 +292,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 		if (!pos->first)
 			continue;
 
-		reservation_object_assert_held(pos->first->resv);
-		reservation_object_assert_held(pos->last->resv);
+		reservation_object_assert_held(pos->first->base.resv);
+		reservation_object_assert_held(pos->last->base.resv);
 
 		man = &pos->first->bdev->man[TTM_PL_VRAM];
 		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
@@ -307,8 +307,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 		if (!pos->first)
 			continue;
 
-		reservation_object_assert_held(pos->first->resv);
-		reservation_object_assert_held(pos->last->resv);
+		reservation_object_assert_held(pos->first->base.resv);
+		reservation_object_assert_held(pos->last->base.resv);
 
 		lru = &pos->first->bdev->glob->swap_lru[i];
 		list_bulk_move_tail(lru, &pos->first->swap, &pos->last->swap);
@@ -439,12 +439,12 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
 {
 	int r;
 
-	if (bo->resv == &bo->base._resv)
+	if (bo->base.resv == &bo->base._resv)
 		return 0;
 
 	BUG_ON(!reservation_object_trylock(&bo->base._resv));
 
-	r = reservation_object_copy_fences(&bo->base._resv, bo->resv);
+	r = reservation_object_copy_fences(&bo->base._resv, bo->base.resv);
 	if (r)
 		reservation_object_unlock(&bo->base._resv);
 
@@ -482,23 +482,23 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
 		/* Last resort, if we fail to allocate memory for the
 		 * fences block for the BO to become idle
 		 */
-		reservation_object_wait_timeout_rcu(bo->resv, true, false,
+		reservation_object_wait_timeout_rcu(bo->base.resv, true, false,
 						    30 * HZ);
 		spin_lock(&glob->lru_lock);
 		goto error;
 	}
 
 	spin_lock(&glob->lru_lock);
-	ret = reservation_object_trylock(bo->resv) ? 0 : -EBUSY;
+	ret = reservation_object_trylock(bo->base.resv) ? 0 : -EBUSY;
 	if (!ret) {
 		if (reservation_object_test_signaled_rcu(&bo->base._resv, true)) {
 			ttm_bo_del_from_lru(bo);
 			spin_unlock(&glob->lru_lock);
-			if (bo->resv != &bo->base._resv)
+			if (bo->base.resv != &bo->base._resv)
 				reservation_object_unlock(&bo->base._resv);
 
 			ttm_bo_cleanup_memtype_use(bo);
-			reservation_object_unlock(bo->resv);
+			reservation_object_unlock(bo->base.resv);
 			return;
 		}
 
@@ -514,9 +514,9 @@ static void ttm_bo_cleanup_refs_or_queue(struct ttm_buffer_object *bo)
 			ttm_bo_add_to_lru(bo);
 		}
 
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 	}
-	if (bo->resv != &bo->base._resv)
+	if (bo->base.resv != &bo->base._resv)
 		reservation_object_unlock(&bo->base._resv);
 
 error:
@@ -550,7 +550,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 	int ret;
 
 	if (unlikely(list_empty(&bo->ddestroy)))
-		resv = bo->resv;
+		resv = bo->base.resv;
 	else
 		resv = &bo->base._resv;
 
@@ -563,7 +563,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 		long lret;
 
 		if (unlock_resv)
-			reservation_object_unlock(bo->resv);
+			reservation_object_unlock(bo->base.resv);
 		spin_unlock(&glob->lru_lock);
 
 		lret = reservation_object_wait_timeout_rcu(resv, true,
@@ -576,7 +576,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 			return -EBUSY;
 
 		spin_lock(&glob->lru_lock);
-		if (unlock_resv && !reservation_object_trylock(bo->resv)) {
+		if (unlock_resv && !reservation_object_trylock(bo->base.resv)) {
 			/*
 			 * We raced, and lost, someone else holds the reservation now,
 			 * and is probably busy in ttm_bo_cleanup_memtype_use.
@@ -593,7 +593,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 
 	if (ret || unlikely(list_empty(&bo->ddestroy))) {
 		if (unlock_resv)
-			reservation_object_unlock(bo->resv);
+			reservation_object_unlock(bo->base.resv);
 		spin_unlock(&glob->lru_lock);
 		return ret;
 	}
@@ -606,7 +606,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 	ttm_bo_cleanup_memtype_use(bo);
 
 	if (unlock_resv)
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 
 	return 0;
 }
@@ -632,14 +632,14 @@ static bool ttm_bo_delayed_delete(struct ttm_bo_device *bdev, bool remove_all)
 		kref_get(&bo->list_kref);
 		list_move_tail(&bo->ddestroy, &removed);
 
-		if (remove_all || bo->resv != &bo->base._resv) {
+		if (remove_all || bo->base.resv != &bo->base._resv) {
 			spin_unlock(&glob->lru_lock);
-			reservation_object_lock(bo->resv, NULL);
+			reservation_object_lock(bo->base.resv, NULL);
 
 			spin_lock(&glob->lru_lock);
 			ttm_bo_cleanup_refs(bo, false, !remove_all, true);
 
-		} else if (reservation_object_trylock(bo->resv)) {
+		} else if (reservation_object_trylock(bo->base.resv)) {
 			ttm_bo_cleanup_refs(bo, false, !remove_all, true);
 		} else {
 			spin_unlock(&glob->lru_lock);
@@ -708,7 +708,7 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 	struct ttm_placement placement;
 	int ret = 0;
 
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 
 	placement.num_placement = 0;
 	placement.num_busy_placement = 0;
@@ -778,8 +778,8 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
 {
 	bool ret = false;
 
-	if (bo->resv == ctx->resv) {
-		reservation_object_assert_held(bo->resv);
+	if (bo->base.resv == ctx->resv) {
+		reservation_object_assert_held(bo->base.resv);
 		if (ctx->flags & TTM_OPT_FLAG_ALLOW_RES_EVICT
 		    || !list_empty(&bo->ddestroy))
 			ret = true;
@@ -787,7 +787,7 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
 		if (busy)
 			*busy = false;
 	} else {
-		ret = reservation_object_trylock(bo->resv);
+		ret = reservation_object_trylock(bo->base.resv);
 		*locked = ret;
 		if (busy)
 			*busy = !ret;
@@ -815,10 +815,10 @@ static int ttm_mem_evict_wait_busy(struct ttm_buffer_object *busy_bo,
 		return -EBUSY;
 
 	if (ctx->interruptible)
-		r = reservation_object_lock_interruptible(busy_bo->resv,
+		r = reservation_object_lock_interruptible(busy_bo->base.resv,
 							  ticket);
 	else
-		r = reservation_object_lock(busy_bo->resv, ticket);
+		r = reservation_object_lock(busy_bo->base.resv, ticket);
 
 	/*
 	 * TODO: It would be better to keep the BO locked until allocation is at
@@ -826,7 +826,7 @@ static int ttm_mem_evict_wait_busy(struct ttm_buffer_object *busy_bo,
 	 * of TTM.
 	 */
 	if (!r)
-		reservation_object_unlock(busy_bo->resv);
+		reservation_object_unlock(busy_bo->base.resv);
 
 	return r == -EDEADLK ? -EBUSY : r;
 }
@@ -852,7 +852,7 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 			if (!ttm_bo_evict_swapout_allowable(bo, ctx, &locked,
 							    &busy)) {
 				if (busy && !busy_bo &&
-				    bo->resv->lock.ctx != ticket)
+				    bo->base.resv->lock.ctx != ticket)
 					busy_bo = bo;
 				continue;
 			}
@@ -860,7 +860,7 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 			if (place && !bdev->driver->eviction_valuable(bo,
 								      place)) {
 				if (locked)
-					reservation_object_unlock(bo->resv);
+					reservation_object_unlock(bo->base.resv);
 				continue;
 			}
 			break;
@@ -932,9 +932,9 @@ static int ttm_bo_add_move_fence(struct ttm_buffer_object *bo,
 	spin_unlock(&man->move_lock);
 
 	if (fence) {
-		reservation_object_add_shared_fence(bo->resv, fence);
+		reservation_object_add_shared_fence(bo->base.resv, fence);
 
-		ret = reservation_object_reserve_shared(bo->resv, 1);
+		ret = reservation_object_reserve_shared(bo->base.resv, 1);
 		if (unlikely(ret)) {
 			dma_fence_put(fence);
 			return ret;
@@ -967,7 +967,7 @@ static int ttm_bo_mem_force_space(struct ttm_buffer_object *bo,
 		if (mem->mm_node)
 			break;
 		ret = ttm_mem_evict_first(bdev, mem->mem_type, place, ctx,
-					  bo->resv->lock.ctx);
+					  bo->base.resv->lock.ctx);
 		if (unlikely(ret != 0))
 			return ret;
 	} while (1);
@@ -1089,7 +1089,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
 	bool type_found = false;
 	int i, ret;
 
-	ret = reservation_object_reserve_shared(bo->resv, 1);
+	ret = reservation_object_reserve_shared(bo->base.resv, 1);
 	if (unlikely(ret))
 		return ret;
 
@@ -1170,7 +1170,7 @@ static int ttm_bo_move_buffer(struct ttm_buffer_object *bo,
 	int ret = 0;
 	struct ttm_mem_reg mem;
 
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 
 	mem.num_pages = bo->num_pages;
 	mem.size = mem.num_pages << PAGE_SHIFT;
@@ -1240,7 +1240,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 	int ret;
 	uint32_t new_flags;
 
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 	/*
 	 * Check whether we need to move buffer.
 	 */
@@ -1332,7 +1332,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	if (resv) {
 		bo->resv = resv;
 		bo->base.resv = resv;
-		reservation_object_assert_held(bo->resv);
+		reservation_object_assert_held(bo->base.resv);
 	} else {
 		bo->resv = &bo->base._resv;
 		bo->base.resv = &bo->base._resv;
@@ -1360,7 +1360,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	 * since otherwise lockdep will be angered in radeon.
 	 */
 	if (!resv) {
-		locked = reservation_object_trylock(bo->resv);
+		locked = reservation_object_trylock(bo->base.resv);
 		WARN_ON(!locked);
 	}
 
@@ -1804,13 +1804,13 @@ int ttm_bo_wait(struct ttm_buffer_object *bo,
 	long timeout = 15 * HZ;
 
 	if (no_wait) {
-		if (reservation_object_test_signaled_rcu(bo->resv, true))
+		if (reservation_object_test_signaled_rcu(bo->base.resv, true))
 			return 0;
 		else
 			return -EBUSY;
 	}
 
-	timeout = reservation_object_wait_timeout_rcu(bo->resv, true,
+	timeout = reservation_object_wait_timeout_rcu(bo->base.resv, true,
 						      interruptible, timeout);
 	if (timeout < 0)
 		return timeout;
@@ -1818,7 +1818,7 @@ int ttm_bo_wait(struct ttm_buffer_object *bo,
 	if (timeout == 0)
 		return -EBUSY;
 
-	reservation_object_add_excl_fence(bo->resv, NULL);
+	reservation_object_add_excl_fence(bo->base.resv, NULL);
 	return 0;
 }
 EXPORT_SYMBOL(ttm_bo_wait);
@@ -1934,7 +1934,7 @@ int ttm_bo_swapout(struct ttm_bo_global *glob, struct ttm_operation_ctx *ctx)
 	 * already swapped buffer.
 	 */
 	if (locked)
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 	kref_put(&bo->list_kref, ttm_bo_release_list);
 	return ret;
 }
@@ -1972,14 +1972,14 @@ int ttm_bo_wait_unreserved(struct ttm_buffer_object *bo)
 	ret = mutex_lock_interruptible(&bo->wu_mutex);
 	if (unlikely(ret != 0))
 		return -ERESTARTSYS;
-	if (!ww_mutex_is_locked(&bo->resv->lock))
+	if (!ww_mutex_is_locked(&bo->base.resv->lock))
 		goto out_unlock;
-	ret = reservation_object_lock_interruptible(bo->resv, NULL);
+	ret = reservation_object_lock_interruptible(bo->base.resv, NULL);
 	if (ret == -EINTR)
 		ret = -ERESTARTSYS;
 	if (unlikely(ret != 0))
 		goto out_unlock;
-	reservation_object_unlock(bo->resv);
+	reservation_object_unlock(bo->base.resv);
 
 out_unlock:
 	mutex_unlock(&bo->wu_mutex);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f5009c1b6a9c..425a6d627b30 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -517,9 +517,9 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	kref_init(&fbo->base.kref);
 	fbo->base.destroy = &ttm_transfered_destroy;
 	fbo->base.acc_size = 0;
-	fbo->base.resv = &fbo->base.base._resv;
-	reservation_object_init(fbo->base.resv);
-	ret = reservation_object_trylock(fbo->base.resv);
+	fbo->base.base.resv = &fbo->base.base._resv;
+	reservation_object_init(fbo->base.base.resv);
+	ret = reservation_object_trylock(fbo->base.base.resv);
 	WARN_ON(!ret);
 
 	*new_obj = &fbo->base;
@@ -689,7 +689,7 @@ int ttm_bo_move_accel_cleanup(struct ttm_buffer_object *bo,
 	int ret;
 	struct ttm_buffer_object *ghost_obj;
 
-	reservation_object_add_excl_fence(bo->resv, fence);
+	reservation_object_add_excl_fence(bo->base.resv, fence);
 	if (evict) {
 		ret = ttm_bo_wait(bo, false, false);
 		if (ret)
@@ -716,7 +716,7 @@ int ttm_bo_move_accel_cleanup(struct ttm_buffer_object *bo,
 		if (ret)
 			return ret;
 
-		reservation_object_add_excl_fence(ghost_obj->resv, fence);
+		reservation_object_add_excl_fence(ghost_obj->base.resv, fence);
 
 		/**
 		 * If we're not moving to fixed memory, the TTM object
@@ -752,7 +752,7 @@ int ttm_bo_pipeline_move(struct ttm_buffer_object *bo,
 
 	int ret;
 
-	reservation_object_add_excl_fence(bo->resv, fence);
+	reservation_object_add_excl_fence(bo->base.resv, fence);
 
 	if (!evict) {
 		struct ttm_buffer_object *ghost_obj;
@@ -772,7 +772,7 @@ int ttm_bo_pipeline_move(struct ttm_buffer_object *bo,
 		if (ret)
 			return ret;
 
-		reservation_object_add_excl_fence(ghost_obj->resv, fence);
+		reservation_object_add_excl_fence(ghost_obj->base.resv, fence);
 
 		/**
 		 * If we're not moving to fixed memory, the TTM object
@@ -841,7 +841,7 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo)
 	if (ret)
 		return ret;
 
-	ret = reservation_object_copy_fences(ghost->resv, bo->resv);
+	ret = reservation_object_copy_fences(ghost->base.resv, bo->base.resv);
 	/* Last resort, wait for the BO to be idle when we are OOM */
 	if (ret)
 		ttm_bo_wait(bo, false, false);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index fb6875a789b7..85f5bcbe0c76 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -71,7 +71,7 @@ static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
 		ttm_bo_get(bo);
 		up_read(&vmf->vma->vm_mm->mmap_sem);
 		(void) dma_fence_wait(bo->moving, true);
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 		ttm_bo_put(bo);
 		goto out_unlock;
 	}
@@ -131,7 +131,7 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	 * for reserve, and if it fails, retry the fault after waiting
 	 * for the buffer to become unreserved.
 	 */
-	if (unlikely(!reservation_object_trylock(bo->resv))) {
+	if (unlikely(!reservation_object_trylock(bo->base.resv))) {
 		if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
 			if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
 				ttm_bo_get(bo);
@@ -296,7 +296,7 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 out_io_unlock:
 	ttm_mem_io_unlock(man);
 out_unlock:
-	reservation_object_unlock(bo->resv);
+	reservation_object_unlock(bo->base.resv);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
index 957ec375a4ba..861c4145b462 100644
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -39,7 +39,7 @@ static void ttm_eu_backoff_reservation_reverse(struct list_head *list,
 	list_for_each_entry_continue_reverse(entry, list, head) {
 		struct ttm_buffer_object *bo = entry->bo;
 
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 	}
 }
 
@@ -71,7 +71,7 @@ void ttm_eu_backoff_reservation(struct ww_acquire_ctx *ticket,
 
 		if (list_empty(&bo->lru))
 			ttm_bo_add_to_lru(bo);
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 	}
 	spin_unlock(&glob->lru_lock);
 
@@ -114,7 +114,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 
 		ret = __ttm_bo_reserve(bo, intr, (ticket == NULL), ticket);
 		if (!ret && unlikely(atomic_read(&bo->cpu_writers) > 0)) {
-			reservation_object_unlock(bo->resv);
+			reservation_object_unlock(bo->base.resv);
 
 			ret = -EBUSY;
 
@@ -130,7 +130,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 			if (!entry->num_shared)
 				continue;
 
-			ret = reservation_object_reserve_shared(bo->resv,
+			ret = reservation_object_reserve_shared(bo->base.resv,
 								entry->num_shared);
 			if (!ret)
 				continue;
@@ -144,16 +144,16 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 
 		if (ret == -EDEADLK) {
 			if (intr) {
-				ret = ww_mutex_lock_slow_interruptible(&bo->resv->lock,
+				ret = ww_mutex_lock_slow_interruptible(&bo->base.resv->lock,
 								       ticket);
 			} else {
-				ww_mutex_lock_slow(&bo->resv->lock, ticket);
+				ww_mutex_lock_slow(&bo->base.resv->lock, ticket);
 				ret = 0;
 			}
 		}
 
 		if (!ret && entry->num_shared)
-			ret = reservation_object_reserve_shared(bo->resv,
+			ret = reservation_object_reserve_shared(bo->base.resv,
 								entry->num_shared);
 
 		if (unlikely(ret != 0)) {
@@ -201,14 +201,14 @@ void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
 	list_for_each_entry(entry, list, head) {
 		bo = entry->bo;
 		if (entry->num_shared)
-			reservation_object_add_shared_fence(bo->resv, fence);
+			reservation_object_add_shared_fence(bo->base.resv, fence);
 		else
-			reservation_object_add_excl_fence(bo->resv, fence);
+			reservation_object_add_excl_fence(bo->base.resv, fence);
 		if (list_empty(&bo->lru))
 			ttm_bo_add_to_lru(bo);
 		else
 			ttm_bo_move_to_lru_tail(bo, NULL);
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 	}
 	spin_unlock(&glob->lru_lock);
 	if (ticket)
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index e3a0691582ff..00b4a3337840 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -48,7 +48,7 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 	struct ttm_bo_device *bdev = bo->bdev;
 	uint32_t page_flags = 0;
 
-	reservation_object_assert_held(bo->resv);
+	reservation_object_assert_held(bo->base.resv);
 
 	if (bdev->need_dma32)
 		page_flags |= TTM_PAGE_FLAG_DMA32;
-- 
2.18.1

