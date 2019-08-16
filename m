Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61517C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810D206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfHPJbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:31:18 -0400
Received: from foss.arm.com ([217.140.110.172]:54070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfHPJbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:31:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7C7360;
        Fri, 16 Aug 2019 02:31:14 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C07A43F706;
        Fri, 16 Aug 2019 02:31:13 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panfrost: Queue jobs on the hardware
Date:   Fri, 16 Aug 2019 10:31:06 +0100
Message-Id: <20190816093107.30518-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware has a set of '_NEXT' registers that can hold a second job
while the first is executing. Make use of these registers to enqueue a
second job per slot.

Signed-off-by: Steven Price <steven.price@arm.com>
---
Note that this is based on top of Rob Herring's "per FD address space"
patch[1].

[1] https://marc.info/?i=20190813150115.30338-1-robh%20()%20kernel%20!%20org

 drivers/gpu/drm/panfrost/panfrost_device.h |  4 +-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 76 ++++++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_mmu.c    |  2 +-
 3 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index f503c566e99f..0153defd6085 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -55,7 +55,7 @@ struct panfrost_devfreq_slot {
 	ktime_t busy_time;
 	ktime_t idle_time;
 	ktime_t time_last_update;
-	bool busy;
+	int busy;
 };
 
 struct panfrost_device {
@@ -80,7 +80,7 @@ struct panfrost_device {
 
 	struct panfrost_job_slot *js;
 
-	struct panfrost_job *jobs[NUM_JOB_SLOTS];
+	struct panfrost_job *jobs[NUM_JOB_SLOTS][2];
 	struct list_head scheduled_jobs;
 
 	struct panfrost_perfcnt *perfcnt;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 05c85f45a0de..b2b5027af976 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -138,6 +138,37 @@ static void panfrost_job_write_affinity(struct panfrost_device *pfdev,
 	job_write(pfdev, JS_AFFINITY_NEXT_HI(js), affinity >> 32);
 }
 
+static int panfrost_job_count(struct panfrost_device *pfdev, int slot)
+{
+	if (pfdev->jobs[slot][0] == NULL)
+		return 0;
+	if (pfdev->jobs[slot][1] == NULL)
+		return 1;
+	return 2;
+}
+
+static struct panfrost_job *panfrost_dequeue_job(
+		struct panfrost_device *pfdev, int slot)
+{
+	struct panfrost_job *job = pfdev->jobs[slot][0];
+
+	pfdev->jobs[slot][0] = pfdev->jobs[slot][1];
+	pfdev->jobs[slot][1] = NULL;
+
+	return job;
+}
+
+static void panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
+				 struct panfrost_job *job)
+{
+	if (pfdev->jobs[slot][0] == NULL) {
+		pfdev->jobs[slot][0] = job;
+		return;
+	}
+	WARN_ON(pfdev->jobs[slot][1] != NULL);
+	pfdev->jobs[slot][1] = job;
+}
+
 static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
@@ -150,13 +181,16 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 	if (ret < 0)
 		return;
 
-	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js))))
-		goto end;
-
 	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
 
-	panfrost_devfreq_record_transition(pfdev, js);
 	spin_lock_irqsave(&pfdev->hwaccess_lock, flags);
+	panfrost_enqueue_job(pfdev, js, job);
+
+	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js))))
+		goto end;
+
+	if (panfrost_job_count(pfdev, js) == 1)
+		panfrost_devfreq_record_transition(pfdev, js);
 
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), jc_head >> 32);
@@ -186,9 +220,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 
 	job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
 
+end:
 	spin_unlock_irqrestore(&pfdev->hwaccess_lock, flags);
 
-end:
 	pm_runtime_mark_last_busy(pfdev->dev);
 	pm_runtime_put_autosuspend(pfdev->dev);
 }
@@ -336,8 +370,6 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
 
-	pfdev->jobs[slot] = job;
-
 	fence = panfrost_fence_create(pfdev, slot);
 	if (IS_ERR(fence))
 		return NULL;
@@ -421,21 +453,36 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
 	struct panfrost_device *pfdev = data;
 	u32 status = job_read(pfdev, JOB_INT_STAT);
 	int j;
+	unsigned long flags;
 
 	dev_dbg(pfdev->dev, "jobslot irq status=%x\n", status);
 
 	if (!status)
 		return IRQ_NONE;
 
+	spin_lock_irqsave(&pfdev->hwaccess_lock, flags);
+
 	pm_runtime_mark_last_busy(pfdev->dev);
 
 	for (j = 0; status; j++) {
 		u32 mask = MK_JS_MASK(j);
+		int jobs = panfrost_job_count(pfdev, j);
+		int active;
 
 		if (!(status & mask))
 			continue;
 
 		job_write(pfdev, JOB_INT_CLEAR, mask);
+		active = (job_read(pfdev, JOB_INT_JS_STATE) &
+			  JOB_INT_MASK_DONE(j)) ? 1 : 0;
+
+		if (!(status & JOB_INT_MASK_ERR(j))) {
+			/* Recheck RAWSTAT to check if there's a newly
+			 * failed job (since JOB_INT_STAT was read)
+			 */
+			status |= job_read(pfdev, JOB_INT_RAWSTAT) &
+				JOB_INT_MASK_ERR(j);
+		}
 
 		if (status & JOB_INT_MASK_ERR(j)) {
 			job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
@@ -447,20 +494,25 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
 				job_read(pfdev, JS_TAIL_LO(j)));
 
 			drm_sched_fault(&pfdev->js->queue[j].sched);
+			jobs --;
 		}
 
-		if (status & JOB_INT_MASK_DONE(j)) {
-			struct panfrost_job *job = pfdev->jobs[j];
+		while (jobs -- > active) {
+			struct panfrost_job *job =
+				panfrost_dequeue_job(pfdev, j);
 
-			pfdev->jobs[j] = NULL;
 			panfrost_mmu_as_put(pfdev, &job->file_priv->mmu);
-			panfrost_devfreq_record_transition(pfdev, j);
 			dma_fence_signal(job->done_fence);
 		}
 
+		if (!active)
+			panfrost_devfreq_record_transition(pfdev, j);
+
 		status &= ~mask;
 	}
 
+	spin_unlock_irqrestore(&pfdev->hwaccess_lock, flags);
+
 	return IRQ_HANDLED;
 }
 
@@ -491,7 +543,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 
 		ret = drm_sched_init(&js->queue[j].sched,
 				     &panfrost_sched_ops,
-				     1, 0, msecs_to_jiffies(500),
+				     2, 0, msecs_to_jiffies(500),
 				     "pan_js");
 		if (ret) {
 			dev_err(pfdev->dev, "Failed to create scheduler: %d.", ret);
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index f22d8f02568d..c25fd88ef437 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -147,7 +147,7 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 	as = mmu->as;
 	if (as >= 0) {
 		int en = atomic_inc_return(&mmu->as_count);
-		WARN_ON(en >= NUM_JOB_SLOTS);
+		WARN_ON(en >= NUM_JOB_SLOTS*2);
 
 		list_move(&mmu->list, &pfdev->as_lru_list);
 		goto out;
-- 
2.20.1

