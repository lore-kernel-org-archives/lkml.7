Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA7C4CECC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC192067D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfILL2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:28:16 -0400
Received: from foss.arm.com ([217.140.110.172]:32800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbfILL2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:28:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D74C015AB;
        Thu, 12 Sep 2019 04:28:14 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8279A3F67D;
        Thu, 12 Sep 2019 04:28:13 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panfrost: Simplify devfreq utilisation tracking
Date:   Thu, 12 Sep 2019 12:28:04 +0100
Message-Id: <20190912112804.10104-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912112804.10104-1-steven.price@arm.com>
References: <20190912112804.10104-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of tracking per-slot utilisation track a single value for the
entire GPU. Ultimately it doesn't matter if the GPU is busy with only
vertex or a combination of vertex and fragment processing - if it's busy
then it's busy and devfreq should be scaling appropriately.

This also makes way for being able to submit multiple jobs per slot
which requires more values than the original boolean per slot.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 64 ++++++++-------------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  3 +-
 drivers/gpu/drm/panfrost/panfrost_device.h  | 12 ++--
 drivers/gpu/drm/panfrost/panfrost_job.c     | 14 ++---
 4 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 7ded282a5ca8..4c4e8a30a1ac 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -13,7 +13,7 @@
 #include "panfrost_gpu.h"
 #include "panfrost_regs.h"
 
-static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev, int slot);
+static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev);
 
 static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 				   u32 flags)
@@ -32,37 +32,23 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 
 static void panfrost_devfreq_reset(struct panfrost_device *pfdev)
 {
-	ktime_t now = ktime_get();
-	int i;
-
-	for (i = 0; i < NUM_JOB_SLOTS; i++) {
-		pfdev->devfreq.slot[i].busy_time = 0;
-		pfdev->devfreq.slot[i].idle_time = 0;
-		pfdev->devfreq.slot[i].time_last_update = now;
-	}
+	pfdev->devfreq.busy_time = 0;
+	pfdev->devfreq.idle_time = 0;
+	pfdev->devfreq.time_last_update = ktime_get();
 }
 
 static int panfrost_devfreq_get_dev_status(struct device *dev,
 					   struct devfreq_dev_status *status)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
-	int i;
 
-	for (i = 0; i < NUM_JOB_SLOTS; i++) {
-		panfrost_devfreq_update_utilization(pfdev, i);
-	}
+	panfrost_devfreq_update_utilization(pfdev);
 
 	status->current_frequency = clk_get_rate(pfdev->clock);
-	status->total_time = ktime_to_ns(ktime_add(pfdev->devfreq.slot[0].busy_time,
-						   pfdev->devfreq.slot[0].idle_time));
-
-	status->busy_time = 0;
-	for (i = 0; i < NUM_JOB_SLOTS; i++) {
-		status->busy_time += ktime_to_ns(pfdev->devfreq.slot[i].busy_time);
-	}
+	status->total_time = ktime_to_ns(ktime_add(pfdev->devfreq.busy_time,
+						   pfdev->devfreq.idle_time));
 
-	/* We're scheduling only to one core atm, so don't divide for now */
-	/* status->busy_time /= NUM_JOB_SLOTS; */
+	status->busy_time = ktime_to_ns(pfdev->devfreq.busy_time);
 
 	panfrost_devfreq_reset(pfdev);
 
@@ -134,14 +120,10 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
 {
-	int i;
-
 	if (!pfdev->devfreq.devfreq)
 		return;
 
 	panfrost_devfreq_reset(pfdev);
-	for (i = 0; i < NUM_JOB_SLOTS; i++)
-		pfdev->devfreq.slot[i].busy = false;
 
 	devfreq_resume_device(pfdev->devfreq.devfreq);
 }
@@ -154,9 +136,8 @@ void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
 	devfreq_suspend_device(pfdev->devfreq.devfreq);
 }
 
-static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev, int slot)
+static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
 {
-	struct panfrost_devfreq_slot *devfreq_slot = &pfdev->devfreq.slot[slot];
 	ktime_t now;
 	ktime_t last;
 
@@ -164,22 +145,27 @@ static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev, i
 		return;
 
 	now = ktime_get();
-	last = pfdev->devfreq.slot[slot].time_last_update;
+	last = pfdev->devfreq.time_last_update;
 
-	/* If we last recorded a transition to busy, we have been idle since */
-	if (devfreq_slot->busy)
-		pfdev->devfreq.slot[slot].busy_time += ktime_sub(now, last);
+	if (atomic_read(&pfdev->devfreq.busy_count) > 0)
+		pfdev->devfreq.busy_time += ktime_sub(now, last);
 	else
-		pfdev->devfreq.slot[slot].idle_time += ktime_sub(now, last);
+		pfdev->devfreq.idle_time += ktime_sub(now, last);
+
+	pfdev->devfreq.time_last_update = now;
+}
 
-	pfdev->devfreq.slot[slot].time_last_update = now;
+void panfrost_devfreq_record_busy(struct panfrost_device *pfdev)
+{
+	panfrost_devfreq_update_utilization(pfdev);
+	atomic_inc(&pfdev->devfreq.busy_count);
 }
 
-/* The job scheduler is expected to call this at every transition busy <-> idle */
-void panfrost_devfreq_record_transition(struct panfrost_device *pfdev, int slot)
+void panfrost_devfreq_record_idle(struct panfrost_device *pfdev)
 {
-	struct panfrost_devfreq_slot *devfreq_slot = &pfdev->devfreq.slot[slot];
+	int count;
 
-	panfrost_devfreq_update_utilization(pfdev, slot);
-	devfreq_slot->busy = !devfreq_slot->busy;
+	panfrost_devfreq_update_utilization(pfdev);
+	count = atomic_dec_if_positive(&pfdev->devfreq.busy_count);
+	WARN_ON(count < 0);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index e3bc63e82843..0611beffc8d0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -10,6 +10,7 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev);
 void panfrost_devfreq_resume(struct panfrost_device *pfdev);
 void panfrost_devfreq_suspend(struct panfrost_device *pfdev);
 
-void panfrost_devfreq_record_transition(struct panfrost_device *pfdev, int slot);
+void panfrost_devfreq_record_busy(struct panfrost_device *pfdev);
+void panfrost_devfreq_record_idle(struct panfrost_device *pfdev);
 
 #endif /* __PANFROST_DEVFREQ_H__ */
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 4c2b3c84baac..233957f88d77 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -51,13 +51,6 @@ struct panfrost_features {
 	unsigned long hw_issues[64 / BITS_PER_LONG];
 };
 
-struct panfrost_devfreq_slot {
-	ktime_t busy_time;
-	ktime_t idle_time;
-	ktime_t time_last_update;
-	bool busy;
-};
-
 struct panfrost_device {
 	struct device *dev;
 	struct drm_device *ddev;
@@ -95,7 +88,10 @@ struct panfrost_device {
 	struct {
 		struct devfreq *devfreq;
 		struct thermal_cooling_device *cooling;
-		struct panfrost_devfreq_slot slot[NUM_JOB_SLOTS];
+		ktime_t busy_time;
+		ktime_t idle_time;
+		ktime_t time_last_update;
+		atomic_t busy_count;
 	} devfreq;
 };
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 05c85f45a0de..47aeadb4f161 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -155,7 +155,7 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 
 	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
 
-	panfrost_devfreq_record_transition(pfdev, js);
+	panfrost_devfreq_record_busy(pfdev);
 	spin_lock_irqsave(&pfdev->hwaccess_lock, flags);
 
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
@@ -396,7 +396,7 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 
 	/* panfrost_core_dump(pfdev); */
 
-	panfrost_devfreq_record_transition(pfdev, js);
+	panfrost_devfreq_record_idle(pfdev);
 	panfrost_device_reset(pfdev);
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
@@ -454,7 +454,7 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
 
 			pfdev->jobs[j] = NULL;
 			panfrost_mmu_as_put(pfdev, &job->file_priv->mmu);
-			panfrost_devfreq_record_transition(pfdev, j);
+			panfrost_devfreq_record_idle(pfdev);
 			dma_fence_signal(job->done_fence);
 		}
 
@@ -551,14 +551,14 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
 	struct panfrost_job_slot *js = pfdev->js;
 	int i;
 
+	/* Check whether the hardware is idle */
+	if (atomic_read(&pfdev->devfreq.busy_count))
+		return false;
+
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		/* If there are any jobs in the HW queue, we're not idle */
 		if (atomic_read(&js->queue[i].sched.hw_rq_count))
 			return false;
-
-		/* Check whether the hardware is idle */
-		if (pfdev->devfreq.slot[i].busy)
-			return false;
 	}
 
 	return true;
-- 
2.20.1

