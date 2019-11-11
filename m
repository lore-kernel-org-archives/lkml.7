Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F45C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE9B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKKJcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:32:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55745 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:32:40 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63l-00037C-QZ; Mon, 11 Nov 2019 10:32:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5C1AF1C0093;
        Mon, 11 Nov 2019 10:32:33 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:33 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irq_work: Convert flags to atomic_t
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108160858.31665-2-frederic@kernel.org>
References: <20191108160858.31665-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157346475306.29376.7227479004275194338.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     153bedbac2ebd475e1c7c2d2fa0c042f5525927d
Gitweb:        https://git.kernel.org/tip/153bedbac2ebd475e1c7c2d2fa0c042f5525927d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 17:08:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 09:02:56 +01:00

irq_work: Convert flags to atomic_t

We need to convert flags to atomic_t in order to later fix an ordering
issue on atomic_cmpxchg() failure. This will allow us to use atomic_fetch_or().

Also clarify the nature of those flags.

[ mingo: Converted two more usage site the original patch missed. ]

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191108160858.31665-2-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/irq_work.h | 10 +++++++---
 kernel/bpf/stackmap.c    |  2 +-
 kernel/irq_work.c        | 18 +++++++++---------
 kernel/printk/printk.c   |  2 +-
 kernel/trace/bpf_trace.c |  2 +-
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index b11fcdf..02da997 100644
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
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 052580c..4d31284 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -289,7 +289,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 
 	if (in_nmi()) {
 		work = this_cpu_ptr(&up_read_work);
-		if (work->irq_work.flags & IRQ_WORK_BUSY)
+		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
 			/* cannot queue more up_read, fallback */
 			irq_work_busy = true;
 	}
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index d42acaf..df0dbf4 100644
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
index ca65327..8657273 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2961,7 +2961,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
 	.func = wake_up_klogd_work_func,
-	.flags = IRQ_WORK_LAZY,
+	.flags = ATOMIC_INIT(IRQ_WORK_LAZY),
 };
 
 void wake_up_klogd(void)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 44bd08f..ff467a4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -660,7 +660,7 @@ BPF_CALL_1(bpf_send_signal, u32, sig)
 			return -EINVAL;
 
 		work = this_cpu_ptr(&send_signal_work);
-		if (work->irq_work.flags & IRQ_WORK_BUSY)
+		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
 			return -EBUSY;
 
 		/* Add the current task, which is the target of sending signal,
