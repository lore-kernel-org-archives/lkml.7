Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD96C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E1D2073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uF58PRRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLBPgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:36:55 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33685 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLBPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:36:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so158469lfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFCuIWDe0r9z0ofPkFsx4bqSW8G0i7zhf1JqfD79wcc=;
        b=uF58PRRP7rxMmTYQAMZdqiBXiZybfhfExTcFzJUdlL7Qd9+vknGxCJA5hn9Wc/Y/Qp
         VzLJO5QoUjwtrFWxbIl7n6uGO+VaDBNLSHrHvVdHpsrKjelERqtN/RbiZg9+PxVfPmAw
         v62mSVW1dDm0VEXft4+hUx/UgKkygByIpvrFooKcCr3L25vgqrlQqTzV3HQwhEd3y3nc
         1mAs70EP1+jY3CPEgBGr59SM/q84jiM2w9Om2lnCumpn+eAUfqQwUKdXfGsOPtKxB3uY
         V4jkwFHMxLw29p9Umupqa5dJCRqNY6RSJzCA/lMzEd3dKr/GpmX5h3e4llx61VtGXF86
         +kBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFCuIWDe0r9z0ofPkFsx4bqSW8G0i7zhf1JqfD79wcc=;
        b=mdroIiRXsWUv3juAMtqKxoW5SN8/ksirpDNz5qZyDPtrgMaxw63MBMstkdxo1EUBxT
         q8EEbTCbnoFrht0RwP6LnNPaJQ0WBQDc9rY7Vvw2fiMOJIGeo5+Xn6CI77PdJGnFzg19
         5/W9porvP4JoH8sfO31FVONU5H2YuiuO0LuoXuVhrU2AzRE6V3uypCZIwrSNVYzkrj3E
         W40/MF8zCvSy/Pn0NMgfAUpF7RW8Gp65uzjxvzpZNmjHpXrzI2ZlzbYnVg/tJvdZReCJ
         CirSrkMhGGRlyLKz4W9OMPedccQNIqdCPE7X+/H2KDgEq2g473AuOCvSQHHv8mopJ98B
         Bk7w==
X-Gm-Message-State: APjAAAWbB1mE17pwqsJxODj85W4HR1PKClO7ICichp8oa68P+NiewY7k
        Q9mwLVSaTzOet/z6ndPYfEHEXOrfa28cpSExLaG9qg==
X-Google-Smtp-Source: APXvYqxjpo9lN0tubElvQ07MFkjVIu9ZwmINdIgzBNwt5AwOmONgVVXhOdrFPGu6YyxZbigDh3JFs9AKKeNs4TtCP3k=
X-Received: by 2002:ac2:5107:: with SMTP id q7mr11617478lfb.177.1575301011300;
 Mon, 02 Dec 2019 07:36:51 -0800 (PST)
MIME-Version: 1.0
References: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org> <b8cee573-d1a7-bc26-c6d3-4f9e1a4ad330@arm.com>
In-Reply-To: <b8cee573-d1a7-bc26-c6d3-4f9e1a4ad330@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 2 Dec 2019 16:36:39 +0100
Message-ID: <CAKfTPtCVn+Ep4iMNZZi_MKfO9vnXt3G+LKR70LcLnyEAvfhoiw@mail.gmail.com>
Subject: Re: [PATCH] sched/cfs: fix spurious active migration
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 at 16:13, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 29/11/2019 15:04, Vincent Guittot wrote:
> > The load balance can fail to find a suitable task during the periodic check
> > because  the imbalance is smaller than half of the load of the waiting
> > tasks. This results in the increase of the number of failed load balance,
> > which can end up to start an active migration. This active migration is
> > useless because the current running task is not a better choice than the
> > waiting ones. In fact, the current task was probably not running but
> > waiting for the CPU during one of the previous attempts and it had already
> > not been selected.
> >
> > When load balance fails too many times to migrate a task, we should relax
> > the contraint on the maximum load of the tasks that can be migrated
> > similarly to what is done with cache hotness.
> >
> > Before the rework, load balance used to set the imbalance to the average
> > load_per_task in order to mitigate such situation. This increased the
> > likelihood of migrating a task but also of selecting a larger task than
> > needed while more appropriate ones were in the list.
>
> Why not use '&& !env->sd->nr_balance_failed' then? Too aggressive? But

Yeah I have thought and tried !env->sd->nr_balance_failed. In fact, I
have tried both and I haven't seen any visible difference in my tests.
Nevertheless, using !env->sd->nr_balance_failed condition doesn't let
a chance to the current running task with a possibly correct load to
become a waiting task during the next load balance and to be selected
instead of a larger task, which will create another imbalance. Also
cache_nice_tries increase the number of trials to large domain span to
select different rqs before migrating a large task. Then,
env->sd->nr_balance_failed <= env->sd->cache_nice_tries is used in
can_migrate() for preventing migration because of cache_hotness so we
are aligned with this condition. At the opposite,
!env->sd->nr_balance_failed is used with LB_MIN which is disable by
default.

TBH, I don't have a strong opinion between !env->sd->nr_balance_failed
and env->sd->nr_balance_failed <= env->sd->cache_nice_tries.


> the average load_per_task was calculated at each load balance attempt,
> so it would have led to a migration at the first load balance.
>
> This would be in sync with the LB_MIN check in the same switch case
> (migrate_load). Although LB_MIN is false by default.
>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > I haven't seen any noticable performance changes on the benchmarks that I
> > usually run but the problem can be easily highlight with a simple test
> > with 9 always running tasks on 8 cores.
> >
> >  kernel/sched/fair.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e0d662a..d1b4fa7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7433,7 +7433,14 @@ static int detach_tasks(struct lb_env *env)
> >                           load < 16 && !env->sd->nr_balance_failed)
> >                               goto next;
> >
> > -                     if (load/2 > env->imbalance)
> > +                     /*
> > +                      * Make sure that we don't migrate too much load.
> > +                      * Nevertheless, let relax the constraint if
> > +                      * scheduler fails to find a good waiting task to
> > +                      * migrate.
> > +                      */
> > +                     if (load/2 > env->imbalance &&
> > +                         env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
> >                               goto next;
> >
> >                       env->imbalance -= load;
> >
