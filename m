Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A9AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842DA2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oZlf3uG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKKQFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:05:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cpt7icqXDgl+LiUQfWDe+S6rMm3qwcVM7vERwPVl+ow=; b=oZlf3uG3hZZyw3583U6m8KawF
        A3V9bkHuoSpsgEzQRMYAkAmNvmDqCDFq3gflOMH+AuAtpKLISNheaoHiumaPCqfk662Ch5XuIpOYc
        VgrkxefVVse8WbQHHHNQRCAc8YUznyDi2HumHgyF0Wp2aB1PiW6ffCzvEg6HE4HsbHX5wuN7XdaZM
        /ZIHwge4fjmRbhfPQEShUaiHAKHKfPVFMW3NmNHzj+4fCsDtSIpfTfCCHNBFVLlqgEwPjRWHypy4+
        h/EYv7L7mQTdcOMBvAkqQpJz9LELRVSTNorPUuE7Zlc+zQxaNcvewtmjBaF+oQYYVo1OjjgOQlzcn
        /6jiEb8wA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUCBf-0002nx-UU; Mon, 11 Nov 2019 16:05:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD7FD305615;
        Mon, 11 Nov 2019 17:03:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F60829A37A82; Mon, 11 Nov 2019 17:05:05 +0100 (CET)
Date:   Mon, 11 Nov 2019 17:05:05 +0100
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
Message-ID: <20191111160505.GZ4097@hirez.programming.kicks-ass.net>
References: <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
 <20191101100440.GU4131@hirez.programming.kicks-ass.net>
 <20191104022346.GC26019@leoy-ThinkPad-X240s>
 <20191108150530.GA7721@leoy-ThinkPad-X240s>
 <20191111144642.GM4114@hirez.programming.kicks-ass.net>
 <20191111153925.GC10488@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111153925.GC10488@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:39:25PM +0000, Will Deacon wrote:

> Backing up though, I think I'm missing details about what this thread is
> trying to achieve. You're adding perf events so that coresight trace can
> take into account modifications of the kernel text, right?

Yes, because ARM-CS / Intel-PT need to know the exact text at any one
time in order to correctly decode their traces.

> If so:
>
>   * Does this need to take into account more than just jump_label()?

jump_label seems to be the initial target Adrian set, but yes, it needs
to cover 'everything'.

That is, all single instruction patching crud around:

 - optimized kprobes
   (regular kprobes are exempt because they rely on exceptions)
 - jump_labels
 - static_call (still pending but still)
 - ftrace fentry

We also need a solution for whole new chunks of text:

 - modules
 - ftrace trampolines
 - optprobe trampolines
 - JIT stuff

but that is so far not included; I had some ideas about a /dev/mem based
interface that would report new ranges and wait for acks (from open
file-desc) before freeing them.

>   * What consistency guarantees are needed by userspace? It's not clear to
>     me how it correlates the new event with execution on other CPUs. Is this
>     using timestamps or something else?

Something else :-)

Both CS/PT basically have a bit-stream encoding of taken / not-taken
decisions. To decode they read the text until a conditional
branch-point, then consume one bit from the stream and continue.

(note how unconditional branches -- jump_labels -- are expected to be
correct in this scheme)

This means they need an exact representation of the text to be able to
accurately decode.

This means timestamps or PRE/POST modify events are not acceptible.
Because until the I-FLUSH has completed we do not know which CPU has
which version of the instruction.

Instead we rely on exceptions; exceptions are differently encoded in the
CS/PT data streams.

The scheme used is:

 - overwrite target instruction with an exception (INT3 on x86, BRK on arm)
 - sync (IPI broadcast CPUID or I-FLUSH completion)

at this point we know the instruction _will_ trap and CS/PT can observe
this alternate flow. That is, the exception handler will emulate the
instruction.

 - emit the TEXT_POKE event with both the old and new instruction
   included

 - overwrite the target instruction with the new instruction
 - sync

at this point the new instruction should be valid.

Using this scheme we can at all times follow the instruction flow.
Either it is an exception and the exception encoding helps us navigate,
or, on either size, we'll know the old/new instruction.

>   * What about module loading?

I mentioned that above; that is still pending.

> Finally, the whole point of the '_nosync()' stuff is that we don't have
> to synchronise. Therefore, there is a window where you really can't tell
> whether the instruction has been updated from the perspective of another
> CPU.

Right, and much of that is preserved with the above scheme, nowhere do
you have to wait/disturb other CPUs, except for the I-FLUSH completion.

Does this help?
