Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ABA20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbfCARaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:30:30 -0500
Received: from foss.arm.com ([217.140.101.70]:39558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfCARaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:30:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B04FB80D;
        Fri,  1 Mar 2019 09:30:29 -0800 (PST)
Received: from [10.118.34.19] (e107475-lin.austin.arm.com [10.118.34.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 289BC3F575;
        Fri,  1 Mar 2019 09:30:29 -0800 (PST)
Subject: Re: [PATCH v5 03/10] arm64: add sysfs vulnerability show for meltdown
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        marc.zyngier@arm.com, suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-4-jeremy.linton@arm.com>
 <c98ff98e-30e2-596b-39c5-8505ddef9496@foss.arm.com>
 <9cfb9cff-6a26-fff7-9374-82eea0f63a21@arm.com>
 <20190301162050.GB28687@arrakis.emea.arm.com>
 <bd5677d7-a520-c6a4-b97f-d76d48e511a7@arm.com>
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <0cb5730b-987d-334c-35c3-59ca474b9ac7@foss.arm.com>
Date:   Fri, 1 Mar 2019 11:30:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bd5677d7-a520-c6a4-b97f-d76d48e511a7@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/19 10:53 AM, Jeremy Linton wrote:
> Hi,
> 
> On 3/1/19 10:20 AM, Catalin Marinas wrote:
>> On Fri, Mar 01, 2019 at 10:12:09AM -0600, Jeremy Linton wrote:
>>> On 3/1/19 1:11 AM, Andre Przywara wrote:
>>>> On 2/26/19 7:05 PM, Jeremy Linton wrote:
>>>>> Display the mitigation status if active, otherwise
>>>>> assume the cpu is safe unless it doesn't have CSV3
>>>>> and isn't in our whitelist.
>>>>>
>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>> ---
>>>>>    arch/arm64/kernel/cpufeature.c | 47 
>>>>> ++++++++++++++++++++++++++--------
>>>>>    1 file changed, 37 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/cpufeature.c
>>>>> b/arch/arm64/kernel/cpufeature.c
>>>>> index f6d84e2c92fe..d31bd770acba 100644
>>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>>> @@ -944,7 +944,7 @@ has_useable_cnp(const struct
>>>>> arm64_cpu_capabilities *entry, int scope)
>>>>>        return has_cpuid_feature(entry, scope);
>>>>>    }
>>>>> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>>>> +static bool __meltdown_safe = true;
>>>>>    static int __kpti_forced; /* 0: not forced, >0: forced on, <0:
>>>>> forced off */
>>>>>    static bool unmap_kernel_at_el0(const struct
>>>>> arm64_cpu_capabilities *entry,
>>>>> @@ -963,6 +963,16 @@ static bool unmap_kernel_at_el0(const struct
>>>>> arm64_cpu_capabilities *entry,
>>>>>            { /* sentinel */ }
>>>>>        };
>>>>>        char const *str = "command line option";
>>>>> +    bool meltdown_safe;
>>>>> +
>>>>> +    meltdown_safe = is_midr_in_range_list(read_cpuid_id(),
>>>>> kpti_safe_list);
>>>>> +
>>>>> +    /* Defer to CPU feature registers */
>>>>> +    if (has_cpuid_feature(entry, scope))
>>>>> +        meltdown_safe = true;
>>>>> +
>>>>> +    if (!meltdown_safe)
>>>>> +        __meltdown_safe = false;
>>>>>        /*
>>>>>         * For reasons that aren't entirely clear, enabling KPTI on 
>>>>> Cavium
>>>>> @@ -974,6 +984,11 @@ static bool unmap_kernel_at_el0(const struct
>>>>> arm64_cpu_capabilities *entry,
>>>>>            __kpti_forced = -1;
>>>>>        }
>>>>> +    if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0)) {
>>>>> +        pr_info_once("kernel page table isolation disabled by
>>>>> CONFIG\n");
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>>        /* Forced? */
>>>>>        if (__kpti_forced) {
>>>>>            pr_info_once("kernel page table isolation forced %s by 
>>>>> %s\n",
>>>>> @@ -985,14 +1000,10 @@ static bool unmap_kernel_at_el0(const struct
>>>>> arm64_cpu_capabilities *entry,
>>>>>        if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>>>>>            return kaslr_offset() > 0;
>>>>> -    /* Don't force KPTI for CPUs that are not vulnerable */
>>>>> -    if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
>>>>> -        return false;
>>>>> -
>>>>> -    /* Defer to CPU feature registers */
>>>>> -    return !has_cpuid_feature(entry, scope);
>>>>> +    return !meltdown_safe;
>>>>>    }
>>>>> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>>>>    static void
>>>>>    kpti_install_ng_mappings(const struct arm64_cpu_capabilities 
>>>>> *__unused)
>>>>>    {
>>>>> @@ -1022,6 +1033,13 @@ kpti_install_ng_mappings(const struct
>>>>> arm64_cpu_capabilities *__unused)
>>>>>        return;
>>>>>    }
>>>>> +#else
>>>>> +static void
>>>>> +kpti_install_ng_mappings(const struct arm64_cpu_capabilities 
>>>>> *__unused)
>>>>> +{
>>>>> +}
>>>>> +#endif    /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>>>>> +
>>>>>    static int __init parse_kpti(char *str)
>>>>>    {
>>>>> @@ -1035,7 +1053,6 @@ static int __init parse_kpti(char *str)
>>>>>        return 0;
>>>>>    }
>>>>>    early_param("kpti", parse_kpti);
>>>>> -#endif    /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>>>>>    #ifdef CONFIG_ARM64_HW_AFDBM
>>>>>    static inline void __cpu_enable_hw_dbm(void)
>>>>> @@ -1286,7 +1303,6 @@ static const struct arm64_cpu_capabilities
>>>>> arm64_features[] = {
>>>>>            .field_pos = ID_AA64PFR0_EL0_SHIFT,
>>>>>            .min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
>>>>>        },
>>>>> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>>>>        {
>>>>>            .desc = "Kernel page table isolation (KPTI)",
>>>>>            .capability = ARM64_UNMAP_KERNEL_AT_EL0,
>>>>> @@ -1302,7 +1318,6 @@ static const struct arm64_cpu_capabilities
>>>>> arm64_features[] = {
>>>>>            .matches = unmap_kernel_at_el0,
>>>>>            .cpu_enable = kpti_install_ng_mappings,
>>>>>        },
>>>>> -#endif
>>>>>        {
>>>>>            /* FP/SIMD is not implemented */
>>>>>            .capability = ARM64_HAS_NO_FPSIMD,
>>>>> @@ -2063,3 +2078,15 @@ static int __init enable_mrs_emulation(void)
>>>>>    }
>>>>>    core_initcall(enable_mrs_emulation);
>>>>> +
>>>>> +ssize_t cpu_show_meltdown(struct device *dev, struct
>>>>> device_attribute *attr,
>>>>> +        char *buf)
>>>>> +{
>>>>> +    if (arm64_kernel_unmapped_at_el0())
>>>>> +        return sprintf(buf, "Mitigation: KPTI\n");
>>>>> +
>>>>> +    if (__meltdown_safe)
>>>>> +        return sprintf(buf, "Not affected\n");
>>>>
>>>> Shall those two checks be swapped? So it doesn't report about a KPTI
>>>> mitigation if the CPU is safe, but we enable KPTI because of KASLR
>>>> having enabled it? Or is that a different knob?
>>>
>>> Hmmm, I think having it this way reflects the fact that the machine is
>>> mitigated independent of whether it needed it. The force on case is 
>>> similar.
>>> The machine may not have needed the mitigation but it was forced on.
>>
>> So is this patchset about showing vulnerabilities _and_ mitigations or
>> just one of them?
>>
> 
> Well, I don't think there is a way to express a mitigated but not 
> vulnerable state in the current ABI. This set is mostly just to bring us 
> in line with the current ABI expectations.

Yeah, from a user's point of view this is probably just bikeshedding, 
because the system is safe either way. If there are good arguments later 
on to prefer "Not affected" over "Mitigated", we can still change it.

Cheers,
Andre.
