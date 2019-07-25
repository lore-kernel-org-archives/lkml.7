Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A1C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7996922BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WEPiFnil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390027AbfGYQLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:11:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56309 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGYQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:11:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGBdp21074267
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:11:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGBdp21074267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071100;
        bh=Gz8NyVwCngpH3GX0/Bk9YUVy8PF8UqRnBIZ7opmcG3o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WEPiFnilRmR+TS/oe40rMJH7NcX+41EehT28uz1el0Xt8Xi4nUZ/TzplHk+RE524G
         b9tLBAAKlYMlbAAHRI66cakUKTqOjHkuVssTggn9mmwXxNxbA7UK8cgHEQ1IaNbVjE
         ezpvghPJH3d3vDL00FxMV/b+ww8ApsHsw2PFbcZgSjAIWHu/l3QngRGjA6EXLNod6+
         VYyR7l+2MWDFrKRpcy1Fsv5q8EMwYyH1eValmoc5mafHVJeQITL+n+rnIDC7Oygqof
         IktajUeOdRdfjxaeobyt5FWcLb9pyCRbNFYNlR+vRjqU6YzRyfSMEsK6xyYll2hYSb
         KKfpzXTzECXGw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGBdwO1074264;
        Thu, 25 Jul 2019 09:11:39 -0700
Date:   Thu, 25 Jul 2019 09:11:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-d35927a144641700c8328d707d1c89d305b4ecb8@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, valentin.schneider@arm.com
Reply-To: mingo@kernel.org, peterz@infradead.org,
          valentin.schneider@arm.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190715102508.32434-2-valentin.schneider@arm.com>
References: <20190715102508.32434-2-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Move init_numa_balancing() below
 task_numa_work()
Git-Commit-ID: d35927a144641700c8328d707d1c89d305b4ecb8
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

Commit-ID:  d35927a144641700c8328d707d1c89d305b4ecb8
Gitweb:     https://git.kernel.org/tip/d35927a144641700c8328d707d1c89d305b4ecb8
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 15 Jul 2019 11:25:06 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:51 +0200

sched/fair: Move init_numa_balancing() below task_numa_work()

To reference task_numa_work() from within init_numa_balancing(), we
need the former to be declared before the latter. Do just that.

This is a pure code movement.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: mgorman@suse.de
Cc: riel@surriel.com
Link: https://lkml.kernel.org/r/20190715102508.32434-2-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 82 ++++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd..f0c488015649 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1188,47 +1188,6 @@ static unsigned int task_scan_max(struct task_struct *p)
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
-	RCU_INIT_POINTER(p->numa_group, NULL);
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
@@ -2665,6 +2624,47 @@ out:
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
+	RCU_INIT_POINTER(p->numa_group, NULL);
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
