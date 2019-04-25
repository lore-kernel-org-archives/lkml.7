Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24249C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408DA206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfDYVpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:45:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:45:29 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJmB1-0003WJ-Aq; Thu, 25 Apr 2019 23:45:07 +0200
Date:   Thu, 25 Apr 2019 23:45:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
Subject: Re: [PATCHv3 06/27] posix-timers/timens: Take into account clock
 offsets
In-Reply-To: <20190425161416.26600-7-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1904252328360.1768@nanos.tec.linutronix.de>
References: <20190425161416.26600-1-dima@arista.com> <20190425161416.26600-7-dima@arista.com>
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

> From: Andrei Vagin <avagin@gmail.com>
> 
> Wire timer_settime() syscall into time namespace virtualization.
> 
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  kernel/time/alarmtimer.c   | 3 +++
>  kernel/time/posix-timers.c | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 31f99361342e..23f5c39c8d23 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -26,6 +26,7 @@
>  #include <linux/freezer.h>
>  #include <linux/compat.h>
>  #include <linux/module.h>
> +#include <linux/time_namespace.h>
>  
>  #include "posix-timers.h"
>  
> @@ -621,6 +622,8 @@ static void alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
>  
>  	if (!absolute)
>  		expires = ktime_add_safe(expires, base->gettime());
> +	else
> +		expires = timens_ktime_to_host(base->base_clockid, expires);
>
>  	if (sigev_none)
>  		alarm->node.expires = expires;
>  	else
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index a723e63d55fd..7922731f98cd 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -803,6 +803,8 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
>  
>  	if (!absolute)
>  		expires = ktime_add_safe(expires, timer->base->get_time());
> +	else
> +		expires = timens_ktime_to_host(timer->base->clockid, expires);
>  	hrtimer_set_expires(timer, expires);

So you have now two places where you do that adjustment. Why? And why in
the timer_arm() callback? The obvious place to do that is in
common_timer_set().

-	expires = timespec64_to_ktime(new_setting->it_value);
+	expires = timespec64_to_host(timr->it_clock, &new_setting->it_value);

static ktime_t timespec64_to_host(clockid_t which, struct timespec64 val)
{
	ktime_t expires = timespec64_to_ktime(val);

#ifdef NAMESPACE
	switch (which) {
	case CLOCK_MONOTONIC:
		return timens_sub_monotonic(expires);
	case CLOCK_BOOTTINE:
	case CLOCK_BOOTTIME_ALARM:
		return timens_sub_boottime(expires);
	}
#endif
	return expires;
}

Thanks,

	tglx
