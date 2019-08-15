Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D6BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA1F20644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbfHOOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:52:05 -0400
Received: from foss.arm.com ([217.140.110.172]:45178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733165AbfHOOwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:52:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D321B1596;
        Thu, 15 Aug 2019 07:51:59 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0B813F706;
        Thu, 15 Aug 2019 07:51:58 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        tglx@linutronix.de, qais.yousef@arm.com
Subject: [PATCH v2 3/4] sched/fair: Check for CFS tasks before detach_one_task()
Date:   Thu, 15 Aug 2019 15:51:06 +0100
Message-Id: <20190815145107.5318-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815145107.5318-1-valentin.schneider@arm.com>
References: <20190815145107.5318-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

detach_one_task() (and the CFS load-balancer in general) can only ever
pull CFS tasks, so we should check if there's any before invoking the
cpu stopper.

Likewise, when the cpu stopper is already up, we can bail out slightly
earlier when we see there's no CFS task to detach.

Check for CFS tasks at the top of need_active_balance(), and add a
similar check in active_load_balance_cpu_stop().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
Note that this only touches the active load balance paths. IMO
load_balance() could go through a similar treatment
(s/rq.nr_running/rq.cfs.h_nr_running/ before going to detach_tasks())
but that conflicts with Vincent's rework, so I've not included it
here.
---
 kernel/sched/fair.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 751f41085f47..8f5f6cad5008 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8776,6 +8776,10 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
 
 	raw_spin_lock_irqsave(&busiest->lock, flags);
 
+	/* Is there actually anything to pull? */
+	if (busiest->cfs.h_nr_running < 1)
+		goto unlock;
+
 	/*
 	 * Don't kick the active_load_balance_cpu_stop, if the curr task on
 	 * busiest CPU can't be moved to dst_cpu:
@@ -9142,8 +9146,8 @@ static int active_load_balance_cpu_stop(void *data)
 		     !busiest_rq->active_balance))
 		goto out_unlock;
 
-	/* Is there any task to move? */
-	if (busiest_rq->nr_running <= 1)
+	/* Is there any CFS task to move? */
+	if (busiest_rq->cfs.h_nr_running < 1)
 		goto out_unlock;
 
 	/*
-- 
2.22.0

