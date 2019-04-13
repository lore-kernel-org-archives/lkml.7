Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E422C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C652084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDMUwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:52:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34039 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDMUwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:52:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKolRn2265568
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:50:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKokbh2265565;
        Sat, 13 Apr 2019 13:50:46 -0700
Date:   Sat, 13 Apr 2019 13:50:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-2722146eb78451b30e4717a267a3a2b44e4ad317@git.kernel.org>
Cc:     rkrcmar@redhat.com, mingo@kernel.org, mhiramat@kernel.org,
        bigeasy@linutronix.de, jannh@google.com, dima@arista.com,
        jroedel@suse.de, kvm@vger.kernel.org, will.deacon@arm.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        Babu.Moger@amd.com, sergey.senozhatsky@gmail.com, nstange@suse.de,
        riel@surriel.com, peterz@infradead.org, Jason@zx2c4.com,
        hpa@zytor.com, mathieu.desnoyers@efficios.com,
        dave.hansen@intel.com, x86@kernel.org, tglx@linutronix.de,
        aubrey.li@intel.com, pbonzini@redhat.com, bp@suse.de,
        chang.seok.bae@intel.com
Reply-To: luto@kernel.org, Babu.Moger@amd.com,
          sergey.senozhatsky@gmail.com, riel@surriel.com, nstange@suse.de,
          linux-kernel@vger.kernel.org, Jason@zx2c4.com, hpa@zytor.com,
          peterz@infradead.org, dave.hansen@intel.com, x86@kernel.org,
          mathieu.desnoyers@efficios.com, aubrey.li@intel.com,
          pbonzini@redhat.com, bp@suse.de, chang.seok.bae@intel.com,
          tglx@linutronix.de, bigeasy@linutronix.de, jannh@google.com,
          rkrcmar@redhat.com, mhiramat@kernel.org, mingo@kernel.org,
          dima@arista.com, jroedel@suse.de, will.deacon@arm.com,
          kvm@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20190403164156.19645-8-bigeasy@linutronix.de>
References: <20190403164156.19645-8-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Remove fpu->initialized
Git-Commit-ID: 2722146eb78451b30e4717a267a3a2b44e4ad317
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

Commit-ID:  2722146eb78451b30e4717a267a3a2b44e4ad317
Gitweb:     https://git.kernel.org/tip/2722146eb78451b30e4717a267a3a2b44e4ad317
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:36 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 15:42:40 +0200

x86/fpu: Remove fpu->initialized

The struct fpu.initialized member is always set to one for user tasks
and zero for kernel tasks. This avoids saving/restoring the FPU
registers for kernel threads.

The ->initialized = 0 case for user tasks has been removed in previous
changes, for instance, by doing an explicit unconditional init at fork()
time for FPU-less systems which was otherwise delayed until the emulated
opcode.

The context switch code (switch_fpu_prepare() + switch_fpu_finish())
can't unconditionally save/restore registers for kernel threads. Not
only would it slow down the switch but also load a zeroed xcomp_bv for
XSAVES.

For kernel_fpu_begin() (+end) the situation is similar: EFI with runtime
services uses this before alternatives_patched is true. Which means that
this function is used too early and it wasn't the case before.

For those two cases, use current->mm to distinguish between user and
kernel thread. For kernel_fpu_begin() skip save/restore of the FPU
registers.

During the context switch into a kernel thread don't do anything. There
is no reason to save the FPU state of a kernel thread.

The reordering in __switch_to() is important because the current()
pointer needs to be valid before switch_fpu_finish() is invoked so ->mm
is seen of the new task instead the old one.

N.B.: fpu__save() doesn't need to check ->mm because it is called by
user tasks only.

 [ bp: Massage. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Babu Moger <Babu.Moger@amd.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-8-bigeasy@linutronix.de
---
 arch/x86/ia32/ia32_signal.c         | 17 ++++-----
 arch/x86/include/asm/fpu/internal.h | 18 +++++-----
 arch/x86/include/asm/fpu/types.h    |  9 -----
 arch/x86/include/asm/trace/fpu.h    |  5 +--
 arch/x86/kernel/fpu/core.c          | 70 +++++++++++--------------------------
 arch/x86/kernel/fpu/init.c          |  2 --
 arch/x86/kernel/fpu/regset.c        | 19 +++-------
 arch/x86/kernel/fpu/xstate.c        |  2 --
 arch/x86/kernel/process_32.c        |  4 +--
 arch/x86/kernel/process_64.c        |  4 +--
 arch/x86/kernel/signal.c            | 17 ++++-----
 arch/x86/mm/pkeys.c                 |  7 +---
 12 files changed, 53 insertions(+), 121 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 321fe5f5d0e9..6eeb3249f22f 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -216,8 +216,7 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 				 size_t frame_size,
 				 void __user **fpstate)
 {
-	struct fpu *fpu = &current->thread.fpu;
-	unsigned long sp;
+	unsigned long sp, fx_aligned, math_size;
 
 	/* Default to using normal stack */
 	sp = regs->sp;
@@ -231,15 +230,11 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 		 ksig->ka.sa.sa_restorer)
 		sp = (unsigned long) ksig->ka.sa.sa_restorer;
 
-	if (fpu->initialized) {
-		unsigned long fx_aligned, math_size;
-
-		sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
-		*fpstate = (struct _fpstate_32 __user *) sp;
-		if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
-				    math_size) < 0)
-			return (void __user *) -1L;
-	}
+	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
+	*fpstate = (struct _fpstate_32 __user *) sp;
+	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
+				     math_size) < 0)
+		return (void __user *) -1L;
 
 	sp -= frame_size;
 	/* Align the stack pointer according to the i386 ABI,
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 70ecb7c032cb..04042eacc852 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -494,11 +494,14 @@ static inline void fpregs_activate(struct fpu *fpu)
  *
  *  - switch_fpu_finish() restores the new state as
  *    necessary.
+ *
+ * The FPU context is only stored/restored for a user task and
+ * ->mm is used to distinguish between kernel and user threads.
  */
 static inline void
 switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU) && old_fpu->initialized) {
+	if (static_cpu_has(X86_FEATURE_FPU) && current->mm) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
 			old_fpu->last_cpu = -1;
 		else
@@ -506,8 +509,7 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 
 		/* But leave fpu_fpregs_owner_ctx! */
 		trace_x86_fpu_regs_deactivated(old_fpu);
-	} else
-		old_fpu->last_cpu = -1;
+	}
 }
 
 /*
@@ -520,12 +522,12 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 {
-	bool preload = static_cpu_has(X86_FEATURE_FPU) &&
-		       new_fpu->initialized;
+	if (static_cpu_has(X86_FEATURE_FPU)) {
+		if (!fpregs_state_valid(new_fpu, cpu)) {
+			if (current->mm)
+				copy_kernel_to_fpregs(&new_fpu->state);
+		}
 
-	if (preload) {
-		if (!fpregs_state_valid(new_fpu, cpu))
-			copy_kernel_to_fpregs(&new_fpu->state);
 		fpregs_activate(new_fpu);
 	}
 }
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 2e32e178e064..f098f6cab94b 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -293,15 +293,6 @@ struct fpu {
 	 */
 	unsigned int			last_cpu;
 
-	/*
-	 * @initialized:
-	 *
-	 * This flag indicates whether this context is initialized: if the task
-	 * is not running then we can restore from this context, if the task
-	 * is running then we should save into this context.
-	 */
-	unsigned char			initialized;
-
 	/*
 	 * @avx512_timestamp:
 	 *
diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 069c04be1507..bd65f6ba950f 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -13,22 +13,19 @@ DECLARE_EVENT_CLASS(x86_fpu,
 
 	TP_STRUCT__entry(
 		__field(struct fpu *, fpu)
-		__field(bool, initialized)
 		__field(u64, xfeatures)
 		__field(u64, xcomp_bv)
 		),
 
 	TP_fast_assign(
 		__entry->fpu		= fpu;
-		__entry->initialized	= fpu->initialized;
 		if (boot_cpu_has(X86_FEATURE_OSXSAVE)) {
 			__entry->xfeatures = fpu->state.xsave.header.xfeatures;
 			__entry->xcomp_bv  = fpu->state.xsave.header.xcomp_bv;
 		}
 	),
-	TP_printk("x86/fpu: %p initialized: %d xfeatures: %llx xcomp_bv: %llx",
+	TP_printk("x86/fpu: %p xfeatures: %llx xcomp_bv: %llx",
 			__entry->fpu,
-			__entry->initialized,
 			__entry->xfeatures,
 			__entry->xcomp_bv
 	)
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e43296854e37..97e27de2b7c0 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -101,7 +101,7 @@ static void __kernel_fpu_begin(void)
 
 	kernel_fpu_disable();
 
-	if (fpu->initialized) {
+	if (current->mm) {
 		/*
 		 * Ignore return value -- we don't care if reg state
 		 * is clobbered.
@@ -116,7 +116,7 @@ static void __kernel_fpu_end(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
-	if (fpu->initialized)
+	if (current->mm)
 		copy_kernel_to_fpregs(&fpu->state);
 
 	kernel_fpu_enable();
@@ -147,11 +147,10 @@ void fpu__save(struct fpu *fpu)
 
 	preempt_disable();
 	trace_x86_fpu_before_save(fpu);
-	if (fpu->initialized) {
-		if (!copy_fpregs_to_fpstate(fpu)) {
-			copy_kernel_to_fpregs(&fpu->state);
-		}
-	}
+
+	if (!copy_fpregs_to_fpstate(fpu))
+		copy_kernel_to_fpregs(&fpu->state);
+
 	trace_x86_fpu_after_save(fpu);
 	preempt_enable();
 }
@@ -190,7 +189,7 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
 {
 	dst_fpu->last_cpu = -1;
 
-	if (!src_fpu->initialized || !static_cpu_has(X86_FEATURE_FPU))
+	if (!static_cpu_has(X86_FEATURE_FPU))
 		return 0;
 
 	WARN_ON_FPU(src_fpu != &current->thread.fpu);
@@ -227,14 +226,10 @@ static void fpu__initialize(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
-	if (!fpu->initialized) {
-		fpstate_init(&fpu->state);
-		trace_x86_fpu_init_state(fpu);
+	fpstate_init(&fpu->state);
+	trace_x86_fpu_init_state(fpu);
 
-		trace_x86_fpu_activate_state(fpu);
-		/* Safe to do for the current task: */
-		fpu->initialized = 1;
-	}
+	trace_x86_fpu_activate_state(fpu);
 }
 
 /*
@@ -247,32 +242,20 @@ static void fpu__initialize(struct fpu *fpu)
  *
  * - or it's called for stopped tasks (ptrace), in which case the
  *   registers were already saved by the context-switch code when
- *   the task scheduled out - we only have to initialize the registers
- *   if they've never been initialized.
+ *   the task scheduled out.
  *
  * If the task has used the FPU before then save it.
  */
 void fpu__prepare_read(struct fpu *fpu)
 {
-	if (fpu == &current->thread.fpu) {
+	if (fpu == &current->thread.fpu)
 		fpu__save(fpu);
-	} else {
-		if (!fpu->initialized) {
-			fpstate_init(&fpu->state);
-			trace_x86_fpu_init_state(fpu);
-
-			trace_x86_fpu_activate_state(fpu);
-			/* Safe to do for current and for stopped child tasks: */
-			fpu->initialized = 1;
-		}
-	}
 }
 
 /*
  * This function must be called before we write a task's fpstate.
  *
- * If the task has used the FPU before then invalidate any cached FPU registers.
- * If the task has not used the FPU before then initialize its fpstate.
+ * Invalidate any cached FPU registers.
  *
  * After this function call, after registers in the fpstate are
  * modified and the child task has woken up, the child task will
@@ -289,17 +272,8 @@ void fpu__prepare_write(struct fpu *fpu)
 	 */
 	WARN_ON_FPU(fpu == &current->thread.fpu);
 
-	if (fpu->initialized) {
-		/* Invalidate any cached state: */
-		__fpu_invalidate_fpregs_state(fpu);
-	} else {
-		fpstate_init(&fpu->state);
-		trace_x86_fpu_init_state(fpu);
-
-		trace_x86_fpu_activate_state(fpu);
-		/* Safe to do for stopped child tasks: */
-		fpu->initialized = 1;
-	}
+	/* Invalidate any cached state: */
+	__fpu_invalidate_fpregs_state(fpu);
 }
 
 /*
@@ -316,17 +290,13 @@ void fpu__drop(struct fpu *fpu)
 	preempt_disable();
 
 	if (fpu == &current->thread.fpu) {
-		if (fpu->initialized) {
-			/* Ignore delayed exceptions from user space */
-			asm volatile("1: fwait\n"
-				     "2:\n"
-				     _ASM_EXTABLE(1b, 2b));
-			fpregs_deactivate(fpu);
-		}
+		/* Ignore delayed exceptions from user space */
+		asm volatile("1: fwait\n"
+			     "2:\n"
+			     _ASM_EXTABLE(1b, 2b));
+		fpregs_deactivate(fpu);
 	}
 
-	fpu->initialized = 0;
-
 	trace_x86_fpu_dropped(fpu);
 
 	preempt_enable();
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6abd83572b01..20d8fa7124c7 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -239,8 +239,6 @@ static void __init fpu__init_system_ctx_switch(void)
 
 	WARN_ON_FPU(!on_boot_cpu);
 	on_boot_cpu = 0;
-
-	WARN_ON_FPU(current->thread.fpu.initialized);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 5dbc099178a8..d652b939ccfb 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -15,16 +15,12 @@
  */
 int regset_fpregs_active(struct task_struct *target, const struct user_regset *regset)
 {
-	struct fpu *target_fpu = &target->thread.fpu;
-
-	return target_fpu->initialized ? regset->n : 0;
+	return regset->n;
 }
 
 int regset_xregset_fpregs_active(struct task_struct *target, const struct user_regset *regset)
 {
-	struct fpu *target_fpu = &target->thread.fpu;
-
-	if (boot_cpu_has(X86_FEATURE_FXSR) && target_fpu->initialized)
+	if (boot_cpu_has(X86_FEATURE_FXSR))
 		return regset->n;
 	else
 		return 0;
@@ -370,16 +366,9 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 int dump_fpu(struct pt_regs *regs, struct user_i387_struct *ufpu)
 {
 	struct task_struct *tsk = current;
-	struct fpu *fpu = &tsk->thread.fpu;
-	int fpvalid;
-
-	fpvalid = fpu->initialized;
-	if (fpvalid)
-		fpvalid = !fpregs_get(tsk, NULL,
-				      0, sizeof(struct user_i387_ia32_struct),
-				      ufpu, NULL);
 
-	return fpvalid;
+	return !fpregs_get(tsk, NULL, 0, sizeof(struct user_i387_ia32_struct),
+			   ufpu, NULL);
 }
 EXPORT_SYMBOL(dump_fpu);
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d7432c2b1051..8bfcc5b9e04b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -892,8 +892,6 @@ const void *get_xsave_field_ptr(int xsave_state)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
-	if (!fpu->initialized)
-		return NULL;
 	/*
 	 * fpu__save() takes the CPU's xstate registers
 	 * and saves them off to the 'fpu memory buffer.
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 7888a41a03cd..77d9eb43ccac 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -288,10 +288,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		lazy_load_gs(next->gs);
 
-	switch_fpu_finish(next_fpu, cpu);
-
 	this_cpu_write(current_task, next_p);
 
+	switch_fpu_finish(next_fpu, cpu);
+
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e1983b3a16c4..ffea7c557963 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -566,14 +566,14 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	x86_fsgsbase_load(prev, next);
 
-	switch_fpu_finish(next_fpu, cpu);
-
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
+	switch_fpu_finish(next_fpu, cpu);
+
 	/* Reload sp0. */
 	update_task_stack(next_p);
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index b419e1a1a0ce..87b327c6cb10 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -246,7 +246,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
 	int onsigstack = on_sig_stack(sp);
-	struct fpu *fpu = &current->thread.fpu;
+	int ret;
 
 	/* redzone */
 	if (IS_ENABLED(CONFIG_X86_64))
@@ -265,11 +265,9 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 		sp = (unsigned long) ka->sa.sa_restorer;
 	}
 
-	if (fpu->initialized) {
-		sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
-					  &buf_fx, &math_size);
-		*fpstate = (void __user *)sp;
-	}
+	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
+				  &buf_fx, &math_size);
+	*fpstate = (void __user *)sp;
 
 	sp = align_sigframe(sp - frame_size);
 
@@ -281,8 +279,8 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 		return (void __user *)-1L;
 
 	/* save i387 and extended state */
-	if (fpu->initialized &&
-	    copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size) < 0)
+	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
+	if (ret < 0)
 		return (void __user *)-1L;
 
 	return (void __user *)sp;
@@ -763,8 +761,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		/*
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
-		if (fpu->initialized)
-			fpu__clear(fpu);
+		fpu__clear(fpu);
 	}
 	signal_setup_done(failed, ksig, stepping);
 }
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 047a77f6a10c..05bb9a44eb1c 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -39,17 +39,12 @@ int __execute_only_pkey(struct mm_struct *mm)
 	 * dance to set PKRU if we do not need to.  Check it
 	 * first and assume that if the execute-only pkey is
 	 * write-disabled that we do not have to set it
-	 * ourselves.  We need preempt off so that nobody
-	 * can make fpregs inactive.
+	 * ourselves.
 	 */
-	preempt_disable();
 	if (!need_to_set_mm_pkey &&
-	    current->thread.fpu.initialized &&
 	    !__pkru_allows_read(read_pkru(), execute_only_pkey)) {
-		preempt_enable();
 		return execute_only_pkey;
 	}
-	preempt_enable();
 
 	/*
 	 * Set up PKRU so that it denies access for everything
