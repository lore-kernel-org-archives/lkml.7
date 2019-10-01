Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7448ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFE721855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbfJAOVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:21:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388942AbfJAOVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:21:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB641570;
        Tue,  1 Oct 2019 07:21:52 -0700 (PDT)
Received: from [10.37.8.149] (unknown [10.37.8.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0F3E3F71A;
        Tue,  1 Oct 2019 07:21:50 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] arm64: vdso32: Detect binutils support for dmb
 ishld
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-3-vincenzo.frascino@arm.com>
 <20191001132640.plowjzi5nmajs72x@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a1b6fbd9-743d-a484-ad41-ff3b66fc0850@arm.com>
Date:   Tue, 1 Oct 2019 15:23:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001132640.plowjzi5nmajs72x@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 2:26 PM, Will Deacon wrote:
> On Thu, Sep 26, 2019 at 10:43:39PM +0100, Vincenzo Frascino wrote:
>> As reported by Will Deacon, older versions of binutils that do not
>> support certain types of memory barriers can cause build failure of the
>> vdso32 library.
>>
>> Add a compilation time mechanism that detects if binutils supports those
>> instructions and configure the kernel accordingly.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/include/asm/vdso/compat_barrier.h | 2 +-
>>  arch/arm64/kernel/vdso32/Makefile            | 9 +++++++++
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
>> index fb60a88b5ed4..3fd8fd6d8fc2 100644
>> --- a/arch/arm64/include/asm/vdso/compat_barrier.h
>> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
>> @@ -20,7 +20,7 @@
>>  
>>  #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
>>  
>> -#if __LINUX_ARM_ARCH__ >= 8
>> +#if __LINUX_ARM_ARCH__ >= 8 && defined(CONFIG_AS_DMB_ISHLD)
>>  #define aarch32_smp_mb()	dmb(ish)
>>  #define aarch32_smp_rmb()	dmb(ishld)
>>  #define aarch32_smp_wmb()	dmb(ishst)
>> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
>> index 19e0d3115ffe..77aa61340374 100644
>> --- a/arch/arm64/kernel/vdso32/Makefile
>> +++ b/arch/arm64/kernel/vdso32/Makefile
>> @@ -15,6 +15,8 @@ cc32-disable-warning = $(call try-run,\
>>  	$(COMPATCC) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>>  cc32-ldoption = $(call try-run,\
>>          $(COMPATCC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
>> +cc32-as-instr = $(call try-run,\
>> +	printf "%b\n" "$(1)" | $(COMPATCC) $(VDSO_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
> 
> It's a shame that we have to duplicate the logic from scripts/Kbuild.include
> here. Is there a way to reuse those helpers by temporarily overriding things
> like CC and KBUILD_AFLAGS? If not, no bother, but thought I'd better ask.
> 

I tried to define a rule in scripts/Kbuild.include at the beginning doing what
you are saying but I could not end up with a working solution, hence I ended up
with a dedicated one.

> Will
> 

-- 
Regards,
Vincenzo
