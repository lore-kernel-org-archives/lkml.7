Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF2E21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u8/mt62+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfCOPLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:11:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WH+mhh1U03ZhBYk41Hu8JvupxkfHg7aEqGBgx4656B4=; b=u8/mt62+oDr/gv8PeRPA3/ZWV
        i7utCi1XFwQbgj1ooowqmijDxAn69VoHt3Y0P5YaALED88s3NpU/qleskECUhkkRJvOJ1ijeyTioA
        yfSYshfsDzn4+7BdQEp4ZMYE0mF9eSLLqA/QajYUDlfwQYR7X1oIJrYN1SdWLxXztkTmiNJXp8l4K
        7mQw53BXUi47JWtHSa6fTOnU2Y8up44aEVmOwVuJFJKEhYitGLOAal6OJleNBdopeHefkd/myAvV0
        8DBbg74n7cRnyvAwxLZ8Kxx9fNlVcfJlnqVeeElEgwzcmRaTiV8gGSUlu1BG/2b76Ft83n25h7cMr
        tnO2rsfvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4oUG-0006Uj-Ji; Fri, 15 Mar 2019 15:11:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42A7F236812A9; Fri, 15 Mar 2019 16:11:07 +0100 (CET)
Date:   Fri, 15 Mar 2019 16:11:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Message-ID: <20190315151107.GG6058@hirez.programming.kicks-ass.net>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
 <155232292961.21417.3665243457569518550.stgit@tlendack-t1.amdoffice.net>
 <20190315120311.GX5996@hirez.programming.kicks-ass.net>
 <ef7fb4f8-29a8-16e6-5a8c-18da2eaf4243@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7fb4f8-29a8-16e6-5a8c-18da2eaf4243@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 02:44:32PM +0000, Lendacky, Thomas wrote:

> >> @@ -689,6 +731,7 @@ static __initconst const struct x86_pmu amd_pmu = {
> >>   
> >>   	.amd_nb_constraints	= 1,
> >>   	.wait_on_overflow	= amd_pmu_wait_on_overflow,
> >> +	.mitigate_nmi_latency	= amd_pmu_mitigate_nmi_latency,
> >>   };
> > 
> > Again, you could just do amd_pmu_handle_irq() and avoid an extra
> > callback.
> 
> This is where there would be a bunch of code duplication where I thought
> adding the callback at the end would be better. But if it's best to add
> an AMD handle_irq callback I can do that. I'm easy, let me know if you'd
> prefer that.

Hmm, the thing that avoids you directly using x86_pmu_handle_irq() is
that added active count, but is that not the same as the POPCNT of
cpuc->active_mask?

Is the latency of POPCNT so bad that we need avoid it?

That is, I was thinking of something like:

int amd_pmu_handle_irq(struct pt_regs *regs)
{
	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
	int active = hweight_long(cpuc->active_mask);
	int handled = x86_pmu_handle_irq(regs);

+       if (active <= 1) {
		this_cpu_write(perf_nmi_counter, 0);
+               return handled;
	}
+
+       /*
+        * If a counter was handled, record the number of possible remaining
+        * NMIs that can occur.
+        */
+       if (handled) {
+               this_cpu_write(perf_nmi_counter,
+                              min_t(unsigned int, 2, active - 1));
+
+               return handled;
+       }
+
+       if (!this_cpu_read(perf_nmi_counter))
+               return NMI_DONE;
+
+       this_cpu_dec(perf_nmi_counter);
+
+       return NMI_HANDLED;
}

> > Anyway, we already had code to deal with spurious NMIs from AMD; see
> > commit:
> > 
> >    63e6be6d98e1 ("perf, x86: Catch spurious interrupts after disabling counters")
> > 
> > And that looks to be doing something very much the same. Why then do you
> > still need this on top?
> 
> This can happen while perf is handling normal counter overflow as opposed
> to covering the disabling of the counter case. When multiple counters
> overflow at roughly the same time, but the NMI doesn't arrive in time to
> get collapsed into a pending NMI, the back-to-back support in
> do_default_nmi() doesn't kick in.
> 
> Hmmm... I wonder if the wait on overflow in the disable_all() function
> would eliminate the need for 63e6be6d98e1. That would take a more testing
> on some older hardware to verify. That's something I can look into
> separate from this series.

Yes please, or at least better document the reason for their separate
existence. It's all turning into a bit of magic it seems.
