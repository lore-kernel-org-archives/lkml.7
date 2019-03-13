Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD56C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508E62077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXbyA5EJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfCMVBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:01:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40316 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:01:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so3547025wri.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooeB9frmEz7/jM7yQCHASLdIJ3TvMV/aBEhnqHp4fbc=;
        b=GXbyA5EJ8mvI4Xc1cx1tVHW9qv3Jx/OpUEfxxicsFG4uUAWbKVR3/FV64JqEbRU1W+
         xmlEbUrrYtoBAP8mPFoAI/MfKiVOxtItdeYPCIkCI7dnLb9MlSePEHNFJpJUGinsrGJI
         mqcWY5t/jm+oCWHT78iXXAwWLr9VjjtlRRGikTn7/zyquCF3f+LRXpCxp52EZgJP5DXz
         lxv4deWQkgtcOV0ZOlxXIvC3ZxB710Mu+Fv2H7U4prVrjPSCfSn74NY8v1d3CJfBq9ul
         2YbJ+ZZ3NIzH3v4zd+vaGKi8cgNMyPwjnHea00TEA3vcB7ttCJIciVZ8VZ/sojtakHwA
         3Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooeB9frmEz7/jM7yQCHASLdIJ3TvMV/aBEhnqHp4fbc=;
        b=XOQ/CesO6qHJndpkQBnVLPLzwSspgDJjnIJj+ZjrWBNCKS/DiY+YdwmPmTCamQyWBg
         fxQHzo6Uod190zpSsMryxQQnQeR9poiJKiUGKR/G2Q9Ln2Yi8NBNpSpcIMVteDq38d3p
         jM+bag8/gmirn8WTIrMim3oZx1ljxjeiGxgy1Ur+Oja9OBTuNQkw/eqZMm2a8znRagHf
         i+S5lzVgdW+fyouGzMuIepDSRiKuSgk+i1Hs/hrXpSEonU1F3mtKCqUNhSwFFWE/xg0q
         mWMyGjKsMcaQ4lAKrPbADaXMRIURY9Q7GpngaWJTacWaKs0IFcUi5N1dU7revmvnvoDU
         F1xA==
X-Gm-Message-State: APjAAAUce+MNTHmeWj2HBHJxAUXQGPvIRCKHZ2CWqqoFsjyp9pUDRjgy
        4nbmL4xz+dcebQPDAcBgWobpfj9+xvpV/nLdfEbfpg==
X-Google-Smtp-Source: APXvYqz+tmxZ/39wwsIIdL7Y9FUzWES+pyNwq5d2i4ZPAn4eDJHcfk4vaphC9PzxLWwvcVZjnmYK0ibTY+zAKpuCsqM=
X-Received: by 2002:adf:face:: with SMTP id a14mr31291400wrs.320.1552510907381;
 Wed, 13 Mar 2019 14:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com> <21171fa0-7fd5-ebbf-dd48-d6668ed563af@arm.com>
 <20190313151535.q5ivsuywvwkewrk5@e110439-lin>
In-Reply-To: <20190313151535.q5ivsuywvwkewrk5@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 13 Mar 2019 14:01:36 -0700
Message-ID: <CAJuCfpGzxnV8UH4h0O7V03RrecEkJA3JQ3zJTu=b8SHhnOo_mg@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets refcounting
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
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

On Wed, Mar 13, 2019 at 8:15 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 12-Mar 13:52, Dietmar Eggemann wrote:
> > On 2/8/19 11:05 AM, Patrick Bellasi wrote:
> >
> > [...]
> >
> > > +config UCLAMP_BUCKETS_COUNT
> > > +   int "Number of supported utilization clamp buckets"
> > > +   range 5 20
> > > +   default 5
> > > +   depends on UCLAMP_TASK
> > > +   help
> > > +     Defines the number of clamp buckets to use. The range of each bucket
> > > +     will be SCHED_CAPACITY_SCALE/UCLAMP_BUCKETS_COUNT. The higher the
> > > +     number of clamp buckets the finer their granularity and the higher
> > > +     the precision of clamping aggregation and tracking at run-time.
> > > +
> > > +     For example, with the default configuration we will have 5 clamp
> > > +     buckets tracking 20% utilization each. A 25% boosted tasks will be
> > > +     refcounted in the [20..39]% bucket and will set the bucket clamp
> > > +     effective value to 25%.
> > > +     If a second 30% boosted task should be co-scheduled on the same CPU,
> > > +     that task will be refcounted in the same bucket of the first task and
> > > +     it will boost the bucket clamp effective value to 30%.
> > > +     The clamp effective value of a bucket is reset to its nominal value
> > > +     (20% in the example above) when there are anymore tasks refcounted in
> >
> > this sounds weird.
>
> Why ?

Should probably be "when there are no more tasks refcounted"

> >
> > [...]
> >
> > > +static inline unsigned int uclamp_bucket_value(unsigned int clamp_value)
> > > +{
> > > +   return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
> > > +}
> >
> > Soemthing like uclamp_bucket_nominal_value() should be clearer.
>
> Maybe... can update it in v8
>

uclamp_bucket_base_value is a little shorter, just to consider :)

> > > +static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> > > +{
> > > +   struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> > > +   unsigned int max_value = uclamp_none(clamp_id);
> > > +   unsigned int bucket_id;
> >
> > unsigned int bucket_id = UCLAMP_BUCKETS;
> >
> > > +
> > > +   /*
> > > +    * Both min and max clamps are MAX aggregated, thus the topmost
> > > +    * bucket with some tasks defines the rq's clamp value.
> > > +    */
> > > +   bucket_id = UCLAMP_BUCKETS;
> >
> > to get rid of this line?
>
> I put it on a different line as a justfication for the loop variable
> initialization described in the comment above.
>
> >
> > > +   do {
> > > +           --bucket_id;
> > > +           if (!rq->uclamp[clamp_id].bucket[bucket_id].tasks)
> >
> > if (!bucket[bucket_id].tasks)
>
> Right... that's some leftover from the last refactoring!
>
> [...]
>
> > > + * within each bucket the exact "requested" clamp value whenever all tasks
> > > + * RUNNABLE in that bucket require the same clamp.
> > > + */
> > > +static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
> > > +                               unsigned int clamp_id)
> > > +{
> > > +   unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> > > +   unsigned int rq_clamp, bkt_clamp, tsk_clamp;
> >
> > Wouldn't it be easier to have a pointer to the task's and rq's uclamp
> > structure as well to the bucket?
> >
> > -       unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> > +       struct uclamp_se *uc_se = &p->uclamp[clamp_id];
> > +       struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
> > +       struct uclamp_bucket *bucket = &uc_rq->bucket[uc_se->bucket_id];
>
> I think I went back/forth a couple of times in using pointer or the
> extended version, which both have pros and cons.
>
> I personally prefer the pointers as you suggest but I've got the
> impression in the past that since everybody cleared "basic C trainings"
> it's not so difficult to read the code above too.
>
> > The code in uclamp_rq_inc_id() and uclamp_rq_dec_id() for example becomes
> > much more readable.
>
> Agree... let's try to switch once again in v8 and see ;)
>
> > [...]
> >
> > >   struct sched_class {
> > >     const struct sched_class *next;
> > > +#ifdef CONFIG_UCLAMP_TASK
> > > +   int uclamp_enabled;
> > > +#endif
> > > +
> > >     void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
> > >     void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
> > > -   void (*yield_task)   (struct rq *rq);
> > > -   bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
> > >     void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
> > > @@ -1685,7 +1734,6 @@ struct sched_class {
> > >     void (*set_curr_task)(struct rq *rq);
> > >     void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
> > >     void (*task_fork)(struct task_struct *p);
> > > -   void (*task_dead)(struct task_struct *p);
> > >     /*
> > >      * The switched_from() call is allowed to drop rq->lock, therefore we
> > > @@ -1702,12 +1750,17 @@ struct sched_class {
> > >     void (*update_curr)(struct rq *rq);
> > > +   void (*yield_task)   (struct rq *rq);
> > > +   bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
> > > +
> > >   #define TASK_SET_GROUP            0
> > >   #define TASK_MOVE_GROUP           1
> > >   #ifdef CONFIG_FAIR_GROUP_SCHED
> > >     void (*task_change_group)(struct task_struct *p, int type);
> > >   #endif
> > > +
> > > +   void (*task_dead)(struct task_struct *p);
> >
> > Why do you move yield_task, yield_to_task and task_dead here?
>
> Since I'm adding a new field at the beginning of the struct, which is
> used at enqueue/dequeue time, this is to ensure that all the
> callbacks used in these paths are grouped together and don't fall
> across a cache line... but yes, that's supposed to be a
> micro-optimization which I can skip in this patch.
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
