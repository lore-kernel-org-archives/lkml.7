Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47386C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1996F20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573744406;
	bh=J0lcc9QcJ5EeH2wg4bRiCQRDMMUvIOvIOmibUE5m1/g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cLAfChZaa1g860mEpuOiFNez8lo/OWvSyIML2+cH/Vyg3WoDu97E3cthVsN43I8L+
	 ek5ocb8dfv5NJIe3JcTz1Gx4BdGUhoTYp+qaWn/cwUGQgs0wnhmKwgOovddyXzdquS
	 CX9HbdSqfMjk/6vMsnTztcUqWIExMzKSbDXd5U7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKNPNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfKNPNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:13:24 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6DDC206DC;
        Thu, 14 Nov 2019 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573744403;
        bh=J0lcc9QcJ5EeH2wg4bRiCQRDMMUvIOvIOmibUE5m1/g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xWgVs5XIfQdHwcKr3V/r7hqlD75ScUevDV/AIvouZWbwpzhdoW7WVAJX9K/sWfpqv
         zHwXWelx/30UmXzbjtTJ2J4ApruL6mWOO5CtdbQWk6Kjlrli7zlIcg0Huq5A/LemgI
         uTSdPwFpz5s+VFvYS1QZMFH9/al1ydCbI7qIVwAk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2C27E3520486; Thu, 14 Nov 2019 07:13:23 -0800 (PST)
Date:   Thu, 14 Nov 2019 07:13:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH -v5 12/17] x86/kprobes: Fix ordering
Message-ID: <20191114151323.GK2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191111131252.921588318@infradead.org>
 <20191111132458.162172862@infradead.org>
 <394483573.90.1573659752560.JavaMail.zimbra@efficios.com>
 <20191114135311.GW4131@hirez.programming.kicks-ass.net>
 <1135959694.112.1573743977897.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135959694.112.1573743977897.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:06:17AM -0500, Mathieu Desnoyers wrote:
> ----- On Nov 14, 2019, at 8:53 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Wed, Nov 13, 2019 at 10:42:32AM -0500, Mathieu Desnoyers wrote:
> >> ----- On Nov 11, 2019, at 8:13 AM, Peter Zijlstra peterz@infradead.org wrote:
> >> 
> >> > Kprobes does something like:
> >> > 
> >> > register:
> >> >	arch_arm_kprobe()
> >> >	  text_poke(INT3)
> >> >          /* guarantees nothing, INT3 will become visible at some point, maybe */
> >> > 
> >> >        kprobe_optimizer()
> >> >	  /* guarantees the bytes after INT3 are unused */
> >> >	  syncrhonize_rcu_tasks();
> >> 
> >> syncrhonize -> synchronize
> > 
> > Fixed.
> > 
> >> >	  text_poke_bp(JMP32);
> >> >	  /* implies IPI-sync, kprobe really is enabled */
> >> > 
> >> > 
> >> > unregister:
> >> >	__disarm_kprobe()
> >> >	  unoptimize_kprobe()
> >> >	    text_poke_bp(INT3 + tail);
> >> >	    /* implies IPI-sync, so tail is guaranteed visible */
> >> >          arch_disarm_kprobe()
> >> >            text_poke(old);
> >> >	    /* guarantees nothing, old will maybe become visible */
> >> > 
> >> >	synchronize_rcu()
> >> > 
> >> >        free-stuff
> >> > 
> >> > Now the problem is that on register, the synchronize_rcu_tasks() does
> >> > not imply sufficient to guarantee all CPUs have already observed INT3
> >> > (although in practise this is exceedingly unlikely not to have
> >> 
> >> practise -> practice
> > 
> > And fixed.
> > 
> >> > happened) (similar to how MEMBARRIER_CMD_PRIVATE_EXPEDITED does not
> >> > imply MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).
> >> > 
> >> > Worse, even if it did, we'd have to do 2 synchronize calls to provide
> >> > the guarantee we're looking for, the first to ensure INT3 is visible,
> >> > the second to guarantee nobody is then still using the instruction
> >> > bytes after INT3.
> >> 
> >> I'm not entirely convinced about this last statement though. AFAIU:
> >> 
> >> - Swapping between some instruction and INT3 is OK,
> >> - Swapping back between that INT3 and _original_ instruction is OK,
> >> - Anything else needs to have explicit core serialization.
> > 
> > So far, agreed.
> > 
> >> So I understand the part about requiring the synchronize call to guarantee
> >> that nobody is then still using the instruction bytes following INT3, but not
> >> the rationale for the first synchronization. What operation would theoretically
> >> follow this first synchronize call ?
> > 
> > I'm not completely sure what you're asking, so I'm going to explain too
> > much and hope I answered your question along the way. If not, please be
> > a little more specific.
> > 
> > First:
> > 
> > So what can happen with optimized kprobes is that the original
> > instruction is <5 bytes and we want to write a JMP.d32 (5 bytes).
> > Something like:
> > 
> >	83e:   48 89 e5                mov    %rsp,%rbp
> >	841:   48 85 c0                test   %rax,%rax
> > 
> > And we put a kprobe on the MOV. Then we poke INT3 at 0x83e and IPI-sync.
> > At that point the kprobe is active:
> > 
> >	83e:   cc 89 e5                int3 ; 2 byte garbage
> >	841:   48 85 c0                test   %rax,%rax
> > 
> > Now we want to optimize that thing. But imagine a task being preempted
> > at 0x841. If we poke in the JMP.d32 the above turns into gibberish
> > 
> >	83e:   e9 12 34 56 78		jmp +0x12345678
> > 
> > Then our task resumes, loads the instruction at 0x841, which then reads:
> > 
> >	841:   56 78 c0
> > 
> > And goes *bang*.
> 
> Thanks for the reminder. I somehow forgot that optimized kprobes covered
> instructions smaller than 5 bytes.
> 
> > 
> > So what we do, after enabling the regular kprobe, is call
> > synchronize_rcu_tasks() to wait for each task to have passed through
> > schedule(). That guarantees no task is preempted inside the kprobe
> > shadow (when it triggers it ensures it resumes execution at an
> > instruction boundary further than 5 bytes away).
> 
> Indeed, given that synchronize_rcu_tasks() awaits for voluntary context
> switches (or user-space execution), it guarantees that no task was preempted
> within the kprobe shadow.
> 
> Considering that synchronize_rcu_tasks() is meant only for code rewriting,
> I wonder if it would make sense to include the core serializing guarantees
> within this RCU API ?

As in have synchronize_rcu_tasks() do the IPI-sync love before doing
the current wait-for-voluntary-context-switch work?  I don't know of
any objection to that approach.  Certainly there is no possible
argument based on latency.  ;-)

						Thanx, Paul
