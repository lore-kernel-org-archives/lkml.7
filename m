Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0DC20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfI0Ksd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:48:33 -0400
Received: from foss.arm.com ([217.140.110.172]:48924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0Ksc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:48:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E949628;
        Fri, 27 Sep 2019 03:48:31 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EE103F67D;
        Fri, 27 Sep 2019 03:48:30 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: drm_sched with panfrost crash on T820
To:     Neil Armstrong <narmstrong@baylibre.com>, daniel@ffwll.ch,
        airlied@linux.ie,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Erico Nunes <nunes.erico@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <e450fbe6-dec7-2704-59c2-db7e869d67f5@baylibre.com>
 <3fb178d8-f069-0ae2-1ed3-4ded84a71951@arm.com>
Message-ID: <26ae2a4d-8df1-e8db-3060-41638ed63e2a@arm.com>
Date:   Fri, 27 Sep 2019 11:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3fb178d8-f069-0ae2-1ed3-4ded84a71951@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2019 10:55, Steven Price wrote:
[...]
> One obvious issue with the DRM scheduler is that there is a call to
> cancel_delayed_work() in drm_sched_stop() which to me looks like it
> should be cancel_delayed_work_sync() to ensure that the timeout handling
> has completed.
> 
> However in the above scenario a _sync() variety would then cause a
> deadlock (one thread has pfdev->reset_lock and is waiting for the other
> thread which is trying to take the lock).
> 
> So we need to update Panfrost so that it can coordinate the reset
> between schedulers. Can you try something like the following (untested):

And actually testing it I of course discover it doesn't quite work. We
do need the cancel_delayed_work_sync() in the DRM scheduler (when
stopping a different scheduler) and we need to avoid holding the
reset_lock during the drm_sched_stop() call to prevent deadlocking with
another thread handling a timeout.

Can you give the following patch a spin? I don't have a great
reproduction case, so it would be good to get some confidence it fixes
the problem.

----8<----
From 521a286789260197ae94f698932ebf369efc45ad Mon Sep 17 00:00:00 2001
From: Steven Price <steven.price@arm.com>
Date: Fri, 27 Sep 2019 11:42:40 +0100
Subject: [PATCH] drm/panfrost: Handle resetting on timeout better

Panfrost uses multiple schedulers (one for each slot, so 2 in reality),
and on a timeout has to stop all the schedulers to safely perform a
reset. However more than one scheduler can trigger a timeout at the same
time. This race condition results in jobs being freed while they are
still in use.

Modify drm_sched_stop() to call cancel_delayed_work_sync() when stopping
a different scheduler to the one belonging to the passed in job.
panfrost_job_timedout() is also modified to only allow one thread at a
time to handle the reset. Any subsequent threads simply return assuming
that the first thread will handle the situation.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h |  2 ++
 drivers/gpu/drm/panfrost/panfrost_job.c    | 11 ++++++++++-
 drivers/gpu/drm/scheduler/sched_main.c     |  5 ++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index f503c566e99f..6441c7fba6c4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -99,6 +99,8 @@ struct panfrost_device {
 		unsigned long cur_volt;
 		struct panfrost_devfreq_slot slot[NUM_JOB_SLOTS];
 	} devfreq;
+
+	bool is_resetting;
 };
 
 struct panfrost_mmu {
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 05c85f45a0de..1b2019e08b43 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -388,13 +388,21 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 
 	mutex_lock(&pfdev->reset_lock);
 
+	if (pfdev->is_resetting) {
+		mutex_unlock(&pfdev->reset_lock);
+		return;
+	}
+	pfdev->is_resetting = true;
+
+	mutex_unlock(&pfdev->reset_lock);
+
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
 		drm_sched_stop(&pfdev->js->queue[i].sched, sched_job);
 
 	if (sched_job)
 		drm_sched_increase_karma(sched_job);
 
-	/* panfrost_core_dump(pfdev); */
+	mutex_lock(&pfdev->reset_lock);
 
 	panfrost_devfreq_record_transition(pfdev, js);
 	panfrost_device_reset(pfdev);
@@ -406,6 +414,7 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
 		drm_sched_start(&pfdev->js->queue[i].sched, true);
 
+	pfdev->is_resetting = false;
 	mutex_unlock(&pfdev->reset_lock);
 }
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 148468447ba9..bc6d1862ec8a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -415,7 +415,10 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 	 * this TDR finished and before the newly restarted jobs had a
 	 * chance to complete.
 	 */
-	cancel_delayed_work(&sched->work_tdr);
+	if (bad->sched != sched)
+		cancel_delayed_work_sync(&sched->work_tdr);
+	else
+		cancel_delayed_work(&sched->work_tdr);
 }
 
 EXPORT_SYMBOL(drm_sched_stop);
-- 
2.20.1

