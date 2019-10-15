Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED387C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95082083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfJOJo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:44:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOJo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:44:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B84C28;
        Tue, 15 Oct 2019 02:44:25 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 701283F68E;
        Tue, 15 Oct 2019 02:44:24 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD
 capability
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave P Martin <Dave.Martin@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-2-suzuki.poulose@arm.com>
 <20191011113620.GG27757@arm.com>
 <4ba5c423-4e2a-d810-cd36-32a16ad42c91@arm.com>
 <20191011142137.GH27757@arm.com>
 <418b0c4b-cbcd-4263-276d-1e9edc5eee0b@arm.com>
 <20191014145204.GS27757@arm.com>
 <12e002e7-42e8-c205-e42c-3348359d2f98@arm.com>
 <20191014155009.GM24047@e103592.cambridge.arm.com>
 <CAKv+Gu83oa3+DKNFowVkE=mZfLorAvGQ3GVPiZtsXzQBcsMCWg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2764d8ed-0796-64cc-e3c6-356ba6e67967@arm.com>
Date:   Tue, 15 Oct 2019 10:44:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu83oa3+DKNFowVkE=mZfLorAvGQ3GVPiZtsXzQBcsMCWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/10/2019 17:57, Ard Biesheuvel wrote:
> On Mon, 14 Oct 2019 at 17:50, Dave P Martin <Dave.Martin@arm.com> wrote:
>>
>> On Mon, Oct 14, 2019 at 04:45:40PM +0100, Suzuki K Poulose wrote:
>>>
>>>
>>> On 14/10/2019 15:52, Dave Martin wrote:
>>>> On Fri, Oct 11, 2019 at 06:28:43PM +0100, Suzuki K Poulose wrote:
>>>>>
>>>>>
>>>>> On 11/10/2019 15:21, Dave Martin wrote:
>>>>>> On Fri, Oct 11, 2019 at 01:13:18PM +0100, Suzuki K Poulose wrote: > Hi Dave
>>>>>>>
>>>>>>> On 11/10/2019 12:36, Dave Martin wrote:
>>>>>>>> On Thu, Oct 10, 2019 at 06:15:15PM +0100, Suzuki K Poulose wrote:
>>>>>>>>> The NO_FPSIMD capability is defined with scope SYSTEM, which implies
>>>>>>>>> that the "absence" of FP/SIMD on at least one CPU is detected only
>>>>>>>>> after all the SMP CPUs are brought up. However, we use the status
>>>>>>>>> of this capability for every context switch. So, let us change
>>>>>>>>> the scop to LOCAL_CPU to allow the detection of this capability
>>>>>>>>> as and when the first CPU without FP is brought up.
>>>>>>>>>
>>>>>>>>> Also, the current type allows hotplugged CPU to be brought up without
>>>>>>>>> FP/SIMD when all the current CPUs have FP/SIMD and we have the userspace
>>>>>>>>> up. Fix both of these issues by changing the capability to
>>>>>>>>> BOOT_RESTRICTED_LOCAL_CPU_FEATURE.
>>>>>>>>>
>>>>>>>>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
>>>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>>>> ---
>>>>>>>>>    arch/arm64/kernel/cpufeature.c | 2 +-
>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>>>>>>> index 9323bcc40a58..0f9eace6c64b 100644
>>>>>>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>>>>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>>>>>>> @@ -1361,7 +1361,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>>>>>>>>         {
>>>>>>>>>                 /* FP/SIMD is not implemented */
>>>>>>>>>                 .capability = ARM64_HAS_NO_FPSIMD,
>>>>>>>>> -              .type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>>>>>>>> +              .type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
>>>>>>>>
>>>>>>>> ARM64_HAS_NO_FPSIMD is really a disability, not a capability.
>>>>>>>>
>>>>>>>> Although we have other things that smell like this (CPU errata for
>>>>>>>> example), I wonder whether inverting the meaning in the case would
>>>>>>>> make the situation easier to understand.
>>>>>>>
>>>>>>> Yes, it is indeed a disability, more on that below.
>>>>>>>
>>>>>>>>
>>>>>>>> So, we'd have ARM64_HAS_FPSIMD, with a minimum (signed) feature field
>>>>>>>> value of 0.  Then this just looks like an ARM64_CPUCAP_SYSTEM_FEATURE
>>>>>>>> IIUC.  We'd just need to invert the sense of the check in
>>>>>>>> system_supports_fpsimd().
>>>>>>>
>>>>>>> This is particularly something we want to avoid with this patch. We want
>>>>>>> to make sure that we have the up-to-date status of the disability right
>>>>>>> when it happens. i.e, a CPU without FP/SIMD is brought up. With SYSTEM_FEATURE
>>>>>>> you have to wait until we bring all the CPUs up. Also, for HAS_FPSIMD,
>>>>>>> you must wait until all the CPUs are up, unlike the negated capability.
>>>>>>
>>>>>> I don't see why waiting for the random defective early CPU to come up is
>>>>>> better than waiting for all the early CPUs to come up and then deciding.
>>>>>>
>>>>>> Kernel-mode NEON aside, the status of this cap should not matter until
>>>>>> we enter userspace for the first time.
>>>>>>
>>>>>> The only issue is if e.g., crypto drivers that can use kernel-mode NEON
>>>>>> probe for it before all early CPUs are up, and so cache the wrong
>>>>>> decision.  The current approach doesn't cope with that anyway AFAICT.
>>>>>
>>>>> This approach does in fact. With LOCAL_CPU scope, the moment a defective
>>>>> CPU turns up, we mark the "capability" and thus the kernel cannot use
>>>>> the neon then onwards, unlike the existing case where we have time till
>>>>> we boot all the CPUs (even when the boot CPU may be defective).
>>>>
>>>> I guess that makes sense.
>>>>
>>>> I'm now wondering what happens if anything tries to use kernel-mode NEON
>>>> before SVE is initialised -- which doesn't happen until cpufeatures
>>>> configures the system features.
>>>>
>>>> I don't think your proposed change makes anything worse here, but it may
>>>> need looking into.
>>>
>>> We could throw in a WARN_ON() in kernel_neon() to make sure that the SVE
>>> is initialised ?
>>
>> Could do, at least as an experiment.
>>
>> Ard, do you have any thoughts on this?
>>
> 
> All in-kernel NEON code checks whether the NEON is usable, so I'd
> expect that check to return 'false' if it is too early in the boot for
> the NEON to be used at all.

Ok. That implies, we need a check to make sure SVE set up is complete,
which we don't at the moment, as we default to assume FP/SIMD is available.

"system_can_use_fpsimd()" instead of the "system_supports_fpsimd() where
the former should indicate:

  system_supports_fpsimd() && sve_setup_complete()

Where the sve_setup_complete() can itself be a static key, initialized
very early if we have !CONFIG_SVE. Otherwise, set from sve_setup().


Thoughts ?
Suzuki

