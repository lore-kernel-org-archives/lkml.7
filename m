Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1789CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E7C2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KHEHVvcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfEIQn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:43:26 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54204 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:43:26 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so3297596ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ri3CpftuIpT9d0s+IVfuoxut7FIO9KJuWpxsKIznmbU=;
        b=KHEHVvclKxX3b4VEd9rqQSKIfc/VB1DG46AiuqoQO6MmdzqKPChzqIjaWeLi8WZuSN
         qg3vWPQpJh8P12dR1aDpy55Qfcft4l5n6tx87xVhtWFaRWgJ0e6J78POHm0EgkWmRDZy
         cpd6tWNs2OYEAKfYsXj+ATze0Cs/+Vxv485d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ri3CpftuIpT9d0s+IVfuoxut7FIO9KJuWpxsKIznmbU=;
        b=MPqBIs9EDMfKycFQ+cQyLS//MIuyNUDepHE8WfrFKuMHfQpTekCSAWvl/xOIPya9X0
         m0NCZS9uBSU7leGoRmOkkGw9WckM+uTEjCOD/wR0jmQ7KCI6D52/azZ3vDNWVdgegG2h
         JzuQfmZblSBjXOf6ArscIFMZXf+gvewjgAGdT4CLntcXroxMdOcyJsnff9+3M6swKTC7
         kOi0AUm4mEcnBXvhxUrGlxg3svr0yyb9CyDdwP0qimEo/2SGysjvg7QeOrJCHF8Zm6Cf
         3+IuKPCY6VVMP8FmWtnxzjh2f1wzu74nzPAA5ceLXgQhLqLtO8hRjeTlk1fecZ6IUxxp
         A5SA==
X-Gm-Message-State: APjAAAVVRhXfc4MJSiFUNfx2JHgAqvWQnjFyzlvmbqfhqSuZDEugYOro
        G6QBel20WQvuG0G4GGNdMHDAmwi2RYRL0IV++kYbzQ==
X-Google-Smtp-Source: APXvYqzWDnGMynWy3va8bT/rHKkJudfLzib87wLjGrfcxNr6pxPcPCAai2WR2EI/XFW0Fo6VtG3+2XlryAQjvA9Beww=
X-Received: by 2002:a05:660c:4d0:: with SMTP id v16mr3974611itk.62.1557420205267;
 Thu, 09 May 2019 09:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch> <20190509145620.2pjqko7copbxuzth@pathway.suse.cz>
In-Reply-To: <20190509145620.2pjqko7copbxuzth@pathway.suse.cz>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 9 May 2019 18:43:12 +0200
Message-ID: <CAKMK7uFTsr1F8nFExTvC7nWFQMcZ7ejh+k_X6E8EcMUaP3e29A@mail.gmail.com>
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
To:     Petr Mladek <pmladek@suse.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 4:56 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2019-05-09 14:09:03, Daniel Vetter wrote:
> > console_trylock, called from within printk, can be called from pretty
> > much anywhere. Including try_to_wake_up. Note that this isn't common,
> > usually the box is in pretty bad shape at that point already. But it
> > really doesn't help when then lockdep jumps in and spams the logs,
> > potentially obscuring the real backtrace we're really interested in.
> > One case I've seen (slightly simplified backtrace):
> >
> >  Call Trace:
> >   <IRQ>
> >   console_trylock+0xe/0x60
> >   vprintk_emit+0xf1/0x320
> >   printk+0x4d/0x69
> >   __warn_printk+0x46/0x90
> >   native_smp_send_reschedule+0x2f/0x40
> >   check_preempt_curr+0x81/0xa0
> >   ttwu_do_wakeup+0x14/0x220
> >   try_to_wake_up+0x218/0x5f0
> >   pollwake+0x6f/0x90
> >   credit_entropy_bits+0x204/0x310
> >   add_interrupt_randomness+0x18f/0x210
> >   handle_irq+0x67/0x160
> >   do_IRQ+0x5e/0x130
> >   common_interrupt+0xf/0xf
> >   </IRQ>
> >
> > This alone isn't a problem, but the spinlock in the semaphore is also
> > still held while waking up waiters (up() -> __up() -> try_to_wake_up()
> > callchain), which then closes the runqueue vs. semaphore.lock loop,
> > and upsets lockdep, which issues a circular locking splat to dmesg.
> > Worse it upsets developers, since we don't want to spam dmesg with
> > clutter when the machine is dying already.
> >
> > Fix this by creating a prinkt_safe_up() which calls wake_up_process
> > outside of the spinlock. This isn't correct in full generality, but
> > good enough for console_lock:
> >
> > - console_lock doesn't use interruptible or killable or timeout down()
> >   calls, hence an up() is the only thing that can wake up a process.
> >   Hence the process can't get woken and killed and reaped while we try
> >   to wake it up too.
> >
> > - semaphore.c always updates the waiter list while under the spinlock,
> >   so there's no other races. Specifically another process that races
> >   with a quick console_lock/unlock while we've dropped the spinlock
> >   already won't see our own waiter.
> >
> > Note that we only have to break the recursion for the semaphore.lock
> > spinlock of the console_lock. Recursion within various scheduler
> > related locks is already prevented by the printk_safe_enter/exit pair
> > in __up_console_sem().
>
> This is not fully true. printk_safe() helps only when
> the first try_to_wake_up() is called from printk_safe() context.
>
> > --- a/kernel/locking/semaphore.c
> > +++ b/kernel/locking/semaphore.c
> > @@ -197,6 +197,37 @@ struct semaphore_waiter {
> >       bool up;
> >  };
> >
> > +/**
> > + * printk_safe_up - release the semaphore in console_unlock
> > + * @sem: the semaphore to release
> > + *
> > + * Release the semaphore.  Unlike mutexes, up() may be called from any
> > + * context and even by tasks which have never called down().
> > + *
> > + * NOTE: This is a special version of up() for console_unlock only. It is only
> > + * safe if there are no killable, interruptible or timing out down() calls.
> > + */
> > +void printk_safe_up(struct semaphore *sem)
> > +{
> > +     unsigned long flags;
> > +     struct semaphore_waiter *waiter = NULL;
> > +
> > +     raw_spin_lock_irqsave(&sem->lock, flags);
> > +     if (likely(list_empty(&sem->wait_list))) {
> > +             sem->count++;
> > +     } else {
> > +             waiter = list_first_entry(&sem->wait_list,
> > +                                       struct semaphore_waiter, list);
> > +             list_del(&waiter->list);
> > +             waiter->up = true;
> > +     }
> > +     raw_spin_unlock_irqrestore(&sem->lock, flags);
> > +
> > +     if (waiter) /* protected by being sole wake source */
> > +             wake_up_process(waiter->task);
>
> I still do not see how this could help. Let's take the above
> backtrace as example:
>
>    <IRQ>
>    console_trylock+0xe/0x60
>    vprintk_emit+0xf1/0x320
>    printk+0x4d/0x69
>    __warn_printk+0x46/0x90
>    native_smp_send_reschedule +0x2f/0x40
>    check_preempt_curr+0x81/0xa0
>    ttwu_do_wakeup+0x14/0x220
>    try_to_wake_up+0x218/0x5f0
>    pollwake+0x6f/0x90
>    credit_entropy_bits+0x204/0x310
>    add_interrupt_randomness+0x18f/0x210
>    handle_irq+0x67/0x160
>    do_IRQ+0x5e/0x130
>    common_interrupt+0xf/0xf
>    </IRQ>
>
> We have the following chain of calls:
>
>   + do_IRQ()
>     ...
>       + try_to_wake_up()    # takes p->pi_lock
>         + ttwu_remote()     # takes rq lock
>           + ttwu_do_wakeup()
>             + check_preempt_curr()
>               + native_smp_send_reschedule()
>                 + __warn_printk()
>                   + printk()
>                     + vprintk_emit()
>                       + console_trylock() # success
>                       + console_unlock()
>                         + up_console_sem()
>                           + up() # wait list in not empty
>                             + __up()
>                               + wake_up_process()
>                                 + try_to_wake_up()
>
> !BANG! Deadlock on p->pi_lock.

Hm right ... I only looked at this starting with console_unlock.

> It does not matter if the nested try_to_wake_up() was called
> under sem->lock or outside.
>
> By other words. The patch removed one lockdep warning. But it just
> just delayed the deadlock. It will not happen on sem->lock but
> later on p->pi_lock.
>
> I am repeating myself. But IMHO, the only solution is to introduce
> printk deferred context and use it in WARN_DEFERRED().

One thing to keep in mind is that the kernel is already dying, and
things will come crashing down later on (I've seen this only in dmesg
tails capture in pstore in our CI, i.e. the box died for good). I just
want to make sure that the useful information isn't overwritten by
more dmesg splats that happen as a consequence of us somehow trying to
run things on an offline cpu. Once console_unlock has completed in
your above backtrace and the important stuff has gone out I'm totally
fine with the kernel just dying. Pulling the wake_up_process out from
under the semaphore.lock is enough to prevent lockdep from dumping
more stuff while we're trying to print the important things, and I
think the untangling of the locking hiararchy is useful irrespective
of this lockdep splat. Plus Peter doesn't sound like he likes to roll
out more printk_deferred kind of things.

But if you think I should do the printk_deferred thing too I can look
into that. Just not quite sure what that's supposed to look like now.
-Daniel





--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
