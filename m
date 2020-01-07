Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93223C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF182187F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4kmK3et"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgAGIil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:38:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42644 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgAGIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:38:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so39462410ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 00:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iaYcRM2Wb4iUR8clkvAqehaUip7geonOtWQG3p7+rA=;
        b=B4kmK3etlJfYDiFmBaA1ZdTm8COdJVROaM9gx9bmzrfQNMO5WaWZD+sPHHqth9GW+p
         YusBBDW99Jm4WncPCf88EOb6KCqmIRQhZ4kYkGgFB1oLKWO+P0u8/ItnRiDl7ZNBlAbx
         hYnk4emiCNsF1sE8T5q8UrDf85yoN3UsSwye4swCXYExA8uh979mqlPFoBUK+dOUNAe7
         BzaBhskBU2pLy6Yl+1IjcyR/D3Qq7enRHFodPAtVC6TeQEtjaF1Ki6Z402gaXHMC5KB+
         R9pN7q3VTMcZaYuTjq1iog82Eltlc8qqEI79R0kszEsmOyxEuq11dytsp1sl0SUYTdc6
         h2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iaYcRM2Wb4iUR8clkvAqehaUip7geonOtWQG3p7+rA=;
        b=XKtmfeNOqKJKEzj3y69o/wu8F38HkiTqwgoqbX5oehGmKkuxEXYUPsN5/BIJRE0ZLU
         tgEVXz35LNCXXOPs5LqoaTTTGkr2bc4Sg1LJDz2F3wiqLvlEAk6K4kvT+PknhNu0UsEo
         QnQ4XaSr89oL9Vpnz+WsG99lrNkXgSmlRlX2oybbginhCGYYdjx3Y4G6s1S6KkSqfrtX
         aPmQmszkYVqBIKVboOib3aPcTFIHvA1xmwaVQJq4/YaJELyfd+EL3IrpprKpNMJgLYYM
         k/W/iuLeGsODnotq2ebThukJBGMAXY1uRr36q5R2zlZQoCjlwssr3fonChPoT8X1WvSP
         3iuw==
X-Gm-Message-State: APjAAAXkRc3RQhojOnlTA499NZ+MhWE9t18p5r5jNd0DgTUBrioQeFHF
        PR2jFckzyJ0kSl+x6wNtpNNXwyKtUJ85kqBAkou+tJdxs455rw==
X-Google-Smtp-Source: APXvYqzFnHXLSQO60fJsMW2onxvxz9I+vPj5Kxzr+DUJHwXJlBvGEiiLY87HQfxdCar/btQmTZDkrYF7+to4EmxOEJE=
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr55392718ljj.225.1578386318077;
 Tue, 07 Jan 2020 00:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20191220084252.GL3178@techsingularity.net> <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net> <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
In-Reply-To: <20200106145225.GB3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jan 2020 09:38:26 +0100
Message-ID: <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020 at 15:52, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Sorry I sent out v3 before seeing this email as my mail only synchronises
> periodically.
>
> On Mon, Jan 06, 2020 at 02:55:00PM +0100, Vincent Guittot wrote:
> > > -                       return;
> > > -               }
> > > +               } else {
> > >
> > > -               /*
> > > -                * If there is no overload, we just want to even the number of
> > > -                * idle cpus.
> > > -                */
> > > -               env->migration_type = migrate_task;
> > > -               env->imbalance = max_t(long, 0, (local->idle_cpus -
> > > +                       /*
> > > +                        * If there is no overload, we just want to even the number of
> > > +                        * idle cpus.
> > > +                        */
> > > +                       env->migration_type = migrate_task;
> > > +                       env->imbalance = max_t(long, 0, (local->idle_cpus -
> > >                                                  busiest->idle_cpus) >> 1);
> > > +               }
> > > +
> > > +               /* Consider allowing a small imbalance between NUMA groups */
> > > +               if (env->sd->flags & SD_NUMA) {
> > > +                       long imbalance_adj, imbalance_max;
> > > +
> > > +                       /*
> > > +                        * imbalance_adj is the allowable degree of imbalance
> > > +                        * to exist between two NUMA domains. imbalance_pct
> > > +                        * is used to estimate the number of active tasks
> > > +                        * needed before memory bandwidth may be as important
> > > +                        * as memory locality.
> > > +                        */
> > > +                       imbalance_adj = (100 / (env->sd->imbalance_pct - 100)) - 1;
> >
> > This looks weird to me because you use imbalance_pct, which is
> > meaningful only compare a ratio, to define a number that will be then
> > compared to a number of tasks without taking into account the weight
> > of the node. So whatever the node size, 32 or 128 CPUs, the
> > imbalance_adj will be the same: 3 with the default imbalance_pct of
> > NUMA level which is 125 AFAICT
> >
>
> The intent in this version was to only cover the low utilisation case
> regardless of the NUMA node size. There were too many corner cases
> where the tradeoff of local memory latency versus local memory bandwidth
> cannot be quantified. See Srikar's report as an example but it's a general
> problem. The use of imbalance_pct was simply to find the smallest number of
> running tasks were (imbalance_pct - 100) would be 1 running task and limit

But using imbalance_pct alone doesn't mean anything. Using similar to the below

    busiest->group_weight * (env->sd->imbalance_pct - 100) / 100

would be more meaningful

Or you could use the util_avg so you will take into account if the
tasks are short running ones or long running ones

> the patch to address the low utilisation case only. It could be simply
> hard-coded but that would ignore cases where an architecture overrides
> imbalance_pct. I'm open to suggestion on how we could identify the point
> where imbalances can be ignored without hitting other corner cases.
>
> > > +
> > > +                       /*
> > > +                        * Allow small imbalances when the busiest group has
> > > +                        * low utilisation.
> > > +                        */
> > > +                       imbalance_max = imbalance_adj << 1;
> >
> > Why do you add this shift ?
> >
>
> For very low utilisation, there is no balancing between nodes. For slightly
> above that, there is limited balancing. After that, the load balancing
> behaviour is unchanged as I believe we cannot determine if memory latency
> or memory bandwidth is more important for arbitrary workloads.
>
> --
> Mel Gorman
> SUSE Labs
