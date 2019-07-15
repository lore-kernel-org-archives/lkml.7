Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C38C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5B820665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfGOK0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:26:20 -0400
Received: from foss.arm.com ([217.140.110.172]:46856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbfGOK0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:26:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFE5A2B;
        Mon, 15 Jul 2019 03:26:17 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 022683F59C;
        Mon, 15 Jul 2019 03:26:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, mgorman@suse.de,
        riel@surriel.com
Subject: [PATCH 2/3] sched/fair: Move task_numa_work() init to init_numa_balancing()
Date:   Mon, 15 Jul 2019 11:25:07 +0100
Message-Id: <20190715102508.32434-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715102508.32434-1-valentin.schneider@arm.com>
References: <20190715102508.32434-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only need to set the callback_head worker function once, do it
during sched_fork().

While at it, move the comment regarding double task_work addition to
init_numa_balancing(), since the double add sentinel is first set there.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 476b0201a8fb..74faa55bc52a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2441,7 +2441,7 @@ void task_numa_work(struct callback_head *work)
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
-	work->next = work; /* protect against double add */
+	work->next = work;
 	/*
 	 * Who cares about NUMA placement when they're dying.
 	 *
@@ -2585,12 +2585,15 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	/* Protect against double add, see task_tick_numa and task_numa_work */
 	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
 	p->numa_group			= NULL;
 	p->last_task_numa_placement	= 0;
 	p->last_sum_exec_runtime	= 0;
 
+	init_task_work(&p->numa_work, task_numa_work);
+
 	/* New address space, reset the preferred nid */
 	if (!(clone_flags & CLONE_VM)) {
 		p->numa_preferred_nid = NUMA_NO_NODE;
@@ -2639,10 +2642,8 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 			curr->numa_scan_period = task_scan_start(curr);
 		curr->node_stamp += period;
 
-		if (!time_before(jiffies, curr->mm->numa_next_scan)) {
-			init_task_work(work, task_numa_work); /* TODO: move this into sched_fork() */
+		if (!time_before(jiffies, curr->mm->numa_next_scan))
 			task_work_add(curr, work, true);
-		}
 	}
 }
 
--
2.22.0

