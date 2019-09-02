Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567A8C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C0D2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJUvi748"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfIBNHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:07:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33634 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfIBNHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:07:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so12851670ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKe979HgeQxbQmohkDzxqNV0aLCJsYbgurIOUVPKIDk=;
        b=VJUvi748QPw6Xa3k4353sOFHw8vcJ+qLf/K/ISQDfo+qeMoVbx+M1/UOVe8Xb5vgAO
         Lm2jl/d09MmqpyyWmMovPT/qx8zI1wKFrv/9Yx0MBGiCMXWUXgG13ZxQWl572XEZ3L8R
         5GpUXKwdUJf2CE8MSbVXfsUQiOXSbECOicIS3yK7NTP/LVDZFpLlN1jTpqj2m9CEbVFk
         GRtke8tbyj5dWt2YjGeX+M470mo58u4eZ6W2GIbyuMeU2eMex5m1ftXz+Pjhiz72a0l9
         z8HnjnGHoe5Ba1n958EEflt2pBMYzc2dNvAYOmuhk5jGs2+JJXvhPTaU5tiVbL/xsgZn
         3rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKe979HgeQxbQmohkDzxqNV0aLCJsYbgurIOUVPKIDk=;
        b=UJMbWfRkiPu2PV3gCZAthYQsE4hxVPcVWUcziLH2dedVOFIEE2dPOvv3DE/2N96c+O
         Ch6RFRKexWuZY0zSvSuP0/HC2ZT/5hPnPFWWYQIr0gSIthesBiBZJ0rqGNfaCb3M3ykq
         9NjirR6MzEpZjErDcdECSN2emapti4o4kBpzqh6Urqvv+VZZF/nbDxHcaraQtXu7sWDD
         XtoH0qEH0xauHesl5FaIWE3YoQshvV+X5EiI/mMQmLgV3XNefVGI8Npb3R9SQfVon9Mu
         vSr+lmTEw+Wh4vXQ501KRvhXHZzbi6BXpkeeINllIBqjmGb4gQYjxEy3InX44f0O6wtV
         4OsQ==
X-Gm-Message-State: APjAAAVt25DjXmWvl1j8ARVVceTKl1KV1NtNC3XksY61yOYW8z25yGTb
        lpOYo33fHVC0r6iz3b8wC1RRI3ibaGYShntuijK9Lg==
X-Google-Smtp-Source: APXvYqyTR5uL4Cmcpp9m9VUAltcd+623TUnvDSvKhyv7YLKMHzCNTO/FcEj+YxRZ8bv0eb7MGFx9ig+LME37AfVGBRg=
X-Received: by 2002:a2e:80cf:: with SMTP id r15mr4715598ljg.219.1567429656576;
 Mon, 02 Sep 2019 06:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org> <20190809052124.13016-1-hdanton@sina.com>
In-Reply-To: <20190809052124.13016-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 2 Sep 2019 15:07:25 +0200
Message-ID: <CAKfTPtBAvK8Ka0-qpwUkaT09e0NvEH6B-pYyvzwuX2rTC5FZSA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] sched/fair: use rq->nr_running when balancing load
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

Sorry for the late reply.
I have noticed that i didn't answer your question while preparing v3

On Fri, 9 Aug 2019 at 07:21, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Thu,  1 Aug 2019 16:40:21 +0200 Vincent Guittot wrote:
> >
> > cfs load_balance only takes care of CFS tasks whereas CPUs can be used by
> > other scheduling class. Typically, a CFS task preempted by a RT or deadline
> > task will not get a chance to be pulled on another CPU because the
> > load_balance doesn't take into account tasks from classes.
>
> We can add something accordingly in RT to push cfs tasks to another cpu
> in this direction if the pulling above makes some sense missed long.

RT class doesn't and can't touch CFS tasks but the ilb will be kicked
to check if another CPU can pull the CFS task.

> I doubt we can as we can not do too much about RT tasks on any cpu.
> Nor is busiest cpu selected for load balancing based on a fifo cpuhog.

This patch takes into account all type tasks when checking the state
of a group and when trying to balance the number of tasks but of
course we can only detach and move the cfs tasks at the end.

So if we have 1 RT task and 1 CFS task competing for the same CPU but
there is an idle CPU, the CFS task will be pulled during the
load_balance of the idle CPU whereas it was not the case before.

>
> > Add sum of nr_running in the statistics and use it to detect such
> > situation.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a8681c3..f05f1ad 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7774,6 +7774,7 @@ struct sg_lb_stats {
> >       unsigned long group_load; /* Total load over the CPUs of the group */
> >       unsigned long group_capacity;
> >       unsigned long group_util; /* Total utilization of the group */
> > +     unsigned int sum_nr_running; /* Nr tasks running in the group */
> >       unsigned int sum_h_nr_running; /* Nr tasks running in the group */
>
> A different comment is appreciated.

ok

>
> >       unsigned int idle_cpus;
> >       unsigned int group_weight;
> > @@ -8007,7 +8008,7 @@ static inline int sg_imbalanced(struct sched_group *group)
> >  static inline bool
> >  group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
> >  {
> > -     if (sgs->sum_h_nr_running < sgs->group_weight)
> > +     if (sgs->sum_nr_running < sgs->group_weight)
> >               return true;
> >
> >       if ((sgs->group_capacity * 100) >
> > @@ -8028,7 +8029,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
> >  static inline bool
> >  group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
> >  {
> > -     if (sgs->sum_h_nr_running <= sgs->group_weight)
> > +     if (sgs->sum_nr_running <= sgs->group_weight)
> >               return false;
> >
> >       if ((sgs->group_capacity * 100) <
> > @@ -8132,6 +8133,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >               sgs->sum_h_nr_running += rq->cfs.h_nr_running;
> >
> >               nr_running = rq->nr_running;
> > +             sgs->sum_nr_running += nr_running;
> > +
> >               if (nr_running > 1)
> >                       *sg_status |= SG_OVERLOAD;
> >
> > @@ -8480,7 +8483,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >                        * groups.
> >                        */
> >                       env->balance_type = migrate_task;
> > -                     env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
> > +                     env->imbalance = (busiest->sum_nr_running - local->sum_nr_running) >> 1;
>
> Can we detach RR tasks?
>
> >                       return;
> >               }
> >
> > @@ -8643,7 +8646,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >
> >       /* Try to move all excess tasks to child's sibling domain */
> >       if (sds.prefer_sibling && local->group_type == group_has_spare &&
> > -         busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
> > +         busiest->sum_nr_running > local->sum_nr_running + 1)
> >               goto force_balance;
> >
> >       if (busiest->group_type != group_overloaded &&
> > --
> > 2.7.4
>
