Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BFA222C5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfKDOlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:41:51 -0500
Received: from foss.arm.com ([217.140.110.172]:44420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727766AbfKDOlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:41:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE6AE1FB;
        Mon,  4 Nov 2019 06:41:50 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FB063F67D;
        Mon,  4 Nov 2019 06:41:50 -0800 (PST)
Date:   Mon, 4 Nov 2019 14:41:48 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <20191104142609.GA25197@e108754-lin>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-6-git-send-email-thara.gopinath@linaro.org>
 <2b19d7da-412c-932f-7251-110eadbef3e3@arm.com>
 <CAKfTPtCpZq61gQVpATtTdg5hDA+tP4bF6xPMsvHYUMoY+H-6FQ@mail.gmail.com>
 <20191101154612.GA4884@e108754-lin>
 <5DBC9DEF.6030007@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DBC9DEF.6030007@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Friday 01 Nov 2019 at 17:04:47 (-0400), Thara Gopinath wrote:
> On 11/01/2019 11:47 AM, Ionela Voinescu wrote:
> > Hi guys,
> > 
> > On Thursday 31 Oct 2019 at 17:38:25 (+0100), Vincent Guittot wrote:
> >> On Thu, 31 Oct 2019 at 17:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>
> >>> On 22.10.19 22:34, Thara Gopinath wrote:
> >>>> Thermal governors can request for a cpu's maximum supported frequency
> >>>> to be capped in case of an overheat event. This in turn means that the
> >>>> maximum capacity available for tasks to run on the particular cpu is
> >>>> reduced. Delta between the original maximum capacity and capped
> >>>> maximum capacity is known as thermal pressure. Enable cpufreq cooling
> >>>> device to update the thermal pressure in event of a capped
> >>>> maximum frequency.
> >>>>
> >>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> >>>> ---
> >>>>  drivers/thermal/cpu_cooling.c | 31 +++++++++++++++++++++++++++++--
> >>>>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> >>>> index 391f397..2e6a979 100644
> >>>> --- a/drivers/thermal/cpu_cooling.c
> >>>> +++ b/drivers/thermal/cpu_cooling.c
> >>>> @@ -218,6 +218,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
> >>>>  }
> >>>>
> >>>>  /**
> >>>> + * update_sched_max_capacity - update scheduler about change in cpu
> >>>> + *                                   max frequency.
> >>>> + * @policy - cpufreq policy whose max frequency is capped.
> >>>> + */
> >>>> +static void update_sched_max_capacity(struct cpumask *cpus,
> >>>> +                                   unsigned int cur_max_freq,
> >>>> +                                   unsigned int max_freq)
> >>>> +{
> >>>> +     int cpu;
> >>>> +     unsigned long capacity = (cur_max_freq << SCHED_CAPACITY_SHIFT) /
> >>>> +                               max_freq;
> >>>> +
> >>>> +     for_each_cpu(cpu, cpus)
> >>>> +             update_thermal_pressure(cpu, capacity);
> >>>> +}
> >>>> +
> >>>> +/**
> >>>>   * get_load() - get load for a cpu since last updated
> >>>>   * @cpufreq_cdev:    &struct cpufreq_cooling_device for this cpu
> >>>>   * @cpu:     cpu number
> >>>> @@ -320,6 +337,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> >>>>                                unsigned long state)
> >>>>  {
> >>>>       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> >>>> +     int ret;
> >>>>
> >>>>       /* Request state should be less than max_level */
> >>>>       if (WARN_ON(state > cpufreq_cdev->max_level))
> >>>> @@ -331,8 +349,17 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> >>>>
> >>>>       cpufreq_cdev->cpufreq_state = state;
> >>>>
> >>>> -     return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
> >>>> -                             cpufreq_cdev->freq_table[state].frequency);
> >>>> +     ret = dev_pm_qos_update_request
> >>>> +                             (&cpufreq_cdev->qos_req,
> >>>> +                              cpufreq_cdev->freq_table[state].frequency);
> >>>> +
> >>>> +     if (ret > 0)
> >>>> +             update_sched_max_capacity
> >>>> +                             (cpufreq_cdev->policy->cpus,
> >>>> +                              cpufreq_cdev->freq_table[state].frequency,
> >>>> +                              cpufreq_cdev->policy->cpuinfo.max_freq);
> >>>> +
> >>>> +     return ret;
> >>>>  }
> >>>>
> >>>>  /**
> >>>>
> >>>
> >>> Why not getting rid of update_sched_max_capacity() entirely and call
> >>> update_thermal_pressure() in cpu_cooling.c directly? Saves one level in
> >>> the call chain and would mean less code for this feature.
> >>
> >> But you add complexity in update_thermal_pressure which now has to
> >> deal with a cpumask and to compute some frequency ratio
> >> IMHO, it's cleaner to keep update_thermal_pressure simple as it is now
> >>
> > 
> > How about removing update_thermal_pressure altogether and doing all the
> > work in update_sched_max_capacity? That is, have
> > update_sched_max_capacity compute the capped_freq_ratio, do the
> > normalization, and set it per_cpu for all CPUs in the frequency domain.
> > You'll save some calculations that you're now doing in
> > update_thermal_pressure for each cpu and you avoid shifting back and
> > forth.
> 
> Yes.  I can pass the delta to update_thermal_pressure. I will still want
> to keep update_thermal_pressure and a per cpu variable in fair.c to
> store this.
> > 

Why do you want to keep the variable in fair.c? To me this thermal
pressure delta seems more of a CPU thermal characteristic, not a
CFS characteristic, so I would be tempted to define it and set it
in cpu_cooling.c and let fair.c/pelt.c to be just the consumers of
thermal pressure delta, either directly or through some interface.

What do you think?

Thanks,
Ionela.

> > If you're doing so it would be worth renaming update_sched_max_capacity
> > to something like update_sched_thermal_pressure.
> Will do.
> 
> 
> -- 
> Warm Regards
> Thara
