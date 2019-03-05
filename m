Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947E620661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCERhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:37:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51386 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfCERhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:37:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02F49A78;
        Tue,  5 Mar 2019 09:37:52 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9263F703;
        Tue,  5 Mar 2019 09:37:50 -0800 (PST)
Date:   Tue, 5 Mar 2019 17:37:48 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Message-ID: <20190305173746.p32xolcpueudlzwn@queper01-lin>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net>
 <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
 <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 Mar 2019 at 18:02:25 (+0100), Rafael J. Wysocki wrote:
> But that 128 needs to be compared to
> 
> (SCHED_CAPACITY_SCALE * cpuinfo.min_freq) / cpuinfo.max_freq
> 
> so with SCHED_CAPACITY_SCALE equal to 1024 this means max_freq 8x
> higher than min_freq.  That is not totally unreasonable IMO and
> because sg_cpu->iowait_boost grows exponentially, the difference
> between 8x and, say, 4x is one iteration.
> 
> > The first steps will all be below the min freq, so they'll just be
> > transparent, while right now the iowait boost kicks in much faster :/
> 
> There can be one iteration of a difference this way or that way AFAICS
> and I'm not even sure how much of a performance difference that makes
> in practice.

Yeah I don't expect that to have a huge impact TBH but it'd be nice to
actually get numbers to verify that, that's all I'm saying :-)

You have 'funny' platforms like Juno r0 out there where the min/max
frequencies are 450MHz/850Mhz. In this case, starting from 128 you'll
need 3 wake-ups to reach what is currently the starting point. I'm not
sure if the impact is visible or not, but it's worth checking.

> OTOH I fundamentally don't see why the iowait boost should ramp up
> faster on CPUs having a higher max_freq to min_freq ratio.  Say you
> have two platforms, both with max_freq of 2 GHz and with min_freq
> equal to 250 MHz and 500 MHz, respectively.  The ratios in question
> will be 8 and 4 then, so the first one will reliably react 50% slower
> to iowait than the second one for no particular reason at all.
>
> > OTOH, you also have platforms like the recent Snapdragons with 30+ OPPs,
> > and for them starting at 128 will speed things up.
> >
> > So maybe what you want is to start at max(min, 128) ?
> 
> That's not just min, though, or is it?

I'm not sure to get the question, so just to make sure it's clearer, I
was suggesting to do something along the lines of:

	sg_cpu->min = max(min_freq * 1024 / max_freq, 128);

That basically just prevents you from starting too low -- some boards,
unlike juno, have tons of OPPs on the lower end of the curve so these
might benefit from getting a higher starting point. But then perhaps
this is in fact a good illustration of the issue of having different
ramp-up speeds depending on the min_freq so ... :-)

Thanks,
Quentin
