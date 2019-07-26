Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA7C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430622ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzr5ANtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfGZMax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:30:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46274 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfGZMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:30:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so51413517ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfC7r7egqcmLcAk6n3iKm6f8Xh8JcrIrSANHZHpk8GU=;
        b=jzr5ANtEX2qUkj+XoVxuzWC7nTcZQ2akMOW1/iojf3IzwV7iq08AApnuGDii78u3Bf
         KOVAyTGMPRrlTfbrHkKdNuJ5rmDxnmopYtvG55UgLWvWQyGUbQOe36yikDiA1fng4TLT
         RwKa3ntKwoyuT/M6n74tZv7uCDRneKJKSzO5ARbddP+Nq33Zkl18ZfNTcJvGijP/kltw
         1s4D96qP0pn5tmP8YkkFjBSGaYAGQ1gZhjsUE6I2Yk6PHGk9NzWJLh0SdTx69miq96cR
         vvNIyZDRGK68k6eL2kNO+ziOvN9J6uoEdcHj6UsvAiNHIO7Z7Fx/shx8ig9tC8B2oGOj
         5w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfC7r7egqcmLcAk6n3iKm6f8Xh8JcrIrSANHZHpk8GU=;
        b=gTmHNJx4Ae5/hp6pFCoL8KT1tLm+f0wAfxUXXGSdsVv3I4moCeCOqN7sAMP4Ox+Too
         mGi3L1cwMuFSByfHVD7BAOC/HtdgHWs+VH7/7tJO3z+RTU/DzlZFHJ0NuHgm5z6PD+7n
         nBwLyZJq9Kq4p+7kKCWifTN3InDToItQAkJr09qmKVGx5AeJxsbQktw58NrLdA1bIBqv
         kpBdzGgsqcWBps+QMU7ehIsGJwMh5nBGkgc4T/fXoEdAxzKE+/cBur4KrO2jOlRSZpht
         VC+IHe71TNbiRKYtrcYo13G/w6FUJ4FfLXY0qnRfeAjOSxVA/GK7d/9rTGL7936up+yz
         MG0A==
X-Gm-Message-State: APjAAAWxGSRAdyhOcKWgnnyVYlIQRIJ7/67VPZzghgycUc/pIrkZYNcA
        jjUWdetEYg2lBZ3vfeTDVzCxlhRpQbiQSwFYf1fSdw==
X-Google-Smtp-Source: APXvYqz7Cse1iNsXScfPL1zspiFm/K167O828IaNBm2qORn0Uh//1I2ydbJpAU2fZtfULvsyLm7wRirv89IIynmAXdc=
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr9965050ljj.24.1564144248054;
 Fri, 26 Jul 2019 05:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
 <d55f906e-6e91-9f49-5c2c-7ec2e6bd68b0@arm.com> <CAKfTPtD2hDxnHSaa5C_Jrtabb_ogJSgkLE=5UPyystKZqUmzWA@mail.gmail.com>
 <4d3a67f5-c9c4-6397-7405-6f0efbd49d5c@arm.com>
In-Reply-To: <4d3a67f5-c9c4-6397-7405-6f0efbd49d5c@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 26 Jul 2019 14:30:37 +0200
Message-ID: <CAKfTPtBE5fzycHk33rf7Bky-tYSeCXaKd9oGR5cgaghzbL2TvA@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Valentin Schneider <valentin.schneider@arm.com>
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

On Fri, 26 Jul 2019 at 12:41, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 26/07/2019 10:01, Vincent Guittot wrote:
> >> Huh, interesting. Why go for utilization?
> >
> > Mainly because that's what is used to detect a misfit task and not the load
> >
> >>
> >> Right now we store the load of the task and use it to pick the "biggest"
> >> misfit (in terms of load) when there are more than one misfit tasks to
> >> choose:
> >
> > But having a big load doesn't mean that you have a big utilization
> >
> > so you can trig the misfit case because of task A with a big
> > utilization that doesn't fit to its local cpu. But then select a task
> > B in detach_tasks that has a small utilization but a big weight and as
> > a result a higher load
> > And task B will never trig the misfit UC by itself and should not
> > steal the pulling opportunity of task A
> >
>
> We can avoid this entirely by going straight for an active balance when
> we are balancing misfit tasks (which we really should be doing TBH).

but your misfit task might not be the running one anymore when
load_balance effectively happens

>
> If we *really* want to be surgical about misfit migration, we could track
> the task itself via a pointer to its task_struct, but IIRC Morten

I thought about this but task can have already die at that time and
the pointer is no more relevant.
Or we should parse the list of task still attached to the cpu and
compare them with the saved pointer but then it's not scalable and
will consume a lot of time

> purposely avoided this due to all the fun synchronization issues that
> come with it.
>
> With that out of the way, I still believe we should maximize the migrated
> load when dealing with several misfit tasks - there's not much else you can
> look at anyway to make a decision.

But you can easily select a task that is not misfit so what is the best/worst ?
select a fully wrong task or at least one of the real misfit tasks

I'm fine to go back and use load instead of util but it's not robust IMO.

>
> It sort of makes sense when e.g. you have two misfit tasks stuck on LITTLE
> CPUs and you finally have a big CPU being freed, it would seem fair to pick
> the one that's been "throttled" the longest - at equal niceness, that would
> be the one with the highest load.
>
> >>
> >> update_sd_pick_busiest():
> >> ,----
> >> | /*
> >> |  * If we have more than one misfit sg go with the biggest misfit.
> >> |  */
> >> | if (sgs->group_type == group_misfit_task &&
> >> |     sgs->group_misfit_task_load < busiest->group_misfit_task_load)
> >> |       return false;
> >> `----
> >>
> >> I don't think it makes much sense to maximize utilization for misfit tasks:
> >> they're over the capacity margin, which exactly means "I can't really tell
> >> you much on that utilization other than it doesn't fit".
> >>
> >> At the very least, this rq field should be renamed "misfit_task_util".
> >
> > yes. I agree that i should rename the field
> >
> >>
> >> [...]
> >>
> >>> @@ -7060,12 +7048,21 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
> >>>  enum fbq_type { regular, remote, all };
> >>>
> >>>  enum group_type {
> >>> -     group_other = 0,
> >>> +     group_has_spare = 0,
> >>> +     group_fully_busy,
> >>>       group_misfit_task,
> >>> +     group_asym_capacity,
> >>>       group_imbalanced,
> >>>       group_overloaded,
> >>>  };
> >>>
> >>> +enum group_migration {
> >>> +     migrate_task = 0,
> >>> +     migrate_util,
> >>> +     migrate_load,
> >>> +     migrate_misfit,
> >>
> >> Can't we have only 3 imbalance types (task, util, load), and make misfit
> >> fall in that first one? Arguably it is a special kind of task balance,
> >> since it would go straight for the active balance, but it would fit a
> >> `migrate_task` imbalance with a "go straight for active balance" flag
> >> somewhere.
> >
> > migrate_misfit uses its own special condition to detect the task that
> > can be pulled compared to the other ones
> >
>
> Since misfit is about migrating running tasks, a `migrate_task` imbalance
> with a flag that goes straight to active balancing should work, no?

see my previous comment

>
> [...]
> >> Rather than filling the local group, shouldn't we follow the same strategy
> >> as for load, IOW try to reach an average without pushing local above nor
> >> busiest below ?
> >
> > But we don't know if this will be enough to make the busiest group not
> > overloaded anymore
> >
> > This is a transient state:
> > a group is overloaded, another one has spare capacity
> > How to balance the system will depend of how much overload if in the
> > group and we don't know this value.
> > The only solution is to:
> > - try to pull as much task as possible to fill the spare capacity
> > - Is the group still overloaded ? use avg_load to balance the system
> > because both group will be overloaded
> > - Is the group no more overloaded ? balance the number of idle cpus
> >
> >>
> >> We could build an sds->avg_util similar to sds->avg_load.
> >
> > When there is spare capacity, we balances the number of idle cpus
> >
>
> What if there is spare capacity but no idle CPUs? In scenarios like this
> we should balance utilization. We could wait for a newidle balance to

why should we balance anything ? all tasks have already enough running time.
It's better to wait for a cpu to become idle instead of trying to
predict which one will be idle first and migrate task uselessly
because other tasks can easily wakeup in the meantime

> happen, but it'd be a shame to repeatedly do this when we could
> preemptively balance utilization.
>
