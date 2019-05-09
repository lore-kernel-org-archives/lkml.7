Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E1C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E620920989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEIPIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:08:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfEIPIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:08:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF88EAC58;
        Thu,  9 May 2019 15:08:48 +0000 (UTC)
Date:   Thu, 9 May 2019 17:08:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] RFC: console: hack up console_lock more v2
Message-ID: <20190509150848.dj5kb47iuz5tcmso@pathway.suse.cz>
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
 <20190506074553.21464-1-daniel.vetter@ffwll.ch>
 <20190506081614.b7b22k4prodskbiy@pathway.suse.cz>
 <20190506082628.wehkislebljxmk5d@pathway.suse.cz>
 <20190506093812.GG17751@phenom.ffwll.local>
 <20190506112448.rng2oefmp2c262dq@pathway.suse.cz>
 <20190508081712.GQ17751@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508081712.GQ17751@phenom.ffwll.local>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-05-08 10:17:12, Daniel Vetter wrote:
> On Mon, May 06, 2019 at 01:24:48PM +0200, Petr Mladek wrote:
> > On Mon 2019-05-06 11:38:13, Daniel Vetter wrote:
> > > On Mon, May 06, 2019 at 10:26:28AM +0200, Petr Mladek wrote:
> > > > On Mon 2019-05-06 10:16:14, Petr Mladek wrote:
> > > > > On Mon 2019-05-06 09:45:53, Daniel Vetter wrote:
> > > > > > console_trylock, called from within printk, can be called from pretty
> > > > > > much anywhere. Including try_to_wake_up. Note that this isn't common,
> > > > > > usually the box is in pretty bad shape at that point already. But it
> > > > > > really doesn't help when then lockdep jumps in and spams the logs,
> > > > > > potentially obscuring the real backtrace we're really interested in.
> > > > > > One case I've seen (slightly simplified backtrace):
> > > > > > 
> > > > > >  Call Trace:
> > > > > >   <IRQ>
> > > > > >   console_trylock+0xe/0x60
> > > > > >   vprintk_emit+0xf1/0x320
> > > > > >   printk+0x4d/0x69
> > > > > >   __warn_printk+0x46/0x90
> > > > > >   native_smp_send_reschedule+0x2f/0x40
> > > > > >   check_preempt_curr+0x81/0xa0
> > > > > >   ttwu_do_wakeup+0x14/0x220
> > > > > >   try_to_wake_up+0x218/0x5f0
> > > > > 
> > > > > try_to_wake_up() takes p->pi_lock. It could deadlock because it
> > > > > can get called recursively from printk_safe_up().
> > > > > 
> > > > > And there are more locks taken from try_to_wake_up(), for example,
> > > > > __task_rq_lock() taken from ttwu_remote().
> > > > > 
> > > > > IMHO, the most reliable solution would be do call the entire
> > > > > up_console_sem() from printk deferred context. We could assign
> > > > > few bytes for this context in the per-CPU printk_deferred
> > > > > variable.
> > > > 
> > > > Ah, I was too fast and did the same mistake. This won't help because
> > > > it would still call try_to_wake_up() recursively.
> > > 
> > > Uh :-/
> > > 
> > > > We need to call all printk's that can be called under locks
> > > > taken in try_to_wake_up() path in printk deferred context.
> > > > Unfortunately it is whack a mole approach.
> > > 
> > > Hm since it's whack-a-mole anyway, what about converting the WARN_ON into
> > > a prinkt_deferred, like all the other scheduler related code? Feels a
> > > notch more consistent to me than leaking the printk_context into areas it
> > > wasn't really meant built for. Scheduler code already fully subscribed to
> > > the whack-a-mole approach after all.
> > 
> > I am not sure how exactly you mean the conversion.
> > 
> > Anyway, we do not want to use printk_deferred() treewide. It reduces
> > the chance that the messages reach consoles. Scheduler is an
> > exception because of the possible deadlocks.
> > 
> > A solution would be to define WARN_ON_DEFERRED() that would
> > call normal WARN_ON() in printk deferred context and
> > use in scheduler.
> 
> Sent it out, and then Sergey pointed out printk_safe_enter/exit (which I
> guess is what you meant, and which I missed)

No, I meant introducing a deferred printk context that would behave
like printk_deferred().

printk safe context is more limiting. It prevents deadlock on
logbuf_lock by temporary saving the messages into per-CPU
buffers.

In scheduler, we could store the messages directly into
the main log buffer. We just need to deffer the console
handling to avoid deadlock on the scheduler locks.

> , but we're doing this already around the up() call
> in __up_console_sem.
>
> So I think these further recursions you're pointed out are already handled
> correctly, and all we need to do is to break the loop involving
> semaphore.lock of the console_lock semaphore only. Which I think this
> patch here achieves.

printk safe context would help only when try_to_wake_up()
and all other functions using the same locks _all over
the system_ are called printk safe (or deferred) context.

By other words, printk safe context solves only printk()
recursion. It does not solve recursion of the scheduler
operations.

Best Regards,
Petr
