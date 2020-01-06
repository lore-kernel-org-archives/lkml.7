Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6324C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E37321744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578349135;
	bh=aOq88Kdv/xqqvmSHyVyBDCV/K9Sa1oXzVNvd1u+Buts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CXgdEXRqdyOEa0D5Ujhc2AapRAJxPNbHCTmiPH9+rBapZOBECAuL914ZREP3d1Yna
	 yySqP0HhOvaglKTk6pNwMp8IXX+phPX54WPo7ELz3KPcUDtQLoj/RiS7pOxTzM2spl
	 0STVlfz6CxWk2yb3rVFpfG+4umNrvi8p/ZjW6ndY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgAFWSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAFWSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:18:54 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5D82081E;
        Mon,  6 Jan 2020 22:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578349133;
        bh=aOq88Kdv/xqqvmSHyVyBDCV/K9Sa1oXzVNvd1u+Buts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPC5q+ZmrxSZU7qareABNle0xnS3ptrD66RNLoj3Y+CyK38TidyrkZmk6zUbKCbeN
         TzkDjYPZMoYpxfwufXgiuwHsb/gKHZXmxHnRcePvWdnIQUqlVJjr/r5q7AiTQGJiY4
         rHwMv4i3cJZaE2rgRhvEv51rhnDtyIjMdad1w20E=
Date:   Mon, 6 Jan 2020 23:18:51 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tick/sched: Forward timer even in nohz mode
Message-ID: <20200106221850.GD26097@lenoir>
References: <1576538545-13274-1-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576538545-13274-1-git-send-email-swood@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:22:22PM -0500, Scott Wood wrote:
> Currently when exiting nohz, the expiry will be forwarded as if we
> had just run the timer.  If we re-enter nohz before this new expiry,
> and exit after, this forwarding will happen again.  If this load pattern
> recurs the tick can be indefinitely postponed.

I must be missing something but I don't see why that would be a problem.
Indeed the tick can be indefinitely postponed but that's as long as it's
not needed. As soon as it's needed (timer callback expired, RCU, ...), the
tick will be retained and it will eventually fire.

> @@ -642,9 +642,6 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
>  	hrtimer_cancel(&ts->sched_timer);
>  	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
>  
> -	/* Forward the time to expire in the future */
> -	hrtimer_forward(&ts->sched_timer, now, tick_period);
> -

By doing that, you may program a past tick and thus add a useless interrupt
at each idle exit.

Thanks.
