Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34231C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0835821924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573229367;
	bh=XKjdzw+j67qL4ncbzmGVP5lHPvtz8u+vLbAMgxbriDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W0GmTNC3yVYncQbifrAy5d4+peBW8wMoDCScA7g0VzaNLYOyM1JKadMLyGoc1iXSe
	 oviwTECkRgWs6NjEF3UQGxxcSA0/pbXjqzKFbEN9nKzcm9yqpBirhT5DoQaA1d/Qy6
	 c5irSiF4jGnCm3FTOQW9IXS3lNwnIcVmFSzhcmz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfKHQJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfKHQJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:09:24 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D692178F;
        Fri,  8 Nov 2019 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573229364;
        bh=XKjdzw+j67qL4ncbzmGVP5lHPvtz8u+vLbAMgxbriDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2uwNpQ9KS4P271PBIVNnE5bEPkdUnvGL227j62c0ygog8a2wT3JyhsJOatlwuKAu
         S+5YezKL6xzN3y6ra0NcK4mpR4bPA7sqekzOCluKcxL+4+5dkakF9o9VJL+zA/Z03J
         8lFx8dkjmBbH5scoqjD8SaFvm4c+wZc4vt3yv/dg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] irq_work: Convert flags to atomic_t
Date:   Fri,  8 Nov 2019 17:08:55 +0100
Message-Id: <20191108160858.31665-2-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108160858.31665-1-frederic@kernel.org>
References: <20191108160858.31665-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to convert flags to atomic_t in order to later fix an ordering
issue on cmpxchg() failure. This will allow us to use atomic_fetch_or().
Also that clarify the nature of those flags.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/irq_work.h | 10 +++++++---
 kernel/irq_work.c        | 18 +++++++++---------
 kernel/printk/printk.c   |  2 +-
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index b11fcdfd0770..02da997ad12c 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -22,7 +22,7 @@
 #define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
 
 struct irq_work {
-	unsigned long flags;
+	atomic_t flags;
 	struct llist_node llnode;
 	void (*func)(struct irq_work *);
 };
@@ -30,11 +30,15 @@ struct irq_work {
 static inline
 void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 {
-	work->flags = 0;
+	atomic_set(&work->flags, 0);
 	work->func = func;
 }
 
-#define DEFINE_IRQ_WORK(name, _f) struct irq_work name = { .func = (_f), }
+#define DEFINE_IRQ_WORK(name, _f) struct irq_work name = {	\
+		.flags = ATOMIC_INIT(0),			\
+		.func  = (_f)					\
+}
+
 
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index d42acaf81886..df0dbf4d859b 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -29,16 +29,16 @@ static DEFINE_PER_CPU(struct llist_head, lazy_list);
  */
 static bool irq_work_claim(struct irq_work *work)
 {
-	unsigned long flags, oflags, nflags;
+	int flags, oflags, nflags;
 
 	/*
 	 * Start with our best wish as a premise but only trust any
 	 * flag value after cmpxchg() result.
 	 */
-	flags = work->flags & ~IRQ_WORK_PENDING;
+	flags = atomic_read(&work->flags) & ~IRQ_WORK_PENDING;
 	for (;;) {
 		nflags = flags | IRQ_WORK_CLAIMED;
-		oflags = cmpxchg(&work->flags, flags, nflags);
+		oflags = atomic_cmpxchg(&work->flags, flags, nflags);
 		if (oflags == flags)
 			break;
 		if (oflags & IRQ_WORK_PENDING)
@@ -61,7 +61,7 @@ void __weak arch_irq_work_raise(void)
 static void __irq_work_queue_local(struct irq_work *work)
 {
 	/* If the work is "lazy", handle it from next tick if any */
-	if (work->flags & IRQ_WORK_LAZY) {
+	if (atomic_read(&work->flags) & IRQ_WORK_LAZY) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
 		    tick_nohz_tick_stopped())
 			arch_irq_work_raise();
@@ -143,7 +143,7 @@ static void irq_work_run_list(struct llist_head *list)
 {
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
-	unsigned long flags;
+	int flags;
 
 	BUG_ON(!irqs_disabled());
 
@@ -159,15 +159,15 @@ static void irq_work_run_list(struct llist_head *list)
 		 * to claim that work don't rely on us to handle their data
 		 * while we are in the middle of the func.
 		 */
-		flags = work->flags & ~IRQ_WORK_PENDING;
-		xchg(&work->flags, flags);
+		flags = atomic_read(&work->flags) & ~IRQ_WORK_PENDING;
+		atomic_xchg(&work->flags, flags);
 
 		work->func(work);
 		/*
 		 * Clear the BUSY bit and return to the free state if
 		 * no-one else claimed it meanwhile.
 		 */
-		(void)cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
 	}
 }
 
@@ -199,7 +199,7 @@ void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
 
-	while (work->flags & IRQ_WORK_BUSY)
+	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ca65327a6de8..865727373a3b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2961,7 +2961,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
 	.func = wake_up_klogd_work_func,
-	.flags = IRQ_WORK_LAZY,
+	.flags = ATOMIC_INIT(IRQ_WORK_LAZY),
 };
 
 void wake_up_klogd(void)
-- 
2.23.0

