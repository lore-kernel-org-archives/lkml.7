Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9673ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919F321906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbfJAOSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:18:49 -0400
Received: from foss.arm.com ([217.140.110.172]:50656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfJAOSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:18:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDD671000;
        Tue,  1 Oct 2019 07:18:47 -0700 (PDT)
Received: from [10.37.8.149] (unknown [10.37.8.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24E0F3F71A;
        Tue,  1 Oct 2019 07:18:45 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        tglx@linutronix.de
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
 <20191001132731.GG41399@arrakis.emea.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
Date:   Tue, 1 Oct 2019 15:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001132731.GG41399@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 2:27 PM, Catalin Marinas wrote:
> On Tue, Oct 01, 2019 at 02:14:23PM +0100, Will Deacon wrote:
>> On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 37c610963eee..0e5beb928af5 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -110,7 +110,7 @@ config ARM64
>>>  	select GENERIC_STRNLEN_USER
>>>  	select GENERIC_TIME_VSYSCALL
>>>  	select GENERIC_GETTIMEOFDAY
>>> -	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
>>> +	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPATCC_IS_ARM_GCC)
>>>  	select HANDLE_DOMAIN_IRQ
>>>  	select HARDIRQS_SW_RESEND
>>>  	select HAVE_PCI
>>> @@ -313,6 +313,9 @@ config KASAN_SHADOW_OFFSET
>>>  	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>>>  	default 0xffffffffffffffff
>>>  
>>> +config COMPATCC_IS_ARM_GCC
>>> +	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")
>>
>> I've seen toolchains where the first part of the tuple is "armv7-", so they
>> won't get detected here. However, do we really need to detect this? If
>> somebody passes a duff compiler, then the build will fail in the same way as
>> if they passed it to CROSS_COMPILE=.
> 
> Not sure what happens if we pass an aarch64 compiler. Can we end up with
> a 64-bit compat vDSO?
> 

I agree with Catalin here. The problem is not only when you pass and aarch64
toolchain but even an x86 and so on.

If the problem is related to armv7- we can change the rule as "arm.*-gcc" which
should detect them as well. Do you know what is the triple that an armv7-
toolchain prints?

-- 
Regards,
Vincenzo
