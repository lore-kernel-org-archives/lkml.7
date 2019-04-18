Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEAFC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8B82183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmP91XC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbfDRAvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:51:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39007 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbfDRAvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:51:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so656701wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIUE3CyTnyuGhRtlj3pPZCDwE53afxTuajiCQG8eDOQ=;
        b=NmP91XC6pr0jMUyp7C/ToNhmTPbQQmuIZ5KVeUfzj/HQR2G3b1vnqgl+06iUSU3wWK
         ycDkEiU3Y4AzIUw1PSd6uXW037xE3A5iILl23SqYp8LsxuJyX+2aHvQsoV+rdsHIGyAT
         bafYmAbvG2AbukJGWfv5InYrFBmMl4kQBr1lb9M6wpqMBWRU2gQOipcuITz8qaTr9hBJ
         YZBb3Uq0xjxd2mw3hK/9QUd2X8fYDG4EI00Wa1vUUoX96hJq/hRy0zHmXe0nUJpUGhNQ
         Wro5mMCaV3fNjeQbxfOCvaYiKbvoVxcb+llIjxeM81gQj1+c7lcSx44BH1+NUmbcLDnH
         05xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIUE3CyTnyuGhRtlj3pPZCDwE53afxTuajiCQG8eDOQ=;
        b=RLmNsbSExReNlA27lgpxDYzqI82/6tGGlZTuvByvz/RAiNaFWNoK8qu0w8GBaRrKXh
         wABsvw/TJ748dHPgsTFQ5Pv8OYsIfcnEkeo9gD9zQNHMTBIjrJ+HlGpQ8Urvr+1LqLDj
         bm6ptgsvmtJqBbahHEyDTnmHLRIoza4DPq4rSk7MNm1v5LiIbcgowod6iu74BpLU8LWs
         zT8ROxBcUj8VWtgn4HD/Z6IGW2ULc/hGHNFJ7OmyNB36gt3FYAchBaNyky1YlGv9zk3O
         +ybeT3B7I0b7mzFxerMoZ0oFVmb6ka54L6n9UwdP0Km68o7ITHnZs8axEkwfXIJ6qCIA
         3c0w==
X-Gm-Message-State: APjAAAXnBqGCPzVIB5jVACwM6Cgdak2unE1fycDPMXo1+sB0z142YdGa
        Kgk5LmeEZKOpLdwR0E669Fal5IoZYmJFArH1INZhCQ==
X-Google-Smtp-Source: APXvYqzWkWbiii8DzrWAU8oZHf8mLplWiacc0i9JH58TPzP+VXcVV1RZIBiJhlvWPYANLJetn5vTODhW6zQiUNQtX8w=
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr28350444wru.150.1555548673477;
 Wed, 17 Apr 2019 17:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190402104153.25404-1-patrick.bellasi@arm.com> <20190402104153.25404-5-patrick.bellasi@arm.com>
In-Reply-To: <20190402104153.25404-5-patrick.bellasi@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 17 Apr 2019 17:51:02 -0700
Message-ID: <CAJuCfpGcN-CWCoo16_xKzohUbBTCY3W5D1E8izhA8wtEjCtF+Q@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] sched/core: uclamp: Add system default clamps
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

On Tue, Apr 2, 2019 at 3:42 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> Tasks without a user-defined clamp value are considered not clamped
> and by default their utilization can have any value in the
> [0..SCHED_CAPACITY_SCALE] range.
>
> Tasks with a user-defined clamp value are allowed to request any value
> in that range, and the required clamp is unconditionally enforced.
> However, a "System Management Software" could be interested in limiting
> the range of clamp values allowed for all tasks.
>
> Add a privileged interface to define a system default configuration via:
>
>   /proc/sys/kernel/sched_uclamp_util_{min,max}
>
> which works as an unconditional clamp range restriction for all tasks.
>
> With the default configuration, the full SCHED_CAPACITY_SCALE range of
> values is allowed for each clamp index. Otherwise, the task-specific
> clamp is capped by the corresponding system default value.
>
> Do that by tracking, for each task, the "effective" clamp value and
> bucket the task has been refcounted in at enqueue time. This
> allows to lazy aggregate "requested" and "system default" values at
> enqueue time and simplifies refcounting updates at dequeue time.
>
> The cached bucket ids are used to avoid (relatively) more expensive
> integer divisions every time a task is enqueued.
>
> An active flag is used to report when the "effective" value is valid and
> thus the task is actually refcounted in the corresponding rq's bucket.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
>
> ---
> Changes in v8:
>  Message-ID: <20190313201010.GU2482@worktop.programming.kicks-ass.net>
>  - add "requested" values uclamp_se instance beside the existing
>    "effective" values instance
>  - rename uclamp_effective_{get,assign}() into uclamp_eff_{get,set}()
>  - make uclamp_eff_get() return the new "effective" values by copy
> Message-ID: <20190318125844.ajhjpaqlcgxn7qkq@e110439-lin>
>  - run uclamp_fork() code independently from the class being supported.
>    Resetting active flag is not harmful and following patches will add
>    other code which still needs to be executed independently from class
>    support.
> Message-ID: <20190313201342.GV2482@worktop.programming.kicks-ass.net>
>  - add sysctl_sched_uclamp_handler()'s internal mutex to serialize
>    concurrent usages
> ---
>  include/linux/sched.h        |  10 +++
>  include/linux/sched/sysctl.h |  11 +++
>  kernel/sched/core.c          | 131 ++++++++++++++++++++++++++++++++++-
>  kernel/sysctl.c              |  16 +++++
>  4 files changed, 167 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 0c0dd7aac8e9..d8491954e2e1 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -584,14 +584,21 @@ struct sched_dl_entity {
>   * Utilization clamp for a scheduling entity
>   * @value:             clamp value "assigned" to a se
>   * @bucket_id:         bucket index corresponding to the "assigned" value
> + * @active:            the se is currently refcounted in a rq's bucket
>   *
>   * The bucket_id is the index of the clamp bucket matching the clamp value
>   * which is pre-computed and stored to avoid expensive integer divisions from
>   * the fast path.
> + *
> + * The active bit is set whenever a task has got an "effective" value assigned,
> + * which can be different from the clamp value "requested" from user-space.
> + * This allows to know a task is refcounted in the rq's bucket corresponding
> + * to the "effective" bucket_id.
>   */
>  struct uclamp_se {
>         unsigned int value              : bits_per(SCHED_CAPACITY_SCALE);
>         unsigned int bucket_id          : bits_per(UCLAMP_BUCKETS);
> +       unsigned int active             : 1;
>  };
>  #endif /* CONFIG_UCLAMP_TASK */
>
> @@ -676,6 +683,9 @@ struct task_struct {
>         struct sched_dl_entity          dl;
>
>  #ifdef CONFIG_UCLAMP_TASK
> +       /* Clamp values requested for a scheduling entity */
> +       struct uclamp_se                uclamp_req[UCLAMP_CNT];
> +       /* Effective clamp values used for a scheduling entity */
>         struct uclamp_se                uclamp[UCLAMP_CNT];
>  #endif
>
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 99ce6d728df7..d4f6215ee03f 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -56,6 +56,11 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
>  extern unsigned int sysctl_sched_rt_period;
>  extern int sysctl_sched_rt_runtime;
>
> +#ifdef CONFIG_UCLAMP_TASK
> +extern unsigned int sysctl_sched_uclamp_util_min;
> +extern unsigned int sysctl_sched_uclamp_util_max;
> +#endif
> +
>  #ifdef CONFIG_CFS_BANDWIDTH
>  extern unsigned int sysctl_sched_cfs_bandwidth_slice;
>  #endif
> @@ -75,6 +80,12 @@ extern int sched_rt_handler(struct ctl_table *table, int write,
>                 void __user *buffer, size_t *lenp,
>                 loff_t *ppos);
>
> +#ifdef CONFIG_UCLAMP_TASK
> +extern int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> +                                      void __user *buffer, size_t *lenp,
> +                                      loff_t *ppos);
> +#endif
> +
>  extern int sysctl_numa_balancing(struct ctl_table *table, int write,
>                                  void __user *buffer, size_t *lenp,
>                                  loff_t *ppos);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 046f61d33f00..d368ac26b8aa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -733,6 +733,14 @@ static void set_load_weight(struct task_struct *p, bool update_load)
>  }
>
>  #ifdef CONFIG_UCLAMP_TASK
> +/* Max allowed minimum utilization */
> +unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
> +
> +/* Max allowed maximum utilization */
> +unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
> +
> +/* All clamps are required to be less or equal than these values */
> +static struct uclamp_se uclamp_default[UCLAMP_CNT];
>
>  /* Integer rounded range for each bucket */
>  #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
> @@ -801,6 +809,52 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
>         return uclamp_idle_value(rq, clamp_id, clamp_value);
>  }
>
> +/*
> + * The effective clamp bucket index of a task depends on, by increasing
> + * priority:
> + * - the task specific clamp value, when explicitly requested from userspace
> + * - the system default clamp value, defined by the sysadmin
> + */
> +static inline struct uclamp_se
> +uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
> +{
> +       struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> +       struct uclamp_se uc_max = uclamp_default[clamp_id];
> +
> +       /* System default restrictions always apply */
> +       if (unlikely(uc_req.value > uc_max.value))
> +               return uc_max;
> +
> +       return uc_req;
> +}
> +
> +static inline unsigned int
> +uclamp_eff_bucket_id(struct task_struct *p, unsigned int clamp_id)

This function is not used anywhere AFAIKT. uclamp_eff_bucket_id() and
uclamp_eff_value() look very similar, maybe they can be combined into
one function returning struct uclamp_se?

> +{
> +       struct uclamp_se uc_eff;
> +
> +       /* Task currently refcounted: use back-annotated (effective) bucket */
> +       if (p->uclamp[clamp_id].active)
> +               return p->uclamp[clamp_id].bucket_id;
> +
> +       uc_eff = uclamp_eff_get(p, clamp_id);
> +
> +       return uc_eff.bucket_id;
> +}
> +
> +unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
> +{
> +       struct uclamp_se uc_eff;
> +
> +       /* Task currently refcounted: use back-annotated (effective) value */
> +       if (p->uclamp[clamp_id].active)
> +               return p->uclamp[clamp_id].value;
> +
> +       uc_eff = uclamp_eff_get(p, clamp_id);
> +
> +       return uc_eff.value;
> +}
> +
>  /*
>   * When a task is enqueued on a rq, the clamp bucket currently defined by the
>   * task's uclamp::bucket_id is refcounted on that rq. This also immediately
> @@ -818,8 +872,12 @@ static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
>         struct uclamp_se *uc_se = &p->uclamp[clamp_id];
>         struct uclamp_bucket *bucket;
>
> +       /* Update task effective clamp */
> +       p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
> +
>         bucket = &uc_rq->bucket[uc_se->bucket_id];
>         bucket->tasks++;
> +       uc_se->active = true;
>
>         uclamp_idle_reset(rq, clamp_id, uc_se->value);
>
> @@ -856,6 +914,7 @@ static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
>         SCHED_WARN_ON(!bucket->tasks);
>         if (likely(bucket->tasks))
>                 bucket->tasks--;
> +       uc_se->active = false;
>
>         /*
>          * Keep "local max aggregation" simple and accept to (possibly)
> @@ -909,8 +968,69 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>                 uclamp_rq_dec_id(p, rq, clamp_id);
>  }
>
> +int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> +                               void __user *buffer, size_t *lenp,
> +                               loff_t *ppos)
> +{
> +       int old_min, old_max;
> +       static DEFINE_MUTEX(mutex);
> +       int result;
> +
> +       mutex_lock(&mutex);
> +       old_min = sysctl_sched_uclamp_util_min;
> +       old_max = sysctl_sched_uclamp_util_max;
> +
> +       result = proc_dointvec(table, write, buffer, lenp, ppos);
> +       if (result)
> +               goto undo;
> +       if (!write)
> +               goto done;
> +
> +       if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
> +           sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
> +               result = -EINVAL;
> +               goto undo;
> +       }
> +
> +       if (old_min != sysctl_sched_uclamp_util_min) {
> +               uclamp_default[UCLAMP_MIN].value =
> +                       sysctl_sched_uclamp_util_min;
> +               uclamp_default[UCLAMP_MIN].bucket_id =
> +                       uclamp_bucket_id(sysctl_sched_uclamp_util_min);
> +       }
> +       if (old_max != sysctl_sched_uclamp_util_max) {
> +               uclamp_default[UCLAMP_MAX].value =
> +                       sysctl_sched_uclamp_util_max;
> +               uclamp_default[UCLAMP_MAX].bucket_id =
> +                       uclamp_bucket_id(sysctl_sched_uclamp_util_max);
> +       }
> +
> +       /*
> +        * Updating all the RUNNABLE task is expensive, keep it simple and do
> +        * just a lazy update at each next enqueue time.
> +        */
> +       goto done;
> +
> +undo:
> +       sysctl_sched_uclamp_util_min = old_min;
> +       sysctl_sched_uclamp_util_max = old_max;
> +done:
> +       mutex_unlock(&mutex);
> +
> +       return result;
> +}
> +
> +static void uclamp_fork(struct task_struct *p)
> +{
> +       unsigned int clamp_id;
> +
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> +               p->uclamp[clamp_id].active = false;
> +}
> +
>  static void __init init_uclamp(void)
>  {
> +       struct uclamp_se uc_max = {};
>         unsigned int clamp_id;
>         int cpu;
>
> @@ -920,16 +1040,23 @@ static void __init init_uclamp(void)
>         }
>
>         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> -               struct uclamp_se *uc_se = &init_task.uclamp[clamp_id];
> +               struct uclamp_se *uc_se = &init_task.uclamp_req[clamp_id];
>
>                 uc_se->value = uclamp_none(clamp_id);
>                 uc_se->bucket_id = uclamp_bucket_id(uc_se->value);
>         }
> +
> +       /* System defaults allow max clamp values for both indexes */
> +       uc_max.value = uclamp_none(UCLAMP_MAX);
> +       uc_max.bucket_id = uclamp_bucket_id(uc_max.value);
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> +               uclamp_default[clamp_id] = uc_max;
>  }
>
>  #else /* CONFIG_UCLAMP_TASK */
>  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
> +static inline void uclamp_fork(struct task_struct *p) { }
>  static inline void init_uclamp(void) { }
>  #endif /* CONFIG_UCLAMP_TASK */
>
> @@ -2530,6 +2657,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>          */
>         p->prio = current->normal_prio;
>
> +       uclamp_fork(p);
> +
>         /*
>          * Revert to default priority/policy on fork if requested.
>          */
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 987ae08147bf..72277f09887d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -446,6 +446,22 @@ static struct ctl_table kern_table[] = {
>                 .mode           = 0644,
>                 .proc_handler   = sched_rr_handler,
>         },
> +#ifdef CONFIG_UCLAMP_TASK
> +       {
> +               .procname       = "sched_uclamp_util_min",
> +               .data           = &sysctl_sched_uclamp_util_min,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = sysctl_sched_uclamp_handler,
> +       },
> +       {
> +               .procname       = "sched_uclamp_util_max",
> +               .data           = &sysctl_sched_uclamp_util_max,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = sysctl_sched_uclamp_handler,
> +       },
> +#endif
>  #ifdef CONFIG_SCHED_AUTOGROUP
>         {
>                 .procname       = "sched_autogroup_enabled",
> --
> 2.20.1
>
