Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1946C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B276E21D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfJKMNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:13:21 -0400
Received: from foss.arm.com ([217.140.110.172]:58308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfJKMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:13:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EFA028;
        Fri, 11 Oct 2019 05:13:20 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBF023F6C4;
        Fri, 11 Oct 2019 05:13:19 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD
 capability
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        will@kernel.org
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-2-suzuki.poulose@arm.com>
 <20191011113620.GG27757@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4ba5c423-4e2a-d810-cd36-32a16ad42c91@arm.com>
Date:   Fri, 11 Oct 2019 13:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011113620.GG27757@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave

On 11/10/2019 12:36, Dave Martin wrote:
> On Thu, Oct 10, 2019 at 06:15:15PM +0100, Suzuki K Poulose wrote:
>> The NO_FPSIMD capability is defined with scope SYSTEM, which implies
>> that the "absence" of FP/SIMD on at least one CPU is detected only
>> after all the SMP CPUs are brought up. However, we use the status
>> of this capability for every context switch. So, let us change
>> the scop to LOCAL_CPU to allow the detection of this capability
>> as and when the first CPU without FP is brought up.
>>
>> Also, the current type allows hotplugged CPU to be brought up without
>> FP/SIMD when all the current CPUs have FP/SIMD and we have the userspace
>> up. Fix both of these issues by changing the capability to
>> BOOT_RESTRICTED_LOCAL_CPU_FEATURE.
>>
>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 9323bcc40a58..0f9eace6c64b 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1361,7 +1361,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   	{
>>   		/* FP/SIMD is not implemented */
>>   		.capability = ARM64_HAS_NO_FPSIMD,
>> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>> +		.type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
> 
> ARM64_HAS_NO_FPSIMD is really a disability, not a capability.
> 
> Although we have other things that smell like this (CPU errata for
> example), I wonder whether inverting the meaning in the case would
> make the situation easier to understand.

Yes, it is indeed a disability, more on that below.

> 
> So, we'd have ARM64_HAS_FPSIMD, with a minimum (signed) feature field
> value of 0.  Then this just looks like an ARM64_CPUCAP_SYSTEM_FEATURE
> IIUC.  We'd just need to invert the sense of the check in
> system_supports_fpsimd().

This is particularly something we want to avoid with this patch. We want
to make sure that we have the up-to-date status of the disability right
when it happens. i.e, a CPU without FP/SIMD is brought up. With SYSTEM_FEATURE
you have to wait until we bring all the CPUs up. Also, for HAS_FPSIMD,
you must wait until all the CPUs are up, unlike the negated capability.

> 
>>   		.min_field_value = 0,
> 
> (Does .min_field_value == 0 make sense, or is it even used?  I thought
> only the default has_cpuid_feature() match logic uses that.)

True, it is not used for this particular case.

Cheers
Suzuki
