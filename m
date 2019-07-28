Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2341BC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF82D2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfG1Pbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:31:55 -0400
Received: from foss.arm.com ([217.140.110.172]:33560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfG1Pbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:31:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906B5344;
        Sun, 28 Jul 2019 08:31:54 -0700 (PDT)
Received: from [10.37.12.40] (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45FE03F71F;
        Sun, 28 Jul 2019 08:31:53 -0700 (PDT)
Subject: Re: [patch 3/5] lib/vdso/32: Provide legacy syscall fallbacks
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.786513965@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3aba2ca9-5ed2-8bde-eb3e-ddb25410205d@arm.com>
Date:   Sun, 28 Jul 2019 16:33:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190728131648.786513965@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/19 2:12 PM, Thomas Gleixner wrote:
> To address the regression which causes seccomp to deny applications the
> access to clock_gettime64() and clock_getres64() syscalls because they
> are not enabled in the existing filters.
> 
> That trips over the fact that 32bit VDSOs use the new clock_gettime64() and
> clock_getres64() syscalls in the fallback path.
> 
> Implement a __cvdso_clock_get*time32() variants which invokes the legacy
> 32bit syscalls when the architecture requests it.
> 
> The conditional can go away once all architectures are converted.
>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/vdso/gettimeofday.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -117,6 +117,8 @@ static __maybe_unused int
>  	return 0;
>  }
>  
> +#ifndef VDSO_HAS_32BIT_FALLBACK
> +
>  static __maybe_unused int
>  __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
>  {
> @@ -132,10 +134,29 @@ static __maybe_unused int
>  		res->tv_sec = ts.tv_sec;
>  		res->tv_nsec = ts.tv_nsec;
>  	}
> -
>  	return ret;
>  }
>  
> +#else
> +
> +static __maybe_unused int
> +__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
> +{
> +	struct __kernel_timespec ts;
> +	int ret;
> +
> +	ret = __cvdso_clock_gettime_common(clock, &ts);
> +
> +	if (likely(!ret)) {
> +		res->tv_sec = ts.tv_sec;
> +		res->tv_nsec = ts.tv_nsec;
> +		return 0;
> +	}
> +	return clock_gettime32_fallback(clock, res);
> +}
> +
> +#endif
> +
>  static __maybe_unused int
>  __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
>  {
> @@ -225,6 +246,8 @@ int __cvdso_clock_getres(clockid_t clock
>  	return 0;
>  }
>  
> +#ifndef VDSO_HAS_32BIT_FALLBACK
> +
>  static __maybe_unused int
>  __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
>  {
> @@ -241,4 +264,25 @@ static __maybe_unused int
>  	}
>  	return ret;
>  }
> +
> +#else
> +
> +static __maybe_unused int
> +__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
> +{
> +	struct __kernel_timespec ts;
> +	int ret;
> +
> +	ret = __cvdso_clock_getres_common(clock, &ts);
> +
> +	if (likely(!ret)) {
> +		res->tv_sec = ts.tv_sec;
> +		res->tv_nsec = ts.tv_nsec;
> +		return 0;
> +	}
> +
> +	return clock_getres32_fallback(clock, res);
> +}
> +#endif
> +
>  #endif /* VDSO_HAS_CLOCK_GETRES */
> 
> 

-- 
Regards,
Vincenzo
