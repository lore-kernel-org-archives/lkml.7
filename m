Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F4CCA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3586222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQZ+RwOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442913AbfJRPQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:16:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47089 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442717AbfJRPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:16:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so4981642lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lo3UvlHYtf4ozZndPQfhjiOJN5mXwv6pqPJDrdrIjCk=;
        b=FQZ+RwORMJC9WyV8NBFN7wS7R70Z+eklM8epYvWnfuOhY4hOptUVCRR+2RwWBTQjgN
         uEe6sb1E7VbCJfU+eax3BCwMdDosw9yzpBIww2FeGk2BVSlMElvb6m6uWahKChlZGZ3/
         pHSuaBCeuqm23il1Jsc6Gov6B00nO5Ya/rmKGp7HuRZs/+/mme4QePARw9Ez2AtM96ue
         23hC/GryyO1YfPlILLmjgm9TlIqXbqL3Kl0hAWNt8cXQKM87FNWu6QRCE5QO9vF6D+Nz
         isAEE8YA5etqNB4fVKHrGjojTc2La+Goy3rNzXYOVB451dhV6Ek0nCg90L0aK3qDkTPz
         iDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lo3UvlHYtf4ozZndPQfhjiOJN5mXwv6pqPJDrdrIjCk=;
        b=cXkCOtQyjW/+bA6O2xWSxcLlGjMGY+0U2mF+lDWoBaCFq1dCTKps9bfIGTAxrRCqd4
         dB1osxeFb4lqOn9DFv7R6teP8NHCM5fXZUx95bRr+QqKJO/lXGW+Ft/elWcDlUSXNoW9
         iSg+7os3cDTajtK+PvGuMQS/AKHGoMv7WB+aNC5SFQWQwnHpaDoMo3RJO5Q3GYgUTi3F
         xcNS/0xkfNdtgcMEBkGAZpTXNOdljLvgtGqiA0SQvQNpWSenKRmcC+kdfJCUj7dkbH1s
         T04y9MNCDaKLcpxKzRMVFB3ez5rJ1R0hjMotlQjchJ1orMW90A+PULQHW8yBKBQvzHCJ
         QDaA==
X-Gm-Message-State: APjAAAVZG4ZgNrC8+7LIbhH87fM1P98xpndXQ4VBN6t4naCT6ftjCK4g
        2mKWtrPcoZXHtxKkcqqT3lhH8HnaucMFSD8c3ubl4pv/7QM=
X-Google-Smtp-Source: APXvYqy9vhf+OFbOy3GAZCCKcRW3SIGbxO9fNuuHbBaa05VMMBCUMuPllHcKwYHKIgdfmPJNsE9DvaQw3h0oPZyTQew=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr5345113lfg.133.1571411764719;
 Fri, 18 Oct 2019 08:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net> <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net> <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
 <20191017190708.GF22902@worktop.programming.kicks-ass.net>
 <0b807cb3-6a88-1138-dc66-9a32d9bba7ea@arm.com> <20191018120719.GH2328@hirez.programming.kicks-ass.net>
 <32d07c51-847d-9d51-480c-c8836f1aedc7@arm.com>
In-Reply-To: <32d07c51-847d-9d51-480c-c8836f1aedc7@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 18 Oct 2019 17:15:53 +0200
Message-ID: <CAKfTPtATv+TaLus3ggijLWf0KAkexHgpHOTq++iqxaB4jeo-=w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        dh.han@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 at 16:44, Douglas Raillard <douglas.raillard@arm.com> wrote:
>
>
>
> On 10/18/19 1:07 PM, Peter Zijlstra wrote:
> > On Fri, Oct 18, 2019 at 12:46:25PM +0100, Douglas Raillard wrote:
> >
> >>> What I don't see is how that that difference makes sense as input to:
> >>>
> >>>     cost(x) : (1 + x) * cost_j
> >>
> >> The actual input is:
> >> x = (EM_COST_MARGIN_SCALE/SCHED_CAPACITY_SCALE) * (util - util_est)
> >>
> >> Since EM_COST_MARGIN_SCALE == SCHED_CAPACITY_SCALE == 1024, this factor of 1
> >> is not directly reflected in the code but is important for units
> >> consistency.
> >
> > But completely irrelevant for the actual math and conceptual
> > understanding.
>
>  > how that that difference makes sense as input to
> I was unsure if you referred to the units being inconsistent or the
> actual way of computing values being strange, so I provided some
> justification for both.
>
> > Just because computers suck at real numbers, and floats
> > are expensive, doesn't mean we have to burden ourselves with fixed point
> > when writing equations.
> >
> > Also, as a physicist I'm prone to normalizing everything to 1, because
> > that's lazy.
> >
> >>> I suppose that limits the additional OPP to twice the previously
> >>> selected cost / efficiency (see the confusion from that other email).
> >>> But given that efficency drops (or costs rise) for higher OPPs that
> >>> still doesn't really make sense..
> >
> >> Yes, this current limit to +100% freq boosting is somehow arbitrary and
> >> could probably benefit from being tunable in some way (Kconfig option
> >> maybe). When (margin > 0), we end up selecting an OPP that has a higher cost
> >> than the one strictly required, which is expected. The goal is to speed
> >> things up at the expense of more power consumed to achieve the same work,
> >> hence at a lower efficiency (== higher cost).
> >
> > No, no Kconfig knobs.
> >
> >> That's the main reason why this boosting apply a margin on the cost of the
> >> selected OPP rather than just inflating the util. This allows controlling
> >> directly how much more power (battery life) we are going to spend to achieve
> >> some work that we know could be achieved with less power.
> >
> > But you're not; the margin is relative to the OPP, it is not absolute.
>
> Considering a CPU with 1024 max capacity (since we are not talking about
> migrations here, we can ignore CPU invariance):
>
> work = normalized number of iterations of a given busy loop
> # Thanks to freq invariance
> work = util (between 0 and 1)
> util = f/f_max
>
> # f(work) is the min freq that is admissible for "work", which we will
> # abbreviate as "f"
> f(work) = work * f_max
>
> # from struct em_cap_state doc in energy_model.h
> cost(f) = power(f) * f_max / f
> cost(f) = power(f) / util
> cost(f) = power(f) / work
> power(f) = cost(f) * work
>
> boosted_cost(f) = cost(f) + x

In em_pd_get_higher_freq, the boost is a % of cost(f)  so it should be
boosted_cost(f)=cost(f)1+ cost(f)*x

> boosted_power(f) = boosted_cost(f) * work
> boosted_power(f) = (cost(f) + x) * work
>
> # Let's normalize cost() so we can forget about f and deal only with work.
> cost'(work) = cost(f)/cost(f_max)
> x' = x/cost(f_max)
> boosted_power'(work) = (cost'(work) + x') * work
> boosted_power'(work) = cost'(work) * work + x' * work
> boosted_power'(work) = power'(work) + x' * work
> boosted_power'(work) = power'(work) + A(work)
>
> # Over a duration T, spend an extra B unit of energy
> B(work) = A(work) * T
> lost_battery_percent(work) = 100 * B(work)/total_battery_energy
> lost_battery_percent(work) = 100 * T * x' * work /total_battery_energy
> lost_battery_percent(work) =
>   (100 * T / cost(f_max) / total_battery_energy) * x * work
>
> This means that the effect of boosting on battery life is proportional
> to "x" unless I made a mistake somewhere.
>
> >
> > Or rather, the only actual limit is in relation to the max OPP. So you
> > have very little actual control over how much more energy you're
> > spending.
> >
> >>> So while I agree that 2) is a reasonable signal to work from, everything
> >>> that comes after is still much confusing me.
> >
> >> "When applying these boosting rules on the runqueue util signals ...":
> >> Assuming the set of enqueued tasks stays the same between 2 observations
> >> from schedutil, if we see the rq util_avg increase above its
> >> util_est.enqueued, that means that at least one task had its util_avg go
> >> above util_est.enqueued. We might miss some boosting opportunities if some
> >> (util - util_est) compensates:
> >> TASK_1(util - util_est) = - TASK_2(util - util_est)
> >> but working on the aggregated value is much easier in schedutil, to avoid
> >> crawling the list of entities.
> >
> > That still does not explain why 'util - util_est', when >0, makes for a
> > sensible input into an OPP relative function > I agree that 'util - util_est', when >0, indicates utilization is
> > increasing (for the aperiodic blah blah blah). But after that I'm still
> > confused.
>
> For the same reason PELT makes a sensible input for OPP selection.
> Currently, OPP selection is based on max(util_avg, util_est.enqueued)
> (from cpu_util_cfs in sched.h), so as soon as we have
> (util - util_est > 0), the OPP will be selected according to util_avg.
> In a way, using util_avg there is already some kind of boosting.
>
> Since the boosting is essentially (util - constant), it grows the same
> way as util. If we think of (util - util_est) as being some estimation
> of how wrong we were in the estimation of the task "true" utilization of
> the CPU, then it makes sense to feed that to the boost. The wronger we
> were, the more we want to boost, because the more time passes, the more
> the scheduler realizes it actually does not know what the task needs. In
> doubt, provide a higher freq than usual until we get to know this task
> better. When that happens (at the next period), boosting is disabled and
> we revert to the usual behavior (aka margin=0).
>
> Hope we are converging to some wording that makes sense.
