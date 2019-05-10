Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2751C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7CD2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfEJJ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:28:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbfEJJ2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:28:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEE65AD9D;
        Fri, 10 May 2019 09:28:19 +0000 (UTC)
Date:   Fri, 10 May 2019 11:28:19 +0200
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
Subject: Re: [PATCH] kernel/locking/semaphore: use wake_q in up()
Message-ID: <20190510092819.elu4b7fcojzcek2q@pathway.suse.cz>
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
 <20190509200633.19678-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509200633.19678-1-daniel.vetter@ffwll.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-05-09 22:06:33, Daniel Vetter wrote:
> console_trylock, called from within printk, can be called from pretty
> much anywhere. Including try_to_wake_up. Note that this isn't common,
> usually the box is in pretty bad shape at that point already. But it
> really doesn't help when then lockdep jumps in and spams the logs,
> potentially obscuring the real backtrace we're really interested in.
> One case I've seen (slightly simplified backtrace):
> 
> Fix this specific locking recursion by moving the wake_up_process out
> from under the semaphore.lock spinlock, using wake_q as recommended by
> Peter Zijlstra.

It might make sense to mention also the optimization effect mentioned
by Peter.

> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> index 561acdd39960..7a6f33715688 100644
> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -169,6 +169,14 @@ int down_timeout(struct semaphore *sem, long timeout)
>  }
>  EXPORT_SYMBOL(down_timeout);
>  
> +/* Functions for the contended case */
> +
> +struct semaphore_waiter {
> +	struct list_head list;
> +	struct task_struct *task;
> +	bool up;
> +};
> +
>  /**
>   * up - release the semaphore
>   * @sem: the semaphore to release
> @@ -179,24 +187,25 @@ EXPORT_SYMBOL(down_timeout);
>  void up(struct semaphore *sem)
>  {
>  	unsigned long flags;
> +	struct semaphore_waiter *waiter;
> +	DEFINE_WAKE_Q(wake_q);

We need to call wake_q_init(&wake_q) to make sure that
it is empty.

Best Regards,
Petr

>  	raw_spin_lock_irqsave(&sem->lock, flags);
> -	if (likely(list_empty(&sem->wait_list)))
> +	if (likely(list_empty(&sem->wait_list))) {
>  		sem->count++;
> -	else
> -		__up(sem);
> +	} else {
> +		waiter =  list_first_entry(&sem->wait_list,
> +					   struct semaphore_waiter, list);
> +		list_del(&waiter->list);
> +		waiter->up = true;
> +		wake_q_add(&wake_q, waiter->task);
> +	}
>  	raw_spin_unlock_irqrestore(&sem->lock, flags);
> +
> +	wake_up_q(&wake_q);
>  }
>  EXPORT_SYMBOL(up);
>  
> -/* Functions for the contended case */
> -
> -struct semaphore_waiter {
> -	struct list_head list;
> -	struct task_struct *task;
> -	bool up;
> -};
> -
>  /*
>   * Because this function is inlined, the 'state' parameter will be
>   * constant, and thus optimised away by the compiler.  Likewise the
