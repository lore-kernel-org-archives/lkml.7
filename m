Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE14C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFC920854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfCAGKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:10:32 -0500
Received: from foss.arm.com ([217.140.101.70]:58164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfCAGKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:10:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B95F3EBD;
        Thu, 28 Feb 2019 22:10:30 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AF8E3F5C1;
        Thu, 28 Feb 2019 22:10:27 -0800 (PST)
Subject: Re: [PATCH v6 2/6] arm64/kvm: preserve host MDCR_EL2 value
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        linux-kernel@vger.kernel.org
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-3-git-send-email-amit.kachhap@arm.com>
 <20190221155101.GV3567@e103592.cambridge.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <4f97aeda-492b-acd2-8a41-340e8bb47240@arm.com>
Date:   Fri, 1 Mar 2019 11:40:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221155101.GV3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/19 9:21 PM, Dave Martin wrote:
> On Tue, Feb 19, 2019 at 02:54:27PM +0530, Amit Daniel Kachhap wrote:
>> Save host MDCR_EL2 value during kvm HYP initialisation and restore
>> after every switch from host to guest. There should not be any
>> change in functionality due to this.
>>
>> The value of mdcr_el2 is now stored in struct kvm_cpu_context as
>> both host and guest can now use this field in a common way.
> 
> Is MDCR_EL2 somehow relevant to pointer auth?
> 
> It's not entirely clear why this patch is here.
> 
> If this is a cleanup to align the handling of this register with
> how HCR_EL2 is handled, it would be good to explain that in the commit
> message.
Agreed I will more information in commit message.
> 
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> ---
>>   arch/arm/include/asm/kvm_host.h   |  1 -
>>   arch/arm64/include/asm/kvm_host.h |  6 ++----
>>   arch/arm64/kvm/debug.c            | 28 ++++++----------------------
>>   arch/arm64/kvm/hyp/switch.c       | 17 ++++-------------
>>   arch/arm64/kvm/hyp/sysreg-sr.c    |  6 ++++++
>>   virt/kvm/arm/arm.c                |  1 -
>>   6 files changed, 18 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index 05706b4..704667e 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -294,7 +294,6 @@ static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>>   static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
>>   
>> -static inline void kvm_arm_init_debug(void) {}
>>   static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 1b2e05b..2f1bb86 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -205,6 +205,8 @@ struct kvm_cpu_context {
>>   
>>   	/* HYP host/guest configuration */
>>   	u64 hcr_el2;
>> +	u32 mdcr_el2;
>> +
> 
> ARMv8-A says MDCR_EL2 is a 64-bit register.
> 
> Bits [63:20] are currently RES0, so this is probably not a big deal.
> But it would be better to make this 64-bit to prevent future accidents.
> It may be better to make that change in a separate patch.
Yes this a potential issue. I will fix it in a separate patch.

Thanks,
Amit D
> 
> This is probably non-urgent, since this is clearly not causing problems
> for anyone today.
> 
> [...]
> 
> Cheers
> ---Dave
> 
