Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3862173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfGSMTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:19:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfGSMTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:19:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0683FAF37;
        Fri, 19 Jul 2019 12:19:09 +0000 (UTC)
Date:   Fri, 19 Jul 2019 14:19:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] printk/panic/x86: Allow to access printk log buffer
 after crash_smp_send_stop()
Message-ID: <20190719121907.4hrfp4dxdhtjygbi@pathway.suse.cz>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-3-pmladek@suse.com>
 <20190718104756.GA22851@jagdpanzerIV>
 <CALYGNiMnqUKxKsY1JRi075xs-P_QzfA4Pg3XANiW0mFYkp_RQQ@mail.gmail.com>
 <20190718112954.GA1774@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718112954.GA1774@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-07-18 20:29:54, Sergey Senozhatsky wrote:
> On (07/18/19 14:07), Konstantin Khlebnikov wrote:
> > > Let me test the waters. Criticize the following idea:
> > >
> > > Can we, sort of, disconnect "supposed to be dead" CPUs from printk()
> > > so then we can unconditionally re-init printk() from panic-CPU?
> > >
> > > We have per-CPU printk_state; so panic-CPU can set, let's say,
> > > DEAD_CPUS_TELL_NO_TALES bit on all CPUs but self, and vprintk_func()
> > > will do nothing if DEAD_CPUS_TELL_NO_TALES bit set on particular
> > > CPU. Foreign CPUs are not even supposed to be alive, and smp_send_stop()
> > > waits for IPI acks from secondary CPUs long enough on average (need
> > > to check that) so if one of the CPUs is misbehaving and doesn't want
> > > to die (geez...) we will just "disconnect" it from printk() to minimize
> > > possible logbuf/console drivers interventions and then proceed with
> > > panic; assuming that misbehaving CPUs are actually up to something
> > > sane. Sometimes, you know, in some cases, those CPUs are already dead:
> > > either accidentally powered off, or went completely nuts and do nothing,
> > > etc. etc. but we still can kdump() and console_flush_on_panic().
> > 
> > Good idea.
> > Panic-CPU could just increment state to reroute printk into 'safe'
> > per-cpu buffer.
> 
> Yeah, that's better.
> 
> So we can do something like this
> 
> @@ -269,15 +269,21 @@ void printk_safe_flush_on_panic(void)
>  	 * Make sure that we could access the main ring buffer.
>  	 * Do not risk a double release when more CPUs are up.
>  	 */
> -	if (raw_spin_is_locked(&logbuf_lock)) {
> -		if (num_online_cpus() > 1)
> -			return;
> +	debug_locks_off();
> +	raw_spin_lock_init(&logbuf_lock);

Hmm, the check for num_online_cpus() is there to avoid deadlock
caused be double unlock. The unconditional init would bring it back.

It is about what compromise we use. We either try to get the messages
out, init the lock and risk a deadlock. Or we do not risk the
deadlock.

The current code is not consistent. printk_safe_flush_on_panic()
is conservative and does not risk the deadlock. While kmsg_dump(),
console_unblank() and console_flush_on_panic() risk the deadlock.

The 1st patch tries to make it more consistent. It makes all
the above functions as conservative as printk_safe_flush_on_panic()
regarding logbuf_lock. While they still risk a deadlock with
console-specific locks.

The reasoning might be:

  + The code under logbuf_lock mostly just manipulates strings. There
    are no nested locks. Infinite loops would most likely happen also
    during normal operation. By other words, it is not easy to stay
    locked in logbuf_lock (he, he, the last famous words).

  + On the other hand, a lot of code is done with disabled interrupts.
    It is easier to imagine that a CPU could not get stopped by normal
    interrupt because some deadlock or infinite loop in interrupt
    context. It might even be a code calling console_unlock().
    Re-initializing logbuf_lock might be unnecessary risk.

  + We are probably more relaxed with console specific locks because
    most of them are ignored in panic after bust_spinlocks().


Anyway, this patchset is primary about logbuf_lock related deadlocks.
I needed a fix for our customers. I do not want to spend too much
time on upstreaming. IMHO, it is better to invest into the lockless
ring buffer.

If we could agree that the patches makes things better (more
consistent, more safe in kdump with enabled notifiers) and
the complexity is acceptable. Then let's accept them
(with some trivial improvements).

If they are too controversial, risky, or complex then
let's abandon them and concentrate on lockless ring buffer.

Best Regards,
Petr
