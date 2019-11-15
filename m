Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140DBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D408F20732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1Jw/23n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKONhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:37:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35162 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKONhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:37:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so10745468ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnvvD2ZeM5vKPP1tfylvPDXkeQr9SFp75yhSYe1Xulc=;
        b=m1Jw/23n+iisdbWIMGdINYIcJqeIdg+yayv8bYQDeE6ZCioIuwnfN59UKSCIwGAz0Q
         xszYqRgALYGj7ngIEKChQ80a2enaeRyCl7n1DZaHPKovpSTIuKfzFA0qLxUlm9O38gvT
         qlpzEc4B62qgJbKkgqbkgRJjVKJGR8Y56m0FxSoO/ZN9B3yzRxd3i2vueC84VVP9KaH6
         qPkHxfwWW+NFxNZfLn6CC022yANCkWRbQiKUf/SbJN0d4ilSLJ8Xd3x/rhcLEst1ohfR
         FqC21XSY63JFBHF5QRBySmKqSgGIjOp1OC3Y6SH1dUEHxcYnSQRNeopmN2XXAtK+9Coh
         iy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnvvD2ZeM5vKPP1tfylvPDXkeQr9SFp75yhSYe1Xulc=;
        b=CtKEL8WLyUvYyg1du/tOTK2n1MJXLCyZx4lK9wUhhoXBAbG6Z52Oot0hYtyoY37v0M
         n22yCGxygMZm4i1OW4M7ZpCVAKA8k2T3bV+JONx7xDwy9HUbyNsgFVv7Hv+JLzKB820X
         Sw42Yj5Wflbos2fn0l2lkNYyMGeB1mdiEnic6Kflsb3NvqMryteDCI/fvq4Z3AZHOLza
         N9k0/rpD9wg3NoYTfh0gM8WJ2LpodxfQs+ysO3mbUDvtk7Q+nqQK+4oQVa5PMmJsOz1h
         /BSxMVscMa8rMaeBSUwoRK4VMiEnzU3JFAxHgJI4Umk0NJSBfSNJetzUZQSNXrcqZrLa
         dYCA==
X-Gm-Message-State: APjAAAXxvSNHIHbVd6P2k/wKhcGbmTgjilQjrbG0ZXkZAywOLXBe+VRg
        0ynhyqW0dvjHwehgmzNZvkQJMCHNlOalqAg7xOERzw==
X-Google-Smtp-Source: APXvYqyOdqqccvOtm7AV1N1Yxfh47Ub5SZrqKZQUq6pcKfjpwCzYSpvGv94ZQGpxs2WH77C5iVDiLHZopJCYYCzMkgg=
X-Received: by 2002:a2e:9695:: with SMTP id q21mr10819701lji.206.1573825059112;
 Fri, 15 Nov 2019 05:37:39 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org> <20191115132520.GJ4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115132520.GJ4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 14:37:27 +0100
Message-ID: <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 14:25, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 69a81a5..3be44e1 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3504,9 +3504,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >       cfs_rq->load_last_update_time_copy = sa->last_update_time;
> >  #endif
> >
> > -     if (decayed)
> > -             cfs_rq_util_change(cfs_rq, 0);
> > -
> >       return decayed;
> >  }
>
> This removes the call from the for_each_leaf_cfs_rq_safe() loop.
>
> > @@ -7543,18 +7544,19 @@ static void update_blocked_averages(int cpu)
> >       const struct sched_class *curr_class;
> >       struct rq_flags rf;
> >       bool done = true;
> > +     int decayed;
> >
> >       rq_lock_irqsave(rq, &rf);
> >       update_rq_clock(rq);
> >
> >       /*
> > -      * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> > -      * that RT, DL and IRQ signals have been updated before updating CFS.
> > +      * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
> > +      * DL and IRQ signals have been updated before updating CFS.
> >        */
> >       curr_class = rq->curr->sched_class;
> > -     update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> > -     update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> > -     update_irq_load_avg(rq, 0);
> > +     decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> > +     decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> > +     decayed |= update_irq_load_avg(rq, 0);
>
> Should not all 3 have their windows aligned and thus alway return the
> exact same value?

rt and dl yes but not irq

But having aligned window doesn't mean that they will all decay.
One can have been updated just before (during a dequeue as an example)
or at least less than 1ms before

>
> >
> >       /* Don't need periodic decay once load/util_avg are null */
> >       if (others_have_blocked(rq))
> > @@ -7567,9 +7569,13 @@ static void update_blocked_averages(int cpu)
> >       for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
> >               struct sched_entity *se;
> >
> > -             if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> > +             if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
> >                       update_tg_load_avg(cfs_rq, 0);
> >
> > +                     if (cfs_rq == &rq->cfs)
> > +                             decayed = 1;
>
> And that restores it.
>
> But should not also rq->cfs's window be aligned with the above 3?
> Meaning that this one, with exception of the list_del, covers all 4.
>
> > +             }
> > +
> >               /* Propagate pending load changes to the parent, if any: */
> >               se = cfs_rq->tg->se[cpu];
> >               if (se && !skip_blocked_update(se))
> > @@ -7588,6 +7594,9 @@ static void update_blocked_averages(int cpu)
> >       }
> >
> >       update_blocked_load_status(rq, !done);
> > +
> > +     if (decayed)
> > +             cpufreq_update_util(rq, 0);
> >       rq_unlock_irqrestore(rq, &rf);
> >  }
> >
> > @@ -7644,22 +7653,22 @@ static inline void update_blocked_averages(int cpu)
> >       struct cfs_rq *cfs_rq = &rq->cfs;
> >       const struct sched_class *curr_class;
> >       struct rq_flags rf;
> > +     int decayed;
> >
> >       rq_lock_irqsave(rq, &rf);
> >       update_rq_clock(rq);
> >
> > -     /*
> > -      * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
> > -      * that RT, DL and IRQ signals have been updated before updating CFS.
> > -      */
> >       curr_class = rq->curr->sched_class;
> > -     update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> > -     update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> > -     update_irq_load_avg(rq, 0);
> > +     decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> > +     decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> > +     decayed |= update_irq_load_avg(rq, 0);
> >
> > -     update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> > +     decayed |= update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
>
> And that thus this one makes all 3 above redundant.
>
> >
> >       update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
> > +
> > +     if (decayed)
> > +             cpufreq_update_util(rq, 0);
> >       rq_unlock_irqrestore(rq, &rf);
> >  }
>
> That is, I'm almost tempted to prefer a variant of your initial hack,
> that refuses to remove rq->cfs from the list.
>
> That avoids having to care about the rt,dl,irq decays (their windows
> align with rq->cfs) and makes smp/up similar.
>
>
> I still don't actually understand how any of this makes intel_pstate
> happy though.
