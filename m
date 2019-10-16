Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C26FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC3C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvhmFw29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfJPL5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:57:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34248 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJPL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:57:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so23728636lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iidcREMNQbpSj7QIK2mzZsgN87zkGYqiHC5Wx2Lqiak=;
        b=jvhmFw29RQ+Dns+Za4F1tRmgVK0ZuenK8or5kZmFZRyWfQDPB+9f7vW8B+y1mTSNvQ
         TUt4JofxObqVRWPBRSXPkRwDp0JQyi0D73IiQuWuNN5K04zAOtFOgaetQwdP5L4VNLoP
         yWPmfwui3g75hUe9hLuM9r95lSgDVkVOse30aneEq+q+xhmNnACGRHvwAoLZ+xjcz02W
         hfFOTSFMNOXZ3ap/vy8Ni5ObkdDbV+LmWE5uRV0B7v7qIxF/VyW8qY/2fpO8ObzSYQGh
         3hvzgeEXRh34v0VcNa2D2oCuRrrumztwdaggykegm9yp3hDoAw2+DgZbdu8ISU8CXBiP
         uh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iidcREMNQbpSj7QIK2mzZsgN87zkGYqiHC5Wx2Lqiak=;
        b=UOFUOHUFtv8QbSEZO3nsZL9I/2VMG4sAmi9N9rf7FzfwXTqDsz6PbPjyb2DlfAG4m1
         drRqcfq5xT2Ee9H17X4qT3a3KHj5k8wtNqQkM7FM7/p2was7dZCCJN2Z0onLkNdph4gA
         hONTOklMU61xZ67+7uKH3nL6lQj7mxjJN5DgogSeAn+ps98QfUr2YP9vh9aCZgo57u7Q
         W3+Eukm3snRc/DvbIwKRirvVWvwadlLHQBetmXGMcOl66HsFkbcdlk8Vokb0SehYEE9u
         SHwurwkXvTqI4CXdlVhMsLXRbkUgFFgNaEj4aaVf64MbLq691mqh58doQM33isAXBLx3
         npNA==
X-Gm-Message-State: APjAAAVuZtRtbS2pczEqX8Uwkutz3Wfy8smrjBLQxUPpqnVhyJKPGqga
        LN3kdwd2fFabhYnGM5+CAeU7LzmqZXWO9U/hd8gLig==
X-Google-Smtp-Source: APXvYqyb/+1D2Q12S3rc/Nnw1v5q7R17Mxz022QcdTRXckzc4D9WCVzrb76DAT9UWuaTvMsGk3Ge2ukLzvF+zu9Jq84=
X-Received: by 2002:a05:651c:237:: with SMTP id z23mr17973207ljn.214.1571227021131;
 Wed, 16 Oct 2019 04:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org> <17c4e175-d580-a43d-1278-b7a54c697544@linux.ibm.com>
In-Reply-To: <17c4e175-d580-a43d-1278-b7a54c697544@linux.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Oct 2019 13:56:49 +0200
Message-ID: <CAKfTPtB-12oAe5ssxrp4aO35qC9H_EWK=UcuqEDXSucKEWngzA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 at 09:21, Parth Shah <parth@linux.ibm.com> wrote:
>
>
>
> On 9/19/19 1:03 PM, Vincent Guittot wrote:
>
> [...]
>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 585 ++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 380 insertions(+), 205 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 017aad0..d33379c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7078,11 +7078,26 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
> >
> >  enum fbq_type { regular, remote, all };
> >
> > +/*
> > + * group_type describes the group of CPUs at the moment of the load balance.
> > + * The enum is ordered by pulling priority, with the group with lowest priority
> > + * first so the groupe_type can be simply compared when selecting the busiest
> > + * group. see update_sd_pick_busiest().
> > + */
> >  enum group_type {
> > -     group_other = 0,
> > +     group_has_spare = 0,
> > +     group_fully_busy,
> >       group_misfit_task,
> > +     group_asym_packing,
> >       group_imbalanced,
> > -     group_overloaded,
> > +     group_overloaded
> > +};
> > +
> > +enum migration_type {
> > +     migrate_load = 0,
> > +     migrate_util,
> > +     migrate_task,
> > +     migrate_misfit
> >  };
> >
> >  #define LBF_ALL_PINNED       0x01
> > @@ -7115,7 +7130,7 @@ struct lb_env {
> >       unsigned int            loop_max;
> >
> >       enum fbq_type           fbq_type;
> > -     enum group_type         src_grp_type;
> > +     enum migration_type     balance_type;
> >       struct list_head        tasks;
> >  };
> >
> > @@ -7347,7 +7362,7 @@ static int detach_tasks(struct lb_env *env)
> >  {
> >       struct list_head *tasks = &env->src_rq->cfs_tasks;
> >       struct task_struct *p;
> > -     unsigned long load;
> > +     unsigned long util, load;
> >       int detached = 0;
> >
> >       lockdep_assert_held(&env->src_rq->lock);
> > @@ -7380,19 +7395,53 @@ static int detach_tasks(struct lb_env *env)
> >               if (!can_migrate_task(p, env))
> >                       goto next;
> >
> > -             load = task_h_load(p);
> > +             switch (env->balance_type) {
> > +             case migrate_load:
> > +                     load = task_h_load(p);
> >
> > -             if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> > -                     goto next;
> > +                     if (sched_feat(LB_MIN) &&
> > +                         load < 16 && !env->sd->nr_balance_failed)
> > +                             goto next;
> >
> > -             if ((load / 2) > env->imbalance)
> > -                     goto next;
> > +                     if ((load / 2) > env->imbalance)
> > +                             goto next;
> > +
> > +                     env->imbalance -= load;
> > +                     break;
> > +
> > +             case migrate_util:
> > +                     util = task_util_est(p);
> > +
> > +                     if (util > env->imbalance)
>
> Can you please explain what would happen for
> `if (util/2 > env->imbalance)` ?
> just like when migrating load, even util shouldn't be migrated if
> env->imbalance is just near the utilization of the task being moved, isn't it?

I have chosen uti and not util/2 to be conservative because
migrate_util is used to fill spare capacity.
With `if (util/2 > env->imbalance)`, we can more easily overload the
local group or pick too much utilization from the overloaded group.

>
> > +                             goto next;
> > +
> > +                     env->imbalance -= util;
> > +                     break;
> > +[ ... ]
>
> Thanks,
> Parth
>
