Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A13C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4AD2343D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUWX54lU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfH3XTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:19:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34361 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfH3XTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:19:01 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so17459452ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8J01/EAVyRK3VJ3MaUx1xLzUlE5JyUjMH9q9tVtOmA=;
        b=kUWX54lUDrTuq0GKwNh+Ib3vo8f/hLay9UM4yRX8nHz9Y3cXQonDE/h596QwVU5TeS
         VSiO/+Q/0Rv8QcshZ2Fi0B+aNhdoLl363iD6+f9+66oaG3Vt6DKTcVmW054UwVEB0DeA
         VrkWptg0IEiyywJ7ORnsAHVcbJaZMdNY2wPfl0p1ZbzfEEEv9OXzeiLFDnZnsDJgWG/X
         dCeF4VsNVQ7EXVnoqGWx+CPV91DPZvdA4va+ezs5CcoQm7WhXSS+YWOnA015VijgFR1p
         ETdbPvDHcug66eOdjfiMhONEfrd6mhC3GVOsdmrNwZ6OxgspULtYsJFm0+VhWPHBf5J9
         PrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8J01/EAVyRK3VJ3MaUx1xLzUlE5JyUjMH9q9tVtOmA=;
        b=Ie8rQ8TJzaZcrDXc3+EO37w7v288JsanJdGzWUTjRtlwHvQeKrIBs9p5fjjJb0BCct
         FviZX2CPo5ago9WOhWMjaK21OqyD1zgzpJow8TmSYUAf+WaMBzies2Keam+Z++/k3UrF
         ygHu3XEvWppmfaJ3bB0LZwenw2TeKpVWvOL9RSiy60xJKHOEbRADVNZowFxN8a8nzk/J
         aqJvB/8kA4UoP+7034KdFDj+/27P5iH5ftqRj/bH4YGJ0phO0uRSk/W3OItpgtGw7ozO
         EB49KvmePyBSfdI79gXYGLNh5rkcfb/O3YNEsnbOoEMMM4WGeBt3tQFnK5z9WD0b2ASi
         M8hw==
X-Gm-Message-State: APjAAAXsS/qEXW51bfhGSeug5F0144ehdFmdAqoj7mZUeYH2Swj+/mOp
        h0KidV0ZFkYPcd/Rbg+Y5lqfudYPi+xE5/Qu2IM0dg==
X-Google-Smtp-Source: APXvYqwM0v80oGAvv37h60UScn7BtXO/S3Rmk7eaZ540RvYkzJUXXLqKTtzde56UOpDoKM3H9oTZDKBjTWH7VbiQ8sY=
X-Received: by 2002:a5e:a90f:: with SMTP id c15mr4259109iod.41.1567207138977;
 Fri, 30 Aug 2019 16:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190826144740.10163-1-kan.liang@linux.intel.com> <20190826144740.10163-4-kan.liang@linux.intel.com>
In-Reply-To: <20190826144740.10163-4-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 30 Aug 2019 16:18:47 -0700
Message-ID: <CABPqkBTS8bRjSwOBm2HxtuDWhxeZrTGa_E8mqfRfEJPzX1BNhw@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown metrics
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 26, 2019 at 7:48 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Intro
> =====
>
> Icelake has support for measuring the four top level TopDown metrics
> directly in hardware. This is implemented by an additional "metrics"
> register, and a new Fixed Counter 3 that measures pipeline "slots".
>
> Events
> ======
>
> We export four metric events as separate perf events, which map to
> internal "metrics" counter register. Those events do not exist in
> hardware, but can be allocated by the scheduler.
>
There is another approach possible for supporting Topdown-style counters.
Instead of trying to abstract them as separate events to the user and then
trying to put them back together in the kernel and then using slots to scale
them as counts, we could just expose them as is, i.e., structured counter
values. The kernel already handles structured counter configs and exports
the fields on the config via sysfs and the perf tool picks them up and can
encode any event. We could have a similar approach for a counter
value. It could have fields, unit, types. Perf stat would pick them up in
the same manner. It would greatly simplify the kernel implementation.
You would need to publish an pseudo-event code for each group of
metrics. Note that I am not advocating expose the raw counter value.
That way you would maintain one event code -> one "counter" on hw.
The reset on read would also work. It would generate only one rdmsr
per read without forcing any grouping. You would not need any grouping,
or using slots under the hood to scale. If PERF_METRICS gets extended, you
can just add another pseudo event code or umask.

The PERF_METRICS events do not make real sense in isolation. The SLOTS
scaling is hard to interpret. You can never profiling on PERF_METRICS event
so keeping them grouped is okay.


> For the event mapping we use a special 0x00 event code, which is
> reserved for fake events. The metric events start from umask 0x10.
>
> When setting up such events they point to the slots counter, and a
> special callback, update_topdown_event(), reads the additional metrics
> msr to generate the metrics. Then the metric is reported by multiplying
> the metric (percentage) with slots.
>
> This multiplication allows to easily keep a running count, for example
> when the slots counter overflows, and makes all the standard tools, such
> as a perf stat, work. They can do deltas of the values without needing
> to know about percentages. This also simplifies accumulating the counts
> of child events, which otherwise would need to know how to average
> percent values.
>
> All four metric events don't support sampling. Since they will be
> handled specially for event update, a flag PERF_X86_EVENT_TOPDOWN is
> introduced to indicate this case.
>
> The slots event can support both sampling and counting.
> For counting, the flag is also applied.
> For sampling, it will be handled normally as other normal events.
>
> Groups
> ======
>
> To avoid reading the METRICS register multiple times, the metrics and
> slots value can only be updated by the first slots/metrics event in a
> group. All active slots and metrics events will be updated one time.
>
> Reset
> ======
>
> The PERF_METRICS and Fixed counter 3 have to be reset for each read,
> because:
> - The 8bit metrics ratio values lose precision when the measurement
>   period gets longer.
> - The PERF_METRICS may report wrong value if its delta was less than
>   1/255 of SLOTS (Fixed counter 3).
>
> Also, for counting, the -max_period is the initial value of the SLOTS.
> The huge initial value will definitely trigger the issue mentioned
> above. Force initial value as 0 for topdown and slots event counting.
>
> NMI
> ======
>
> The METRICS register may be overflow. The bit 48 of STATUS register
> will be set. If so, update all active slots and metrics events.
>
> The update_topdown_event() has to read two registers separately. The
> values may be modify by a NMI. PMU has to be disabled before calling the
> function.
>
> RDPMC
> ======
>
> RDPMC is temporarily disabled. The following patch will enable it.
>
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/core.c           |  10 ++
>  arch/x86/events/intel/core.c     | 230 ++++++++++++++++++++++++++++++-
>  arch/x86/events/perf_event.h     |  17 +++
>  arch/x86/include/asm/msr-index.h |   2 +
>  4 files changed, 255 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 54534ff00940..1ae23db5c2d7 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -76,6 +76,8 @@ u64 x86_perf_event_update(struct perf_event *event)
>         if (idx == INTEL_PMC_IDX_FIXED_BTS)
>                 return 0;
>
> +       if (is_topdown_count(event) && x86_pmu.update_topdown_event)
> +               return x86_pmu.update_topdown_event(event);
>         /*
>          * Careful: an NMI might modify the previous event value.
>          *
> @@ -1003,6 +1005,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
>
>         max_count = x86_pmu.num_counters + x86_pmu.num_counters_fixed;
>
> +       /* There are 4 TopDown metrics events. */
> +       if (x86_pmu.intel_cap.perf_metrics)
> +               max_count += 4;
> +
>         /* current number of events already accepted */
>         n = cpuc->n_events;
>
> @@ -1184,6 +1190,10 @@ int x86_perf_event_set_period(struct perf_event *event)
>         if (idx == INTEL_PMC_IDX_FIXED_BTS)
>                 return 0;
>
> +       if (unlikely(is_topdown_count(event)) &&
> +           x86_pmu.set_topdown_event_period)
> +               return x86_pmu.set_topdown_event_period(event);
> +
>         /*
>          * If we are way outside a reasonable range then just skip forward:
>          */
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index f4d6335a18e2..616313d7f3d7 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -247,6 +247,10 @@ static struct event_constraint intel_icl_event_constraints[] = {
>         FIXED_EVENT_CONSTRAINT(0x003c, 1),      /* CPU_CLK_UNHALTED.CORE */
>         FIXED_EVENT_CONSTRAINT(0x0300, 2),      /* CPU_CLK_UNHALTED.REF */
>         FIXED_EVENT_CONSTRAINT(0x0400, 3),      /* SLOTS */
> +       METRIC_EVENT_CONSTRAINT(0x1000, 0),     /* Retiring metric */
> +       METRIC_EVENT_CONSTRAINT(0x1100, 1),     /* Bad speculation metric */
> +       METRIC_EVENT_CONSTRAINT(0x1200, 2),     /* FE bound metric */
> +       METRIC_EVENT_CONSTRAINT(0x1300, 3),     /* BE bound metric */
>         INTEL_EVENT_CONSTRAINT_RANGE(0x03, 0x0a, 0xf),
>         INTEL_EVENT_CONSTRAINT_RANGE(0x1f, 0x28, 0xf),
>         INTEL_EVENT_CONSTRAINT(0x32, 0xf),      /* SW_PREFETCH_ACCESS.* */
> @@ -267,6 +271,14 @@ static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
>         INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffff9fffull, RSP_1),
>         INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
>         INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
> +       /*
> +        * The original Fixed Ctr 3 are shared from different metrics
> +        * events. So use the extra reg to enforce the same
> +        * configuration on the original register, but do not actually
> +        * write to it.
> +        */
> +       INTEL_UEVENT_EXTRA_REG(0x0400, 0, -1L, TOPDOWN),
> +       INTEL_UEVENT_TOPDOWN_EXTRA_REG(0x1000),
>         EVENT_EXTRA_END
>  };
>
> @@ -2190,10 +2202,163 @@ static void intel_pmu_del_event(struct perf_event *event)
>                 intel_pmu_pebs_del(event);
>  }
>
> +static inline bool is_metric_event(struct perf_event *event)
> +{
> +       return ((event->attr.config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
> +               ((event->attr.config & INTEL_ARCH_EVENT_MASK) >= 0x1000)  &&
> +               ((event->attr.config & INTEL_ARCH_EVENT_MASK) <= 0x1300);
> +}
> +
> +static inline bool is_slots_event(struct perf_event *event)
> +{
> +       return (event->attr.config & INTEL_ARCH_EVENT_MASK) == 0x0400;
> +}
> +
> +static inline bool is_topdown_event(struct perf_event *event)
> +{
> +       return is_metric_event(event) || is_slots_event(event);
> +}
> +
> +static bool is_first_topdown_event_in_group(struct perf_event *event)
> +{
> +       struct perf_event *first = NULL;
> +
> +       if (is_topdown_event(event->group_leader))
> +               first = event->group_leader;
> +       else {
> +               for_each_sibling_event(first, event->group_leader)
> +                       if (is_topdown_event(first))
> +                               break;
> +       }
> +
> +       if (event == first)
> +               return true;
> +
> +       return false;
> +}
> +
> +static int icl_set_topdown_event_period(struct perf_event *event)
> +{
> +       struct hw_perf_event *hwc = &event->hw;
> +       s64 left = local64_read(&hwc->period_left);
> +
> +       /*
> +        * Clear PERF_METRICS and Fixed counter 3 in initialization.
> +        * After that, both MSRs will be cleared for each read.
> +        * Don't need to clear them again.
> +        */
> +       if (left == x86_pmu.max_period) {
> +               wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
> +               wrmsrl(MSR_PERF_METRICS, 0);
> +               local64_set(&hwc->period_left, 0);
> +       }
> +
> +       perf_event_update_userpage(event);
> +
> +       return 0;
> +}
> +
> +static u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
> +{
> +       u32 val;
> +
> +       /*
> +        * The metric is reported as an 8bit integer percentage
> +        * suming up to 0xff.
> +        * slots-in-metric = (Metric / 0xff) * slots
> +        */
> +       val = (metric >> ((idx - INTEL_PMC_IDX_FIXED_METRIC_BASE) * 8)) & 0xff;
> +       return  mul_u64_u32_div(slots, val, 0xff);
> +}
> +
> +static void __icl_update_topdown_event(struct perf_event *event,
> +                                      u64 slots, u64 metrics)
> +{
> +       int idx = event->hw.idx;
> +       u64 delta;
> +
> +       if (is_metric_idx(idx))
> +               delta = icl_get_metrics_event_value(metrics, slots, idx);
> +       else
> +               delta = slots;
> +
> +       local64_add(delta, &event->count);
> +}
> +
> +/*
> + * Update all active Topdown events.
> + * PMU has to be disabled before calling this function.
> + */
> +static u64 icl_update_topdown_event(struct perf_event *event)
> +{
> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +       struct perf_event *other;
> +       u64 slots, metrics;
> +       int idx;
> +
> +       /*
> +        * Only need to update all events for the first
> +        * slots/metrics event in a group
> +        */
> +       if (event && !is_first_topdown_event_in_group(event))
> +               return 0;
> +
> +       /* read Fixed counter 3 */
> +       rdpmcl((3 | 1<<30), slots);
> +       if (!slots)
> +               return 0;
> +
> +       /* read PERF_METRICS */
> +       rdpmcl((1<<29), metrics);
> +
> +       for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
> +               if (!is_topdown_idx(idx))
> +                       continue;
> +               other = cpuc->events[idx];
> +               __icl_update_topdown_event(other, slots, metrics);
> +       }
> +
> +       /*
> +        * Check and update this event, which may have been cleared
> +        * in active_mask e.g. x86_pmu_stop()
> +        */
> +       if (event && !test_bit(event->hw.idx, cpuc->active_mask))
> +               __icl_update_topdown_event(event, slots, metrics);
> +
> +       /*
> +        * To avoid the known issues as below, the PERF_METRICS and
> +        * Fixed counter 3 are reset for each read.
> +        * - The 8bit metrics ratio values lose precision when the
> +        *   measurement period gets longer.
> +        * - The PERF_METRICS may report wrong value if its delta was
> +        *   less than 1/255 of Fixed counter 3.
> +        */
> +       wrmsrl(MSR_PERF_METRICS, 0);
> +       wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
> +
> +       return slots;
> +}
> +
> +static void intel_pmu_read_topdown_event(struct perf_event *event)
> +{
> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +       /* Only need to call update_topdown_event() once for group read. */
> +       if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
> +           !is_first_topdown_event_in_group(event))
> +               return;
> +
> +       perf_pmu_disable(event->pmu);
> +       x86_pmu.update_topdown_event(event);
> +       perf_pmu_enable(event->pmu);
> +}
> +
>  static void intel_pmu_read_event(struct perf_event *event)
>  {
>         if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>                 intel_pmu_auto_reload_read(event);
> +       else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
> +               intel_pmu_read_topdown_event(event);
>         else
>                 x86_perf_event_update(event);
>  }
> @@ -2401,6 +2566,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>                         intel_pt_interrupt();
>         }
>
> +       /*
> +        * Intel Perf mertrics
> +        */
> +       if (__test_and_clear_bit(48, (unsigned long *)&status)) {
> +               handled++;
> +               if (x86_pmu.update_topdown_event)
> +                       x86_pmu.update_topdown_event(NULL);
> +       }
> +
>         /*
>          * Checkpointed counters can lead to 'spurious' PMIs because the
>          * rollback caused by the PMI will have cleared the overflow status
> @@ -3312,6 +3486,42 @@ static int intel_pmu_hw_config(struct perf_event *event)
>         if (event->attr.type != PERF_TYPE_RAW)
>                 return 0;
>
> +       /*
> +        * Config Topdown slots and metric events
> +        *
> +        * The slots event on Fixed Counter 3 can support sampling,
> +        * which will be handled normally in x86_perf_event_update().
> +        *
> +        * The metric events don't support sampling.
> +        *
> +        * For counting, topdown slots and metric events will be
> +        * handled specially for event update.
> +        * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
> +        */
> +       if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
> +               if (is_metric_event(event) && is_sampling_event(event))
> +                       return -EINVAL;
> +
> +               if (!is_sampling_event(event)) {
> +                       if (event->attr.config1 != 0)
> +                               return -EINVAL;
> +                       if (event->attr.config & ARCH_PERFMON_EVENTSEL_ANY)
> +                               return -EINVAL;
> +                       /*
> +                        * Put configuration (minus event) into config1 so that
> +                        * the scheduler enforces through an extra_reg that
> +                        * all instances of the metrics events have the same
> +                        * configuration.
> +                        */
> +                       event->attr.config1 = event->hw.config &
> +                                             X86_ALL_EVENT_FLAGS;
> +                       event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
> +
> +                       if (is_metric_event(event))
> +                               event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
> +               }
> +       }
> +
>         if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
>                 return 0;
>
> @@ -5040,6 +5250,8 @@ __init int intel_pmu_init(void)
>                 x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
>                 x86_pmu.lbr_pt_coexist = true;
>                 intel_pmu_pebs_data_source_skl(pmem);
> +               x86_pmu.update_topdown_event = icl_update_topdown_event;
> +               x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
>                 pr_cont("Icelake events, ");
>                 name = "icelake";
>                 break;
> @@ -5096,10 +5308,17 @@ __init int intel_pmu_init(void)
>                  * counter, so do not extend mask to generic counters
>                  */
>                 for_each_event_constraint(c, x86_pmu.event_constraints) {
> -                       if (c->cmask == FIXED_EVENT_FLAGS
> -                           && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES
> -                           && c->idxmsk64 != INTEL_PMC_MSK_FIXED_SLOTS) {
> -                               c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
> +                       if (c->cmask == FIXED_EVENT_FLAGS) {
> +                               /*
> +                                * Don't extend topdown slots and metrics
> +                                * events to generic counters.
> +                                */
> +                               if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
> +                                       c->weight = hweight64(c->idxmsk64);
> +                                       continue;
> +                               }
> +                               if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
> +                                       c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
>                         }
>                         c->idxmsk64 &=
>                                 ~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
> @@ -5152,6 +5371,9 @@ __init int intel_pmu_init(void)
>         if (x86_pmu.counter_freezing)
>                 x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
>
> +       if (x86_pmu.intel_cap.perf_metrics)
> +               x86_pmu.intel_ctrl |= 1ULL << 48;
> +
>         return 0;
>  }
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 37f17f55ef2d..7c59f08fadc0 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -40,6 +40,7 @@ enum extra_reg_type {
>         EXTRA_REG_LBR   = 2,    /* lbr_select */
>         EXTRA_REG_LDLAT = 3,    /* ld_lat_threshold */
>         EXTRA_REG_FE    = 4,    /* fe_* */
> +       EXTRA_REG_TOPDOWN = 5,  /* Topdown slots/metrics */
>
>         EXTRA_REG_MAX           /* number of entries needed */
>  };
> @@ -76,6 +77,12 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
>  #define PERF_X86_EVENT_EXCL_ACCT       0x0100 /* accounted EXCL event */
>  #define PERF_X86_EVENT_AUTO_RELOAD     0x0200 /* use PEBS auto-reload */
>  #define PERF_X86_EVENT_LARGE_PEBS      0x0400 /* use large PEBS */
> +#define PERF_X86_EVENT_TOPDOWN         0x0800 /* Count Topdown slots/metrics events */
> +
> +static inline bool is_topdown_count(struct perf_event *event)
> +{
> +       return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
> +}
>
>  struct amd_nb {
>         int nb_id;  /* NorthBridge id */
> @@ -509,6 +516,9 @@ struct extra_reg {
>                                0xffff, \
>                                LDLAT)
>
> +#define INTEL_UEVENT_TOPDOWN_EXTRA_REG(event)  \
> +       EVENT_EXTRA_REG(event, 0, 0xfcff, -1L, TOPDOWN)
> +
>  #define EVENT_EXTRA_END EVENT_EXTRA_REG(0, 0, 0, 0, RSP_0)
>
>  union perf_capabilities {
> @@ -524,6 +534,7 @@ union perf_capabilities {
>                  */
>                 u64     full_width_write:1;
>                 u64     pebs_baseline:1;
> +               u64     perf_metrics:1;
>         };
>         u64     capabilities;
>  };
> @@ -686,6 +697,12 @@ struct x86_pmu {
>          */
>         atomic_t        lbr_exclusive[x86_lbr_exclusive_max];
>
> +       /*
> +        * Intel perf metrics
> +        */
> +       u64             (*update_topdown_event)(struct perf_event *event);
> +       int             (*set_topdown_event_period)(struct perf_event *event);
> +
>         /*
>          * AMD bits
>          */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 78f3a5ebc1e2..460a419a7214 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -118,6 +118,8 @@
>  #define MSR_TURBO_RATIO_LIMIT1         0x000001ae
>  #define MSR_TURBO_RATIO_LIMIT2         0x000001af
>
> +#define MSR_PERF_METRICS               0x00000329
> +
>  #define MSR_LBR_SELECT                 0x000001c8
>  #define MSR_LBR_TOS                    0x000001c9
>  #define MSR_LBR_NHM_FROM               0x00000680
> --
> 2.17.1
>
