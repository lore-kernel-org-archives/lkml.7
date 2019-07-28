Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D22C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3602087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfG1Pef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:34:35 -0400
Received: from foss.arm.com ([217.140.110.172]:33594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfG1Pef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:34:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59211344;
        Sun, 28 Jul 2019 08:34:34 -0700 (PDT)
Received: from [10.37.12.40] (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E3663F71F;
        Sun, 28 Jul 2019 08:34:32 -0700 (PDT)
Subject: Re: [patch 5/5] arm64: compat: vdso: Use legacy syscalls as fallback
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.971361611@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <68c3f5ca-6c38-4a82-4586-6b33fd54390a@arm.com>
Date:   Sun, 28 Jul 2019 16:35:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190728131648.971361611@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/19 2:12 PM, Thomas Gleixner wrote:
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
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> Note:
> 
> The NULL pointer check in the getres/getres32() fallbacks is just wrong.
> The proper return code for a NULL pointer is -EFAULT. How did this ever
> pass any posix test? Also it just should go away because any other invalid
> pointer will be caught in the syscall anyway. The clockid check is also
> part of the syscall so no point in having it here again. Handling calls
> with invalid arguments is not really a performance critical operation.
> 
> ---
>  arch/arm64/include/asm/vdso/compat_gettimeofday.h |   40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> --- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> @@ -16,6 +16,8 @@
>  
>  #define VDSO_HAS_CLOCK_GETRES		1
>  
> +#define VDSO_HAS_32BIT_FALLBACK		1
> +
>  static __always_inline
>  int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
>  			  struct timezone *_tz)
> @@ -52,6 +54,23 @@ long clock_gettime_fallback(clockid_t _c
>  }
>  
>  static __always_inline
> +long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
> +{
> +	register struct old_timespec32 *ts asm("r1") = _ts;
> +	register clockid_t clkid asm("r0") = _clkid;
> +	register long ret asm ("r0");
> +	register long nr asm("r7") = __NR_compat_clock_gettime;
> +
> +	asm volatile(
> +	"	swi #0\n"
> +	: "=r" (ret)
> +	: "r" (clkid), "r" (ts), "r" (nr)
> +	: "memory");
> +
> +	return ret;
> +}
> +
> +static __always_inline
>  int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
>  {
>  	register struct __kernel_timespec *ts asm("r1") = _ts;
> @@ -61,6 +80,27 @@ int clock_getres_fallback(clockid_t _clk
>  
>  	/* The checks below are required for ABI consistency with arm */
>  	if ((_clkid >= MAX_CLOCKS) && (_ts == NULL))
> +		return -EINVAL;
> +
> +	asm volatile(
> +	"       swi #0\n"
> +	: "=r" (ret)
> +	: "r" (clkid), "r" (ts), "r" (nr)
> +	: "memory");
> +
> +	return ret;
> +}
> +
> +static __always_inline
> +int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
> +{
> +	register struct old_timespec32 *ts asm("r1") = _ts;
> +	register clockid_t clkid asm("r0") = _clkid;
> +	register long ret asm ("r0");
> +	register long nr asm("r7") = __NR_compat_clock_getres;
> +
> +	/* The checks below are required for ABI consistency with arm */
> +	if ((_clkid >= MAX_CLOCKS) && (_ts == NULL))
>  		return -EINVAL;
>  
>  	asm volatile(
> 
> 

-- 
Regards,
Vincenzo
