Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8667C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43E02053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfHZXdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:33:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfHZXdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:33:18 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2OU7-0007Bk-8F; Tue, 27 Aug 2019 01:33:15 +0200
Date:   Tue, 27 Aug 2019 01:33:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 37/38] posix-cpu-timers: Move state tracking to struct
 posix_cputimers
In-Reply-To: <20190826232849.GL14309@lenoir>
Message-ID: <alpine.DEB.2.21.1908270132250.1939@nanos.tec.linutronix.de>
References: <20190821190847.665673890@linutronix.de> <20190821192922.743229404@linutronix.de> <20190826232849.GL14309@lenoir>
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

On Tue, 27 Aug 2019, Frederic Weisbecker wrote:
> On Wed, Aug 21, 2019 at 09:09:24PM +0200, Thomas Gleixner wrote:
> > Put it where it belongs and clean up the ifdeffery in fork completely.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> > V2: Adopt to the per clock base struct
> > ---
> >  include/linux/posix-timers.h   |    8 ++++
> >  include/linux/sched/cputime.h  |    9 +++--
> >  include/linux/sched/signal.h   |    6 ---
> >  init/init_task.c               |    2 -
> >  kernel/fork.c                  |    6 ---
> >  kernel/time/posix-cpu-timers.c |   73 ++++++++++++++++++++++-------------------
> >  6 files changed, 54 insertions(+), 50 deletions(-)
> > 
> > --- a/include/linux/posix-timers.h
> > +++ b/include/linux/posix-timers.h
> > @@ -77,15 +77,23 @@ struct posix_cputimer_base {
> >  /**
> >   * posix_cputimers - Container for posix CPU timer related data
> >   * @bases:		Base container for posix CPU clocks
> > + * @timers_active:	Timers are queued.
> > + * @expiry_active:	Timer expiry is active. Used for
> > + *			process wide timers to avoid multiple
> > + *			task trying to handle expiry concurrently
> 
> So those two fields are also added to struct task_struct but unused there,
> right?

Yes. I did not come up with a smart way to avoid that, but lemme think
about it some more.

Thanks,

	tglx
