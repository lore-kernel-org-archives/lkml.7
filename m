Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3433BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B101207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfIZMUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:20:16 -0400
Received: from foss.arm.com ([217.140.110.172]:48064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfIZMUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:20:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 240B6142F;
        Thu, 26 Sep 2019 05:20:15 -0700 (PDT)
Received: from [10.37.12.151] (unknown [10.37.12.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFDC43F67D;
        Thu, 26 Sep 2019 05:20:13 -0700 (PDT)
Subject: Re: [PATCH 1/4] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926060353.54894-1-vincenzo.frascino@arm.com>
 <20190926060353.54894-2-vincenzo.frascino@arm.com>
 <20190926080616.GB26802@iMac.local>
 <0ff3d5f4-11c9-4207-c6ab-2f8e9ee7de5e@arm.com>
Message-ID: <ad90f9bb-aa39-615c-3ae5-bea394bd787c@arm.com>
Date:   Thu, 26 Sep 2019 13:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0ff3d5f4-11c9-4207-c6ab-2f8e9ee7de5e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 11:56 AM, Vincenzo Frascino wrote:
> On 9/26/19 9:06 AM, Catalin Marinas wrote:
>> On Thu, Sep 26, 2019 at 07:03:50AM +0100, Vincenzo Frascino wrote:
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 37c610963eee..afe8c948b493 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -110,7 +110,7 @@ config ARM64
>>>  	select GENERIC_STRNLEN_USER
>>>  	select GENERIC_TIME_VSYSCALL
>>>  	select GENERIC_GETTIMEOFDAY
>>> -	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
>>> +	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPAT_CC_IS_GCC)
>>>  	select HANDLE_DOMAIN_IRQ
>>>  	select HARDIRQS_SW_RESEND
>>>  	select HAVE_PCI
>>> @@ -313,6 +313,9 @@ config KASAN_SHADOW_OFFSET
>>>  	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>>>  	default 0xffffffffffffffff
>>>  
>>> +config COMPAT_CC_IS_GCC
>>> +	def_bool $(success,$(CROSS_COMPILE_COMPAT)gcc --version | head -n 1 | grep -q arm)
>>
>> Nitpick: I prefer COMPATCC instead of COMPAT_CC for consistency with
>> HOSTCC.
>>
> 
> Ok, will change this in v2.
> 
>> Now, could we not generate a COMPATCC in the Makefile and use
>> $(COMPATCC) here instead of $(CROSS_COMPILE_COMPAT)gcc? It really
>> doesn't make sense to check that gcc is gcc.
>>
> 
> All right, COMPATCC is already in the makefile, I will use it in here.
>

What you are proposing seems not possible because Kconfig runs first and then
the arch Makefile, hence compatcc does not take effect on the Kconfig. I will
post v2 with what I proposed, please feel free to comment if you have a better idea.

arch/arm64/configs/defconfig:726:warning: symbol value 'm' invalid for
REMOTEPROC
#

# configuration written to .config

#

make[1]: Leaving directory '/data1/Projects/LinuxKernel/linux-out'

make[1]: Entering directory '/data1/Projects/LinuxKernel/linux-out'

$COMPATCC is [arm-linux-gnueabihf-gcc]

  GEN     Makefile

>> A next step would be to check that COMPATCC can actually generate 32-bit
>> objects. But it's not essential at this stage.
>>
> 
> We are already checking this making sure that arm is present in the triple (grep
> -q arm).
> 
>>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>>> index 84a3d502c5a5..34f53eb11878 100644
>>> --- a/arch/arm64/Makefile
>>> +++ b/arch/arm64/Makefile
>>> @@ -54,19 +54,8 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>>>  endif
>>>  
>>>  ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>>> -  CROSS_COMPILE_COMPAT ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
>>> -
>>> -  ifeq ($(CONFIG_CC_IS_CLANG), y)
>>> -    $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
>>> -  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
>>> -    $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
>>> -  else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
>>> -    $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
>>> -  else
>>> -    export CROSS_COMPILE_COMPAT
>>> -    export CONFIG_COMPAT_VDSO := y
>>> -    compat_vdso := -DCONFIG_COMPAT_VDSO=1
>>> -  endif
>>> +  export CONFIG_COMPAT_VDSO := y
>>> +  compat_vdso := -DCONFIG_COMPAT_VDSO=1
>>>  endif
>>
>> Has CONFIG_CROSS_COMPILE_COMPAT_VDSO actually been removed from
>> lib/vdso/Kconfig? (I haven't checked the subsequent patches).
>>
> 

-- 
Regards,
Vincenzo
