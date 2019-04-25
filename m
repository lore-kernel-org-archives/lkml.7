Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3001C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B012077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbfDYTxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDYTxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:05 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJkQE-0001Cn-Bd; Thu, 25 Apr 2019 21:52:42 +0200
Date:   Thu, 25 Apr 2019 21:52:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv3 03/27] timens: Introduce CLOCK_MONOTONIC offsets
In-Reply-To: <20190425161416.26600-4-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1904252118280.1768@nanos.tec.linutronix.de>
References: <20190425161416.26600-1-dima@arista.com> <20190425161416.26600-4-dima@arista.com>
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

On Thu, 25 Apr 2019, Dmitry Safonov wrote:
> From: Andrei Vagin <avagin@openvz.org>
> 
> Add monotonic time virtualisation for time namespace.
> Introduce timespec for monotionic clock into timens offsets and wire
> clock_gettime() syscall.

That's a bit meager. It should at least explain the concept how this is
supposed to work.
 
>  #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
>  #define CLOCKS_MONO			CLOCK_MONOTONIC

Unrelated to this, but those two defines can go away.
  
> +#define CLOCK_TIMENS			1024

Random number pulled out of thin air without any explanation. Aside of that
why is this exposed to user space?

> @@ -77,6 +78,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
>  		break;
>  	case CLOCK_MONOTONIC:
>  		ktime_get_ts64(tp);
> +		timens_add_monotonic(tp);
>  		break;
>  	case CLOCK_BOOTTIME:
>  		ktime_get_boottime_ts64(tp);
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 29176635991f..a047d6b7c768 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -30,6 +30,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/compat.h>
>  #include <linux/nospec.h>
> +#include <linux/time_namespace.h>
>  
>  #include "timekeeping.h"
>  #include "posix-timers.h"
> @@ -190,6 +191,8 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
>  static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
>  {
>  	ktime_get_ts64(tp);
> +	if (which_clock & CLOCK_TIMENS)
> +		timens_add_monotonic(tp);

> @@ -1039,7 +1046,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
>  	if (!kc)
>  		return -EINVAL;
>  
> -	error = kc->clock_get(which_clock, &kernel_tp);
> +	error = kc->clock_get(which_clock | CLOCK_TIMENS, &kernel_tp);

Bah. After some banging the head against the wall I figured out what you
are doing here. It's because kc->clock_get() is used in common_timer_get()
as well and there you don't want the adjustment there. Sorry, but this is
uncomprehensible and unmaintainable and adds yet another conditional into
the code flow.

The callsite in common_timer_get() has already a comment:
        /*
         * The timespec64 based conversion is suboptimal, but it's not
         * worth to implement yet another callback.
         */
        kc->clock_get(timr->it_clock, &ts64);
        now = timespec64_to_ktime(ts64);

So now we have a proper justification to add that extra callback:
separation of functionality. It's trivial and not a massive code size
overhead.

Thanks,

	tglx
