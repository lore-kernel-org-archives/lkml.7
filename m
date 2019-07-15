Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC26C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E91220665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfGOK0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:26:17 -0400
Received: from foss.arm.com ([217.140.110.172]:46844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbfGOK0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:26:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CA94344;
        Mon, 15 Jul 2019 03:26:16 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 235103F59C;
        Mon, 15 Jul 2019 03:26:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, mgorman@suse.de,
        riel@surriel.com
Subject: [PATCH 1/3] sched/fair: Move init_numa_balancing() below task_numa_work()
Date:   Mon, 15 Jul 2019 11:25:06 +0100
Message-Id: <20190715102508.32434-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715102508.32434-1-valentin.schneider@arm.com>
References: <20190715102508.32434-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reference task_numa_work() from within init_numa_balancing(), we
need the former to be declared before the latter. Do just that.

This is a pure code movement.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 82 ++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..476b0201a8fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1169,47 +1169,6 @@ static unsigned int task_scan_max(struct task_struct *p)
 	return max(smin, smax);
 }
 
-void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
-{
-	int mm_users = 0;
-	struct mm_struct *mm = p->mm;
-
-	if (mm) {
-		mm_users = atomic_read(&mm->mm_users);
-		if (mm_users == 1) {
-			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
-			mm->numa_scan_seq = 0;
-		}
-	}
-	p->node_stamp			= 0;
-	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
-	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
-	p->numa_work.next		= &p->numa_work;
-	p->numa_faults			= NULL;
-	p->numa_group			= NULL;
-	p->last_task_numa_placement	= 0;
-	p->last_sum_exec_runtime	= 0;
-
-	/* New address space, reset the preferred nid */
-	if (!(clone_flags & CLONE_VM)) {
-		p->numa_preferred_nid = NUMA_NO_NODE;
-		return;
-	}
-
-	/*
-	 * New thread, keep existing numa_preferred_nid which should be copied
-	 * already by arch_dup_task_struct but stagger when scans start.
-	 */
-	if (mm) {
-		unsigned int delay;
-
-		delay = min_t(unsigned int, task_scan_max(current),
-			current->numa_scan_period * mm_users * NSEC_PER_MSEC);
-		delay += 2 * TICK_NSEC;
-		p->node_stamp = delay;
-	}
-}
-
 static void account_numa_enqueue(struct rq *rq, struct task_struct *p)
 {
 	rq->nr_numa_running += (p->numa_preferred_nid != NUMA_NO_NODE);
@@ -2611,6 +2570,47 @@ void task_numa_work(struct callback_head *work)
 	}
 }
 
+void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
+{
+	int mm_users = 0;
+	struct mm_struct *mm = p->mm;
+
+	if (mm) {
+		mm_users = atomic_read(&mm->mm_users);
+		if (mm_users == 1) {
+			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+			mm->numa_scan_seq = 0;
+		}
+	}
+	p->node_stamp			= 0;
+	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
+	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	p->numa_work.next		= &p->numa_work;
+	p->numa_faults			= NULL;
+	p->numa_group			= NULL;
+	p->last_task_numa_placement	= 0;
+	p->last_sum_exec_runtime	= 0;
+
+	/* New address space, reset the preferred nid */
+	if (!(clone_flags & CLONE_VM)) {
+		p->numa_preferred_nid = NUMA_NO_NODE;
+		return;
+	}
+
+	/*
+	 * New thread, keep existing numa_preferred_nid which should be copied
+	 * already by arch_dup_task_struct but stagger when scans start.
+	 */
+	if (mm) {
+		unsigned int delay;
+
+		delay = min_t(unsigned int, task_scan_max(current),
+			current->numa_scan_period * mm_users * NSEC_PER_MSEC);
+		delay += 2 * TICK_NSEC;
+		p->node_stamp = delay;
+	}
+}
+
 /*
  * Drive the periodic memory faults..
  */
--
2.22.0

