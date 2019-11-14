Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF4C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F12F206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="p6WWfMgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKNPGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:06:21 -0500
Received: from mail.efficios.com ([167.114.142.138]:43772 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:06:20 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BFA2E41E99F;
        Thu, 14 Nov 2019 10:06:18 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id y5v4rZBxmuph; Thu, 14 Nov 2019 10:06:18 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3C86441E99B;
        Thu, 14 Nov 2019 10:06:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3C86441E99B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1573743978;
        bh=RuHkOvmK9qPDSxk0veOJwx6BmoK8VXMvjoAV6kKuzNA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=p6WWfMghZQc+kpvpCBgL5oXSi7D1qZVAT7yOQrmffSy+QR0/q+RpK/Fbp6rR4JGmd
         RsEm4EKRLHlWDjPu4thI52KRM4aQeEi3dHM2VOFUacpP5ToY+x5qgbMsQCP2z4Q4nt
         XPVK5b8aiU8LxFGwQTAVZr/YB1/G+YDh4dnZLN4QKs6/Ernl/0nMt5NEf1hPLYRIXt
         36V7bO0vbDw8+FrOKGdzc077wjK9OT38pZXD8GGw7wSSc/mN65OsWZC03sXPCQZvaB
         mwj31EIVfnR8iheUodhBSbbunNiSlRDv2Bg3nJNEZxipvDF4Fnf/Jsd2o2JBaPySvo
         qQbweWFuziasQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 58PU-DPc0tvL; Thu, 14 Nov 2019 10:06:18 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1347B41E98B;
        Thu, 14 Nov 2019 10:06:18 -0500 (EST)
Date:   Thu, 14 Nov 2019 10:06:17 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        paulmck <paulmck@kernel.org>
Message-ID: <1135959694.112.1573743977897.JavaMail.zimbra@efficios.com>
In-Reply-To: <20191114135311.GW4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org> <20191111132458.162172862@infradead.org> <394483573.90.1573659752560.JavaMail.zimbra@efficios.com> <20191114135311.GW4131@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH -v5 12/17] x86/kprobes: Fix ordering
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3888 (ZimbraWebClient - FF70 (Linux)/8.8.15_GA_3869)
Thread-Topic: x86/kprobes: Fix ordering
Thread-Index: UFOFrabDNwwFpDwtGKVJiKNujCuP8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 14, 2019, at 8:53 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Nov 13, 2019 at 10:42:32AM -0500, Mathieu Desnoyers wrote:
>> ----- On Nov 11, 2019, at 8:13 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > Kprobes does something like:
>> > 
>> > register:
>> >	arch_arm_kprobe()
>> >	  text_poke(INT3)
>> >          /* guarantees nothing, INT3 will become visible at some point, maybe */
>> > 
>> >        kprobe_optimizer()
>> >	  /* guarantees the bytes after INT3 are unused */
>> >	  syncrhonize_rcu_tasks();
>> 
>> syncrhonize -> synchronize
> 
> Fixed.
> 
>> >	  text_poke_bp(JMP32);
>> >	  /* implies IPI-sync, kprobe really is enabled */
>> > 
>> > 
>> > unregister:
>> >	__disarm_kprobe()
>> >	  unoptimize_kprobe()
>> >	    text_poke_bp(INT3 + tail);
>> >	    /* implies IPI-sync, so tail is guaranteed visible */
>> >          arch_disarm_kprobe()
>> >            text_poke(old);
>> >	    /* guarantees nothing, old will maybe become visible */
>> > 
>> >	synchronize_rcu()
>> > 
>> >        free-stuff
>> > 
>> > Now the problem is that on register, the synchronize_rcu_tasks() does
>> > not imply sufficient to guarantee all CPUs have already observed INT3
>> > (although in practise this is exceedingly unlikely not to have
>> 
>> practise -> practice
> 
> And fixed.
> 
>> > happened) (similar to how MEMBARRIER_CMD_PRIVATE_EXPEDITED does not
>> > imply MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).
>> > 
>> > Worse, even if it did, we'd have to do 2 synchronize calls to provide
>> > the guarantee we're looking for, the first to ensure INT3 is visible,
>> > the second to guarantee nobody is then still using the instruction
>> > bytes after INT3.
>> 
>> I'm not entirely convinced about this last statement though. AFAIU:
>> 
>> - Swapping between some instruction and INT3 is OK,
>> - Swapping back between that INT3 and _original_ instruction is OK,
>> - Anything else needs to have explicit core serialization.
> 
> So far, agreed.
> 
>> So I understand the part about requiring the synchronize call to guarantee
>> that nobody is then still using the instruction bytes following INT3, but not
>> the rationale for the first synchronization. What operation would theoretically
>> follow this first synchronize call ?
> 
> I'm not completely sure what you're asking, so I'm going to explain too
> much and hope I answered your question along the way. If not, please be
> a little more specific.
> 
> First:
> 
> So what can happen with optimized kprobes is that the original
> instruction is <5 bytes and we want to write a JMP.d32 (5 bytes).
> Something like:
> 
>	83e:   48 89 e5                mov    %rsp,%rbp
>	841:   48 85 c0                test   %rax,%rax
> 
> And we put a kprobe on the MOV. Then we poke INT3 at 0x83e and IPI-sync.
> At that point the kprobe is active:
> 
>	83e:   cc 89 e5                int3 ; 2 byte garbage
>	841:   48 85 c0                test   %rax,%rax
> 
> Now we want to optimize that thing. But imagine a task being preempted
> at 0x841. If we poke in the JMP.d32 the above turns into gibberish
> 
>	83e:   e9 12 34 56 78		jmp +0x12345678
> 
> Then our task resumes, loads the instruction at 0x841, which then reads:
> 
>	841:   56 78 c0
> 
> And goes *bang*.

Thanks for the reminder. I somehow forgot that optimized kprobes covered
instructions smaller than 5 bytes.

> 
> So what we do, after enabling the regular kprobe, is call
> synchronize_rcu_tasks() to wait for each task to have passed through
> schedule(). That guarantees no task is preempted inside the kprobe
> shadow (when it triggers it ensures it resumes execution at an
> instruction boundary further than 5 bytes away).

Indeed, given that synchronize_rcu_tasks() awaits for voluntary context
switches (or user-space execution), it guarantees that no task was preempted
within the kprobe shadow.

Considering that synchronize_rcu_tasks() is meant only for code rewriting,
I wonder if it would make sense to include the core serializing guarantees
within this RCU API ?

> 
> 
> Second:
> 
> The argument I was making was that if we didn't IPI-sync, and if
> synchronize_rcu_tasks() would imply the IPI-sync, we would still need
> two invocations of it to achieve the desired result. Because only after
> the implied IPI-sync must we guarantee no tasks is still inside the
> kprobe 'shadow'.
> 
> 
> Did that answer your question?

Yes.

Which makes me wonder if we should include the IPI-sync guarantees within
synchronize_rcu_tasks(), _and_ issue the additional IPI-sync when a full
synchronize_rcu_tasks() is not required. But this is a minor nit, I'm fine
with the approach you propose.

> 
>> I understand that this patch modifies arch_{arm,disarm}_kprobe to add
>> core serialization after inserting/removing the INT3 even in the case
>> where no optimized kprobes are used, which is heavier than what is
>> strictly required without optimized kprobes.
> 
> I disagree, it is required even for normal kprobes, namely:
> 
> Without this additional sync it is uncertain when the kprobe would've
> taken effect (if ever).
> 
> Suppose a CPU is stuck in a tight loop around the probed instruction,
> then it would never have to re-fetch the changed text and thus never
> trigger.

If the instruction cache state is not presumed to be "eventually
consistent", then this explicit core serialization is indeed required.

Please consider my comments about as food for thoughts, I'm fine with
your proposed patch:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
