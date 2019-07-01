Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A274C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549CE208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfGAIxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:53:55 -0400
Received: from foss.arm.com ([217.140.110.172]:57808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfGAIxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:53:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025172B;
        Mon,  1 Jul 2019 01:53:54 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84D1C3F718;
        Mon,  1 Jul 2019 01:53:52 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:53:50 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization
 increases
Message-ID: <20190701085350.y5wrnatm3tscifkn@e110439-lin>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin>
 <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <CAKfTPtCyC5R40xjzQjp8qJchay9WzucuE4E-CduR46tNBh0uRg@mail.gmail.com>
 <20190628141011.d4oo5ezp4kxgrfnn@e110439-lin>
 <CAKfTPtDeR7+-ah4KiQVu7SQAns0yvumr4_mqGiVsVGhSs+v34A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDeR7+-ah4KiQVu7SQAns0yvumr4_mqGiVsVGhSs+v34A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Jun 10:43, Vincent Guittot wrote:
> On Fri, 28 Jun 2019 at 16:10, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > On 28-Jun 15:51, Vincent Guittot wrote:
> > > On Fri, 28 Jun 2019 at 14:38, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Fri, Jun 28, 2019 at 11:08:14AM +0100, Patrick Bellasi wrote:
> > > > > On 26-Jun 13:40, Vincent Guittot wrote:

Hi Vincent,

[...]

> > > AFAICT, it's not related to the time-scaling
> > >
> > > In fact the big 1st activation happens because task runs at low OPP
> > > and hasn't enough time to finish its running phase before the time to
> > > begin the next one happens. This means that the task will run several
> > > computations phase in one go which is no more a 75% task.
> >
> > But in that case, running multiple activations back to back, should we
> > not expect the util_avg to exceed the 75% mark?
> 
> But task starts with a very low value and Pelt needs time to ramp up.

Of course...

[...]

> > > Once cpu reaches a high enough OPP that enable to have sleep phase
> > > between each running phases, the task load tracking comes back to the
> > > normal slope increase (the one that would have happen if task would
> > > have jump from 5% to 75% but already running at max OPP)
> >
> >
> > Indeed, I can see from the plots a change in slope. But there is also
> > that big drop after the first big activation: 375 units in 1.1ms.
> >
> > Is that expected? I guess yes, since we fix the clock_pelt with the
> > lost_idle_time.

... but, I guess Peter was mainly asking about the point above: is
that "big" drop after the first activation related to time-scaling or
not?

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
