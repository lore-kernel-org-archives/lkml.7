Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A2C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D129B2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WXWvm+RM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEINGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:06:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56125 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEINGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:06:22 -0400
Received: by mail-it1-f194.google.com with SMTP id q132so3375427itc.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDHzEizTc5iYLRPdBf/FVK/yUV4INbU48OdqJ7lgHxc=;
        b=WXWvm+RMP8NWmdvwirguzLRMlo+T+wAS5vXiS2fbQKs74buNlCr+k7I546dBLsEZc/
         LBmc0l/tnX6mJ96HeTxICfz3t18xxx+PAJXHxj0y54oTetc7vgB5iHzRcjiLuc4hKaeT
         ovGlHzI33mWXaOz4AbjxIh4hQis+oJ0alNYaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDHzEizTc5iYLRPdBf/FVK/yUV4INbU48OdqJ7lgHxc=;
        b=ody1HuRkivb030LJutsCzLXFHFi1eGywvkteIjij9z95P+jTTfO850d4RXBNz52f1M
         I7sV4EIYyxg5HCG8uniAP55FNwD3RnOwdpl08dwmpTHpBh2PKjoyMWhSKctx1BmR/TPU
         nxiOnhJu983yYybJOirHH4+XsbYjUg6OTSGMrSfF5GyQNFNvyd7cVuhuKrO/o3/jDkOY
         yf8XMZ3aJBol/fXuPMnJtnKECDDolLPWZnidnavVGmC2IrsKDh6uUhMfb5hBQCAxH6jL
         g1wMMBKCGoVJIuCp5pm/zQTT/JjsAXiIZ898YsJCQ1xPJ2b/d5MfBT8m2FgmzSejwuuL
         tTeg==
X-Gm-Message-State: APjAAAX5ZjzWXSK8u04SuVR9Jc+Dxgl3y/x/8z4aqZCFUhhFdQCfP8Q3
        Tvb0BVTYSQNdseCX98EAgw4q9N/uxPs51hFzyB7W9w==
X-Google-Smtp-Source: APXvYqzco7FbWnVDpFWTkfbz0x/u3/OfHmcn73ope1/ooZAPUgdjq7jqDiQtXid8yC/d607ANdpIgxNbYDXtfmQZiYw=
X-Received: by 2002:a05:660c:6c8:: with SMTP id z8mr1720655itk.51.1557407181048;
 Thu, 09 May 2019 06:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch> <20190509123104.GQ2589@hirez.programming.kicks-ass.net>
In-Reply-To: <20190509123104.GQ2589@hirez.programming.kicks-ass.net>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 9 May 2019 15:06:09 +0200
Message-ID: <CAKMK7uGuOFGEuw1m_fiBfGbAEY0eeoDEFtP7Htt8-RCzD66MGw@mail.gmail.com>
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
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

On Thu, May 9, 2019 at 2:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, May 09, 2019 at 02:09:03PM +0200, Daniel Vetter wrote:
> > Fix this by creating a prinkt_safe_up() which calls wake_up_process
> > outside of the spinlock. This isn't correct in full generality, but
> > good enough for console_lock:
> >
> > - console_lock doesn't use interruptible or killable or timeout down()
> >   calls, hence an up() is the only thing that can wake up a process.
>
> Wrong :/ Any task can be woken at any random time. We must, at all
> times, assume spurious wakeups will happen.

Out of curiosity, where do these come from? I know about the races
where you need to recheck on the waiter side to avoid getting stuck,
but didn't know about this. Are these earlier (possibly spurious)
wakeups that got held up and delayed for a while, then hit the task
much later when it's already continued doing something else? Or even
more random, and even if I never put a task on a wait list or anything
else, ever, it can get woken spuriously?

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
> > +}
> > +EXPORT_SYMBOL(printk_safe_up);
>
> Since its only used from printk, that EXPORT really isn't needed.
>
> Something like the below might work.

Yeah that looks like the proper fix. I guess semaphores are uncritical
enough that we can roll this out for everyone. Thanks for the hint.
-Daniel

>
> ---
>  kernel/locking/semaphore.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> index 561acdd39960..ac0a67e95aac 100644
> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -38,7 +38,6 @@ static noinline void __down(struct semaphore *sem);
>  static noinline int __down_interruptible(struct semaphore *sem);
>  static noinline int __down_killable(struct semaphore *sem);
>  static noinline int __down_timeout(struct semaphore *sem, long timeout);
> -static noinline void __up(struct semaphore *sem);
>
>  /**
>   * down - acquire the semaphore
> @@ -178,14 +177,24 @@ EXPORT_SYMBOL(down_timeout);
>   */
>  void up(struct semaphore *sem)
>  {
> +       struct semaphore_waiter *waiter;
> +       DEFINE_WAKE_Q(wake_q);
>         unsigned long flags;
>
>         raw_spin_lock_irqsave(&sem->lock, flags);
> -       if (likely(list_empty(&sem->wait_list)))
> +       if (likely(list_empty(&sem->wait_list))) {
>                 sem->count++;
> -       else
> -               __up(sem);
> +               goto unlock;
> +       }
> +
> +       waiter = list_first_entry(&sem->wait_list, struct semaphore_waiter, list);
> +       list_del(&waiter->list);
> +       waiter->up = true;
> +       wake_q_add(&wake_q, waiter->task);
> +unlock:
>         raw_spin_unlock_irqrestore(&sem->lock, flags);
> +
> +       wake_up_q(&wake_q);
>  }
>  EXPORT_SYMBOL(up);
>
> @@ -252,12 +261,3 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
>  {
>         return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
>  }
> -
> -static noinline void __sched __up(struct semaphore *sem)
> -{
> -       struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
> -                                               struct semaphore_waiter, list);
> -       list_del(&waiter->list);
> -       waiter->up = true;
> -       wake_up_process(waiter->task);
> -}



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
