Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489ECC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9312173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfrgdJhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfKFRAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:00:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38609 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732176AbfKFRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:00:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id e2so25236917qkn.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TuUoy8AF5+MQM14Gz0S6Jwy4jFwogd2IsB/lmQVPWOU=;
        b=AfrgdJhVutnHKlbfu7HBPtnX6DELZ9cgqccdljj5em2WkeXm7A+cS4SocjHeEBGrey
         V5js7w0f6AKzhPOP8qngyoMT+q5ClnmhglpUJwzdcerB3rZVe5CIrup1wJYqXSNJp+aV
         K0fVk91f4XrVESCNS8JK7pmXSNRAePxBF6/BEkNOu5fAGE6adJaZ6u6DhWmSM+pciczh
         O4rHYR7nb518D25cuU+DdtAZOzyJhWOHjPZNN4jmXQv4zOD2pz6FZoAB3gg2lKadTRZC
         EPgO75NJk3QkDC5V4/hb8nxR+Kolt+kxnIu/TsXeHFrqzokUcvuo56nRZoX4aL6VpJA7
         VZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TuUoy8AF5+MQM14Gz0S6Jwy4jFwogd2IsB/lmQVPWOU=;
        b=Nvb3KXuJYqFPdfbC5E9by+Xa572j/7/pRHJO/2DeTEv3xDC/5e9VdmzKNvryiikRor
         w/1noBvEHRbVtkf6BTNRxA7Tyt7Mr9S+u70Medwh8P5h6WG25K0gOn1sA1ozl0BYOVhI
         KfoJAwjds7Uwn+o/YjgXLj6WUWKdbBOENKlV5OKze07Pd43UUa8riBY6XuWCDW5LHfUR
         FXM0sBla7S17ZOX6sCmAX/4OJfTJgJgllkLGs2LUJQmQz/L6gb1o/DJt2sPq4JZeQXDg
         fz3SUNZk09hXmdduH3xOH8dWHnRYDsx9oi8EEg02aD2bmx3ARjKWvAarA4cyoYgdFivb
         gWKQ==
X-Gm-Message-State: APjAAAUB9c8gkikS8vkbM0wtQ4mdD7n/jR7xqeDuKJavp2QbqAPyfp85
        HQRQfPpE89iZvMkgsik3lbRF/w==
X-Google-Smtp-Source: APXvYqwwWT8C+swhRztT53AjhPmsd/3onsnkwEvch3jAcYo6eP2coaOnK75ia/480UKp81xboBvi5g==
X-Received: by 2002:a37:9f48:: with SMTP id i69mr2912658qke.273.1573059650812;
        Wed, 06 Nov 2019 09:00:50 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id s123sm11680430qke.31.2019.11.06.09.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:00:50 -0800 (PST)
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
 <CAKfTPtCQXSoR5ohpJvT+esAeXewRDFoBEGGzfgB37_ZWJuKjeQ@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC2FC41.8030308@linaro.org>
Date:   Wed, 6 Nov 2019 12:00:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCQXSoR5ohpJvT+esAeXewRDFoBEGGzfgB37_ZWJuKjeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,
Thanks for the review
On 11/06/2019 03:27 AM, Vincent Guittot wrote:
> Hi Thara,
> 
> 
> On Tue, 5 Nov 2019 at 19:49, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Add interface APIs to initialize, update/average, track, accumulate
>> and decay thermal pressure per cpu basis. A per cpu variable
>> thermal_pressure is introduced to keep track of instantaneous per
>> cpu thermal pressure. Thermal pressure is the delta between maximum
>> capacity and capped capacity due to a thermal event.
>> API trigger_thermal_pressure_average is called for periodic accumulate
>> and decay of the thermal pressure.This API passes on the instantaneous
>> thermal pressure of a cpu to update_thermal_load_avg to do the necessary
>> accumulate, decay and average.
>> API update_thermal_pressure is for the system to update the thermal
>> pressure by providing a capped maximum capacity.
>> Considering, trigger_thermal_pressure_average reads thermal_pressure and
>> update_thermal_pressure writes into thermal_pressure, one can argue for
>> some sort of locking mechanism to avoid a stale value.
>> But considering trigger_thermal_pressure_average can be called from a
>> system critical path like scheduler tick function, a locking mechanism
>> is not ideal. This means that it is possible the thermal_pressure value
>> used to calculate average thermal pressure for a cpu can be
>> stale for upto 1 tick period.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v3->v4:
>>         - Dropped per cpu max_capacity_info struct and instead added a per
>>           delta_capacity variable to store the delta between maximum
>>           capacity and capped capacity. The delta is now calculated when
>>           thermal pressure is updated and not every tick.
>>         - Dropped populate_max_capacity_info api as only per cpu delta
>>           capacity is stored.
>>         - Renamed update_periodic_maxcap to
>>           trigger_thermal_pressure_average and update_maxcap_capacity to
>>           update_thermal_pressure.
>> v4->v5:
>>         - As per Peter's review comments folded thermal.c into fair.c.
>>         - As per Ionela's review comments revamped update_thermal_pressure
>>           to take maximum available capacity as input instead of maximum
>>           capped frequency ration.
>>
>> ---
>>  include/linux/sched.h |  9 +++++++++
>>  kernel/sched/fair.c   | 37 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 263cf08..3c31084 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1993,6 +1993,15 @@ static inline void rseq_syscall(struct pt_regs *regs)
>>
>>  #endif
>>
>> +#ifdef CONFIG_SMP
>> +void update_thermal_pressure(int cpu, unsigned long capped_capacity);
>> +#else
>> +static inline void
>> +update_thermal_pressure(int cpu, unsigned long capped_capacity)
>> +{
>> +}
>> +#endif
>> +
>>  const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
>>  char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
>>  int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 682a754..2e907cc 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -86,6 +86,12 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity       = 1000000UL;
>>
>>  const_debug unsigned int sysctl_sched_migration_cost   = 500000UL;
>>
>> +/*
>> + * Per-cpu instantaneous delta between maximum capacity
>> + * and maximum available capacity due to thermal events.
>> + */
>> +static DEFINE_PER_CPU(unsigned long, thermal_pressure);
>> +
>>  #ifdef CONFIG_SMP
>>  /*
>>   * For asym packing, by default the lower numbered CPU has higher priority.
>> @@ -10401,6 +10407,37 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
>>         return rr_interval;
>>  }
>>
>> +#ifdef CONFIG_SMP
>> +/**
>> + * update_thermal_pressure: Update thermal pressure
>> + * @cpu: the cpu for which thermal pressure is to be updated for
>> + * @capped_capacity: maximum capacity of the cpu after the capping
>> + *                  due to thermal event.
>> + *
>> + * Delta between the arch_scale_cpu_capacity and capped max capacity is
>> + * stored in per cpu thermal_pressure variable.
>> + */
>> +void update_thermal_pressure(int cpu, unsigned long capped_capacity)
>> +{
>> +       unsigned long delta;
>> +
>> +       delta = arch_scale_cpu_capacity(cpu) - capped_capacity;
>> +       per_cpu(thermal_pressure, cpu) = delta;
> 
> use WRITE_ONCE
Will do.
> 
>> +}
>> +#endif
>> +
>> +/**
>> + * trigger_thermal_pressure_average: Trigger the thermal pressure accumulate
>> + *                                  and average algorithm
>> + */
>> +static void trigger_thermal_pressure_average(struct rq *rq)
>> +{
>> +#ifdef CONFIG_SMP
>> +       update_thermal_load_avg(rq_clock_task(rq), rq,
>> +                               per_cpu(thermal_pressure, cpu_of(rq)));
>> +#endif
>> +}
>> +
>>  /*
>>   * All the scheduling class methods:
>>   */
>> --
>> 2.1.4
>>


-- 
Warm Regards
Thara
