Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57840C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FF820883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfE1MsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:48:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56858 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfE1MsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:48:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FDF580D;
        Tue, 28 May 2019 05:48:22 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A42393F5AF;
        Tue, 28 May 2019 05:48:19 -0700 (PDT)
Subject: Re: [kvmtool PATCH v10 5/5] KVM: arm/arm64: Add a vcpu feature for
 pointer authentication
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <1555994558-26349-1-git-send-email-amit.kachhap@arm.com>
 <1555994558-26349-6-git-send-email-amit.kachhap@arm.com>
 <20190423154625.GP3567@e103592.cambridge.arm.com>
 <3b7bafc9-5d6a-7845-ef1f-577ea59000e2@arm.com>
 <20190424134120.GW3567@e103592.cambridge.arm.com>
 <20190528101128.GB28398@e103592.cambridge.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <53ecc253-e9e0-a6ca-2540-fa85bd26bfc1@arm.com>
Date:   Tue, 28 May 2019 18:18:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190528101128.GB28398@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 5/28/19 3:41 PM, Dave Martin wrote:
> On Wed, Apr 24, 2019 at 02:41:21PM +0100, Dave Martin wrote:
>> On Wed, Apr 24, 2019 at 12:32:22PM +0530, Amit Daniel Kachhap wrote:
>>> Hi,
>>>
>>> On 4/23/19 9:16 PM, Dave Martin wrote:
> 
> [...]
> 
>>>>> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
>>>>> index 7780251..acd1d5f 100644
>>>>> --- a/arm/kvm-cpu.c
>>>>> +++ b/arm/kvm-cpu.c
>>>>> @@ -68,6 +68,18 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>>>>>   		vcpu_init.features[0] |= (1UL << KVM_ARM_VCPU_PSCI_0_2);
>>>>>   	}
>>>>> +	/* Check Pointer Authentication command line arguments. */
>>>>> +	if (kvm->cfg.arch.enable_ptrauth && kvm->cfg.arch.disable_ptrauth)
>>>>> +		die("Both enable-ptrauth and disable-ptrauth option cannot be present");
>>>>
>>>> Preferably, print the leading dashes, the same as the user would see
>>>> on the command line (e.g., --enable-ptrauth, --disable-ptrauth).
>>>>
>>>> For brevity, we could write something like:
>>>>
>>>> 		die("--enable-ptrauth conflicts with --disable-ptrauth");
> 
> [...]
> 
>>>>> @@ -106,8 +118,12 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>>>>>   			die("Unable to find matching target");
>>>>>   	}
>>>>> -	if (err || target->init(vcpu))
>>>>> -		die("Unable to initialise vcpu");
>>>>> +	if (err || target->init(vcpu)) {
>>>>> +		if (kvm->cfg.arch.enable_ptrauth)
>>>>> +			die("Unable to initialise vcpu with pointer authentication feature");
>>>>
>>>> We don't special-case this error message for any other feature yet:
>>>> there are a variety of reasons why we might have failed, so suggesting
>>>> that the failure is something to do with ptrauth may be misleading to
>>>> the user.
>>>>
>>>> If we want to be more informative, we could do something like the
>>>> following:
>>>>
>>>> 	bool supported;
>>>>
>>>> 	supported = kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
>>>> 		    kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_GENERIC);
>>>>
>>>> 	if (kvm->cfg.arch.enable_ptrauth && !supported)
>>>> 		die("--enable-ptrauth not supported on this host");
>>>>
>>>> 	if (supported && !kvm->cfg.arch.disable_ptrauth)
>>>> 		vcpu_init.features[0] |= ARM_VCPU_PTRAUTH_FEATURE;
>>>>
>>>> 	/* ... */
>>>>
>>>> 	if (err || target->init(vcpu))
>>>> 		die("Unable to initialise vcpu");
>>>>
>>>> We don't do this for any other feature today, but since it helps the
>>>> user to understand what went wrong it's probably a good idea.
>>> Yes this is more clear. As Mark has picked the core guest ptrauth patches. I
>>> will post this changes as standalone.
>>
>> Sounds good.  (I also need to do that separately for SVE...)
> 
> Were you planning to repost this?
> 
> Alternatively, I can fix up the diagnostic messages discussed here and
> post it together with the SVE support.  I'll do that locally for now,
> but let me know what you plan to do.  I'd like to get the SVE support
> posted soon so that people can test it.
I will clean up the print messages as you suggested and repost it shortly.

Thanks,
Amit Daniel
> 
> Cheers
> ---Dave
> 
