Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437EC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02D5208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZum+jiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfGQSKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:10:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45246 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfGQSKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:10:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so25798567wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4zRuuB0tQXvX7Wdz6K3fiN9+DH90QL9fyAJw6VWrt0=;
        b=hZum+jiR2vgl4lS74AjOj+d62h8hAhmn4FOC9UXn7kG9/RgpXWF7CXHaoU+P7vYAcn
         j9IL9atHTvQM0fNvrFvbol0WL4XwOSthmuDrX1OZCDmLWNADLb/haP/kK5ZyWQ9ZXMdy
         q45HzysbyXpRzrPUtu9JcIKpUVrClA9Jy+FNsjoL5aLh8J6R4T+69N1Mb4w/WrNetHh1
         7vBbT3z0rLa80sjSyXrG7Ba3TRBRyb3XR/kHqVCNLZZJm0JuLF+MyyYjF8m8UfIUxH3L
         neOu+RCrTFJNr4wR+ywZoGSYbauYJG6Yu98Lilu/U/7/T8RzjfwJNQ3eIlyG6uQznLRX
         pnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4zRuuB0tQXvX7Wdz6K3fiN9+DH90QL9fyAJw6VWrt0=;
        b=iyYiSba7zhe2onUM2neJcL8WJeZEQBA14bFVVIRV1lommzCzx2GP3uQ8qyGjma0Dc/
         D3v2Q7SrHr9lX17GwXRvlPtfL+pk05xwJzs0stfA+ls2eBpYenGj7tGwdwJ9I3tcSPSP
         1UqqgfMjr6XDYJtwsAvZJyCI4j4YOnhCynbRnVzErxyUoiq+ByfW9Nf3+njOPn3UrLtZ
         tdbzkvrM4fk+CMLgFjHPLDfIyAxBsWnoxY2TZSRYFkeldCvtq1qwWiBYTPAC8/jPxpcE
         glMXKcxxZaNMhgIikNjRyQnchDMYhnlx0hRinNjCYVozFkzpDNp2xN34bAQkqAt3YIoS
         yCHw==
X-Gm-Message-State: APjAAAUyFmgkEDQHbODHtTTFNF68vAOLrhG5rfQHZUclEpOZ9uZWbb+q
        kZUrq4HWpjjlqv6H9ITFKyP8yEdWfO3MMJABmMBNsg==
X-Google-Smtp-Source: APXvYqxhijtKaBEq5+Ox1NxfoTOb5cA2wv9dpEJ0x9BhkoYyJZmFHCkvbN2mhmlt7GRKsdQ5VehCG31uxWbiYxU+2B4=
X-Received: by 2002:adf:ce88:: with SMTP id r8mr18117945wrn.42.1563387010687;
 Wed, 17 Jul 2019 11:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190717172100.261204-1-joel@joelfernandes.org> <20190717175556.axe2pne7lcrkmtzr@brauner.io>
In-Reply-To: <20190717175556.axe2pne7lcrkmtzr@brauner.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 17 Jul 2019 11:09:59 -0700
Message-ID: <CAJuCfpHYoxT0yJvgU62GaoT0g9+ngOhLBN2LP1wt9rrN4-oxvg@mail.gmail.com>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd polling
To:     Christian Brauner <christian@brauner.io>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:56 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Wed, Jul 17, 2019 at 01:21:00PM -0400, Joel Fernandes wrote:
> > From: Suren Baghdasaryan <surenb@google.com>
> >
> > There is a race between reading task->exit_state in pidfd_poll and writing
> > it after do_notify_parent calls do_notify_pidfd. Expected sequence of
> > events is:
> >
> > CPU 0                            CPU 1
> > ------------------------------------------------
> > exit_notify
> >   do_notify_parent
> >     do_notify_pidfd
> >   tsk->exit_state = EXIT_DEAD
> >                                   pidfd_poll
> >                                      if (tsk->exit_state)
> >
> > However nothing prevents the following sequence:
> >
> > CPU 0                            CPU 1
> > ------------------------------------------------
> > exit_notify
> >   do_notify_parent
> >     do_notify_pidfd
> >                                    pidfd_poll
> >                                       if (tsk->exit_state)
> >   tsk->exit_state = EXIT_DEAD
> >
> > This causes a polling task to wait forever, since poll blocks because
> > exit_state is 0 and the waiting task is not notified again. A stress
> > test continuously doing pidfd poll and process exits uncovered this bug,
> > and the below patch fixes it.
> >
> > To fix this, we set tsk->exit_state before calling do_notify_pidfd.
> >
> > Cc: kernel-team@android.com
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> That means in such a situation other users will see EXIT_ZOMBIE where
> they didn't see that before until after the parent failed to get
> notified.

I'm a little nervous about that myself even though in my stress
testing this worked fine. I think the safest change would be to move
do_notify_pidfd() out of do_notify_parent() and call it after
tsk->exit_state is finalized. The downside of that is that there are 4
places we call do_notify_parent(), so instead of calling
do_notify_pidfd() one time from do_notify_parent() we will be calling
it 4 times now.

Also my original patch had memory barriers to ensure correct ordering
of tsk->exit_state writes before reads. In this final version Joel
removed them, so I suppose he found out they are not needed. Joel,
please clarify.
Thanks!

> That's a rather subtle internal change. I was worried about
> __ptrace_detach() since it explicitly checks for EXIT_ZOMBIE but it
> seems to me that this is fine since we hold write_lock_irq(&tasklist_lock);
> at the point when we do set p->exit_signal.
>
> Acked-by: Christian Brauner <christian@brauner.io>
>
> Once Oleg confirms that I'm right not to worty I'll pick this up.
>
> Thanks!
> Christian
>
> >
> > ---
> >  kernel/exit.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index a75b6a7f458a..740ceacb4b76 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -720,6 +720,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
> >       if (group_dead)
> >               kill_orphaned_pgrp(tsk->group_leader, NULL);
> >
> > +     tsk->exit_state = EXIT_ZOMBIE;
> >       if (unlikely(tsk->ptrace)) {
> >               int sig = thread_group_leader(tsk) &&
> >                               thread_group_empty(tsk) &&
> > @@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
> >               ptrace_unlink(p);
> >
> >               /* If parent wants a zombie, don't release it now */
> > -             state = EXIT_ZOMBIE;
> > +             p->exit_state = EXIT_ZOMBIE;
> >               if (do_notify_parent(p, p->exit_signal))
> > -                     state = EXIT_DEAD;
> > -             p->exit_state = state;
> > +                     p->exit_state = EXIT_DEAD;
> > +
> > +             state = p->exit_state;
> >               write_unlock_irq(&tasklist_lock);
> >       }
> >       if (state == EXIT_DEAD)
> > --
> > 2.22.0.657.g960e92d24f-goog
> >
