Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC8CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A8C2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfJaKJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:09:02 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:57303 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727466AbfJaKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:09:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TgmBgWg_1572516531;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TgmBgWg_1572516531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:51 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Rik van Riel <riel@surriel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jann Horn <jannh@google.com>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>, rcu@vger.kernel.org
Subject: [PATCH 11/11] x86,rcu: use percpu rcu_preempt_depth
Date:   Thu, 31 Oct 2019 10:08:06 +0000
Message-Id: <20191031100806.1326-12-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert x86 to use a per-cpu rcu_preempt_depth. The reason for doing so
is that accessing per-cpu variables is a lot cheaper than accessing
task_struct variables.

We need to save/restore the actual rcu_preempt_depth when switch.
We also place the per-cpu rcu_preempt_depth close to __preempt_count
and current_task variable.

Using the idea of per-cpu __preempt_count.

No function call when using rcu_read_[un]lock().
Single instruction for rcu_read_lock().
2 instructions for fast path of rcu_read_unlock().

CC: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/Kconfig                         |  2 +
 arch/x86/include/asm/rcu_preempt_depth.h | 87 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c             |  7 ++
 arch/x86/kernel/process_32.c             |  2 +
 arch/x86/kernel/process_64.c             |  2 +
 include/linux/rcupdate.h                 | 24 +++++++
 init/init_task.c                         |  2 +-
 kernel/fork.c                            |  2 +-
 kernel/rcu/Kconfig                       |  3 +
 kernel/rcu/tree_exp.h                    |  2 +
 kernel/rcu/tree_plugin.h                 | 39 ++++++++---
 11 files changed, 160 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/rcu_preempt_depth.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa28c58..af9fedc0fdc4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -18,6 +18,7 @@ config X86_32
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
 	select GENERIC_VDSO_32
+	select ARCH_HAVE_RCU_PREEMPT_DEEPTH
 
 config X86_64
 	def_bool y
@@ -31,6 +32,7 @@ config X86_64
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_HAVE_RCU_PREEMPT_DEEPTH
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/arch/x86/include/asm/rcu_preempt_depth.h b/arch/x86/include/asm/rcu_preempt_depth.h
new file mode 100644
index 000000000000..88010ad59c20
--- /dev/null
+++ b/arch/x86/include/asm/rcu_preempt_depth.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RCU_PREEMPT_DEPTH_H
+#define __ASM_RCU_PREEMPT_DEPTH_H
+
+#include <asm/rmwcc.h>
+#include <asm/percpu.h>
+
+#ifdef CONFIG_PREEMPT_RCU
+DECLARE_PER_CPU(int, __rcu_preempt_depth);
+
+/*
+ * We use the RCU_NEED_SPECIAL bit as an inverted need_special
+ * such that a decrement hitting 0 means we can and should do
+ * rcu_read_unlock_special().
+ */
+#define RCU_NEED_SPECIAL	0x80000000
+
+#define INIT_RCU_PREEMPT_DEPTH	(RCU_NEED_SPECIAL)
+
+/* We mask the RCU_NEED_SPECIAL bit so that it return real depth */
+static __always_inline int rcu_preempt_depth(void)
+{
+	return raw_cpu_read_4(__rcu_preempt_depth) & ~RCU_NEED_SPECIAL;
+}
+
+static __always_inline void rcu_preempt_depth_set(int pc)
+{
+	int old, new;
+
+	do {
+		old = raw_cpu_read_4(__rcu_preempt_depth);
+		new = (old & RCU_NEED_SPECIAL) |
+			(pc & ~RCU_NEED_SPECIAL);
+	} while (raw_cpu_cmpxchg_4(__rcu_preempt_depth, old, new) != old);
+}
+
+/*
+ * We fold the RCU_NEED_SPECIAL bit into the rcu_preempt_depth such that
+ * rcu_read_unlock() can decrement and test for needing to do special
+ * with a single instruction.
+ *
+ * We invert the actual bit, so that when the decrement hits 0 we know
+ * both it just exited the outmost rcu_read_lock() critical section and
+ * we need to do specail (the bit is cleared) if it doesn't need to be
+ * deferred.
+ */
+
+static inline void set_rcu_preempt_need_special(void)
+{
+	raw_cpu_and_4(__rcu_preempt_depth, ~RCU_NEED_SPECIAL);
+}
+
+/*
+ * irq needs to be disabled for clearing any bits of ->rcu_read_unlock_special
+ * and calling this function. Otherwise it may clear the work done
+ * by set_rcu_preempt_need_special() in interrupt.
+ */
+static inline void clear_rcu_preempt_need_special(void)
+{
+	raw_cpu_or_4(__rcu_preempt_depth, RCU_NEED_SPECIAL);
+}
+
+static __always_inline void rcu_preempt_depth_inc(void)
+{
+	raw_cpu_add_4(__rcu_preempt_depth, 1);
+}
+
+static __always_inline bool rcu_preempt_depth_dec_and_test(void)
+{
+	return GEN_UNARY_RMWcc("decl", __rcu_preempt_depth, e, __percpu_arg([var]));
+}
+
+/* must be macros to avoid header recursion hell */
+#define save_restore_rcu_preempt_depth(prev_p, next_p) do {				\
+		prev_p->rcu_read_lock_nesting = this_cpu_read(__rcu_preempt_depth);	\
+		this_cpu_write(__rcu_preempt_depth, next_p->rcu_read_lock_nesting);	\
+	} while (0)
+
+#define DEFINE_PERCPU_RCU_PREEMP_DEPTH						\
+	DEFINE_PER_CPU(int, __rcu_preempt_depth) = INIT_RCU_PREEMPT_DEPTH;	\
+	EXPORT_PER_CPU_SYMBOL(__rcu_preempt_depth)
+#else /* #ifdef CONFIG_PREEMPT_RCU */
+#define save_restore_rcu_preempt_depth(prev_p, next_p) do {} while (0)
+#define DEFINE_PERCPU_RCU_PREEMP_DEPTH	/* empty */
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
+
+#endif /* __ASM_RCU_PREEMPT_DEPTH_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9ae7d1bcd4f4..0151737e196c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -46,6 +46,7 @@
 #include <asm/asm.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/rcu_preempt_depth.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/pat.h>
@@ -1633,6 +1634,9 @@ DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+/* close to __preempt_count */
+DEFINE_PERCPU_RCU_PREEMP_DEPTH;
+
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
@@ -1690,6 +1694,9 @@ EXPORT_PER_CPU_SYMBOL(current_task);
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+/* close to __preempt_count */
+DEFINE_PERCPU_RCU_PREEMP_DEPTH;
+
 /*
  * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
  * the top of the kernel stack.  Use an extra percpu variable to track the
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index b8ceec4974fe..ab1f20353663 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -51,6 +51,7 @@
 #include <asm/cpu.h>
 #include <asm/syscalls.h>
 #include <asm/debugreg.h>
+#include <asm/rcu_preempt_depth.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
 #include <asm/resctrl_sched.h>
@@ -290,6 +291,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		lazy_load_gs(next->gs);
 
+	save_restore_rcu_preempt_depth(prev_p, next_p);
 	this_cpu_write(current_task, next_p);
 
 	switch_fpu_finish(next_fpu);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index af64519b2695..2e1c6e829d30 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -50,6 +50,7 @@
 #include <asm/ia32.h>
 #include <asm/syscalls.h>
 #include <asm/debugreg.h>
+#include <asm/rcu_preempt_depth.h>
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
@@ -559,6 +560,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	x86_fsgsbase_load(prev, next);
 
+	save_restore_rcu_preempt_depth(prev_p, next_p);
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index a35daab95d14..0d2abf08b694 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -41,6 +41,29 @@ void synchronize_rcu(void);
 
 #ifdef CONFIG_PREEMPT_RCU
 
+#ifdef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH
+#include <asm/rcu_preempt_depth.h>
+
+#ifndef CONFIG_PROVE_LOCKING
+extern void rcu_read_unlock_special(void);
+
+static inline void __rcu_read_lock(void)
+{
+	rcu_preempt_depth_inc();
+}
+
+static inline void __rcu_read_unlock(void)
+{
+	if (unlikely(rcu_preempt_depth_dec_and_test()))
+		rcu_read_unlock_special();
+}
+#else
+void __rcu_read_lock(void);
+void __rcu_read_unlock(void);
+#endif
+
+#else /* #ifdef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH */
+#define INIT_RCU_PREEMPT_DEPTH (0)
 void __rcu_read_lock(void);
 void __rcu_read_unlock(void);
 
@@ -51,6 +74,7 @@ void __rcu_read_unlock(void);
  * types of kernel builds, the rcu_read_lock() nesting depth is unknowable.
  */
 #define rcu_preempt_depth() (current->rcu_read_lock_nesting)
+#endif /* #else #ifdef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH */
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
diff --git a/init/init_task.c b/init/init_task.c
index 9e5cbe5eab7b..0a91e38fba37 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -130,7 +130,7 @@ struct task_struct init_task
 	.perf_event_list = LIST_HEAD_INIT(init_task.perf_event_list),
 #endif
 #ifdef CONFIG_PREEMPT_RCU
-	.rcu_read_lock_nesting = 0,
+	.rcu_read_lock_nesting = INIT_RCU_PREEMPT_DEPTH,
 	.rcu_read_unlock_special.s = 0,
 	.rcu_node_entry = LIST_HEAD_INIT(init_task.rcu_node_entry),
 	.rcu_blocked_node = NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index f9572f416126..7368d4ccb857 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1665,7 +1665,7 @@ init_task_pid(struct task_struct *task, enum pid_type type, struct pid *pid)
 static inline void rcu_copy_process(struct task_struct *p)
 {
 #ifdef CONFIG_PREEMPT_RCU
-	p->rcu_read_lock_nesting = 0;
+	p->rcu_read_lock_nesting = INIT_RCU_PREEMPT_DEPTH;
 	p->rcu_read_unlock_special.s = 0;
 	p->rcu_blocked_node = NULL;
 	INIT_LIST_HEAD(&p->rcu_node_entry);
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 1cc940fef17c..d2ecca49a1a4 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -14,6 +14,9 @@ config TREE_RCU
 	  thousands of CPUs.  It also scales down nicely to
 	  smaller systems.
 
+config ARCH_HAVE_RCU_PREEMPT_DEEPTH
+	def_bool n
+
 config PREEMPT_RCU
 	bool
 	default y if PREEMPTION
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index dc1af2073e25..b8922cb19884 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -588,6 +588,7 @@ static void wait_rcu_exp_gp(struct work_struct *wp)
 }
 
 #ifdef CONFIG_PREEMPT_RCU
+static inline void set_rcu_preempt_need_special(void);
 
 /*
  * Remote handler for smp_call_function_single().  If there is an
@@ -644,6 +645,7 @@ static void rcu_exp_handler(void *unused)
 	if (rcu_preempt_depth() > 0) {
 		rdp->exp_deferred_qs = true;
 		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
+		set_rcu_preempt_need_special();
 		return;
 	}
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 21bb04fec0d2..4d958d4b179c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -82,7 +82,7 @@ static void __init rcu_bootup_announce_oddness(void)
 #ifdef CONFIG_PREEMPT_RCU
 
 static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
-static void rcu_read_unlock_special(struct task_struct *t);
+void rcu_read_unlock_special(void);
 
 /*
  * Tell them what RCU they are running.
@@ -298,6 +298,7 @@ void rcu_note_context_switch(bool preempt)
 		t->rcu_read_unlock_special.b.need_qs = false;
 		t->rcu_read_unlock_special.b.blocked = true;
 		t->rcu_blocked_node = rnp;
+		set_rcu_preempt_need_special();
 
 		/*
 		 * Verify the CPU's sanity, trace the preemption, and
@@ -345,6 +346,7 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 /* Bias and limit values for ->rcu_read_lock_nesting. */
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
+#ifndef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH
 static inline void rcu_preempt_depth_inc(void)
 {
 	current->rcu_read_lock_nesting++;
@@ -352,7 +354,12 @@ static inline void rcu_preempt_depth_inc(void)
 
 static inline bool rcu_preempt_depth_dec_and_test(void)
 {
-	return --current->rcu_read_lock_nesting == 0;
+	if (--current->rcu_read_lock_nesting == 0) {
+		/* check speical after dec ->rcu_read_lock_nesting */
+		barrier();
+		return READ_ONCE(current->rcu_read_unlock_special.s);
+	}
+	return 0;
 }
 
 static inline void rcu_preempt_depth_set(int val)
@@ -360,6 +367,12 @@ static inline void rcu_preempt_depth_set(int val)
 	current->rcu_read_lock_nesting = val;
 }
 
+static inline void clear_rcu_preempt_need_special(void) {}
+static inline void set_rcu_preempt_need_special(void) {}
+
+#endif /* #ifndef CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH */
+
+#if !defined(CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH) || defined (CONFIG_PROVE_LOCKING)
 /*
  * Preemptible RCU implementation for rcu_read_lock().
  * Just increment ->rcu_read_lock_nesting, shared state will be updated
@@ -383,18 +396,16 @@ EXPORT_SYMBOL_GPL(__rcu_read_lock);
  */
 void __rcu_read_unlock(void)
 {
-	struct task_struct *t = current;
-
 	if (rcu_preempt_depth_dec_and_test()) {
-		barrier();  /* critical section before exit code. */
-		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
-			rcu_read_unlock_special(t);
+		rcu_read_unlock_special();
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		WARN_ON_ONCE(rcu_preempt_depth() < 0);
+		WARN_ON_ONCE(rcu_preempt_depth() < 0 ||
+			     rcu_preempt_depth() > RCU_NEST_PMAX);
 	}
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
+#endif /* #if !defined(CONFIG_ARCH_HAVE_RCU_PREEMPT_DEEPTH) || defined (CONFIG_PROVE_LOCKING) */
 
 /*
  * Advance a ->blkd_tasks-list pointer to the next entry, instead
@@ -445,6 +456,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 */
 	special = t->rcu_read_unlock_special;
 	t->rcu_read_unlock_special.s = 0;
+	clear_rcu_preempt_need_special();
 	if (special.b.need_qs) {
 		rcu_qs();
 	}
@@ -577,8 +589,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+void rcu_read_unlock_special(void)
 {
+	struct task_struct *t = current;
 	unsigned long flags;
 	bool preempt_bh_were_disabled =
 			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
@@ -610,6 +623,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		// call rcu_read_unlock_special() and then wake_up()
 		// recursively and deadlock if deferred_qs is still false.
 		// To avoid it, deferred_qs has to be set beforehand.
+		// rcu_preempt_need_special is already set, so it doesn't
+		// need to call set_rcu_preempt_need_special()
 		t->rcu_read_unlock_special.b.deferred_qs = true;
 		if (irqs_were_disabled && use_softirq &&
 		    (in_interrupt() || (exp && !deferred_qs))) {
@@ -636,6 +651,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	}
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
+EXPORT_SYMBOL_GPL(rcu_read_unlock_special);
 
 /*
  * Check that the list of blocked tasks for the newly completed grace
@@ -699,8 +715,10 @@ static void rcu_flavor_sched_clock_irq(int user)
 	    __this_cpu_read(rcu_data.core_needs_qs) &&
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
 	    !t->rcu_read_unlock_special.b.need_qs &&
-	    time_after(jiffies, rcu_state.gp_start + HZ))
+	    time_after(jiffies, rcu_state.gp_start + HZ)) {
 		t->rcu_read_unlock_special.b.need_qs = true;
+		set_rcu_preempt_need_special();
+	}
 }
 
 /*
@@ -719,6 +737,7 @@ void exit_rcu(void)
 		rcu_preempt_depth_set(1);
 		barrier();
 		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
+		set_rcu_preempt_need_special();
 	} else if (unlikely(rcu_preempt_depth())) {
 		rcu_preempt_depth_set(1);
 	} else {
-- 
2.20.1

