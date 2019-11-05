Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA2C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6141B204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390860AbfKES4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:56:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390651AbfKES4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:56:09 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iS3zm-0002DU-Un; Tue, 05 Nov 2019 19:56:03 +0100
Date:   Tue, 5 Nov 2019 19:56:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
cc:     Florian Weimer <fweimer@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: handle_exit_race && PF_EXITING
In-Reply-To: <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de> <20191105152728.GA5666@redhat.com> <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de>
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

On Tue, 5 Nov 2019, Thomas Gleixner wrote:
> On Tue, 5 Nov 2019, Thomas Gleixner wrote:
> > On Tue, 5 Nov 2019, Oleg Nesterov wrote:
> > > On 11/05, Thomas Gleixner wrote:
> > > >
> > > > Out of curiosity, what's the race issue vs. robust list which you are
> > > > trying to solve?
> > > 
> > > Off-topic, but this reminds me...
> > > 
> > > 	#include <sched.h>
> > > 	#include <assert.h>
> > > 	#include <unistd.h>
> > > 	#include <syscall.h>
> > > 
> > > 	#define FUTEX_LOCK_PI		6
> > > 
> > > 	int main(void)
> > > 	{
> > > 		struct sched_param sp = {};
> > > 
> > > 		sp.sched_priority = 2;
> > > 		assert(sched_setscheduler(0, SCHED_FIFO, &sp) == 0);
> > > 
> > > 		int lock = vfork();
> > > 		if (!lock) {
> > > 			sp.sched_priority = 1;
> > > 			assert(sched_setscheduler(0, SCHED_FIFO, &sp) == 0);
> > > 			_exit(0);
> > > 		}
> > > 
> > > 		syscall(__NR_futex, &lock, FUTEX_LOCK_PI, 0,0,0);
> > > 		return 0;
> > > 	}
> > > 
> > > this creates the unkillable RT process spinning in futex_lock_pi() on
> > > a single CPU machine (or you can use taskset).
> > 
> > Uuurgh.
> 
> But staring more at it. That's a scheduler bug.
> 
> parent	    	    	child
> 
>  set FIFO prio 2
> 
>  fork()	         ->	set FIFO prio 1
>  		 	 sched_setscheduler(...)
> 			   return from syscall		<= BUG
> 
>  		 	_exit()
> 
> When the child lowers its priority from 2 to 1, then the parent _must_
> preempt the child simply because the parent is now the top priority task on
> that CPU. Child should never reach exit before the parent blocks on the
> futex.

I'm a moron. It's vfork() not fork() so the behaviour is expected.

Staring more at the trace which shows me where this goes down the drain.

Thanks,

	tglx
