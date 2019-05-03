Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799F4C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508E7205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfECPOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:14:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:51814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbfECPOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:14:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71469ACFA;
        Fri,  3 May 2019 15:14:38 +0000 (UTC)
Date:   Fri, 3 May 2019 17:14:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: console: hack up console_trylock more
Message-ID: <20190503151437.dc2ty2mnddabrz4r@pathway.suse.cz>
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-05-02 16:16:43, Daniel Vetter wrote:
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
> Fix this by creating a __down_trylock which only trylocks the
> semaphore.lock. This isn't correct in full generality, but good enough
> for console_lock:
> 
> - there's only ever one console_lock holder, we won't fail spuriously
>   because someone is doing a down() or up() while there's still room
>   (unlike other semaphores with count > 1).
>
> - console_unlock() has one massive retry loop, which will catch anyone
>   who races the trylock against the up(). This makes sure that no
>   printk lines will get lost. Making the trylock more racy therefore
>   has no further impact.

To be honest, I do not see how this could solve the problem.

The circular dependency is still there. If the new __down_trylock()
succeeds then console_unlock() will get called in the same context
and it will still need to call up() -> try_to_wake_up().

Note that there are many other console_lock() callers that might
happen in parallel and might appear in the wait queue.

Best Regards,
Petr
