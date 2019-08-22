Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3062C3A5A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7842216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfHVCSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:18:54 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34114 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbfHVCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:18:13 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i0cfX-0001S6-Ji; Wed, 21 Aug 2019 22:17:43 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 14/15] sched,fair: ramp up task_se_h_weight quickly
Date:   Wed, 21 Aug 2019 22:17:39 -0400
Message-Id: <20190822021740.15554-15-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822021740.15554-1-riel@surriel.com>
References: <20190822021740.15554-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in update_cfs_group / calc_group_shares has some logic to
quickly ramp up the load when a task has just started running in a
cgroup, in order to get sane values for the cgroup se->load.weight.

This code adds a similar hack to task_se_h_weight.

However, THIS CODE IS WRONG, since it does not do things hierarchically.

I am wondering a few things here:
1) Should I have something similar to the logic in calc_group_shares
   in update_cfs_rq_h_load?
2) If so, should I also use that fast-ramp-up value for task_h_load,
   to prevent the load balancer from thinking it is moving zero weight
   tasks around?
3) If update_cfs_rq_h_load is the wrong place, where should I be
   calculating a hierarchical group weight value, instead?

Not-yet-signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d6c881c5c4d5..3df5d60b245f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7672,6 +7672,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 static unsigned long task_se_h_weight(struct sched_entity *se)
 {
+	unsigned long group_load;
 	struct cfs_rq *cfs_rq;
 
 	if (!task_se_in_cgroup(se))
@@ -7680,8 +7681,12 @@ static unsigned long task_se_h_weight(struct sched_entity *se)
 	cfs_rq = group_cfs_rq_of_parent(se);
 	update_cfs_rq_h_load(cfs_rq);
 
+	/* Ramp up quickly to keep h_weight sane. */
+	group_load = max(scale_load_down(se->parent->load.weight),
+							cfs_rq->h_load);
+
 	/* Reduce the load.weight by the h_load of the group the task is in. */
-	return (cfs_rq->h_load * se->load.weight) >> SCHED_FIXEDPOINT_SHIFT;
+	return (group_load * se->load.weight) >> SCHED_FIXEDPOINT_SHIFT;
 }
 
 static unsigned long task_se_h_load(struct sched_entity *se)
-- 
2.20.1

