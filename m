Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F7CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416092190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573486774;
	bh=o4qJouEy1HgCEmH6O0gWZxRya36rLkMLwmDDxwFd4s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KD177RCQMmMdeHVeMvMPIsDiCz81k/mR+BpJRngjQOc8Bto41FcZkQi7Qva6fFjn8
	 VE4ZJA3i29Ltn09NUkCOBuXcegBHKdQCRcvQdq1dnzyjaLZRDX60+YgTfJz+I0XrJm
	 dFjTdbLg2Qfk+yyofu0x++0y7YtfFCc2gBoMKTaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKKPjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfKKPjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:39:32 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A1E2084F;
        Mon, 11 Nov 2019 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573486771;
        bh=o4qJouEy1HgCEmH6O0gWZxRya36rLkMLwmDDxwFd4s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjrwe5DJXe7U7bKOIW26eK/hF1Li/TwctNy62/R3SXwK7uAz75n+FRf5fHpjAEydf
         8dkQmsAKtOvy3b8yBgg6r8h6xcswTtesgILbIbhqvJr2PH6arFgk0u7PS3/F2bZi8k
         JT+KuombXKnis5fNIBII8zSsV5qrdFFfRXvfDdxg=
Date:   Mon, 11 Nov 2019 15:39:25 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191111153925.GC10488@willie-the-truck>
References: <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
 <20191101100440.GU4131@hirez.programming.kicks-ass.net>
 <20191104022346.GC26019@leoy-ThinkPad-X240s>
 <20191108150530.GA7721@leoy-ThinkPad-X240s>
 <20191111144642.GM4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111144642.GM4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a disclaimer: I'm having a hard time understanding what this thread is
about.

On Mon, Nov 11, 2019 at 03:46:42PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 08, 2019 at 11:05:30PM +0800, Leo Yan wrote:
> 
> > I will update some status for prototype (the code has been uploaded into
> > git server [1]) and found some issues for text poke perf event on arm64.
> > These issues are mainly related with arch64 architecture.
> > 
> > - The first issue is for the nosync instruction emulation.  On arm64,
> >   some instructions need to be single stepped and some instructions
> >   is emulated.  Especially, after I read the code for kprobe
> >   implementation on Arm64.  So the main idea for prototyping is to use
> >   the almos same method with kprobe for nosync instruction.
> 
> This makes no sense to me what so ever. What actual instructions are
> patched with _nosync() ? ftrace/jump_label only use 'NOP/JMP/CALL'

'_nosync()' can be used to patch the following instructions:

	B		(JMP)
	BL		(CALL)
	BRK		(Breakpoint)
	SVC, HVC, SMC	(System calls)
	NOP
	ISB		(Pipe flush)

Our kprobes implementation prefers to single-step the instruction in an
XOL buffer (we should do this by placing a BRK at the end of the buffer,
but we currently use hardware step which is overkill imo). For instructions
that are performing a PC-relative operation (e.g. an immediate branch),
we can't run from the XOL buffer because we'd go to the wrong place; these
instructions are therefore emulated in software...

> For NOP you can advance regs->ip, for JMP you can adjust regs->ip, for
> CALL you adjust regs->ip and regs->r14 (IIUC you do something like:
> regs->r14 = regs->ip+4; regs->ip = func;)

... in a manner similar to what you describe here. See simulate_b_bl(),
although it's thankfully simpler than what x86 seems to have to do. This
approach means we can avoid emulating the vast majority of the instruction
set.

> (FWIW emulating CALL on x86 is fun because we get to PUSH something on
> the stack, let me know if you want to see the patches that were required
> to make that happen :-)

No thanks ;)

> > - The second issue is race condition between the CPU alters
> >   instructions and other CPUs hit the altered instructions (and
> >   breakpointed).
> > 
> >   Peter's suggestion uses global variables 'nosync_insn' and
> >   'nosync_addr' to record the altered instruction.  But from the
> >   testing I found for single static key, usually it will change for
> >   multiple address at once.
> > 
> >   So this might cause the issue is: CPU(a) will loop to alter
> >   instructions for different address (sometimes the opcode also is
> >   different for different address), at the meantime, CPU(b) hits an
> >   altered instruction and handle exception for the breakpoint, if
> >   CPU(a) is continuing to alter instruction for the next address, thne
> >   CPU(a) might wrongly to use the value from 'nosync_insn' and
> >   'nosync_addr'.
> > 
> >   Simply to say, we cannot only support single nosync instruction but
> >   need to support multiple nosync instructions in the loop.
> 
> On x86 all actual text poking is serialized by text_mutex.

On arm64, we patch a *lot* and I think stop_machine() is the only safe
choice for things like the alternatives, where we patch all sorts of things
(cache maintenance, I/O accessors, atomics (until recently), user accessors.
Even then, we have to provide our own synchronisation in
__apply_alternatives_multi_stop() and use special cache-flushing
(clean_dcache_range_nopatch()) to avoid the possibility of running the code
that we're modifying. Outside of the alternatives, I'd still be wary about
recursive debug exceptions if we were to patch jump labels with breakpoints.

Backing up though, I think I'm missing details about what this thread is
trying to achieve. You're adding perf events so that coresight trace can
take into account modifications of the kernel text, right? If so:

  * Does this need to take into account more than just jump_label()?
  * What consistency guarantees are needed by userspace? It's not clear to
    me how it correlates the new event with execution on other CPUs. Is this
    using timestamps or something else?
  * What about module loading?

Finally, the whole point of the '_nosync()' stuff is that we don't have
to synchronise. Therefore, there is a window where you really can't tell
whether the instruction has been updated from the perspective of another
CPU.

Will
