Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A358DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716812086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6lw/6Vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfF1Nvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:51:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38330 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfF1Nvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:51:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so6075675ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1h1/xipv3BOe7ox5t14uQvL2uoJ0RC2iAUPP1KdAz8=;
        b=L6lw/6VyDYVWKwP024cpXNGFoM09948dEewrC4H0j+MsEn7WyBbak8cNouPTYGJXtu
         0Lha1zJ9POxVPHt/VZv3EwucQN6jW3OTRvya4CKLyxXHBIVObJ4t7yKdoinzARbJsnkq
         xCeFiUMIj2wwFjBOjlfdR+D/fDsH5DF7mvItjCuBEd9GA2arAcmNDEBkKf4O95nutV8u
         o2JExRGWNKuCFR7PqvG/hcmFJ1mS+0Ya1SAXCUB1pEEZGXcVYDh6EcjDlXFSno0DzDkR
         YqcWeVSGYks9Z5f/pnE8fa8s4+okQ5k2WnSTM64AYDfcZmkdV2ehRDmFIrTGHMTq/YHt
         cdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1h1/xipv3BOe7ox5t14uQvL2uoJ0RC2iAUPP1KdAz8=;
        b=KnT/MNJlauZgi8/Vo3zWKuelTsM9MLwHjTFrsRPBP2U+/vfTBLZyCujlQi7ugCHQkv
         G9NlBXw/hgR+E5yk7WO+Frfi8KIDWUnjLtPdBXfcRCXI/muOysntg2pvOiljZ1ruFpBi
         zr4MPw0BoD7QyPe5giBL9kwPAT0VgC2viJ80kXCzvcxj3VobVU0susrx+wH2STrARLg9
         dXLHQ2EtSBXoicYCrCICdjFtxny/cDX/2diTPdDEtiwP0vLQejl9iCcYX6yhxomMpoiX
         TH/YsRIqTHVolcT6rq2Idjg9Rgi0MzVFScFkbic6wCHuqzYnCW6J+SEjXaIGKn6yyfaj
         Khaw==
X-Gm-Message-State: APjAAAVIeq5hwDZ3O0DYU3PyqggetZG+B1vKxP6jllFQ07U/AIwieYw1
        pflVdsb4MZace0JKwWDfjdbOI5PBuj4Nfjud4mEZag==
X-Google-Smtp-Source: APXvYqztkTpKyjQBz+NH7vdI48Y76KfZI7JsvnYVsBxhSkeXvDkX0Xu9PM1xe3FZ4tS7Hxewm83lJicBxkEKw6Dllyw=
X-Received: by 2002:a2e:5b5b:: with SMTP id p88mr6052004ljb.192.1561729907815;
 Fri, 28 Jun 2019 06:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin> <20190628123800.GS3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190628123800.GS3419@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Jun 2019 15:51:36 +0200
Message-ID: <CAKfTPtCyC5R40xjzQjp8qJchay9WzucuE4E-CduR46tNBh0uRg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization increases
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 at 14:38, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 28, 2019 at 11:08:14AM +0100, Patrick Bellasi wrote:
> > On 26-Jun 13:40, Vincent Guittot wrote:
> > > Hi Patrick,
> > >
> > > On Thu, 20 Jun 2019 at 17:06, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > >
> > > > The estimated utilization for a task is currently defined based on:
> > > >  - enqueued: the utilization value at the end of the last activation
> > > >  - ewma:     an exponential moving average which samples are the enqueued values
> > > >
> > > > According to this definition, when a task suddenly change it's bandwidth
> > > > requirements from small to big, the EWMA will need to collect multiple
> > > > samples before converging up to track the new big utilization.
> > > >
> > > > Moreover, after the PELT scale invariance update [1], in the above scenario we
> > > > can see that the utilization of the task has a significant drop from the first
> > > > big activation to the following one. That's implied by the new "time-scaling"
> > >
> > > Could you give us more details about this? I'm not sure to understand
> > > what changes between the 1st big activation and the following one ?
> >
> > We are after a solution for the problem Douglas Raillard discussed at
> > OSPM, specifically the "Task util drop after 1st idle" highlighted in
> > slide 6 of his presentation:
> >
> >   http://retis.sssup.it/ospm-summit/Downloads/02_05-Douglas_Raillard-How_can_we_make_schedutil_even_more_effective.pdf
> >
>
> So I see the problem, and I don't hate the patch, but I'm still
> struggling to understand how exactly it related to the time-scaling
> stuff. Afaict the fundamental problem here is layering two averages. The

AFAICT, it's not related to the time-scaling

In fact the big 1st activation happens because task runs at low OPP
and hasn't enough time to finish its running phase before the time to
begin the next one happens. This means that the task will run several
computations phase in one go which is no more a 75% task. From a pelt
PoV, the task is far larger than a 75% task and its utilization too
because it runs far longer (even after scaling time with frequency).
Once cpu reaches a high enough OPP that enable to have sleep phase
between each running phases, the task load tracking comes back to the
normal slope increase (the one that would have happen if task would
have jump from 5% to 75% but already running at max OPP)

> second (EWMA in our case) will always lag/delay the input of the first
> (PELT).
>
> The time-scaling thing might make matters worse, because that helps PELT
> ramp up faster, but that is not the primary issue.
>
> Or am I missing something?
