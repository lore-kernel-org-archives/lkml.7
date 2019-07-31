Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2408DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACD42089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOxFiJFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfGaJta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:49:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfGaJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M/SBbX4vvj5n45iza8h2bwIhFMe1LpVGRh930JnCtqI=; b=aOxFiJFxGULkeW7WrPu2NKfHT
        gNGBCBqfR3CdnJ5SOHtMIoFV6sDynfjukthlstMdtwD/Ag61CBmRa0d9ATCxu00BXY9HOWh5+GopD
        5E4223bXPdLtRJyJ5/aGPLYvkvlYXV4HzK9uJuYSJbsdhutCfVowol/x5CL9U3wR4HLLh2Q2kkRga
        Xzf2QLvfV44+SA9/gXq8oxl8qZFhBbF3JtvG857T7C3d3NMfZBZn4PvQIoUnvYhZeTmk/BUbOAvHz
        fCtkSFdJuXiWFCH2GkA/aEHDky4JDnGBv1LZsV4605hfGAc7oK6vubmOzNEy5gAraRr0Bad1A8NuB
        d4Ynsegkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hslEW-0000p2-Rc; Wed, 31 Jul 2019 09:49:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9281D2029FD58; Wed, 31 Jul 2019 11:49:17 +0200 (CEST)
Date:   Wed, 31 Jul 2019 11:49:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: Re: [patch 7/7] posix-timers: Prepare for PREEMPT_RT
Message-ID: <20190731094917.GR31381@hirez.programming.kicks-ass.net>
References: <20190730223348.409366334@linutronix.de>
 <20190730223829.058247862@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730223829.058247862@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:33:55AM +0200, Thomas Gleixner wrote:
> +static struct k_itimer *timer_wait_running(struct k_itimer *timer,
> +					   unsigned long *flags)
> +{
> +	const struct k_clock *kc = READ_ONCE(timer->kclock);
> +	timer_t timer_id = READ_ONCE(timer->it_id);
> +
> +	/* Prevent kfree(timer) after dropping the lock */
> +	rcu_read_lock();
> +	unlock_timer(timer, *flags);
> +
> +	if (kc->timer_arm == common_hrtimer_arm)
> +		hrtimer_cancel_wait_running(&timer->it.real.timer);
> +	else if (kc == &alarm_clock)
> +		hrtimer_cancel_wait_running(&timer->it.alarm.alarmtimer.timer);

	else WARN();

> +	rcu_read_unlock();
> +
> +	/* Relock the timer. It might be not longer hashed. */
> +	return lock_timer(timer_id, flags);
> +}
