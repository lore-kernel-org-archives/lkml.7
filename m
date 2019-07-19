Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55BC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2CA21851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfGSM54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:57:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfGSM54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:57:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32DF7AB9D;
        Fri, 19 Jul 2019 12:57:54 +0000 (UTC)
Date:   Fri, 19 Jul 2019 14:57:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk/panic: Access the main printk log in panic()
 only when safe
Message-ID: <20190719125753.miniwfq4nhicy76n@pathway.suse.cz>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
 <20190717095615.GD3664@jagdpanzerIV>
 <20190718083629.nso3vwbvmankqgks@pathway.suse.cz>
 <20190718094934.GA10041@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718094934.GA10041@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-07-18 18:49:34, Sergey Senozhatsky wrote:
> On (07/18/19 10:36), Petr Mladek wrote:
> > On Wed 2019-07-17 18:56:15, Sergey Senozhatsky wrote:
> > > On (07/16/19 09:28), Petr Mladek wrote:
> > > > Kernel tries hard to store and show printk messages when panicking. Even
> > > > logbuf_lock gets re-initialized when only one CPU is running after
> > > > smp_send_stop().
> > > > 
> > > > Unfortunately, smp_send_stop() might fail on architectures that do not
> > > > use NMI as a fallback. Then printk log buffer might stay locked and
> > > > a deadlock is almost inevitable.
> > > 
> > > I'd say that deadlock is still almost inevitable.
> > > 
> > > panic-CPU syncs with the printing-CPU before it attempts to SMP_STOP.
> > > If there is an active printing-CPU, which is looping in console_unlock(),
> > > taking logbuf_lock in order to msg_print_text() and stuff, then panic-CPU
> > > will spin on console_owner waiting for that printing-CPU to handover
> > > printing duties.
> > > 
> > > 	pr_emerg("Kernel panic - not syncing");
> > > 	smp_send_stop();
> > 
> > Good point. I forgot the handover logic. Well, it is enabled only
> > around call_console_drivers(). Therefore it is not under
> > lockbuf_lock.
> > 
> > I had in mind some infinite loop or deadlock in vprintk_store().
> > There was at least one long time ago (warning triggered
> > by leap second).
> > 
> > 
> > > If printing-CPU goes nuts under logbuf_lock, has corrupted IDT or anything
> > > else, then we will not progress with panic(). panic-CPU will deadlock. If
> > > not on
> > > 	pr_emerg("Kernel panic - not syncing")
> > > 
> > > then on another pr_emerg(), right before the NMI-fallback.
> > 
> > Nested printk() should not be problem thanks to printk_safe.
> 
> Where do nested printk()-s come from? Which one of the following
> scenarios you cover in commit message:
> 
> scenario 1
> 
> - we have CPUB which holds logbuf_lock
> - we have CPUA which panic()-s the system, but can't bring CPUB down,
>   so logbuf_lock stays locked on remote CPU

No, this scenario is not affected by this patch. It would always lead to
a deadlock.

> scenario 2
> 
> - we have CPUA which holds logbuf_lock
> - we have panic() on CPUA, but it cannot bring down some other CPUB
>   so logbuf_lock stays locked on local CPU, and it cannot re-init
>   logbuf.

This scenario should get better handled by this patch. The difference
will be when smp_send_stop() is not able to stop all CPUs:

  + Before:
      + printk_safe_flush_on_panic() will keep logbuf_lock locked
	and do nothing.

      + kmsg_dump(), console_unblank(), or console_flush_on_panic()
	will deadlock when they try to get logbuf_lock(). They will
	not be able to process any single line.

  + After:
      + printk_bust_lock_safe() will keep logbuf_lock locked

      + All functions using logbuf_lock will not get called.
	We will not see the messages (as previously) but the
	system will not deadlock.


But there is one more scenario 3:

  - we have CPUB which loops or is deadlocked in IRQ context

  - we have CPUA which panic()-s the system, but can't bring CPUB down,
    so logbuf_lock might be takes and release from time to time
    by CPUB

Hmm, this scenario might be handled a bit _worse_ by this patch:

  + Before:
      + printk_safe_flush_on_panic() will not touch logbuf_lock
	The messages will get flushed according to the state of
	logbuf_lock at the moment when it is being checked.

      + kmsg_dump(), console_unblank(), or console_flush_on_panic()
	will be able to do their job.

  + After:
      +  printk_safe_flush_on_panic(), kmsg_dump(), console_unblank(),
	 and console_flush_on_panic() could finish the job. But they
	 will get called _only_ when logbuf_lock is released at
	 the moment when it is being checked by printk_bust_lock_safe().


Resume:

From my POV, the 3rd scenario is the most likely one. Therefore this
patch would make more bad than good.

It might be possible to somehow detect if lockbuf_lock is released
from time the time on the non-stopped CPU. But it would be hairy.
IMHO, it is not worth it.

Thanks a lot for helping me to sort the ideas. I suggest to forget
this patch and work on lockless ringbuffer.

Best Regards,
Petr
