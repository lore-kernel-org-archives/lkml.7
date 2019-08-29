Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828B7233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2ZTbIaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfH2OTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:19:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44955 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfH2OTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:19:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id e24so3196139ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2Vk/oUrlvTcz6kv+kYQO6+FuVIgcGNrY+yE7jFD0Dk=;
        b=z2ZTbIaMEjH8E0b9Q27U++nHNYIbYJo0yD+f+vse9czel08g9uyFzSBeKdnO/a0JTy
         wGUDsioqBE11ROV4hHR6x3oJPcrVPp1Ql4F61TZbMuwUolmqKM9frNcilT3MfFZMc+jz
         ubDaacb5wfofBkFq+RwYNa1hDWMKQa9mjxUoaV+CAYE/kGBZ2ieVy2GP8iWsUdQMaqqS
         Yq5EBWUf2xplqQvaKh2NO6uAykQE4WoIaCiH0nLd8DhTicCAMCDXzmYIj4dEWwATeAYw
         hpPXRKQLTFhVeJcRbs3hCZVITC7ro34rKimMmyNKXNMpW8+ZDkjI1zqCqdVYxrbqABIM
         shSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2Vk/oUrlvTcz6kv+kYQO6+FuVIgcGNrY+yE7jFD0Dk=;
        b=HL0kW7RvXgq2ZY0dqDkdX2mesLkbvGwuBDcHf+dQSxXRDR5lAoxUWbD+lk1tjPfBEQ
         ywRHFSv1j0i71UijQSHgeWX0Kt+TrrX+arDd0ijndgg7va4B6d6LbyqppHRDo+QEpNRR
         oKnwtm5U+2jTvKAn1FuvqH3wWmc9yzpSY6TeKoFayXL0Bm4nzpY8QfMQLDMefCDiMy9E
         DTzgTeDDe9lLfE0Y4/m+nS2/+4aIcf850Zo3fV03ctMHZrYl/hBmUFrpdll9X9JksTB1
         M5FdLb/VO05PtFzkjjP7nekppMwv5WaU8EFKqNHTECIc6rlvS97ekTmpOsTPa3D5YO+x
         n73g==
X-Gm-Message-State: APjAAAWl+BMyM4Xp1zCjuCdYqN9cSB5WCbB+GTWIeNMWpPSdmlpoDKSv
        IPYanW6bckG+zkU0u9yTPZb6YVOcZlvwF4IHcJcORA==
X-Google-Smtp-Source: APXvYqyCYzKuHWowS8ncxK7QUGXejSNH4jnAJmlBqz6ON1y28LywqHXLN1DLfKXlrPbal0esIiBkVPoBukwUHE6ARRM=
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr2274568ljj.24.1567088384562;
 Thu, 29 Aug 2019 07:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190815145107.5318-1-valentin.schneider@arm.com>
 <20190815145107.5318-5-valentin.schneider@arm.com> <CAKfTPtCq3fv_ajgwnUUodnd+G_Bx6Jqod3751FnB5AASxZczYg@mail.gmail.com>
 <1ba22164-bcae-3bec-a002-acca4e7c8eae@arm.com>
In-Reply-To: <1ba22164-bcae-3bec-a002-acca4e7c8eae@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Aug 2019 16:19:33 +0200
Message-ID: <CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] sched/fair: Prevent active LB from preempting
 higher sched classes
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 at 11:46, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 27/08/2019 13:28, Vincent Guittot wrote:
> > On Thu, 15 Aug 2019 at 16:52, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> The CFS load balancer can cause the cpu_stopper to run a function to
> >> try and steal a remote rq's running task. However, it so happens
> >> that while only CFS tasks will ever be migrated by that function, we
> >> can end up preempting higher sched class tasks, since it is executed
> >> by the cpu_stopper.
> >>
> >> This can potentially occur whenever a rq's running task is > CFS but
> >> the rq has runnable CFS tasks.
> >>
> >> Check the sched class of the remote rq's running task after we've
> >> grabbed its lock. If it's CFS, carry on, otherwise run
> >> detach_one_task() locally since we don't need the cpu_stopper (that
> >> !CFS task is doing the exact same thing).
> >
> > AFAICT, this doesn't prevent from preempting !CFS task but only reduce
> > the window.
> > As soon as you unlock, !CFS task can preempt CFS before you start stop thread
> >
>
> Right, if we end up kicking the cpu_stopper this can still happen (since
> we drop the lock). Thing is, you can't detect it on the cpu_stopper side,
> since the currently running is obviously not going to be CFS (and it's
> too late anyway, we already preempted whatever was running there). Though
> I should probably change the name of the patch to reflect that it's not a
> 100% cure.
>
> I tweaked the nr_running check of the cpu_stop callback in patch 3/4 to try
> to bail out early, but AFAICT that's the best we can do without big changes
> elsewhere.
>
> If we wanted to prevent those preemptions at all cost, I suppose we'd want

I'm not sure that it's worth the effort and the complexity

> the equivalent of a sched class sitting between CFS and RT: have the
> callback only run when there's no runnable > CFS tasks. But then by the
> time we execute it we may no longer need to balance anything...
>
> At the very least, what I'm proposing here alleviates *some* of the
> preemption cases without swinging the wrecking ball too hard (and without
> delaying the balancing either).
>
> > testing  busiest->cfs.h_nr_running < 1 and/or
> > busiest->curr->sched_class != &fair_sched_class
> > in need_active_balance() will do almost the same and is much simpler
> > than this patchset IMO.
> >
>
> I had this initially but convinced myself out of it: since we hold no
> lock in need_active_balance(), the information we get on the current task
> (and, arguably, on the h_nr_running) is too volatile to be of any use.

But since the lock is released anyway, everything will always be too
volatile in this case.

>
> I do believe those checks have their place in active_load_balance()'s
> critical section, as that's the most accurate we're going to get. On the
> plus side, if we *do* detect the remote rq's current task isn't CFS, we
> can run detach_one_task() locally, which is an improvement IMO.

This add complexity in the code by adding another path to detach attach task(s).
We could simply bail out and wait the next load balance (which is
already the case sometime) or if you really want to detach a task jump
back to more_balance
