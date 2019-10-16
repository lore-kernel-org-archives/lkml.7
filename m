Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A34FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83A720854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4NT39Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394598AbfJPVWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:22:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44383 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394411AbfJPVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:22:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so24178045qkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FJQPqxpKYu+HvIzg3Pi0OZNwC+XAOSAD85uLZ1RQFVw=;
        b=d4NT39CjoJ4nzBHAfVtCEjnjHwHT/72ldML/DR7UOOKMpGa+fpbW4j1NKroh15Z4yI
         +gpZ3Mt5F3lOr8JkzW23Gc15FCuRT98euDuoQmVVlrA7sgQvH7/ASgySAadTtzeRziyk
         QGe2ZnpW+1wGRT2avQmeFKslEx+2Yz0R9gJo59VwoxMZt+q4gl58JE0HuPvnNOf1LCkx
         yJcH8OL20gKrLOGgqH1G8pNdBGGm8XCEI83zJEZW9sOlZutTMLbiS+Apsu8T7cvl417y
         GFZisAlfpD6e6WBIU3cIxNhr8+QhQeeVB2GpLEju6YnDiBn27UQP/YuJLZKHDjqVlERf
         3d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FJQPqxpKYu+HvIzg3Pi0OZNwC+XAOSAD85uLZ1RQFVw=;
        b=HxQKxZPmf3vxBhU99XEtB+gw6GVcDLMGKOmhR+zv9A/CPrh/f1i84XVTB4L0JajCkj
         e08R4WBpbyUR6D/TVHPFN8Byk4ajljq8B4uO9EiQ8wbZ8pqrBcdfoWBH16yM2+NfFtV+
         qN9P3WrL+C8mpMiqd+MIgBNWYi2Q7/YslPV1qOg1rMc3Br4OS1Ub76RPQWUH9zu2QjwB
         wuavzEGI1LmT948D0S0LAUMU8fa0aiuO1KTk8rC8+xcaGzqnuWFG7qFXbbptg+fCS8Fx
         CMBNnKfb3dYqJtEZAoQwHkUsxlqvkKdC5lICpEmvKGTMK0GQD5LRzxrmF4mYBus9NdsI
         JcOg==
X-Gm-Message-State: APjAAAUyN5GjoNuzQ3gxT/D7VCpn5uiyOhrNOKCyMhKUVYzGq/9tnsmc
        hB1L9l8IbxAgGOO3h0UOyBU6Cw==
X-Google-Smtp-Source: APXvYqxxNSWeChR6/VJsEH6JrlJ+uL2u6vlcvENLPwAlph2+D04jagUSl5rbfQNsNeJ9uWTUVhj3jQ==
X-Received: by 2002:a37:68e:: with SMTP id 136mr35254qkg.211.1571260954965;
        Wed, 16 Oct 2019 14:22:34 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id x59sm175614qte.20.2019.10.16.14.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 14:22:34 -0700 (PDT)
Subject: Re: [Patch v3 2/7] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
 <1571014705-19646-3-git-send-email-thara.gopinath@linaro.org>
 <CAKfTPtD13=7VNvZBt9nMwMTg=_2xfJsEAApfFKagwKikh9g6-Q@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DA78A18.9050801@linaro.org>
Date:   Wed, 16 Oct 2019 17:22:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD13=7VNvZBt9nMwMTg=_2xfJsEAApfFKagwKikh9g6-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Thanks for the review
On 10/14/2019 11:50 AM, Vincent Guittot wrote:
> Hi Thara,
> 
> On Mon, 14 Oct 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Add thermal.c and thermal.h files that provides interface
>> APIs to initialize, update/average, track, accumulate and decay
>> thermal pressure per cpu basis. A per cpu structure max_capacity_info is
>> introduced to keep track of instantaneous per cpu thermal pressure.
>> Thermal pressure is the delta between max_capacity and cap_capacity.
>> API update_periodic_maxcap is called for periodic accumulate and decay
>> of the thermal pressure. It is to to be called from a periodic tick
>> function. This API calculates the delta between max_capacity and
>> cap_capacity and passes on the delta to update_thermal_avg to do the
>> necessary accumulate, decay and average. API update_maxcap_capacity is for
>> the system to update the thermal pressure by updating cap_capacity.
>> Considering, update_periodic_maxcap reads cap_capacity and
>> update_maxcap_capacity writes into cap_capacity, one can argue for
>> some sort of locking mechanism to avoid a stale value.
>> But considering update_periodic_maxcap can be called from a system
>> critical path like scheduler tick function, a locking mechanism is not
>> ideal. This means that it is possible the value used to
>> calculate average thermal pressure for a cpu can be stale for upto 1
>> tick period.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  include/linux/sched.h  | 14 +++++++++++
>>  kernel/sched/Makefile  |  2 +-
>>  kernel/sched/thermal.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/sched/thermal.h | 13 ++++++++++
>>  4 files changed, 94 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/sched/thermal.c
>>  create mode 100644 kernel/sched/thermal.h
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 2c2e56b..875ce2b 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1983,6 +1983,20 @@ static inline void rseq_syscall(struct pt_regs *regs)
>>
>>  #endif
>>
>> +#ifdef CONFIG_SMP
>> +void update_maxcap_capacity(int cpu, u64 capacity);
>> +
>> +void populate_max_capacity_info(void);
>> +#else
>> +static inline void update_maxcap_capacity(int cpu, u64 capacity)
>> +{
>> +}
>> +
>> +static inline void populate_max_capacity_info(void)
>> +{
>> +}
>> +#endif
>> +
>>  const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
>>  char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
>>  int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
>> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
>> index 21fb5a5..4d3b820 100644
>> --- a/kernel/sched/Makefile
>> +++ b/kernel/sched/Makefile
>> @@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
>>  obj-y += idle.o fair.o rt.o deadline.o
>>  obj-y += wait.o wait_bit.o swait.o completion.o
>>
>> -obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
>> +obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o thermal.o
>>  obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
>>  obj-$(CONFIG_SCHEDSTATS) += stats.o
>>  obj-$(CONFIG_SCHED_DEBUG) += debug.o
>> diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
>> new file mode 100644
>> index 0000000..5f0b2d4
>> --- /dev/null
>> +++ b/kernel/sched/thermal.c
>> @@ -0,0 +1,66 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Sceduler Thermal Interactions
>> + *
>> + *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
>> + */
>> +
>> +#include <linux/sched.h>
>> +#include "sched.h"
>> +#include "pelt.h"
>> +#include "thermal.h"
>> +
>> +struct max_capacity_info {
>> +       unsigned long max_capacity;
>> +       unsigned long cap_capacity;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct max_capacity_info, max_cap);
>> +
>> +void update_maxcap_capacity(int cpu, u64 capacity)
>> +{
>> +       struct max_capacity_info *__max_cap;
>> +       unsigned long __capacity;
>> +
>> +       __max_cap = (&per_cpu(max_cap, cpu));
>> +       if (!__max_cap) {
>> +               pr_err("no max_capacity_info structure for cpu %d\n", cpu);
>> +               return;
>> +       }
>> +
>> +       /* Normalize the capacity */
>> +       __capacity = (capacity * arch_scale_cpu_capacity(cpu)) >>
>> +                                                       SCHED_CAPACITY_SHIFT;
>> +       pr_debug("updating cpu%d capped capacity from %lu to %lu\n", cpu, __max_cap->cap_capacity, __capacity);
>> +
>> +       __max_cap->cap_capacity = __capacity;
>> +}
>> +
>> +void populate_max_capacity_info(void)
>> +{
>> +       struct max_capacity_info *__max_cap;
>> +       u64 capacity;
>> +       int cpu;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               __max_cap = (&per_cpu(max_cap, cpu));
>> +               if (!__max_cap)
>> +                       continue;
>> +               capacity = arch_scale_cpu_capacity(cpu);
>> +               __max_cap->max_capacity = capacity;
>> +               __max_cap->cap_capacity = capacity;
>> +               pr_debug("cpu %d max capacity set to %ld\n", cpu, __max_cap->max_capacity);
>> +       }
>> +}
> 
> everything above seems to be there for the cpu cooling device and
> should be included in it instead. The scheduler only need the capacity
> capping
> The cpu cooling device should just set the delta capacity in the
> per-cpu variable (see my comment below)
It can be a firmware  updating the thermal pressure instead of cpu
cooling device. Or may be some other entity .So instead of replicating
this code, isnt't it better to reside in one place ?
> 
>> +
>> +void update_periodic_maxcap(struct rq *rq)
>> +{
>> +       struct max_capacity_info *__max_cap = (&per_cpu(max_cap, cpu_of(rq)));
>> +       unsigned long delta;
>> +
>> +       if (!__max_cap)
>> +               return;
>> +
>> +       delta = __max_cap->max_capacity - __max_cap->cap_capacity;
> 
> Why don't you just save the delta in the per_cpu variable instead of
> the struct max_capacity_info ? You have to compute the delta every
> tick whereas we can expect it to not change that much compared to the
> number of tick.

Again I think thermal pressure can be applied from other entities like
firmware as well. But  I agree with your point that calculating delta
every tick is not a good idea. How about I move it to
update_maxcap_capacity so that delta is calculate every time an update
comes from cpu cooling device or anybody else ?

Warm Regards
Thara

