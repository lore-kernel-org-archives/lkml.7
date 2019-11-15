Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FD0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6CB20733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtYR9ENH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKOImX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:42:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37405 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:42:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so7412800lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEIpoMZ0gXwJ0gRdyyaQptLojsEUlVAjG2/nHev0Sbk=;
        b=NtYR9ENHYaKunQuSHrAckQ+vNY1PmgxxOarDkm/KI2Xyn9nJEbMJvFkSNowmxpD2gy
         jbVCPsTTEv/hC+LCb0W02mnMEF/mt1q+rCuR6v+2Sut5Q1M/6xXScYM2bc7l5JWFZhqo
         ZsI+j1mr9r4oZda0MEqKCdyCluAnqGTNJM2v8l7MYTg2a5lyEc6HFR2AqJ7bFHNlL/Jn
         RP4sQ/WGbfWqmDf1yL94pWLmoArLnGWZ8FKtpO/qkFMuIdI6dFMcdQTJXgQcUVcn5zXV
         1qOLQqY2hS+qx3TLCoxIjR4AHouSFac1P/Gm6Fu3DLiSW5E2sp+tAPoPRLETRDXwmDr0
         a4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEIpoMZ0gXwJ0gRdyyaQptLojsEUlVAjG2/nHev0Sbk=;
        b=T9N8YK/Yl8GyenofadHo08eT82cBxT3KgR2OmetbSwhUwY9XWsE2ZntpCMIJ0dX8Yn
         JznGytn0RIw3wJoGe3Wxv12clYI7LG9ovC/56qAiVK70Z4+66T4W/bWJShQnXZCqdwAT
         jfwUcMrWvAFXDE4V/rQTz8I1/gKGRPenK+LsdGrfdcQ/PbctvkGu2gcgBG1SDymw7iKQ
         +NwdWmY/AVv5vUF41iJB1f7SA7jTVUG4GxO//gEX0dHiPoBrrQ7lmq848PY4S1PzP0Sg
         xj526kD+VhkRCJKyoEnmj8dARQENtvNjLlp8GIUqr6DDYdq+l7nnRre+IRab+nAcq3I4
         IGkQ==
X-Gm-Message-State: APjAAAVI7Ps62WO3Lzwqw1S158o0Ai/lXnRPj879a2iclKWcN+3J/FuO
        0lh2LXoTzsig9XMEerD61XzliBhqI9Otz60SoLI/Lg==
X-Google-Smtp-Source: APXvYqxgns4SuhB6G0vkjs2Ok0fSP/qHpuhJW74Vv2e2d+moAammcgNVnz3/2TVAa0wcXbxNhiHFgwCfeMVoNh5Fvvc=
X-Received: by 2002:ac2:48b8:: with SMTP id u24mr8927842lfg.133.1573807340301;
 Fri, 15 Nov 2019 00:42:20 -0800 (PST)
MIME-Version: 1.0
References: <b90cbcce608cef4e02a7bbfe178335f76d201bab.1573728344.git.viresh.kumar@linaro.org>
In-Reply-To: <b90cbcce608cef4e02a7bbfe178335f76d201bab.1573728344.git.viresh.kumar@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 09:42:09 +0100
Message-ID: <CAKfTPtBua4vBB8hAZ-9c-K8LXuF0+oC3r3XD5KF13_8+FZiF-Q@mail.gmail.com>
Subject: Re: [PATCH V2] sched/fair: Make sched-idle CPU selection consistent throughout
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Parth Shah <parth@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 at 11:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There are instances where we keep searching for an idle CPU despite
> already having a sched-idle CPU (in find_idlest_group_cpu(),
> select_idle_smt() and select_idle_cpu() and then there are places where
> we don't necessarily do that and return a sched-idle CPU as soon as we
> find one (in select_idle_sibling()). This looks a bit inconsistent and
> it may be worth having the same policy everywhere.
>
> On the other hand, choosing a sched-idle CPU over a idle one shall be
> beneficial from performance and power point of view as well, as we don't
> need to get the CPU online from a deep idle state which wastes quite a
> lot of time and energy and delays the scheduling of the newly woken up
> task.
>
> This patch tries to simplify code around sched-idle CPU selection and
> make it consistent throughout.
>
> Testing is done with the help of rt-app on hikey board (ARM64 octa-core,
> 2 clusters, 0-3 and 4-7). The cpufreq governor was set to performance to
> avoid any side affects from CPU frequency. Following are the tests
> performed:
>
> Test 1: 1-cfs-task:
>
> A single SCHED_NORMAL task is pinned to CPU5 which runs for 2333 us
> out of 7777 us (so gives time for the cluster to go in deep idle
> state).
>
> Test 2: 1-cfs-1-idle-task:
>
> A single SCHED_NORMAL task is pinned on CPU5 and single SCHED_IDLE
> task is pinned on CPU6 (to make sure cluster 1 doesn't go in deep idle
> state).
>
> Test 3: 1-cfs-8-idle-task:
>
> A single SCHED_NORMAL task is pinned on CPU5 and eight SCHED_IDLE
> tasks are created which run forever (not pinned anywhere, so they run
> on all CPUs). Checked with kernelshark that as soon as NORMAL task
> sleeps, the SCHED_IDLE task starts running on CPU5.
>
> And here are the results on mean latency (in us), using the "st" tool.
>
> $ st 1-cfs-task/rt-app-cfs_thread-0.log
> N       min     max     sum     mean    stddev
> 642     90      592     197180  307.134 109.906
>
> $ st 1-cfs-1-idle-task/rt-app-cfs_thread-0.log
> N       min     max     sum     mean    stddev
> 642     67      311     113850  177.336 41.4251
>
> $ st 1-cfs-8-idle-task/rt-app-cfs_thread-0.log
> N       min     max     sum     mean    stddev
> 643     29      173     41364   64.3297 13.2344
>
> The mean latency when we need to:
> - wakeup from deep idle state is 307 us.
> - wakeup from shallow idle state is 177 us.
> - preempt a SCHED_IDLE task is 64 us.

Make sense to me

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Updated commit log with the numbers received from rt-app tests.
>
>  kernel/sched/fair.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a81c36472822..bb367f48c1ef 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5545,7 +5545,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>         unsigned int min_exit_latency = UINT_MAX;
>         u64 latest_idle_timestamp = 0;
>         int least_loaded_cpu = this_cpu;
> -       int shallowest_idle_cpu = -1, si_cpu = -1;
> +       int shallowest_idle_cpu = -1;
>         int i;
>
>         /* Check if we have any choice: */
> @@ -5554,6 +5554,9 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>
>         /* Traverse only the allowed CPUs */
>         for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
> +               if (sched_idle_cpu(i))
> +                       return i;
> +
>                 if (available_idle_cpu(i)) {
>                         struct rq *rq = cpu_rq(i);
>                         struct cpuidle_state *idle = idle_get_state(rq);
> @@ -5576,12 +5579,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>                                 latest_idle_timestamp = rq->idle_stamp;
>                                 shallowest_idle_cpu = i;
>                         }
> -               } else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
> -                       if (sched_idle_cpu(i)) {
> -                               si_cpu = i;
> -                               continue;
> -                       }
> -
> +               } else if (shallowest_idle_cpu == -1) {
>                         load = cpu_load(cpu_rq(i));
>                         if (load < min_load) {
>                                 min_load = load;
> @@ -5590,11 +5588,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>                 }
>         }
>
> -       if (shallowest_idle_cpu != -1)
> -               return shallowest_idle_cpu;
> -       if (si_cpu != -1)
> -               return si_cpu;
> -       return least_loaded_cpu;
> +       return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
>  }
>
>  static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p,
> @@ -5747,7 +5741,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>   */
>  static int select_idle_smt(struct task_struct *p, int target)
>  {
> -       int cpu, si_cpu = -1;
> +       int cpu;
>
>         if (!static_branch_likely(&sched_smt_present))
>                 return -1;
> @@ -5755,13 +5749,11 @@ static int select_idle_smt(struct task_struct *p, int target)
>         for_each_cpu(cpu, cpu_smt_mask(target)) {
>                 if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>                         continue;
> -               if (available_idle_cpu(cpu))
> +               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>                         return cpu;
> -               if (si_cpu == -1 && sched_idle_cpu(cpu))
> -                       si_cpu = cpu;
>         }
>
> -       return si_cpu;
> +       return -1;
>  }
>
>  #else /* CONFIG_SCHED_SMT */
> @@ -5790,7 +5782,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         u64 time, cost;
>         s64 delta;
>         int this = smp_processor_id();
> -       int cpu, nr = INT_MAX, si_cpu = -1;
> +       int cpu, nr = INT_MAX;
>
>         this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>         if (!this_sd)
> @@ -5818,13 +5810,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
>                 if (!--nr)
> -                       return si_cpu;
> +                       return -1;
>                 if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>                         continue;
> -               if (available_idle_cpu(cpu))
> +               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>                         break;
> -               if (si_cpu == -1 && sched_idle_cpu(cpu))
> -                       si_cpu = cpu;
>         }
>
>         time = cpu_clock(this) - time;
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
