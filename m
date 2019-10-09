Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6A5ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C42320673
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfJIJpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:45:03 -0400
Received: from foss.arm.com ([217.140.110.172]:58302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbfJIJpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:45:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CA8128;
        Wed,  9 Oct 2019 02:45:02 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E759A3F68E;
        Wed,  9 Oct 2019 02:45:00 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/2] drm/panfrost: Handle resetting on timeout better
Date:   Wed,  9 Oct 2019 10:44:55 +0100
Message-Id: <20191009094456.9704-1-steven.price@arm.com>
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
sched_job not being NULL, let's remove the unnecessary checks.

Fixes: aa20236784ab ("drm/panfrost: Prevent concurrent resets")
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
v2:
 * Added fixes and tested-by tags
 * Moved cleanup of panfrost_core_dump() comment to separate patch

 drivers/gpu/drm/panfrost/panfrost_job.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index a58551668d9a..21f34d44aac2 100644
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
-- 
2.20.1

