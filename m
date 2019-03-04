Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41757C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1507520815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCDLIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:08:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60332 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfCDLIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:08:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0555EEBD;
        Mon,  4 Mar 2019 03:08:24 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9DB3F703;
        Mon,  4 Mar 2019 03:08:21 -0800 (PST)
Subject: Re: [kvmtool PATCH v6 6/6] arm/kvm: arm64: Add a vcpu feature for
 pointer authentication
To:     Dave P Martin <Dave.Martin@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Kristina Martsenko <Kristina.Martsenko@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-7-git-send-email-amit.kachhap@arm.com>
 <20190221155409.GA3567@e103592.cambridge.arm.com>
 <048f772a-1faf-5fa3-d82c-25212a5104af@arm.com>
 <20190301112452.GS16031@e103592.cambridge.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <b21de5ed-197d-3ea7-021c-b3bca312e70c@arm.com>
Date:   Mon, 4 Mar 2019 16:38:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190301112452.GS16031@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

On 3/1/19 4:54 PM, Dave P Martin wrote:
> On Fri, Mar 01, 2019 at 10:37:54AM +0000, Amit Daniel Kachhap wrote:
>> Hi,
>>
>> On 2/21/19 9:24 PM, Dave Martin wrote:
>>> On Tue, Feb 19, 2019 at 02:54:31PM +0530, Amit Daniel Kachhap wrote:
> 
> [...]
> 
>>>> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
>>>> index 04be43d..2074684 100644
>>>> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
>>>> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
>>>> @@ -8,7 +8,9 @@
>>>>    			"Create PMUv3 device"),				\
>>>>    	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
>>>>    			"Specify random seed for Kernel Address Space "	\
>>>> -			"Layout Randomization (KASLR)"),
>>>> +			"Layout Randomization (KASLR)"),		\
>>>> +	OPT_BOOLEAN('\0', "ptrauth", &(cfg)->has_ptrauth,		\
>>>> +			"Enable address authentication"),
>>>
>>> Nit: doesn't this enable address *and* generic authentication?  The
>>> discussion on what capababilities and enables the ABI exposes probably
>>> needs to conclude before we can finalise this here.
>> ok.
>>>
>>> However, I would recommend that we provide a single option here that
>>> turns both address authentication and generic authentication on, even
>>> if the ABI treats them independently.  This is expected to be the common
>>> case by far.
>> ok
>>>
>>> We can always add more fine-grained options later if it turns out to be
>>> necessary.
>> Mark suggested to provide 2 flags [1] for Address and Generic
>> authentication so I was thinking of adding 2 features like,
>>
>> +#define KVM_ARM_VCPU_PTRAUTH_ADDR		4 /* CPU uses pointer address
>> authentication */
>> +#define KVM_ARM_VCPU_PTRAUTH_GENERIC		5 /* CPU uses pointer generic
>> authentication */
>>
>> And supply both of them concatenated in VCPU_INIT stage. Kernel KVM
>> would expect both feature requested together.
> 
> Seems reasonable.  Do you mean the kernel would treat it as an error if
> only one of these flags is passed to KVM_ARM_VCPU_INIT, or would KVM
> simply treat them as independent?
If both flags are passed together then only start using ptrauth 
otherwise keep ptrauth disabled. This is just to finalize the user side 
abi as of now and KVM can be updated later.

Thanks,
Amit D
> 
> [...]
> 
>>>> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
>>>> index 7780251..4ac80f8 100644
>>>> --- a/arm/kvm-cpu.c
>>>> +++ b/arm/kvm-cpu.c
>>>> @@ -68,6 +68,12 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>>>>    		vcpu_init.features[0] |= (1UL << KVM_ARM_VCPU_PSCI_0_2);
>>>>    	}
>>>>    
>>>> +	/* Set KVM_ARM_VCPU_PTRAUTH if available */
>>>> +	if (kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH)) {
>>>> +		if (kvm->cfg.arch.has_ptrauth)
>>>> +			vcpu_init.features[0] |= ARM_VCPU_PTRAUTH_FEATURE;
>>>> +	}
>>>> +
>>>
>>> I'm not too keen on requiring a dummy #define for AArch32 here.  How do
>>> we handle other subarch-specific feature flags?  Is there something we
>>> can reuse?
>> I will check it.
> 
> OK
> 
> Cheers
> ---Dave
> 
