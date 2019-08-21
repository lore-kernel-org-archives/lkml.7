Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436902339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfHUNbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:31:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55723 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:31:43 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0QiC-00050y-Ac; Wed, 21 Aug 2019 15:31:40 +0200
Date:   Wed, 21 Aug 2019 15:31:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 04/44] posix-cpu-timers: Fixup stale comment
In-Reply-To: <20190820225604.GI2093@lenoir>
Message-ID: <alpine.DEB.2.21.1908211525150.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143801.747233612@linutronix.de> <20190820142658.GG2093@lenoir> <alpine.DEB.2.21.1908201946320.2223@nanos.tec.linutronix.de> <20190820204803.GH2093@lenoir> <alpine.DEB.2.21.1908202331080.2223@nanos.tec.linutronix.de>
 <20190820225604.GI2093@lenoir>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019, Frederic Weisbecker wrote:
> On Tue, Aug 20, 2019 at 11:43:26PM +0200, Thomas Gleixner wrote:
> > On Tue, 20 Aug 2019, Frederic Weisbecker wrote:
> > No it can't do that throughout posix_cpu_timer_del() because exit_itimers()
> > can only look at current->signal->posix_timers which does not contain the
> > posix timers owned by a different task/process.
> > 
> > We could of course invoke posix_cpu_timers_exit() from exit_itimers() but
> > does that buy anything?
> >  
> > > It would make things more simple to delete the timer off the target from
> > > the same caller and place and we could remove posix_cpu_timers_exit*().
> > 
> > We can't. The foreign owned cpu timers are not in cur->signal->posix_timers
> > so how should we invoke posix_cpu_timer_del() on them. Only the owner task
> > can. The only thing the exiting task can do is to remove the foreign timer
> > from it's expiry list which has nothing to do with cur->signal->posix_timers.
> 
> That's exactly what I'm proposing. I think you're misunderstanding me.
> 
> I want the owner to handle all the list deletion work from the target.
> 
> Ok let's imagine a timer $ITIMER, owned by task $OWNER and whose target is task $TARGET.
> 
> So it's enqueued on $OWNER->signal->posix_timers and $TARGET->cputime_expires.
> 
> Two scenarios can happen:
> 
> 1) $TARGET exits first and is released. So it calls posix_cpu_timers_exit()
>    which deletes $ITIMER from $TARGET->cputime_expires.
> 
>    Later on, $OWNER exits and calls exit_itimers() -> timer_delete_hook($ITIMER)
>    -> posix_cpu_timer_del($ITIMER). It finds $TARGET as the target of $ITIMER but no
>    more sighand. So it returns.
> 
> 2) $OWNER exits first and calls exit_itimer() -> timer_delete_hook($ITIMER)
>    -> posix_cpu_timer_del($ITIMER). It finds $TARGET as the target of $ITIMER and it
>    finds a sighand to lock. So it deletes $ITIMER from $TARGET->cputime_expires
>    (see list_del(&timer->it.cpu.entry)).
> 
> 
> So I propose to change the behaviour of case 1) so that $TARGET doesn't call
> posix_cpu_timers_exit(). We instead wait for $OWNER to exit and call
> exit_itimers()  -> timer_delete_hook($ITIMER) -> posix_cpu_timer_del($ITIMER).
> It is going to find $TARGET as the target of $ITIMER but no more sighand. Then
> finally it removes $ITIMER from $TARGET->cputime_expires.
> We basically do the same thing as in 2) but without locking sighand since it's NULL
> on $TARGET at this time.

But what do we win with that? Horrors like this:

task A		task B	   	task C

     		arm_timer(A)	arm_timer(A)

do_exit()

		del_timer(A)	del_timer(A)
		no sighand	no_sighand
		 list_del()       list_del()

Guess how well concurrent list deletion works.

We must remove armed timers from the task/signal _before_ dropping sighand,
really.

Thanks,

	tglx
