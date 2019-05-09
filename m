Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D8C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAA620644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEIKeG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:34:06 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57786 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbfEIKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:34:05 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16500941-1500050 
        for multiple; Thu, 09 May 2019 11:33:00 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190506074553.21464-1-daniel.vetter@ffwll.ch>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
 <20190506074553.21464-1-daniel.vetter@ffwll.ch>
Message-ID: <155739797736.28545.2942646931608459049@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH] RFC: console: hack up console_lock more v2
Date:   Thu, 09 May 2019 11:32:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2019-05-06 08:45:53)
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
> +       unsigned long flags;
> +       struct semaphore_waiter *waiter = NULL;
> +
> +       raw_spin_lock_irqsave(&sem->lock, flags);
> +       if (likely(list_empty(&sem->wait_list))) {
> +               sem->count++;
> +       } else {
> +               waiter = list_first_entry(&sem->wait_list,
> +                                         struct semaphore_waiter, list);
> +               list_del(&waiter->list);
> +               waiter->up = true;
> +       }
> +       raw_spin_unlock_irqrestore(&sem->lock, flags);
> +
> +       if (waiter)
> +               wake_up_process(waiter->task);

From comparing against __down_common() there's a risk here that as soon
as waiter->up == true, the waiter may complete and make the onstack
struct semaphore_waiter invalid. If you store waiter->task locally under
the spinlock that problem is resolved.

Then there is the issue of an unprotected dereference of the task in
wake_up_process() -- I think you can wrap this function with
rcu_read_lock() to keep that safe, and wake_up_process() should be a
no-op if it races against process termination.
-Chris
