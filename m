Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADA8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAA12064A
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbfHAUwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:52:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37893 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388889AbfHAUv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:51:57 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htI3G-0001g7-R9; Thu, 01 Aug 2019 22:51:54 +0200
Date:   Thu, 1 Aug 2019 22:51:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sched/fair: Cleanup task->numa_work initialization
Message-ID: <alpine.DEB.2.21.1908012246530.1789@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Resolve the ancient TODO by setting the numa_work function in
  init_numa_balancing() which is called on fork().

- Make task_numa_work() static as it's not used outside of the fair
  scheduler and lacks a prototype as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd..f47869c0cdad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1103,6 +1103,7 @@ static struct numa_group *deref_curr_numa_group(struct task_struct *p)
 
 static inline unsigned long group_faults_priv(struct numa_group *ng);
 static inline unsigned long group_faults_shared(struct numa_group *ng);
+static void task_numa_work(struct callback_head *work);
 
 static unsigned int task_nr_scan_windows(struct task_struct *p)
 {
@@ -1203,6 +1204,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	p->numa_work.func		= task_numa_work;
 	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
 	RCU_INIT_POINTER(p->numa_group, NULL);
@@ -2523,7 +2525,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
  */
-void task_numa_work(struct callback_head *work)
+static void task_numa_work(struct callback_head *work)
 {
 	unsigned long migrate, next_scan, now = jiffies;
 	struct task_struct *p = current;
@@ -2693,10 +2695,8 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 			curr->numa_scan_period = task_scan_start(curr);
 		curr->node_stamp += period;
 
-		if (!time_before(jiffies, curr->mm->numa_next_scan)) {
-			init_task_work(work, task_numa_work); /* TODO: move this into sched_fork() */
+		if (!time_before(jiffies, curr->mm->numa_next_scan))
 			task_work_add(curr, work, true);
-		}
 	}
 }
 
