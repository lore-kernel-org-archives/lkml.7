Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA9DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D45920644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEIO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:56:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:56440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfEIO4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:56:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60010AC9C;
        Thu,  9 May 2019 14:56:21 +0000 (UTC)
Date:   Thu, 9 May 2019 16:56:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
Message-ID: <20190509145620.2pjqko7copbxuzth@pathway.suse.cz>
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-05-09 14:09:03, Daniel Vetter wrote:
> console_trylock, called from within printk, can be called from pretty
> much anywhere. Including try_to_wake_up. Note that this isn't common,
> usually the box is in pretty bad shape at that point already. But it
> really doesn't help when then lockdep jumps in and spams the logs,
> potentially obscuring the real backtrace we're really interested in.
> One case I've seen (slightly simplified backtrace):
> 
>  Call Trace:
>   <IRQ>
>   console_trylock+0xe/0x60
>   vprintk_emit+0xf1/0x320
>   printk+0x4d/0x69
>   __warn_printk+0x46/0x90
>   native_smp_send_reschedule+0x2f/0x40
>   check_preempt_curr+0x81/0xa0
>   ttwu_do_wakeup+0x14/0x220
>   try_to_wake_up+0x218/0x5f0
>   pollwake+0x6f/0x90
>   credit_entropy_bits+0x204/0x310
>   add_interrupt_randomness+0x18f/0x210
>   handle_irq+0x67/0x160
>   do_IRQ+0x5e/0x130
>   common_interrupt+0xf/0xf
>   </IRQ>
> 
> This alone isn't a problem, but the spinlock in the semaphore is also
> still held while waking up waiters (up() -> __up() -> try_to_wake_up()
> callchain), which then closes the runqueue vs. semaphore.lock loop,
> and upsets lockdep, which issues a circular locking splat to dmesg.
> Worse it upsets developers, since we don't want to spam dmesg with
> clutter when the machine is dying already.
> 
> Fix this by creating a prinkt_safe_up() which calls wake_up_process
> outside of the spinlock. This isn't correct in full generality, but
> good enough for console_lock:
> 
> - console_lock doesn't use interruptible or killable or timeout down()
>   calls, hence an up() is the only thing that can wake up a process.
>   Hence the process can't get woken and killed and reaped while we try
>   to wake it up too.
> 
> - semaphore.c always updates the waiter list while under the spinlock,
>   so there's no other races. Specifically another process that races
>   with a quick console_lock/unlock while we've dropped the spinlock
>   already won't see our own waiter.
> 
> Note that we only have to break the recursion for the semaphore.lock
> spinlock of the console_lock. Recursion within various scheduler
> related locks is already prevented by the printk_safe_enter/exit pair
> in __up_console_sem().

This is not fully true. printk_safe() helps only when
the first try_to_wake_up() is called from printk_safe() context.

> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -197,6 +197,37 @@ struct semaphore_waiter {
>  	bool up;
>  };
>  
> +/**
> + * printk_safe_up - release the semaphore in console_unlock
> + * @sem: the semaphore to release
> + *
> + * Release the semaphore.  Unlike mutexes, up() may be called from any
> + * context and even by tasks which have never called down().
> + *
> + * NOTE: This is a special version of up() for console_unlock only. It is only
> + * safe if there are no killable, interruptible or timing out down() calls.
> + */
> +void printk_safe_up(struct semaphore *sem)
> +{
> +	unsigned long flags;
> +	struct semaphore_waiter *waiter = NULL;
> +
> +	raw_spin_lock_irqsave(&sem->lock, flags);
> +	if (likely(list_empty(&sem->wait_list))) {
> +		sem->count++;
> +	} else {
> +		waiter = list_first_entry(&sem->wait_list,
> +					  struct semaphore_waiter, list);
> +		list_del(&waiter->list);
> +		waiter->up = true;
> +	}
> +	raw_spin_unlock_irqrestore(&sem->lock, flags);
> +
> +	if (waiter) /* protected by being sole wake source */
> +		wake_up_process(waiter->task);

I still do not see how this could help. Let's take the above
backtrace as example:

   <IRQ>
   console_trylock+0xe/0x60
   vprintk_emit+0xf1/0x320
   printk+0x4d/0x69
   __warn_printk+0x46/0x90
   native_smp_send_reschedule +0x2f/0x40
   check_preempt_curr+0x81/0xa0
   ttwu_do_wakeup+0x14/0x220
   try_to_wake_up+0x218/0x5f0
   pollwake+0x6f/0x90
   credit_entropy_bits+0x204/0x310
   add_interrupt_randomness+0x18f/0x210
   handle_irq+0x67/0x160
   do_IRQ+0x5e/0x130
   common_interrupt+0xf/0xf
   </IRQ>

We have the following chain of calls:

  + do_IRQ()
    ...
      + try_to_wake_up()    # takes p->pi_lock
        + ttwu_remote()     # takes rq lock
          + ttwu_do_wakeup()
	    + check_preempt_curr()
	      + native_smp_send_reschedule()
	        + __warn_printk()
		  + printk()
		    + vprintk_emit()
		      + console_trylock() # success
		      + console_unlock()
		        + up_console_sem()
			  + up() # wait list in not empty
			    + __up()
			      + wake_up_process()
			        + try_to_wake_up()

!BANG! Deadlock on p->pi_lock.

It does not matter if the nested try_to_wake_up() was called
under sem->lock or outside.

By other words. The patch removed one lockdep warning. But it just
just delayed the deadlock. It will not happen on sem->lock but
later on p->pi_lock.

I am repeating myself. But IMHO, the only solution is to introduce
printk deferred context and use it in WARN_DEFERRED().

Best Regards,
Petr
