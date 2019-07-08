Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DE0C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFE320844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KlQ9rDMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfGHHtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:49:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfGHHtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZtdcoTJjChZhuPwlagtEicRdXE6fEWR8USCQzYBj3As=; b=KlQ9rDMj5O2oKgRR1ZVrSXvUR
        XU7cMcDvPgTu4Yb6UzfhpJCk5+aWfMLToecJ23SOGlfDKIOqnrOtuz7PcZjuUBRqtfhv8VPXrS4mW
        FLU+w0npjYzog8aSpyh2PTF19VyckbJ8hmWZnQ9bouqs/o88uTq705C1YmRkTSGmLDHfSvgOUIukx
        kBFyXGgzzrlNp58xqEeoOt+P7huHAt/5cvsm7c2WwzJyn9eCzYL0IexGYXChiD+G4QflroGJcBZgc
        0uQtSudvMHBuf0lfLQ0PGqaAbqwKEV7Go/1EXK2KIw+SFchsSFFDSRivCL4vS8KXNMUW3QUgUH3LD
        bUpVnwxgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkONt-0002mS-Qu; Mon, 08 Jul 2019 07:48:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BAD420AA5C74; Mon,  8 Jul 2019 09:48:23 +0200 (CEST)
Date:   Mon, 8 Jul 2019 09:48:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190708074823.GV3402@hirez.programming.kicks-ass.net>
References: <20190704195555.580363209@infradead.org>
 <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
 <a4a50e28-d972-3cef-b668-1e49d5b5496f@etsukata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a50e28-d972-3cef-b668-1e49d5b5496f@etsukata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 08:07:22PM +0900, Eiichi Tsukata wrote:
> 
> 
> On 2019/07/05 11:18, Linus Torvalds wrote:
> > On Fri, Jul 5, 2019 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> Despire the current efforts to read CR2 before tracing happens there
> >> still exist a number of possible holes:
> > 
> > So this whole series disturbs me for the simple reason that I thought
> > tracing was supposed to save/restore cr2 and make it unnecessary to
> > worry about this in non-tracing code.
> > 
> > That is very much what the NMI code explicitly does. Why shouldn't all
> > the other tracing code do the same thing in case they can take page
> > faults?
> > 
> > So I don't think the patches are wrong per se, but this seems to solve
> > it at the wrong level.

This solves it all at one site. If we're going to sprinkle CR2
save/restore over 'all' sites we're bound to miss some and we'll be
playing catch-up forever :/

> Steven previously tried to fix it by saving CR2 in TRACE_IRQS_OFF:
> https://lore.kernel.org/lkml/20190320221534.165ab87b@oasis.local.home/

That misses the context tracking tracepoint, which is also before we
load CR2.

> To prevent userstack trace code from reading user stack before it becomes ready,
> checking current->in_execve in stack_trace_save_user() can help Steven's approach,
> though trace_sched_process_exec() is called before current->in_execve = 0 so it changes
> current behavior.
> 
> The PoC code is as follows:
> 
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index 2abf27d7df6b..30fa6e1b7a87 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -116,10 +116,12 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
>                           const struct pt_regs *regs)
>  {
>         const void __user *fp = (const void __user *)regs->bp;
> +       unsigned long address;
>  
>         if (!consume_entry(cookie, regs->ip, false))
>                 return;
>  
> +       address = read_cr2();
>         while (1) {
>                 struct stack_frame_user frame;
>  
> @@ -131,11 +133,14 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
>                         break;
>                 if (frame.ret_addr) {
>                         if (!consume_entry(cookie, frame.ret_addr, false))
> -                               return;
> +                               break;
>                 }
>                 if (fp == frame.next_fp)
>                         break;
>                 fp = frame.next_fp;
>         }
> +
> +       if (address != read_cr2())
> +               write_cr2(address);
>  }
>  

And this misses the perf unwinder, which we can reach if we attach perf
to the tracepoint. We can most likely also do user accesses from
kprobes, which we can similarly attach to tracepoints, and there's eBPF,
and who knows what else...

Do we really want to go put CR2 save/restore around every single thing
that can cause a fault (any fault) and is reachable from a tracepoint?
That's going to be a long list of things ... :/

Or are we going to put the CR2 save/restore on every single tracepoint?
But then we also need it on the mcount/fentry stubs and we again have
multiple places.

Whereas if we stick it in the entry path, like I proposed, we fix it in
one location and we're done.
