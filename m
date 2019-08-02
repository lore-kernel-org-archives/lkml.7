Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFE2C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F74520644
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cyxqyeqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390730AbfHBQU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:20:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389867AbfHBQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j5+63vZdbplFhxoqwHWApOYrFTyD5+jt6HVVJsgbCfc=; b=cyxqyeqqDjKXINoQrqjU65XPo
        R3J33POnBnQUpGPFhQGr3nss7u+BeuuFpOR1wdMZHjoDDfx5cUxX7JX41A8TWIj8GWLIzQfSt/e6N
        hnYoZ0YeGnn0YGiKMn/aFgDgHbKGEEh0Y/2GcH8DNQfrQNszDmxWZ+SmM72wKT6fV3JfqWCY/tsmV
        P2UOAvlX2wsAdYPNkEKzN9h4Y9ccKYp/zYG99pY+GGqp8kOeqe12v023AlmcWlgMcd69dsHk0tR8Q
        u/Nq68NhXPiVX0HLUeEq7mOGkOwDiskhSerjxgLiBMPgaSrcFauAjv4PjO2a2rGCEEKvVvMVjNgl+
        2Qoa5kdyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htaHy-0003wo-0O; Fri, 02 Aug 2019 16:20:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A91920298C00; Fri,  2 Aug 2019 18:20:15 +0200 (CEST)
Date:   Fri, 2 Aug 2019 18:20:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Message-ID: <20190802162015.GA2349@hirez.programming.kicks-ass.net>
References: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com>
 <20190801211613.GB3578@hirez.programming.kicks-ass.net>
 <b4597324-6eb8-31fa-e911-63f3b704c974@amd.com>
 <alpine.DEB.2.21.1908012331550.1789@nanos.tec.linutronix.de>
 <20190801214813.GB2332@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1908012352390.1789@nanos.tec.linutronix.de>
 <925c3458-aeae-a44b-ddd5-40a1e173a307@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925c3458-aeae-a44b-ddd5-40a1e173a307@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:33:41PM +0000, Lendacky, Thomas wrote:
> On 8/1/19 4:59 PM, Thomas Gleixner wrote:
> > On Thu, 1 Aug 2019, Peter Zijlstra wrote:
> >> On Thu, Aug 01, 2019 at 11:34:23PM +0200, Thomas Gleixner wrote:
> >>> Avoid the whole NMI mess, make the PMC interrupt a proper vector in the
> >>> highest prio bucket and instead of using CLI/STI use CR8. That would have
> >>> the additional advantage that we could prevent perf "NMI" then occsionally :)
> >>
> >> Exactly, and not only the PMC, we can basically start giving out actual
> >> vectors on register_nmi_handler() and do away with all that shared line
> >> crap.
> >>
> >> And then the actual NMI line will be mostly empty again, and it can read
> >> its stupid slow reason port again.
> >>
> >> One complication though; IRET et al only do EFLAGS, not CR8, so that's
> >> going to be massive fun :-(
> 
> Talking to the hardware folks, they say setting CR8 is a serializing
> instruction and has to communicate out to the APIC, so it's better to
> use CLI/STI.

Bah; the Intel SDM states: "MOV CR* instructions, except for MOV CR8,
are serializing instructions", which had given me a little hope.

At the same time, all these chips still have the APIC TPR field too, so
much like how the TSC DEADLINE MSR is a hidden APIC write, so too is CR8
I suppose :-(

I'll still finish the patches I started, just to see what it would look
like.

Thomas mentioned combining this with software IRQ disable (like Power),
but at that point maybe full software priorities aren't too bad either.
We'll see.
