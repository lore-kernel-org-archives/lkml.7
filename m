Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B32C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BC52082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDAW0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:26:42 -0400
Received: from anholt.net ([50.246.234.109]:48328 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfDAW0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:26:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6646410A2AA9;
        Mon,  1 Apr 2019 15:26:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id sGs0iYN5kLms; Mon,  1 Apr 2019 15:26:37 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C4DCF10A28B1;
        Mon,  1 Apr 2019 15:26:36 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id B10132FE338C; Mon,  1 Apr 2019 15:26:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Rob Herring <robh@kernel.org>,
        Qiang Yu <yuq825@gmail.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/7] drm/v3d: Switch the type of job-> to reduce casting.
Date:   Mon,  1 Apr 2019 15:26:29 -0700
Message-Id: <20190401222635.25013-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401222635.25013-1-eric@anholt.net>
References: <20190401222635.25013-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All consumers wanted drm_gem_object * now.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_drv.h |  4 ++--
 drivers/gpu/drm/v3d/v3d_gem.c | 42 +++++++++++++----------------------
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 89e5b9852c4d..238486925096 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -195,7 +195,7 @@ struct v3d_exec_info {
 	struct kref refcount;
 
 	/* This is the array of BOs that were looked up at the start of exec. */
-	struct v3d_bo **bo;
+	struct drm_gem_object **bo;
 	u32 bo_count;
 
 	/* List of overflow BOs used in the job that need to be
@@ -223,7 +223,7 @@ struct v3d_tfu_job {
 	struct kref refcount;
 
 	/* This is the array of BOs that were looked up at the start of exec. */
-	struct v3d_bo *bo[4];
+	struct drm_gem_object *bo[4];
 };
 
 /**
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 93ff8fcbe475..aa0397d12847 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -194,27 +194,17 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
 }
 
 static void
-v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
+v3d_attach_object_fences(struct drm_gem_object **bos, int bo_count,
 			 struct dma_fence *fence)
 {
 	int i;
 
 	for (i = 0; i < bo_count; i++) {
 		/* XXX: Use shared fences for read-only objects. */
-		reservation_object_add_excl_fence(bos[i]->base.base.resv,
-						  fence);
+		reservation_object_add_excl_fence(bos[i]->resv, fence);
 	}
 }
 
-static void
-v3d_unlock_bo_reservations(struct v3d_bo **bos,
-			   int bo_count,
-			   struct ww_acquire_ctx *acquire_ctx)
-{
-	drm_gem_unlock_reservations((struct drm_gem_object **)bos, bo_count,
-				    acquire_ctx);
-}
-
 /* Takes the reservation lock on all the BOs being referenced, so that
  * at queue submit time we can update the reservations.
  *
@@ -223,14 +213,13 @@ v3d_unlock_bo_reservations(struct v3d_bo **bos,
  * to v3d, so we don't attach dma-buf fences to them.
  */
 static int
-v3d_lock_bo_reservations(struct v3d_bo **bos,
+v3d_lock_bo_reservations(struct drm_gem_object **bos,
 			 int bo_count,
 			 struct ww_acquire_ctx *acquire_ctx)
 {
 	int i, ret;
 
-	ret = drm_gem_lock_reservations((struct drm_gem_object **)bos,
-					bo_count, acquire_ctx);
+	ret = drm_gem_lock_reservations(bos, bo_count, acquire_ctx);
 	if (ret)
 		return ret;
 
@@ -238,11 +227,10 @@ v3d_lock_bo_reservations(struct v3d_bo **bos,
 	 * before we commit the CL to the hardware.
 	 */
 	for (i = 0; i < bo_count; i++) {
-		ret = reservation_object_reserve_shared(bos[i]->base.base.resv,
-							1);
+		ret = reservation_object_reserve_shared(bos[i]->resv, 1);
 		if (ret) {
-			v3d_unlock_bo_reservations(bos, bo_count,
-						   acquire_ctx);
+			drm_gem_unlock_reservations(bos, bo_count,
+						    acquire_ctx);
 			return ret;
 		}
 	}
@@ -319,7 +307,7 @@ v3d_cl_lookup_bos(struct drm_device *dev,
 			goto fail;
 		}
 		drm_gem_object_get(bo);
-		exec->bo[i] = to_v3d_bo(bo);
+		exec->bo[i] = bo;
 	}
 	spin_unlock(&file_priv->table_lock);
 
@@ -347,7 +335,7 @@ v3d_exec_cleanup(struct kref *ref)
 	dma_fence_put(exec->render_done_fence);
 
 	for (i = 0; i < exec->bo_count; i++)
-		drm_gem_object_put_unlocked(&exec->bo[i]->base.base);
+		drm_gem_object_put_unlocked(exec->bo[i]);
 	kvfree(exec->bo);
 
 	list_for_each_entry_safe(bo, save, &exec->unref_list, unref_head) {
@@ -378,7 +366,7 @@ v3d_tfu_job_cleanup(struct kref *ref)
 
 	for (i = 0; i < ARRAY_SIZE(job->bo); i++) {
 		if (job->bo[i])
-			drm_gem_object_put_unlocked(&job->bo[i]->base.base);
+			drm_gem_object_put_unlocked(job->bo[i]);
 	}
 
 	pm_runtime_mark_last_busy(v3d->dev);
@@ -532,7 +520,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	v3d_attach_object_fences(exec->bo, exec->bo_count,
 				 exec->render_done_fence);
 
-	v3d_unlock_bo_reservations(exec->bo, exec->bo_count, &acquire_ctx);
+	drm_gem_unlock_reservations(exec->bo, exec->bo_count, &acquire_ctx);
 
 	/* Update the return sync object for the */
 	sync_out = drm_syncobj_find(file_priv, args->out_sync);
@@ -547,7 +535,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
-	v3d_unlock_bo_reservations(exec->bo, exec->bo_count, &acquire_ctx);
+	drm_gem_unlock_reservations(exec->bo, exec->bo_count, &acquire_ctx);
 fail:
 	v3d_exec_put(exec);
 
@@ -616,7 +604,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 			goto fail;
 		}
 		drm_gem_object_get(bo);
-		job->bo[bo_count] = to_v3d_bo(bo);
+		job->bo[bo_count] = bo;
 	}
 	spin_unlock(&file_priv->table_lock);
 
@@ -639,7 +627,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 
 	v3d_attach_object_fences(job->bo, bo_count, sched_done_fence);
 
-	v3d_unlock_bo_reservations(job->bo, bo_count, &acquire_ctx);
+	drm_gem_unlock_reservations(job->bo, bo_count, &acquire_ctx);
 
 	/* Update the return sync object */
 	sync_out = drm_syncobj_find(file_priv, args->out_sync);
@@ -655,7 +643,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
-	v3d_unlock_bo_reservations(job->bo, bo_count, &acquire_ctx);
+	drm_gem_unlock_reservations(job->bo, bo_count, &acquire_ctx);
 fail:
 	v3d_tfu_job_put(job);
 
-- 
2.20.1

