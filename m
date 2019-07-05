Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D578C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC8C20856
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qqcv+JAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfGENus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:50:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfGENur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3aOmf4wG24KSuD0s327KTluB/ek7l1O+tQrwGfYOZew=; b=Qqcv+JAC02xbIHnUp/YzYVXZn
        Y52cIwuqLCFJ1vfCSH+qgZZCZqVvQ59bTdj5E0Vlr750CU+DwFuVVzUK5lG7WGR5ueC6BMJKzoSyo
        XIfJPDL3K23uV+FIVk1L97gOhfI1iDTV+F0y8gcie3T1fU6j67uw3b22TyTrF2C5mWTqiact/Zk9T
        uWcmd/fTRDUKGavWhkiyMtEJIuG7elZTwr4s7V9DtY9Spx57emXs5IbBbxJRNDIGj/YKtkDNXB2oA
        PsUymVnOyEsWMpR00WxWSB9nBnR+t4vQ5YLxdQK43k0wCzq+b6RwvstoWnorCcturtLyshin8s/zx
        lX9b5z7pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjOax-0002Mf-Hq; Fri, 05 Jul 2019 13:49:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 112A120AF24BF; Fri,  5 Jul 2019 15:49:16 +0200 (CEST)
Date:   Fri, 5 Jul 2019 15:49:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190705134916.GU3402@hirez.programming.kicks-ass.net>
References: <20190704195555.580363209@infradead.org>
 <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:18:51AM +0900, Linus Torvalds wrote:
> On Fri, Jul 5, 2019 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Despire the current efforts to read CR2 before tracing happens there
> > still exist a number of possible holes:
> 
> So this whole series disturbs me for the simple reason that I thought
> tracing was supposed to save/restore cr2 and make it unnecessary to
> worry about this in non-tracing code.
> 
> That is very much what the NMI code explicitly does. Why shouldn't all
> the other tracing code do the same thing in case they can take page
> faults?
> 
> So I don't think the patches are wrong per se, but this seems to solve
> it at the wrong level.

My thinking is that that results in far too many sites which we have to
fix and a possibly fragility of interface. Invariably we'll get multiple
interface for the same thing, one which preserves CR2 and one which
doesn't -- in the name of performance. And then someone uses the wrong
one, and we're back where we started.

Conversely, this way we get to fix it in one place.

Also; all previous attempts at fixing this have been about pushing the
read_cr2() earlier; notably:

  0ac09f9f8cd1 ("x86, trace: Fix CR2 corruption when tracing page faults")
  d4078e232267 ("x86, trace: Further robustify CR2 handling vs tracing")

And I'm thinking that with exception of this patch, the rest are
worthwhile cleanups regardless.

Also; while looking at this, if we do continue with the C wrappers from
the very last patch, we can do horrible things like this on top and move
the read_cr2() back into C code.


--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -826,7 +826,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
 
-.macro idtentry_part do_sym, has_error_code:req, read_cr2:req, paranoid:req, shift_ist=-1, ist_offset=0
+.macro idtentry_part do_sym, has_error_code:req, paranoid:req, shift_ist=-1, ist_offset=0
 
 	.if \paranoid
 	call	paranoid_entry
@@ -836,10 +836,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	.endif
 	UNWIND_HINT_REGS
 
-	.if \read_cr2
-	GET_CR2_INTO(%rdx);			/* can clobber %rax */
-	.endif
-
 	.if \has_error_code
 	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
 	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
@@ -885,7 +881,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  *			fresh stack.  (This is for #DB, which has a nasty habit
  *			of recursing.)
  * @create_gap:		create a 6-word stack gap when coming from kernel mode.
- * @read_cr2:		load CR2 into the 3rd argument; done before calling any C code
  *
  * idtentry generates an IDT stub that sets up a usable kernel context,
  * creates struct pt_regs, and calls @do_sym.  The stub has the following
@@ -910,7 +905,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0 read_cr2=0
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -948,7 +943,7 @@ ENTRY(\sym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_part \do_sym, \has_error_code, \read_cr2, \paranoid, \shift_ist, \ist_offset
+	idtentry_part \do_sym, \has_error_code, \paranoid, \shift_ist, \ist_offset
 
 	.if \paranoid == 1
 	/*
@@ -957,7 +952,7 @@ ENTRY(\sym)
 	 * run in real process context if user_mode(regs).
 	 */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_part \do_sym, \has_error_code, \read_cr2, 0
+	idtentry_part \do_sym, \has_error_code, paranoid=0
 	.endif
 
 _ASM_NOKPROBE(\sym)
@@ -969,7 +964,7 @@ idtentry overflow			do_overflow			has_er
 idtentry bounds				do_bounds			has_error_code=0
 idtentry invalid_op			do_invalid_op			has_error_code=0
 idtentry device_not_available		do_device_not_available		has_error_code=0
-idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2 read_cr2=1
+idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2
 idtentry coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry invalid_TSS			do_invalid_TSS			has_error_code=1
 idtentry segment_not_present		do_segment_not_present		has_error_code=1
@@ -1142,10 +1137,10 @@ idtentry xenint3		do_int3			has_error_co
 #endif
 
 idtentry general_protection	do_general_protection	has_error_code=1
-idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
+idtentry page_fault		do_page_fault		has_error_code=1
 
 #ifdef CONFIG_KVM_GUEST
-idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
+idtentry async_page_fault	do_async_page_fault	has_error_code=1
 #endif
 
 #ifdef CONFIG_X86_MCE
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -22,20 +22,34 @@
 #define CALL_enter_from_user_mode(_regs)
 #endif
 
+#define __IDT_NR1 1
+#define __IDT_NR2 2
+#define __IDT_NR3 2
+
+#define IDT_NR(n) __IDT_NR##n
+
+#define __IDT_TRAP1(t1,a1)
+#define __IDT_TRAP2(t1,a1,t2,a2)
+#define __IDT_TRAP3(t1,a1,t2,a2,t3,a3)	t3 a3 = read_cr2()
+
+#define IDT_TRAP(n,...) __IDT_TRAP##n(__VA_ARGS__)
+
 #define IDTENTRYx(n, name, ...)	\
 	static notrace void __idt_##name(__IDT_MAP(n, __IDT_DECL, __VA_ARGS__)); \
 	NOKPROBE_SYMBOL(__idt_##name); \
-	dotraplinkage notrace void name(__IDT_MAP(n, __IDT_DECL, __VA_ARGS__)) \
+	dotraplinkage notrace void name(__IDT_MAP(__IDT_NR(n), __IDT_DECL, __VA_ARGS__)) \
 	{ \
 		__IDT_MAP(n, __IDT_TEST, __VA_ARGS__); \
+		__IDT_TRAP(n, __VA_ARGS__); \
 		trace_hardirqs_off(); \
 		CALL_enter_from_user_mode(regs); \
 		__idt_##name(__IDT_MAP(n, __IDT_ARGS, __VA_ARGS__)); \
 	} \
 	NOKPROBE_SYMBOL(name); \
-	dotraplinkage notrace void name##_paranoid(__IDT_MAP(n, __IDT_DECL, __VA_ARGS__)) \
+	dotraplinkage notrace void name##_paranoid(__IDT_MAP(__IDT_NR(n), __IDT_DECL, __VA_ARGS__)) \
 	{ \
 		__IDT_MAP(n, __IDT_TEST, __VA_ARGS__); \
+		__IDT_TRAP(n, __VA_ARGS__); \
 		trace_hardirqs_off(); \
 		__idt_##name(__IDT_MAP(n, __IDT_ARGS, __VA_ARGS__)); \
 	} \
