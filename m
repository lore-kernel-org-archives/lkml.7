Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EAEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB5321721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfJGMuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:50:25 -0400
Received: from foss.arm.com ([217.140.110.172]:33790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfJGMuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:50:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D38001570;
        Mon,  7 Oct 2019 05:50:24 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9840E3F706;
        Mon,  7 Oct 2019 05:50:23 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] drm/panfrost: Handle resetting on timeout better
Date:   Mon,  7 Oct 2019 13:50:14 +0100
Message-Id: <20191007125014.12595-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panfrost uses multiple schedulers (one for each slot, so 2 in reality),
and on a timeout has to stop all the schedulers to safely perform a
reset. However more than one scheduler can trigger a timeout at the same
time. This race condition results in jobs being freed while they are
still in use.

When stopping other slots use cancel_delayed_work_sync() to ensure that
any timeout started for that slot has completed. Also use
mutex_trylock() to obtain reset_lock. This means that only one thread
attempts the reset, the other threads will simply complete without doing
anything (the first thread will wait for this in the call to
cancel_delayed_work_sync()).

While we're here and since the function is already dependent on
sched_job not being NULL, let's remove the unnecessary checks, along
with a commented out call to panfrost_core_dump() which has never
existed in mainline.

Signed-off-by: Steven Price <steven.price@arm.com>
---
This is a tidied up version of the patch orginally posted here:
http://lkml.kernel.org/r/26ae2a4d-8df1-e8db-3060-41638ed63e2a%40arm.com

 drivers/gpu/drm/panfrost/panfrost_job.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index a58551668d9a..dcc9a7603685 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -381,13 +381,19 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 		job_read(pfdev, JS_TAIL_LO(js)),
 		sched_job);
 
-	mutex_lock(&pfdev->reset_lock);
+	if (!mutex_trylock(&pfdev->reset_lock))
+		return;
 
-	for (i = 0; i < NUM_JOB_SLOTS; i++)
-		drm_sched_stop(&pfdev->js->queue[i].sched, sched_job);
+	for (i = 0; i < NUM_JOB_SLOTS; i++) {
+		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
+
+		drm_sched_stop(sched, sched_job);
+		if (js != i)
+			/* Ensure any timeouts on other slots have finished */
+			cancel_delayed_work_sync(&sched->work_tdr);
+	}
 
-	if (sched_job)
-		drm_sched_increase_karma(sched_job);
+	drm_sched_increase_karma(sched_job);
 
 	spin_lock_irqsave(&pfdev->js->job_lock, flags);
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
@@ -398,7 +404,6 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 	}
 	spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
 
-	/* panfrost_core_dump(pfdev); */
 
 	panfrost_devfreq_record_transition(pfdev, js);
 	panfrost_device_reset(pfdev);
-- 
2.20.1

