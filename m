Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9A0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D654E20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCGLDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:03:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43862 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCGLDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:03:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F15E0EBD;
        Thu,  7 Mar 2019 03:03:01 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52B823F706;
        Thu,  7 Mar 2019 03:03:00 -0800 (PST)
Date:   Thu, 7 Mar 2019 11:02:58 +0000
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
Message-ID: <20190307110256.padefvq4e52ly3nm@queper01-lin>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
 <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net>
 <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
 <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
 <20190305173746.p32xolcpueudlzwn@queper01-lin>
 <CAJZ5v0jJxMw6_6Ep=fee8VGEbqpFKQtA2kX5t1scNwX3GhaTTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jJxMw6_6Ep=fee8VGEbqpFKQtA2kX5t1scNwX3GhaTTg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wednesday 06 Mar 2019 at 11:05:47 (+0100), Rafael J. Wysocki wrote:
> Please recall that the iowait boosting algo was different to start
> with, though: it jumped to the max right away and then backed off.
> That turned out to be overly aggressive in general and led to some
> undesired "jittery" behavior, which is why it was changed.
> 
> Thus it looks like the platforms on which it still jumps to the max
> right away may actually benefit from changing it to more steps. :-)

On the energy side of things at least ... ;-)

> In turn, the platforms where it takes more than 3 steps for the boost
> to get to the max would get a slight performance improvement from this
> changes and I'm not sure why that could be bad.

For energy possibly ? IIUC this thread:

    https://patchwork.kernel.org/patch/9735885/

the original intent of the ramp thing for the iowait boost was to reduce
power consumption.

> Moreover, it didn't depend on the min originally, just on the max and
> just because I wanted the number of backoff steps needed to go back
> down to zero to be independent of the platform IIRC.  The dependency
> on the min is sort of artificial here and leads to arbitrary
> differences in behavior between different platforms which isn't
> particularly fortunate.

It's a question of perspective I would say. Right now you can say the
behaviour is somewhat coherent across platforms: getting an IOWAIT boost
means you'll run twice as fast regardless of your board. With the '128
approach', you may or may not run faster, depending on your set of OPPs.

Also on recent big little SoCs, the capacity ratio can be pretty high.
You can get little CPUs with 300 of capacity or so. The arbitrary 128
thing is basically gonna go near max freq in one step, although the CPUs
actually 20 available OPPs or so. And I guess that's a shame.

For these reasons, I feel like it's not completely idiotic to have a
platform-dependent starting point, although arguably min_freq might not
always be the best choice.

> With all of that in mind, I would go right away to making the boost
> independent of min and max (the final number of steps to reach the max
> is TBD in practice, but 3 looks like a good enough compromise to me).

Perhaps the energy model could help find a good starting point, and a
good number of steps ?

FWIW there should be a slot at OSPM to discuss how sugov could be made
smarter using the EM :-).

> FWIW, the internal governor in intel_pstate has been changed along
> these lines already (the changes is waiting for Linus to pull it ATM).

Thanks,
Quentin
