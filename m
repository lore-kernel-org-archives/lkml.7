Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC6ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BBD21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfKAPrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:47:23 -0400
Received: from foss.arm.com ([217.140.110.172]:37726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfKAPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:47:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C153328;
        Fri,  1 Nov 2019 08:47:22 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F01CB3F719;
        Fri,  1 Nov 2019 08:47:21 -0700 (PDT)
Date:   Fri, 1 Nov 2019 15:47:20 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [Patch v4 5/6] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
Message-ID: <20191101154612.GA4884@e108754-lin>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-6-git-send-email-thara.gopinath@linaro.org>
 <2b19d7da-412c-932f-7251-110eadbef3e3@arm.com>
 <CAKfTPtCpZq61gQVpATtTdg5hDA+tP4bF6xPMsvHYUMoY+H-6FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCpZq61gQVpATtTdg5hDA+tP4bF6xPMsvHYUMoY+H-6FQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Thursday 31 Oct 2019 at 17:38:25 (+0100), Vincent Guittot wrote:
> On Thu, 31 Oct 2019 at 17:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >
> > On 22.10.19 22:34, Thara Gopinath wrote:
> > > Thermal governors can request for a cpu's maximum supported frequency
> > > to be capped in case of an overheat event. This in turn means that the
> > > maximum capacity available for tasks to run on the particular cpu is
> > > reduced. Delta between the original maximum capacity and capped
> > > maximum capacity is known as thermal pressure. Enable cpufreq cooling
> > > device to update the thermal pressure in event of a capped
> > > maximum frequency.
> > >
> > > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > > ---
> > >  drivers/thermal/cpu_cooling.c | 31 +++++++++++++++++++++++++++++--
> > >  1 file changed, 29 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > > index 391f397..2e6a979 100644
> > > --- a/drivers/thermal/cpu_cooling.c
> > > +++ b/drivers/thermal/cpu_cooling.c
> > > @@ -218,6 +218,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
> > >  }
> > >
> > >  /**
> > > + * update_sched_max_capacity - update scheduler about change in cpu
> > > + *                                   max frequency.
> > > + * @policy - cpufreq policy whose max frequency is capped.
> > > + */
> > > +static void update_sched_max_capacity(struct cpumask *cpus,
> > > +                                   unsigned int cur_max_freq,
> > > +                                   unsigned int max_freq)
> > > +{
> > > +     int cpu;
> > > +     unsigned long capacity = (cur_max_freq << SCHED_CAPACITY_SHIFT) /
> > > +                               max_freq;
> > > +
> > > +     for_each_cpu(cpu, cpus)
> > > +             update_thermal_pressure(cpu, capacity);
> > > +}
> > > +
> > > +/**
> > >   * get_load() - get load for a cpu since last updated
> > >   * @cpufreq_cdev:    &struct cpufreq_cooling_device for this cpu
> > >   * @cpu:     cpu number
> > > @@ -320,6 +337,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> > >                                unsigned long state)
> > >  {
> > >       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> > > +     int ret;
> > >
> > >       /* Request state should be less than max_level */
> > >       if (WARN_ON(state > cpufreq_cdev->max_level))
> > > @@ -331,8 +349,17 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> > >
> > >       cpufreq_cdev->cpufreq_state = state;
> > >
> > > -     return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
> > > -                             cpufreq_cdev->freq_table[state].frequency);
> > > +     ret = dev_pm_qos_update_request
> > > +                             (&cpufreq_cdev->qos_req,
> > > +                              cpufreq_cdev->freq_table[state].frequency);
> > > +
> > > +     if (ret > 0)
> > > +             update_sched_max_capacity
> > > +                             (cpufreq_cdev->policy->cpus,
> > > +                              cpufreq_cdev->freq_table[state].frequency,
> > > +                              cpufreq_cdev->policy->cpuinfo.max_freq);
> > > +
> > > +     return ret;
> > >  }
> > >
> > >  /**
> > >
> >
> > Why not getting rid of update_sched_max_capacity() entirely and call
> > update_thermal_pressure() in cpu_cooling.c directly? Saves one level in
> > the call chain and would mean less code for this feature.
> 
> But you add complexity in update_thermal_pressure which now has to
> deal with a cpumask and to compute some frequency ratio
> IMHO, it's cleaner to keep update_thermal_pressure simple as it is now
> 

How about removing update_thermal_pressure altogether and doing all the
work in update_sched_max_capacity? That is, have
update_sched_max_capacity compute the capped_freq_ratio, do the
normalization, and set it per_cpu for all CPUs in the frequency domain.
You'll save some calculations that you're now doing in
update_thermal_pressure for each cpu and you avoid shifting back and
forth.

If you're doing so it would be worth renaming update_sched_max_capacity
to something like update_sched_thermal_pressure.

Thanks,
Ionela.

> >
> > Just compile tested on arm64:
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 3211b4d3a899..bf36995013b0 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -217,23 +217,6 @@ static u32 cpu_power_to_freq(struct
> > cpufreq_cooling_device *cpufreq_cdev,
> >         return freq_table[i - 1].frequency;
> >  }
> >
> > -/**
> > - * update_sched_max_capacity - update scheduler about change in cpu
> > - *                                     max frequency.
> > - * @policy - cpufreq policy whose max frequency is capped.
> > - */
> > -static void update_sched_max_capacity(struct cpumask *cpus,
> > -                                     unsigned int cur_max_freq,
> > -                                     unsigned int max_freq)
> > -{
> > -       int cpu;
> > -       unsigned long capacity = (cur_max_freq << SCHED_CAPACITY_SHIFT) /
> > -                                 max_freq;
> > -
> > -       for_each_cpu(cpu, cpus)
> > -               update_thermal_pressure(cpu, capacity);
> > -}
> > -
> >  /**
> >   * get_load() - get load for a cpu since last updated
> >   * @cpufreq_cdev:      &struct cpufreq_cooling_device for this cpu
> > @@ -353,7 +336,7 @@ static int cpufreq_set_cur_state(struct
> > thermal_cooling_device *cdev,
> >                                 cpufreq_cdev->freq_table[state].frequency);
> >
> >         if (ret > 0)
> > -               update_sched_max_capacity
> > +               update_thermal_pressure
> >                                 (cpufreq_cdev->policy->cpus,
> >                                  cpufreq_cdev->freq_table[state].frequency,
> >                                  cpufreq_cdev->policy->cpuinfo.max_freq);
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 55dfe9634f67..5707813c7621 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1985,9 +1985,9 @@ static inline void rseq_syscall(struct pt_regs *regs)
> >  #endif
> >
> >  #ifdef CONFIG_SMP
> > -void update_thermal_pressure(int cpu, u64 capacity);
> > +void update_thermal_pressure(struct cpumask *cpus, unsigned int cur,
> > unsigned int max);
> >  #else
> > -static inline void update_thermal_pressure(int cpu, u64 capacity)
> > +static inline void update_thermal_pressure(struct cpumask *cpus,
> > unsigned int cur, unsigned int max);
> >  {
> >  }
> >  #endif
> > diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
> > index 0da31e12a5ff..691bdd79597a 100644
> > --- a/kernel/sched/thermal.c
> > +++ b/kernel/sched/thermal.c
> > @@ -43,17 +43,16 @@ static DEFINE_PER_CPU(unsigned long, delta_capacity);
> >   * the arch_scale_cpu_capacity and capped capacity is stored in per cpu
> >   * delta_capacity.
> >   */
> > -void update_thermal_pressure(int cpu, u64 capped_freq_ratio)
> > +void update_thermal_pressure(struct cpumask *cpus, unsigned int cur,
> > unsigned int max)
> >  {
> > -       unsigned long __capacity, delta;
> > +       int cpu;
> >
> > -       /* Normalize the capped freq ratio */
> > -       __capacity = (capped_freq_ratio * arch_scale_cpu_capacity(cpu)) >>
> > -
> > SCHED_CAPACITY_SHIFT;
> > -       delta = arch_scale_cpu_capacity(cpu) -  __capacity;
> > -       pr_debug("updating cpu%d thermal pressure to %lu\n", cpu, delta);
> > +       for_each_cpu(cpu, cpus) {
> > +               unsigned long scale_cap = arch_scale_cpu_capacity(cpu);
> > +               unsigned long cur_cap = cur * scale_cap / max;
> >
> > -       per_cpu(delta_capacity, cpu) = delta;
> > +               per_cpu(delta_capacity, cpu) = scale_cap - cur_cap;
> > +       }
> >  }
