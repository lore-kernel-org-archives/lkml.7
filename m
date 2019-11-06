Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EB0C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC92217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Y5IlL5r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfKFDJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:09:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43837 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbfKFDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:09:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so16115669pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9u2z65BPTEuwBLuCUzFNMCAwuYoea6QtnVxoE9Y+xI=;
        b=Y5IlL5r1g4rbYVzeJqN0j0crNgUtlY1cKDuVzQt/++NQozm+zzXI1KDp8ZDXC0wbN6
         vmp34G0ePfxi6uXFVsHfNSPhGEaLMnfkIbaLQcMLRUBtAfrAMzuFBWq2NAFyj4de/tAb
         IlriS6bFGYb6ZrlwZbyTs8P66azimfdneEAcVagmf3LFt4TGzOkBoDzf/IBypMk1deBm
         OYJtsUT5iyVcL7qc0WfwPnKTkAWYM5qdAwKKu90+hntlLwKEz1OdgGyKE3xyO5HyuHKS
         s08Z6gS8z2AFED/dHVJBkv1a0flLBds2tcPAEK1RT2YXnDGxyTuIUmM5h6SrsXUEmbn4
         QuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9u2z65BPTEuwBLuCUzFNMCAwuYoea6QtnVxoE9Y+xI=;
        b=dbZbBp4lnYesS0HOHOMvl3ZPTe8ikLVhnerOR2tHjqD5SWF9RJSuW1mMaqhJWqZ+ez
         lgFdq2NYi2JUgV391C9Qt/7Y69Bb/Tdyb6+TuUvhQsYgsy2JX9fG4iUK5MK0IEbQE3/F
         KPSPAuqDbkG0IJ2uj4+enCxyWnrEbAsGETz3eZNVsExWXBMn4L9YfXSPYt08U4Y6ns4s
         RfECLylvuvO1nhev1QwalgagINBKHYkMyde7w8atBrFw11x2u3GbDleD6H0FqLKgPJ77
         mTkizVOfrquP82Pt1mnqGM0it0KM2vjl5I4q0s5LBRXsSFOKzK+Ck7+SUP0AdTmhb6lZ
         O47A==
X-Gm-Message-State: APjAAAVR2mNB59PoMYvpbJCCRGWX3iNNiKrpaV+bz6tfq7mLPAtFBpxO
        08HiReBr51utVoD90kc1L5OaS9LPkmQ=
X-Google-Smtp-Source: APXvYqxbJYjVFA8bF/XBmlfTxFdHY2zDdQq2gEG8U9pQ1hxwoGQkno0ib5WBmqayXPk2bWCjYa1BcA==
X-Received: by 2002:a17:90a:1b2a:: with SMTP id q39mr579676pjq.119.1573009757192;
        Tue, 05 Nov 2019 19:09:17 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:09:16 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 50/50] kernel: Rename show_stack_loglvl() => show_stack()
Date:   Wed,  6 Nov 2019 03:05:41 +0000
Message-Id: <20191106030542.868541-51-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the last users of show_stack() got converted to use an explicit log
level, show_stack_loglvl() can drop it's redundant suffix and become
once again well known show_stack().

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/alpha/kernel/traps.c        |  8 +-------
 arch/arc/kernel/stacktrace.c     |  8 +-------
 arch/arm/kernel/traps.c          |  8 +-------
 arch/arm64/kernel/traps.c        |  8 +-------
 arch/c6x/kernel/traps.c          |  7 +------
 arch/csky/kernel/dumpstack.c     |  7 +------
 arch/csky/kernel/ptrace.c        |  4 ++--
 arch/h8300/kernel/traps.c        |  8 +-------
 arch/hexagon/kernel/traps.c      |  8 +-------
 arch/ia64/kernel/mca.c           |  2 +-
 arch/ia64/kernel/process.c       | 11 ++---------
 arch/m68k/kernel/traps.c         | 11 +++--------
 arch/microblaze/kernel/traps.c   |  8 +-------
 arch/mips/kernel/traps.c         |  8 +-------
 arch/nds32/kernel/traps.c        |  8 +-------
 arch/nios2/kernel/traps.c        | 12 +++---------
 arch/openrisc/kernel/traps.c     | 10 ++--------
 arch/parisc/kernel/traps.c       |  8 +-------
 arch/powerpc/kernel/process.c    | 11 +++--------
 arch/powerpc/kernel/stacktrace.c |  2 +-
 arch/riscv/kernel/stacktrace.c   |  8 +-------
 arch/s390/kernel/dumpstack.c     |  7 +------
 arch/sh/kernel/dumpstack.c       |  8 +-------
 arch/sh/kernel/process_64.c      |  3 +--
 arch/sparc/kernel/process_32.c   | 11 ++---------
 arch/sparc/kernel/process_64.c   |  2 +-
 arch/um/drivers/mconsole_kern.c  |  2 +-
 arch/um/kernel/sysrq.c           |  7 +------
 arch/unicore32/kernel/traps.c    |  7 +------
 arch/x86/kernel/amd_gart_64.c    |  2 +-
 arch/x86/kernel/dumpstack.c      |  7 +------
 arch/xtensa/kernel/traps.c       | 10 ++--------
 drivers/base/power/main.c        |  2 +-
 drivers/tty/sysrq.c              |  2 +-
 include/linux/sched/debug.h      |  5 ++---
 kernel/debug/kdb/kdb_bt.c        |  8 ++++----
 kernel/locking/rtmutex-debug.c   |  2 +-
 kernel/sched/core.c              |  2 +-
 lib/dump_stack.c                 |  2 +-
 39 files changed, 54 insertions(+), 200 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 2402f1777f54..8383ccfaccdc 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -144,8 +144,7 @@ dik_show_trace(unsigned long *sp, const char *loglvl)
 
 static int kstack_depth_to_print = 24;
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
-			const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
 	unsigned long *stack;
 	int i;
@@ -174,11 +173,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
 	dik_show_trace(sp, loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_DEFAULT);
-}
-
 void
 die_if_kernel(char * str, struct pt_regs *regs, long err, unsigned long *r9_15)
 {
diff --git a/arch/arc/kernel/stacktrace.c b/arch/arc/kernel/stacktrace.c
index 24f9cd8a12c9..feba91c9d969 100644
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -228,17 +228,11 @@ noinline void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs,
 EXPORT_SYMBOL(show_stacktrace);
 
 /* Expected by sched Code */
-void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
-			const char *loglvl)
+void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 {
 	show_stacktrace(tsk, NULL, loglvl);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
-{
-	show_stack_loglvl(tsk, sp, KERN_DEFAULT);
-}
-
 /* Another API expected by schedular, shows up in "ps" as Wait Channel
  * Of course just returning schedule( ) would be pointless so unwind until
  * the function is not in schedular code
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index f999a0e4bab8..02e9e297bf92 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -246,18 +246,12 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 }
 #endif
 
-void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 {
 	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
-{
-	show_stack_loglvl(tsk, sp, KERN_DEFAULT);
-}
-
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
 #else
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5b3ae8ed33fd..b1d437ec93d2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -136,18 +136,12 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 	put_task_stack(tsk);
 }
 
-void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 {
 	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
-{
-	show_stack_loglvl(tsk, sp, KERN_DEFAULT);
-}
-
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
 #else
diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
index 07704670236b..33ac8c76c17f 100644
--- a/arch/c6x/kernel/traps.c
+++ b/arch/c6x/kernel/traps.c
@@ -374,7 +374,7 @@ static void show_trace(unsigned long *stack, unsigned long *endstack,
 	printk("%s\n", loglvl);
 }
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+void show_stack(struct task_struct *task, unsigned long *stack,
 		const char *loglvl)
 {
 	unsigned long *p, *endstack;
@@ -403,11 +403,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
 	show_trace(stack, endstack, loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
-{
-	show_stack_loglvl(task, stack, KERN_DEBUG);
-}
-
 int is_valid_bugaddr(unsigned long addr)
 {
 	return __kernel_text_address(addr);
diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
index c500837390d3..b9660b1944a1 100644
--- a/arch/csky/kernel/dumpstack.c
+++ b/arch/csky/kernel/dumpstack.c
@@ -32,7 +32,7 @@ static void show_trace(unsigned long *stack, const char *loglvl)
 	pr_cont("\n");
 }
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+void show_stack(struct task_struct *task, unsigned long *stack,
 		const char *loglvl)
 {
 	if (!stack) {
@@ -48,8 +48,3 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
 
 	show_trace(stack, loglvl);
 }
-
-void show_stack(struct task_struct *task, unsigned long *stack)
-{
-	show_stack_loglvl(task, stack, KERN_INFO);
-}
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 313623a19ecb..7fa7202e025f 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -235,7 +235,7 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 }
 
-extern void show_stack(struct task_struct *task, unsigned long *stack);
+extern void show_stack(struct task_struct *task, unsigned long *stack, const char *loglvl);
 void show_regs(struct pt_regs *fp)
 {
 	unsigned long   *sp;
@@ -311,6 +311,6 @@ void show_regs(struct pt_regs *fp)
 	}
 	pr_cont("\n");
 
-	show_stack(NULL, (unsigned long *)fp->regs[4]);
+	show_stack(NULL, (unsigned long *)fp->regs[4], KERN_INFO);
 	return;
 }
diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
index 6362446563d6..5d8b969cd8f3 100644
--- a/arch/h8300/kernel/traps.c
+++ b/arch/h8300/kernel/traps.c
@@ -115,8 +115,7 @@ void die(const char *str, struct pt_regs *fp, unsigned long err)
 
 static int kstack_depth_to_print = 24;
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *esp, const char *loglvl)
 {
 	unsigned long *stack,  addr;
 	int i;
@@ -158,8 +157,3 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
 	}
 	printk("%s\n", loglvl);
 }
-
-void show_stack(struct task_struct *task, unsigned long *esp)
-{
-	show_stack_loglvl(task, esp, KERN_INFO);
-}
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index a8a3a210d781..904134b37232 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -175,18 +175,12 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	}
 }
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *fp,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *fp, const char *loglvl)
 {
 	/* Saved link reg is one word above FP */
 	do_show_stack(task, fp, 0, loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *fp)
-{
-	show_stack_loglvl(task, fp, 0, KERN_INFO);
-}
-
 int die(const char *str, struct pt_regs *regs, long err)
 {
 	static struct {
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index bf2cb9294795..1d4b8f619fd2 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1630,7 +1630,7 @@ default_monarch_init_process(struct notifier_block *self, unsigned long val, voi
 	if (read_trylock(&tasklist_lock)) {
 		do_each_thread (g, t) {
 			printk("\nBacktrace of pid %d (%s)\n", t->pid, t->comm);
-			show_stack(t, NULL);
+			show_stack(t, NULL, KERN_DEFAULT);
 		} while_each_thread (g, t);
 		read_unlock(&tasklist_lock);
 	}
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index b0eeb19bdd8d..aaabf515cef5 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -85,8 +85,7 @@ ia64_do_show_stack (struct unw_frame_info *info, void *arg)
 }
 
 void
-show_stack_loglvl (struct task_struct *task, unsigned long *sp,
-		   const char *loglvl)
+show_stack (struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
 	if (!task)
 		unw_init_running(ia64_do_show_stack, (void *)loglvl);
@@ -98,12 +97,6 @@ show_stack_loglvl (struct task_struct *task, unsigned long *sp,
 	}
 }
 
-void
-show_stack (struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_DEFAULT);
-}
-
 void
 show_regs (struct pt_regs *regs)
 {
@@ -158,7 +151,7 @@ show_regs (struct pt_regs *regs)
 			       ((i == sof - 1) || (i % 3) == 2) ? "\n" : " ");
 		}
 	} else
-		show_stack(NULL, NULL);
+		show_stack(NULL, NULL, KERN_DEFAULT);
 }
 
 /* local support for deprecated console_print */
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index ffcc5ec4fac3..df6fc782754f 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -916,7 +916,7 @@ void show_registers(struct pt_regs *regs)
 	default:
 		pr_cont("\n");
 	}
-	show_stack(NULL, (unsigned long *)addr);
+	show_stack(NULL, (unsigned long *)addr, KERN_INFO);
 
 	pr_info("Code:");
 	set_fs(KERNEL_DS);
@@ -935,8 +935,8 @@ void show_registers(struct pt_regs *regs)
 	pr_cont("\n");
 }
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *stack,
+		const char *loglvl)
 {
 	unsigned long *p;
 	unsigned long *endstack;
@@ -963,11 +963,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
 	show_trace(stack, loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
-{
-	show_stack_loglvl(task, stack, KERN_INFO);
-}
-
 /*
  * The vector number returned in the frame pointer may also contain
  * the "fs" (Fault Status) bits on ColdFire. These are in the bottom
diff --git a/arch/microblaze/kernel/traps.c b/arch/microblaze/kernel/traps.c
index 149ae534937e..94b6fe93147d 100644
--- a/arch/microblaze/kernel/traps.c
+++ b/arch/microblaze/kernel/traps.c
@@ -31,8 +31,7 @@ static int __init kstack_setup(char *s)
 }
 __setup("kstack=", kstack_setup);
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
 	unsigned long words_to_show;
 	u32 fp = (u32) sp;
@@ -77,8 +76,3 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
 
 	debug_show_held_locks(task);
 }
-
-void show_stack(struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_INFO);
-}
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 11cdb16311e1..ece76ed129b3 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -196,8 +196,7 @@ static void show_stacktrace(struct task_struct *task,
 	show_backtrace(task, regs, loglvl);
 }
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
 	struct pt_regs regs;
 	mm_segment_t old_fs = get_fs();
@@ -230,11 +229,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
 	set_fs(old_fs);
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_DEFAULT)
-}
-
 static void show_code(unsigned int __user *pc)
 {
 	long i;
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 90f12582c218..6a9772ba7392 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -135,8 +135,7 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg,
 	printk("%s\n", loglvl);
 }
 
-void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 {
 	unsigned long *base_reg;
 
@@ -157,11 +156,6 @@ void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
 	barrier();
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
-{
-	show_stack_loglvl(tsk, sp, KERN_EMERG);
-}
-
 DEFINE_SPINLOCK(die_lock);
 
 /*
diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index 08071caa9b36..b172da4eb1a9 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -52,14 +52,13 @@ void _exception(int signo, struct pt_regs *regs, int code, unsigned long addr)
 }
 
 /*
- * The show_stack(), show_stack_loglvl() are external API
- * which we do not use ourselves.
+ * The show_stack() is external API which we do not use ourselves.
  */
 
 int kstack_depth_to_print = 48;
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *stack,
+		const char *loglvl)
 {
 	unsigned long *endstack, addr;
 	int i;
@@ -106,11 +105,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
 	printk("%s\n", loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
-{
-	show_stack_loglvl(task, stack, KERN_EMERG);
-}
-
 void __init trap_init(void)
 {
 	/* Nothing to do here */
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 9d5a85dd1992..97163815bbc5 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -48,8 +48,7 @@ void print_trace(void *data, unsigned long addr, int reliable)
 }
 
 /* displays a short stack trace */
-void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
-		const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *esp, const char *loglvl)
 {
 	if (esp == NULL)
 		esp = (unsigned long *)&esp;
@@ -58,11 +57,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
 	unwind_stack((void *)loglvl, esp, print_trace);
 }
 
-void show_stack(struct task_struct *task, unsigned long *esp)
-{
-	show_stack_loglvl(task, esp, KERN_EMERG);
-}
-
 void show_trace_task(struct task_struct *tsk)
 {
 	/*
@@ -111,7 +105,7 @@ void show_registers(struct pt_regs *regs)
 	if (in_kernel) {
 
 		printk("\nStack: ");
-		show_stack(NULL, (unsigned long *)esp);
+		show_stack(NULL, (unsigned long *)esp, KERN_EMERG);
 
 		printk("\nCode: ");
 		if (regs->pc < PAGE_OFFSET)
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index c2411de3730f..0a89899f154a 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -198,17 +198,11 @@ static void parisc_show_stack(struct task_struct *task,
 	do_show_stack(&info, loglvl);
 }
 
-void show_stack_loglvl(struct task_struct *t, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *t, unsigned long *sp, const char *loglvl)
 {
 	parisc_show_stack(t, NULL, loglvl);
 }
 
-void show_stack(struct task_struct *t, unsigned long *sp)
-{
-	show_stack_loglvl(t, sp, KERN_CRIT)
-}
-
 int is_valid_bugaddr(unsigned long iaoq)
 {
 	return 1;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 34b46680a196..b37bc12b072b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1431,7 +1431,7 @@ void show_regs(struct pt_regs * regs)
 	printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
 	printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
 #endif
-	show_stack(current, (unsigned long *) regs->gpr[1]);
+	show_stack(current, (unsigned long *) regs->gpr[1], KERN_DEFAULT);
 	if (!user_mode(regs))
 		show_instructions(regs);
 }
@@ -2028,8 +2028,8 @@ unsigned long get_wchan(struct task_struct *p)
 
 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
-void show_stack_loglvl(struct task_struct *tsk, unsigned long *stack,
-		       const char *loglvl)
+void show_stack(struct task_struct *tsk, unsigned long *stack,
+		const char *loglvl)
 {
 	unsigned long sp, ip, lr, newsp;
 	int count = 0;
@@ -2098,11 +2098,6 @@ void show_stack_loglvl(struct task_struct *tsk, unsigned long *stack,
 	put_task_stack(tsk);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *stack)
-{
-	show_stack_loglvl(tsk, stack, KERN_DEFAULT);
-}
-
 #ifdef CONFIG_PPC64
 /* Called with hard IRQs off */
 void notrace __ppc64_runlatch_on(void)
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index e2a46cfed5fd..5efef8f35ad3 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -260,7 +260,7 @@ static void raise_backtrace_ipi(cpumask_t *mask)
 			pr_cont(" current pointer corrupt? (%px)\n", p->__current);
 
 		pr_warn("Back trace of paca->saved_r1 (0x%016llx) (possibly stale):\n", p->saved_r1);
-		show_stack(p->__current, (unsigned long *)p->saved_r1);
+		show_stack(p->__current, (unsigned long *)p->saved_r1, KERN_WARNING);
 	}
 }
 
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 5b414ba9848b..7d60aa44598e 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -104,18 +104,12 @@ static bool print_trace_address(unsigned long pc, void *arg)
 	return false;
 }
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
 	pr_cont("Call Trace:\n");
 	walk_stackframe(task, NULL, print_trace_address, (void *)loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_DEFAULT);
-}
-
 static bool save_wchan(unsigned long pc, void *arg)
 {
 	if (!in_sched_functions(pc)) {
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 1a89f0968742..1e383f7e0d3a 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -123,7 +123,7 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 	return -EINVAL;
 }
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+void show_stack(struct task_struct *task, unsigned long *stack,
 		       const char *loglvl)
 {
 	struct unwind_state state;
@@ -138,11 +138,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
 	debug_show_held_locks(task ? : current);
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
-{
-	show_stack_loglvl(task, stack, KERN_DEFAULT);
-}
-
 static void show_last_breaking_event(struct pt_regs *regs)
 {
 	printk("Last Breaking-Event-Address:\n");
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index cc51e9d74667..a13c045804ed 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -144,8 +144,7 @@ void show_trace(struct task_struct *tsk, unsigned long *sp,
 	debug_show_held_locks(tsk);
 }
 
-void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 {
 	unsigned long stack;
 
@@ -161,8 +160,3 @@ void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
 		 (unsigned long)task_stack_page(tsk));
 	show_trace(tsk, sp, NULL, loglvl);
 }
-
-void show_stack(struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_DEFAULT);
-}
diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index c2844a2e18cd..4c2144225c8e 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -275,13 +275,12 @@ void show_regs(struct pt_regs *regs)
 	 * If we're in kernel mode, dump the stack too..
 	 */
 	if (!user_mode(regs)) {
-		void show_stack(struct task_struct *tsk, unsigned long *sp);
 		unsigned long sp = regs->regs[15] & 0xffffffff;
 		struct task_struct *tsk = get_current();
 
 		tsk->thread.kregs = regs;
 
-		show_stack(tsk, (unsigned long *)sp);
+		show_stack(tsk, (unsigned long *)sp, KERN_DEFAULT);
 	}
 }
 
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index d2f3aea7b977..8d9831054e44 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -145,12 +145,10 @@ void show_regs(struct pt_regs *r)
 }
 
 /*
- * The show_stack(), show_stack_loglvl() are external APIs which
- * we do not use ourselves.
+ * The show_stack() is external API which we do not use ourselves.
  * The oops is printed in die_if_kernel.
  */
-void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
 	unsigned long pc, fp;
 	unsigned long task_base;
@@ -179,11 +177,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
 	printk("%s\n", loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_DEFAULT);
-}
-
 /*
  * Free current thread data structures etc..
  */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 4282116e28e7..b2e3fe729b7e 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -195,7 +195,7 @@ void show_regs(struct pt_regs *regs)
 	       regs->u_regs[15]);
 	printk("RPC: <%pS>\n", (void *) regs->u_regs[15]);
 	show_regwindow(regs);
-	show_stack(current, (unsigned long *) regs->u_regs[UREG_FP]);
+	show_stack(current, (unsigned long *)regs->u_regs[UREG_FP], KERN_DEFAULT);
 }
 
 union global_cpu_snapshot global_cpu_snapshot[NR_CPUS];
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 0117489e9b30..f16ed66ffadc 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -642,7 +642,7 @@ static void stack_proc(void *arg)
 {
 	struct task_struct *task = arg;
 
-	show_stack(task, NULL);
+	show_stack(task, NULL, KERN_INFO);
 }
 
 /*
diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 1b54b6431499..acbc879d2773 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -27,7 +27,7 @@ static const struct stacktrace_ops stackops = {
 	.address = _print_addr
 };
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+void show_stack(struct task_struct *task, unsigned long *stack,
 		       const char *loglvl)
 {
 	struct pt_regs *segv_regs = current->thread.segv_regs;
@@ -56,8 +56,3 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
 	dump_trace(current, &stackops, (void *)loglvl);
 	printk("%s\n", loglvl);
 }
-
-void show_stack(struct task_struct *task, unsigned long *stack)
-{
-	show_stack_loglvl(task, stack, KERN_INFO);
-}
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index 8b1335997f50..a3ac01df1a2e 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -167,18 +167,13 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		c_backtrace(fp, loglvl);
 }
 
-void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+void show_stack(struct task_struct *tsk, unsigned long *sp,
 		       const char *loglvl)
 {
 	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
-{
-	show_stack_loglvl(tsk, sp, KERN_DEFAULT)
-}
-
 static int __die(const char *str, int err, struct thread_info *thread,
 		struct pt_regs *regs)
 {
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 033503f394f7..4e11a199432a 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -159,7 +159,7 @@ static void dump_leak(void)
 		return;
 	dump = 1;
 
-	show_stack_loglvl(NULL, NULL, KERN_ERR);
+	show_stack(NULL, NULL, KERN_ERR);
 	debug_dma_dump_mappings(NULL);
 }
 #endif
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 940cd4c27b17..5c974462c087 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -279,7 +279,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+void show_stack(struct task_struct *task, unsigned long *sp,
 		       const char *loglvl)
 {
 	task = task ? : current;
@@ -294,11 +294,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
 	show_trace_log_lvl(task, NULL, sp, loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_DEFAULT);
-}
-
 void show_stack_regs(struct pt_regs *regs)
 {
 	show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index ba6c150095c6..791441c5ddaa 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -502,8 +502,7 @@ static void show_trace(struct task_struct *task, unsigned long *sp,
 
 static int kstack_depth_to_print = 24;
 
-void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
-		       const char *loglvl)
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
 	int i = 0;
 	unsigned long *stack;
@@ -524,11 +523,6 @@ void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
 	show_trace(task, stack, loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
-{
-	show_stack_loglvl(task, sp, KERN_INFO);
-}
-
 DEFINE_SPINLOCK(die_lock);
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -542,7 +536,7 @@ void die(const char * str, struct pt_regs * regs, long err)
 		IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "");
 	show_regs(regs);
 	if (!user_mode(regs))
-		show_stack(NULL, (unsigned long*)regs->areg[1]);
+		show_stack(NULL, (unsigned long *)regs->areg[1], KERN_INFO);
 
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irq(&die_lock);
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3f39c9524c4d..baf1aaaddb9f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -487,7 +487,7 @@ static void dpm_watchdog_handler(struct timer_list *t)
 	struct dpm_watchdog *wd = from_timer(wd, t, timer);
 
 	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
-	show_stack_loglvl(wd->tsk, NULL, KERN_EMERG);
+	show_stack(wd->tsk, NULL, KERN_EMERG);
 	panic("%s %s: unrecoverable failure\n",
 		dev_driver_string(wd->dev), dev_name(wd->dev));
 }
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index fc5f84fa5347..f9809bc7367d 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -220,7 +220,7 @@ static void showacpu(void *dummy)
 
 	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
-	show_stack_loglvl(NULL, NULL, KERN_INFO);
+	show_stack(NULL, NULL, KERN_INFO);
 	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index 373e4e3faf2a..00c45a0e6abe 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -30,9 +30,8 @@ extern void show_regs(struct pt_regs *);
  * task), SP is the stack pointer of the first frame that should be shown in the back
  * trace (or NULL if the entire call-chain of the task should be shown).
  */
-extern void show_stack(struct task_struct *task, unsigned long *sp);
-extern void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
-			      const char *loglvl);
+extern void show_stack(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl);
 
 extern void sched_show_task(struct task_struct *p);
 
diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 5ce1fe082a38..00ae3516af5b 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -24,15 +24,15 @@ static void kdb_show_stack(struct task_struct *p, void *addr)
 	kdb_trap_printk++;
 	kdb_set_current_task(p);
 	if (addr) {
-		show_stack_loglvl(p, addr, KERN_EMERG);
+		show_stack(p, addr, KERN_EMERG);
 	} else if (kdb_current_regs) {
 #ifdef CONFIG_X86
-		show_stack_loglvl(p, &kdb_current_regs->sp, KERN_EMERG);
+		show_stack(p, &kdb_current_regs->sp, KERN_EMERG);
 #else
-		show_stack_loglvl(p, NULL, KERN_EMERG);
+		show_stack(p, NULL, KERN_EMERG);
 #endif
 	} else {
-		show_stack_loglvl(p, NULL, KERN_EMERG);
+		show_stack(p, NULL, KERN_EMERG);
 	}
 	kdb_trap_printk--;
 }
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index 5e63d6e8a223..36e69100e8e0 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -125,7 +125,7 @@ void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter)
 
 	printk("\n%s/%d's [blocked] stackdump:\n\n",
 		task->comm, task_pid_nr(task));
-	show_stack_loglvl(task, NULL, KERN_DEFAULT);
+	show_stack(task, NULL, KERN_DEFAULT);
 	printk("\n%s/%d's [current] stackdump:\n\n",
 		current->comm, task_pid_nr(current));
 	dump_stack();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb50c70e73ea..6de0229f2e6e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5932,7 +5932,7 @@ void sched_show_task(struct task_struct *p)
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
-	show_stack_loglvl(p, NULL, KERN_INFO);
+	show_stack(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
 EXPORT_SYMBOL_GPL(sched_show_task);
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index efb8e651709d..54761a3d28db 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -74,7 +74,7 @@ void show_regs_print_info(const char *log_lvl)
 static void __dump_stack(void)
 {
 	dump_stack_print_info(KERN_DEFAULT);
-	show_stack_loglvl(NULL, NULL, KERN_DEFAULT);
+	show_stack(NULL, NULL, KERN_DEFAULT);
 }
 
 /**
-- 
2.23.0

