Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B7DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A0E21897
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEFcv12Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfGVK1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:27:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39078 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfGVK1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:27:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so37021959ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uO8QssrA4thQQ0TQYXTnyB0KjJivAP5UmYfHEDlsSck=;
        b=KEFcv12YnoFI+/iDFg3BS6tgInlZUR+RBMKw+KyIKs3VsDy8SP9bOF2338TOIaVyVV
         CAMJJ3OUazF1SZhzlwAYtEMFyFhEQoZ/76mD5owdP0uW6yxnRMwhB/QMNwtb6aP+5aW/
         C+UZqP2AVYUkFdpe/f/qOWEP+/Q2jBW8G8YD+XJiQzbvyKg/sUHiiWW6+8LNNqRXv30m
         3tXasH6hMnP6nA3BcsD+ZUfGBFq0dQV3YT7LrLnS4oYQYn8xaAEpxvjSWZb9Xddd/sdr
         A1NgdrlbFP9uSh03eq69jQsIPpYgachYRSFmN98w8wqSO6fE+rwYKsQ08PGSYlcOtVm+
         gz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uO8QssrA4thQQ0TQYXTnyB0KjJivAP5UmYfHEDlsSck=;
        b=DXKKzFMU8xsOtBY9FwBqjNcSimTI4Ex7xw2VKHaQFyKQguEFQGkbEd15k2OjbE9724
         Ybxh2fDDZ0FsRpjW8yKbgouYwDZoSWKavpC4R39E1a3DDlcrQSAqAdMKCsg6VJJGwV1Z
         X4W7QYOPlQvsSGEH9cHRc/VscA1wlLxFGiu+5ppSHQhR6UAiU6WAXztwx/W+esxWrL8R
         iNlSQQgbU2o/MnRgck/v6AWHKHwyAKm/+KuunPIrdyRjV6dv8i+ifYYsZkaZaheeC+BM
         OsaxnisFq7cYhOuS57zJZj1MRTuPosZaBLwqwtBUHGahS1l4gMK+v1Cnn5Dsyrt8n7l7
         PmVw==
X-Gm-Message-State: APjAAAVq6OV4E7DUdprRBkPOBN0b26uRml0yV2IPQxNqnb5kERsXsz3T
        fcOowOdQD9tVtOhHs//7YRrSdz2wTLbvnnibwfcUr/yB
X-Google-Smtp-Source: APXvYqzxeGFvCv+z3W/QgClkk3jBj7ZvzkrPNjnG11edWUMx1Jhm5c8XfsmoVA84+thKlxsR2nMs/RIHOsVqM/Snj8s=
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr36476353ljk.70.1563791217799;
 Mon, 22 Jul 2019 03:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com> <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad> <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com> <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
In-Reply-To: <20190718100714.GA469@aaronlu>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Mon, 22 Jul 2019 18:26:46 +0800
Message-ID: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 6:07 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On Wed, Jun 19, 2019 at 02:33:02PM -0400, Julien Desfossez wrote:
> > On 17-Jun-2019 10:51:27 AM, Aubrey Li wrote:
> > > The result looks still unfair, and particularly, the variance is too high,
> >
> > I just want to confirm that I am also seeing the same issue with a
> > similar setup. I also tried with the priority boost fix we previously
> > posted, the results are slightly better, but we are still seeing a very
> > high variance.
> >
> > On average, the results I get for 10 30-seconds runs are still much
> > better than nosmt (both sysbench pinned on the same sibling) for the
> > memory benchmark, and pretty similar for the CPU benchmark, but the high
> > variance between runs is indeed concerning.
>
> I was thinking to use util_avg signal to decide which task win in
> __prio_less() in the cross cpu case. The reason util_avg is chosen
> is because it represents how cpu intensive the task is, so the end
> result is, less cpu intensive task will preempt more cpu intensive
> task.
>
> Here is the test I have done to see how util_avg works
> (on a single node, 16 cores, 32 cpus vm):
> 1 Start tmux and then start 3 windows with each running bash;
> 2 Place two shells into two different cgroups and both have cpu.tag set;
> 3 Switch to the 1st tmux window, start
>   will-it-scale/page_fault1_processes -t 16 -s 30
>   in the first tagged shell;
> 4 Switch to the 2nd tmux window;
> 5 Start
>   will-it-scale/page_fault1_processes -t 16 -s 30
>   in the 2nd tagged shell;
> 6 Switch to the 3rd tmux window;
> 7 Do some simple things in the 3rd untagged shell like ls to see if
>   untagged task is able to proceed;
> 8 Wait for the two page_fault workloads to finish.
>
> With v3 here, I can not do step 4 and later steps, i.e. the 16
> page_fault1 processes started in step 3 will occupy all 16 cores and
> other tasks do not have a chance to run, including tmux, which made
> switching tmux window impossible.
>
> With the below patch on top of v3 that makes use of util_avg to decide
> which task win, I can do all 8 steps and the final scores of the 2
> workloads are: 1796191 and 2199586. The score number are not close,
> suggesting some unfairness, but I can finish the test now...
>
> Here is the diff(consider it as a POC):
>
> ---
>  kernel/sched/core.c  | 35 ++---------------------------------
>  kernel/sched/fair.c  | 36 ++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  2 ++
>  3 files changed, 40 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 26fea68f7f54..7557a7bbb481 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -105,25 +105,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
>         if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
>                 return !dl_time_before(a->dl.deadline, b->dl.deadline);
>
> -       if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
> -               u64 a_vruntime = a->se.vruntime;
> -               u64 b_vruntime = b->se.vruntime;
> -
> -               /*
> -                * Normalize the vruntime if tasks are in different cpus.
> -                */
> -               if (task_cpu(a) != task_cpu(b)) {
> -                       b_vruntime -= task_cfs_rq(b)->min_vruntime;
> -                       b_vruntime += task_cfs_rq(a)->min_vruntime;
> -
> -                       trace_printk("(%d:%Lu,%Lu,%Lu) <> (%d:%Lu,%Lu,%Lu)\n",
> -                                    a->pid, a_vruntime, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
> -                                    b->pid, b_vruntime, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
> -
> -               }
> -
> -               return !((s64)(a_vruntime - b_vruntime) <= 0);
> -       }
> +       if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
> +               return cfs_prio_less(a, b);
>
>         return false;
>  }
> @@ -3663,20 +3646,6 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
>         if (!class_pick)
>                 return NULL;
>
> -       if (!cookie) {
> -               /*
> -                * If class_pick is tagged, return it only if it has
> -                * higher priority than max.
> -                */
> -               bool max_is_higher = sched_feat(CORESCHED_STALL_FIX) ?
> -                                    max && !prio_less(max, class_pick) :
> -                                    max && prio_less(class_pick, max);
> -               if (class_pick->core_cookie && max_is_higher)
> -                       return idle_sched_class.pick_task(rq);
> -
> -               return class_pick;
> -       }
> -
>         /*
>          * If class_pick is idle or matches cookie, return early.
>          */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 26d29126d6a5..06fb00689db1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10740,3 +10740,39 @@ __init void init_sched_fair_class(void)
>  #endif /* SMP */
>
>  }
> +
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +       struct sched_entity *sea = &a->se;
> +       struct sched_entity *seb = &b->se;
> +       bool samecore = task_cpu(a) == task_cpu(b);
> +       struct task_struct *p;
> +       s64 delta;
> +
> +       if (samecore) {
> +               /* vruntime is per cfs_rq */
> +               while (!is_same_group(sea, seb)) {
> +                       int sea_depth = sea->depth;
> +                       int seb_depth = seb->depth;
> +
> +                       if (sea_depth >= seb_depth)
> +                               sea = parent_entity(sea);
> +                       if (sea_depth <= seb_depth)
> +                               seb = parent_entity(seb);
> +               }
> +
> +               delta = (s64)(sea->vruntime - seb->vruntime);
> +       }
> +
> +       /* across cpu: use util_avg to decide which task to run */
> +       delta = (s64)(sea->avg.util_avg - seb->avg.util_avg);

The granularity period of util_avg seems too large to decide task priority
during pick_task(), at least it is in my case, cfs_prio_less() always picked
core max task, so pick_task() eventually picked idle, which causes this change
not very helpful for my case.

 <idle>-0     [057] dN..    83.716973: __schedule: max: sysbench/2578
ffff889050f68600
 <idle>-0     [057] dN..    83.716974: __schedule:
(swapper/5/0;140,0,0) ?< (mysqld/2511;119,1042118143,0)
 <idle>-0     [057] dN..    83.716975: __schedule:
(sysbench/2578;119,96449836,0) ?< (mysqld/2511;119,1042118143,0)
 <idle>-0     [057] dN..    83.716975: cfs_prio_less: picked
sysbench/2578 util_avg: 20 527 -507 <======= here===
 <idle>-0     [057] dN..    83.716976: __schedule: pick_task cookie
pick swapper/5/0 ffff889050f68600

Thanks,
-Aubrey
