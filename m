Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E490EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEA220659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K36trUTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKKUdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:33:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qoYbJCOFJQIZTAKkMEWi02lu+BzXNt5t/hAbSGPJtf8=; b=K36trUTLv5vlbLCkuS8ba8ej1
        tEMLcRkQ2DGefRvpl3/q0EKwN8WjGAfLba5Qc6IYNK8qZ1/0SOT8kRTwREBqNO50IXfysJMCEJfO0
        u2MRaIQSCOab/NIqAXiRc6jKKpm4dRPBoj+Q4aw5zAdy5eaAuLYlwxNg4WfGQMG6Ap5CkCCWCwdv3
        Nxm3u/EP5WxiRLj9xXiy5G77MesoJ5WdD+sZ8h+5Lh2xkqYCfFuZW9AglmYZ8JHCzWnxpDb9DCHP+
        IOCyWKC7B08SSCN5LNZTPYmmq9MgyHR0Bh50NV02cjKHXb6sPJVijlIirhtrRvr6QoC4hobENSCoh
        sAo9Barqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUGMh-0002UW-Ib; Mon, 11 Nov 2019 20:32:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3516D30018B;
        Mon, 11 Nov 2019 21:31:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE19129BC8180; Mon, 11 Nov 2019 21:32:43 +0100 (CET)
Date:   Mon, 11 Nov 2019 21:32:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20191111203243.GT4131@hirez.programming.kicks-ass.net>
References: <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
 <20191101100440.GU4131@hirez.programming.kicks-ass.net>
 <20191104022346.GC26019@leoy-ThinkPad-X240s>
 <20191108150530.GA7721@leoy-ThinkPad-X240s>
 <20191111144642.GM4114@hirez.programming.kicks-ass.net>
 <20191111153925.GC10488@willie-the-truck>
 <20191111160505.GZ4097@hirez.programming.kicks-ass.net>
 <20191111172935.GA11972@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111172935.GA11972@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:29:35PM +0000, Will Deacon wrote:
> On Mon, Nov 11, 2019 at 05:05:05PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 11, 2019 at 03:39:25PM +0000, Will Deacon wrote:
> > 
> > > Backing up though, I think I'm missing details about what this thread is
> > > trying to achieve. You're adding perf events so that coresight trace can
> > > take into account modifications of the kernel text, right?
> > 
> > Yes, because ARM-CS / Intel-PT need to know the exact text at any one
> > time in order to correctly decode their traces.
> > 
> > > If so:
> > >
> > >   * Does this need to take into account more than just jump_label()?
> > 
> > jump_label seems to be the initial target Adrian set, but yes, it needs
> > to cover 'everything'.
> 
> Including alternatives, which are what get me worried since the potential
> for recursion is pretty high there (on arm64, at least).

So I had not considered alternatives because they're typically ran once
at boot (and module load) and never seen again. That would make them
just part of loading new text.

But you mentioned wanting to run them at hotplug time... which is more
'interresting'.

> > That is, all single instruction patching crud around:
> > 
> >  - optimized kprobes
> >    (regular kprobes are exempt because they rely on exceptions)
> >  - jump_labels
> >  - static_call (still pending but still)
> >  - ftrace fentry
> > 
> > We also need a solution for whole new chunks of text:
> > 
> >  - modules
> >  - ftrace trampolines
> >  - optprobe trampolines
> >  - JIT stuff
> > 
> > but that is so far not included; I had some ideas about a /dev/mem based
> > interface that would report new ranges and wait for acks (from open
> > file-desc) before freeing them.
> 
> I think that it would be nice not to end up with two very different
> interfaces for this. But I see this is still just an RFC, so maybe the
> full picture will emerge once we solve more of these use-cases.

The general distinction is between new text mappings and changing them
once they exist.

In general a text mapping is large and doesn't change (much). Once you
get an event it exist you can copy it out at your convenience, all you
really need to make sure of it that it doesn't dissapear before you've
completed your copy.

OTOH dynamic text like jump_labels can happen quite frequently and we
cannot wait for all observers to have observed/copied the new state
before we allow changing it again -- ie. we need a buffered event.

So we don't want to stick whole new text things into a buffer (a module
might be larger than the buffer) but we cannot be lazy with text
updates.

That is, yes it sucks, but these are two different cases.

> > Instead we rely on exceptions; exceptions are differently encoded in the
> > CS/PT data streams.
> > 
> > The scheme used is:
> > 
> >  - overwrite target instruction with an exception (INT3 on x86, BRK on arm)
> >  - sync (IPI broadcast CPUID or I-FLUSH completion)
> 
> Hmm. Wouldn't this sync also need to drain the trace buffers for all other
> CPUs so that we make sure that the upcoming TEXT_POKE event occurs after
> all prior trace data, which could've been from before the breakpoint was
> installed?

All we need to ensure is that the breakpoint is visible before the
event. That way we know that before the event we have the old
instruction, after the event we have the new instruction, and any
ambiguity must be resolved with exception packets.

That is, if there is concurrency, the trace buffer will be 'flushed' by
the exception. If there is no concurrency, we don't care and can assume
old/new depending on timestamps relative to the event.

> > at this point we know the instruction _will_ trap and CS/PT can observe
> > this alternate flow. That is, the exception handler will emulate the
> > instruction.
> > 
> >  - emit the TEXT_POKE event with both the old and new instruction
> >    included
> > 
> >  - overwrite the target instruction with the new instruction
> >  - sync
> > 
> > at this point the new instruction should be valid.
> > 
> > Using this scheme we can at all times follow the instruction flow.
> > Either it is an exception and the exception encoding helps us navigate,
> > or, on either size, we'll know the old/new instruction.
