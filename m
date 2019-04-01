Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC654C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD45C2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfDAW1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:27:00 -0400
Received: from anholt.net ([50.246.234.109]:48392 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbfDAW06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:26:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6CBAC10A280A;
        Mon,  1 Apr 2019 15:26:57 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id FOnfzCXikpFz; Mon,  1 Apr 2019 15:26:53 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 06BCE10A2230;
        Mon,  1 Apr 2019 15:26:38 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CD6712FE3514; Mon,  1 Apr 2019 15:26:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Rob Herring <robh@kernel.org>,
        Qiang Yu <yuq825@gmail.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 7/7] drm/lima: Use the drm_gem_fence_array_add helpers for our deps.
Date:   Mon,  1 Apr 2019 15:26:35 -0700
Message-Id: <20190401222635.25013-8-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401222635.25013-1-eric@anholt.net>
References: <20190401222635.25013-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tested this, but it's a pretty direct port of what I did for
v3d.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/lima/lima_gem.c   | 37 +----------------
 drivers/gpu/drm/lima/lima_sched.c | 66 ++++++-------------------------
 drivers/gpu/drm/lima/lima_sched.h |  6 +--
 3 files changed, 16 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 2d3cf96f6c58..8f80286c80b4 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -144,40 +144,7 @@ static int lima_gem_sync_bo(struct lima_sched_task *task, struct lima_bo *bo,
 	if (explicit)
 		return 0;
 
-	/* implicit sync use bo fence in resv obj */
-	if (write) {
-		unsigned nr_fences;
-		struct dma_fence **fences;
-		int i;
-
-		err = reservation_object_get_fences_rcu(
-			bo->gem.resv, NULL, &nr_fences, &fences);
-		if (err || !nr_fences)
-			return err;
-
-		for (i = 0; i < nr_fences; i++) {
-			err = lima_sched_task_add_dep(task, fences[i]);
-			if (err)
-				break;
-		}
-
-		/* for error case free remaining fences */
-		for ( ; i < nr_fences; i++)
-			dma_fence_put(fences[i]);
-
-		kfree(fences);
-	} else {
-		struct dma_fence *fence;
-
-		fence = reservation_object_get_excl_rcu(bo->gem.resv);
-		if (fence) {
-			err = lima_sched_task_add_dep(task, fence);
-			if (err)
-				dma_fence_put(fence);
-		}
-	}
-
-	return err;
+	return drm_gem_fence_array_add_implicit(&task->deps, &bo->gem, write);
 }
 
 static int lima_gem_lock_bos(struct lima_bo **bos, u32 nr_bos,
@@ -250,7 +217,7 @@ static int lima_gem_add_deps(struct drm_file *file, struct lima_submit *submit)
 		if (err)
 			return err;
 
-		err = lima_sched_task_add_dep(submit->task, fence);
+		err = drm_gem_fence_array_add(&submit->task->deps, fence);
 		if (err) {
 			dma_fence_put(fence);
 			return err;
diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 97bd9c1deb87..e253d031fb3d 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -3,6 +3,7 @@
 
 #include <linux/kthread.h>
 #include <linux/slab.h>
+#include <linux/xarray.h>
 
 #include "lima_drv.h"
 #include "lima_sched.h"
@@ -126,19 +127,24 @@ int lima_sched_task_init(struct lima_sched_task *task,
 
 	task->num_bos = num_bos;
 	task->vm = lima_vm_get(vm);
+
+	xa_init_flags(&task->deps, XA_FLAGS_ALLOC);
+
 	return 0;
 }
 
 void lima_sched_task_fini(struct lima_sched_task *task)
 {
+	struct dma_fence *fence;
+	unsigned long index;
 	int i;
 
 	drm_sched_job_cleanup(&task->base);
 
-	for (i = 0; i < task->num_dep; i++)
-		dma_fence_put(task->dep[i]);
-
-	kfree(task->dep);
+	xa_for_each(&task->deps, index, fence) {
+		dma_fence_put(fence);
+	}
+	xa_destroy(&task->deps);
 
 	if (task->bos) {
 		for (i = 0; i < task->num_bos; i++)
@@ -149,42 +155,6 @@ void lima_sched_task_fini(struct lima_sched_task *task)
 	lima_vm_put(task->vm);
 }
 
-int lima_sched_task_add_dep(struct lima_sched_task *task, struct dma_fence *fence)
-{
-	int i, new_dep = 4;
-
-	/* same context's fence is definitly earlier then this task */
-	if (fence->context == task->base.s_fence->finished.context) {
-		dma_fence_put(fence);
-		return 0;
-	}
-
-	if (task->dep && task->num_dep == task->max_dep)
-		new_dep = task->max_dep * 2;
-
-	if (task->max_dep < new_dep) {
-		void *dep = krealloc(task->dep, sizeof(*task->dep) * new_dep, GFP_KERNEL);
-
-		if (!dep)
-			return -ENOMEM;
-
-		task->max_dep = new_dep;
-		task->dep = dep;
-	}
-
-	for (i = 0; i < task->num_dep; i++) {
-		if (task->dep[i]->context == fence->context &&
-		    dma_fence_is_later(fence, task->dep[i])) {
-			dma_fence_put(task->dep[i]);
-			task->dep[i] = fence;
-			return 0;
-		}
-	}
-
-	task->dep[task->num_dep++] = fence;
-	return 0;
-}
-
 int lima_sched_context_init(struct lima_sched_pipe *pipe,
 			    struct lima_sched_context *context,
 			    atomic_t *guilty)
@@ -213,21 +183,9 @@ static struct dma_fence *lima_sched_dependency(struct drm_sched_job *job,
 					       struct drm_sched_entity *entity)
 {
 	struct lima_sched_task *task = to_lima_task(job);
-	int i;
-
-	for (i = 0; i < task->num_dep; i++) {
-		struct dma_fence *fence = task->dep[i];
-
-		if (!task->dep[i])
-			continue;
-
-		task->dep[i] = NULL;
 
-		if (!dma_fence_is_signaled(fence))
-			return fence;
-
-		dma_fence_put(fence);
-	}
+	if (!xa_empty(&task->deps))
+		return xa_erase(&task->deps, task->last_dep++);
 
 	return NULL;
 }
diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
index b017cfa7e327..928af91c1118 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -14,9 +14,8 @@ struct lima_sched_task {
 	struct lima_vm *vm;
 	void *frame;
 
-	struct dma_fence **dep;
-	int num_dep;
-	int max_dep;
+	struct xarray deps;
+	unsigned long last_dep;
 
 	struct lima_bo **bos;
 	int num_bos;
@@ -78,7 +77,6 @@ int lima_sched_task_init(struct lima_sched_task *task,
 			 struct lima_bo **bos, int num_bos,
 			 struct lima_vm *vm);
 void lima_sched_task_fini(struct lima_sched_task *task);
-int lima_sched_task_add_dep(struct lima_sched_task *task, struct dma_fence *fence);
 
 int lima_sched_context_init(struct lima_sched_pipe *pipe,
 			    struct lima_sched_context *context,
-- 
2.20.1

