Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C959C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F207E2196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Wxm7fGN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404410AbfISRiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:38:52 -0400
Received: from mail.efficios.com ([167.114.142.138]:33808 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404041AbfISRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:38:35 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A99453318DC;
        Thu, 19 Sep 2019 13:38:34 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id vxAVBfIg62Gm; Thu, 19 Sep 2019 13:38:34 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 427EA3318D5;
        Thu, 19 Sep 2019 13:38:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 427EA3318D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568914714;
        bh=72Das0OPV9KlLsKcm7XxjdznJXHbh2C41hlTCYLQ4U4=;
        h=From:To:Date:Message-Id;
        b=Wxm7fGN+28QkUTtldNV/lmnXeYsbE8HTm8B6Piv1RUSB8UggV1DY6Yct1bWdLz+4e
         Aa+R73vxJnIF7arhF9FDq3BrU9ED9RZbKnyIavLEQbv/fokndUHP6D4KSPZG7MocnZ
         6h/Fiu5zgS6WBymuroM9SYjEmL/iAwP4His9VE81Y5C3AXaZOgGuCC1Fx3LvvJRqP9
         PhajqSp7uq69BGBDdHoSU30w5w1DIV9YU2/8bD2hZBjzjDNsp5Me0NcfDSN0/AO9Rg
         54GvSBgc3qtwcRHnRbVG7JhjUzL1105sKpvrA/G14m93H6lFJyN+gdtqAIVNC0Gznj
         USgchkPWWaZww==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id AgMXqXRzIKNY; Thu, 19 Sep 2019 13:38:34 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 0FDD2331896;
        Thu, 19 Sep 2019 13:38:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 5.4 7/7] sched/membarrier: Return -ENOMEM to userspace on memory allocation failure
Date:   Thu, 19 Sep 2019 13:37:05 -0400
Message-Id: <20190919173705.2181-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the IPI fallback code from membarrier to deal with very
infrequent cpumask memory allocation failure. Use GFP_KERNEL rather
than GFP_NOWAIT, and relax the blocking guarantees for the expedited
membarrier system call commands, allowing it to block if waiting for
memory to be made available.

In addition, now -ENOMEM can be returned to user-space if the cpumask
memory allocation fails.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/membarrier.c | 61 ++++++++++++---------------------------
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 8afbdf92be0a..1420c656e8f0 100644
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
@@ -194,20 +175,16 @@ static int membarrier_private_expedited(int flags)
 		if (cpu == raw_smp_processor_id())
 			continue;
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
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
-- 
2.17.1

