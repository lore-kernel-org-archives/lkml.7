Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2917AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC2122CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r2UC0aW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1Mr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:47:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1Mr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yo8ksqnEdWgOiS8sAppighLlFSGFqNAL1t3ArNRPpJo=; b=r2UC0aW9eqIw0+a2m7yQZmq/r
        4c4MTWXyyZvHAzXtuaKaMHRgEfLkxiHfJ+sdktKPL/NOPc9W+JXWwfDY1S1Z4MsTog0HHOHrPQSj7
        +uO2h5BdOAYxBExgrQ798Ap9wh+BCJe1lneyjdIpxY/yPQR5jmg7PTtHhGF6mA7Jowe20cbySGp72
        sTiFapICYcQmY7lnuJ9HZRQmpWD9i+fjtzxuMz3IrC5BEkTN5KNBr9yOozWnjN3vPvdGCI2imFdbf
        AkyzbTf9P3A5GXTfHAl6hMpHZM+n5U4UX75eE3LwvobhmE5QHIgVyUGKfavmIUBToI47wiFXlx5Av
        akpIROLEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2xMT-0003s8-Nl; Wed, 28 Aug 2019 12:47:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD2E03070F4;
        Wed, 28 Aug 2019 14:47:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3AF320C7995E; Wed, 28 Aug 2019 14:47:38 +0200 (CEST)
Date:   Wed, 28 Aug 2019 14:47:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Martin Liska <mliska@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [RFC] perf/x86/amd: add support for Large Increment per Cycle
 Events
Message-ID: <20190828124738.GN2332@hirez.programming.kicks-ass.net>
References: <20190826195915.30680-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826195915.30680-1-kim.phillips@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 02:59:15PM -0500, Kim Phillips wrote:
> The core AMD PMU has a 4-bit wide per-cycle increment for each
> performance monitor counter.  That works for most counters, but
> now with AMD Family 17h and above processors, for some, more than 15
> events can occur in a cycle.  Those events are called "Large
> Increment per Cycle" events, and one example is the number of
> SSE/AVX FLOPs retired (event code 0x003).  In order to count these
> events, two adjacent h/w PMCs get their count signals merged
> to form 8 bits per cycle total. 

*groan*

> In addition, the PERF_CTR count
> registers are merged to be able to count up to 64 bits.

That is daft; why can't you extend the existing MSR to 64bit?

> Normally, events like instructions retired, get programmed on a single
> counter like so:
> 
> PERF_CTL0 (MSR 0xc0010200) 0x000000000053ff0c # event 0x0c, umask 0xff
> PERF_CTR0 (MSR 0xc0010201) 0x0000800000000001 # r/w 48-bit count
> 
> The next counter at MSRs 0xc0010202-3 remains unused, or can be used
> independently to count something else.
> 
> When counting Large Increment per Cycle events, such as FLOPs,
> however, we now have to reserve the next counter and program the
> PERF_CTL (config) register with the Merge event (0xFFF), like so:
> 
> PERF_CTL0 (msr 0xc0010200) 0x000000000053ff03 # FLOPs event, umask 0xff
> PERF_CTR0 (msr 0xc0010201) 0x0000800000000001 # read 64-bit count, wr low 48b
> PERF_CTL1 (msr 0xc0010202) 0x0000000f004000ff # Merge event, enable bit
> PERF_CTR1 (msr 0xc0010203) 0x0000000000000000 # write higher 16-bits of count
> 
> The count is widened from the normal 48-bits to 64 bits by having the
> second counter carry the higher 16 bits of the count in its lower 16
> bits of its counter register.  Support for mixed 48- and 64-bit counting
> is not supported in this version.

This is diguisting.. please talk to your hardware people. I sort of
understand the pairing, but that upper 16 bit split for writes is just
woeful crap.

> For more details, search a Family 17h PPR for the "Large Increment per
> Cycle Events" section, e.g., section 2.1.15.3 on p. 173 in this version:
> 
> https://www.amd.com/system/files/TechDocs/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06.zip

My mama told me not to open random zip files of the interweb :-)

Also; afaict the only additional information there is that it works in
odd/even pairs and you have to program the odd one before the even one.
Surely you could've included that here.

> In order to support reserving the extra counter for a single Large
> Increment per Cycle event in the perf core, we:
> 
> 1. Add a f17h get_event_constraints() that returns only an even counter
> bitmask, since Large Increment events can only be placed on counters 0,
> 2, and 4 out of the currently available 0-5.

So hereby you promise that all LI events are unconstrained, right?
Also, what marks the paired counter in the used mask? Aaah, you modify
__perf_sched_find_counter(). Comments below.

> 2. We add a commit_scheduler hook that adds the Merge event (0xFFF) to
> any Large Increment event being scheduled.  If the event being scheduled
> is not a Large Increment event, we check for, and remove any
> pre-existing Large Increment events on the next counter.

That is weird at best; the scheduling hooks shouldn't be the one doing
the programming; that should be done in x86_pmu_enable(). Can't you do
this by changing amd_pmu::{en,dis}able() ?

(also; we really should rename some of those x86_pmu::ops :/)

> 3. In the main x86 scheduler, we reduce the number of available
> counters by the number of Large Increment per Cycle events being added.
> This improves the counter scheduler success rate.
> 
> 4. In perf_assign_events(), if a counter is assigned to a Large
> Increment event, we increment the current counter variable, so the
> counter used for the Merge event is skipped.
> 
> 5. In find_counter(), if a counter has been found for the
> Large Increment event, we set the next counter as used, to
> prevent other events from using it.
> 
> A side-effect of assigning a new get_constraints function for f17h
> disables calling the old (prior to f15h) amd_get_event_constraints
> implementation left enabled by commit e40ed1542dd7 ("perf/x86: Add perf
> support for AMD family-17h processors"), which is no longer
> necessary since those North Bridge events are obsolete.

> RFC because I'd like input on the approach, including how to add support
> for mixed-width (48- and 64-bit) counting for a single PMU.

Ideally I'd tell you to wait for sane hardware :/


> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 325959d19d9a..4596c141f348 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -787,6 +787,18 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
>  		if (!__test_and_set_bit(idx, sched->state.used)) {
>  			if (sched->state.nr_gp++ >= sched->max_gp)
>  				return false;
> +			if (c->flags & PERF_X86_EVENT_LARGE_INC) {

Can we please call that something like:

  PERF_X86_EVENT_PAIR

> +				/*
> +				 * merged events need the Merge event
> +				 * on the next counter
> +				 */
> +				if (__test_and_set_bit(idx + 1,
> +						       sched->state.used))
> +					/* next counter already used */
> +					return false;

Coding Style wants { } there. Also, remove that line-break.

> +
> +				set_bit(idx + 1, sched->state.used);

  __set_bit() surely

> +			}
>  
>  			goto done;
>  		}
> @@ -849,14 +861,20 @@ int perf_assign_events(struct event_constraint **constraints, int n,
>  			int wmin, int wmax, int gpmax, int *assign)
>  {
>  	struct perf_sched sched;
> +	struct event_constraint *c;
> +
>  
>  	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax);
>  
>  	do {
>  		if (!perf_sched_find_counter(&sched))
>  			break;	/* failed */
> -		if (assign)
> +		if (assign) {
>  			assign[sched.state.event] = sched.state.counter;
> +			c = constraints[sched.state.event];
> +			if (c->flags & PERF_X86_EVENT_LARGE_INC)
> +				sched.state.counter++;
> +		}

How about you make __perf_sched_find_count() set the right value? That
already knows it did this.

>  	} while (perf_sched_next_event(&sched));
>  
>  	return sched.state.unassigned;
> @@ -952,6 +970,18 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>  		    READ_ONCE(cpuc->excl_cntrs->exclusive_present))
>  			gpmax /= 2;
>  
> +		/*
> +		 * reduce the amount of available counters
> +		 * to allow fitting the Merge event along
> +		 * with their large increment event
> +		 */
> +		if (x86_pmu.flags & PMU_FL_MERGE) {
> +			for (i = 0; i < n; i++) {
> +				hwc = &cpuc->event_list[i]->hw;
> +				if (is_lg_inc_event(hwc) && gpmax > 1)

It should not be possible to hit !gpmax; make that a WARN.

> +					gpmax--;
> +			}

Alternatively you could have collect_events() cound the number of
'lg_inc' (we really have to come up with a better name) events on the
cpuc. Then you can do a simple subtraction and avoid the loop.

> +		}
>  		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
>  					     wmax, gpmax, assign);
>  	}
> @@ -1210,6 +1240,13 @@ int x86_perf_event_set_period(struct perf_event *event)
>  
>  	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
>  
> +	/*
> +	 * Clear the Merge event counter's upper 16 bits since
> +	 * we currently declare a 48-bit counter width
> +	 */
> +	if (is_lg_inc_event(hwc))
> +		wrmsrl(x86_pmu_event_addr(idx + 1), 0);
> +

*yuck*...

>  	/*
>  	 * Due to erratum on certan cpu we need
>  	 * a second write to be sure the register
