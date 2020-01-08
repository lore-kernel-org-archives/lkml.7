Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA73C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA92206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juSfdx20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgAHIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:05:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33238 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAHIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:05:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so2394347lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1EU76HkXS03l+2T5n8yLlrhyJ/YjUsQu84fPA/UIi0=;
        b=juSfdx20rKroYfzg7vziXZBhUb4VGBE0on7PZqXOvPbzWae0lA0XCMAl6hm/niqXDV
         JcyeMb7o+Wakc74lEFcLdgIaHvQqcmNjbVBQn/kaEO8E3FNqmiAJqh26tocn39R5t5ne
         c4525lZtCqIRi1v0u3z7uL8rrsIAInjFIjyvwvXJiFyRJ9Vl05QO/iT9ogdVXr+NGcjA
         WPPtVUfv3qO4XVEzMQWAZCNjPy462LDelh9EYNoHrftYLit5qr+OUsNdVhUM/jce2NoW
         n6i4UBMV3212rHE11qlfZ3g6gFhJWLhtO3dzxJRXIFGvTT4f6wgee+I1c0U5gvWI7xoR
         4RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1EU76HkXS03l+2T5n8yLlrhyJ/YjUsQu84fPA/UIi0=;
        b=LmLYDRov4wgUwFGm3Q5PI0mgdfQ2iFflzoiwYDCbOLOAHVRgMQRhDbwg3+yKsft81o
         73V68j7RKYMe0+FvHs6jGOQP5J8FC2SVGr8j16gjqXUvgfFQzrA1Bj+13ai3gH7T3XrR
         ERIBFzbzkjFmzWmfTp/PyIGD2F4PxyFEXjJSQ+rwhAwH1V+kPx8N+0vlGPrc5zVYxnWv
         Lvf77quDQcxbr78S5Rvdi2o80OCcYpGcyHD5Byi7p+VnQ4e0lCmfLtr6RiAqxrc4tjxE
         agxKibihGYIBqBjVBybbo7hmHKi3QxiTqbcP+G1o/aHzvzpRKoh8pP2MfqEr7S6Ay15u
         /HmA==
X-Gm-Message-State: APjAAAXTMXEz+S6dDdEHZoJEt7mBmAY8zTe+TC+727wPzWQt9SCROLWu
        +8OibDcdBQrT2LZLASgT4LSGBon3S8Dt4vIx2eUVng==
X-Google-Smtp-Source: APXvYqznTfCxnkN6yMc6J9MYXCYuLRcg6W9ZDL/wJp/vlThoiBCeC6wwPnHDnVnDaQ/egn3DjCROzPSrVibUAilRNqE=
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr2234888lji.87.1578470732042;
 Wed, 08 Jan 2020 00:05:32 -0800 (PST)
MIME-Version: 1.0
References: <885b1be9af68d124f44a863f54e337f8eb6c4917.1577090998.git.viresh.kumar@linaro.org>
 <20200107124244.GY2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20200107124244.GY2844@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Jan 2020 09:05:20 +0100
Message-ID: <CAKfTPtDxRKL+-fbCHkDd-A72=x1hYJnPTM02CUkTOh4g8wtfqw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Load balance aggressively for SCHED_IDLE CPUs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 13:42, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 24, 2019 at 10:43:30AM +0530, Viresh Kumar wrote:
> > The fair scheduler performs periodic load balance on every CPU to check
> > if it can pull some tasks from other busy CPUs. The duration of this
> > periodic load balance is set to sd->balance_interval for the idle CPUs
> > and is calculated by multiplying the sd->balance_interval with the
> > sd->busy_factor (set to 32 by default) for the busy CPUs. The
> > multiplication is done for busy CPUs to avoid doing load balance too
> > often and rather spend more time executing actual task. While that is
> > the right thing to do for the CPUs busy with SCHED_OTHER or SCHED_BATCH
> > tasks, it may not be the optimal thing for CPUs running only SCHED_IDLE
> > tasks.
> >
> > With the recent enhancements in the fair scheduler around SCHED_IDLE
> > CPUs, we now prefer to enqueue a newly-woken task to a SCHED_IDLE
> > CPU instead of other busy or idle CPUs. The same reasoning should be
> > applied to the load balancer as well to make it migrate tasks more
> > aggressively to a SCHED_IDLE CPU, as that will reduce the scheduling
> > latency of the migrated (SCHED_OTHER) tasks.
> >
> > This patch makes minimal changes to the fair scheduler to do the next
> > load balance soon after the last non SCHED_IDLE task is dequeued from a
> > runqueue, i.e. making the CPU SCHED_IDLE. Also the sd->busy_factor is
> > ignored while calculating the balance_interval for such CPUs. This is
> > done to avoid delaying the periodic load balance by few hundred
> > milliseconds for SCHED_IDLE CPUs.
> >
> > This is tested on ARM64 Hikey620 platform (octa-core) with the help of
> > rt-app and it is verified, using kernel traces, that the newly
> > SCHED_IDLE CPU does load balancing shortly after it becomes SCHED_IDLE
> > and pulls tasks from other busy CPUs.
>
> Nothing seems really objectionable here; I have a few comments below.
>
> Vincent?

The change makes sense to me. This should fix the last remaining long
scheduling latency of SCHED_OTHER tasks in presence of SCHED_IDLE
tasks

With the change proposed by Peter below you can add my
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
>
> > @@ -5324,6 +5336,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >       struct sched_entity *se = &p->se;
> >       int task_sleep = flags & DEQUEUE_SLEEP;
> >       int idle_h_nr_running = task_has_idle_policy(p);
> > +     bool was_sched_idle = sched_idle_rq(rq);
> >
> >       for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> > @@ -5370,6 +5383,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >       if (!se)
> >               sub_nr_running(rq, 1);
> >
> > +     /* balance early to pull high priority tasks */
> > +     if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
> > +             rq->next_balance = jiffies;
> > +
> >       util_est_dequeue(&rq->cfs, p, task_sleep);
> >       hrtick_update(rq);
> >  }
>
> This can effectively set ->next_balance in the past, but given we only
> tickle the balancer on every jiffy edge, that is of no concern. It just
> made me stumble when reading this.
>
> Not sure it even deserves a comment or not..
>
> > @@ -9531,6 +9539,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
> >  {
> >       int continue_balancing = 1;
> >       int cpu = rq->cpu;
> > +     int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
> >       unsigned long interval;
> >       struct sched_domain *sd;
> >       /* Earliest time when we have to do rebalance again */
> > @@ -9567,7 +9576,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
> >                       break;
> >               }
> >
> > -             interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
> > +             interval = get_sd_balance_interval(sd, busy);
> >
> >               need_serialize = sd->flags & SD_SERIALIZE;
> >               if (need_serialize) {
> > @@ -9582,10 +9591,16 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
> >                                * env->dst_cpu, so we can't know our idle
> >                                * state even if we migrated tasks. Update it.
> >                                */
> > -                             idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
> > +                             if (idle_cpu(cpu)) {
> > +                                     idle = CPU_IDLE;
> > +                                     busy = 0;
> > +                             } else {
> > +                                     idle = CPU_NOT_IDLE;
> > +                                     busy = !sched_idle_cpu(cpu);
> > +                             }
>
> This is inconsistent vs the earlier code. That is, why not write it
> like:
>
>                                 idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
>                                 busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);

This looks easier to read

>
> >                       }
> >                       sd->last_balance = jiffies;
> > -                     interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
> > +                     interval = get_sd_balance_interval(sd, busy);
> >               }
> >               if (need_serialize)
> >                       spin_unlock(&balancing);
