Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3495208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfDAW1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:27:11 -0400
Received: from anholt.net ([50.246.234.109]:48402 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728707AbfDAW1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:27:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8112B10A2230;
        Mon,  1 Apr 2019 15:26:59 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id f2r7L83k-OzE; Mon,  1 Apr 2019 15:26:54 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 18FB810A2A7A;
        Mon,  1 Apr 2019 15:26:38 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id C98332FE34D8; Mon,  1 Apr 2019 15:26:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Rob Herring <robh@kernel.org>,
        Qiang Yu <yuq825@gmail.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 6/7] drm/v3d: Add missing implicit synchronization.
Date:   Mon,  1 Apr 2019 15:26:34 -0700
Message-Id: <20190401222635.25013-7-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401222635.25013-1-eric@anholt.net>
References: <20190401222635.25013-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is the expectation of existing userspace (X11 + Mesa, in
particular) that jobs submitted to the kernel against a shared BO will
get implicitly synchronized by their submission order.  If we want to
allow clever userspace to disable implicit synchronization, we should
do that under its own submit flag (as amdgpu and lima do).

Note that we currently only implicitly sync for the rendering pass,
not binning -- if you texture-from-pixmap in the binning vertex shader
(vertex coordinate generation), you'll miss out on synchronization.

Fixes flickering when multiple clients are running in parallel,
particularly GL apps and compositors.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_drv.h   | 11 +++---
 drivers/gpu/drm/v3d/v3d_gem.c   | 62 ++++++++++++++++++++++++---------
 drivers/gpu/drm/v3d/v3d_sched.c | 40 +++------------------
 3 files changed, 53 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index c4ef640effc2..6d31a6a5a08e 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -188,8 +188,10 @@ struct v3d_job {
 	struct drm_gem_object **bo;
 	u32 bo_count;
 
-	/* An optional fence userspace can pass in for the job to depend on. */
-	struct dma_fence *in_fence;
+	/* Array of struct dma_fence * to block on before submitting this job.
+	 */
+	struct xarray deps;
+	unsigned long last_dep;
 
 	/* v3d fence to be signaled by IRQ handler when the job is complete. */
 	struct dma_fence *irq_fence;
@@ -221,11 +223,6 @@ struct v3d_bin_job {
 struct v3d_render_job {
 	struct v3d_job base;
 
-	/* Optional fence for the binner, to depend on before starting
-	 * our job.
-	 */
-	struct dma_fence *bin_done_fence;
-
 	/* GPU virtual addresses of the start/end of the CL job. */
 	u32 start, end;
 
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index ba3188b0d613..cd92850684c1 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -243,16 +243,25 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
  * to v3d, so we don't attach dma-buf fences to them.
  */
 static int
-v3d_lock_bo_reservations(struct drm_gem_object **bos,
-			 int bo_count,
+v3d_lock_bo_reservations(struct v3d_job *job,
 			 struct ww_acquire_ctx *acquire_ctx)
 {
 	int i, ret;
 
-	ret = drm_gem_lock_reservations(bos, bo_count, acquire_ctx);
+	ret = drm_gem_lock_reservations(job->bo, job->bo_count, acquire_ctx);
 	if (ret)
 		return ret;
 
+	for (i = 0; i < job->bo_count; i++) {
+		ret = drm_gem_fence_array_add_implicit(&job->deps,
+						       job->bo[i], true);
+		if (ret) {
+			drm_gem_unlock_reservations(job->bo, job->bo_count,
+						    acquire_ctx);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -339,6 +348,8 @@ static void
 v3d_job_free(struct kref *ref)
 {
 	struct v3d_job *job = container_of(ref, struct v3d_job, refcount);
+	unsigned long index;
+	struct dma_fence *fence;
 	int i;
 
 	for (i = 0; i < job->bo_count; i++) {
@@ -347,7 +358,11 @@ v3d_job_free(struct kref *ref)
 	}
 	kvfree(job->bo);
 
-	dma_fence_put(job->in_fence);
+	xa_for_each(&job->deps, index, fence) {
+		dma_fence_put(fence);
+	}
+	xa_destroy(&job->deps);
+
 	dma_fence_put(job->irq_fence);
 	dma_fence_put(job->done_fence);
 
@@ -414,6 +429,7 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 	     struct v3d_job *job, void (*free)(struct kref *ref),
 	     u32 in_sync)
 {
+	struct dma_fence *in_fence = NULL;
 	int ret;
 
 	job->v3d = v3d;
@@ -423,15 +439,23 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 	if (ret < 0)
 		return ret;
 
-	ret = drm_syncobj_find_fence(file_priv, in_sync, 0, 0, &job->in_fence);
-	if (ret == -EINVAL) {
-		pm_runtime_put_autosuspend(v3d->dev);
-		return ret;
-	}
+	xa_init_flags(&job->deps, XA_FLAGS_ALLOC);
+
+	ret = drm_syncobj_find_fence(file_priv, in_sync, 0, 0, &in_fence);
+	if (ret == -EINVAL)
+		goto fail;
+
+	ret = drm_gem_fence_array_add(&job->deps, in_fence);
+	if (ret)
+		goto fail;
 
 	kref_init(&job->refcount);
 
 	return 0;
+fail:
+	xa_destroy(&job->deps);
+	pm_runtime_put_autosuspend(v3d->dev);
+	return ret;
 }
 
 static int
@@ -552,8 +576,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_lock_bo_reservations(render->base.bo, render->base.bo_count,
-				       &acquire_ctx);
+	ret = v3d_lock_bo_reservations(&render->base, &acquire_ctx);
 	if (ret)
 		goto fail;
 
@@ -563,7 +586,10 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		if (ret)
 			goto fail_unreserve;
 
-		render->bin_done_fence = dma_fence_get(bin->base.done_fence);
+		ret = drm_gem_fence_array_add(&render->base.deps,
+					      dma_fence_get(bin->base.done_fence));
+		if (ret)
+			goto fail_unreserve;
 	}
 
 	ret = v3d_push_job(v3d_priv, &render->base, V3D_RENDER);
@@ -656,8 +682,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	}
 	spin_unlock(&file_priv->table_lock);
 
-	ret = v3d_lock_bo_reservations(job->base.bo, job->base.bo_count,
-				       &acquire_ctx);
+	ret = v3d_lock_bo_reservations(&job->base, &acquire_ctx);
 	if (ret)
 		goto fail;
 
@@ -746,8 +771,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_lock_bo_reservations(job->base.bo, job->base.bo_count,
-				       &acquire_ctx);
+	ret = v3d_lock_bo_reservations(&job->base, &acquire_ctx);
 	if (ret)
 		goto fail;
 
@@ -756,7 +780,11 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
-	clean_job->in_fence = dma_fence_get(job->base.done_fence);
+	ret = drm_gem_fence_array_add(&clean_job->deps,
+				      job->base.done_fence);
+	if (ret)
+		goto fail_unreserve;
+
 	ret = v3d_push_job(v3d_priv, clean_job, V3D_CACHE_CLEAN);
 	if (ret)
 		goto fail_unreserve;
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 9cb3e1b3a024..d688f238b2b9 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -74,47 +74,15 @@ v3d_job_dependency(struct drm_sched_job *sched_job,
 		   struct drm_sched_entity *s_entity)
 {
 	struct v3d_job *job = to_v3d_job(sched_job);
-	struct dma_fence *fence;
-
-	fence = job->in_fence;
-	if (fence) {
-		job->in_fence = NULL;
-		return fence;
-	}
 
 	/* XXX: Wait on a fence for switching the GMP if necessary,
 	 * and then do so.
 	 */
 
-	return NULL;
-}
+	if (!xa_empty(&job->deps))
+		return xa_erase(&job->deps, job->last_dep++);
 
-/**
- * Returns the fences that the render job depends on, one by one.
- * v3d_job_run() won't be called until all of them have been signaled.
- */
-static struct dma_fence *
-v3d_render_job_dependency(struct drm_sched_job *sched_job,
-			  struct drm_sched_entity *s_entity)
-{
-	struct v3d_render_job *job = to_render_job(sched_job);
-	struct dma_fence *fence;
-
-	fence = v3d_job_dependency(sched_job, s_entity);
-	if (fence)
-		return fence;
-
-	/* If we had a bin job, the render job definitely depends on
-	 * it. We first have to wait for bin to be scheduled, so that
-	 * its done_fence is created.
-	 */
-	fence = job->bin_done_fence;
-	if (fence) {
-		job->bin_done_fence = NULL;
-		return fence;
-	}
-
-	return fence;
+	return NULL;
 }
 
 static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
@@ -394,7 +362,7 @@ static const struct drm_sched_backend_ops v3d_bin_sched_ops = {
 };
 
 static const struct drm_sched_backend_ops v3d_render_sched_ops = {
-	.dependency = v3d_render_job_dependency,
+	.dependency = v3d_job_dependency,
 	.run_job = v3d_render_job_run,
 	.timedout_job = v3d_render_job_timedout,
 	.free_job = v3d_job_free,
-- 
2.20.1

