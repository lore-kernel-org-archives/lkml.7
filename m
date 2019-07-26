Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31035C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E7822BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfGZUwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:52:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfGZUwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:52:22 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr7CM-0002OP-Qw; Fri, 26 Jul 2019 22:52:18 +0200
Date:   Fri, 26 Jul 2019 22:52:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 10/12] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
In-Reply-To: <20190726164428.40a4e4b4@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1907262249210.1791@nanos.tec.linutronix.de>
References: <20190726183048.982726647@linutronix.de>        <20190726185753.645792403@linutronix.de> <20190726164428.40a4e4b4@gandalf.local.home>
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

On Fri, 26 Jul 2019, Steven Rostedt wrote:

> On Fri, 26 Jul 2019 20:30:58 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > +++ b/kernel/time/hrtimer.c
> > @@ -1662,6 +1662,30 @@ static enum hrtimer_restart hrtimer_wake
> >  static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
> >  				   clockid_t clock_id, enum hrtimer_mode mode)
> >  {
> > +	/*
> > +	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
> > +	 * marked for hard interrupt expiry mode are moved into soft
> > +	 * interrupt context either for latency reasons or because the
> > +	 * hrtimer callback takes regular spinlocks or invokes other
> > +	 * functions which are not suitable for hard interrupt context on
> > +	 * PREEMPT_RT.
> 
> Have we marked all timer handlers that have normal spin_locks as
> HRTIMER_MODE_SOFT? Otherwise, can't we switch one to hard below and
> having their handler grab a spin_lock/mutex in hard interrupt context
> in RT?

See patch 09/12. We move all timers into soft mode which are not marked
MODE_HARD.

> > +	 *
> > +	 * The hrtimer_sleeper callback is RT compatible in hard interrupt

                                           ^^^^^^^^^^^^^^
> > +	 * context, but there is a latency concern: Untrusted userspace can
> > +	 * spawn many threads which arm timers for the same expiry time on
> > +	 * the same CPU. That causes a latency spike due to the wakeup of
> > +	 * a gazillion threads.
> > +	 *
> > +	 * OTOH, priviledged real-time user space applications rely on the
> > +	 * low latency of hard interrupt wakeups. If the current task is in
> > +	 * a real-time scheduling class, mark the mode for hard interrupt
> > +	 * expiry.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
> > +			mode |= HRTIMER_MODE_HARD;
> > +	}
> > +
> >  	__hrtimer_init(&sl->timer, clock_id, mode);
> >  	sl->timer.function = hrtimer_wakeup;

It's the wakeup function and nothing is supposed to override that.

Thanks,

	tglx
