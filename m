Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28E5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D082332A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfHTVnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:43:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbfHTVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:43:37 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0Bue-0006Zm-OE; Tue, 20 Aug 2019 23:43:32 +0200
Date:   Tue, 20 Aug 2019 23:43:26 +0200 (CEST)
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
In-Reply-To: <20190820204803.GH2093@lenoir>
Message-ID: <alpine.DEB.2.21.1908202331080.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143801.747233612@linutronix.de> <20190820142658.GG2093@lenoir> <alpine.DEB.2.21.1908201946320.2223@nanos.tec.linutronix.de> <20190820204803.GH2093@lenoir>
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

On Tue, 20 Aug 2019, Frederic Weisbecker wrote:
> On Tue, Aug 20, 2019 at 07:57:37PM +0200, Thomas Gleixner wrote:
> > On Tue, 20 Aug 2019, Frederic Weisbecker wrote:
> > > On Mon, Aug 19, 2019 at 04:31:45PM +0200, Thomas Gleixner wrote:
> > > >  /*
> > > > - * Clean out CPU timers still ticking when a thread exited.  The task
> > > > - * pointer is cleared, and the expiry time is replaced with the residual
> > > > - * time for later timer_gettime calls to return.
> > > > + * Clean out CPU timers which are still armed when a thread exits. The
> > > > + * timers are only removed from the list. No other updates are done. The
> > > > + * corresponding posix timers are still accessible, but cannot be rearmed.
> > > > + *
> > > >   * This must be called with the siglock held.
> > > >   */
> > > >  static void cleanup_timers(struct list_head *head)
> > > 
> > > Indeed and I believe we could avoid that step. We remove the sighand at the same
> > > time so those can't be accessed anymore anyway.
> > > 
> > > exit_itimers() takes care of the last call release and could force remove from
> > > the list (although it might be taken care of in your series, haven't checked yet):
> > 
> > No. The posix timer is not necessarily owned by the exiting task or
> > process. It can be owned by a different entity which has permissions,
> > e.g. parent.
> > 
> > So those are not in the posix timer list of the exiting task, which gets
> > cleaned up in exit_itimers(). Those are in the list of the task which armed
> > the timer. The timer is merily queued in the 'active timers' list of the
> > exiting task and posix_cpu_timers_exit()/posix_cpu_timers_exit_group()
> > remove it before the task/signal structs go away.
> 
> Sure, I understand there's two distinct things here: the owner that queues
> timers in owner->sig->posix_timers (cleaned in exit_itimers()) and the target that queues
> in target->[signal->]cputime_expires (cleaned in posix_cpu_timers_exit[_group]().
>
> So I'm wondering why we bother with posix_cpu_timers_exit[_group]() at
> all when exit_itimers() could handle the list deletion from
> target->[signal]->cputime_expires throughout posix_cpu_timer_del() as it
> already does on targets that still have their sighands.

No it can't do that throughout posix_cpu_timer_del() because exit_itimers()
can only look at current->signal->posix_timers which does not contain the
posix timers owned by a different task/process.

We could of course invoke posix_cpu_timers_exit() from exit_itimers() but
does that buy anything?
 
> It would make things more simple to delete the timer off the target from
> the same caller and place and we could remove posix_cpu_timers_exit*().

We can't. The foreign owned cpu timers are not in cur->signal->posix_timers
so how should we invoke posix_cpu_timer_del() on them. Only the owner task
can. The only thing the exiting task can do is to remove the foreign timer
from it's expiry list which has nothing to do with cur->signal->posix_timers.

cur->signal->posix_timers only contains posix timers which are owned by
current not those which are owned by a different task and armed on the
exiting one.

exit_itimers() handles cur->signal->posix_timers, i.e. timers owned by
current.

posix_cpu_timers_exit() handles timers enqueued on current, which are
foreign owned timers because exit_itimers() removed those which were owned
by current already.

posix_cpu_timers_exit_group() handles timers enqueued on current->signal,
which are foreign owned timers because exit_itimers() removed those which
were owned by current already.

> Or is there something I'm awkwardly missing as usual? :-) 

I think so :)

Thanks,

	tglx
