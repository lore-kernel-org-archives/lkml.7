Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE5DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199792083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IqUZGSv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfHAVQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:16:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731215AbfHAVQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EZXce6cOD3FTt98c3sHEiiueY94deZ0x0a8/aE0Lgak=; b=IqUZGSv9HwjLQh3ZuafUskFss
        +T+/sLRusmbLHTe2sD+av+zKS1Mcqo+HRx27gq9n6Zi8CilCPGl+ru9+cws2GpKTY3ZXHovY1b+vw
        MGyw7zs1kF/lr71OG26XdEHZDJiri9UuIgIn1QzcIqBTOd+fFPOl1nKbH/kcuw8pigBIFd7jrq7tY
        IcUITYiX/g7dgrvNZ856IKLJAuEZj4wvKwz/y6ujysLbhlSumNTPMNsftM1yKUEOb3Cpi1GATWPPX
        CCe1Ji0GLmS30jbrkyEBx1j3Nzg9EXUYEsVW7MRCzVz02ccsv9oYY5+ruiWroBIgP0/Cjv9D8TAOC
        EjivxMciA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htIQp-0004Jm-Ki; Thu, 01 Aug 2019 21:16:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E458B2029F4C9; Thu,  1 Aug 2019 23:16:13 +0200 (CEST)
Date:   Thu, 1 Aug 2019 23:16:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Message-ID: <20190801211613.GB3578@hirez.programming.kicks-ass.net>
References: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 06:57:41PM +0000, Lendacky, Thomas wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> It turns out that the NMI latency workaround from commit 6d3edaae16c6
> ("x86/perf/amd: Resolve NMI latency issues for active PMCs") ends up
> being too conservative and results in the perf NMI handler claiming NMIs
> to easily on AMD hardware when the NMI watchdog is active.
> 
> This has an impact, for example, on the hpwdt (HPE watchdog timer) module.
> This module can produce an NMI that is used to reset the system. It
> registers an NMI handler for the NMI_UNKNOWN type and relies on the fact
> that nothing has claimed an NMI so that its handler will be invoked when
> the watchdog device produces an NMI. After the referenced commit, the
> hpwdt module is unable to process its generated NMI if the NMI watchdog is
> active, because the current NMI latency mitigation results in the NMI
> being claimed by the perf NMI handler.
> 
> Update the AMD perf NMI latency mitigation workaround to, instead, use a
> window of time. Whenever a PMC is handled in the perf NMI handler, set a
> timestamp which will act as a perf NMI window. Any NMIs arriving within
> that window will be claimed by perf. Anything outside that window will
> not be claimed by perf. The value for the NMI window is set to 100 msecs.
> This is a conservative value that easily covers any NMI latency in the
> hardware. While this still results in a window in which the hpwdt module
> will not receive its NMI, the window is now much, much smaller.

Blergh, I so hate all this. The proposed patch is basically duct tape.

The horribly retarded x86 NMI infrastructure strikes again :/

Tom; do you have any idea how expensive it is to twiddle CR8 and play
games with interrupt priorities instead of piling world + dog on this
one NMI line? (as compared to CLI/STI)
