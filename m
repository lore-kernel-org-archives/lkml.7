Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2409DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B0D216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfGZI3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:29:39 -0400
Received: from foss.arm.com ([217.140.110.172]:39482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZI3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:29:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC53C152D;
        Fri, 26 Jul 2019 01:29:35 -0700 (PDT)
Received: from e107985-lin.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D06F3F71A;
        Fri, 26 Jul 2019 01:29:34 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] sched/deadline: Fix double accounting of rq/running bw in push_dl_task()
Date:   Fri, 26 Jul 2019 09:27:52 +0100
Message-Id: <20190726082756.5525-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726082756.5525-1-dietmar.eggemann@arm.com>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

push_dl_task() always calls deactivate_task() with flags=0 which sets
p->on_rq=TASK_ON_RQ_MIGRATING.
push_dl_task()->deactivate_task()->dequeue_task()->dequeue_task_dl()
calls sub_[running/rq]_bw() since p->on_rq=TASK_ON_RQ_MIGRATING.
So sub_[running/rq]_bw() in push_dl_task() is double-accounting for
that task.

The same is true for add_[rq/running]_bw() and activate_task() on the
destination (later) CPU.
push_dl_task()->activate_task()->enqueue_task()->enqueue_task_dl()
calls add_[rq/running]_bw() again since p->on_rq is still set to
TASK_ON_RQ_MIGRATING.
So the add_[rq/running]_bw() in enqueue_task_dl() is double-accounting
for that task.

Fix this by removing the rq/running bw accounting in push_dl_task().

Trace (CONFIG_SCHED_DEBUG=y) before the fix on a 6 CPUs system with 6
DL (12000, 100000, 100000) tasks showing the issue:

[   48.147868] dl_rq->running_bw > old
[   48.147886] WARNING: CPU: 1 PID: 0 at kernel/sched/deadline.c:98
...
[   48.274832]  inactive_task_timer+0x468/0x4e8
[   48.279057]  __hrtimer_run_queues+0x10c/0x3b8
[   48.283364]  hrtimer_interrupt+0xd4/0x250
[   48.287330]  tick_handle_oneshot_broadcast+0x198/0x1d0
...
[   48.360057] dl_rq->running_bw > dl_rq->this_bw
[   48.360065] WARNING: CPU: 1 PID: 0 at kernel/sched/deadline.c:86
...
[   48.488294]  task_contending+0x1a0/0x208
[   48.492172]  enqueue_task_dl+0x3b8/0x970
[   48.496050]  activate_task+0x70/0xd0
[   48.499584]  ttwu_do_activate+0x50/0x78
[   48.503375]  try_to_wake_up+0x270/0x7a0
[   48.507167]  wake_up_process+0x14/0x20
[   48.510873]  hrtimer_wakeup+0x1c/0x30
...
[   50.062867] dl_rq->this_bw > old
[   50.062885] WARNING: CPU: 1 PID: 2048 at kernel/sched/deadline.c:122
...
[   50.190520]  dequeue_task_dl+0x1e4/0x1f8
[   50.194400]  __sched_setscheduler+0x1d0/0x860
[   50.198707]  _sched_setscheduler+0x74/0x98
[   50.202757]  do_sched_setscheduler+0xa8/0x110
[   50.207065]  __arm64_sys_sched_setscheduler+0x1c/0x30

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index de2bd006fe93..d1aeada374e1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2121,17 +2121,13 @@ static int push_dl_task(struct rq *rq)
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
 
-- 
2.17.1

