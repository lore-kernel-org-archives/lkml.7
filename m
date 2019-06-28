Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD2EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7F20665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfF1KIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:08:23 -0400
Received: from foss.arm.com ([217.140.110.172]:44232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfF1KIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:08:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A58AC28;
        Fri, 28 Jun 2019 03:08:21 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34F523F718;
        Fri, 28 Jun 2019 03:08:20 -0700 (PDT)
Date:   Fri, 28 Jun 2019 11:08:14 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization
 increases
Message-ID: <20190628100751.lpcwsouacsi2swkm@e110439-lin>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-Jun 13:40, Vincent Guittot wrote:
> Hi Patrick,
> 
> On Thu, 20 Jun 2019 at 17:06, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > The estimated utilization for a task is currently defined based on:
> >  - enqueued: the utilization value at the end of the last activation
> >  - ewma:     an exponential moving average which samples are the enqueued values
> >
> > According to this definition, when a task suddenly change it's bandwidth
> > requirements from small to big, the EWMA will need to collect multiple
> > samples before converging up to track the new big utilization.
> >
> > Moreover, after the PELT scale invariance update [1], in the above scenario we
> > can see that the utilization of the task has a significant drop from the first
> > big activation to the following one. That's implied by the new "time-scaling"
> 
> Could you give us more details about this? I'm not sure to understand
> what changes between the 1st big activation and the following one ?

We are after a solution for the problem Douglas Raillard discussed at
OSPM, specifically the "Task util drop after 1st idle" highlighted in
slide 6 of his presentation:

  http://retis.sssup.it/ospm-summit/Downloads/02_05-Douglas_Raillard-How_can_we_make_schedutil_even_more_effective.pdf

which shows what happens with a task switches from 5% to 75% and
we get these start/end values for each activation:

  Act     Time          __comm  __cpu  __pid    task    util_avg
  --------------------------------------------------------------
  1       2.813559  	<idle>	    4	   0	step_up	      45
          2.902624	step_up	    4	2574	step_up	     665
  --------------------------------------------------------------
  2       2.903722	<idle>	    4	   0	step_up	     289
          2.917385	step_up	    4	2574	step_up	     452
  --------------------------------------------------------------
  3       2.919725	<idle>	    4	   0	step_up	     418
          2.953764	step_up	    4	2574	step_up	     658
  --------------------------------------------------------------
  4       2.954248	<idle>	    4	   0	step_up	     537
          2.967955	step_up	    4	2574	step_up	     645
  --------------------------------------------------------------
  5       2.970248	<idle>	    4	   0	step_up	     597
          2.983914	step_up	    4	2574	step_up	     692
  --------------------------------------------------------------
  6       2.986248	<idle>	    4	   0	step_up	     640
          2.999924	step_up	    4	2574	step_up	     725
  --------------------------------------------------------------
  7       3.002248	<idle>	    4	   0	step_up	     670
          3.015872	step_up	    4	2574	step_up	     749
  --------------------------------------------------------------
  8       3.018248	<idle>	    4	   0	step_up	     694
          3.030474	step_up	    4	2574	step_up	     767
  --------------------------------------------------------------
  9       3.034247	<idle>	    4	   0	step_up	     710
          3.046454	step_up	    4	2574	step_up	     780
  --------------------------------------------------------------

Since the first activation is running at lower-than-max OPPs we do
"time-scaling" at the end of the activation. Util_avg starts at 45
and ramps up to 665 but then it drops 375 units down to 289 at the
beginning of the second activation.

The second activation has a chance to run at higher OPPs, but still
not at max. Util_avg starts at 289 and ramps up to 452, which is even
lower then the previous max value, but then it drops 34 units down to
418.

The following activations have a similar pattern but util_avg
converges toward the final value, we run almost always at the highest
OPP and the drops are defined mainly by the expected PELT decay.

> The utilization implied by new "time-scaling" should be the same as
> always running at max frequency with previous  method

Right, the problem we are tacking with this patch however is to
make util_est a better signal for the ramp-up phases.

Right now util_est "fixes" only the second activation, since:

   max(util_avg, last_value, ewma) =
   max(289, 665, <289) = 665

and thus we keep running on the highest OPP we reached at the end of
the first activation.

While at the start of the third activation:

   max(util_avg, last_value, ewma) =
   max(452, 418, <452) = 452

and this time we drop the OPP quite a lot despite the signal still
being ramping up.

> > mechanisms instead of the previous "delta-scaling" approach.
> >

That happens because the EWMA takes multiple activations to converge
up, which means it's not very helping much:

> > Unfortunately, these drops cannot be fully absorbed by the current util_est
> > implementation. Indeed, the low-frequency filtering introduced by the "ewma" is
> > entirely useless while converging up and it does not help in stabilizing sooner
> > the PELT signal.

The idea of the patch is to exploit two observations:

 1. the default scheduler behavior is to be performance oriented
 2. the longher you run a task underprovisioned, the higher the
    util_avg will be

Which turns into:

> > To make util_est do better service in the above scenario, do change its
> > definition to slow down only utilization decreases. Do that by resetting the
> > "ewma" every time the last collected sample increases.
> >
> > This change makes also the default util_est implementation more aligned with
> > the major scheduler behavior, which is to optimize for performance.
> > In the future, this implementation can be further refined to consider
> > task specific hints.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
