Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64C2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38362084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HUWGuBn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfDBNDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:03:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDBNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bkI6wtwbI4zlHn2VxpbeYXycvAF/xS79oyZQbXRpWjI=; b=HUWGuBn1/p24gvo4+F7u0lbai
        bRKpQY/kNMl18YOwZnwLvdvH0jQ2PU8B1VLqqmqT6PNKB/7e7+1OgYuw8BM8ytVKlGOP445RJOQ5o
        OGWcsugC5V4RQBFH32olZi+FLfcNOt8Z7VuzuU2sA9WWvzVsdlkWzlAEGD3j2Bxb2YFftwUf/dmV+
        VoSAbdD/hpww/QeYtJPO5lmaf24fe4yl9Q6otlNVf6xO3EDz2m9C+3kaHxNx9ImBceZZzP/bqfjFz
        HHlRxCjen49Jp+rKPRlN3ccEzizp/iDlwaVA6FwPOgLaN7i6qpUYGOOEIEWxisfxXf+Pxniu6Ikow
        ZxBNxaXfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBJ4D-0001y3-0i; Tue, 02 Apr 2019 13:03:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F98528B73FE1; Tue,  2 Apr 2019 15:03:02 +0200 (CEST)
Date:   Tue, 2 Apr 2019 15:03:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>, gorcunov@gmail.com,
        Vince Weaver <vince@deater.net>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Message-ID: <20190402130302.GL12232@hirez.programming.kicks-ass.net>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 09:46:33PM +0000, Lendacky, Thomas wrote:
> This patch series addresses issues with increased NMI latency in newer
> AMD processors that can result in unknown NMI messages when PMC counters
> are active.
> 
> The following fixes are included in this series:
> 
> - Resolve a race condition when disabling an overflowed PMC counter,
>   specifically when updating the PMC counter with a new value.
> - Resolve handling of active PMC counter overflows in the perf NMI
>   handler and when to report that the NMI is not related to a PMC.
> - Remove earlier workaround for spurious NMIs by re-ordering the
>   PMC stop sequence to disable the PMC first and then remove the PMC
>   bit from the active_mask bitmap. As part of disabling the PMC, the
>   code will wait for an overflow to be reset.
> 
> The last patch re-works the order of when the PMC is removed from the
> active_mask. There was a comment from a long time ago about having
> to clear the bit in active_mask before disabling the counter because
> the perf NMI handler could re-enable the PMC again. Looking at the
> handler today, I don't see that as possible, hence the reordering. The
> question will be whether the Intel PMC support will now have issues.
> There is still support for using x86_pmu_handle_irq() in the Intel
> core.c file. Did Intel have any issues with spurious NMIs in the past?
> Peter Z, any thoughts on this?

I can't remember :/ I suppose we'll see if anything pops up after these
here patches. At least then we get a chance to properly document things.

> Also, I couldn't completely get rid of the "running" bit because it
> is used by arch/x86/events/intel/p4.c. An old commit comment that
> seems to indicate the p4 code suffered the spurious interrupts:
> 03e22198d237 ("perf, x86: Handle in flight NMIs on P4 platform").
> So maybe that partially answers my previous question...

Yeah, the P4 code is magic, and I don't have any such machines left, nor
do I think does Cyrill who wrote much of that.

I have vague memories of the P4 thing crashing with Vince's perf_fuzzer,
but maybe I'm wrong.

Ideally we'd find a willing victim to maintain that thing, or possibly
just delete it, dunno if anybody still cares.


Anyway, I like these patches, but I cannot apply since you send them
base64 encoded and my script chokes on that.
