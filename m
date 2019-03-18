Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25653C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BE820989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SqJlOsEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCRRhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:37:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfCRRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8aD9+1W3V5mx6TORDEEgq4CgOe+FDRE1sNncKkZvLXM=; b=SqJlOsEtqkNQbSIzFikfwRG7J
        NaNIRHTGFD3ED4ADeT3AJ3WeuFiEqViIf6/WufbHcpu9oMEvT+sjHT8fAWPAG5nUUxRWge4dfNs0S
        b3PF4oYhKkeTHI4OC1AT30PyGcrD4n1Aiv8Qdtj4obphbl/EToE7WmgNmP65voKeNaTbR1+wToKFD
        8YeEzHzaYdxPWTgFkgBRdXNS3mjk8q1CrwnFl88rTc2QdcZto2mt85tLG/+kQb3Feqimp6KIhldlO
        lclNjzJJtFzcy1S9o+wOAhj5HqX+0kdp8KSFfi1tBjQIvVKoIax1wpeGkHXQz+rOsI5J7+EtyAMb9
        MdMyL2zCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5wC3-00070o-QM; Mon, 18 Mar 2019 17:37:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A0402030E118; Mon, 18 Mar 2019 18:36:57 +0100 (CET)
Date:   Mon, 18 Mar 2019 18:36:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/25] x86: Make SMAP 64-bit only
Message-ID: <20190318173657.GV6058@hirez.programming.kicks-ass.net>
References: <20190318153840.906404905@infradead.org>
 <20190318155139.963285969@infradead.org>
 <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 09:58:20AM -0700, Linus Torvalds wrote:
> On Mon, Mar 18, 2019 at 8:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > We rely on objtool to verify AC=1 doesn't escape. However there is no
> > objtool support for x86_32, and thus we cannot guarantee the
> > correctness of the 32bit code.
> 
> Absolutely not.
> 
> This is just crazy. We had working SMAP long before objtool, and we
> will have it regardless of objtool.

Well, 'working', because as shown with this work, there's been a number
of bugs around this.

Anyway, since you mentioned it, I checked, about 16 months: Broadwell
was Oct'14, objtool was Feb'16.

> This is like saying "ok, I don't have an oxygen sensor, so I don't
> know that the air I'm breathing is sufficient to maintain life, so
> I'll just stop breathing".

With PTI, booting a 32bit kernel on a Broadwell or later will already
complain about it being sub-optimal for missing out on PCID. But sure;
if you want to enable this..

> So no way in hell do we make SMAP go away on 32-bit for no sane reason
> what-so-ever.

then I'd sleep much better if we make 32bit context switch EFLAGS.
Because, yes, x86_64 objtool validates a lot of the x86_32 code too, but
unless we have 100% coverage, there's always the chance an AC=1 escapes.

---
 arch/x86/entry/entry_32.S        | 2 ++
 arch/x86/include/asm/switch_to.h | 1 +
 arch/x86/kernel/process_32.c     | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d309f30cf7af..5fc76b755510 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -650,6 +650,7 @@ ENTRY(__switch_to_asm)
 	pushl	%ebx
 	pushl	%edi
 	pushl	%esi
+	pushfl
 
 	/* switch stack */
 	movl	%esp, TASK_threadsp(%eax)
@@ -672,6 +673,7 @@ ENTRY(__switch_to_asm)
 #endif
 
 	/* restore callee-saved registers */
+	popfl
 	popl	%esi
 	popl	%edi
 	popl	%ebx
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 7cf1a270d891..18a4b6890fa8 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -46,6 +46,7 @@ struct inactive_task_frame {
 	unsigned long r13;
 	unsigned long r12;
 #else
+	unsigned long flags;
 	unsigned long si;
 	unsigned long di;
 #endif
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index e471d8e6f0b2..d28e9a74b736 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -127,6 +127,11 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	struct task_struct *tsk;
 	int err;
 
+	/*
+	 * We start a new task with the RESET value of EFLAGS, in particular we
+	 * context switch with IRQs disabled.
+	 */
+	frame->flags = X86_EFLAGS_FIXED;
 	frame->bp = 0;
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
