Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B252067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfG2LXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:23:05 -0400
Received: from foss.arm.com ([217.140.110.172]:42244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387450AbfG2LXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:23:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A15F28;
        Mon, 29 Jul 2019 04:23:05 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2726E3F694;
        Mon, 29 Jul 2019 04:23:04 -0700 (PDT)
Subject: Re: [patch 4/5] x86/vdso/32: Use 32bit syscall fallback
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.879156507@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3baf0efb-dcae-4953-66aa-06c5ee9fbdf7@arm.com>
Date:   Mon, 29 Jul 2019 12:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728131648.879156507@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2019 14:12, Thomas Gleixner wrote:
> The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
> clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
> seccomp setups because these syscalls might be not (yet) allowed.
> 
> Implement the 32bit variants which use the legacy syscalls and select the
> variant in the core library.
> 
> The 64bit time variants are not removed because they are required for the
> time64 based vdso accessors.
>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/vdso/gettimeofday.h |   36 +++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> --- a/arch/x86/include/asm/vdso/gettimeofday.h
> +++ b/arch/x86/include/asm/vdso/gettimeofday.h
> @@ -96,6 +96,8 @@ long clock_getres_fallback(clockid_t _cl
>  
>  #else
>  
> +#define VDSO_HAS_32BIT_FALLBACK	1
> +
>  static __always_inline
>  long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
>  {
> @@ -114,6 +116,23 @@ long clock_gettime_fallback(clockid_t _c
>  }
>  
>  static __always_inline
> +long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
> +{
> +	long ret;
> +
> +	asm (
> +		"mov %%ebx, %%edx \n"
> +		"mov %[clock], %%ebx \n"
> +		"call __kernel_vsyscall \n"
> +		"mov %%edx, %%ebx \n"
> +		: "=a" (ret), "=m" (*_ts)
> +		: "0" (__NR_clock_gettime), [clock] "g" (_clkid), "c" (_ts)
> +		: "edx");
> +
> +	return ret;
> +}
> +
> +static __always_inline
>  long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
>  			   struct timezone *_tz)
>  {
> @@ -146,6 +165,23 @@ clock_getres_fallback(clockid_t _clkid,
>  		: "edx");
>  
>  	return ret;
> +}
> +
> +static __always_inline
> +long clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
> +{
> +	long ret;
> +
> +	asm (
> +		"mov %%ebx, %%edx \n"
> +		"mov %[clock], %%ebx \n"
> +		"call __kernel_vsyscall \n"
> +		"mov %%edx, %%ebx \n"
> +		: "=a" (ret), "=m" (*_ts)
> +		: "0" (__NR_clock_getres), [clock] "g" (_clkid), "c" (_ts)
> +		: "edx");
> +
> +	return ret;
>  }
>  
>  #endif
> 
> 

-- 
Regards,
Vincenzo
