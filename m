Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609FFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6872820869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKsQAYyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392992AbfJQIpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:45:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36087 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390755AbfJQIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:45:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so1654696ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItBSkDkFlIf7Y4QAdu4FQKgiJKgpLtsnbcGId+19Zfg=;
        b=EKsQAYylLuVeahodbEz1+6ekXjIz6QSi0UnXtrHFouR6oFQ/HNNiXeVZeS35gwIFPu
         n86Gi53vq4CI/QjdHdhAm1wmfCJ4ZgN9fJfnqJ7H8vEOA5CAHqEdaMuAII2zOLiHn/WE
         V7Zjqx+8nvs1iDqc2hafBoLUh44Rt6zUEiuXWZwPLbVLVMg3RaSF9o/Gl8kCUIgJ7vS6
         6MiZ20CXeSsNy9aJOizp1VvaHV5VGXBFkNR6vHJPlR4bj/UpdDOWAjoWmSKS0oe5yv2y
         oNttego39KAi/cp4g2Q/iJ1zxXev+RmzXnL5MvWIcpGREXyd/gMwRKRRwmK4JCpuQBMD
         ksaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItBSkDkFlIf7Y4QAdu4FQKgiJKgpLtsnbcGId+19Zfg=;
        b=BR9Bp3las90sdT3S0Y7ZKqGlYg0RJGEwP3Jgd0D6WQ9uwYV3cFCieI7B9O4jjvwTKu
         h0JEM5R4/E0PeM69qRcbwcpL/1SeWcKjqRPx2maCnimfIlxtLlWiN6UUMAJBY4Ls/+/4
         Lrg4eT+N5F2KPR+U6NOs5/wAjhibWgF2RySXLA5ly39Q93SXfs/O+sIuF7mfMnp4VWkm
         eOXrPJXsb29mx4jB2K27vaaGXcS13EQtnMgznOe8eaM3Vukgad3G8/QRTDaQrJY/+hbr
         fr8qqspObc8jG8EaGgryD0R+oVxlXnOOjj8k3f3CqW2H7QlIDcDAtt1tngQoJ4TFcOgM
         Py+Q==
X-Gm-Message-State: APjAAAUT05h8TsU98v0srr+L1HhUEmGb0tkZBmfRGp0ENPy/RAagIaoZ
        Rafc50XaNiwVb6WxRNsOktxsakBYTuGofh6uV4MFyQ==
X-Google-Smtp-Source: APXvYqwIH8A0mJLroaiIHWswO5Rugdt+Ph9Ddbg2QKcDIc70ayGXsUXqxIEHKyiaK8xJte6nYcxlQMl+xa8F5SR131E=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr1649486ljo.193.1571301906457;
 Thu, 17 Oct 2019 01:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
 <1571014705-19646-3-git-send-email-thara.gopinath@linaro.org>
 <CAKfTPtD13=7VNvZBt9nMwMTg=_2xfJsEAApfFKagwKikh9g6-Q@mail.gmail.com> <5DA78A18.9050801@linaro.org>
In-Reply-To: <5DA78A18.9050801@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Oct 2019 10:44:54 +0200
Message-ID: <CAKfTPtCHdrbCKePHxhOm3w2gNO4X7q7Dt-UXQLDRn-39Wk1OLQ@mail.gmail.com>
Subject: Re: [Patch v3 2/7] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Wed, 16 Oct 2019 at 23:22, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Hi Vincent,
>
> Thanks for the review
> On 10/14/2019 11:50 AM, Vincent Guittot wrote:
> > Hi Thara,
> >
> > On Mon, 14 Oct 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> >>
> >> Add thermal.c and thermal.h files that provides interface
> >> APIs to initialize, update/average, track, accumulate and decay
> >> thermal pressure per cpu basis. A per cpu structure max_capacity_info is
> >> introduced to keep track of instantaneous per cpu thermal pressure.
> >> Thermal pressure is the delta between max_capacity and cap_capacity.
> >> API update_periodic_maxcap is called for periodic accumulate and decay
> >> of the thermal pressure. It is to to be called from a periodic tick
> >> function. This API calculates the delta between max_capacity and
> >> cap_capacity and passes on the delta to update_thermal_avg to do the
> >> necessary accumulate, decay and average. API update_maxcap_capacity is for
> >> the system to update the thermal pressure by updating cap_capacity.
> >> Considering, update_periodic_maxcap reads cap_capacity and
> >> update_maxcap_capacity writes into cap_capacity, one can argue for
> >> some sort of locking mechanism to avoid a stale value.
> >> But considering update_periodic_maxcap can be called from a system
> >> critical path like scheduler tick function, a locking mechanism is not
> >> ideal. This means that it is possible the value used to
> >> calculate average thermal pressure for a cpu can be stale for upto 1
> >> tick period.
> >>
> >> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> >> ---
> >>  include/linux/sched.h  | 14 +++++++++++
> >>  kernel/sched/Makefile  |  2 +-
> >>  kernel/sched/thermal.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  kernel/sched/thermal.h | 13 ++++++++++
> >>  4 files changed, 94 insertions(+), 1 deletion(-)
> >>  create mode 100644 kernel/sched/thermal.c
> >>  create mode 100644 kernel/sched/thermal.h
> >>
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index 2c2e56b..875ce2b 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -1983,6 +1983,20 @@ static inline void rseq_syscall(struct pt_regs *regs)
> >>
> >>  #endif
> >>
> >> +#ifdef CONFIG_SMP
> >> +void update_maxcap_capacity(int cpu, u64 capacity);
> >> +
> >> +void populate_max_capacity_info(void);
> >> +#else
> >> +static inline void update_maxcap_capacity(int cpu, u64 capacity)
> >> +{
> >> +}
> >> +
> >> +static inline void populate_max_capacity_info(void)
> >> +{
> >> +}
> >> +#endif
> >> +
> >>  const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
> >>  char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
> >>  int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
> >> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> >> index 21fb5a5..4d3b820 100644
> >> --- a/kernel/sched/Makefile
> >> +++ b/kernel/sched/Makefile
> >> @@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
> >>  obj-y += idle.o fair.o rt.o deadline.o
> >>  obj-y += wait.o wait_bit.o swait.o completion.o
> >>
> >> -obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
> >> +obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o thermal.o
> >>  obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
> >>  obj-$(CONFIG_SCHEDSTATS) += stats.o
> >>  obj-$(CONFIG_SCHED_DEBUG) += debug.o
> >> diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
> >> new file mode 100644
> >> index 0000000..5f0b2d4
> >> --- /dev/null
> >> +++ b/kernel/sched/thermal.c
> >> @@ -0,0 +1,66 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Sceduler Thermal Interactions
> >> + *
> >> + *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
> >> + */
> >> +
> >> +#include <linux/sched.h>
> >> +#include "sched.h"
> >> +#include "pelt.h"
> >> +#include "thermal.h"
> >> +
> >> +struct max_capacity_info {
> >> +       unsigned long max_capacity;
> >> +       unsigned long cap_capacity;
> >> +};
> >> +
> >> +static DEFINE_PER_CPU(struct max_capacity_info, max_cap);
> >> +
> >> +void update_maxcap_capacity(int cpu, u64 capacity)
> >> +{
> >> +       struct max_capacity_info *__max_cap;
> >> +       unsigned long __capacity;
> >> +
> >> +       __max_cap = (&per_cpu(max_cap, cpu));
> >> +       if (!__max_cap) {
> >> +               pr_err("no max_capacity_info structure for cpu %d\n", cpu);
> >> +               return;
> >> +       }
> >> +
> >> +       /* Normalize the capacity */
> >> +       __capacity = (capacity * arch_scale_cpu_capacity(cpu)) >>
> >> +                                                       SCHED_CAPACITY_SHIFT;
> >> +       pr_debug("updating cpu%d capped capacity from %lu to %lu\n", cpu, __max_cap->cap_capacity, __capacity);
> >> +
> >> +       __max_cap->cap_capacity = __capacity;
> >> +}
> >> +
> >> +void populate_max_capacity_info(void)
> >> +{
> >> +       struct max_capacity_info *__max_cap;
> >> +       u64 capacity;
> >> +       int cpu;
> >> +
> >> +       for_each_possible_cpu(cpu) {
> >> +               __max_cap = (&per_cpu(max_cap, cpu));
> >> +               if (!__max_cap)
> >> +                       continue;
> >> +               capacity = arch_scale_cpu_capacity(cpu);
> >> +               __max_cap->max_capacity = capacity;
> >> +               __max_cap->cap_capacity = capacity;
> >> +               pr_debug("cpu %d max capacity set to %ld\n", cpu, __max_cap->max_capacity);
> >> +       }
> >> +}
> >
> > everything above seems to be there for the cpu cooling device and
> > should be included in it instead. The scheduler only need the capacity
> > capping
> > The cpu cooling device should just set the delta capacity in the
> > per-cpu variable (see my comment below)
> It can be a firmware  updating the thermal pressure instead of cpu
> cooling device. Or may be some other entity .So instead of replicating
> this code, isnt't it better to reside in one place ?

But you have now idea which kind of metrics will be provided by
firmware. It might not be a capped frequency and a max frequency but
other metrics.
Also, __max_cap->max_capacity just save in a new per cpu struct the
return of arch_scale_cpu_capacity but this doesn't give us real
benefit




> >
> >> +
> >> +void update_periodic_maxcap(struct rq *rq)
> >> +{
> >> +       struct max_capacity_info *__max_cap = (&per_cpu(max_cap, cpu_of(rq)));
> >> +       unsigned long delta;
> >> +
> >> +       if (!__max_cap)
> >> +               return;
> >> +
> >> +       delta = __max_cap->max_capacity - __max_cap->cap_capacity;
> >
> > Why don't you just save the delta in the per_cpu variable instead of
> > the struct max_capacity_info ? You have to compute the delta every
> > tick whereas we can expect it to not change that much compared to the
> > number of tick.
>
> Again I think thermal pressure can be applied from other entities like
> firmware as well. But  I agree with your point that calculating delta
> every tick is not a good idea. How about I move it to
> update_maxcap_capacity so that delta is calculate every time an update
> comes from cpu cooling device or anybody else ?
>
> Warm Regards
> Thara
>
