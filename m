Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91004C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53774206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKMVDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:03:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:19 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmI-00066I-SR; Wed, 13 Nov 2019 22:02:15 +0100
Message-Id: <20191113210103.911310593@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:42 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 02/20] x86/process: Unify copy_thread_tls()
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

While looking at the TSS io bitmap it turned out that any change in that
area would require identical changes to copy_thread_tls(). The 32 and 64
bit variants share sufficient code to consolidate them into a common
function to avoid duplication of upcoming modifications.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>

---
 arch/x86/include/asm/ptrace.h    |    6 ++
 arch/x86/include/asm/switch_to.h |   10 ++++
 arch/x86/kernel/process.c        |   94 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/process_32.c     |   68 ----------------------------
 arch/x86/kernel/process_64.c     |   75 -------------------------------
 5 files changed, 110 insertions(+), 143 deletions(-)

--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -361,5 +361,11 @@ extern int do_get_thread_area(struct tas
 extern int do_set_thread_area(struct task_struct *p, int idx,
 			      struct user_desc __user *info, int can_allocate);
 
+#ifdef CONFIG_X86_64
+# define do_set_thread_area_64(p, s, t)	do_arch_prctl_64(p, s, t)
+#else
+# define do_set_thread_area_64(p, s, t)	(0)
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_PTRACE_H */
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -103,7 +103,17 @@ static inline void update_task_stack(str
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
+}
 
+static inline void kthread_frame_init(struct inactive_task_frame *frame,
+				      unsigned long fun, unsigned long arg)
+{
+	frame->bx = fun;
+#ifdef CONFIG_X86_32
+	frame->di = arg;
+#else
+	frame->r12 = arg;
+#endif
 }
 
 #endif /* _ASM_X86_SWITCH_TO_H */
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -132,6 +132,100 @@ void exit_thread(struct task_struct *tsk
 	fpu__drop(fpu);
 }
 
+static int set_new_tls(struct task_struct *p, unsigned long tls)
+{
+	struct user_desc __user *utls = (struct user_desc __user *)tls;
+
+	if (in_ia32_syscall())
+		return do_set_thread_area(p, -1, utls, 0);
+	else
+		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
+}
+
+static inline int copy_io_bitmap(struct task_struct *tsk)
+{
+	if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
+		return 0;
+
+	tsk->thread.io_bitmap_ptr = kmemdup(current->thread.io_bitmap_ptr,
+					    IO_BITMAP_BYTES, GFP_KERNEL);
+	if (!tsk->thread.io_bitmap_ptr) {
+		tsk->thread.io_bitmap_max = 0;
+		return -ENOMEM;
+	}
+	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
+	return 0;
+}
+
+static inline void free_io_bitmap(struct task_struct *tsk)
+{
+	if (tsk->thread.io_bitmap_ptr) {
+		kfree(tsk->thread.io_bitmap_ptr);
+		tsk->thread.io_bitmap_ptr = NULL;
+		tsk->thread.io_bitmap_max = 0;
+	}
+}
+
+int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
+		    unsigned long arg, struct task_struct *p, unsigned long tls)
+{
+	struct inactive_task_frame *frame;
+	struct fork_frame *fork_frame;
+	struct pt_regs *childregs;
+	int ret;
+
+	childregs = task_pt_regs(p);
+	fork_frame = container_of(childregs, struct fork_frame, regs);
+	frame = &fork_frame->frame;
+
+	frame->bp = 0;
+	frame->ret_addr = (unsigned long) ret_from_fork;
+	p->thread.sp = (unsigned long) fork_frame;
+	p->thread.io_bitmap_ptr = NULL;
+	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
+
+#ifdef CONFIG_X86_64
+	savesegment(gs, p->thread.gsindex);
+	p->thread.gsbase = p->thread.gsindex ? 0 : current->thread.gsbase;
+	savesegment(fs, p->thread.fsindex);
+	p->thread.fsbase = p->thread.fsindex ? 0 : current->thread.fsbase;
+	savesegment(es, p->thread.es);
+	savesegment(ds, p->thread.ds);
+#else
+	/* Clear all status flags including IF and set fixed bit. */
+	frame->flags = X86_EFLAGS_FIXED;
+#endif
+
+	/* Kernel thread ? */
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		memset(childregs, 0, sizeof(struct pt_regs));
+		kthread_frame_init(frame, sp, arg);
+		return 0;
+	}
+
+	frame->bx = 0;
+	*childregs = *current_pt_regs();
+	childregs->ax = 0;
+	if (sp)
+		childregs->sp = sp;
+
+#ifdef CONFIG_X86_32
+	task_user_gs(p) = get_user_gs(current_pt_regs());
+#endif
+
+	ret = copy_io_bitmap(p);
+	if (ret)
+		return ret;
+
+	/* Set a new TLS for the child thread? */
+	if (clone_flags & CLONE_SETTLS) {
+		ret = set_new_tls(p, tls);
+		if (ret)
+			free_io_bitmap(p);
+	}
+	return ret;
+}
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -112,74 +112,6 @@ void release_thread(struct task_struct *
 	release_vm86_irqs(dead_task);
 }
 
-int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
-	unsigned long arg, struct task_struct *p, unsigned long tls)
-{
-	struct pt_regs *childregs = task_pt_regs(p);
-	struct fork_frame *fork_frame = container_of(childregs, struct fork_frame, regs);
-	struct inactive_task_frame *frame = &fork_frame->frame;
-	struct task_struct *tsk;
-	int err;
-
-	/*
-	 * For a new task use the RESET flags value since there is no before.
-	 * All the status flags are zero; DF and all the system flags must also
-	 * be 0, specifically IF must be 0 because we context switch to the new
-	 * task with interrupts disabled.
-	 */
-	frame->flags = X86_EFLAGS_FIXED;
-	frame->bp = 0;
-	frame->ret_addr = (unsigned long) ret_from_fork;
-	p->thread.sp = (unsigned long) fork_frame;
-	p->thread.sp0 = (unsigned long) (childregs+1);
-	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
-
-	if (unlikely(p->flags & PF_KTHREAD)) {
-		/* kernel thread */
-		memset(childregs, 0, sizeof(struct pt_regs));
-		frame->bx = sp;		/* function */
-		frame->di = arg;
-		p->thread.io_bitmap_ptr = NULL;
-		return 0;
-	}
-	frame->bx = 0;
-	*childregs = *current_pt_regs();
-	childregs->ax = 0;
-	if (sp)
-		childregs->sp = sp;
-
-	task_user_gs(p) = get_user_gs(current_pt_regs());
-
-	p->thread.io_bitmap_ptr = NULL;
-	tsk = current;
-	err = -ENOMEM;
-
-	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr = kmemdup(tsk->thread.io_bitmap_ptr,
-						IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr) {
-			p->thread.io_bitmap_max = 0;
-			return -ENOMEM;
-		}
-		set_tsk_thread_flag(p, TIF_IO_BITMAP);
-	}
-
-	err = 0;
-
-	/*
-	 * Set a new TLS for the child thread?
-	 */
-	if (clone_flags & CLONE_SETTLS)
-		err = do_set_thread_area(p, -1,
-			(struct user_desc __user *)tls, 0);
-
-	if (err && p->thread.io_bitmap_ptr) {
-		kfree(p->thread.io_bitmap_ptr);
-		p->thread.io_bitmap_max = 0;
-	}
-	return err;
-}
-
 void
 start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 {
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -371,81 +371,6 @@ void x86_gsbase_write_task(struct task_s
 	task->thread.gsbase = gsbase;
 }
 
-int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct *p, unsigned long tls)
-{
-	int err;
-	struct pt_regs *childregs;
-	struct fork_frame *fork_frame;
-	struct inactive_task_frame *frame;
-	struct task_struct *me = current;
-
-	childregs = task_pt_regs(p);
-	fork_frame = container_of(childregs, struct fork_frame, regs);
-	frame = &fork_frame->frame;
-
-	frame->bp = 0;
-	frame->ret_addr = (unsigned long) ret_from_fork;
-	p->thread.sp = (unsigned long) fork_frame;
-	p->thread.io_bitmap_ptr = NULL;
-
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase = p->thread.gsindex ? 0 : me->thread.gsbase;
-	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase = p->thread.fsindex ? 0 : me->thread.fsbase;
-	savesegment(es, p->thread.es);
-	savesegment(ds, p->thread.ds);
-	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
-
-	if (unlikely(p->flags & PF_KTHREAD)) {
-		/* kernel thread */
-		memset(childregs, 0, sizeof(struct pt_regs));
-		frame->bx = sp;		/* function */
-		frame->r12 = arg;
-		return 0;
-	}
-	frame->bx = 0;
-	*childregs = *current_pt_regs();
-
-	childregs->ax = 0;
-	if (sp)
-		childregs->sp = sp;
-
-	err = -ENOMEM;
-	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr = kmemdup(me->thread.io_bitmap_ptr,
-						  IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr) {
-			p->thread.io_bitmap_max = 0;
-			return -ENOMEM;
-		}
-		set_tsk_thread_flag(p, TIF_IO_BITMAP);
-	}
-
-	/*
-	 * Set a new TLS for the child thread?
-	 */
-	if (clone_flags & CLONE_SETTLS) {
-#ifdef CONFIG_IA32_EMULATION
-		if (in_ia32_syscall())
-			err = do_set_thread_area(p, -1,
-				(struct user_desc __user *)tls, 0);
-		else
-#endif
-			err = do_arch_prctl_64(p, ARCH_SET_FS, tls);
-		if (err)
-			goto out;
-	}
-	err = 0;
-out:
-	if (err && p->thread.io_bitmap_ptr) {
-		kfree(p->thread.io_bitmap_ptr);
-		p->thread.io_bitmap_max = 0;
-	}
-
-	return err;
-}
-
 static void
 start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		    unsigned long new_sp,




