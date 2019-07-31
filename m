Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20775C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1EB206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTrpmWoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfGaPhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:37:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42286 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfGaPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:37:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id s19so47769709lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcaec4FSZ2/4FwADe+AuXu/tmxAr982s4JHK2wh9Ss8=;
        b=hTrpmWoca1O4WBgsCZUmqTAgtQLHbQVWn17pUPyeeBfgdz+ZKwCanYZjW+7twWHmZ9
         8D5pORvEtWgi0znqdbDzLtAp3mPca7cUHSSDtBXFpFQYlUgVhaHhP6uUg3xS1SmyHb+H
         PXB42xmANW4ZPDKlNyk9T43JDCprxH2tTkpcLSBuQnFOWqOXnKBbmmv6F7ke24e+8mnF
         Lj34uIbh/iiVYpmF27gaiso5eV4G7WlfYFJqYmE0O3g+xkHbzks6wmc04GPSIubzg84E
         uVciazaN+R2GD7XPs+H09hubgLSnUcef29/xh6ysWy93HEAsL5igLrTLK2dZoB9bkXKh
         q+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcaec4FSZ2/4FwADe+AuXu/tmxAr982s4JHK2wh9Ss8=;
        b=mIRpkwDVSvr9IXuw7umY9w9leZuIEXILjY6FKO/45DgExKukv+29is5DPoBJVAwLb7
         Jpk0Y9brqRJT0RWoCgyFyGK7LZC/sdV2Qxw6Pfsk8lWxWysbDMbgSbXHjkkLQRx2lqU6
         Yhb7oxzCGBB/lk1RigpCtxF6KCNIs60IZRIiA6Bmoo/2GlBx+2/4D5oXTkutRHuZIiss
         OGuAs6qCNS9ZV2PNrYGj/TCU/tBxFGTd1O1sZrf+5s3q3sazh0GtlW9kVWh2uf84TUBs
         HJwVSlaQmuDLgZ8Y0PCr5DnUCCBmSV1tpw8ywrGPpNA1WsQG8X/IVoD3DObNVTYP1tpl
         gEfg==
X-Gm-Message-State: APjAAAUEqGJoX5Ioxfnbu1k5ZpYlX9YecSFjMhtrNXjakCKVpVwj1Dfq
        s86FKF3fPwPfIcpft1dCeAfDvMq7R4gwYIqxg6Of8g==
X-Google-Smtp-Source: APXvYqys32vEVCXsjJueGzDTmmcODSv0+Y3K3O3J8aDbig9wwURLHCzUvKT12bR3qDmO9lhQ6LR8bvws1hUDv8oOeCI=
X-Received: by 2002:ac2:4a78:: with SMTP id q24mr15216045lfp.59.1564587468829;
 Wed, 31 Jul 2019 08:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
 <20190726135852.GB7168@linux.vnet.ibm.com> <CAKfTPtA7UKL4NJHkMTx=MgohbXqO6kJCwamEjBX-zu3nNO1XLA@mail.gmail.com>
 <20190731134355.GC11365@linux.vnet.ibm.com>
In-Reply-To: <20190731134355.GC11365@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 31 Jul 2019 17:37:37 +0200
Message-ID: <CAKfTPtBp+mk6+O3qczwmJ=0Xs71t0jaORqOxj8kgH-CKGZxFUg@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 at 15:44, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2019-07-26 16:42:53]:
>
> > On Fri, 26 Jul 2019 at 15:59, Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > > > @@ -7361,19 +7357,46 @@ static int detach_tasks(struct lb_env *env)
> > > >               if (!can_migrate_task(p, env))
> > > >                       goto next;
> > > >
> > > > -             load = task_h_load(p);
> > > > +             if (env->src_grp_type == migrate_load) {
> > > > +                     unsigned long load = task_h_load(p);
> > > >
> > > > -             if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> > > > -                     goto next;
> > > > +                     if (sched_feat(LB_MIN) &&
> > > > +                         load < 16 && !env->sd->nr_balance_failed)
> > > > +                             goto next;
> > > > +
> > > > +                     if ((load / 2) > env->imbalance)
> > > > +                             goto next;
> > >
> > > I know this existed before too but if the load is exactly or around 2x of
> > > env->imbalance, the resultant imbalance after the load balance operation
> > > would still be around env->imbalance. We may lose some cache affinity too.
> > >
> > > Can we do something like.
> > >                 if (2 * load > 3 * env->imbalance)
> > >                         goto next;
> >
> > TBH, I don't know what should be the best value and it's probably
> > worth doing some investigation but i would prefer to do that as a
> > separate patch to get a similar behavior in the overloaded case
> > Why do you propose 3/2 instead of 2 ?
> >
>
> If the imbalance is exactly or around load/2, then we still select the task to migrate
> However after the migrate the imbalance will still be load/2.
> - Can this lead to ping/pong?

In some case you're probably right but this might also help to move
other tasks when  3/2 will not.

1st example with 3 tasks with almost same load on 2 cpus, we will
probably end up migrating the waiting task with a load  / 2 ~<
env->imbalance whereas 2 * load > 3 * env->imbalance will not move any
task.
Note that we don't ensure fairness between the 3 tasks in the latter
case. TBH I don't know what is better

2nd example with 2 tasks TA and TB  with a load around L and 4 tasks
T0 T1 T2 T3 with a load around L/4
TA and TB are on CPU0 and T0 to T3 are on CPU1, we have the same
imbalance as previous example 2L on CPU0 and L on CPU1.
With load / 2 > env->imbalance, we will migrate TA or TB to CPU1 and
then, we might end up migrating 2 tasks among T0 to T3 and the system
will be balanced
With 2 * load > 3 * env->imbalance, we will not migrate TA or TB
because task load is higher the the imbalance which is L/2 and the
scheduler will never get a chance to balance the system whereas it
could have reached a balanced state

Just to say that I'm not sure that there one best ratio to use

> - Did we lose out of cache though we didn't gain from an imbalance.
>
> > > >
> > > >
> > > > -     if (sgs->sum_h_nr_running)
> > > > -             sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
> > > > +     sgs->group_capacity = group->sgc->capacity;
> > > >
> > > >       sgs->group_weight = group->group_weight;
> > > >
> > > > -     sgs->group_no_capacity = group_is_overloaded(env, sgs);
> > > > -     sgs->group_type = group_classify(group, sgs);
> > > > +     sgs->group_type = group_classify(env, group, sgs);
> > > > +
> > > > +     /* Computing avg_load makes sense only when group is overloaded */
> > > > +     if (sgs->group_type != group_overloaded)
> > > > +             sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
> > > > +                             sgs->group_capacity;
> > >
> > > Mismatch in comment and code?
> >
> > I may need to add more comments but at this step, the group should be
> > either overloaded or fully busy but it can also be imbalanced.
> > In case of a group fully busy or imbalanced (sgs->group_type !=
> > group_overloaded), we haven't computed avg_load yet so we have to do
> > so because:
> > -In the case of fully_busy, we are going to be overloaded which the
> > next step after fully busy when you are about to pull more load
> > -In case of imbalance, we don't know the real state of the local group
> > so we fall back to this default behavior
> >
>
> We seem to be checking for avg_load when the group_type is group_overloaded.
> But somehow I am don't see where sgs->avg_load is calculated for
> group_overloaded case.

My fault, I read to quickly your comment and thought that you were
referring to calculte_imbalance() but your comment is about
update_sg_lb_stats().
As Peter mentioned previously this should be
  if (sgs->group_type == group_overloaded)
instead of
  if (sgs->group_type != group_overloaded)

>
> > >
> > > We calculated avg_load for !group_overloaded case, but seem to be using for
> > > group_overloaded cases too.
> >
> > for group_overloaded case, we already computed it in update_sg_lb_stats()
> >
>
>
> From update_sg_lb_stats()
>
>         if (sgs->group_type != group_overloaded)
>                 sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
>                                 sgs->group_capacity;
>
> So we seem to be skipping calculation of avg_load for group_overloaded. No?

yes.

Thanks
Vincent

>
>
> --
> Thanks and Regards
> Srikar Dronamraju
>
