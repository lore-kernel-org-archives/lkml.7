Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B628AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980572086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405696AbfHBJrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:47:35 -0400
Received: from foss.arm.com ([217.140.110.172]:47980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405660AbfHBJrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:47:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A90344;
        Fri,  2 Aug 2019 02:47:32 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B75B03F575;
        Fri,  2 Aug 2019 02:47:30 -0700 (PDT)
Date:   Fri, 2 Aug 2019 10:47:25 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190802094725.ploqfarz7fj7vrtp@e110439-lin>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin>
 <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <20190628140057.7aujh2wsk7wtqib3@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628140057.7aujh2wsk7wtqib3@e110439-lin>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Vincent,
is there anything different I can do on this?

Cheers,
Patrick

On 28-Jun 15:00, Patrick Bellasi wrote:
> On 28-Jun 14:38, Peter Zijlstra wrote:
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
> > second (EWMA in our case) will always lag/delay the input of the first
> > (PELT).
> > 
> > The time-scaling thing might make matters worse, because that helps PELT
> > ramp up faster, but that is not the primary issue.
> 
> Sure, we like the new time-scaling PELT which ramps up faster and, as
> long as we have idle time, it's better in predicting what would be the
> utilization as if we was running at max OPP.
> 
> However, the experiment above shows that:
> 
>  - despite the task being a 75% after a certain activation, it takes
>    multiple activations for PELT to actually enter that range.
> 
>  - the first activation ends at 665, 10% short wrt the configured
>    utilization
> 
>  - while the PELT signal converge toward the 75%, we have some pretty
>    consistent drops at wakeup time, especially after the first big
>    activation.
> 
> > Or am I missing something?
> 
> I'm not sure the above happens because of a problem in the new
> time-scaling PELT, I actually think it's kind of expected given the
> way we re-scale time contributions depending on the current OPPs.
> 
> It's just that a 375 drops in utilization with just 1.1ms sleep time
> looks to me more related to the time-scaling invariance then just the
> normal/expected PELT decay.
> 
>    Could it be an out-of-sync issue between the PELT time scaling code
>    and capacity scaling code?
>    Perhaps due to some OPP changes/notification going wrong?
> 
> Sorry for not being much more useful on that, maybe Vincent has some
> better ideas.
> 
> The only thing I've kind of convinced myself is that an EWMA on
> util_est does not make a lot of sense for increasing utilization
> tracking.
> 
> Best,
> Patrick
> 
> -- 
> #include <best/regards.h>
> 
> Patrick Bellasi

-- 
#include <best/regards.h>

Patrick Bellasi
