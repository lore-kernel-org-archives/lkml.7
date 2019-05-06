Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8035FC04AAE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC25205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEFHsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:48:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbfEFHsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:48:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5F40AE27;
        Mon,  6 May 2019 07:48:09 +0000 (UTC)
Date:   Mon, 6 May 2019 09:48:09 +0200
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC: console: hack up console_trylock more
Message-ID: <20190506074809.huawsdaynyci5kwz@pathway.suse.cz>
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
 <20190503151437.dc2ty2mnddabrz4r@pathway.suse.cz>
 <CAKMK7uF8AD6033_tJw1Y7VsAXb6OD_syZtG3a-JM2g9eEb-P9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uF8AD6033_tJw1Y7VsAXb6OD_syZtG3a-JM2g9eEb-P9g@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-05-06 09:11:37, Daniel Vetter wrote:
> On Fri, May 3, 2019 at 5:14 PM Petr Mladek <pmladek@suse.com> wrote:
> > On Thu 2019-05-02 16:16:43, Daniel Vetter wrote:
> > > console_trylock, called from within printk, can be called from pretty
> > > much anywhere. Including try_to_wake_up. Note that this isn't common,
> > > usually the box is in pretty bad shape at that point already. But it
> > > really doesn't help when then lockdep jumps in and spams the logs,
> > > potentially obscuring the real backtrace we're really interested in.
> > > One case I've seen (slightly simplified backtrace):
> > >
> > >  Call Trace:
> > >   <IRQ>
> > >   console_trylock+0xe/0x60
> > >   vprintk_emit+0xf1/0x320
> > >   printk+0x4d/0x69
> > >   __warn_printk+0x46/0x90
> > >   native_smp_send_reschedule+0x2f/0x40
> > >   check_preempt_curr+0x81/0xa0
> > >   ttwu_do_wakeup+0x14/0x220
> > >   try_to_wake_up+0x218/0x5f0
> > >   pollwake+0x6f/0x90
> > >   credit_entropy_bits+0x204/0x310
> > >   add_interrupt_randomness+0x18f/0x210
> > >   handle_irq+0x67/0x160
> > >   do_IRQ+0x5e/0x130
> > >   common_interrupt+0xf/0xf
> > >   </IRQ>
> > >
> > > This alone isn't a problem, but the spinlock in the semaphore is also
> > > still held while waking up waiters (up() -> __up() -> try_to_wake_up()
> > > callchain), which then closes the runqueue vs. semaphore.lock loop,
> > > and upsets lockdep, which issues a circular locking splat to dmesg.
> > > Worse it upsets developers, since we don't want to spam dmesg with
> > > clutter when the machine is dying already.
> > >
> > > Fix this by creating a __down_trylock which only trylocks the
> > > semaphore.lock. This isn't correct in full generality, but good enough
> > > for console_lock:
> > >
> > > - there's only ever one console_lock holder, we won't fail spuriously
> > >   because someone is doing a down() or up() while there's still room
> > >   (unlike other semaphores with count > 1).
> > >
> > > - console_unlock() has one massive retry loop, which will catch anyone
> > >   who races the trylock against the up(). This makes sure that no
> > >   printk lines will get lost. Making the trylock more racy therefore
> > >   has no further impact.
> >
> > To be honest, I do not see how this could solve the problem.
> >
> > The circular dependency is still there. If the new __down_trylock()
> > succeeds then console_unlock() will get called in the same context
> > and it will still need to call up() -> try_to_wake_up().
> >
> > Note that there are many other console_lock() callers that might
> > happen in parallel and might appear in the wait queue.
> 
> Hm right. It's very rare we hit this in our CI and I don't know how to
> repro otherwise, so just threw this out at the wall to see if it
> sticks. I'll try and come up with a new trick then.

Single messages are printed from scheduler via printk_deferred().
WARN() might be solved by introducing printk deferred context,
see the per-cpu variable printk_context.

Best Regards,
Petr
