Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80127C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A6920989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEIMV2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:21:28 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51566 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726448AbfEIMV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:21:27 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16502409-1500050 
        for multiple; Thu, 09 May 2019 13:21:24 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
Message-ID: <155740448210.28545.914918106077410179@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
Date:   Thu, 09 May 2019 13:21:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2019-05-09 13:09:03)
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
> 
> Also cc'ing John Ogness since perhaps his printk rework fixes this all
> properly.
> 
> v2: Ditch attempt to fix console_trylock.
> 
> v3: Add a comment explaining why the taks we're waking won't
> disappear (Chris), and improve commit message to address review
> questions.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'm a bit nervous about that this is only safe for the precisely
controlled conditions, but then again that it is called printk_safe
should deter any other users.

The logic checks out, and you convinced me that the dereference is
protected, so
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
