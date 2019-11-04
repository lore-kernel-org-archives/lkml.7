Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2FFCA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3932218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjNU2zYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfKDCXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 21:23:55 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34450 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfKDCXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 21:23:55 -0500
Received: by mail-yb1-f195.google.com with SMTP id f6so2512028ybp.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 18:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RtbVhPlDBk9zWC9oucfvuM6GNX7O3UKyaoyCJiF2cHU=;
        b=vjNU2zYmDhUfZYAJoCNd6Hc0br/AUDTLTdxVw98Nk7Sc8wO9pkpff/M8tVNGxmQAON
         4OWeNYkC3jKuEX1tZYh69kXALtpWdz2lPAi+eziVMEFIqu+zeCOvMD39e3mLELahMVqY
         8j/YD0Q4qgSiMeb0TO0cyv0M/tRzHkqoH4JI8vQ6PyOdgR5VxnskJoqdQL/UK1OcHogD
         K1MKJ2GyTGcsqJrGG0btAk7JhHY1lmO3SQzyKOjCIm+Vhsrg2ts/GOiRIVuhB/Vq7kqw
         mBaRxO/ZQ5RtrC4YL2m9PjJF/81+6uSPz+urqg/6+v7/9Oh55trVug/irMwleJH9IWK3
         dsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RtbVhPlDBk9zWC9oucfvuM6GNX7O3UKyaoyCJiF2cHU=;
        b=nfUkKhLkwEQWCjrTf/XF2SWPgAj1EE9NYmhXEq0Fd4gWlb9arzTCdzD/SPMzP3+54C
         0JrAJW6moqZUJELoLoewjCc98Nz63Fm3M4Adyag+Kgnwm2dFy5f8bD1NovGX/wutYspc
         QXAE/Ci7+tqx9Oe55WffuTxz8BHSB6GwvW+/qKEEaychbqoqYS2aH6DcdkWmPoCvGVyK
         uq8MQZmUUgUzLKvjXaXvHriZPfzJ+ILdGUotTEJNpOfSqhlA4y7uvP0Va9iFVxn9LIVK
         la95gCmy0dCQCVNjnRtHkvr1or4DZ84xA2Z57PFIlMWW0SpawOzh9UwVelqQHxv/6ds4
         upZg==
X-Gm-Message-State: APjAAAW8zmtS4DBD/PiQCYWlCMN1M5YQwoNrpaQ7lW0WY1gLUaSFMcC6
        S0+dXcD58RROOhFmDk6wl3fn3Q==
X-Google-Smtp-Source: APXvYqwd5JTQ30JFnEckJVJjrSyrFBhQKJhynvz0JQJzuMNnVChDfp12BtdvAi4zL0cE4jnUkeAKnQ==
X-Received: by 2002:a25:a326:: with SMTP id d35mr21671710ybi.224.1572834234115;
        Sun, 03 Nov 2019 18:23:54 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id f8sm17835550ywb.47.2019.11.03.18.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 18:23:53 -0800 (PST)
Date:   Mon, 4 Nov 2019 10:23:46 +0800
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
Message-ID: <20191104022346.GC26019@leoy-ThinkPad-X240s>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
 <20191101100440.GU4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101100440.GU4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Nov 01, 2019 at 11:04:40AM +0100, Peter Zijlstra wrote:
> On Thu, Oct 31, 2019 at 03:31:36PM +0800, Leo Yan wrote:
> 
> > Before move farward, I'd like to step back to describe clearly what's
> > current problem on Arm64 and check one question for jump label:
> > 
> > I checked the kernel code, both kprobe and ftrace both uses
> > stop_machine() to alter instructions,
> 
> That's not currect for Aargh64, see aarch64_insn_patch_text_nosync(),
> which is used in both ftrace and jump_label.

Thanks for pointing out this.

Agree, for ftrace, it's complex and there have multiple pathes to use
aarch64_insn_patch_text_nosync().

Below flow uses stop_machine() in ftrace:

  ftrace_run_stop_machine()
   stop_machine(__ftrace_modify_code, &command, NULL);
     __ftrace_modify_code()
       ftrace_modify_all_code()
         ftrace_update_ftrace_func()
           ftrace_modify_code()
             aarch64_insn_patch_text_nosync()

Below flow doesn't use stop_machine() in ftrace:

  prepare_coming_module()
    ftrace_module_enable()
      process_cached_mods()
        process_mod_list()
          ftrace_hash_move_and_update_ops()
            ftrace_ops_update_code()
              ftrace_ops_update_code()
                ftrace_run_modify_code()
                  ftrace_run_update_code()
                    arch_ftrace_update_code()
                      ftrace_modify_all_code()
                        ftrace_update_ftrace_func()
                          ftrace_modify_code()
                            aarch64_insn_patch_text_nosync()

Actually, there have other flows also will call into
aarch64_insn_patch_text_nosync(), so at least we cannot say all ftrace
flow uses stop_machine() to alter instructions.

> > since all CPUs run into stop
> > machine's synchronization, there have no race condition between
> > instructions transition and CPUs execte the altered instruction; thus
> > it's safe for kprobe and ftrace to use perf event PERF_TEXT_POKE_UPDATE
> > to notify instruction transition and can allow us to read out 'correct'
> > instruction for decoder.
> 
> Agreed, IFF patching happens using stop_machine(), things are easy. ARM
> is (so far) exclusively using stop_machine() based text_poking, although
> the last time I spoke to Will about this, he said the _nosync stuff is
> possible on 32bit too, just nobody has bothered implementing it.
> 
> > But for jump label, it doesn't use the stop_machine() and perf event
> > PERF_TEXT_POKE_UPDATE will introduce race condition as below (Let's see
> > the example for transition from nop to branch):
> > 
> >               CPU0                                      CPU1
> >   NOP instruction
> >    `-> static_key_enable()
> >         `-> aarch64_insn_patch_text_nosync()
> >              `-> perf event PERF_TEXT_POKE_UPDATE
> >                                                      -> Execute nop
> >                                                         instruction
> >              `-> aarch64_insn_write()
> >              `-> __flush_icache_range()
> > 
> > Since x86 platform have INT3 as a mediate state, it can avoid the
> > race condition between CPU0 (who is do transition) and other CPUs (who
> > is possible to execute nop/branch).
> 
> Ah, you found the _nosync thing in jump_label, here's the one in ftrace:
> 
> arch/arm64/kernel/ftrace.c:     if (aarch64_insn_patch_text_nosync((void *)pc, new))
> 
> And yes, this is racy.
> 
> > > The thing is, as I argued, the instruction state between PRE and POST is
> > > ambiguous. This makes it impossible to decode the branch decision
> > > stream.
> > > 
> > > Suppose CPU0 emits the PRE event at T1 and the POST event at T5, but we
> > > have CPU1 covering the instruction at T3.
> > > 
> > > How do you decide where CPU1 goes and what the next conditional branch
> > > is?
> > 
> > Sorry for my not well thought.
> > 
> > I agree that T3 is an uncertain state with below flow:
> > 
> >       CPU0                                             CPU1
> >   perf event PERF_TEXT_POKE_UPDATE_PRE   -> T1
> > 
> >     Int3 / NOP                                       -> T3
> > 
> >     Int3 / branch                                    -> T3'
> > 
> >   perf event PERF_TEXT_POKE_UPDATE_POST  -> T5
> > 
> > Except if the trace has extra info and can use old/new instructions
> > combination for analysis, otherwise PRE/POST pair events aren't helpful
> > for resolve this issue (if trace decoder can do this, then the change in
> > kernel will be much simpler).
> > 
> > Below are two potential options we can use on Arm64 platform:
> > 
> > - Change to use stop_machine() for jump label; this might introduce
> >   performance issue if jump label is altered frequently.
> > 
> >   To mitigate the impaction, we can only use stop_machine() when
> >   detect the perf events are enabled, otherwise will rollback to use
> >   the old code path.
> > 
> > - We can use breakpoint to emulate the similiar flow with x86's int3,
> >   thus we can dismiss the race condition between one CPU alters
> >   instruction and other CPUs run into the alternative instruction.
> > 
> > @Will, @Mark, could you help review this?  Appreciate any comments
> > and suggestions.  And please let me know if you want to consolidate
> > related works with your side (or as you know if there have ongoing
> > discussion or someone works on this).
> 
> Given people are building larger Aargh64 machines (I've heard about 100+
> CPUs already), I'm thinking the 3rd option is the most performant.
> 
> But yes, as you mention earlier, we can make this optional on the
> TEXT_POKE_UPDATE event being in use.
> 
> I'm thinking something along the lines of:
> 
> static uintptr_t nosync_addr;
> static u32 nosync_insn;
> 
> int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> {
> 	const u32 break = // some_breakpoint_insn;
> 	uintptr_t tp = (uintptr_t)addr;
> 	int ret;
> 
> 	lockdep_assert_held(&text_mutex);
> 
> 	/* A64 instructions must be word aligned */
> 	if (tp & 0x3)
> 		return -EINVAL;
> 
> 	if (perf_text_poke_update_enabled()) {
> 
> 		nosync_insn = insn;
> 		smp_store_release(&nosync_addr, tp);
> 
> 		ret = aarch64_insn_write(addr, break);
> 		if (ret == 0)
> 			__flush_icache_range(tp, tp + AARCH64_INSN_SIZE);
> 
> 		perf_event_text_poke(....);
> 	}
> 
> 	ret = aarch64_insn_write(addr, insn);
> 	if (ret == 0)
> 		__flush_icache_range(tp, tp + AARCH64_INSN_SIZE);
> 
> 	return ret;
> }
> 
> And have the 'break' handler do:
> 
> aarch64_insn_break_handler(struct pt_regs *regs)
> {
> 	unsigned long addr = smp_load_acquire(&nosync_addr);
> 	u32 insn = nosync_insn;
> 
> 	if (regs->ip != addr)
> 		return;
> 
> 	// emulate @insn
> }
> 
> I understood from Will the whole nosync scheme only works for a limited
> set of instructions, but you only have to implement emulation for the
> actual instructions used of course.
> 
> (which is what we do on x86)
> 
> Does this sound workable?

Very appreciate for the posted code (and another minor fixing in your
next replying), the logic is quite clear.

Will do prototype for this, at the meantime, I'd like to give a bit more
time for Will (or other Arm maintainers) to review this.

Thanks,
Leo Yan
