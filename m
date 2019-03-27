Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D52C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30192075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714604;
	bh=EpLJ3u0C6+VxruNbP/k5cof3OA9WelL0IhLBMySVgG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kC2IvtyVEE5NbJwlt4iKuDZ/mcnRKxcgdJGVhZTHQFhfn+DKT/CaS3T2wCYZNs6r6
	 rx6f6vWZjvFqfQO96F9cXLjBOsu/RJ5LWuwUnCkKWrMXfv7TyAWbln+FMCdw8e8Dcv
	 1C5AXvZW9Yss+E+ID37qxdcfn5z8CT3mN30ROwJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfC0TXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387862AbfC0SGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:06:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902E021734;
        Wed, 27 Mar 2019 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709966;
        bh=EpLJ3u0C6+VxruNbP/k5cof3OA9WelL0IhLBMySVgG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQ6QjnDl4vsMtdvKyGKuvuW9Mxq6DNRx/+Z+lf3dRYrdT25/1i9t79qApCE3Gx0DO
         8N0MrDpx4lGR9Rc5HsciNlG0Jg71KdJqnP9zJR1/AzTPJXG+/JM4xpMthu/zaMB3YK
         xiPXJbPaYAdLvikuTz4ZXRBETf54tI8DBtRq0o8Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 135/262] drm/sched: Fix entities with 0 rqs.
Date:   Wed, 27 Mar 2019 13:59:50 -0400
Message-Id: <20190327180158.10245-135-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

[ Upstream commit 1decbf6bb0b4dc56c9da6c5e57b994ebfc2be3aa ]

Some blocks in amdgpu can have 0 rqs.

Job creation already fails with -ENOENT when entity->rq is NULL,
so jobs cannot be pushed. Without a rq there is no scheduler to
pop jobs, and rq selection already does the right thing with a
list of length 0.

So the operations we need to fix are:
  - Creation, do not set rq to rq_list[0] if the list can have length 0.
  - Do not flush any jobs when there is no rq.
  - On entity destruction handle the rq = NULL case.
  - on set_priority, do not try to change the rq if it is NULL.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 39 ++++++++++++++++--------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e2942c9a11a7..35ddbec1375a 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -52,12 +52,12 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 {
 	int i;
 
-	if (!(entity && rq_list && num_rq_list > 0 && rq_list[0]))
+	if (!(entity && rq_list && (num_rq_list == 0 || rq_list[0])))
 		return -EINVAL;
 
 	memset(entity, 0, sizeof(struct drm_sched_entity));
 	INIT_LIST_HEAD(&entity->list);
-	entity->rq = rq_list[0];
+	entity->rq = NULL;
 	entity->guilty = guilty;
 	entity->num_rq_list = num_rq_list;
 	entity->rq_list = kcalloc(num_rq_list, sizeof(struct drm_sched_rq *),
@@ -67,6 +67,10 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 
 	for (i = 0; i < num_rq_list; ++i)
 		entity->rq_list[i] = rq_list[i];
+
+	if (num_rq_list)
+		entity->rq = rq_list[0];
+
 	entity->last_scheduled = NULL;
 
 	spin_lock_init(&entity->rq_lock);
@@ -165,6 +169,9 @@ long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 	struct task_struct *last_user;
 	long ret = timeout;
 
+	if (!entity->rq)
+		return 0;
+
 	sched = entity->rq->sched;
 	/**
 	 * The client will not queue more IBs during this fini, consume existing
@@ -264,20 +271,24 @@ static void drm_sched_entity_kill_jobs(struct drm_sched_entity *entity)
  */
 void drm_sched_entity_fini(struct drm_sched_entity *entity)
 {
-	struct drm_gpu_scheduler *sched;
+	struct drm_gpu_scheduler *sched = NULL;
 
-	sched = entity->rq->sched;
-	drm_sched_rq_remove_entity(entity->rq, entity);
+	if (entity->rq) {
+		sched = entity->rq->sched;
+		drm_sched_rq_remove_entity(entity->rq, entity);
+	}
 
 	/* Consumption of existing IBs wasn't completed. Forcefully
 	 * remove them here.
 	 */
 	if (spsc_queue_peek(&entity->job_queue)) {
-		/* Park the kernel for a moment to make sure it isn't processing
-		 * our enity.
-		 */
-		kthread_park(sched->thread);
-		kthread_unpark(sched->thread);
+		if (sched) {
+			/* Park the kernel for a moment to make sure it isn't processing
+			 * our enity.
+			 */
+			kthread_park(sched->thread);
+			kthread_unpark(sched->thread);
+		}
 		if (entity->dependency) {
 			dma_fence_remove_callback(entity->dependency,
 						  &entity->cb);
@@ -362,9 +373,11 @@ void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 	for (i = 0; i < entity->num_rq_list; ++i)
 		drm_sched_entity_set_rq_priority(&entity->rq_list[i], priority);
 
-	drm_sched_rq_remove_entity(entity->rq, entity);
-	drm_sched_entity_set_rq_priority(&entity->rq, priority);
-	drm_sched_rq_add_entity(entity->rq, entity);
+	if (entity->rq) {
+		drm_sched_rq_remove_entity(entity->rq, entity);
+		drm_sched_entity_set_rq_priority(&entity->rq, priority);
+		drm_sched_rq_add_entity(entity->rq, entity);
+	}
 
 	spin_unlock(&entity->rq_lock);
 }
-- 
2.19.1

