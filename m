Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94628C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605B9217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NEAvdkGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbfGRKJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:09:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35863 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfGRKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:09:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so20930647wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XP5xVuD5EmXFFFctwJTPJ6GJZS1Z+p5f1Geb9fNzSnE=;
        b=NEAvdkGXiDPQPoWETEAP7uviJSoMMS1xiRu96OOOPsmF4yLZXwfneo3tPND7B4lQhr
         SztD1xNikzb30f0i+o3ODPFZVeLklsMZeGa3ouw/8wlp+3J/pA3qQ+eJSLvTgySHjMgB
         J0qjJjpB21H+S9739E2/Hok/DxC6F6WrA1ic09xeOr4oRc48LQkyqjO4RpeyaYQFQ9bI
         lThyU0/n/hOD0z7tUo1CSajD2o91E+dECPeviRfu3+T8RrvzNkwUTX6UHR3x9K3nvDVg
         KaEqQoALxRBeanz24z7xyzYBS0lp0NZ93YjNGgZxesaw2qDsrTIy8Eh6IoR5ypmhEUwD
         HC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XP5xVuD5EmXFFFctwJTPJ6GJZS1Z+p5f1Geb9fNzSnE=;
        b=MYiKm+M0XbMxQ0NFSPdg7C4ud8PSn6eIbxZfSUcu2YxTWCwMZ1R2nOVi+JzWnZ7JWZ
         qVqOSrJboyUNbPI4wmNCGhlLOWFSsb12kTEbsCw9XF+Q2Gzx5auflKgtB0mFDtNmVMzf
         qNux3rhPKB7v+G88+18L7xclS88jGPacfUnpgBmtsuPyW091tLWWYbdy/rCh8VyxM1oA
         Po2WEoj/Y7dH13ApIcesN7GYfmHZfCu3hu3c/C8hICX74aBt0LeLjCv9WAmKG952U3Lg
         +USlnv8/zTOYoikwlCVyhDU8gHUZf1f+Q2FKVL1GyMiTYkQ90i4iJIVnxjEwsqvQENdB
         CMhg==
X-Gm-Message-State: APjAAAXAyDbKHmeRsCgQGfUPurl1/2KGLcgDJUnyNlQI73+L3L9Q2jRh
        SCdrcOAD0HBDq8mlGOONVg0=
X-Google-Smtp-Source: APXvYqxBxMsFhjsSH/fKxgBILWXptuGQ90AfgybT42xCnhTo+aeQNlCoIPXcTeZZtnEeawmLc/XK6Q==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr37931214wmc.89.1563444567167;
        Thu, 18 Jul 2019 03:09:27 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id x83sm27197338wmb.42.2019.07.18.03.09.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 03:09:26 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:09:25 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd
 polling
Message-ID: <20190718100924.i74ndj3zvkgbvxwu@brauner.io>
References: <20190717172100.261204-1-joel@joelfernandes.org>
 <20190717175556.axe2pne7lcrkmtzr@brauner.io>
 <CAJuCfpHYoxT0yJvgU62GaoT0g9+ngOhLBN2LP1wt9rrN4-oxvg@mail.gmail.com>
 <20190717204758.GB72146@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717204758.GB72146@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 04:47:58PM -0400, Joel Fernandes wrote:
> On Wed, Jul 17, 2019 at 11:09:59AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jul 17, 2019 at 10:56 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Wed, Jul 17, 2019 at 01:21:00PM -0400, Joel Fernandes wrote:
> > > > From: Suren Baghdasaryan <surenb@google.com>
> > > >
> > > > There is a race between reading task->exit_state in pidfd_poll and writing
> > > > it after do_notify_parent calls do_notify_pidfd. Expected sequence of
> > > > events is:
> > > >
> > > > CPU 0                            CPU 1
> > > > ------------------------------------------------
> > > > exit_notify
> > > >   do_notify_parent
> > > >     do_notify_pidfd
> > > >   tsk->exit_state = EXIT_DEAD
> > > >                                   pidfd_poll
> > > >                                      if (tsk->exit_state)
> > > >
> > > > However nothing prevents the following sequence:
> > > >
> > > > CPU 0                            CPU 1
> > > > ------------------------------------------------
> > > > exit_notify
> > > >   do_notify_parent
> > > >     do_notify_pidfd
> > > >                                    pidfd_poll
> > > >                                       if (tsk->exit_state)
> > > >   tsk->exit_state = EXIT_DEAD
> > > >
> > > > This causes a polling task to wait forever, since poll blocks because
> > > > exit_state is 0 and the waiting task is not notified again. A stress
> > > > test continuously doing pidfd poll and process exits uncovered this bug,
> > > > and the below patch fixes it.
> > > >
> > > > To fix this, we set tsk->exit_state before calling do_notify_pidfd.
> > > >
> > > > Cc: kernel-team@android.com
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > That means in such a situation other users will see EXIT_ZOMBIE where
> > > they didn't see that before until after the parent failed to get
> > > notified.
> > 
> > I'm a little nervous about that myself even though in my stress
> > testing this worked fine. I think the safest change would be to move
> > do_notify_pidfd() out of do_notify_parent() and call it after
> > tsk->exit_state is finalized. The downside of that is that there are 4
> 
> My initial approach to pidfd polling did it this way, and I remember there
> was a break in semantics where this does not work well. We want the
> notification to happen in do_notify_parent() so that it is in sync with the
> wait APIs..
> 
> I don't see a risk with this patch though. But let us see what Oleg's eyes
> find.

I've been going through the various codepaths and that change should be
fine. The places I looked at that worried me were release_task(),
reparent_leader(), wait_consider_task() and their callers.
But all of these either take read_lock(&tasklist_lock) or
write_lock_irq(&tasklist_lock) themselves or are called with them held,
same for ptrace_attach() and ptrace_detach(). And the whole sequence
that switches to autoreaping when the parent ingores SIGCHLD in
do_notify_parent() and wait_task_zombie() is under
write_lock_irq(&tasklist_lock) as well so setting it to EXIT_ZOMBIE
before do_notify_parent() and switching it to EXIT_DEAD when the parent
ignores SIGCHLD should be safe.
If we missed a sublety then we'll know pretty soon I'm sure.

I'll pick this up now. We'll have some time anyway.

> 
> > places we call do_notify_parent(), so instead of calling
> > do_notify_pidfd() one time from do_notify_parent() we will be calling
> > it 4 times now.
> > 
> > Also my original patch had memory barriers to ensure correct ordering
> > of tsk->exit_state writes before reads. In this final version Joel
> > removed them, so I suppose he found out they are not needed. Joel,
> > please clarify.
> 
> The barriers were initially add by me to your patch, but then I felt it may
> not be needed so I removed them before sending the patch. My initial concern
> was something like the following:
> 
> CPU 0                      CPU 1
> ------------------------------------------------
> store tsk->exit_state = 1
> /* smp_wmb() ? */
> do_notify_parent
> wake up
>                            poll_wait()
>                            /* smp_rmb(); ? */
>                            read tsk->exit_state = 0
>                            block...
> 
> 
> I was initially concerned if tsk->exit_state write would be missed by the
> polling thread and we would block forever (similar to this bug).
> 
> I don't think this is possible anymore since wakeup implies release-barrier

wake_up_all() which is used in do_notify_pidfd() implies a general
memory barrier if something is actually woken up.

> and waiting implies acquire barrier AFAIU. I am still not fully sure though,

poll_wait() when used with eventpoll hits add_wait_queue which takes
spin_lock_irqsave() which implies an acquire barrier if I remember
memory_barriers right.

> so yeah if you guys think it is an issue, let us add the memory barriers. As
> such I know memory barrier additions to the kernel requires justification,
> otherwise Linus calls it "Voodoo programming". So let us convince ourself
> first if memory barriers are needed before adding them anyway.

I didn't see it as an issue either.

> 
> thanks,
> 
>  - Joel
> 
> 
> 
> 
> > Thanks!
> > 
> > > That's a rather subtle internal change. I was worried about
> > > __ptrace_detach() since it explicitly checks for EXIT_ZOMBIE but it
> > > seems to me that this is fine since we hold write_lock_irq(&tasklist_lock);
> > > at the point when we do set p->exit_signal.
> > >
> > > Acked-by: Christian Brauner <christian@brauner.io>
> > >
> > > Once Oleg confirms that I'm right not to worty I'll pick this up.
> > >
> > > Thanks!
> > > Christian
> > >
> > > >
> > > > ---
> > > >  kernel/exit.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/exit.c b/kernel/exit.c
> > > > index a75b6a7f458a..740ceacb4b76 100644
> > > > --- a/kernel/exit.c
> > > > +++ b/kernel/exit.c
> > > > @@ -720,6 +720,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
> > > >       if (group_dead)
> > > >               kill_orphaned_pgrp(tsk->group_leader, NULL);
> > > >
> > > > +     tsk->exit_state = EXIT_ZOMBIE;
> > > >       if (unlikely(tsk->ptrace)) {
> > > >               int sig = thread_group_leader(tsk) &&
> > > >                               thread_group_empty(tsk) &&
> > > > @@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
> > > >               ptrace_unlink(p);
> > > >
> > > >               /* If parent wants a zombie, don't release it now */
> > > > -             state = EXIT_ZOMBIE;
> > > > +             p->exit_state = EXIT_ZOMBIE;
> > > >               if (do_notify_parent(p, p->exit_signal))
> > > > -                     state = EXIT_DEAD;
> > > > -             p->exit_state = state;
> > > > +                     p->exit_state = EXIT_DEAD;
> > > > +
> > > > +             state = p->exit_state;
> > > >               write_unlock_irq(&tasklist_lock);
> > > >       }
> > > >       if (state == EXIT_DEAD)
> > > > --
> > > > 2.22.0.657.g960e92d24f-goog
> > > >
