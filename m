Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A7C73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F512082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfGIL6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:58:17 -0400
Received: from foss.arm.com ([217.140.110.172]:42202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfGIL6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:58:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30D742B;
        Tue,  9 Jul 2019 04:58:16 -0700 (PDT)
Received: from e108031-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4720D3F59C;
        Tue,  9 Jul 2019 04:58:15 -0700 (PDT)
From:   Chris Redpath <chris.redpath@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        Chris Redpath <chris.redpath@arm.com>
Subject: [PATCH] sched/fair: Update rq_clock, cfs_rq before migrating for asym cpu capacity
Date:   Tue,  9 Jul 2019 12:57:59 +0100
Message-Id: <20190709115759.10451-1-chris.redpath@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ancient workaround to avoid the cost of updating rq clocks in the
middle of a migration causes some issues on asymmetric CPU capacity
systems where we use task utilization to determine which cpus fit a task.
On quiet systems we can inflate task util after a migration which
causes misfit to fire and force-migrate the task.

This occurs when:

(a) a task has util close to the non-overutilized capacity limit of a
    particular cpu (cpu0 here); and
(b) the prev_cpu was quiet otherwise, such that rq clock is
    sufficiently out of date (cpu1 here).

e.g.
                              _____
cpu0: ________________________|   |______________

                                  |<- misfit happens
          ______                  ___         ___
cpu1: ____|    |______________|___| |_________|

             ->|              |<- wakeup migration time
last rq clock update

When the task util is in just the right range for the system, we can end
up migrating an unlucky task back and forth many times until we are lucky
and the source rq happens to be updated close to the migration time.

In order to address this, lets update both rq_clock and cfs_rq where
this could be an issue.

Signed-off-by: Chris Redpath <chris.redpath@arm.com>
---
 kernel/sched/fair.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b798fe7ff7cd..51791db26a2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6545,6 +6545,21 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * wakee task is less decayed, but giving the wakee more load
 		 * sounds not bad.
 		 */
+		if (static_branch_unlikely(&sched_asym_cpucapacity) &&
+			p->state == TASK_WAKING) {
+			/*
+			 * On asymmetric capacity systems task util guides
+			 * wake placement so update rq_clock and cfs_rq
+			 */
+			struct cfs_rq *cfs_rq = task_cfs_rq(p);
+			struct rq *rq = task_rq(p);
+			struct rq_flags rf;
+
+			rq_lock_irqsave(rq, &rf);
+			update_rq_clock(rq);
+			update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+			rq_unlock_irqrestore(rq, &rf);
+		}
 		remove_entity_load_avg(&p->se);
 	}
 
-- 
2.17.1

