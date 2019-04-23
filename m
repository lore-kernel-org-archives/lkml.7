Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA4AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380C9218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6fSC253"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfDWXqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:46:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40181 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:46:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id o16so2281708lfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JamLPcc2cO/9BiTkxZ+G70OkDKZaJfqbA7V5gBeer08=;
        b=A6fSC2534C2kU9FncHx1yriPKdTASRI49dp2bGGNzUZq0x5F5GAVGokBOtLD3xVhUL
         GOxVrFhDRAxHAPTY7tOZLotzFuC+8Ww6eeouYneucPAKlFFIS208rPX520SJuPRDfsqM
         de02ijd6JRKwsgvxdmqju7SVLQ5FGu6OwtzCfYvet6iTDUPELCbCo1iJFFo6DNyY1tI4
         hPOo3aoLvOxL/+2h/RT2LdY6yldvTiu/by6W5/KtRMDxny+GLkkVlKkkzgtjcis2OYNm
         jF/qxANoQDsfx9MCWF1yQXYwSAxus+dzkgR7dcaZqUPdTT4HDDynOIz0xETxCT70HnK4
         cLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JamLPcc2cO/9BiTkxZ+G70OkDKZaJfqbA7V5gBeer08=;
        b=fYrcWZhAGAg7uPuZS+wYdAhsO5UxDd1AQS3Xbs51vKkD2+085pVBL8zRZzP8V1GLzG
         RYn9GB5baSS9fNU4wzQ+X0btXd2AmRrL/rFHoFETeFNwumdFL2n9sBkYFsYXGjNvNGHA
         H2UZqkzXHOK+gwct7MzEkC8RzymXq5QWFgU4AYY4vHW+qeLNOAt/3pyXxNmE4shPMZRT
         yAlsBTticssYzpc/NzbtltZEPlqdmmT6xeGkFn7qWMqPIBjelUCXLQSo1PnvbuWktag0
         oXUz5KBWIBlylOUIDfXiDMWkBxihnf3TXVnCjoALULbUiDrsf+PIoTkbLSNCrBYwL/OZ
         hw4w==
X-Gm-Message-State: APjAAAWY0OSjJjstyzp/GV+CZS1OKiFgkdvOYqvhfhMuWqmZpemJsQ8K
        RvHkLXv3bABek2BV7+KO07ZQUJwg9pu2UNiSwNQ=
X-Google-Smtp-Source: APXvYqwU1bUr/iiYmgnlYuuXrWKc+GUNMoE2bJx3PH7cviOXR4VaO5f4zbcS7VbPP1TYfv3AYXbHHfgf2kad1hrymoU=
X-Received: by 2002:ac2:5455:: with SMTP id d21mr14836842lfn.60.1556063190656;
 Tue, 23 Apr 2019 16:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com> <002304fa58577c7926abe9f4cdc8039945985b3d.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <002304fa58577c7926abe9f4cdc8039945985b3d.1556025155.git.vpillai@digitalocean.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 24 Apr 2019 07:46:19 +0800
Message-ID: <CAERHkrtP90QJCc-xxqxJbiWg+0jod_U2i-tHayw=Wd+WRDdTFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/17] sched: Trivial forced-newidle balancer
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> When a sibling is forced-idle to match the core-cookie; search for
> matching tasks to fill the core.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched.h |   1 +
>  kernel/sched/core.c   | 131 +++++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/idle.c   |   1 +
>  kernel/sched/sched.h  |   6 ++
>  4 files changed, 138 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a4b39a28236f..1a309e8546cd 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -641,6 +641,7 @@ struct task_struct {
>  #ifdef CONFIG_SCHED_CORE
>         struct rb_node                  core_node;
>         unsigned long                   core_cookie;
> +       unsigned int                    core_occupation;
>  #endif
>
>  #ifdef CONFIG_CGROUP_SCHED
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9e6e90c6f9b9..e8f5ec641d0a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -217,6 +217,21 @@ struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
>         return match;
>  }
>
> +struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
> +{
> +       struct rb_node *node = &p->core_node;
> +
> +       node = rb_next(node);
> +       if (!node)
> +               return NULL;
> +
> +       p = container_of(node, struct task_struct, core_node);
> +       if (p->core_cookie != cookie)
> +               return NULL;
> +
> +       return p;
> +}
> +
>  /*
>   * The static-key + stop-machine variable are needed such that:
>   *
> @@ -3672,7 +3687,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>         struct task_struct *next, *max = NULL;
>         const struct sched_class *class;
>         const struct cpumask *smt_mask;
> -       int i, j, cpu;
> +       int i, j, cpu, occ = 0;
>
>         if (!sched_core_enabled(rq))
>                 return __pick_next_task(rq, prev, rf);
> @@ -3763,6 +3778,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                                 goto done;
>                         }
>
> +                       if (!is_idle_task(p))
> +                               occ++;
> +
>                         rq_i->core_pick = p;
>
>                         /*
> @@ -3786,6 +3804,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>
>                                                 cpu_rq(j)->core_pick = NULL;
>                                         }
> +                                       occ = 1;
>                                         goto again;
>                                 }
>                         }
> @@ -3808,6 +3827,8 @@ next_class:;
>
>                 WARN_ON_ONCE(!rq_i->core_pick);
>
> +               rq_i->core_pick->core_occupation = occ;
> +
>                 if (i == cpu)
>                         continue;
>
> @@ -3823,6 +3844,114 @@ next_class:;
>         return next;
>  }
>
> +static bool try_steal_cookie(int this, int that)
> +{
> +       struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
> +       struct task_struct *p;
> +       unsigned long cookie;
> +       bool success = false;
> +

try_steal_cookie() is in the loop of for_each_cpu_wrap().
The root domain could be large and we should avoid
stealing cookie if source rq has only one task or dst is really busy.

The following patch eliminated a deadlock issue on my side if I didn't
miss anything in v1. I'll double check with v2, but it at least avoids
unnecessary irq off/on and double rq lock. Especially, it avoids lock
contention that the idle cpu which is holding rq lock in the progress
of load_balance() and tries to lock rq here. I think it might be worth to
be picked up.

Thanks,
-Aubrey

---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 191ebf9..973a75d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3876,6 +3876,13 @@ static bool try_steal_cookie(int this, int that)
        unsigned long cookie;
        bool success = false;

+       /*
+        * Don't steal if src is idle or has only one runnable task,
+        * or dst has more than one runnable task
+        */
+       if (src->nr_running <= 1 || unlikely(dst->nr_running >= 1))
+               return false;
+
        local_irq_disable();
        double_rq_lock(dst, src);

-- 
2.7.4

> +       local_irq_disable();
> +       double_rq_lock(dst, src);
> +
> +       cookie = dst->core->core_cookie;
> +       if (!cookie)
> +               goto unlock;
> +
> +       if (dst->curr != dst->idle)
> +               goto unlock;
> +
> +       p = sched_core_find(src, cookie);
> +       if (p == src->idle)
> +               goto unlock;
> +
> +       do {
> +               if (p == src->core_pick || p == src->curr)
> +                       goto next;
> +
> +               if (!cpumask_test_cpu(this, &p->cpus_allowed))
> +                       goto next;
> +
> +               if (p->core_occupation > dst->idle->core_occupation)
> +                       goto next;
> +
> +               p->on_rq = TASK_ON_RQ_MIGRATING;
> +               deactivate_task(src, p, 0);
> +               set_task_cpu(p, this);
> +               activate_task(dst, p, 0);
> +               p->on_rq = TASK_ON_RQ_QUEUED;
> +
> +               resched_curr(dst);
> +
> +               success = true;
> +               break;
> +
> +next:
> +               p = sched_core_next(p, cookie);
> +       } while (p);
> +
> +unlock:
> +       double_rq_unlock(dst, src);
> +       local_irq_enable();
> +
> +       return success;
> +}
> +
> +static bool steal_cookie_task(int cpu, struct sched_domain *sd)
> +{
> +       int i;
> +
> +       for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
> +               if (i == cpu)
> +                       continue;
> +
> +               if (need_resched())
> +                       break;
> +
> +               if (try_steal_cookie(cpu, i))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static void sched_core_balance(struct rq *rq)
> +{
> +       struct sched_domain *sd;
> +       int cpu = cpu_of(rq);
> +
> +       rcu_read_lock();
> +       raw_spin_unlock_irq(rq_lockp(rq));
> +       for_each_domain(cpu, sd) {
> +               if (!(sd->flags & SD_LOAD_BALANCE))
> +                       break;
> +
> +               if (need_resched())
> +                       break;
> +
> +               if (steal_cookie_task(cpu, sd))
> +                       break;
> +       }
> +       raw_spin_lock_irq(rq_lockp(rq));
> +       rcu_read_unlock();
> +}
> +
> +static DEFINE_PER_CPU(struct callback_head, core_balance_head);
> +
> +void queue_core_balance(struct rq *rq)
> +{
> +       if (!sched_core_enabled(rq))
> +               return;
> +
> +       if (!rq->core->core_cookie)
> +               return;
> +
> +       if (!rq->nr_running) /* not forced idle */
> +               return;
> +
> +       queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
> +}
> +
>  #else /* !CONFIG_SCHED_CORE */
>
>  static struct task_struct *
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index e7f38da60373..44decdcccba1 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -387,6 +387,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next)
>  {
>         update_idle_core(rq);
>         schedstat_inc(rq->sched_goidle);
> +       queue_core_balance(rq);
>  }
>
>  static struct task_struct *
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4cfde289610d..2a5f5a6b11ae 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1013,6 +1013,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>         return &rq->__lock;
>  }
>
> +extern void queue_core_balance(struct rq *rq);
> +
>  #else /* !CONFIG_SCHED_CORE */
>
>  static inline bool sched_core_enabled(struct rq *rq)
> @@ -1025,6 +1027,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>         return &rq->__lock;
>  }
>
> +static inline void queue_core_balance(struct rq *rq)
> +{
> +}
> +
>  #endif /* CONFIG_SCHED_CORE */
>
>  #ifdef CONFIG_SCHED_SMT
> --
> 2.17.1
>
