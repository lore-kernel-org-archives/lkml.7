Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10249C5DF61
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59D1222C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YHgqLF/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfKFDG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40936 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbfKFDG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so17713910pfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBtxih23xWrgcRmf1jKFKRXIiDXyNW7ostp5IRFGwGg=;
        b=YHgqLF/xf0UfV56unVpiD7gs58hGrp5nU7zsBUKicmNd+VCnpD1Smm1JT0NFvwwYmh
         sbNt65jdDRLxtA9uG85IVtWgRSJIe45kuDbhTiQF8jFVxUEz3iq0Syw+EBrMd3NOLga4
         hJE2UxaVEH8ZBFR4f7HCE7c6xOxCtR4jLj446GcXnaS6oCmpJPpNyQwew64qjAu8gv2G
         GCoTuMcAU0iuqFbhRNKPIhN2zQVNrucMPXI1a2tjJJW+IQFUUZfPiltyCJAAY6PWAzZ9
         WY0GHQMeb2DA1hx6641aebmUQjrONvPwfIC/s7C9UQhPYv5/qBs2eqEOPgeP6/MsxyNU
         J+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBtxih23xWrgcRmf1jKFKRXIiDXyNW7ostp5IRFGwGg=;
        b=DrL3BFjHBEO7cfmwOt66HlDaImlJHJ1zlb80p5fk6aIHj3lqRVHMfQor2FG/sohcI9
         KziwrxK9aza1mkLR5f8oNLk8oLeA2xoWeWjzrlOr99nOUCutomLg06OlzNE3FDX04QO4
         6aJ9PqnZ3bznQ1P2QDK0V+ctDSm7OapQE76bRxuelxCH2xJEP2CHtiaEQxMSv2dRiTbY
         Xhos+nxg/vPVGsX+BPoG1srly8t2sIt/Y8YzesbgfnOpeM50pJsQTnqQlgZwVeGqOuX5
         uLX3wpgjcLdvFaj1qU5gLmSMFwdlM5BsXwXHPjyPfUZM1NKl5zQkv6n5qZYxgu9jbA7l
         kqfg==
X-Gm-Message-State: APjAAAUbm3i6o1rPddfohaKiBNGolha3GSfmvQYvv7xZDg1g6CTd/kZp
        f2WaWD9n0QCSrjsbnUdiCgJ1EfxvtEQ=
X-Google-Smtp-Source: APXvYqwGXT2UHNWFnuY01bYCY/ThDRYp5oUVdZdP80+BlNvF2mPcn9yXz3RJrA4HPh9kgHhIoFpvIg==
X-Received: by 2002:a65:49c7:: with SMTP id t7mr155165pgs.431.1573009584201;
        Tue, 05 Nov 2019 19:06:24 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:23 -0800 (PST)
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
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH 04/50] arm/asm: Add loglvl to c_backtrace()
Date:   Wed,  6 Nov 2019 03:04:55 +0000
Message-Id: <20191106030542.868541-5-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Add log level argument to c_backtrace() as a preparation for introducing
show_stack_loglvl().

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/include/asm/bug.h     |  3 ++-
 arch/arm/include/asm/traps.h   |  3 ++-
 arch/arm/kernel/traps.c        |  9 +++++----
 arch/arm/kernel/unwind.c       |  2 +-
 arch/arm/lib/backtrace-clang.S |  9 +++++++--
 arch/arm/lib/backtrace.S       | 14 ++++++++++----
 6 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index deef4d0cb3b5..673c7dd75ab9 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -82,7 +82,8 @@ void hook_ifault_code(int nr, int (*fn)(unsigned long, unsigned int,
 				       struct pt_regs *),
 		     int sig, int code, const char *name);
 
-extern asmlinkage void c_backtrace(unsigned long fp, int pmode);
+extern asmlinkage void c_backtrace(unsigned long fp, int pmode,
+				   const char *loglvl);
 
 struct mm_struct;
 void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr);
diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 172b08ff3760..987fefb0a4db 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -29,7 +29,8 @@ static inline int __in_irqentry_text(unsigned long ptr)
 }
 
 extern void __init early_trap_init(void *);
-extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
+extern void dump_backtrace_entry(unsigned long where, unsigned long from,
+				 unsigned long frame, const char *loglvl);
 extern void ptrace_break(struct pt_regs *regs);
 
 extern void *vectors_page;
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index c053abd1fb53..7c3f32b26585 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -62,7 +62,8 @@ __setup("user_debug=", user_debug_setup);
 
 static void dump_mem(const char *, const char *, unsigned long, unsigned long);
 
-void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame)
+void dump_backtrace_entry(unsigned long where, unsigned long from,
+			  unsigned long frame, const char *loglvl)
 {
 #ifdef CONFIG_KALLSYMS
 	printk("[<%08lx>] (%ps) from [<%08lx>] (%pS)\n", where, (void *)where, from, (void *)from);
@@ -74,7 +75,7 @@ void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long
 		dump_mem("", "Exception stack", frame + 4, frame + 4 + sizeof(struct pt_regs));
 }
 
-void dump_backtrace_stm(u32 *stack, u32 instruction)
+void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
 {
 	char str[80], *p;
 	unsigned int x;
@@ -236,7 +237,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	pr_cont("\n");
 
 	if (ok)
-		c_backtrace(fp, mode);
+		c_backtrace(fp, mode, NULL);
 }
 #endif
 
@@ -662,7 +663,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 		dump_instr("", regs);
 		if (user_mode(regs)) {
 			__show_regs(regs);
-			c_backtrace(frame_pointer(regs), processor_mode(regs));
+			c_backtrace(frame_pointer(regs), processor_mode(regs), NULL);
 		}
 	}
 #endif
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 4574e6aea0a5..0a65005e10f0 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -493,7 +493,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		urc = unwind_frame(&frame);
 		if (urc < 0)
 			break;
-		dump_backtrace_entry(where, frame.pc, frame.sp - 4);
+		dump_backtrace_entry(where, frame.pc, frame.sp - 4, NULL);
 	}
 }
 
diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
index 2ff375144b55..6174c45f53a5 100644
--- a/arch/arm/lib/backtrace-clang.S
+++ b/arch/arm/lib/backtrace-clang.S
@@ -17,6 +17,7 @@
 #define sv_pc	r6
 #define mask	r7
 #define sv_lr	r8
+#define loglvl	r9
 
 ENTRY(c_backtrace)
 
@@ -99,6 +100,7 @@ ENDPROC(c_backtrace)
 						@ to ensure 8 byte alignment
 		movs	frame, r0		@ if frame pointer is zero
 		beq	no_frame		@ we have no stack frames
+		mov	loglvl, r2
 		tst	r1, #0x10		@ 26 or 32-bit mode?
 		moveq	mask, #0xfc000003
 		movne	mask, #0		@ mask for 32-bit
@@ -167,6 +169,7 @@ finished_setup:
 		mov	r1, sv_lr
 		mov	r2, frame
 		bic	r1, r1, mask		@ mask PC/LR for the mode
+		mov	r3, loglvl
 		bl	dump_backtrace_entry
 
 /*
@@ -183,6 +186,7 @@ finished_setup:
 		ldr	r0, [frame]		@ locals are stored in
 						@ the preceding frame
 		subeq	r0, r0, #4
+		mov	r2, loglvl
 		bleq	dump_backtrace_stm	@ dump saved registers
 
 /*
@@ -196,7 +200,8 @@ finished_setup:
 		bhi	for_each_frame
 
 1006:		adr	r0, .Lbad
-		mov	r1, frame
+		mov	r1, loglvl
+		mov	r2, frame
 		bl	printk
 no_frame:	ldmfd	sp!, {r4 - r9, fp, pc}
 ENDPROC(c_backtrace)
@@ -209,7 +214,7 @@ ENDPROC(c_backtrace)
 		.long   1005b, 1006b
 		.popsection
 
-.Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
+.Lbad:		.asciz	"%sBacktrace aborted due to bad frame pointer <%p>\n"
 		.align
 .Lopcode:	.word	0xe92d4800 >> 11	@ stmfd sp!, {... fp, lr}
 		.word	0x0b000000		@ bl if these bits are set
diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index 582925238d65..872f658638d9 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -18,6 +18,7 @@
 #define sv_pc	r6
 #define mask	r7
 #define offset	r8
+#define loglvl	r9
 
 ENTRY(c_backtrace)
 
@@ -25,9 +26,10 @@ ENTRY(c_backtrace)
 		ret	lr
 ENDPROC(c_backtrace)
 #else
-		stmfd	sp!, {r4 - r8, lr}	@ Save an extra register so we have a location...
+		stmfd	sp!, {r4 - r9, lr}	@ Save an extra register so we have a location...
 		movs	frame, r0		@ if frame pointer is zero
 		beq	no_frame		@ we have no stack frames
+		mov	loglvl, r2
 
 		tst	r1, #0x10		@ 26 or 32-bit mode?
  ARM(		moveq	mask, #0xfc000003	)
@@ -73,6 +75,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		ldr	r1, [frame, #-4]	@ get saved lr
 		mov	r2, frame
 		bic	r1, r1, mask		@ mask PC/LR for the mode
+		mov	r3, loglvl
 		bl	dump_backtrace_entry
 
 		ldr	r1, [sv_pc, #-4]	@ if stmfd sp!, {args} exists,
@@ -80,12 +83,14 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		teq	r3, r1, lsr #11
 		ldreq	r0, [frame, #-8]	@ get sp
 		subeq	r0, r0, #4		@ point at the last arg
+		mov	r2, loglvl
 		bleq	dump_backtrace_stm	@ dump saved registers
 
 1004:		ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, ip, lr, pc}
 		ldr	r3, .Ldsi		@ instruction exists,
 		teq	r3, r1, lsr #11
 		subeq	r0, frame, #16
+		mov	r2, loglvl
 		bleq	dump_backtrace_stm	@ dump saved registers
 
 		teq	sv_fp, #0		@ zero saved fp means
@@ -96,9 +101,10 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		bhi	for_each_frame
 
 1006:		adr	r0, .Lbad
-		mov	r1, frame
+		mov	r1, loglvl
+		mov	r2, frame
 		bl	printk
-no_frame:	ldmfd	sp!, {r4 - r8, pc}
+no_frame:	ldmfd	sp!, {r4 - r9, pc}
 ENDPROC(c_backtrace)
 		
 		.pushsection __ex_table,"a"
@@ -109,7 +115,7 @@ ENDPROC(c_backtrace)
 		.long	1004b, 1006b
 		.popsection
 
-.Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
+.Lbad:		.asciz	"%sBacktrace aborted due to bad frame pointer <%p>\n"
 		.align
 .Ldsi:		.word	0xe92dd800 >> 11	@ stmfd sp!, {... fp, ip, lr, pc}
 		.word	0xe92d0000 >> 11	@ stmfd sp!, {}
-- 
2.23.0

