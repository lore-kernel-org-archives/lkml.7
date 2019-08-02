Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA7FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFED2216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FgfI9M5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfHBQdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:33:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfHBQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=POb9S0P8wt5FGDQBsksiLIQ4LHAbMykwcFNaxiHaxxk=; b=FgfI9M5YrkQCEuIQlLEUcXuEH
        aXDrUrgG/bZZK/rYRCwrpoWbDQg/rYNyXQIDgekl8JI8zXmo4L3g7vBMOYyjmc0OAnV2/kpWWmbBm
        pe48TTWl4lmSEsKrJB6iID/iGBFCdhwX5Rqqhk37hDDzfCH8wHpxOBsXRy2tsFQb6y+Dax/amtbzU
        7nE0GkJ3oaRzj+loS3URDS8fCOaPJnIHMdKvZebkNmsmaqqIV88eNdcIC8VHXH+wg3he4DqoudqDb
        La9Xtk2Xr1vIlZqQ/Y7nYivHyCUzxCTKBipIJpG7xGdZUZkiVTxD5Lr6NXSqbNCNvvCyhEIilpFBy
        NsKUiaWhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htaUk-0004ad-Ka; Fri, 02 Aug 2019 16:33:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2261F20293EA8; Fri,  2 Aug 2019 18:33:28 +0200 (CEST)
Date:   Fri, 2 Aug 2019 18:33:28 +0200
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
Message-ID: <20190802163328.GB2349@hirez.programming.kicks-ass.net>
References: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com>
 <20190801211613.GB3578@hirez.programming.kicks-ass.net>
 <b4597324-6eb8-31fa-e911-63f3b704c974@amd.com>
 <alpine.DEB.2.21.1908012331550.1789@nanos.tec.linutronix.de>
 <20190801214813.GB2332@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1908012352390.1789@nanos.tec.linutronix.de>
 <925c3458-aeae-a44b-ddd5-40a1e173a307@amd.com>
 <20190802162015.GA2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802162015.GA2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:20:15PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 02:33:41PM +0000, Lendacky, Thomas wrote:

> > Talking to the hardware folks, they say setting CR8 is a serializing
> > instruction and has to communicate out to the APIC, so it's better to
> > use CLI/STI.
> 
> Bah; the Intel SDM states: "MOV CR* instructions, except for MOV CR8,
> are serializing instructions", which had given me a little hope.
> 
> At the same time, all these chips still have the APIC TPR field too, so
> much like how the TSC DEADLINE MSR is a hidden APIC write, so too is CR8
> I suppose :-(
> 
> I'll still finish the patches I started, just to see what it would look
> like.

Another 'fun' issue I ran into while doing these patches; STI has a 1
instruction shadow, which we rely on, MOV CR8 does not. So things like:

native_safe_halt:
	sti
	hlt

turn into:

native_safe_halt:
	cli
	movl $0, %rax
	movq %rax, %cr8
	sti
	hlt


