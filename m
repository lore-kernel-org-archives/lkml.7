Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8123C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3431206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfG2Osd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:48:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:61107 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfG2Osd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:48:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 07:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,323,1559545200"; 
   d="scan'208";a="182772134"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2019 07:48:31 -0700
Date:   Mon, 29 Jul 2019 07:48:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: Re: [patch 3/5] lib/vdso/32: Provide legacy syscall fallbacks
Message-ID: <20190729144831.GA21120@linux.intel.com>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.786513965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728131648.786513965@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 03:12:54PM +0200, Thomas Gleixner wrote:
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

Any reason not to have the #ifndef apply only to the fallback?  Wrapping
the entire function and flipping the order of handling 'ret' makes it a bit
difficult to discern that the only difference is the fallback invocation.

static __maybe_unused int
__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
{
        struct __kernel_timespec ts;
        int ret;

        ret = __cvdso_clock_gettime_common(clock, &ts);

        if (unlikely(ret))
#ifndef VDSO_HAS_32BIT_FALLBACK
                ret = clock_gettime_fallback(clock, &ts);
#else
                return clock_gettime32_fallback(clock, res);
#endif

        if (likely(!ret)) {
                res->tv_sec = ts.tv_sec;
                res->tv_nsec = ts.tv_nsec;
        }
        return ret;
}

static __maybe_unused int
__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
{
        struct __kernel_timespec ts;
        int ret;

        ret = __cvdso_clock_getres_common(clock, &ts);
        if (unlikely(ret))
#ifndef VDSO_HAS_32BIT_FALLBACK
                ret = clock_getres_fallback(clock, &ts);
#else
                return clock_getres32_fallback(clock, res);
#endif

        if (likely(!ret)) {
                res->tv_sec = ts.tv_sec;
                res->tv_nsec = ts.tv_nsec;
        }
        return ret;
}
