Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B595C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1512077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfG1P26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:28:58 -0400
Received: from foss.arm.com ([217.140.110.172]:33526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfG1P25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:28:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B7A4344;
        Sun, 28 Jul 2019 08:28:57 -0700 (PDT)
Received: from [10.37.12.40] (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEBAD3F71F;
        Sun, 28 Jul 2019 08:28:55 -0700 (PDT)
Subject: Re: [patch 1/5] lib/vdso/32: Remove inconsistent NULL pointer checks
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.587523358@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <dafaa6b5-8e45-307c-c65a-dfef467a5754@arm.com>
Date:   Sun, 28 Jul 2019 16:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190728131648.587523358@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/19 2:12 PM, Thomas Gleixner wrote:
> The 32bit variants of vdso_clock_gettime()/getres() have a NULL pointer
> check for the timespec pointer. That's inconsistent vs. 64bit.
> 
> But the vdso implementation will never be consistent versus the syscall
> because the only case which it can handle is NULL. Any other invalid
> pointer will cause a segfault. So special casing NULL is not really useful.
> 
> Remove it along with the superflouos syscall fallback invocation as that
> will return -EFAULT anyway. That also gets rid of the dubious typecast
> which only works because the pointer is NULL.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> 
> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/vdso/gettimeofday.c |   18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -115,9 +115,6 @@ static __maybe_unused int
>  	struct __kernel_timespec ts;
>  	int ret;
>  
> -	if (res == NULL)
> -		goto fallback;
> -
>  	ret = __cvdso_clock_gettime(clock, &ts);
>  
>  	if (ret == 0) {
> @@ -126,9 +123,6 @@ static __maybe_unused int
>  	}
>  
>  	return ret;
> -
> -fallback:
> -	return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
>  }
>  
>  static __maybe_unused int
> @@ -204,10 +198,8 @@ int __cvdso_clock_getres(clockid_t clock
>  		goto fallback;
>  	}
>  
> -	if (res) {
> -		res->tv_sec = 0;
> -		res->tv_nsec = ns;
> -	}
> +	res->tv_sec = 0;
> +	res->tv_nsec = ns;
>  
>  	return 0;
>  
> @@ -221,9 +213,6 @@ static __maybe_unused int
>  	struct __kernel_timespec ts;
>  	int ret;
>  
> -	if (res == NULL)
> -		goto fallback;
> -
>  	ret = __cvdso_clock_getres(clock, &ts);
>  
>  	if (ret == 0) {
> @@ -232,8 +221,5 @@ static __maybe_unused int
>  	}
>  
>  	return ret;
> -
> -fallback:
> -	return clock_getres_fallback(clock, (struct __kernel_timespec *)res);
>  }
>  #endif /* VDSO_HAS_CLOCK_GETRES */
> 
> 

-- 
Regards,
Vincenzo
