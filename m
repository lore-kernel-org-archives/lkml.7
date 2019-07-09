Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416E7C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EFA21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy+sZ9y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfGIBVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:21:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41224 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfGIBVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:21:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id v22so14835434qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 18:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJPLJFRZklumgGo3UfXbE2D4rwEid6onhitxhpd4hh4=;
        b=Sy+sZ9y0lUCQsiBVdC82Iyar/i/QOx6oIduzGqS12UVNAXi9Gw/OxdAQgBtaBzcohy
         B/xcGDfquUTGkHunoAEhaRERlWoRWCXKof8Oqo8roVztKSW6eztwPg/kyBOI0gGBsf0Y
         7iFtBjaj3M4bPfOYh1VGhLMUhFL7lOF5iVlmsAQMncFCjVB2CrdNE4WK5gNCohjyZ6N+
         7gF2SvZTPCtNH16Xb28jTtz2+c8bGdg3yM4em64nWfpnYVmnVdy4OceJdYs0MSVWWrKR
         Byt/IX85rYAStpm+Yo+UO1Ea4cBd0/eHAZkaRaexmddFifh75efBa20GVfujDxkyo90j
         4EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJPLJFRZklumgGo3UfXbE2D4rwEid6onhitxhpd4hh4=;
        b=JlItuE5rn+FS5lN7KRA70HJwe4qMbCDLmu69hFL2AQnXtOLVKiSGp5qrw2Itw0y/Kh
         wi2JFT+iPMKgzuEHVu3DgkvO7HQ3e9oluxqwi9MPxlwxYMf9UJ7Pb6vYCRh2pK6YzCTH
         b2hWDNujtlXI47mrraklbRqOQPxkgsMA8taJm+ApvlwjkCozG13s7D6Lqet5mT1pkyhP
         Z4EKzTogqig7xoFxX0l0FF+cFvoefwWGEP8A6teGJr4Uc7letHm2GGFshFesHCOtPvz2
         Q7cLFcYCUfE42x+BGzfhHAmWYLVWV0dY4S6MYEW+aOV+6okRMqU11maWuAnY2JKq/OH2
         jn3A==
X-Gm-Message-State: APjAAAUBlWArhtKHAPnkyMf88k8B0k43nEOuWkFITRJaqm5E3CGF8M4p
        nWF+sLODGwI506WyjjD6OTczEJ5PKTYydbf+mUVE3a+i8gfsaQ==
X-Google-Smtp-Source: APXvYqwH+h9ZD/IJ/stDbLxYjtc817038rjfrRjrSc6Le6e5PvkHv+JQEXhBxCxMCd0lXU0mKZYoycck0m+saHw76uo=
X-Received: by 2002:a37:6b87:: with SMTP id g129mr16430203qkc.305.1562635305406;
 Mon, 08 Jul 2019 18:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190610055258.6424-1-duyuyang@gmail.com> <1562607152.8510.5.camel@lca.pw>
In-Reply-To: <1562607152.8510.5.camel@lca.pw>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Tue, 9 Jul 2019 09:21:34 +0800
Message-ID: <CAHttsrbQuHYEYYgx+c7-Q=ffPxoqRQ1PfZ5bhWNhuMAeR9LvuQ@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Fix lock IRQ usage initialization bug
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem should have been fixed with this in that pull:

locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS &&
CONFIG_PROVE_LOCKING

and this is a better fix than mine.

Thanks,
Yuyang

On Tue, 9 Jul 2019 at 01:32, Qian Cai <cai@lca.pw> wrote:
>
> I saw Ingo send a pull request to Linus for 5.3 [1] includes the offensive
> commit "locking/lockdep: Consolidate lock usage bit initialization" but did not
> include this patch.
>
> [1] https://lore.kernel.org/lkml/20190708093516.GA57558@gmail.com/
>
> On Mon, 2019-06-10 at 13:52 +0800, Yuyang Du wrote:
> > The commit:
> >
> >   091806515124b20 ("locking/lockdep: Consolidate lock usage bit
> > initialization")
> >
> > misses marking LOCK_USED flag at IRQ usage initialization when
> > CONFIG_TRACE_IRQFLAGS
> > or CONFIG_PROVE_LOCKING is not defined. Fix it.
> >
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> > ---
> >  kernel/locking/lockdep.c | 110 +++++++++++++++++++++++-----------------------
> > -
> >  1 file changed, 53 insertions(+), 57 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 48a840a..c3db987 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3460,9 +3460,61 @@ void trace_softirqs_off(unsigned long ip)
> >               debug_atomic_inc(redundant_softirqs_off);
> >  }
> >
> > +static inline unsigned int task_irq_context(struct task_struct *task)
> > +{
> > +     return 2 * !!task->hardirq_context + !!task->softirq_context;
> > +}
> > +
> > +static int separate_irq_context(struct task_struct *curr,
> > +             struct held_lock *hlock)
> > +{
> > +     unsigned int depth = curr->lockdep_depth;
> > +
> > +     /*
> > +      * Keep track of points where we cross into an interrupt context:
> > +      */
> > +     if (depth) {
> > +             struct held_lock *prev_hlock;
> > +
> > +             prev_hlock = curr->held_locks + depth-1;
> > +             /*
> > +              * If we cross into another context, reset the
> > +              * hash key (this also prevents the checking and the
> > +              * adding of the dependency to 'prev'):
> > +              */
> > +             if (prev_hlock->irq_context != hlock->irq_context)
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
> > +
> > +static inline
> > +int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
> > +             enum lock_usage_bit new_bit)
> > +{
> > +     WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
> > +     return 1;
> > +}
> > +
> > +static inline unsigned int task_irq_context(struct task_struct *task)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline int separate_irq_context(struct task_struct *curr,
> > +             struct held_lock *hlock)
> > +{
> > +     return 0;
> > +}
> > +
> > +#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
> > +
> >  static int
> >  mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
> >  {
> > +#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
> >       if (!check)
> >               goto lock_used;
> >
> > @@ -3510,6 +3562,7 @@ void trace_softirqs_off(unsigned long ip)
> >       }
> >
> >  lock_used:
> > +#endif
> >       /* mark it as used: */
> >       if (!mark_lock(curr, hlock, LOCK_USED))
> >               return 0;
> > @@ -3517,63 +3570,6 @@ void trace_softirqs_off(unsigned long ip)
> >       return 1;
> >  }
> >
> > -static inline unsigned int task_irq_context(struct task_struct *task)
> > -{
> > -     return 2 * !!task->hardirq_context + !!task->softirq_context;
> > -}
> > -
> > -static int separate_irq_context(struct task_struct *curr,
> > -             struct held_lock *hlock)
> > -{
> > -     unsigned int depth = curr->lockdep_depth;
> > -
> > -     /*
> > -      * Keep track of points where we cross into an interrupt context:
> > -      */
> > -     if (depth) {
> > -             struct held_lock *prev_hlock;
> > -
> > -             prev_hlock = curr->held_locks + depth-1;
> > -             /*
> > -              * If we cross into another context, reset the
> > -              * hash key (this also prevents the checking and the
> > -              * adding of the dependency to 'prev'):
> > -              */
> > -             if (prev_hlock->irq_context != hlock->irq_context)
> > -                     return 1;
> > -     }
> > -     return 0;
> > -}
> > -
> > -#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
> > -
> > -static inline
> > -int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
> > -             enum lock_usage_bit new_bit)
> > -{
> > -     WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
> > -     return 1;
> > -}
> > -
> > -static inline int
> > -mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
> > -{
> > -     return 1;
> > -}
> > -
> > -static inline unsigned int task_irq_context(struct task_struct *task)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline int separate_irq_context(struct task_struct *curr,
> > -             struct held_lock *hlock)
> > -{
> > -     return 0;
> > -}
> > -
> > -#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
> > -
> >  /*
> >   * Mark a lock with a usage bit, and validate the state transition:
> >   */
