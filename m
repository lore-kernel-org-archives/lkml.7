Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C0C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3BF21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZSi1KLxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfKHPFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:05:42 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42321 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKHPFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:05:41 -0500
Received: by mail-yw1-f67.google.com with SMTP id z67so2242294ywb.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 07:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJp6cAXN+dUfVPQDeABvOLqnK8LTiKhkA6L1GxR0KxI=;
        b=ZSi1KLxTHC0JsBr1m7FvI9OJJr89ObT0qA53ShtRXqFFwpHSqfnM2ipbciIaiIV5Cd
         W/3CE5c1OTw909XwIx5s676pywHmlsscGloBgcVMpaeW63hoOldMbxprPQXqxfaV4St4
         dKq5XdfMD1gcyeDUWx+vtLrTGI4Wh9S1+aJ6/MCcUDeEeoR78BlbJyr3RykS8oxvdnmS
         XF4fFpmNlO86BFyskuJjbGL5Lk8ReyeXJ2z0k5RIhFz34JMH6ymA2LEGfiNEYpsrfk6N
         rjLSHV1O8EUsaOPDYbwRAhbJqdM67FFXLEFL/OW8EJeFBySc50dVJPxnRQB8mLCxtd+M
         oaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJp6cAXN+dUfVPQDeABvOLqnK8LTiKhkA6L1GxR0KxI=;
        b=c82F+BPF4TGM5WAsEFj6xu0U/wlPsmuz4fcKbtU5Jz3RzaX/BTNAGROCxMB21pjx+q
         GTrQelV47jmxWelHDvI4Fy5wlzOgIwrqD5AafneKK5y3jtON1BhneFg5NSKQeUoXnFB/
         P2/67/8/V2mCmY4JmbbhT++HnwfFhIohHeMivv+7Cdunu7zoYLXUOC+hgUfh8zr+9orO
         oqwfoLr/jdEZV0SsQzLVRYED4y71fipjoGxudhpBpLF0d2HIVcei9EQeE6OZIYBYqS74
         4vUJ7eK+rFQX/VUi83XHVn3aMDnrbNcwYPcZqwf/qERyqwSlsVmxtWoydGl26NlUft/w
         s9NQ==
X-Gm-Message-State: APjAAAX1nhxg4wlakPiSgsAhQAGroUfM4++SrgYlDdV6LpoJjj2kTkcC
        wxszMEcObNlR8fBrfmoBceGVFA==
X-Google-Smtp-Source: APXvYqxdrm/S62wuGVAaHr5+HUu1YUsMnUPQN2VDRWjfX+teLcpNNpruypYZxdZa2IwZv0+/75SDgA==
X-Received: by 2002:a0d:e445:: with SMTP id n66mr7495001ywe.179.1573225540571;
        Fri, 08 Nov 2019 07:05:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id u7sm6290532ywu.45.2019.11.08.07.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 07:05:39 -0800 (PST)
Date:   Fri, 8 Nov 2019 23:05:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20191108150530.GA7721@leoy-ThinkPad-X240s>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
 <20191101100440.GU4131@hirez.programming.kicks-ass.net>
 <20191104022346.GC26019@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104022346.GC26019@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:23:46AM +0800, Leo Yan wrote:

[...]

> > > But for jump label, it doesn't use the stop_machine() and perf event
> > > PERF_TEXT_POKE_UPDATE will introduce race condition as below (Let's see
> > > the example for transition from nop to branch):
> > > 
> > >               CPU0                                      CPU1
> > >   NOP instruction
> > >    `-> static_key_enable()
> > >         `-> aarch64_insn_patch_text_nosync()
> > >              `-> perf event PERF_TEXT_POKE_UPDATE
> > >                                                      -> Execute nop
> > >                                                         instruction
> > >              `-> aarch64_insn_write()
> > >              `-> __flush_icache_range()
> > > 
> > > Since x86 platform have INT3 as a mediate state, it can avoid the
> > > race condition between CPU0 (who is do transition) and other CPUs (who
> > > is possible to execute nop/branch).
> > 
> > Ah, you found the _nosync thing in jump_label, here's the one in ftrace:
> > 
> > arch/arm64/kernel/ftrace.c:     if (aarch64_insn_patch_text_nosync((void *)pc, new))
> > 
> > And yes, this is racy.
> > 
> > > > The thing is, as I argued, the instruction state between PRE and POST is
> > > > ambiguous. This makes it impossible to decode the branch decision
> > > > stream.
> > > > 
> > > > Suppose CPU0 emits the PRE event at T1 and the POST event at T5, but we
> > > > have CPU1 covering the instruction at T3.
> > > > 
> > > > How do you decide where CPU1 goes and what the next conditional branch
> > > > is?
> > > 
> > > Sorry for my not well thought.
> > > 
> > > I agree that T3 is an uncertain state with below flow:
> > > 
> > >       CPU0                                             CPU1
> > >   perf event PERF_TEXT_POKE_UPDATE_PRE   -> T1
> > > 
> > >     Int3 / NOP                                       -> T3
> > > 
> > >     Int3 / branch                                    -> T3'
> > > 
> > >   perf event PERF_TEXT_POKE_UPDATE_POST  -> T5
> > > 
> > > Except if the trace has extra info and can use old/new instructions
> > > combination for analysis, otherwise PRE/POST pair events aren't helpful
> > > for resolve this issue (if trace decoder can do this, then the change in
> > > kernel will be much simpler).
> > > 
> > > Below are two potential options we can use on Arm64 platform:
> > > 
> > > - Change to use stop_machine() for jump label; this might introduce
> > >   performance issue if jump label is altered frequently.
> > > 
> > >   To mitigate the impaction, we can only use stop_machine() when
> > >   detect the perf events are enabled, otherwise will rollback to use
> > >   the old code path.
> > > 
> > > - We can use breakpoint to emulate the similiar flow with x86's int3,
> > >   thus we can dismiss the race condition between one CPU alters
> > >   instruction and other CPUs run into the alternative instruction.
> > > 
> > > @Will, @Mark, could you help review this?  Appreciate any comments
> > > and suggestions.  And please let me know if you want to consolidate
> > > related works with your side (or as you know if there have ongoing
> > > discussion or someone works on this).
> > 
> > Given people are building larger Aargh64 machines (I've heard about 100+
> > CPUs already), I'm thinking the 3rd option is the most performant.
> > 
> > But yes, as you mention earlier, we can make this optional on the
> > TEXT_POKE_UPDATE event being in use.
> > 
> > I'm thinking something along the lines of:
> > 
> > static uintptr_t nosync_addr;
> > static u32 nosync_insn;
> > 
> > int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> > {
> > 	const u32 break = // some_breakpoint_insn;
> > 	uintptr_t tp = (uintptr_t)addr;
> > 	int ret;
> > 
> > 	lockdep_assert_held(&text_mutex);
> > 
> > 	/* A64 instructions must be word aligned */
> > 	if (tp & 0x3)
> > 		return -EINVAL;
> > 
> > 	if (perf_text_poke_update_enabled()) {
> > 
> > 		nosync_insn = insn;
> > 		smp_store_release(&nosync_addr, tp);
> > 
> > 		ret = aarch64_insn_write(addr, break);
> > 		if (ret == 0)
> > 			__flush_icache_range(tp, tp + AARCH64_INSN_SIZE);
> > 
> > 		perf_event_text_poke(....);
> > 	}
> > 
> > 	ret = aarch64_insn_write(addr, insn);
> > 	if (ret == 0)
> > 		__flush_icache_range(tp, tp + AARCH64_INSN_SIZE);
> > 
> > 	return ret;
> > }
> > 
> > And have the 'break' handler do:
> > 
> > aarch64_insn_break_handler(struct pt_regs *regs)
> > {
> > 	unsigned long addr = smp_load_acquire(&nosync_addr);
> > 	u32 insn = nosync_insn;
> > 
> > 	if (regs->ip != addr)
> > 		return;
> > 
> > 	// emulate @insn
> > }
> > 
> > I understood from Will the whole nosync scheme only works for a limited
> > set of instructions, but you only have to implement emulation for the
> > actual instructions used of course.
> > 
> > (which is what we do on x86)
> > 
> > Does this sound workable?

I will update some status for prototype (the code has been uploaded into
git server [1]) and found some issues for text poke perf event on arm64.
These issues are mainly related with arch64 architecture.

- The first issue is for the nosync instruction emulation.  On arm64,
  some instructions need to be single stepped and some instructions
  is emulated.  Especially, after I read the code for kprobe
  implementation on Arm64.  So the main idea for prototyping is to use
  the almos same method with kprobe for nosync instruction.

  As result, there have duplicated code between kprobe and text
  poke handling.  If this is the right way to move forward, we need to
  refactor the common code so that kprobe and text poke can share with
  each other.

- The second issue is race condition between the CPU alters
  instructions and other CPUs hit the altered instructions (and
  breakpointed).

  Peter's suggestion uses global variables 'nosync_insn' and
  'nosync_addr' to record the altered instruction.  But from the
  testing I found for single static key, usually it will change for
  multiple address at once.

  So this might cause the issue is: CPU(a) will loop to alter
  instructions for different address (sometimes the opcode also is
  different for different address), at the meantime, CPU(b) hits an
  altered instruction and handle exception for the breakpoint, if
  CPU(a) is continuing to alter instruction for the next address, thne
  CPU(a) might wrongly to use the value from 'nosync_insn' and
  'nosync_addr'.

  Simply to say, we cannot only support single nosync instruction but
  need to support multiple nosync instructions in the loop.

- The third issue is might be nested issue.  E.g. for the injected
  break instruction, we have no method to pass perf event for this
  instruction; and if we connect with the first issue, if the
  instruction is single stepped with slot (the slot is allocated with
  get_insn_slot()), we cannot to allow the perf user space to know
  the instructions which are executed in the slots.

  I am not sure if I think too complex here.  But seems to me, we
  inject more instructions for poke text event, and if these injected
  instructions are executed but the userspace decoder has no way to
  pass the related info.

Just clarify, I am fine for merging this patch set, but we might
consider more what's the best way on Arm64.  Welcome any public
comments and suggestions; I will sync internally for how to follow up
this functionality.

Thanks,
Leo Yan

[1] https://git.linaro.org/people/leo.yan/linux-coresight.git/log/?h=arm64_perf_text_pork_prototype
