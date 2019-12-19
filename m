Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB38DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865B824683
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JSu+Ps3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLSL3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:29:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfLSL3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:29:51 -0500
Received: from zn.tnic (p200300EC2F0B1C0094E9BF90CF4CAA29.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:1c00:94e9:bf90:cf4c:aa29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 808131EC09F1;
        Thu, 19 Dec 2019 12:29:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576754985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYc4IVqGOwNMU6IvzgVfBVaX/x83qS0O9m9NnBeoH4M=;
        b=JSu+Ps3QDNRT34ureN82x4YBjigaZ9tO4i7xXgJPScANmG9yYyG+7PNJz6OT27zUBQo1Mf
        4Gon6wkzHAwhas/C5tNm/Y6bamWFhLl0yrkYT/zOTKUJN963FIjSBDzBabwAFj/HS5B1P1
        0bvr49lbWZHfWggP5UqKe5FxSahDqjc=
Date:   Thu, 19 Dec 2019 12:29:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 2/4] x86/traps: Print address on #GP
Message-ID: <20191219112940.GD32039@zn.tnic>
References: <20191211170632.GD14821@zn.tnic>
 <BC48F4AD-8330-4ED6-8BE8-254C835506A5@amacapital.net>
 <20191211172945.GE14821@zn.tnic>
 <CALCETrXuJMBawUy3DTQfE4qLb822d9491er9-hd971BtBsPFNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXuJMBawUy3DTQfE4qLb822d9491er9-hd971BtBsPFNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:17:25AM -0800, Andy Lutomirski wrote:
> On Wed, Dec 11, 2019 at 9:29 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Dec 11, 2019 at 09:22:30AM -0800, Andy Lutomirski wrote:
> > > Could we spare a few extra bytes to make this more readable?  I can never keep track of which number is the oops count, which is the cpu, and which is the error code.  How about:
> > >
> > > OOPS 1: general protection blah blah blah (CPU 0)
> > >
> > > and put in the next couple lines “#GP(0)”.
> >
> > Well, right now it is:
> >
> > [    2.470492] general protection fault, probably for non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
> > [    2.471615] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1+ #6
> >
> > and the CPU is on the second line, the error code is before the number -
> > [#1] - in that case.
> >
> > If we pull the number in front, we can do:
> >
> > [    2.470492] [#1] general protection fault, probably for non-canonical address 0xdfff000000000001: 0000 PREEMPT SMP
> > [    2.471615] [#1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1+ #6
> >
> > and this way you know that the error code is there, after the first
> > line's description.
> 
> Hmm, I like that.
> 
> >
> > I guess we can do:
> >
> > [    2.470492] [#1] general protection fault, probably for non-canonical address 0xdfff000000000001 Error Code: 0000 PREEMPT SMP
> >
> > to make it even more explicit...
> 
> I like this too.

Ok, let me add Linus too because I'm sure he would have an opinion here.

@Linus, the idea is to dump the die_counter in front of the oops for two
reasons:

1. It always has been absolutely important to know which the first oops
is.

2. Fuzzing and all those other tools scanning dmesg would not need to
make any adjustments anymore to their grepping regexes because oops
lines would be marked uniquely now.

Here's a first attempt, what do you guys think?

WIP diff follows too.

...
[    3.207442] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    3.209464] Freeing unused kernel image (rodata/data gap) memory: 168K
[    3.221088] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.221885] [0] general protection fault: 0000  PREEMPT SMP
[    3.222590] [0] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc2+ #16
[    3.223388] [0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    3.224374] [0] RIP: 0010:kernel_init+0x58/0x107
[    3.224727] [0] Code: 48 c7 c7 c8 74 ea 81 e8 4b 47 8f ff c7 05 c7 b3 95 00 02 00 00 00 e8 4e cd a0 ff e8 b9 2d 90 ff 48 b8 00 00 00 00 00 00 ff df <ff> e0 48 8b 3d 4e 74 d5 00 48 85 ff 74 22 e8 1b f3 82 ff 85 c0 89
[    3.224727] [0] RSP: 0018:ffffc90000013f50 EFLAGS: 00010246[0] 
[    3.224727] [0] RAX: dfff000000000000 RBX: ffffffff817d1b79 RCX: 0000000080aa00a9
[    3.224727] [0] RDX: 0000000080aa00aa RSI: 0000000000000001 RDI: ffff88807d406f00
[    3.224727] [0] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[    3.224727] [0] R10: 0000000000000001 R11: ffff88807d526d80 R12: 0000000000000000
[    3.224727] [0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    3.224727] [0] FS:  0000000000000000(0000) GS:ffff88807da40000(0000) knlGS:0000000000000000
[    3.224727] [0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.224727] [0] CR2: 0000000000000000 CR3: 0000000002009000 CR4: 00000000003406e0
[    3.224727] [0] Call Trace:
[    3.224727] [0] ret_from_fork+0x22/0x40
[    3.224727] [0] Modules linked in:
[    3.236790] ---[ end trace ef40186b3f9be0f1 ]---
[    3.237430] [0] RIP: 0010:kernel_init+0x58/0x107
[    3.238083] [0] Code: 48 c7 c7 c8 74 ea 81 e8 4b 47 8f ff c7 05 c7 b3 95 00 02 00 00 00 e8 4e cd a0 ff e8 b9 2d 90 ff 48 b8 00 00 00 00 00 00 ff df <ff> e0 48 8b 3d 4e 74 d5 00 48 85 ff 74 22 e8 1b f3 82 ff 85 c0 89
[    3.240176] [0] RSP: 0018:ffffc90000013f50 EFLAGS: 00010246[0] 
[    3.240950] [0] RAX: dfff000000000000 RBX: ffffffff817d1b79 RCX: 0000000080aa00a9
[    3.242486] [0] RDX: 0000000080aa00aa RSI: 0000000000000001 RDI: ffff88807d406f00
[    3.243389] [0] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[    3.244283] [0] R10: 0000000000000001 R11: ffff88807d526d80 R12: 0000000000000000
[    3.245190] [0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    3.246056] [0] FS:  0000000000000000(0000) GS:ffff88807da40000(0000) knlGS:0000000000000000
[    3.246993] [0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.247750] [0] CR2: 0000000000000000 CR3: 0000000002009000 CR4: 00000000003406e0
[    3.248642] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    3.249180] Kernel Offset: disabled
[    3.249180] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


---
diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index 75f1e35e7c15..952f0d786bbf 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -35,7 +35,7 @@ enum show_regs_mode {
 extern void die(const char *, struct pt_regs *,long);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
-extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
+extern void __show_regs(struct pt_regs *regs, enum show_regs_mode, unsigned int die_counter);
 extern void show_iret_regs(struct pt_regs *regs);
 extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 14db05086bbf..4634852f0536 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -86,9 +86,6 @@ get_stack_pointer(struct task_struct *task, struct pt_regs *regs)
 	return (unsigned long *)task->thread.sp;
 }
 
-void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, char *log_lvl);
-
 /* The form of the top of the frame on the stack */
 struct stack_frame {
 	struct stack_frame *next_frame;
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index e07424e19274..0058a02d6c54 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -25,7 +25,7 @@
 
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
-static int die_counter;
+static unsigned int die_counter;
 
 static struct pt_regs exec_summary_regs;
 
@@ -68,7 +68,8 @@ static void printk_stack_address(unsigned long address, int reliable,
 				 char *log_lvl)
 {
 	touch_nmi_watchdog();
-	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
+	printk("%s[%d] %s%pB\n", log_lvl, die_counter, reliable ? "" : "? ",
+	       (void *)address);
 }
 
 /*
@@ -108,10 +109,10 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 
 	if (bad_ip || probe_kernel_read(opcodes, (u8 *)prologue,
 					OPCODE_BUFSIZE)) {
-		printk("%sCode: Bad RIP value.\n", loglvl);
+		printk("%s[%d] Code: Bad RIP value.\n", loglvl, die_counter);
 	} else {
-		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
-		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
+		printk("%s[%d] Code: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
+		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, die_counter, opcodes,
 		       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
 	}
 }
@@ -119,9 +120,9 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 void show_ip(struct pt_regs *regs, const char *loglvl)
 {
 #ifdef CONFIG_X86_32
-	printk("%sEIP: %pS\n", loglvl, (void *)regs->ip);
+	printk("%s[%d] EIP: %pS\n", loglvl, die_counter, (void *)regs->ip);
 #else
-	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
+	printk("%s[%d] RIP: %04x:%pS\n", loglvl, die_counter, (int)regs->cs, (void *)regs->ip);
 #endif
 	show_opcodes(regs, loglvl);
 }
@@ -129,8 +130,8 @@ void show_ip(struct pt_regs *regs, const char *loglvl)
 void show_iret_regs(struct pt_regs *regs)
 {
 	show_ip(regs, KERN_DEFAULT);
-	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
-		regs->sp, regs->flags);
+	printk(KERN_DEFAULT "[%d] RSP: %04x:%016lx EFLAGS: %08lx",
+		die_counter, (int)regs->ss, regs->sp, regs->flags);
 }
 
 static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
@@ -146,7 +147,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	 * they can be printed in the right context.
 	 */
 	if (!partial && on_stack(info, regs, sizeof(*regs))) {
-		__show_regs(regs, SHOW_REGS_SHORT);
+		__show_regs(regs, SHOW_REGS_SHORT, die_counter);
 
 	} else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
 				       IRET_FRAME_SIZE)) {
@@ -159,8 +160,8 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	}
 }
 
-void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, char *log_lvl)
+static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
+			       unsigned long *stack, char *log_lvl)
 {
 	struct unwind_state state;
 	struct stack_info stack_info = {0};
@@ -168,7 +169,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	int graph_idx = 0;
 	bool partial = false;
 
-	printk("%sCall Trace:\n", log_lvl);
+	printk("%s[%d] Call Trace:\n", log_lvl, die_counter);
 
 	unwind_start(&state, task, regs, stack);
 	stack = stack ? : get_stack_pointer(task, regs);
@@ -207,7 +208,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 
 		stack_name = stack_type_name(stack_info.type);
 		if (stack_name)
-			printk("%s <%s>\n", log_lvl, stack_name);
+			printk("%s[%d] <%s>\n", log_lvl, die_counter, stack_name);
 
 		if (regs)
 			show_regs_if_on_stack(&stack_info, regs, partial);
@@ -275,7 +276,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		}
 
 		if (stack_name)
-			printk("%s </%s>\n", log_lvl, stack_name);
+			printk("%s[%d] </%s>\n", log_lvl, die_counter, stack_name);
 	}
 }
 
@@ -344,7 +345,9 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	oops_exit();
 
 	/* Executive summary in case the oops scrolled away */
-	__show_regs(&exec_summary_regs, SHOW_REGS_ALL);
+	__show_regs(&exec_summary_regs, SHOW_REGS_ALL, die_counter);
+
+	die_counter++;
 
 	if (!signr)
 		return;
@@ -368,6 +371,7 @@ NOKPROBE_SYMBOL(oops_end);
 int __die(const char *str, struct pt_regs *regs, long err)
 {
 	const char *pr = "";
+	char pfx[5] = { };
 
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
@@ -377,7 +381,7 @@ int __die(const char *str, struct pt_regs *regs, long err)
 		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	printk(KERN_DEFAULT
-	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
+	       "[%d] %s: %04lx %s%s%s%s%s\n", die_counter, str, err & 0xffff,
 	       pr,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
@@ -385,8 +389,10 @@ int __die(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
 
+	snprintf(pfx, sizeof(pfx), "[%d] ", die_counter);
+
 	show_regs(regs);
-	print_modules();
+	print_modules(pfx);
 
 	if (notify_die(DIE_OOPS, str, regs, err,
 			current->thread.trap_nr, SIGSEGV) == NOTIFY_STOP)
@@ -412,9 +418,13 @@ void die(const char *str, struct pt_regs *regs, long err)
 
 void show_regs(struct pt_regs *regs)
 {
-	show_regs_print_info(KERN_DEFAULT);
+	char prf[5] = { };
+
+	snprintf(prf, sizeof(prf), "%s[%d] ", KERN_DEFAULT, die_counter);
+
+	show_regs_print_info(prf);
 
-	__show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
+	__show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL, die_counter);
 
 	/*
 	 * When in-kernel, we also print out the stack at the time of the fault..
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 506d66830d4d..83422efb5a4a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -64,7 +64,8 @@
 #include "process.h"
 
 /* Prints also some state that isn't saved in the pt_regs */
-void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
+		 unsigned int die_counter)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L, fs, gs, shadowgs;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -74,20 +75,20 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	show_iret_regs(regs);
 
 	if (regs->orig_ax != -1)
-		pr_cont(" ORIG_RAX: %016lx\n", regs->orig_ax);
+		pr_cont("[%d] ORIG_RAX: %016lx\n", die_counter, regs->orig_ax);
 	else
-		pr_cont("\n");
-
-	printk(KERN_DEFAULT "RAX: %016lx RBX: %016lx RCX: %016lx\n",
-	       regs->ax, regs->bx, regs->cx);
-	printk(KERN_DEFAULT "RDX: %016lx RSI: %016lx RDI: %016lx\n",
-	       regs->dx, regs->si, regs->di);
-	printk(KERN_DEFAULT "RBP: %016lx R08: %016lx R09: %016lx\n",
-	       regs->bp, regs->r8, regs->r9);
-	printk(KERN_DEFAULT "R10: %016lx R11: %016lx R12: %016lx\n",
-	       regs->r10, regs->r11, regs->r12);
-	printk(KERN_DEFAULT "R13: %016lx R14: %016lx R15: %016lx\n",
-	       regs->r13, regs->r14, regs->r15);
+		pr_cont("[%d] \n", die_counter);
+
+	printk(KERN_DEFAULT "[%d] RAX: %016lx RBX: %016lx RCX: %016lx\n",
+	       die_counter, regs->ax, regs->bx, regs->cx);
+	printk(KERN_DEFAULT "[%d] RDX: %016lx RSI: %016lx RDI: %016lx\n",
+	       die_counter, regs->dx, regs->si, regs->di);
+	printk(KERN_DEFAULT "[%d] RBP: %016lx R08: %016lx R09: %016lx\n",
+	       die_counter,regs->bp, regs->r8, regs->r9);
+	printk(KERN_DEFAULT "[%d] R10: %016lx R11: %016lx R12: %016lx\n",
+	       die_counter, regs->r10, regs->r11, regs->r12);
+	printk(KERN_DEFAULT "[%d] R13: %016lx R14: %016lx R15: %016lx\n",
+	       die_counter, regs->r13, regs->r14, regs->r15);
 
 	if (mode == SHOW_REGS_SHORT)
 		return;
@@ -95,8 +96,8 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	if (mode == SHOW_REGS_USER) {
 		rdmsrl(MSR_FS_BASE, fs);
 		rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
-		printk(KERN_DEFAULT "FS:  %016lx GS:  %016lx\n",
-		       fs, shadowgs);
+		printk(KERN_DEFAULT "[%d] FS:  %016lx GS:  %016lx\n",
+		       die_counter, fs, shadowgs);
 		return;
 	}
 
@@ -114,12 +115,12 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	cr3 = __read_cr3();
 	cr4 = __read_cr4();
 
-	printk(KERN_DEFAULT "FS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
-	       fs, fsindex, gs, gsindex, shadowgs);
-	printk(KERN_DEFAULT "CS:  %04lx DS: %04x ES: %04x CR0: %016lx\n", regs->cs, ds,
-			es, cr0);
-	printk(KERN_DEFAULT "CR2: %016lx CR3: %016lx CR4: %016lx\n", cr2, cr3,
-			cr4);
+	printk(KERN_DEFAULT "[%d] FS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
+	       die_counter, fs, fsindex, gs, gsindex, shadowgs);
+	printk(KERN_DEFAULT "[%d] CS:  %04lx DS: %04x ES: %04x CR0: %016lx\n",
+	       die_counter, regs->cs, ds, es, cr0);
+	printk(KERN_DEFAULT "[%d] CR2: %016lx CR3: %016lx CR4: %016lx\n",
+	       die_counter, cr2, cr3, cr4);
 
 	get_debugreg(d0, 0);
 	get_debugreg(d1, 1);
@@ -131,14 +132,14 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	/* Only print out debug registers if they are in their non-default state. */
 	if (!((d0 == 0) && (d1 == 0) && (d2 == 0) && (d3 == 0) &&
 	    (d6 == DR6_RESERVED) && (d7 == 0x400))) {
-		printk(KERN_DEFAULT "DR0: %016lx DR1: %016lx DR2: %016lx\n",
-		       d0, d1, d2);
-		printk(KERN_DEFAULT "DR3: %016lx DR6: %016lx DR7: %016lx\n",
-		       d3, d6, d7);
+		printk(KERN_DEFAULT "[%d] DR0: %016lx DR1: %016lx DR2: %016lx\n",
+		       die_counter, d0, d1, d2);
+		printk(KERN_DEFAULT "[%d] DR3: %016lx DR6: %016lx DR7: %016lx\n",
+		       die_counter, d3, d6, d7);
 	}
 
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		printk(KERN_DEFAULT "PKRU: %08x\n", read_pkru());
+		printk(KERN_DEFAULT "[%d] PKRU: %08x\n", die_counter, read_pkru());
 }
 
 void release_thread(struct task_struct *dead_task)
diff --git a/arch/x86/um/sysrq_64.c b/arch/x86/um/sysrq_64.c
index 903ad91b624f..62f0ecc2643f 100644
--- a/arch/x86/um/sysrq_64.c
+++ b/arch/x86/um/sysrq_64.c
@@ -16,7 +16,7 @@
 void show_regs(struct pt_regs *regs)
 {
 	printk("\n");
-	print_modules();
+	print_modules("");
 	printk(KERN_INFO "Pid: %d, comm: %.20s %s %s\n", task_pid_nr(current),
 		current->comm, print_tainted(), init_utsname()->release);
 	printk(KERN_INFO "RIP: %04lx:[<%016lx>]\n", PT_REGS_CS(regs) & 0xffff,
diff --git a/include/linux/module.h b/include/linux/module.h
index 0c7366c317bd..e83a467e7b9c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -665,7 +665,7 @@ int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned
 int register_module_notifier(struct notifier_block *nb);
 int unregister_module_notifier(struct notifier_block *nb);
 
-extern void print_modules(void);
+extern void print_modules(const char *pfx);
 
 static inline bool module_requested_async_probing(struct module *module)
 {
@@ -809,7 +809,7 @@ static inline int unregister_module_notifier(struct notifier_block *nb)
 
 #define module_put_and_exit(code) do_exit(code)
 
-static inline void print_modules(void)
+static inline void print_modules(const char *pfx)
 {
 }
 
diff --git a/init/main.c b/init/main.c
index f9d9701d600c..890208fa7430 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1127,6 +1127,9 @@ static int __ref kernel_init(void *unused)
 
 	rcu_end_inkernel_boot();
 
+	asm volatile("mov $0xdfff000000000000, %rax\n\t"
+		     "jmpq *%rax\n\t");
+
 	if (ramdisk_execute_command) {
 		ret = run_init_process(ramdisk_execute_command);
 		if (!ret)
diff --git a/kernel/module.c b/kernel/module.c
index ac058a5ad1d1..9d73718ce30b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4476,12 +4476,12 @@ struct module *__module_text_address(unsigned long addr)
 EXPORT_SYMBOL_GPL(__module_text_address);
 
 /* Don't grab lock, we're oopsing. */
-void print_modules(void)
+void print_modules(const char *pfx)
 {
 	struct module *mod;
 	char buf[MODULE_FLAGS_BUF_SIZE];
 
-	printk(KERN_DEFAULT "Modules linked in:");
+	printk(KERN_DEFAULT "%sModules linked in:", pfx);
 	/* Most callers should already have preempt disabled, but make sure */
 	preempt_disable();
 	list_for_each_entry_rcu(mod, &modules, list) {
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..056b6448fec0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -582,7 +582,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 		panic("panic_on_warn set ...\n");
 	}
 
-	print_modules();
+	print_modules("");
 
 	if (regs)
 		show_regs(regs);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15508c202bf5..fda7ce233344 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3853,7 +3853,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 		prev->comm, prev->pid, preempt_count());
 
 	debug_show_held_locks(prev);
-	print_modules();
+	print_modules("");
 	if (irqs_disabled())
 		print_irqtrace_events(prev);
 	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334ef0971..597ce03f9f2c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -448,7 +448,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
 		__this_cpu_write(softlockup_task_ptr_saved, current);
-		print_modules();
+		print_modules("");
 		print_irqtrace_events(current);
 		if (regs)
 			show_regs(regs);
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..76aa96a01b10 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -137,7 +137,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 
 		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
 			 this_cpu);
-		print_modules();
+		print_modules("");
 		print_irqtrace_events(current);
 		if (regs)
 			show_regs(regs);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4785a8a2040e..f71d639e0032 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -645,7 +645,7 @@ static void bad_page(struct page *page, const char *reason,
 						bad_flags, &bad_flags);
 	dump_page_owner(page);
 
-	print_modules();
+	print_modules("");
 	dump_stack();
 out:
 	/* Leave bad fields for debug, except PageBuddy could make trouble */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
