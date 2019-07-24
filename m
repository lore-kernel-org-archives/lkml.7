Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064B3C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD5D21BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfGXM1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:27:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:58928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfGXM1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:27:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 296BDAFE1;
        Wed, 24 Jul 2019 12:27:12 +0000 (UTC)
Date:   Wed, 24 Jul 2019 14:27:11 +0200
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
Message-ID: <20190724122711.qquevkcuge24bhdd@pathway.suse.cz>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
 <20190717095615.GD3664@jagdpanzerIV>
 <20190718083629.nso3vwbvmankqgks@pathway.suse.cz>
 <20190718094934.GA10041@jagdpanzerIV>
 <20190719125753.miniwfq4nhicy76n@pathway.suse.cz>
 <20190723031340.GA19463@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723031340.GA19463@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-07-23 12:13:40, Sergey Senozhatsky wrote:
> On (07/19/19 14:57), Petr Mladek wrote:
> > But there is one more scenario 3:
> 
> Yes!
> 
> >   - we have CPUB which loops or is deadlocked in IRQ context
> > 
> >   - we have CPUA which panic()-s the system, but can't bring CPUB down,
> >     so logbuf_lock might be takes and release from time to time
> >     by CPUB
> 
> Great!
> 
> This is the only case when we actually need to pay attention to
> num_online_cpus(), because there is an active logbuf_lock owner;
> in any other case we can unconditionally re-init printk() locks.
> 
> But there is more to it.
> 
> Note, that the problem in scenario 3 is bigger than just logbuf_lock.
> Regardless of logbuf implementation we will not be able to panic()
> the system.
> 
> If we have a never ending source of printk() messages, coming from
> misbehaving CPU which stuck in printing loop in IRQ context, then
> flush_on_panic() will never end or kmsg dump will never stop, etc.

Yes.

> We need to cut off misbehaving CPUs. Panic CPU waits (for up to 1
> second?) in smp_send_stop() for secondary CPUs to die, if some
> secondary CPUs are still chatty after that then most likely those
> CPUs don't have anything good to say, just a pointless flood of same
> messages over and over again; which, however, will not let panic
> CPU to proceed.

Makes sense.

> And this is where the idea of "disconnecting" those CPUs from main
> logbuf come from.
> 
> So what we can do:
> - smp_send_stop()
> - disconnect all-but-self from logbuf (via printk-safe)

printk_safe is not really necessary. As you wrote, nobody
is interested into messages from CPUs that are supposed
to be stopped.

It might be enough to set some global variable, for example,
with the CPU number that is calling panic() and is the only
one allowed to print messages from this point on.

It might even be used to force console lock owner to leave
the cycle immediately.

> - wait for 1 or 2 more extra seconds for secondary CPUs to leave
>   console_unlock() and to redirect printks to per-CPU buffers
> - after that we are sort of good-to-go: re-init printk locks
>   and do kmsg_dump, flush_on_panic().

Sounds good.

> Note, misbehaving CPUs will write to per-CPU buffers, they are not
> expected to be able to flush per-CPU buffers to the main logbuf. That
> will require enabled IRQs, which should deliver stop IPI. But we can
> do even more - just disable print_safe irq work on disconnect CPUs.
>
> So, shall we try one more time with the "disconnect" misbehaving CPUs
> approach? I can send an RFC patch.

IMHO, it will be acceptable only when it is reasonably simple and
straightforward. The panic() code is full of special hacks and
it is already complicated to follow all the twists.

Especially because this scenario came up from a theoretical
discussion. Note that my original, real bug report, was
with logbuf_lock NMI, enabled kdump notifiers, ...

Best Regards,
Petr
