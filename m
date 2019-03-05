Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85652082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfCEMAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:00:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47542 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbfCEMAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:00:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 490C2A78;
        Tue,  5 Mar 2019 04:00:46 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C271D3F71D;
        Tue,  5 Mar 2019 04:00:44 -0800 (PST)
Date:   Tue, 5 Mar 2019 12:00:43 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Message-ID: <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305114406.GV32494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 Mar 2019 at 12:44:06 (+0100), Peter Zijlstra wrote:
> On Tue, Mar 05, 2019 at 11:58:37AM +0100, Rafael J. Wysocki wrote:
> > So after the Peter's patch "sched/cpufreq: Fix 32bit math overflow"
> > I will need to recompute sg_cpu->min in sugov_limits().
> 
> So there's still an open question; do we want that ->min thing to depend
> on available frequencies _at_all_ ?
> 
> I'm thinking it might be a good thing to have the iowait boost curve be
> independent of all that.
> 
> Like said; if we set it at 128 (static), it takes 9 consequtive wake-ups
> for it to reach 1024 (max). While now the curve depends on how wide the
> gap is between min_freq and max_freq. And it seems weird to have this
> behaviour depend on that. To me at least.

I'm not conceptually against it, but that really wants testing I think.
I can already see how we're gonna see regressions: 128 is much lower
than 'min' on my juno for ex, so with the approach you suggest it's
gonna take several wake-up before the iowait stuff does anything at all.
The first steps will all be below the min freq, so they'll just be
transparent, while right now the iowait boost kicks in much faster :/

OTOH, you also have platforms like the recent Snapdragons with 30+ OPPs,
and for them starting at 128 will speed things up.

So maybe what you want is to start at max(min, 128) ?

> Now, I don't know if 128/9 is the right curve, it is just a random
> number I pulled out of a hat. But it seems to make more sense than
> depending on frequencies.

And btw why do you need 9 steps to reach MAX starting from 128 ? If we
double the boost at each wakeup you'll do 128 -> 256 -> 512 -> 1024 no ?

Thanks,
Quentin
