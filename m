Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F055C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24703204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfHNKlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:41:47 -0400
Received: from foss.arm.com ([217.140.110.172]:51858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfHNKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:41:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5A811570;
        Wed, 14 Aug 2019 03:41:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E41503F706;
        Wed, 14 Aug 2019 03:41:41 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        riel@surriel.com, will@kernel.org
Subject: [PATCH 2/9] sched: treewide: use is_kthread()
Date:   Wed, 14 Aug 2019 11:41:24 +0100
Message-Id: <20190814104131.20190-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814104131.20190-1-mark.rutland@arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have is_kthread(), let's convert existing open-coded checks
of the form:

  task->flags & PF_KTHREAD

... over to the new helper, which makes things a little easier to read,
and sets a consistent example for new code to follow.

Generated with coccinelle:

  ----
  virtual patch

  @ depends on patch @
  expression E;
  @@

  - (E->flags & PF_KTHREAD)
  + is_kthread(E)
  ----

... though this didn't pick up the instance in <linux/cgroup.h>, which I
fixed up manually.

Instances checking multiple PF_* flags at ocne are left as-is for now.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/alpha/kernel/process.c      | 2 +-
 arch/arc/kernel/process.c        | 2 +-
 arch/arm/kernel/process.c        | 2 +-
 arch/arm/mm/init.c               | 2 +-
 arch/arm64/kernel/process.c      | 4 ++--
 arch/c6x/kernel/process.c        | 2 +-
 arch/csky/kernel/process.c       | 2 +-
 arch/h8300/kernel/process.c      | 2 +-
 arch/hexagon/kernel/process.c    | 2 +-
 arch/ia64/kernel/process.c       | 2 +-
 arch/m68k/kernel/process.c       | 2 +-
 arch/microblaze/kernel/process.c | 2 +-
 arch/mips/kernel/process.c       | 4 ++--
 arch/nds32/kernel/process.c      | 4 ++--
 arch/nios2/kernel/process.c      | 2 +-
 arch/openrisc/kernel/process.c   | 2 +-
 arch/parisc/kernel/process.c     | 2 +-
 arch/powerpc/kernel/process.c    | 2 +-
 arch/riscv/kernel/process.c      | 2 +-
 arch/s390/kernel/process.c       | 2 +-
 arch/sh/kernel/process_32.c      | 2 +-
 arch/sh/kernel/process_64.c      | 2 +-
 arch/sparc/kernel/process_32.c   | 2 +-
 arch/sparc/kernel/process_64.c   | 2 +-
 arch/um/kernel/process.c         | 2 +-
 arch/unicore32/kernel/process.c  | 2 +-
 arch/x86/kernel/fpu/core.c       | 2 +-
 arch/x86/kernel/process_32.c     | 2 +-
 arch/x86/kernel/process_64.c     | 2 +-
 arch/xtensa/kernel/process.c     | 2 +-
 block/blk-cgroup.c               | 2 +-
 drivers/tty/sysrq.c              | 2 +-
 fs/coredump.c                    | 2 +-
 fs/file_table.c                  | 4 ++--
 fs/namespace.c                   | 2 +-
 fs/proc/base.c                   | 4 ++--
 include/linux/cgroup.h           | 2 +-
 kernel/cgroup/freezer.c          | 4 ++--
 kernel/events/core.c             | 2 +-
 kernel/exit.c                    | 2 +-
 kernel/fork.c                    | 6 +++---
 kernel/freezer.c                 | 4 ++--
 kernel/futex.c                   | 2 +-
 kernel/kthread.c                 | 6 +++---
 kernel/livepatch/transition.c    | 2 +-
 kernel/ptrace.c                  | 2 +-
 kernel/sched/core.c              | 8 ++++----
 kernel/sched/idle.c              | 2 +-
 kernel/sched/wait.c              | 2 +-
 kernel/signal.c                  | 2 +-
 kernel/stacktrace.c              | 2 +-
 lib/is_single_threaded.c         | 2 +-
 mm/memcontrol.c                  | 2 +-
 mm/oom_kill.c                    | 4 ++--
 mm/page_alloc.c                  | 2 +-
 mm/vmacache.c                    | 2 +-
 mm/vmscan.c                      | 2 +-
 security/smack/smack_access.c    | 2 +-
 security/smack/smack_lsm.c       | 4 ++--
 security/yama/yama_lsm.c         | 2 +-
 60 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 48b81d015d8a..e99ec5fab586 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -251,7 +251,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index e1889ce3faf9..f4cf6e9311cd 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -200,7 +200,7 @@ int copy_thread(unsigned long clone_flags,
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = kthread_arg;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f934a6739fc0..899ead9b1336 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -242,7 +242,7 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & PF_KTHREAD))) {
+	if (likely(!is_kthread(p))) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 16d373d587c4..0b568802d400 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -625,7 +625,7 @@ static void update_sections_early(struct section_perm perms[], int n)
 	struct task_struct *t, *s;
 
 	for_each_process(t) {
-		if (t->flags & PF_KTHREAD)
+		if (is_kthread(t))
 			continue;
 		for_each_thread(t, s)
 			set_section_perms(perms, n, true, s->mm);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f674f28df663..288012687c29 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -367,7 +367,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	 */
 	fpsimd_flush_task_state(p);
 
-	if (likely(!(p->flags & PF_KTHREAD))) {
+	if (likely(!is_kthread(p))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
@@ -454,7 +454,7 @@ static void ssbs_thread_switch(struct task_struct *next)
 	 * Nothing to do for kernel threads, but 'regs' may be junk
 	 * (e.g. idle task) so check the flags and bail early.
 	 */
-	if (unlikely(next->flags & PF_KTHREAD))
+	if (unlikely(is_kthread(next)))
 		return;
 
 	/* If the mitigation is enabled, then we leave SSBS clear. */
diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
index cb9c8b63cddd..942bc45b7395 100644
--- a/arch/c6x/kernel/process.c
+++ b/arch/c6x/kernel/process.c
@@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = task_pt_regs(p);
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* case of  __kernel_thread: we return to supervisor space */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->sp = (unsigned long)(childregs + 1);
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index e555740c0be5..671b061ee785 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -52,7 +52,7 @@ int copy_thread(unsigned long clone_flags,
 	/* setup ksp for switch_to !!! */
 	p->thread.ksp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r8 = kthread_arg;
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index e35cdf092e07..e9beda6d5760 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -114,7 +114,7 @@ int copy_thread(unsigned long clone_flags,
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
 		childregs->er4 = topstk; /* arg */
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index ac07f5f4b76b..1f9e6787d07d 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -73,7 +73,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 968b5f33e725..3d75db83b333 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -376,7 +376,7 @@ copy_thread(unsigned long clone_flags,
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		if (unlikely(!user_stack_base)) {
 			/* fork_idle() called us */
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 4e77a06735c1..1adacbf17513 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -138,7 +138,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	 */
 	p->thread.fs = get_fs().seg;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 6527ec22f158..e5f5d4c04152 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -60,7 +60,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 339870ed92f7..8a5a2216558e 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -87,7 +87,7 @@ void exit_thread(struct task_struct *tsk)
 	 * User threads may have allocated a delay slot emulation frame.
 	 * If so, clean up that allocation.
 	 */
-	if (!(current->flags & PF_KTHREAD))
+	if (!is_kthread(current))
 		dsemul_thread_cleanup(tsk);
 }
 
@@ -132,7 +132,7 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = read_c0_status() & ~(ST0_CU2|ST0_CU1);
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 9712fd474f2c..5d88ca5d3621 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -156,7 +156,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* kernel thread fn */
 		p->thread.cpu_context.r6 = stack_start;
@@ -207,7 +207,7 @@ struct task_struct *_switch_fpu(struct task_struct *prev, struct task_struct *ne
 #if !IS_ENABLED(CONFIG_LAZY_FPU)
 	unlazy_fpu(prev);
 #endif
-	if (!(next->flags & PF_KTHREAD))
+	if (!is_kthread(next))
 		clear_fpu(task_pt_regs(next));
 	return prev;
 }
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 509e7855e8dc..f13eb8c23fc8 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -109,7 +109,7 @@ int copy_thread(unsigned long clone_flags,
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index b06f84f6676f..cf79967202dd 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -168,7 +168,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(kregs, 0, sizeof(struct pt_regs));
 		kregs->gpr[20] = usp; /* fn, kernel thread */
 		kregs->gpr[22] = arg;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index ecc5c2771208..774ebf61323e 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -220,7 +220,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (!usp) /* idle thread */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8fc4de0d22b4..411c7e8046eb 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1615,7 +1615,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index f23794bd1e90..08b6dfc6dc54 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -96,7 +96,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* Kernel thread */
 		const register unsigned long gp __asm__ ("gp");
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 63873aa6693f..4802a4014f15 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -113,7 +113,7 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long new_stackp,
 	frame->sf.gprs[9] = (unsigned long) frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index a094633874c3..8cd8f2025bf0 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -137,7 +137,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = arg;
diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index c2844a2e18cd..9c9c6b1efc17 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -389,7 +389,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childregs = (struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1;
 	p->thread.sp = (unsigned long) childregs;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->regs[2] = (unsigned long)arg;
 		childregs->regs[3] = (unsigned long)usp;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 26cca65e9246..0c9ec7c8b8ad 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -338,7 +338,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 4282116e28e7..e98db3ba97c1 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -632,7 +632,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 67c0d1a860e9..58d26a08719d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct * p)
 {
 	void (*handler)(void);
-	int kthread = current->flags & PF_KTHREAD;
+	int kthread = is_kthread(current);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
diff --git a/arch/unicore32/kernel/process.c b/arch/unicore32/kernel/process.c
index b4fd3a604a18..a48ee8b317b9 100644
--- a/arch/unicore32/kernel/process.c
+++ b/arch/unicore32/kernel/process.c
@@ -228,7 +228,7 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&thread->cpu_context, 0, sizeof(struct cpu_context_save));
 	thread->cpu_context.sp = (unsigned long)childregs;
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		thread->cpu_context.pc = (unsigned long)ret_from_kernel_thread;
 		thread->cpu_context.r4 = stack_start;
 		thread->cpu_context.r5 = stk_sz;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 12c70840980e..52a7ac55f89a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -91,7 +91,7 @@ void kernel_fpu_begin(void)
 
 	this_cpu_write(in_kernel_fpu, true);
 
-	if (!(current->flags & PF_KTHREAD) &&
+	if (!is_kthread(current) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 		/*
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index b8ceec4974fe..8263c37fac2b 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -134,7 +134,7 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	p->thread.sp0 = (unsigned long) (childregs+1);
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		frame->bx = sp;		/* function */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index af64519b2695..85375eb3cff1 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -397,7 +397,7 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	savesegment(ds, p->thread.ds);
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		frame->bx = sp;		/* function */
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index db278a9e80c7..1dc0c67a55b3 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -217,7 +217,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 
 	p->thread.sp = (unsigned long)childregs;
 
-	if (!(p->flags & PF_KTHREAD)) {
+	if (!is_kthread(p)) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 55a7dc227dfb..44ea9f371e60 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1739,7 +1739,7 @@ void blkcg_maybe_throttle_current(void)
  */
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
 {
-	if (unlikely(current->flags & PF_KTHREAD))
+	if (unlikely(is_kthread(current)))
 		return;
 
 	if (!blk_get_queue(q))
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 573b2055173c..3101dba0281d 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -336,7 +336,7 @@ static void send_sig_all(int sig)
 
 	read_lock(&tasklist_lock);
 	for_each_process(p) {
-		if (p->flags & PF_KTHREAD)
+		if (is_kthread(p))
 			continue;
 		if (is_global_init(p))
 			continue;
diff --git a/fs/coredump.c b/fs/coredump.c
index b1ea7dfbd149..03ecf67d783e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -412,7 +412,7 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 	for_each_process(g) {
 		if (g == tsk->group_leader)
 			continue;
-		if (g->flags & PF_KTHREAD)
+		if (is_kthread(g))
 			continue;
 
 		for_each_thread(g, p) {
diff --git a/fs/file_table.c b/fs/file_table.c
index b07b53f24ff5..ce793b771a18 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -335,7 +335,7 @@ void fput_many(struct file *file, unsigned int refs)
 	if (atomic_long_sub_and_test(refs, &file->f_count)) {
 		struct task_struct *task = current;
 
-		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+		if (likely(!in_interrupt() && !is_kthread(task))) {
 			init_task_work(&file->f_u.fu_rcuhead, ____fput);
 			if (!task_work_add(task, &file->f_u.fu_rcuhead, true))
 				return;
@@ -368,7 +368,7 @@ void __fput_sync(struct file *file)
 {
 	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task = current;
-		BUG_ON(!(task->flags & PF_KTHREAD));
+		BUG_ON(!is_kthread(task));
 		__fput(file);
 	}
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index d28d30b13043..7af913a0aee2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1173,7 +1173,7 @@ static void mntput_no_expire(struct mount *mnt)
 
 	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
 		struct task_struct *task = current;
-		if (likely(!(task->flags & PF_KTHREAD))) {
+		if (likely(!is_kthread(task))) {
 			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
 			if (!task_work_add(task, &mnt->mnt_rcu, true))
 				return;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..0036d241ba31 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1098,7 +1098,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 				continue;
 
 			/* do not touch kernel threads or the global init */
-			if (p->flags & PF_KTHREAD || is_global_init(p))
+			if (is_kthread(p) || is_global_init(p))
 				continue;
 
 			task_lock(p);
@@ -1695,7 +1695,7 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
 	kuid_t uid;
 	kgid_t gid;
 
-	if (unlikely(task->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(task))) {
 		*ruid = GLOBAL_ROOT_UID;
 		*rgid = GLOBAL_ROOT_GID;
 		return;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f6b048902d6c..96f47db6281a 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -907,7 +907,7 @@ static inline bool cgroup_task_freeze(struct task_struct *task)
 {
 	bool ret;
 
-	if (task->flags & PF_KTHREAD)
+	if (is_kthread(task))
 		return false;
 
 	rcu_read_lock();
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 8cf010680678..eb55085f7b97 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -199,7 +199,7 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
 		 * Ignore kernel threads here. Freezing cgroups containing
 		 * kthreads isn't supported.
 		 */
-		if (task->flags & PF_KTHREAD)
+		if (is_kthread(task))
 			continue;
 		cgroup_freeze_task(task, freeze);
 	}
@@ -227,7 +227,7 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 	/*
 	 * Kernel threads are not supposed to be frozen at all.
 	 */
-	if (task->flags & PF_KTHREAD)
+	if (is_kthread(task))
 		return;
 
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0463c1151bae..7cb753cf32cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5951,7 +5951,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & PF_KTHREAD)) {
+	} else if (!is_kthread(current)) {
 		perf_get_regs_user(regs_user, regs, regs_user_copy);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..e53b291735d4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -448,7 +448,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 * Search through everything else, we should not get here often.
 	 */
 	for_each_process(g) {
-		if (g->flags & PF_KTHREAD)
+		if (is_kthread(g))
 			continue;
 		for_each_thread(g, c) {
 			if (c->mm == mm)
diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e76ea3..d2e401d04971 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -459,7 +459,7 @@ void free_task(struct task_struct *tsk)
 	ftrace_graph_exit_task(tsk);
 	put_seccomp_filter(tsk);
 	arch_release_task_struct(tsk);
-	if (tsk->flags & PF_KTHREAD)
+	if (is_kthread(tsk))
 		free_kthread_struct(tsk);
 	free_task_struct(tsk);
 }
@@ -1167,7 +1167,7 @@ struct file *get_task_exe_file(struct task_struct *task)
 	task_lock(task);
 	mm = task->mm;
 	if (mm) {
-		if (!(task->flags & PF_KTHREAD))
+		if (!is_kthread(task))
 			exe_file = get_mm_exe_file(mm);
 	}
 	task_unlock(task);
@@ -1191,7 +1191,7 @@ struct mm_struct *get_task_mm(struct task_struct *task)
 	task_lock(task);
 	mm = task->mm;
 	if (mm) {
-		if (task->flags & PF_KTHREAD)
+		if (is_kthread(task))
 			mm = NULL;
 		else
 			mmget(mm);
diff --git a/kernel/freezer.c b/kernel/freezer.c
index c0738424bb43..d1c2855cfde4 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -51,7 +51,7 @@ bool freezing_slow_path(struct task_struct *p)
 	if (pm_nosig_freezing || cgroup_freezing(p))
 		return true;
 
-	if (pm_freezing && !(p->flags & PF_KTHREAD))
+	if (pm_freezing && !is_kthread(p))
 		return true;
 
 	return false;
@@ -140,7 +140,7 @@ bool freeze_task(struct task_struct *p)
 		return false;
 	}
 
-	if (!(p->flags & PF_KTHREAD))
+	if (!is_kthread(p))
 		fake_signal_wake_up(p);
 	else
 		wake_up_state(p, TASK_INTERRUPTIBLE);
diff --git a/kernel/futex.c b/kernel/futex.c
index 6d50728ef2e7..3b100d17aa9d 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1249,7 +1249,7 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 	if (!p)
 		return handle_exit_race(uaddr, uval, NULL);
 
-	if (unlikely(p->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(p))) {
 		put_task_struct(p);
 		return -EPERM;
 	}
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 621467c33fef..2c505d2e228c 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -72,7 +72,7 @@ static inline void set_kthread_struct(void *kthread)
 
 static inline struct kthread *to_kthread(struct task_struct *k)
 {
-	WARN_ON(!(k->flags & PF_KTHREAD));
+	WARN_ON(!is_kthread(k));
 	return (__force void *)k->set_child_tid;
 }
 
@@ -1205,7 +1205,7 @@ void kthread_associate_blkcg(struct cgroup_subsys_state *css)
 {
 	struct kthread *kthread;
 
-	if (!(current->flags & PF_KTHREAD))
+	if (!is_kthread(current))
 		return;
 	kthread = to_kthread(current);
 	if (!kthread)
@@ -1231,7 +1231,7 @@ struct cgroup_subsys_state *kthread_blkcg(void)
 {
 	struct kthread *kthread;
 
-	if (current->flags & PF_KTHREAD) {
+	if (is_kthread(current)) {
 		kthread = to_kthread(current);
 		if (kthread)
 			return kthread->blkcg_css;
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index cdf318d86dd6..3091d4eae48f 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -358,7 +358,7 @@ static void klp_send_signals(void)
 		 * Meanwhile the task could migrate itself and the action
 		 * would be meaningless. It is not serious though.
 		 */
-		if (task->flags & PF_KTHREAD) {
+		if (is_kthread(task)) {
 			/*
 			 * Wake up a kthread which sleeps interruptedly and
 			 * still has not been migrated.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index cb9ddcc08119..025ed158a1d4 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -376,7 +376,7 @@ static int ptrace_attach(struct task_struct *task, long request,
 	audit_ptrace(task);
 
 	retval = -EPERM;
-	if (unlikely(task->flags & PF_KTHREAD))
+	if (unlikely(is_kthread(task)))
 		goto out;
 	if (same_thread_group(task, current))
 		goto out;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..4c4a0494c39b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1323,7 +1323,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 static inline bool is_per_cpu_kthread(struct task_struct *p)
 {
-	if (!(p->flags & PF_KTHREAD))
+	if (!is_kthread(p))
 		return false;
 
 	if (p->nr_cpus_allowed != 1)
@@ -1518,7 +1518,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD) {
+	if (is_kthread(p)) {
 		/*
 		 * Kernel threads are allowed on online && !active CPUs
 		 */
@@ -1544,7 +1544,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 	do_set_cpus_allowed(p, new_mask);
 
-	if (p->flags & PF_KTHREAD) {
+	if (is_kthread(p)) {
 		/*
 		 * For kernel threads that do indeed end up on online &&
 		 * !active we want to ensure they are strict per-CPU threads.
@@ -6649,7 +6649,7 @@ void normalize_rt_tasks(void)
 		/*
 		 * Only normalize user tasks:
 		 */
-		if (p->flags & PF_KTHREAD)
+		if (is_kthread(p))
 			continue;
 
 		p->se.exec_start = 0;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..dbf38ba93991 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -321,7 +321,7 @@ void play_idle(unsigned long duration_ms)
 	 */
 	WARN_ON_ONCE(current->policy != SCHED_FIFO);
 	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
-	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
+	WARN_ON_ONCE(!is_kthread(current));
 	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
 	WARN_ON_ONCE(!duration_ms);
 
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index c1e566a114ca..a68429685d2b 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -380,7 +380,7 @@ EXPORT_SYMBOL(autoremove_wake_function);
 
 static inline bool is_kthread_should_stop(void)
 {
-	return (current->flags & PF_KTHREAD) && kthread_should_stop();
+	return is_kthread(current) && kthread_should_stop();
 }
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index e667be6907d7..a6e7ea47ae47 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1085,7 +1085,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	/*
 	 * Skip useless siginfo allocation for SIGKILL and kernel threads.
 	 */
-	if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
+	if ((sig == SIGKILL) || is_kthread(t))
 		goto out_set;
 
 	/*
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index f5440abb7532..bb05fac6e786 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -229,7 +229,7 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 	mm_segment_t fs;
 
 	/* Trace user stack if not a kernel thread */
-	if (current->flags & PF_KTHREAD)
+	if (is_kthread(current))
 		return 0;
 
 	fs = get_fs();
diff --git a/lib/is_single_threaded.c b/lib/is_single_threaded.c
index 8c98b20bfc41..bbb3fa4c01a4 100644
--- a/lib/is_single_threaded.c
+++ b/lib/is_single_threaded.c
@@ -28,7 +28,7 @@ bool current_is_single_threaded(void)
 	ret = false;
 	rcu_read_lock();
 	for_each_process(p) {
-		if (unlikely(p->flags & PF_KTHREAD))
+		if (unlikely(is_kthread(p)))
 			continue;
 		if (unlikely(p == task->group_leader))
 			continue;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cdbb7a84cb6e..a3965ca6037d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2668,7 +2668,7 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 
 static inline bool memcg_kmem_bypass(void)
 {
-	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+	if (in_interrupt() || !current->mm || is_kthread(current))
 		return true;
 	return false;
 }
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eda2e2a0bdc6..06dde52d7abb 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -162,7 +162,7 @@ static bool oom_unkillable_task(struct task_struct *p)
 {
 	if (is_global_init(p))
 		return true;
-	if (p->flags & PF_KTHREAD)
+	if (is_kthread(p))
 		return true;
 	return false;
 }
@@ -919,7 +919,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		 * No use_mm() user needs to read from the userspace so we are
 		 * ok to reap it.
 		 */
-		if (unlikely(p->flags & PF_KTHREAD))
+		if (unlikely(is_kthread(p)))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de1bf4e..4863f9812b90 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -831,7 +831,7 @@ static inline struct capture_control *task_capc(struct zone *zone)
 	struct capture_control *capc = current->capture_control;
 
 	return capc &&
-		!(current->flags & PF_KTHREAD) &&
+		!is_kthread(current) &&
 		!capc->page &&
 		capc->cc->zone == zone &&
 		capc->cc->direct_compaction ? capc : NULL;
diff --git a/mm/vmacache.c b/mm/vmacache.c
index cdc32a3b02fa..153ae62b2276 100644
--- a/mm/vmacache.c
+++ b/mm/vmacache.c
@@ -30,7 +30,7 @@
  */
 static inline bool vmacache_valid_mm(struct mm_struct *mm)
 {
-	return current->mm == mm && !(current->flags & PF_KTHREAD);
+	return current->mm == mm && !is_kthread(current);
 }
 
 void vmacache_update(unsigned long addr, struct vm_area_struct *newvma)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index dbdc46a84f63..16defb76cb2b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3110,7 +3110,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * committing a transaction where throttling it could forcing other
 	 * processes to block on log_wait_commit().
 	 */
-	if (current->flags & PF_KTHREAD)
+	if (is_kthread(current))
 		goto out;
 
 	/*
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index f1c93a7be9ec..1ec30f956852 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -671,7 +671,7 @@ bool smack_privileged(int cap)
 	/*
 	 * All kernel tasks are privileged
 	 */
-	if (unlikely(current->flags & PF_KTHREAD))
+	if (unlikely(is_kthread(current)))
 		return true;
 
 	return smack_privileged_cred(cap, current_cred());
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4c5e5a438f8b..182debb9f114 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2257,7 +2257,7 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	/*
 	 * Sockets created by kernel threads receive web label.
 	 */
-	if (unlikely(current->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(current))) {
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	} else {
@@ -2761,7 +2761,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	/*
 	 * Sockets created by kernel threads receive web label.
 	 */
-	if (unlikely(current->flags & PF_KTHREAD)) {
+	if (unlikely(is_kthread(current))) {
 		ssp = sock->sk->sk_security;
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 94dc346370b1..99a8bd60beb0 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -79,7 +79,7 @@ static void report_access(const char *access, struct task_struct *target,
 
 	assert_spin_locked(&target->alloc_lock); /* for target->comm */
 
-	if (current->flags & PF_KTHREAD) {
+	if (is_kthread(current)) {
 		/* I don't think kthreads call task_work_run() before exiting.
 		 * Imagine angry ranting about procfs here.
 		 */
-- 
2.11.0

