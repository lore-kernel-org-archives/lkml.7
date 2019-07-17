Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B2C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2589521852
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="G2c6z1BI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfGQUsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:48:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42553 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQUsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:48:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so11416076pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIvu+m6OtJySXdmyyJx4x4Oj6+ax+DbpP8RQfikqUdA=;
        b=G2c6z1BI21qYjpUqgk7+Rn6/i8O16nVnLSNOzP3LPAWurG2ntXX0Fg1085fMf+NtlY
         vfB5F+t0VuBQE6o6YGA1tz1Hpb18KAGfFehiUiw+5licyggM6884JwJDMjWWmtk8jqgk
         e4syfpSHQfxXdtJ6YCnA+Wkh5oHWSXVpMK2Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIvu+m6OtJySXdmyyJx4x4Oj6+ax+DbpP8RQfikqUdA=;
        b=DF4vh1ho6ZPLXzToUvUxt/GeQl9nYvUJpZc42sTLV97B0mdYm+GGswuvMCGGMLuIFJ
         J1Fv/bplqkBO31/EAKw77Mgwp6NJXTrAxnG8IOTcxgh0O8CUd8K2odnDGzDVqv6/jkU1
         hcLVdpOMrkn1JlYKTPasAwLl1lh+MFOHpz7h0d5qLQZCpWM8byOvQ4pQKvG1B5Xb74mh
         /vmUXGy23LPeFtNhoRdG/3GEhOe/C2QQ0LSFjDNuJmVA+HE05QpG6dNJsCn0DIBHtjNN
         2hz8J5DursMXkBICPpiPERaUbFEO6HSNTHvXQOM7zj0szRTwHgDrRSoHK9i8fz7oz4Ie
         wcGQ==
X-Gm-Message-State: APjAAAXtP190Iskzs/aXynGD3a+K8PYvOuHrl1ABh5x/ghRTPUVI3yPH
        QGy1sF+pmziCjXu4rr2saRo=
X-Google-Smtp-Source: APXvYqyNkl4jk4vCq+qxbdqU7ypl2V8YwC5HnHUMK4F7MAX6SG+3vwENk43/p5Bq2jsl7Ztpa+aG5g==
X-Received: by 2002:a63:4104:: with SMTP id o4mr44838239pga.345.1563396480804;
        Wed, 17 Jul 2019 13:48:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a21sm29505988pfi.27.2019.07.17.13.47.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 13:47:59 -0700 (PDT)
Date:   Wed, 17 Jul 2019 16:47:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd
 polling
Message-ID: <20190717204758.GB72146@google.com>
References: <20190717172100.261204-1-joel@joelfernandes.org>
 <20190717175556.axe2pne7lcrkmtzr@brauner.io>
 <CAJuCfpHYoxT0yJvgU62GaoT0g9+ngOhLBN2LP1wt9rrN4-oxvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHYoxT0yJvgU62GaoT0g9+ngOhLBN2LP1wt9rrN4-oxvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 11:09:59AM -0700, Suren Baghdasaryan wrote:
> On Wed, Jul 17, 2019 at 10:56 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Wed, Jul 17, 2019 at 01:21:00PM -0400, Joel Fernandes wrote:
> > > From: Suren Baghdasaryan <surenb@google.com>
> > >
> > > There is a race between reading task->exit_state in pidfd_poll and writing
> > > it after do_notify_parent calls do_notify_pidfd. Expected sequence of
> > > events is:
> > >
> > > CPU 0                            CPU 1
> > > ------------------------------------------------
> > > exit_notify
> > >   do_notify_parent
> > >     do_notify_pidfd
> > >   tsk->exit_state = EXIT_DEAD
> > >                                   pidfd_poll
> > >                                      if (tsk->exit_state)
> > >
> > > However nothing prevents the following sequence:
> > >
> > > CPU 0                            CPU 1
> > > ------------------------------------------------
> > > exit_notify
> > >   do_notify_parent
> > >     do_notify_pidfd
> > >                                    pidfd_poll
> > >                                       if (tsk->exit_state)
> > >   tsk->exit_state = EXIT_DEAD
> > >
> > > This causes a polling task to wait forever, since poll blocks because
> > > exit_state is 0 and the waiting task is not notified again. A stress
> > > test continuously doing pidfd poll and process exits uncovered this bug,
> > > and the below patch fixes it.
> > >
> > > To fix this, we set tsk->exit_state before calling do_notify_pidfd.
> > >
> > > Cc: kernel-team@android.com
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > That means in such a situation other users will see EXIT_ZOMBIE where
> > they didn't see that before until after the parent failed to get
> > notified.
> 
> I'm a little nervous about that myself even though in my stress
> testing this worked fine. I think the safest change would be to move
> do_notify_pidfd() out of do_notify_parent() and call it after
> tsk->exit_state is finalized. The downside of that is that there are 4

My initial approach to pidfd polling did it this way, and I remember there
was a break in semantics where this does not work well. We want the
notification to happen in do_notify_parent() so that it is in sync with the
wait APIs..

I don't see a risk with this patch though. But let us see what Oleg's eyes
find.

> places we call do_notify_parent(), so instead of calling
> do_notify_pidfd() one time from do_notify_parent() we will be calling
> it 4 times now.
> 
> Also my original patch had memory barriers to ensure correct ordering
> of tsk->exit_state writes before reads. In this final version Joel
> removed them, so I suppose he found out they are not needed. Joel,
> please clarify.

The barriers were initially add by me to your patch, but then I felt it may
not be needed so I removed them before sending the patch. My initial concern
was something like the following:

CPU 0                      CPU 1
------------------------------------------------
store tsk->exit_state = 1
/* smp_wmb() ? */
do_notify_parent
wake up
                           poll_wait()
                           /* smp_rmb(); ? */
                           read tsk->exit_state = 0
                           block...


I was initially concerned if tsk->exit_state write would be missed by the
polling thread and we would block forever (similar to this bug).

I don't think this is possible anymore since wakeup implies release-barrier
and waiting implies acquire barrier AFAIU. I am still not fully sure though,
so yeah if you guys think it is an issue, let us add the memory barriers. As
such I know memory barrier additions to the kernel requires justification,
otherwise Linus calls it "Voodoo programming". So let us convince ourself
first if memory barriers are needed before adding them anyway.

thanks,

 - Joel




> Thanks!
> 
> > That's a rather subtle internal change. I was worried about
> > __ptrace_detach() since it explicitly checks for EXIT_ZOMBIE but it
> > seems to me that this is fine since we hold write_lock_irq(&tasklist_lock);
> > at the point when we do set p->exit_signal.
> >
> > Acked-by: Christian Brauner <christian@brauner.io>
> >
> > Once Oleg confirms that I'm right not to worty I'll pick this up.
> >
> > Thanks!
> > Christian
> >
> > >
> > > ---
> > >  kernel/exit.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/exit.c b/kernel/exit.c
> > > index a75b6a7f458a..740ceacb4b76 100644
> > > --- a/kernel/exit.c
> > > +++ b/kernel/exit.c
> > > @@ -720,6 +720,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
> > >       if (group_dead)
> > >               kill_orphaned_pgrp(tsk->group_leader, NULL);
> > >
> > > +     tsk->exit_state = EXIT_ZOMBIE;
> > >       if (unlikely(tsk->ptrace)) {
> > >               int sig = thread_group_leader(tsk) &&
> > >                               thread_group_empty(tsk) &&
> > > @@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
> > >               ptrace_unlink(p);
> > >
> > >               /* If parent wants a zombie, don't release it now */
> > > -             state = EXIT_ZOMBIE;
> > > +             p->exit_state = EXIT_ZOMBIE;
> > >               if (do_notify_parent(p, p->exit_signal))
> > > -                     state = EXIT_DEAD;
> > > -             p->exit_state = state;
> > > +                     p->exit_state = EXIT_DEAD;
> > > +
> > > +             state = p->exit_state;
> > >               write_unlock_irq(&tasklist_lock);
> > >       }
> > >       if (state == EXIT_DEAD)
> > > --
> > > 2.22.0.657.g960e92d24f-goog
> > >
