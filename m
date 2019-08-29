Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD355C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709A1208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDduhXAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfH2O1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:27:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43340 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfH2O1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:27:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id h15so3217449ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMqqQLuyfElFbLLOsaCUr3eYEOpdSEM8uXe2pL2MbaE=;
        b=EDduhXAFG+AQ7D7DtK611pTH41HFef90zeeLyE52JD5tDI0YXwpntclBMhaiA7tdHH
         BZSGHv6RuJqEur1KwbRi7G/F6syfd7jDtuUwzT0RcNY5pLGVN3OoSPtq9Z/J9h1vN5ro
         6LW9WYHr8l/OnkpkRd+vwIwx0dNBA90kx/exRh/1zwA4WmcXeDt+1TPKaib/p3UsObeq
         j+PkykBoi7FCkQ23RL9L8xAIfNuZR6flzuerXbI8n7A4a7S4dvQarP+ul9Bi74N8jGLq
         uq5am90UcOWwG3WjOmp1SIZhuR/drTPIFeP1zI/KdJuqPh1IdxzlIzKU3Us1+KokSx4D
         ua2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMqqQLuyfElFbLLOsaCUr3eYEOpdSEM8uXe2pL2MbaE=;
        b=AH/XecbMfJwvJkdWk/OtlpeyDwSf8AMH9ISCKouQXihCsCc9dg4VBe3j6P/EKDN+Ss
         GnXQBNKs6I62JxsqaJeMMFSA7p1e0mAIJMuQ/ArcW6N2UZpG1a3hex0XkuCCqCzn4iDH
         qYWcKIHXuc2Z3Nsth3iuULVj/rgRtOZWk7lIR3fS0D1Hiugl2nISDoOyIlY4XwUaJAII
         RSxSORcVmvKj22BlCMCDHZ5SkB0PZtaNScLueuQmOGxTykqJHrdt6gGoxZmNB9CoEN5y
         48PvltN/iu5gWpJTskaBMFCAljQzIgn4/hkVuGrUuoDsktnromoilH1Jp7FDMMnEbEEn
         PvTg==
X-Gm-Message-State: APjAAAXE7eZDoFbphQ1BNlAuzSMFfVgCtEVa1h9SAQmbpDu593z2BjWU
        vQloUOnLN89hRcUb/xBTLDHCPqs9bsBf/XvZsaTiuw==
X-Google-Smtp-Source: APXvYqwo5s/6PFvJvwDdSVDFq8Cr/g9F4ADuCcO2pbf/GOj/kI5/8O4teI+r9kG2/JEe9L5khMzU0vwuZLQz5FdkvWg=
X-Received: by 2002:a2e:875a:: with SMTP id q26mr5684502ljj.107.1567088822137;
 Thu, 29 Aug 2019 07:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
 <74bb33d7-3ba4-aabe-c7a2-3865d5759281@arm.com> <CAKfTPtA_=_ukj-8cQL4+5qU7bLHX5v4wuPODcGsX6a+o2HmBDQ@mail.gmail.com>
 <a42542e5-8338-c00c-5d55-d30c0daf1701@arm.com>
In-Reply-To: <a42542e5-8338-c00c-5d55-d30c0daf1701@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Aug 2019 16:26:49 +0200
Message-ID: <CAKfTPtAnHSZ9Lb+JUktA8Z_90V9egzU=M5ErrE=PUGy8qUWLBQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] sched/fair: rework load_balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 at 16:19, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 26/08/2019 11:11, Vincent Guittot wrote:
> >>> +     case group_fully_busy:
> >>> +             /*
> >>> +              * Select the fully busy group with highest avg_load.
> >>> +              * In theory, there is no need to pull task from such
> >>> +              * kind of group because tasks have all compute
> >>> +              * capacity that they need but we can still improve the
> >>> +              * overall throughput by reducing contention when
> >>> +              * accessing shared HW resources.
> >>> +              * XXX for now avg_load is not computed and always 0 so
> >>> +              * we select the 1st one.
> >>> +              */
> >>
> >> What's wrong with unconditionally computing avg_load in update_sg_lb_stats()?
> >
> > removing useless division which can be expensive
> >
>
> Seeing how much stuff we already do in just computing the stats, do we
> really save that much by doing this? I'd expect it to be negligible with
> modern architectures and all of the OoO/voodoo, but maybe I need a
> refresher course.

We are not only running on top/latest architecture

>
> >> We already unconditionally accumulate group_load anyway.
> >
> > accumulation must be done while looping on the group whereas computing
> > avg_load can be done only when needed
> >
> >>
> >> If it's to make way for patch 6/8 (using load instead of runnable load),
> >> then I think you are doing things in the wrong order. IMO in this patch we
> >> should unconditionally compute avg_load (using runnable load), and then
> >> you could tweak it up in a subsequent patch.
> >
> > In fact, it's not link to patch 6/8.
> > It's only that I initially wanted to used load only when overloaded
> > but then I got this case and thought that comparing avg_load could be
> > interesting but without any proof that it's worth.
> > As mentioned in the comment, tasks in this group have enough capacity
> > and there is no need to move task in theory. This is there mainly to
> > trigger the discuss and keep in mind a possible area of improvement in
> > a next step.
> > I haven't run tests or done more study on this particular case to make
> > sure that there would be some benefit to compare avg_load.
> >
> > So in the future, we might end up always computing avg_load and
> > comparing it for selecting busiest fully busy group
> >
>
> Okay, that definitely wants testing then.
>
> [...]
> >>> +     if (busiest->group_type == group_misfit_task) {
> >>> +             /* Set imbalance to allow misfit task to be balanced. */
> >>> +             env->balance_type = migrate_misfit;
> >>> +             env->imbalance = busiest->group_misfit_task_load;
> >>
> >> AFAICT we don't ever use this value, other than setting it to 0 in
> >> detach_tasks(), so what we actually set it to doesn't matter (as long as
> >> it's > 0).
> >
> > not yet.
> > it's only in patch 8/8 that we check if the tasks fits the cpu's
> > capacity during the detach_tasks
> >
>
> But that doesn't use env->imbalance, right? With that v3 patch it's just
> the task util's, so AFAICT my comment still stands.

no, misfit case keeps using load and imbalance like the current
implementation in this patch.
The modifications on the way to handle misfit task are all in patch 8

>
> >>
> >> I'd re-suggest folding migrate_misfit into migrate_task, which is doable if
> >> we re-instore lb_env.src_grp_type (or rather, not delete it in this patch),
> >> though it makes some other places somewhat uglier. The good thing is that
> >> it actually does end up being implemented as a special kind of task
> >> migration, rather than being loosely related.
> >
> > I prefer to keep it separate instead of adding a sub case in migrate_task
> >
>
> My argument here is that ideally they shouldn't be separated, since the misfit
> migration is a subcase of task migration (or an extension of it - in any
> case, they're related). I haven't found a nicer way to express it though,
> and I agree that the special casing in detach_tasks()/fbq()/etc is meh.
>
> [...]
> >>> @@ -8765,7 +8942,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >>>       env.src_rq = busiest;
> >>>
> >>>       ld_moved = 0;
> >>> -     if (busiest->cfs.h_nr_running > 1) {
> >>> +     if (busiest->nr_running > 1) {
> >>
> >> Shouldn't that stay h_nr_running ? We can't do much if those aren't CFS
> >> tasks.
> >
> > There is the case raised by srikar where we have for example 1 RT task
> > and 1 CFS task. cfs.h_nr_running==1 but we don't need active balance
> > because CFS is not the running task
> >
> >>
> >>>               /*
> >>>                * Attempt to move tasks. If find_busiest_group has found
> >>>                * an imbalance but busiest->nr_running <= 1, the group is
> >>>
