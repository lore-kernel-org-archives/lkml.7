Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33B2C32756
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50A020B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHJUIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 16:08:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfHJUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:08:04 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwXek-0007tb-JY; Sat, 10 Aug 2019 22:08:02 +0200
Date:   Sat, 10 Aug 2019 20:01:51 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for 5.3-rc4
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
Message-ID: <156546731194.17538.15988994782634770420.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

up to:  04e048cf09d7: sched/psi: Do not require setsched permission from the trigger creator

Three fixlets for the scheduler:

 - Avoid double bandwidth accounting in the push & pull code

 - Use a sane FIFO priority for the Pressure Stall Information (PSI) thread.
 
 - Avoid permission checks when setting the scheduler params for the PSI thread

Thanks,

	tglx

------------------>
Dietmar Eggemann (1):
      sched/deadline: Fix double accounting of rq/running bw in push & pull

Peter Zijlstra (1):
      sched/psi: Reduce psimon FIFO priority

Suren Baghdasaryan (1):
      sched/psi: Do not require setsched permission from the trigger creator


 kernel/sched/deadline.c | 8 --------
 kernel/sched/psi.c      | 4 ++--
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef5b9f6b1d42..46122edd8552 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2088,17 +2088,13 @@ static int push_dl_task(struct rq *rq)
 	}
 
 	deactivate_task(rq, next_task, 0);
-	sub_running_bw(&next_task->dl, &rq->dl);
-	sub_rq_bw(&next_task->dl, &rq->dl);
 	set_task_cpu(next_task, later_rq->cpu);
-	add_rq_bw(&next_task->dl, &later_rq->dl);
 
 	/*
 	 * Update the later_rq clock here, because the clock is used
 	 * by the cpufreq_update_util() inside __add_running_bw().
 	 */
 	update_rq_clock(later_rq);
-	add_running_bw(&next_task->dl, &later_rq->dl);
 	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
 	ret = 1;
 
@@ -2186,11 +2182,7 @@ static void pull_dl_task(struct rq *this_rq)
 			resched = true;
 
 			deactivate_task(src_rq, p, 0);
-			sub_running_bw(&p->dl, &src_rq->dl);
-			sub_rq_bw(&p->dl, &src_rq->dl);
 			set_task_cpu(p, this_cpu);
-			add_rq_bw(&p->dl, &this_rq->dl);
-			add_running_bw(&p->dl, &this_rq->dl);
 			activate_task(this_rq, p, 0);
 			dmin = p->dl.deadline;
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7acc632c3b82..23fbbcc414d5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1051,7 +1051,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 
 	if (!rcu_access_pointer(group->poll_kworker)) {
 		struct sched_param param = {
-			.sched_priority = MAX_RT_PRIO - 1,
+			.sched_priority = 1,
 		};
 		struct kthread_worker *kworker;
 
@@ -1061,7 +1061,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			mutex_unlock(&group->trigger_lock);
 			return ERR_CAST(kworker);
 		}
-		sched_setscheduler(kworker->task, SCHED_FIFO, &param);
+		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
 		kthread_init_delayed_work(&group->poll_work,
 				psi_poll_work);
 		rcu_assign_pointer(group->poll_kworker, kworker);

