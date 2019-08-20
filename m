Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9956322DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfHTUWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:22:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52955 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfHTUWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:22:11 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0Ads-0005Xi-Du; Tue, 20 Aug 2019 22:22:08 +0200
Date:   Tue, 20 Aug 2019 22:22:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 27/44] posix-cpu-timers: Provide array based access to
 expiry cache
In-Reply-To: <20190819193224.GD68079@gmail.com>
Message-ID: <alpine.DEB.2.21.1908202217150.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143803.961800814@linutronix.de> <20190819193224.GD68079@gmail.com>
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

On Mon, 19 Aug 2019, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> >  struct posix_cputimers {
> > -	struct task_cputime	cputime_expires;
> > -	struct list_head	cpu_timers[CPUCLOCK_MAX];
> > +	/* Temporary union until all users are cleaned up */
> > +	union {
> > +		struct task_cputime	cputime_expires;
> > +		u64			expiries[CPUCLOCK_MAX];
> > +	};
> > +	struct list_head		cpu_timers[CPUCLOCK_MAX];
> >  };
> 
> Could we please name this first_expiry[] or such, to make it clear that 
> this is cached value of the first expiry of all timers of this process, 
> instead of the rather vague 'expiries[]' naming?
> 
> Also, while at it, after the above temporary transition union, the final 
> structure becomes:
> 
>  struct posix_cputimers {
>        u64                     expiries[CPUCLOCK_MAX];
>        struct list_head        cpu_timers[CPUCLOCK_MAX];
>  };
> 
> Wouldn't it be more natural and easier to read to have the list head and 
> the expiry together:
> 
> 	struct posix_cputimer_list {
> 		u64				first_expiry;
> 		struct list_head		list;
> 	};
> 
> 	struct posix_cputimers {
> 		struct posix_cputimer_list	timers[CPUCLOCK_MAX];
> 	};
> 
> ?
> 
> This makes the array structure rather clear and the first_expiry field 
> mostly self-documenting.

I kept the odd named expiries for the temporary union and then after the
patch which removes the abused struct task_cputime, I applied a separate
cleanup which looks similar to the above.

Just the names are a bit different and more aligned to what we have in
hrtimers:

struct posix_cputimer_base {
	u64		   	nextevt;
	struct timerqueue_head	tqhead;
};

and then have

struct posix_cputimers {
	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
};

I'll send out a new version after doing some more testing.

Thanks,

	tglx
