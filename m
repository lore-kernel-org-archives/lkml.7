Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D20C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4182083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbfCAQQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:16:43 -0500
Received: from foss.arm.com ([217.140.101.70]:38220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfCAQQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:16:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6D4280D;
        Fri,  1 Mar 2019 08:16:42 -0800 (PST)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12A033F575;
        Fri,  1 Mar 2019 08:16:42 -0800 (PST)
Subject: Re: [PATCH v5 08/10] arm64: Always enable ssb vulnerability detection
To:     Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-9-jeremy.linton@arm.com>
 <5c76075d-1889-ff75-0567-f3e2df7079f4@foss.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <1b07e031-6b82-2a9e-9c0e-0617685b9ef3@arm.com>
Date:   Fri, 1 Mar 2019 10:16:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5c76075d-1889-ff75-0567-f3e2df7079f4@foss.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/19 1:02 AM, Andre Przywara wrote:
> Hi,
> 
> On 2/26/19 7:05 PM, Jeremy Linton wrote:
>> The ssb detection logic is necessary regardless of whether
>> the vulnerability mitigation code is built into the kernel.
>> Break it out so that the CONFIG option only controls the
>> mitigation logic and not the vulnerability detection.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h |  4 ----
>>   arch/arm64/kernel/cpu_errata.c      | 11 +++++++----
>>   2 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h 
>> b/arch/arm64/include/asm/cpufeature.h
>> index dfcfba725d72..c2b60a021437 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -628,11 +628,7 @@ static inline int arm64_get_ssbd_state(void)
>>   #endif
>>   }
>> -#ifdef CONFIG_ARM64_SSBD
>>   void arm64_set_ssbd_mitigation(bool state);
>> -#else
>> -static inline void arm64_set_ssbd_mitigation(bool state) {}
>> -#endif
>>   extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>> diff --git a/arch/arm64/kernel/cpu_errata.c 
>> b/arch/arm64/kernel/cpu_errata.c
>> index 0f6e8f5d67bc..5f5611d17dc1 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -276,7 +276,6 @@ static int detect_harden_bp_fw(void)
>>       return 1;
>>   }
>> -#ifdef CONFIG_ARM64_SSBD
>>   DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>>   int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
>> @@ -347,6 +346,7 @@ void __init arm64_enable_wa2_handling(struct 
>> alt_instr *alt,
>>           *updptr = cpu_to_le32(aarch64_insn_gen_nop());
>>   }
>> +#ifdef CONFIG_ARM64_SSBD
>>   void arm64_set_ssbd_mitigation(bool state)
>>   {
>>       if (this_cpu_has_cap(ARM64_SSBS)) {
>> @@ -371,6 +371,12 @@ void arm64_set_ssbd_mitigation(bool state)
>>           break;
>>       }
>>   }
>> +#else
>> +void arm64_set_ssbd_mitigation(bool state)
>> +{
>> +    pr_info_once("SSBD, disabled by kernel configuration\n");
> 
> Is there a stray comma or is the continuation of some previous printout?

This is on purpose because I didn't like the way it read if you expanded 
the acronym. I still don't, maybe a ":" is more appropriate.


> 
> Regardless of that it looks good and compiles with both 
> CONFIG_ARM64_SSBD defined or not:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> Cheers,
> Andre.
> 
>> +}
>> +#endif    /* CONFIG_ARM64_SSBD */
>>   static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities 
>> *entry,
>>                       int scope)
>> @@ -468,7 +474,6 @@ static bool has_ssbd_mitigation(const struct 
>> arm64_cpu_capabilities *entry,
>>       return required;
>>   }
>> -#endif    /* CONFIG_ARM64_SSBD */
>>   static void __maybe_unused
>>   cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities 
>> *__unused)
>> @@ -760,14 +765,12 @@ const struct arm64_cpu_capabilities 
>> arm64_errata[] = {
>>           ERRATA_MIDR_RANGE_LIST(arm64_harden_el2_vectors),
>>       },
>>   #endif
>> -#ifdef CONFIG_ARM64_SSBD
>>       {
>>           .desc = "Speculative Store Bypass Disable",
>>           .capability = ARM64_SSBD,
>>           .type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>>           .matches = has_ssbd_mitigation,
>>       },
>> -#endif
>>   #ifdef CONFIG_ARM64_ERRATUM_1188873
>>       {
>>           /* Cortex-A76 r0p0 to r2p0 */
>>

