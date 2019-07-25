Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1E5C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C8322BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fD9EKVfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbfGYQMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:12:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389184AbfGYQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:12:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGCOZ81074569
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:12:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGCOZ81074569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071145;
        bh=/PxKEBEMgFwjssVT3ItBw1e8n4z5gTVNDoJCXf0gjvI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fD9EKVfFZktGaQl/5hBFPY2Gb5/84Q4Xvxx+41P+aTc5iRM7G9YscEOoBe+Fgdu2a
         xeSHI+kHPUlQXCshCM6iiFafMWWQn/81IU1m0h7SNYoUo6uJpiyVdwg9pe9hIQrSOA
         IPaJ4123C618phtE4moSPao63f2GLZB0JOdCH3tsbtdKRBCMkNM+8lVpK7lViOOp75
         ry9lhO3q17QmH1ewfSo5K/kEuNGieTu7KFa8jmMGTqjRB1CaHtHM66uZBKPZtQPpkl
         gs0umyWoHQ+/lUrUm0TGjal26oDKBglFV6OCwkeIkQBZe9WD2MX2UfPIZ0UIsAUxhg
         Pa67jkLVx2SzA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGCORg1074566;
        Thu, 25 Jul 2019 09:12:24 -0700
Date:   Thu, 25 Jul 2019 09:12:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-b34920d4ce6e6fc9424c20a4be98676eb543122f@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        valentin.schneider@arm.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org
In-Reply-To: <20190715102508.32434-3-valentin.schneider@arm.com>
References: <20190715102508.32434-3-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Move task_numa_work() init to
 init_numa_balancing()
Git-Commit-ID: b34920d4ce6e6fc9424c20a4be98676eb543122f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b34920d4ce6e6fc9424c20a4be98676eb543122f
Gitweb:     https://git.kernel.org/tip/b34920d4ce6e6fc9424c20a4be98676eb543122f
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 15 Jul 2019 11:25:07 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:51 +0200

sched/fair: Move task_numa_work() init to init_numa_balancing()

We only need to set the callback_head worker function once, do it
during sched_fork().

While at it, move the comment regarding double task_work addition to
init_numa_balancing(), since the double add sentinel is first set there.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: mgorman@suse.de
Cc: riel@surriel.com
Link: https://lkml.kernel.org/r/20190715102508.32434-3-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f0c488015649..fd391fc00ed8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2495,7 +2495,7 @@ void task_numa_work(struct callback_head *work)
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
-	work->next = work; /* protect against double add */
+	work->next = work;
 	/*
 	 * Who cares about NUMA placement when they're dying.
 	 *
@@ -2639,12 +2639,15 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	/* Protect against double add, see task_tick_numa and task_numa_work */
 	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
 	RCU_INIT_POINTER(p->numa_group, NULL);
 	p->last_task_numa_placement	= 0;
 	p->last_sum_exec_runtime	= 0;
 
+	init_task_work(&p->numa_work, task_numa_work);
+
 	/* New address space, reset the preferred nid */
 	if (!(clone_flags & CLONE_VM)) {
 		p->numa_preferred_nid = NUMA_NO_NODE;
@@ -2693,10 +2696,8 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 			curr->numa_scan_period = task_scan_start(curr);
 		curr->node_stamp += period;
 
-		if (!time_before(jiffies, curr->mm->numa_next_scan)) {
-			init_task_work(work, task_numa_work); /* TODO: move this into sched_fork() */
+		if (!time_before(jiffies, curr->mm->numa_next_scan))
 			task_work_add(curr, work, true);
-		}
 	}
 }
 
