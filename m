Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CDAC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF42C2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZbMxX3MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfEJHwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:52:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39725 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfEJHwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:52:00 -0400
Received: by mail-it1-f194.google.com with SMTP id 9so489915itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bb+vyJ2l2JyKWoFlPq1nHRAbP2mdN5kXUD5ewhMbnn8=;
        b=ZbMxX3MKqmdfjEtLjPb6AIYZUKmckX5fhBu1Np3jWVfzdBwLml/8MtAA98LAuk5eVa
         CO+jAczip8dABiK05qRCe/BFFNNLq4gqQmZOelR55RYGn2zHNl/v2THzyk/G585xF1E5
         uGHwq5WIOtP7mmksLzUClSUXAAFQ9FYNn7dCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bb+vyJ2l2JyKWoFlPq1nHRAbP2mdN5kXUD5ewhMbnn8=;
        b=hM68atDUYyxBx3IVJZ+Bvbq3U8hNCcdXJQFPljdgefRDefSGqSI6pn3ztjEpUmAWEQ
         nmn76NYKcucZ32ZIdDqyapzyAvdyi5GEExy6icjIlc5fWzVmxPBHoVePegtN653C8e4Z
         0aD7mzQm7RLVfpPjjN6m3HqPBH+fYYoo1EidI7NQk33IELyoKPm7GHBZnw45711jZG9+
         F6cIMXZ+u3x0z52NtBjgjyc42i6ZNi1uwRfzAkkUSRLI2mw8L/8wjMkjcH+5nvjbYeM8
         MyQLP0BMC9lh9nXbz34HR7y9vzXPyu/rG8kRND3kV366871jIlZAqmYImfMsVDEtHqcN
         t0sQ==
X-Gm-Message-State: APjAAAWK4NdmJ03T9iIZmpYgiNNf/W8ckQGgzqmvhvNhchFXu73XiNai
        bSAHoOqSxA43mFazTihmzdbXDJe0rp1sCrYVpBqvkg==
X-Google-Smtp-Source: APXvYqzQcVYeTWjHA1GWGzWT8t1uQvHdWafbFrs+4Z6lMpSEOoB6AeGNhvySvnNsjv4Ja2SRnIzC+n5UdJycZzPB+WQ=
X-Received: by 2002:a24:7897:: with SMTP id p145mr6524450itc.117.1557474719408;
 Fri, 10 May 2019 00:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
 <20190509200633.19678-1-daniel.vetter@ffwll.ch> <20190510055053.GA9864@jagdpanzerIV>
In-Reply-To: <20190510055053.GA9864@jagdpanzerIV>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 10 May 2019 09:51:48 +0200
Message-ID: <CAKMK7uG2mLg=FDb_4oiXLY7y85WOrCoe4+VrXScuLD0bRuvBNA@mail.gmail.com>
Subject: Re: [PATCH] kernel/locking/semaphore: use wake_q in up()
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
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

On Fri, May 10, 2019 at 7:50 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (05/09/19 22:06), Daniel Vetter wrote:
> [..]
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
> >
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
>
> So the new code still can printk/WARN under sem->lock in some buggy
> cases.
>
> E.g.
>         wake_q_add()
>          get_task_struct()
>           refcount_inc_checked()
>            WARN_ONCE()
>
> Are we fine with that?

Hm not great. It's not as bad as the one I'm trying to fix (or not the
same at least), because with the wake up chain we have a few locks in
there. Which allows lockdep to connect the loop and complain, even
when we never actually hit that specific recursion. I.e. once hitting
a WARN_ON from try_to_wake_up is enough, plus a totally separate
callchain can then close the semaphore.lock->scheduler locks part.
Your chain only goes boom if it happens from the console_lock's up.

wake_q_add_safe would be an option, but then we somehow need to
arrange for down to call get_task_struct(current) and releasing that,
but only if there's no waker who needs that task ref. Sounds tricky
... Also not sure we want to stuff that trickery into the generic
semaphore code.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
