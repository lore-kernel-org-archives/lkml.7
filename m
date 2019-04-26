Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA020C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5481206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDZOOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:14:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbfDZOOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:14:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C218AC9A;
        Fri, 26 Apr 2019 14:14:28 +0000 (UTC)
Date:   Fri, 26 Apr 2019 16:14:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190426141426.h7hpvhr3rqp7umbk@pathway.suse.cz>
References: <1556199137-14163-1-git-send-email-feng.tang@intel.com>
 <20190426074934.seje2tn5p6fsuwaq@pathway.suse.cz>
 <20190426135316.GA505@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426135316.GA505@tigerII.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-04-26 22:53:16, Sergey Senozhatsky wrote:
> On (04/26/19 09:49), Petr Mladek wrote:
> > On Thu 2019-04-25 21:32:17, Feng Tang wrote:
> > > Currently on panic, kernel will lower the loglevel and print out
> > > pending printk msg only with console_flush_on_panic().
> > > 
> > > Add an option for users to configure the "panic_print" to replay
> > > all dmesg in buffer, some of which they may have never seen due
> > > to the loglevel setting, which will help panic debugging .
> > > 
> > > @@ -2539,6 +2540,11 @@ void console_flush_on_panic(void)
> > >  	 */
> > >  	console_trylock();
> > >  	console_may_schedule = 0;
> > > +
> > > +	if (mode == CONSOLE_REPLAY_ALL) {
> > > +		console_seq = log_first_seq;
> > > +		console_idx = log_first_idx;
> > 
> > Ah, log_first_seq and log_first_idx are synchronized by
> > logbuf_log.
> > 
> > console_flush_on_panic(CONSOLE_REPLAY_ALL) is called
> > when only one CPU is running but it is not guaranteed.
> > 
> > Therefore we should use:
> > 
> > 	if (mode == CONSOLE_REPLAY_ALL) {
> > 		unsigned long flags;
> > 
> > 		logbuf_lock_irqsave(flags);
> > 		console_seq = log_first_seq;
> > 		console_idx = log_first_idx;
> > 		logbuf_unlock_irqrestore(flags);
> > 	}
> 
> I thought about it, and I don't think I see how we can race with
> anything here.
> 
> Suppose we have panic on CPUA and cactive CPUB in console_unlock():
> 
> - if it's not in atomic context, then the moment it does
> 
> 	call_console_drivers();
> 	printk_safe_exit_irqrestore(flags);  << IPI
> 
>   IPI will take it down.
> 
> - If IPI doesn't take it down, then NMI will.

Then I wonder why, for example, native_stop_other_cpus() waits
10ms at maximum after sending the NMIs. What is the state
of the CPUs that miss this deadline?


> - But, more importantly, if that CPUB is in atomic context, then panic
>   CPUA will spin, waiting for that CPUB to handoff printing, before
>   panic CPU will even try to stop all CPUs.
> 
> 	pr_emerg("Kernel panic - not syncing: %s\n", buf)
> 
>   is the point of 'synchronization' - panic CPU will wait for
>   current console owner.

"Synchronization point" is too strong formulation.
The console waiter logic is effective but it does not always
work. The current console owner must be calling the console
drivers.


>   Hmm, we might have a bit of a problem here, maybe.

Hmm, the printk() might wait forever when NMI stopped
the current console owner in the console driver code
or with the logbuf_lock taken.

The console waiter logic might get solved by clearing
the console_owner in console_flush_on_panic(). It can't
be much worse, we already ignore console_lock() there, ...

The best solution for the logbuf_lock scenario would be
the lock less log buffer.


Anyway, do we really need to have length discussion about
whether the locks are needed? They will not break anything.
And we could ignore one scenario in case of problems.
Also we will not need to think about it when the
call is moved anywhere else.

Finally, I could imagine that people would want to replay
the log also from other locations when debugging nasty bugs.

Best Regards,
Petr
