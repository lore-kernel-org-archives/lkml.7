Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D03CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464F42146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfCMXwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:52:20 -0400
Received: from anholt.net ([50.246.234.109]:53754 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfCMXwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:52:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E1F5710A2CC1;
        Wed, 13 Mar 2019 16:52:16 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id B0Mea7-s4rhI; Wed, 13 Mar 2019 16:52:14 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9105610A2C74;
        Wed, 13 Mar 2019 16:52:12 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 8014F2FE1FEB; Wed, 13 Mar 2019 16:52:11 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/4] drm/v3d: Rename the fence signaled from IRQs to "irq_fence".
Date:   Wed, 13 Mar 2019 16:52:09 -0700
Message-Id: <20190313235211.28995-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313235211.28995-1-eric@anholt.net>
References: <20190313235211.28995-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have another thing called the "done fence" that tracks when the
scheduler considers the job done, and having the shared name was
confusing.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_drv.h   |  4 ++--
 drivers/gpu/drm/v3d/v3d_gem.c   |  6 +++---
 drivers/gpu/drm/v3d/v3d_irq.c   |  6 +++---
 drivers/gpu/drm/v3d/v3d_sched.c | 12 ++++++------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index a128cd5ee6ea..284ced85ff02 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -169,7 +169,7 @@ struct v3d_job {
 	struct dma_fence *in_fence;
 
 	/* v3d fence to be signaled by IRQ handler when the job is complete. */
-	struct dma_fence *done_fence;
+	struct dma_fence *irq_fence;
 
 	/* GPU virtual addresses of the start/end of the CL job. */
 	u32 start, end;
@@ -216,7 +216,7 @@ struct v3d_tfu_job {
 	struct dma_fence *in_fence;
 
 	/* v3d fence to be signaled by IRQ handler when the job is complete. */
-	struct dma_fence *done_fence;
+	struct dma_fence *irq_fence;
 
 	struct v3d_dev *v3d;
 
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 8ebbc544c61e..b06bed0835c9 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -339,8 +339,8 @@ v3d_exec_cleanup(struct kref *ref)
 	dma_fence_put(exec->bin.in_fence);
 	dma_fence_put(exec->render.in_fence);
 
-	dma_fence_put(exec->bin.done_fence);
-	dma_fence_put(exec->render.done_fence);
+	dma_fence_put(exec->bin.irq_fence);
+	dma_fence_put(exec->render.irq_fence);
 
 	dma_fence_put(exec->bin_done_fence);
 	dma_fence_put(exec->render_done_fence);
@@ -373,7 +373,7 @@ v3d_tfu_job_cleanup(struct kref *ref)
 	unsigned int i;
 
 	dma_fence_put(job->in_fence);
-	dma_fence_put(job->done_fence);
+	dma_fence_put(job->irq_fence);
 
 	for (i = 0; i < ARRAY_SIZE(job->bo); i++) {
 		if (job->bo[i])
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index a09442ec7297..044062607577 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -96,7 +96,7 @@ v3d_irq(int irq, void *arg)
 
 	if (intsts & V3D_INT_FLDONE) {
 		struct v3d_fence *fence =
-			to_v3d_fence(v3d->bin_job->bin.done_fence);
+			to_v3d_fence(v3d->bin_job->bin.irq_fence);
 
 		trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
@@ -105,7 +105,7 @@ v3d_irq(int irq, void *arg)
 
 	if (intsts & V3D_INT_FRDONE) {
 		struct v3d_fence *fence =
-			to_v3d_fence(v3d->render_job->render.done_fence);
+			to_v3d_fence(v3d->render_job->render.irq_fence);
 
 		trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
@@ -141,7 +141,7 @@ v3d_hub_irq(int irq, void *arg)
 
 	if (intsts & V3D_HUB_INT_TFUC) {
 		struct v3d_fence *fence =
-			to_v3d_fence(v3d->tfu_job->done_fence);
+			to_v3d_fence(v3d->tfu_job->irq_fence);
 
 		trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index d0c68b7c8b41..e740f3b99aa5 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -156,9 +156,9 @@ static struct dma_fence *v3d_job_run(struct drm_sched_job *sched_job)
 	if (IS_ERR(fence))
 		return NULL;
 
-	if (job->done_fence)
-		dma_fence_put(job->done_fence);
-	job->done_fence = dma_fence_get(fence);
+	if (job->irq_fence)
+		dma_fence_put(job->irq_fence);
+	job->irq_fence = dma_fence_get(fence);
 
 	trace_v3d_submit_cl(dev, q == V3D_RENDER, to_v3d_fence(fence)->seqno,
 			    job->start, job->end);
@@ -199,9 +199,9 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 		return NULL;
 
 	v3d->tfu_job = job;
-	if (job->done_fence)
-		dma_fence_put(job->done_fence);
-	job->done_fence = dma_fence_get(fence);
+	if (job->irq_fence)
+		dma_fence_put(job->irq_fence);
+	job->irq_fence = dma_fence_get(fence);
 
 	trace_v3d_submit_tfu(dev, to_v3d_fence(fence)->seqno);
 
-- 
2.20.1

