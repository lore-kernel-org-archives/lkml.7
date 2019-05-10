Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CEEC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568EF21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bc5Spi54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfEJPU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:20:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35139 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfEJPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:20:28 -0400
Received: by mail-io1-f68.google.com with SMTP id p2so4803405iol.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrbeovF+fjWSeVPTpilNjNVE8DYyqu+aTis0l/oYkL4=;
        b=bc5Spi54huGVHztgDsdTF8soN5Lb8gcKIzqHvBSey/7ADIFfzvhOL5QJ5yDvBjJeVc
         KAUUU71MlDw88D+naXb7K5FeXTVRxHTTgo/KsCWFU71JQfqVO52TZXz3wVmyYs+Ootx4
         7F2Up23rhUJgrLKL9ACsI64nAWHP+/0NI+XwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrbeovF+fjWSeVPTpilNjNVE8DYyqu+aTis0l/oYkL4=;
        b=gT3K78r3iyK5ZZwF8uhV/a08DoRIWwrqOAgYvrc5zyegyUnKDwOli6S4114QgEvi2g
         veQWikXPi3SpuhuQwNlBJhX8RDACVNUgBRfVG0IuqXA/wquaY4z8XhrXQkxuNVcKgbAS
         exWpuQpQD98h2Xn7WgwyRXC1p0Nj9vpFFXUb/ipm3g4CcnuTX3801/lW6aQOPaJPzH7S
         AzXomNdkxFMKQ0H4UZAOoPZyqgFaU+d5GHM4yhjADqt54GO16Sd3DcvM8osl1AP3ir5/
         Hk0A8D5vyelPofSxCqndEK+8SbbDWF3CcvhkD71d337CG3pNOqS7kcQEmz8RFJf1rE/b
         3TSA==
X-Gm-Message-State: APjAAAU0T+Rvvh6xVvmxmldsPlsk7IGfZWyU4NhyBrreWGh1h+22TJPE
        rnFwF+iXbXJ+HTkJ3wwxaC00dEasiqlNZ7SXjXCdkQ==
X-Google-Smtp-Source: APXvYqyGy0QKq8RFEM2FhfJVX0s/4Ab+rOb+P2bBUoQMSnJ8RrYBJVX9LW7nbUglSVX5XIrzrc3uV91SJ4OQGoa2SJk=
X-Received: by 2002:a6b:400a:: with SMTP id k10mr8036136ioa.291.1557501627148;
 Fri, 10 May 2019 08:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
 <20190509200633.19678-1-daniel.vetter@ffwll.ch> <20190510092819.elu4b7fcojzcek2q@pathway.suse.cz>
In-Reply-To: <20190510092819.elu4b7fcojzcek2q@pathway.suse.cz>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 10 May 2019 17:20:15 +0200
Message-ID: <CAKMK7uEPAH82xv8r+8Rh3eQT1mTO00A-sFTEqQMwA=zFtWmfxQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/locking/semaphore: use wake_q in up()
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

On Fri, May 10, 2019 at 11:28 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2019-05-09 22:06:33, Daniel Vetter wrote:
> > console_trylock, called from within printk, can be called from pretty
> > much anywhere. Including try_to_wake_up. Note that this isn't common,
> > usually the box is in pretty bad shape at that point already. But it
> > really doesn't help when then lockdep jumps in and spams the logs,
> > potentially obscuring the real backtrace we're really interested in.
> > One case I've seen (slightly simplified backtrace):
> >
> > Fix this specific locking recursion by moving the wake_up_process out
> > from under the semaphore.lock spinlock, using wake_q as recommended by
> > Peter Zijlstra.
>
> It might make sense to mention also the optimization effect mentioned
> by Peter.
>
> > diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> > index 561acdd39960..7a6f33715688 100644
> > --- a/kernel/locking/semaphore.c
> > +++ b/kernel/locking/semaphore.c
> > @@ -169,6 +169,14 @@ int down_timeout(struct semaphore *sem, long timeout)
> >  }
> >  EXPORT_SYMBOL(down_timeout);
> >
> > +/* Functions for the contended case */
> > +
> > +struct semaphore_waiter {
> > +     struct list_head list;
> > +     struct task_struct *task;
> > +     bool up;
> > +};
> > +
> >  /**
> >   * up - release the semaphore
> >   * @sem: the semaphore to release
> > @@ -179,24 +187,25 @@ EXPORT_SYMBOL(down_timeout);
> >  void up(struct semaphore *sem)
> >  {
> >       unsigned long flags;
> > +     struct semaphore_waiter *waiter;
> > +     DEFINE_WAKE_Q(wake_q);
>
> We need to call wake_q_init(&wake_q) to make sure that
> it is empty.

DEFINE_WAKE_Q does that already, and if it didn't, I'd wonder how I
managed to boot with this patch. console_lock is usally terribly
contented because thanks to fbcon we must do a full display modeset
while holding it, which takes forever. As long as anyone printks
meanwhile (guaranteed while loading drivers really) you have
contention.
-Daniel


> Best Regards,
> Petr
>
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> > -     if (likely(list_empty(&sem->wait_list)))
> > +     if (likely(list_empty(&sem->wait_list))) {
> >               sem->count++;
> > -     else
> > -             __up(sem);
> > +     } else {
> > +             waiter =  list_first_entry(&sem->wait_list,
> > +                                        struct semaphore_waiter, list);
> > +             list_del(&waiter->list);
> > +             waiter->up = true;
> > +             wake_q_add(&wake_q, waiter->task);
> > +     }
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > +
> > +     wake_up_q(&wake_q);
> >  }
> >  EXPORT_SYMBOL(up);
> >
> > -/* Functions for the contended case */
> > -
> > -struct semaphore_waiter {
> > -     struct list_head list;
> > -     struct task_struct *task;
> > -     bool up;
> > -};
> > -
> >  /*
> >   * Because this function is inlined, the 'state' parameter will be
> >   * constant, and thus optimised away by the compiler.  Likewise the



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
