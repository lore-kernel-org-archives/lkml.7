Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BA6CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECB9217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y1370jn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfKAKFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:05:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKAKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BJtEhFqYG8uOifm5mmlKegogKIvfMvjboDz3ts+GSu0=; b=y1370jn8j/57QtOIgRdTgTDfe
        LcgNagsLO1zqKSY9aO4YhH4a6JpLRmjfakggcz7l80BFf6yOVZlg/erXG2Vj083+FuKmA7JSiDEkh
        37awmuwzZ23auW5Cn6lDq3ui+5BsZOW38V7Ozb8R+whhLxIu4Xh0rNSXJEboDHXcsGneHySkj9cP9
        Z26xp1b8W7S7nO8SkJU1D4L8jo7RB2YJ+AsEZbRDKkztc60RFUCFJs7jx5a9PtG6a4CUFdIBGE9lq
        /CY0EIOi7X8Xqdk+cutkTyXRiH2G7dcFxmJffO65FJ1vMEsVZwE8nLG7bY63FgihEqNdZPgORLz0R
        y0wSHoRTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQTnO-0005Q7-UI; Fri, 01 Nov 2019 10:04:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60878300334;
        Fri,  1 Nov 2019 11:03:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59B4E26540347; Fri,  1 Nov 2019 11:04:40 +0100 (CET)
Date:   Fri, 1 Nov 2019 11:04:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191101100440.GU4131@hirez.programming.kicks-ass.net>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031073136.GC21153@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 03:31:36PM +0800, Leo Yan wrote:

> Before move farward, I'd like to step back to describe clearly what's
> current problem on Arm64 and check one question for jump label:
> 
> I checked the kernel code, both kprobe and ftrace both uses
> stop_machine() to alter instructions,

That's not currect for Aargh64, see aarch64_insn_patch_text_nosync(),
which is used in both ftrace and jump_label.

> since all CPUs run into stop
> machine's synchronization, there have no race condition between
> instructions transition and CPUs execte the altered instruction; thus
> it's safe for kprobe and ftrace to use perf event PERF_TEXT_POKE_UPDATE
> to notify instruction transition and can allow us to read out 'correct'
> instruction for decoder.

Agreed, IFF patching happens using stop_machine(), things are easy. ARM
is (so far) exclusively using stop_machine() based text_poking, although
the last time I spoke to Will about this, he said the _nosync stuff is
possible on 32bit too, just nobody has bothered implementing it.

> But for jump label, it doesn't use the stop_machine() and perf event
> PERF_TEXT_POKE_UPDATE will introduce race condition as below (Let's see
> the example for transition from nop to branch):
> 
>               CPU0                                      CPU1
>   NOP instruction
>    `-> static_key_enable()
>         `-> aarch64_insn_patch_text_nosync()
>              `-> perf event PERF_TEXT_POKE_UPDATE
>                                                      -> Execute nop
>                                                         instruction
>              `-> aarch64_insn_write()
>              `-> __flush_icache_range()
> 
> Since x86 platform have INT3 as a mediate state, it can avoid the
> race condition between CPU0 (who is do transition) and other CPUs (who
> is possible to execute nop/branch).

Ah, you found the _nosync thing in jump_label, here's the one in ftrace:

arch/arm64/kernel/ftrace.c:     if (aarch64_insn_patch_text_nosync((void *)pc, new))

And yes, this is racy.

> > The thing is, as I argued, the instruction state between PRE and POST is
> > ambiguous. This makes it impossible to decode the branch decision
> > stream.
> > 
> > Suppose CPU0 emits the PRE event at T1 and the POST event at T5, but we
> > have CPU1 covering the instruction at T3.
> > 
> > How do you decide where CPU1 goes and what the next conditional branch
> > is?
> 
> Sorry for my not well thought.
> 
> I agree that T3 is an uncertain state with below flow:
> 
>       CPU0                                             CPU1
>   perf event PERF_TEXT_POKE_UPDATE_PRE   -> T1
> 
>     Int3 / NOP                                       -> T3
> 
>     Int3 / branch                                    -> T3'
> 
>   perf event PERF_TEXT_POKE_UPDATE_POST  -> T5
> 
> Except if the trace has extra info and can use old/new instructions
> combination for analysis, otherwise PRE/POST pair events aren't helpful
> for resolve this issue (if trace decoder can do this, then the change in
> kernel will be much simpler).
> 
> Below are two potential options we can use on Arm64 platform:
> 
> - Change to use stop_machine() for jump label; this might introduce
>   performance issue if jump label is altered frequently.
> 
>   To mitigate the impaction, we can only use stop_machine() when
>   detect the perf events are enabled, otherwise will rollback to use
>   the old code path.
> 
> - We can use breakpoint to emulate the similiar flow with x86's int3,
>   thus we can dismiss the race condition between one CPU alters
>   instruction and other CPUs run into the alternative instruction.
> 
> @Will, @Mark, could you help review this?  Appreciate any comments
> and suggestions.  And please let me know if you want to consolidate
> related works with your side (or as you know if there have ongoing
> discussion or someone works on this).

Given people are building larger Aargh64 machines (I've heard about 100+
CPUs already), I'm thinking the 3rd option is the most performant.

But yes, as you mention earlier, we can make this optional on the
TEXT_POKE_UPDATE event being in use.

I'm thinking something along the lines of:

static uintptr_t nosync_addr;
static u32 nosync_insn;

int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
{
	const u32 break = // some_breakpoint_insn;
	uintptr_t tp = (uintptr_t)addr;
	int ret;

	lockdep_assert_held(&text_mutex);

	/* A64 instructions must be word aligned */
	if (tp & 0x3)
		return -EINVAL;

	if (perf_text_poke_update_enabled()) {

		nosync_insn = insn;
		smp_store_release(&nosync_addr, tp);

		ret = aarch64_insn_write(addr, break);
		if (ret == 0)
			__flush_icache_range(tp, tp + AARCH64_INSN_SIZE);

		perf_event_text_poke(....);
	}

	ret = aarch64_insn_write(addr, insn);
	if (ret == 0)
		__flush_icache_range(tp, tp + AARCH64_INSN_SIZE);

	return ret;
}

And have the 'break' handler do:

aarch64_insn_break_handler(struct pt_regs *regs)
{
	unsigned long addr = smp_load_acquire(&nosync_addr);
	u32 insn = nosync_insn;

	if (regs->ip != addr)
		return;

	// emulate @insn
}

I understood from Will the whole nosync scheme only works for a limited
set of instructions, but you only have to implement emulation for the
actual instructions used of course.

(which is what we do on x86)

Does this sound workable?
