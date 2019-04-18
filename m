Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDDEC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F13620821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpmgdKKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbfDRAMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:12:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35806 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbfDRAMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:12:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so597313wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8sIfMQgVdDKXBJIfVSYdK0Eq6QFRE/yDzYQSzlSnzg=;
        b=VpmgdKKHpMbiFLOEbsEhgsAJktCWYBrEICtTE+1yGscGwoKo1aBIkA4GAaf01v9w86
         /qL6unHuo6fj/J5PxjBwu/QBhOH/B6iDEQVt0UnjRG0ZkodOmVSaHSugiFyBTQr/R7+R
         +FUBGQNct690V7pHUiLHfQ21YNssaZrzeWsT2cA5Q/RbOnP3vmuCeRrse9uuzSAuGkpL
         yM1MXuOeknJJM0HJr+p+cyEGkE6M0M1e1BS5cgVzjvM6ZN7MTOGMQY6GtByuFdtRwDnN
         Pmk0/ApsGPKliXEfs9ywJLadI6QvZBQth0bIXJMUCXIJVy2g0dyWTBuyTeSPC3xFPgCH
         Sucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8sIfMQgVdDKXBJIfVSYdK0Eq6QFRE/yDzYQSzlSnzg=;
        b=gbc59z9C+iFz/lpRQ9lmvefiI/6ePJMPGSmyys2tgyMSTYu7RrNrrrufuhl/gLEFCd
         IYmYrlou0HLao5z7pXOl1uhEYpJqtnZ0lye+cyL0MiZUiTetMloPjLBP3tLitktfACZS
         R0LgRiieOW+ufk9xIHfzjeUagiI7hpp7/v9sgpdhHbTo4I3KDrV5AbdB0gu2Xrp78g4A
         SSOvsFbgO+Eq/k9msf6Sw5C3OBEXwd4p+EMw21HGzNk/IngenWHBfrrruOrKniHxvMRj
         4uUUuiWx2ncncw/XhcW2Bei6jtNxD9W687VPmEySs+YPyBPZatwPtinnBFyXIvaUWAOF
         Kc9A==
X-Gm-Message-State: APjAAAUHuMXfclfU7Wegjp0gfVx9XwveeMvBTvfmvTjcfUq4gs4BRMZH
        hOJN4TETBK/34leIitYgjkPo3ZnlvM6SGzBaiuiOfg==
X-Google-Smtp-Source: APXvYqzNtQXw5uNEgyJLP66N8xcWzYNfr8sp+FLRSVFZ1Fo6WpQga5zQ0CtB0VbNg+dOszFT2hUEWldFSxbwpsjcF4c=
X-Received: by 2002:adf:ec09:: with SMTP id x9mr5482465wrn.187.1555546349742;
 Wed, 17 Apr 2019 17:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190402104153.25404-1-patrick.bellasi@arm.com> <20190402104153.25404-13-patrick.bellasi@arm.com>
In-Reply-To: <20190402104153.25404-13-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 17 Apr 2019 17:12:18 -0700
Message-ID: <CAJuCfpFFSgRUFb9pyckpXWxr-z+mrrhcsLjZiVN5fZMvYC5XxQ@mail.gmail.com>
Subject: Re: [PATCH v8 12/16] sched/core: uclamp: Extend CPU's cgroup controller
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 3:43 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> The cgroup CPU bandwidth controller allows to assign a specified
> (maximum) bandwidth to the tasks of a group. However this bandwidth is
> defined and enforced only on a temporal base, without considering the
> actual frequency a CPU is running on. Thus, the amount of computation
> completed by a task within an allocated bandwidth can be very different
> depending on the actual frequency the CPU is running that task.
> The amount of computation can be affected also by the specific CPU a
> task is running on, especially when running on asymmetric capacity
> systems like Arm's big.LITTLE.
>
> With the availability of schedutil, the scheduler is now able
> to drive frequency selections based on actual task utilization.
> Moreover, the utilization clamping support provides a mechanism to
> bias the frequency selection operated by schedutil depending on
> constraints assigned to the tasks currently RUNNABLE on a CPU.
>
> Giving the mechanisms described above, it is now possible to extend the
> cpu controller to specify the minimum (or maximum) utilization which
> should be considered for tasks RUNNABLE on a cpu.
> This makes it possible to better defined the actual computational
> power assigned to task groups, thus improving the cgroup CPU bandwidth
> controller which is currently based just on time constraints.
>
> Extend the CPU controller with a couple of new attributes util.{min,max}
> which allows to enforce utilization boosting and capping for all the
> tasks in a group. Specifically:
>
> - util.min: defines the minimum utilization which should be considered
>             i.e. the RUNNABLE tasks of this group will run at least at a
>                  minimum frequency which corresponds to the util.min
>                  utilization
>
> - util.max: defines the maximum utilization which should be considered
>             i.e. the RUNNABLE tasks of this group will run up to a
>                  maximum frequency which corresponds to the util.max
>                  utilization
>
> These attributes:
>
> a) are available only for non-root nodes, both on default and legacy
>    hierarchies, while system wide clamps are defined by a generic
>    interface which does not depends on cgroups. This system wide
>    interface enforces constraints on tasks in the root node.
>
> b) enforce effective constraints at each level of the hierarchy which
>    are a restriction of the group requests considering its parent's
>    effective constraints. Root group effective constraints are defined
>    by the system wide interface.
>    This mechanism allows each (non-root) level of the hierarchy to:
>    - request whatever clamp values it would like to get
>    - effectively get only up to the maximum amount allowed by its parent
>
> c) have higher priority than task-specific clamps, defined via
>    sched_setattr(), thus allowing to control and restrict task requests
>
> Add two new attributes to the cpu controller to collect "requested"
> clamp values. Allow that at each non-root level of the hierarchy.
> Validate local consistency by enforcing util.min < util.max.
> Keep it simple by do not caring now about "effective" values computation
> and propagation along the hierarchy.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
>
> --
> Changes in v8:
>  Message-ID: <20190214154817.GN50184@devbig004.ftw2.facebook.com>
>  - update changelog description for points b), c) and following paragraph
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  27 +++++
>  init/Kconfig                            |  22 ++++
>  kernel/sched/core.c                     | 142 +++++++++++++++++++++++-
>  kernel/sched/sched.h                    |   6 +
>  4 files changed, 196 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 7bf3f129c68b..47710a77f4fa 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -909,6 +909,12 @@ controller implements weight and absolute bandwidth limit models for
>  normal scheduling policy and absolute bandwidth allocation model for
>  realtime scheduling policy.
>
> +Cycles distribution is based, by default, on a temporal base and it
> +does not account for the frequency at which tasks are executed.
> +The (optional) utilization clamping support allows to enforce a minimum
> +bandwidth, which should always be provided by a CPU, and a maximum bandwidth,
> +which should never be exceeded by a CPU.
> +
>  WARNING: cgroup2 doesn't yet support control of realtime processes and
>  the cpu controller can only be enabled when all RT processes are in
>  the root cgroup.  Be aware that system management software may already
> @@ -974,6 +980,27 @@ All time durations are in microseconds.
>         Shows pressure stall information for CPU. See
>         Documentation/accounting/psi.txt for details.
>
> +  cpu.util.min
> +        A read-write single value file which exists on non-root cgroups.
> +        The default is "0", i.e. no utilization boosting.
> +
> +        The requested minimum utilization in the range [0, 1024].
> +
> +        This interface allows reading and setting minimum utilization clamp
> +        values similar to the sched_setattr(2). This minimum utilization
> +        value is used to clamp the task specific minimum utilization clamp.
> +
> +  cpu.util.max
> +        A read-write single value file which exists on non-root cgroups.
> +        The default is "1024". i.e. no utilization capping
> +
> +        The requested maximum utilization in the range [0, 1024].
> +
> +        This interface allows reading and setting maximum utilization clamp
> +        values similar to the sched_setattr(2). This maximum utilization
> +        value is used to clamp the task specific maximum utilization clamp.
> +
> +
>
>  Memory
>  ------
> diff --git a/init/Kconfig b/init/Kconfig
> index 7439cbf4d02e..33006e8de996 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -877,6 +877,28 @@ config RT_GROUP_SCHED
>
>  endif #CGROUP_SCHED
>
> +config UCLAMP_TASK_GROUP
> +       bool "Utilization clamping per group of tasks"
> +       depends on CGROUP_SCHED
> +       depends on UCLAMP_TASK
> +       default n
> +       help
> +         This feature enables the scheduler to track the clamped utilization
> +         of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> +
> +         When this option is enabled, the user can specify a min and max
> +         CPU bandwidth which is allowed for each single task in a group.
> +         The max bandwidth allows to clamp the maximum frequency a task
> +         can use, while the min bandwidth allows to define a minimum
> +         frequency a task will always use.
> +
> +         When task group based utilization clamping is enabled, an eventually
> +         specified task-specific clamp value is constrained by the cgroup
> +         specified clamp value. Both minimum and maximum task clamping cannot
> +         be bigger than the corresponding clamping defined at task group level.
> +
> +         If in doubt, say N.
> +
>  config CGROUP_PIDS
>         bool "PIDs controller"
>         help
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 71c9dd6487b1..aeed2dd315cc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1130,8 +1130,12 @@ static void __init init_uclamp(void)
>         /* System defaults allow max clamp values for both indexes */
>         uc_max.value = uclamp_none(UCLAMP_MAX);
>         uc_max.bucket_id = uclamp_bucket_id(uc_max.value);
> -       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
>                 uclamp_default[clamp_id] = uc_max;
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +               root_task_group.uclamp_req[clamp_id] = uc_max;
> +#endif
> +       }
>  }
>
>  #else /* CONFIG_UCLAMP_TASK */
> @@ -6720,6 +6724,19 @@ void ia64_set_curr_task(int cpu, struct task_struct *p)
>  /* task_group_lock serializes the addition/removal of task groups */
>  static DEFINE_SPINLOCK(task_group_lock);
>
> +static inline int alloc_uclamp_sched_group(struct task_group *tg,
> +                                          struct task_group *parent)
> +{
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       int clamp_id;
> +
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> +               tg->uclamp_req[clamp_id] = parent->uclamp_req[clamp_id];
> +#endif
> +
> +       return 1;

Looks like you never return anything else neither here nor in the
following patches I think...

> +}
> +
>  static void sched_free_group(struct task_group *tg)
>  {
>         free_fair_sched_group(tg);
> @@ -6743,6 +6760,9 @@ struct task_group *sched_create_group(struct task_group *parent)
>         if (!alloc_rt_sched_group(tg, parent))
>                 goto err;
>
> +       if (!alloc_uclamp_sched_group(tg, parent))
> +               goto err;
> +
>         return tg;
>
>  err:
> @@ -6963,6 +6983,100 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
>                 sched_move_task(task);
>  }
>
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
> +                                 struct cftype *cftype, u64 min_value)
> +{
> +       struct task_group *tg;
> +       int ret = 0;
> +
> +       if (min_value > SCHED_CAPACITY_SCALE)
> +               return -ERANGE;
> +
> +       rcu_read_lock();
> +
> +       tg = css_tg(css);
> +       if (tg == &root_task_group) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +       if (tg->uclamp_req[UCLAMP_MIN].value == min_value)
> +               goto out;
> +       if (tg->uclamp_req[UCLAMP_MAX].value < min_value) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       /* Update tg's "requested" clamp value */
> +       tg->uclamp_req[UCLAMP_MIN].value = min_value;
> +       tg->uclamp_req[UCLAMP_MIN].bucket_id = uclamp_bucket_id(min_value);
> +
> +out:
> +       rcu_read_unlock();
> +
> +       return ret;
> +}
> +
> +static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
> +                                 struct cftype *cftype, u64 max_value)
> +{
> +       struct task_group *tg;
> +       int ret = 0;
> +
> +       if (max_value > SCHED_CAPACITY_SCALE)
> +               return -ERANGE;
> +
> +       rcu_read_lock();
> +
> +       tg = css_tg(css);
> +       if (tg == &root_task_group) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +       if (tg->uclamp_req[UCLAMP_MAX].value == max_value)
> +               goto out;
> +       if (tg->uclamp_req[UCLAMP_MIN].value > max_value) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       /* Update tg's "requested" clamp value */
> +       tg->uclamp_req[UCLAMP_MAX].value = max_value;
> +       tg->uclamp_req[UCLAMP_MAX].bucket_id = uclamp_bucket_id(max_value);
> +
> +out:
> +       rcu_read_unlock();
> +
> +       return ret;
> +}
> +
> +static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
> +                                 enum uclamp_id clamp_id)
> +{
> +       struct task_group *tg;
> +       u64 util_clamp;
> +
> +       rcu_read_lock();
> +       tg = css_tg(css);
> +       util_clamp = tg->uclamp_req[clamp_id].value;
> +       rcu_read_unlock();
> +
> +       return util_clamp;
> +}
> +
> +static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
> +                                struct cftype *cft)
> +{
> +       return cpu_uclamp_read(css, UCLAMP_MIN);
> +}
> +
> +static u64 cpu_util_max_read_u64(struct cgroup_subsys_state *css,
> +                                struct cftype *cft)
> +{
> +       return cpu_uclamp_read(css, UCLAMP_MAX);
> +}
> +#endif /* CONFIG_UCLAMP_TASK_GROUP */
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
>                                 struct cftype *cftype, u64 shareval)
> @@ -7300,6 +7414,18 @@ static struct cftype cpu_legacy_files[] = {
>                 .read_u64 = cpu_rt_period_read_uint,
>                 .write_u64 = cpu_rt_period_write_uint,
>         },
> +#endif
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       {
> +               .name = "util.min",
> +               .read_u64 = cpu_util_min_read_u64,
> +               .write_u64 = cpu_util_min_write_u64,
> +       },
> +       {
> +               .name = "util.max",
> +               .read_u64 = cpu_util_max_read_u64,
> +               .write_u64 = cpu_util_max_write_u64,
> +       },
>  #endif
>         { }     /* Terminate */
>  };
> @@ -7467,6 +7593,20 @@ static struct cftype cpu_files[] = {
>                 .seq_show = cpu_max_show,
>                 .write = cpu_max_write,
>         },
> +#endif
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       {
> +               .name = "util.min",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .read_u64 = cpu_util_min_read_u64,
> +               .write_u64 = cpu_util_min_write_u64,
> +       },
> +       {
> +               .name = "util.max",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .read_u64 = cpu_util_max_read_u64,
> +               .write_u64 = cpu_util_max_write_u64,
> +       },
>  #endif
>         { }     /* terminate */
>  };
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6ae3628248eb..b46b6912beba 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -399,6 +399,12 @@ struct task_group {
>  #endif
>
>         struct cfs_bandwidth    cfs_bandwidth;
> +
> +#ifdef CONFIG_UCLAMP_TASK_GROUP
> +       /* Clamp values requested for a task group */
> +       struct uclamp_se        uclamp_req[UCLAMP_CNT];
> +#endif
> +
>  };
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> --
> 2.20.1
>
