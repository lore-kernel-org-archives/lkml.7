Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131EFCA9ECB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B7A21924
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0sS/BZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfJ3Wub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:50:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36999 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfJ3Wu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:50:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id q130so3945688wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5pv0TrDckCPKq/kpy/66V+Rj+yO2dx6a+ZGMx39OTk=;
        b=U0sS/BZZNsP6TKkYYN6B10usHzz5S2232rBMjOo8KfKq6KyHiKYTpvAbgVE7D8EeSY
         SVa8hTEtcpbOMAjqXM5wXgiB5Lv7QuXvcV3y5xfYctwDBS5/DzmXhMoKj8CAg7MVyQTl
         +m4RAoaytlo9rAE58wWfIrpQxfG6b5v61eZttegGq7EZzh1PHz0YP6ZkwhDloBI/T42T
         sVsxSqrrlMb4QWs4AmNK6xyPMILT90LUvJcBc/msOQF2+f8Sl1zHFhb56EE6U0lHCdiV
         yrObMW+p7g7GGVfyQOuyYkj/9z8NZ0B0907/7i5EyR0RbbirpmZ4mLqTVHR9a9K1MGEK
         uTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5pv0TrDckCPKq/kpy/66V+Rj+yO2dx6a+ZGMx39OTk=;
        b=cfxMBJw830J0xDafmJ6Sdg75nWHTNikeVbTnWnSFtRXrWW+XU0UpbfqkSfs1TEfOEa
         /h1VD10MKTZ9xh9hrhPUXNIZP56J5N8mWxEmykzpOvlGvWmuBACwh879COxLbyC3SLq9
         bmAHy2nEdLlSADs8xdQx8ckgkuZMj9G65KN47MFeN6ZO4RInQgK+IpdXmZXKE1/XDTwg
         zP7s0LEClLWQ2ZEIsQ4i+2ckiNIHGrlBFgTluShKJ7klb21IKEAlfyxJ1DG6IRRLTOEb
         M7zyBoUhsJQlpoyxBepcJS47o8HhoAU0XLcluf/szDtxxavRgButCyaHXImkyJIgaFpa
         8GKw==
X-Gm-Message-State: APjAAAWYKP+FrP6ao9P5auJnTqTGch6HuR30NE2ZOT5QtZ6XAm18BqAF
        rJetp+jHGogd/IqpqECn+brSpf7AM/6GZ47ZSy1udw==
X-Google-Smtp-Source: APXvYqwIuR/7aU9AfLmzsUpOEiGm8Sfd5QT+QzevSUMt1500kwG/j/o5S8PC06ZvL4JIe6bzRkQ/0BgFHrTFeeuGW8I=
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr1885289wmc.150.1572475826967;
 Wed, 30 Oct 2019 15:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191028174603.GA246917@google.com> <20191029113411.GP4643@worktop.programming.kicks-ass.net>
 <20191029115000.GA11194@google.com>
In-Reply-To: <20191029115000.GA11194@google.com>
From:   Ram Muthiah <rammuthiah@google.com>
Date:   Wed, 30 Oct 2019 15:50:00 -0700
Message-ID: <CA+CXyWsoW8ann52pcR66ejRmjJ=4QmoaHTRVhb3=ohe0ZDnm-A@mail.gmail.com>
Subject: Re: NULL pointer dereference in pick_next_task_fair
To:     Quentin Perret <qperret@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        valentin.schneider@arm.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 4:50 AM 'Quentin Perret' via kernel-team
<kernel-team@android.com> wrote:
>
> On Tuesday 29 Oct 2019 at 12:34:11 (+0100), Peter Zijlstra wrote:
> > On Mon, Oct 28, 2019 at 05:46:03PM +0000, Quentin Perret wrote:
> > > The issue is very transient and relatively hard to reproduce.
> > >
> > > After digging a bit, the offending commit seems to be:
> > >
> > >     67692435c411 ("sched: Rework pick_next_task() slow-path")
> > >
> > > By 'offending' I mean that reverting it makes the issue go away. The
> > > issue comes from the fact that pick_next_entity() returns a NULL se in
> > > the 'simple' path of pick_next_task_fair(), which causes obvious
> > > problems in the subsequent call to set_next_entity().
> > >
> > > I'll dig more, but if anybody understands the issue in the meatime feel
> > > free to send me a patch to try out :)
> >
> > Can you please see if this makes any difference?
> >
> > ---
> >  kernel/sched/core.c | 6 ++++--
> >  kernel/sched/fair.c | 2 +-
> >  kernel/sched/idle.c | 3 +--
> >  3 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7880f4f64d0e..abd2d4f80381 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3922,8 +3922,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >                       goto restart;
> >
> >               /* Assumes fair_sched_class->next == idle_sched_class */
> > -             if (unlikely(!p))
> > -                     p = idle_sched_class.pick_next_task(rq, prev, rf);
> > +             if (unlikely(!p)) {
> > +                     prev->sched_class->put_prev_task(rq, prev, rf);
> > +                     p = idle_sched_class.pick_next_task(rq, NULL, NULL);
> > +             }
> >
> >               return p;
> >       }
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 83ab35e2374f..2aad94bb7165 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6820,7 +6820,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
> >  simple:
> >  #endif
> >       if (prev)
> > -             put_prev_task(rq, prev);
> > +             prev->sched_class->put_prev_task(rq, prev, rf);
> >
> >       do {
> >               se = pick_next_entity(cfs_rq, NULL);
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index 8dad5aa600ea..e8dfc84f375a 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -390,8 +390,7 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
> >  {
> >       struct task_struct *next = rq->idle;
> >
> > -     if (prev)
> > -             put_prev_task(rq, prev);
> > +     WARN_ON_ONCE(prev || rf);
> >
> >       set_next_task_idle(rq, next);
> >
> >
>
> Unfortunately the issue went into hiding this morning and I struggle to
> reproduce it (this is turning bordeline nightmare now TBH).
>
> I'll try the patch once my reproducer is fixed :/
>
> Thank you very much for the help,
> Quentin
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

Quentin and I were able to create a setup which reproduces the issue.

Given this, I tried Peter's proposed fix and was still able to reproduce the
issue unfortunately. Current patch is located here -
https://android-review.googlesource.com/c/kernel/common/+/1153487

Our mitigation for this issue on the android-mainline branch has been to
revert 67692435c411 ("sched: Rework pick_next_task() slow-path").
https://android-review.googlesource.com/c/kernel/common/+/1152564

I'll spend some time detailing repro steps next. I should be able to
provide an update on those details early next week.

We appreciate the help so far.
Thanks,
Ram
