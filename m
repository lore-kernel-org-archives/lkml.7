Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6812AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCA22075E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XA+r1Z0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKNNxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:53:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfKNNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hIuuanxR869Yw8X2J/b1nuO4Yx7oS2XS6CVgNsBylqo=; b=XA+r1Z0HQbvRPfZvrZvHd4Z0V
        PbHATkb2Ho491OWaQiciWUmlDEpqQ6+acUCXqwnfdwf79ABhvxaBG0CIr2UuOcidnsF0UqTQ6Uq40
        GB/B55Yv1JfdHQeLnbn73t4n5+PouBPQQ1r3xbzlN8/xik4qcvXmAZx1D4Xq90gw1x3Rb58vEBaSh
        41fBWWmMc8EvWDeByKcZdzCFCPlS2EiFgY+bjWSw90R7ySo7ar4F6YQBcvdh4Xg8j0h31353dCH5j
        0//+xoYcMGhm6Zqov+C14a4mqpuOK8jhVNE4fM937qdBcViRbZISYLLxnG+mHr1fgQvZrjtPs5lun
        +44YjF0EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVFYh-0007Pc-Aw; Thu, 14 Nov 2019 13:53:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 670953002B0;
        Thu, 14 Nov 2019 14:52:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90B6F28B7CC8E; Thu, 14 Nov 2019 14:53:11 +0100 (CET)
Date:   Thu, 14 Nov 2019 14:53:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron@akamai.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        paulmck <paulmck@kernel.org>
Subject: Re: [PATCH -v5 12/17] x86/kprobes: Fix ordering
Message-ID: <20191114135311.GW4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132458.162172862@infradead.org>
 <394483573.90.1573659752560.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <394483573.90.1573659752560.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:42:32AM -0500, Mathieu Desnoyers wrote:
> ----- On Nov 11, 2019, at 8:13 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > Kprobes does something like:
> > 
> > register:
> >	arch_arm_kprobe()
> >	  text_poke(INT3)
> >          /* guarantees nothing, INT3 will become visible at some point, maybe */
> > 
> >        kprobe_optimizer()
> >	  /* guarantees the bytes after INT3 are unused */
> >	  syncrhonize_rcu_tasks();
> 
> syncrhonize -> synchronize

Fixed.

> >	  text_poke_bp(JMP32);
> >	  /* implies IPI-sync, kprobe really is enabled */
> > 
> > 
> > unregister:
> >	__disarm_kprobe()
> >	  unoptimize_kprobe()
> >	    text_poke_bp(INT3 + tail);
> >	    /* implies IPI-sync, so tail is guaranteed visible */
> >          arch_disarm_kprobe()
> >            text_poke(old);
> >	    /* guarantees nothing, old will maybe become visible */
> > 
> >	synchronize_rcu()
> > 
> >        free-stuff
> > 
> > Now the problem is that on register, the synchronize_rcu_tasks() does
> > not imply sufficient to guarantee all CPUs have already observed INT3
> > (although in practise this is exceedingly unlikely not to have
> 
> practise -> practice

And fixed.

> > happened) (similar to how MEMBARRIER_CMD_PRIVATE_EXPEDITED does not
> > imply MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).
> > 
> > Worse, even if it did, we'd have to do 2 synchronize calls to provide
> > the guarantee we're looking for, the first to ensure INT3 is visible,
> > the second to guarantee nobody is then still using the instruction
> > bytes after INT3.
> 
> I'm not entirely convinced about this last statement though. AFAIU:
> 
> - Swapping between some instruction and INT3 is OK,
> - Swapping back between that INT3 and _original_ instruction is OK,
> - Anything else needs to have explicit core serialization.

So far, agreed.

> So I understand the part about requiring the synchronize call to guarantee
> that nobody is then still using the instruction bytes following INT3, but not
> the rationale for the first synchronization. What operation would theoretically
> follow this first synchronize call ?

I'm not completely sure what you're asking, so I'm going to explain too
much and hope I answered your question along the way. If not, please be
a little more specific.

First:

So what can happen with optimized kprobes is that the original
instruction is <5 bytes and we want to write a JMP.d32 (5 bytes).
Something like:

	83e:   48 89 e5                mov    %rsp,%rbp
	841:   48 85 c0                test   %rax,%rax

And we put a kprobe on the MOV. Then we poke INT3 at 0x83e and IPI-sync.
At that point the kprobe is active:

	83e:   cc 89 e5                int3 ; 2 byte garbage
	841:   48 85 c0                test   %rax,%rax

Now we want to optimize that thing. But imagine a task being preempted
at 0x841. If we poke in the JMP.d32 the above turns into gibberish

	83e:   e9 12 34 56 78		jmp +0x12345678

Then our task resumes, loads the instruction at 0x841, which then reads:

	841:   56 78 c0

And goes *bang*.

So what we do, after enabling the regular kprobe, is call
synchronize_rcu_tasks() to wait for each task to have passed through
schedule(). That guarantees no task is preempted inside the kprobe
shadow (when it triggers it ensures it resumes execution at an
instruction boundary further than 5 bytes away).


Second:

The argument I was making was that if we didn't IPI-sync, and if
synchronize_rcu_tasks() would imply the IPI-sync, we would still need
two invocations of it to achieve the desired result. Because only after
the implied IPI-sync must we guarantee no tasks is still inside the
kprobe 'shadow'.


Did that answer your question?

> I understand that this patch modifies arch_{arm,disarm}_kprobe to add
> core serialization after inserting/removing the INT3 even in the case
> where no optimized kprobes are used, which is heavier than what is
> strictly required without optimized kprobes.

I disagree, it is required even for normal kprobes, namely:

Without this additional sync it is uncertain when the kprobe would've
taken effect (if ever).

Suppose a CPU is stuck in a tight loop around the probed instruction,
then it would never have to re-fetch the changed text and thus never
trigger.

