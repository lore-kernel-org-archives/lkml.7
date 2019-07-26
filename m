Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5937C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7639A217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbfGZVfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:35:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50490 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387425AbfGZVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:35:06 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr7rh-0003CB-Vi; Fri, 26 Jul 2019 23:35:02 +0200
Date:   Fri, 26 Jul 2019 23:35:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Julia Cartwright <julia@ni.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 10/12] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
In-Reply-To: <20190726211623.GP29109@jcartwri.amer.corp.natinst.com>
Message-ID: <alpine.DEB.2.21.1907262327250.1791@nanos.tec.linutronix.de>
References: <20190726183048.982726647@linutronix.de> <20190726185753.645792403@linutronix.de> <20190726211623.GP29109@jcartwri.amer.corp.natinst.com>
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

Julia,

On Fri, 26 Jul 2019, Julia Cartwright wrote:
> On Fri, Jul 26, 2019 at 08:30:58PM +0200, Thomas Gleixner wrote:
> > +	 * OTOH, priviledged real-time user space applications rely on the
> > +	 * low latency of hard interrupt wakeups. If the current task is in
> > +	 * a real-time scheduling class, mark the mode for hard interrupt
> > +	 * expiry.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
> > +			mode |= HRTIMER_MODE_HARD;
> 
> Because this ends up sampling the tasks' scheduling parameters only at
> the time of enqueue, it doesn't take into consideration whether or not
> the task maybe holding a PI lock and later be boosted if contended by an
> RT thread.
>
> Am I correct in assuming there is an induced inversion here in this
> case, because the deferred wakeup mechanism isn't part of the PI chain?
>
> If so, is this just to be an accepted limitation at this point?  Is the
> intent to argue this away as bad RT application design? :)

This would bring us back to the point where we moved the hrtimers
which were not marked for hardirq expiry onto the separate softirq expiry
list. That caused horrible latencies in some scenarios.

The separation of the bases into hard and soft expiry mode solved that
nicely and I haven't heard a complaint since we changed that in 4.14-rt.

So yes I'd argue it's an application issue. Holding a lock while doing
e.g. a nanosleep is not the most brilliant idea.

Thanks,

	tglx
