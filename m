Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2844208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfF1OKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:10:16 -0400
Received: from foss.arm.com ([217.140.110.172]:48680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1OKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:10:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891092B;
        Fri, 28 Jun 2019 07:10:15 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10DAB3F706;
        Fri, 28 Jun 2019 07:10:13 -0700 (PDT)
Date:   Fri, 28 Jun 2019 15:10:11 +0100
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
Message-ID: <20190628141011.d4oo5ezp4kxgrfnn@e110439-lin>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin>
 <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <CAKfTPtCyC5R40xjzQjp8qJchay9WzucuE4E-CduR46tNBh0uRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCyC5R40xjzQjp8qJchay9WzucuE4E-CduR46tNBh0uRg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-Jun 15:51, Vincent Guittot wrote:
> On Fri, 28 Jun 2019 at 14:38, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jun 28, 2019 at 11:08:14AM +0100, Patrick Bellasi wrote:
> > > On 26-Jun 13:40, Vincent Guittot wrote:
> > > > Hi Patrick,
> > > >
> > > > On Thu, 20 Jun 2019 at 17:06, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > > >
> > > > > The estimated utilization for a task is currently defined based on:
> > > > >  - enqueued: the utilization value at the end of the last activation
> > > > >  - ewma:     an exponential moving average which samples are the enqueued values
> > > > >
> > > > > According to this definition, when a task suddenly change it's bandwidth
> > > > > requirements from small to big, the EWMA will need to collect multiple
> > > > > samples before converging up to track the new big utilization.
> > > > >
> > > > > Moreover, after the PELT scale invariance update [1], in the above scenario we
> > > > > can see that the utilization of the task has a significant drop from the first
> > > > > big activation to the following one. That's implied by the new "time-scaling"
> > > >
> > > > Could you give us more details about this? I'm not sure to understand
> > > > what changes between the 1st big activation and the following one ?
> > >
> > > We are after a solution for the problem Douglas Raillard discussed at
> > > OSPM, specifically the "Task util drop after 1st idle" highlighted in
> > > slide 6 of his presentation:
> > >
> > >   http://retis.sssup.it/ospm-summit/Downloads/02_05-Douglas_Raillard-How_can_we_make_schedutil_even_more_effective.pdf
> > >
> >
> > So I see the problem, and I don't hate the patch, but I'm still
> > struggling to understand how exactly it related to the time-scaling
> > stuff. Afaict the fundamental problem here is layering two averages. The
> 
> AFAICT, it's not related to the time-scaling
> 
> In fact the big 1st activation happens because task runs at low OPP
> and hasn't enough time to finish its running phase before the time to
> begin the next one happens. This means that the task will run several
> computations phase in one go which is no more a 75% task.

But in that case, running multiple activations back to back, should we
not expect the util_avg to exceed the 75% mark?


> From a pelt PoV, the task is far larger than a 75% task and its
> utilization too because it runs far longer (even after scaling time
> with frequency).

Which thus should match my expectation above, no?

> Once cpu reaches a high enough OPP that enable to have sleep phase
> between each running phases, the task load tracking comes back to the
> normal slope increase (the one that would have happen if task would
> have jump from 5% to 75% but already running at max OPP)


Indeed, I can see from the plots a change in slope. But there is also
that big drop after the first big activation: 375 units in 1.1ms.

Is that expected? I guess yes, since we fix the clock_pelt with the
lost_idle_time.


> > second (EWMA in our case) will always lag/delay the input of the first
> > (PELT).
> >
> > The time-scaling thing might make matters worse, because that helps PELT
> > ramp up faster, but that is not the primary issue.
> >
> > Or am I missing something?

-- 
#include <best/regards.h>

Patrick Bellasi
