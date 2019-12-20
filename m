Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71380C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456D02467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nxRC6vIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLTMKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:10:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTMKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KbKhic6DG6g1sX8JWDudtfs+C3tiHerCOEO+CnBD9sY=; b=nxRC6vIVdwGeKgGE22melBUwK
        OApsX33BLQTOrgU2CbaCPQ1FEkzTWjOr5zhO5C0h/HfGMx4TWNtnG0DFZShmjkuSca2+A1hqlofN7
        0ZtM49dBXI+Eoqg0fmGSRH0i42/U1IQY4+ucJ4Y0GcFpi5i/2TGwBGFnIAWyam5BJBtT0bDZLStIw
        D1CP8LnfjsvCJ5vGJysykJagxDNP48AwnqNOOiS+nLb09ElrGjtIOQSLQakca+mKH9jUOqteJyXqf
        ua94o/CrcFDEF+r/NznZvikiMtK3fPHY43Sur9o8KujAgwmUIWis9l1Fm/m/2sGb0G8Y/zGnuk66+
        wDJvpR2xQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiH6K-0000r0-9E; Fri, 20 Dec 2019 12:09:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DD5A300DB7;
        Fri, 20 Dec 2019 13:08:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 691D320E0710C; Fri, 20 Dec 2019 13:09:45 +0100 (CET)
Date:   Fri, 20 Dec 2019 13:09:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 2/2] perf/x86/amd: Add support for Large Increment per
 Cycle Events
Message-ID: <20191220120945.GG2844@hirez.programming.kicks-ass.net>
References: <20191114183720.19887-1-kim.phillips@amd.com>
 <20191114183720.19887-3-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114183720.19887-3-kim.phillips@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 12:37:20PM -0600, Kim Phillips wrote:

I still hate the naming on this, "large increment per cycle" is just a
random bunch of words collected by AMD marketing or somesuch. It doesn't
convey the fundamental point that counters get paired. So I've done a
giant bunch of search and replace on it for you.

> @@ -621,6 +622,8 @@ void x86_pmu_disable_all(void)
>  			continue;
>  		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>  		wrmsrl(x86_pmu_config_addr(idx), val);
> +		if (is_large_inc(hwc))
> +			wrmsrl(x86_pmu_config_addr(idx + 1), 0);
>  	}
>  }
>  

See, the above makes sense, it doesn't assume anything about where
config for idx and config for idx+1 are, and then here:

> @@ -855,6 +871,9 @@ static inline void x86_pmu_disable_event(struct perf_event *event)
>  	struct hw_perf_event *hwc = &event->hw;
>  
>  	wrmsrl(hwc->config_base, hwc->config);
> +
> +	if (is_large_inc(hwc))
> +		wrmsrl(hwc->config_base + 2, 0);
>  }

You hard-code the offset as being 2. I fixed that for you.

> @@ -849,14 +862,19 @@ int perf_assign_events(struct event_constraint **constraints, int n,
>  			int wmin, int wmax, int gpmax, int *assign)
>  {
>  	struct perf_sched sched;
> +	struct event_constraint *c;
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
>  	} while (perf_sched_next_event(&sched));
>  
>  	return sched.state.unassigned;

I'm still confused by this bit. AFAICT it serves no purpose.
perf_sched_next_event() will reset sched->state.counter to 0 on every
pass anyway.

I've deleted it for you.

> @@ -926,10 +944,14 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>  			break;
>  
>  		/* not already used */
> -		if (test_bit(hwc->idx, used_mask))
> +		if (test_bit(hwc->idx, used_mask) || (is_large_inc(hwc) &&
> +		    test_bit(hwc->idx + 1, used_mask)))
>  			break;
>  
>  		__set_bit(hwc->idx, used_mask);
> +		if (is_large_inc(hwc))
> +			__set_bit(hwc->idx + 1, used_mask);
> +
>  		if (assign)
>  			assign[i] = hwc->idx;
>  	}

This is just really sad.. fixed that too.

Can you verify the patches in:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/amd

work?
