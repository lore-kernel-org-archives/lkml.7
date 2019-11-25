Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6766C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729D520718
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYNzFg8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKYJQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:16:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44426 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfKYJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:16:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so14863827ljl.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tey/2bSNLmncQ8qgh7bSJ4ZLW9GLt07VNpXvs1BaRmk=;
        b=ZYNzFg8iJVVw3Ip3wnefyyJwmjdEaxvxUjfKkUhpgkiDBp52YdhhdonZL0W48Swta3
         A5y7VwHjZ05V5GpKOha7OSjIIV3JSpyn8FHEtUMqWx5jisHy/yq7hlLqyeimzWOQwAiJ
         2RA/x3yJcGRU7FkkwNlchigZNLvq1OvO9aA20uW5pYiRxwodazQAmgdKgeEXF+NETcFU
         r9Fr+KvjtvqLXhPCC/9MzLn8mbMVkoE31zuyvwJ3hdVF04ZPQr48aQRf0Q4AAjzeAZrM
         Vqrni3qQVXjYnVaYaICiUvdkznDUctnD5HWcaQPnNmCFZ25fZjHA3PmkMwAV1LSaz7ER
         XBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tey/2bSNLmncQ8qgh7bSJ4ZLW9GLt07VNpXvs1BaRmk=;
        b=Lf2sB5IyZgyKTu8vflusbEOFAOJAEmvSJozsdwhb2pIptRjsrsFyW2QQqF4wT5Wb5t
         3xd85fcBz2hicSlZWkZ5c2UYe9mv8rhE8O/NuYyuv95/ojeAq1iDhZ6fgMRBBj3M3PUa
         30wkipkWsxtzFmp3JA6WqKIBMM9WoRuvjnSoIob5abJioGyTel2ohf+0/cg298JWDoK5
         iUDKi0CZdmf4gcsouTly6mSA81rpPCsQM7t2PzSit60WqINsWSwmwpgvNjQQNvReHGdT
         0mmSEOKuewpmK+VDV/kHBE4/EFKM4l8BOGEUgBHYVChzAH69qzJA3BOKwjwyYcwotHCb
         shtA==
X-Gm-Message-State: APjAAAVsxjO6eNb7wYyfu80ewEsJaGEeaF2OtNJmSiyTm+6hz+vozNqQ
        +/bSyvcsdWqaUe7neVazjs8aafT5I5RCK0EUf1ny2Q==
X-Google-Smtp-Source: APXvYqyBop5qFlyC+Rwp1ZnWtKcefNU13ZadomU6vhz+dLgGZghH+Jd98He1IQN/Z8B+mww2KGjg7sMnppwVJtWaGeo=
X-Received: by 2002:a2e:9695:: with SMTP id q21mr20776084lji.206.1574673387183;
 Mon, 25 Nov 2019 01:16:27 -0800 (PST)
MIME-Version: 1.0
References: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org> <2bb75047-4a93-4f1d-e2ff-99c499b5a070@arm.com>
In-Reply-To: <2bb75047-4a93-4f1d-e2ff-99c499b5a070@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Nov 2019 10:16:15 +0100
Message-ID: <CAKfTPtC54O7tY4T2RmYAFdZ7iM-wTnabbdeatRn6zY_P=jM9YQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix rework of find_idlest_group()
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 at 15:37, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> I took the liberty of adding some commenting nits in my review. I
> know this is already in tip, but as Mel pointed out this should be merged
> with the rework when sent out to mainline (similar to the removal of
> fix_small_imbalance() & the LB rework).
>
> On 22/10/2019 17:46, Vincent Guittot wrote:
> > The task, for which the scheduler looks for the idlest group of CPUs, must
> > be discounted from all statistics in order to get a fair comparison
> > between groups. This includes utilization, load, nr_running and idle_cpus.
> >
> > Such unfairness can be easily highlighted with the unixbench execl 1 task.
> > This test continuously call execve() and the scheduler looks for the idlest
> > group/CPU on which it should place the task. Because the task runs on the
> > local group/CPU, the latter seems already busy even if there is nothing
> > else running on it. As a result, the scheduler will always select another
> > group/CPU than the local one.
> >
> > Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > This recover most of the perf regression on my system and I have asked
> > Rong if he can rerun the test with the patch to check that it fixes his
> > system as well.
> >
> >  kernel/sched/fair.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 83 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a81c364..0ad4b21 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5379,6 +5379,36 @@ static unsigned long cpu_load(struct rq *rq)
> >  {
> >       return cfs_rq_load_avg(&rq->cfs);
> >  }
> > +/*
> > + * cpu_load_without - compute cpu load without any contributions from *p
> > + * @cpu: the CPU which load is requested
> > + * @p: the task which load should be discounted
>
> For both @cpu and @p, s/which/whose/ (also applies to cpu_util_without()
> which inspired this).

As you mentioned, this is inspired from cpu_util_without and stay
consistent with it

>
> > + *
> > + * The load of a CPU is defined by the load of tasks currently enqueued on that
> > + * CPU as well as tasks which are currently sleeping after an execution on that
> > + * CPU.
> > + *
> > + * This method returns the load of the specified CPU by discounting the load of
> > + * the specified task, whenever the task is currently contributing to the CPU
> > + * load.
> > + */
> > +static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
> > +{
> > +     struct cfs_rq *cfs_rq;
> > +     unsigned int load;
> > +
> > +     /* Task has no contribution or is new */
> > +     if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> > +             return cpu_load(rq);
> > +
> > +     cfs_rq = &rq->cfs;
> > +     load = READ_ONCE(cfs_rq->avg.load_avg);
> > +
> > +     /* Discount task's util from CPU's util */
>
> s/util/load
>
> > +     lsub_positive(&load, task_h_load(p));
> > +
> > +     return load;
> > +}
> >
> >  static unsigned long capacity_of(int cpu)
> >  {
> > @@ -8117,10 +8147,55 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
> >  struct sg_lb_stats;
> >
> >  /*
> > + * task_running_on_cpu - return 1 if @p is running on @cpu.
> > + */
> > +
> > +static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
>           ^^^^^^^^^^^^
> That could very well be bool, right?
>
>
> > +{
> > +     /* Task has no contribution or is new */
> > +     if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> > +             return 0;
> > +
> > +     if (task_on_rq_queued(p))
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * idle_cpu_without - would a given CPU be idle without p ?
> > + * @cpu: the processor on which idleness is tested.
> > + * @p: task which should be ignored.
> > + *
> > + * Return: 1 if the CPU would be idle. 0 otherwise.
> > + */
> > +static int idle_cpu_without(int cpu, struct task_struct *p)
>           ^^^
> Ditto on the boolean return values

This is an extension of idle_cpu which also returns int and I wanted
to stay consistent with it

So we might want to make some kind of cleanup or rewording of
interfaces and their descriptions but this should be done as  a whole
and out of the scope of this patch and would worth having a dedicated
patch IMO because it would imply to modify other patch of the code
that is not covered by this patch like idle_cpu or cpu_util_without


>
> > +{
> > +     struct rq *rq = cpu_rq(cpu);
> > +
> > +     if ((rq->curr != rq->idle) && (rq->curr != p))
> > +             return 0;
> > +
> > +     /*
> > +      * rq->nr_running can't be used but an updated version without the
> > +      * impact of p on cpu must be used instead. The updated nr_running
> > +      * be computed and tested before calling idle_cpu_without().
> > +      */
> > +
> > +#ifdef CONFIG_SMP
> > +     if (!llist_empty(&rq->wake_list))
> > +             return 0;
> > +#endif
> > +
> > +     return 1;
> > +}
> > +
> > +/*
> >   * update_sg_wakeup_stats - Update sched_group's statistics for wakeup.
> > - * @denv: The ched_domain level to look for idlest group.
> > + * @sd: The sched_domain level to look for idlest group.
> >   * @group: sched_group whose statistics are to be updated.
> >   * @sgs: variable to hold the statistics for this group.
> > + * @p: The task for which we look for the idlest group/CPU.
> >   */
> >  static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> >                                         struct sched_group *group,
