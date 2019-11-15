Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC0DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DF920674
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aflnOer8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfKOSBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:01:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34008 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:00:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id y186so8684429lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aCfBkv+M9nZOLz7fNm+Z8ObZJ0f7JVb8LBMFaA2maU=;
        b=aflnOer8LGcy4oWcFhsooSlWizrSOXBTFwCRCZr8HnA6SpVJpVT7maF179wOKP/EVL
         qOe1CeRKHdvnPf7h63yGQDHWNv0tTzWGBUc4ZWkArPMSYt6CIiqNW2fOrX57xozBdTpF
         GfV7C+C+fqGd79tY8MT3o7VQGPpfTULKI50edj+b5zJbcbPVgL317Sv1cbYj0zbCNNMN
         yqGNngMUCRklNMmJiA7sF0LYzOHXM68Z3wC4CAqq6Zq/HS8PGMp1oAHu00yYxqQ5lAnl
         S77ouO4LRAPZQrPAoxfW4YzVfhhVqDrufwR2gLdY9YXSxEsGjHi8TbE3MDXOQ0wKKmBU
         xfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aCfBkv+M9nZOLz7fNm+Z8ObZJ0f7JVb8LBMFaA2maU=;
        b=HUjTX8FXxmhePonOeG5Hn1ayNHZvicVIOjD7XhHuGpTIBXuNE2M3v3D7G9TyXn2qD7
         N39fMrtiVqSFK3pAOPStACW9GgUJnE5y33S2DNMgyILs50s9pmQmMNj9s7m/AnTcGBKu
         HPjF/mIyVWX89Zc9NwM30lEJus41jfp+j78O4QxXf9llcOKJfrGHCamw9IEhroWb2WNl
         fqBSoxDAzf5k8nKL+B4/OlMd/O2SR8kMt9VpXbJouCe08w3aG/GoDr+uFnY3yZMkUyZb
         +ows7pjK1joKFKU6GaGITaDUECqHrgwLD4RZpW91F8WDeVkb1Edn3zI6OZ3pBeH4yrqs
         H0kA==
X-Gm-Message-State: APjAAAV5/t/2s0WcVkC7eunmOwOppZVnU7sNunrIuS/eT46ma9gKBRgH
        uCCPCy+rpd82zH791Zr7a4dzf9gcm4PQDmxPJnC0gQ==
X-Google-Smtp-Source: APXvYqydaWJF/8/gFjWzkC8fRStPI7Uy/iax/4lLJPtlwMnpp1R9UvWn5+/BAwJKRcOt+DJ2eA5P7z6LE00uSs0nWcc=
X-Received: by 2002:ac2:5685:: with SMTP id 5mr445503lfr.32.1573840856977;
 Fri, 15 Nov 2019 10:00:56 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115132520.GJ4131@hirez.programming.kicks-ass.net> <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
 <20191115151220.GO4131@hirez.programming.kicks-ass.net> <CAKfTPtCg-zEysYmGSFTa4bjh0D=sf1UsT0WpeWcVrb9SLt+VZw@mail.gmail.com>
 <20191115174355.GP4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115174355.GP4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 19:00:45 +0100
Message-ID: <CAKfTPtAKz5zGwyNUtEeM+2JJNBNVnoKmFkXdFu1hjWD52_BwFg@mail.gmail.com>
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

On Fri, 15 Nov 2019 at 18:44, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 04:31:35PM +0100, Vincent Guittot wrote:
>
> > > @@ -7476,10 +7477,14 @@ static void update_blocked_averages(int cpu)
> > >          * list_add_leaf_cfs_rq() for details.
> > >          */
> > >         for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
> > > +               bool last = cfs_rq == &rq->cfs;
> > >                 struct sched_entity *se;
> > >
> > > -               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> > > +               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
> > >                         update_tg_load_avg(cfs_rq, 0);
> > > +                       if (last)
> >
> > using this last make code more readable
> >
> > > +                               decayed = true;
> > > +               }
> > >
> > >                 /* Propagate pending load changes to the parent, if any: */
> > >                 se = cfs_rq->tg->se[cpu];
> > > @@ -7490,7 +7495,7 @@ static void update_blocked_averages(int cpu)
> > >                  * There can be a lot of idle CPU cgroups.  Don't let fully
> > >                  * decayed cfs_rqs linger on the list.
> > >                  */
> > > -               if (cfs_rq_is_decayed(cfs_rq))
> > > +               if (!last && cfs_rq_is_decayed(cfs_rq))
> > >                         list_del_leaf_cfs_rq(cfs_rq);
> >
> > Keeping root cfs in the list will not change anything now that
> > cfs_rq_util_change is in update_load_avg()
> > cfs_rq_util_change will not be called
>
> Oh but it does, since it will then keep triggering that hunk above on
> every period.

indeed

>
> > >
> > >                 /* Don't need periodic decay once load/util_avg are null */
> > > @@ -7498,6 +7503,9 @@ static void update_blocked_averages(int cpu)
> > >                         done = false;
> > >         }
> > >
> > > +       if (decayed || done)
> >
> > I'm not sure to get why you want to call cpufreq when done is true
> > which means that everything reaches 0
> > Why do you prefer to use done instead of ORing the decay of  rt, dl,
> > irq and cfs ?
> >
> > > +               cpufreq_update_util(rq, 0);
>
> Because we don't care about the rt,dl,irq decay anywhere else either. We
> only call cpufreq_update_util() for rq->cfs changes.

cpufreq_update_util is called for each enqueue/dequeue of rt/dl tasks

>
> Also, as I argued, realistically rt,dl and cfs decay on the same edge,
> so aside from some fuzz on the first period, they're all the same. But

But the 1st period can be the only one for the next 4sec

> even if they were not, why would we care about their exact edges here
> when we do no anywhere else.
>
> Not caring reduces the number of cpufreq_update_util() calls to one per
> period, instead of potentially many more.
>
> Doing the || done ensures never miss the all 0 case.

How can we miss it  according to your explanation above ?
