Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28496C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0505B208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfGaLDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:03:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfGaLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:03:33 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsmOH-0003ZR-Af; Wed, 31 Jul 2019 13:03:29 +0200
Date:   Wed, 31 Jul 2019 13:03:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: Re: [patch 7/7] posix-timers: Prepare for PREEMPT_RT
In-Reply-To: <20190731094917.GR31381@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907311303130.1715@nanos.tec.linutronix.de>
References: <20190730223348.409366334@linutronix.de> <20190730223829.058247862@linutronix.de> <20190731094917.GR31381@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019, Peter Zijlstra wrote:

> On Wed, Jul 31, 2019 at 12:33:55AM +0200, Thomas Gleixner wrote:
> > +static struct k_itimer *timer_wait_running(struct k_itimer *timer,
> > +					   unsigned long *flags)
> > +{
> > +	const struct k_clock *kc = READ_ONCE(timer->kclock);
> > +	timer_t timer_id = READ_ONCE(timer->it_id);
> > +
> > +	/* Prevent kfree(timer) after dropping the lock */
> > +	rcu_read_lock();
> > +	unlock_timer(timer, *flags);
> > +
> > +	if (kc->timer_arm == common_hrtimer_arm)
> > +		hrtimer_cancel_wait_running(&timer->it.real.timer);
> > +	else if (kc == &alarm_clock)
> > +		hrtimer_cancel_wait_running(&timer->it.alarm.alarmtimer.timer);
> 
> 	else WARN();

Yup. Working on it ...
