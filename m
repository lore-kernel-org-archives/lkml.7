Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E56C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684922146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfI0ILV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45317 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0ILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKs-0005ae-VE; Fri, 27 Sep 2019 10:10:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 798FD1C0740;
        Fri, 27 Sep 2019 10:10:42 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:42 -0000
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/membarrier: Return -ENOMEM to userspace on
 memory allocation failure
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <tkhai@yandex.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190919173705.2181-8-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-8-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <156957184244.9866.6327974056677601202.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c172e0a3e8e65a4c6fffec5bc4d6de08d6f894f7
Gitweb:        https://git.kernel.org/tip/c172e0a3e8e65a4c6fffec5bc4d6de08d6f894f7
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Thu, 19 Sep 2019 13:37:05 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:31 +02:00

sched/membarrier: Return -ENOMEM to userspace on memory allocation failure

Remove the IPI fallback code from membarrier to deal with very
infrequent cpumask memory allocation failure. Use GFP_KERNEL rather
than GFP_NOWAIT, and relax the blocking guarantees for the expedited
membarrier system call commands, allowing it to block if waiting for
memory to be made available.

In addition, now -ENOMEM can be returned to user-space if the cpumask
memory allocation fails.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190919173705.2181-8-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/membarrier.c | 63 ++++++++++++--------------------------
 1 file changed, 20 insertions(+), 43 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index fced54a..a39bed2 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -66,7 +66,6 @@ void membarrier_exec_mmap(struct mm_struct *mm)
 static int membarrier_global_expedited(void)
 {
 	int cpu;
-	bool fallback = false;
 	cpumask_var_t tmpmask;
 
 	if (num_online_cpus() == 1)
@@ -78,15 +77,8 @@ static int membarrier_global_expedited(void)
 	 */
 	smp_mb();	/* system call entry is not a mb. */
 
-	/*
-	 * Expedited membarrier commands guarantee that they won't
-	 * block, hence the GFP_NOWAIT allocation flag and fallback
-	 * implementation.
-	 */
-	if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
-		/* Fallback for OOM. */
-		fallback = true;
-	}
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
 
 	cpus_read_lock();
 	rcu_read_lock();
@@ -117,18 +109,15 @@ static int membarrier_global_expedited(void)
 		if (p->flags & PF_KTHREAD)
 			continue;
 
-		if (!fallback)
-			__cpumask_set_cpu(cpu, tmpmask);
-		else
-			smp_call_function_single(cpu, ipi_mb, NULL, 1);
+		__cpumask_set_cpu(cpu, tmpmask);
 	}
 	rcu_read_unlock();
-	if (!fallback) {
-		preempt_disable();
-		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
-		preempt_enable();
-		free_cpumask_var(tmpmask);
-	}
+
+	preempt_disable();
+	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
+	preempt_enable();
+
+	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
 
 	/*
@@ -143,7 +132,6 @@ static int membarrier_global_expedited(void)
 static int membarrier_private_expedited(int flags)
 {
 	int cpu;
-	bool fallback = false;
 	cpumask_var_t tmpmask;
 	struct mm_struct *mm = current->mm;
 
@@ -168,15 +156,8 @@ static int membarrier_private_expedited(int flags)
 	 */
 	smp_mb();	/* system call entry is not a mb. */
 
-	/*
-	 * Expedited membarrier commands guarantee that they won't
-	 * block, hence the GFP_NOWAIT allocation flag and fallback
-	 * implementation.
-	 */
-	if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
-		/* Fallback for OOM. */
-		fallback = true;
-	}
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
 
 	cpus_read_lock();
 	rcu_read_lock();
@@ -195,20 +176,16 @@ static int membarrier_private_expedited(int flags)
 			continue;
 		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p && p->mm == mm) {
-			if (!fallback)
-				__cpumask_set_cpu(cpu, tmpmask);
-			else
-				smp_call_function_single(cpu, ipi_mb, NULL, 1);
-		}
+		if (p && p->mm == mm)
+			__cpumask_set_cpu(cpu, tmpmask);
 	}
 	rcu_read_unlock();
-	if (!fallback) {
-		preempt_disable();
-		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
-		preempt_enable();
-		free_cpumask_var(tmpmask);
-	}
+
+	preempt_disable();
+	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
+	preempt_enable();
+
+	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
 
 	/*
@@ -264,7 +241,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 		struct rq *rq = cpu_rq(cpu);
 		struct task_struct *p;
 
-		p = rcu_dereference(&rq->curr);
+		p = rcu_dereference(rq->curr);
 		if (p && p->mm == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
 	}
