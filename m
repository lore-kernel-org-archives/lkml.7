Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7015C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E638218A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfFQGJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:09:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfFQGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:09:25 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hckpV-0006Rj-IE; Mon, 17 Jun 2019 08:09:21 +0200
Date:   Mon, 17 Jun 2019 08:09:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] timers: Fix up get_target_base() to use old base
 properly
In-Reply-To: <20190603132944.9726-1-peterx@redhat.com>
Message-ID: <alpine.DEB.2.21.1906170732410.1760@nanos.tec.linutronix.de>
References: <20190603132944.9726-1-peterx@redhat.com>
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

Peter,

On Mon, 3 Jun 2019, Peter Xu wrote:

> get_target_base() in the timer code is not using the "base" parameter
> at all.  My gut feeling is that instead of removing that extra
> parameter, what we really want to do is "return the old base if it
> does not suite for a new one".

Gut feelings are not really useful for technical decisions.

>  kernel/time/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 343c7ba33b1c..6ff6ffd2c719 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -868,7 +868,7 @@ get_target_base(struct timer_base *base, unsigned tflags)
>  	    !(tflags & TIMER_PINNED))
>  		return get_timer_cpu_base(tflags, get_nohz_timer_target());
>  #endif
> -	return get_timer_this_cpu_base(tflags);
> +	return base;
>  }

Timers are supposed to be queued on the local CPU except for the following
cases:

 1) timer migration is enabled and the timer is not pinned

    In this case the get_nohz_timer_target() crystal ball logic tries to
    find a useful base for the timer, which is doomed but its that way
    until we reach the point where the pull model actually works.

 2) add_timer_on() is invoked which puts a timer on an explicit target
    CPU. That's not using the above.

That has been that way forever and the base parameter is stale as older
code used the base to check whether migration is enabled or not. When this
was converted to a static branch the parameter stayed and got unused.

So your change would prevent moving the timer to the current CPU.

You might argue that in case of an explicit pinned timer, the above logic
is wrong when the timer is modified as it might move to a different
CPU. But from day one when the pinned logic was introduced, pinned just
prevents it from being queued on a remote CPU. If you need a timer to stay
on a particular CPU even if modified from a remote CPU, then the only way
right now is to dequeue and requeue it with add_timer_on(). 

If we really want to change that, then we need to audit all usage sites of
pinned timers and figure out whether this would break anything.

The proper change would be in that case:

      return pinned ? base : get_timer_this_cpu_base(tflags);

But unless you can come up with a use case where the current logic is truly
broken, I don't see a reason to do that.

Thanks,

	tglx
