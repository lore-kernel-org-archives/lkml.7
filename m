Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0A1C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3304E2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfDQJjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:39:10 -0400
Received: from foss.arm.com ([217.140.101.70]:41566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfDQJjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:39:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0885A374;
        Wed, 17 Apr 2019 02:39:08 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 724023F68F;
        Wed, 17 Apr 2019 02:39:05 -0700 (PDT)
Subject: Re: [PATCH v9 4/5] KVM: arm64: Add capability to advertise ptrauth
 for guest
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        linux-kernel@vger.kernel.org
References: <1555039236-10608-1-git-send-email-amit.kachhap@arm.com>
 <1555039236-10608-5-git-send-email-amit.kachhap@arm.com>
 <20190416163212.GX3567@e103592.cambridge.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <0070b1c2-07d6-7472-1bbc-c252710f6ca3@arm.com>
Date:   Wed, 17 Apr 2019 15:09:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190416163212.GX3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/16/19 10:02 PM, Dave Martin wrote:
> On Fri, Apr 12, 2019 at 08:50:35AM +0530, Amit Daniel Kachhap wrote:
>> This patch advertises the capability of two cpu feature called address
>> pointer authentication and generic pointer authentication. These
>> capabilities depend upon system support for pointer authentication and
>> VHE mode.
>>
>> The current arm64 KVM partially implements pointer authentication and
>> support of address/generic authentication are tied together. However,
>> separate ABI requirements for both of them is added so that any future
>> isolated implementation will not require any ABI changes.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> ---
>> Changes since v8:
>> *  Keep the capability check same for the 2 vcpu ptrauth features. [Dave Martin]
>>
>>   Documentation/virtual/kvm/api.txt | 2 ++
>>   arch/arm64/kvm/reset.c            | 5 +++++
>>   include/uapi/linux/kvm.h          | 2 ++
>>   3 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 9d202f4..56021d0 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -2756,9 +2756,11 @@ Possible features:
>>   	- KVM_ARM_VCPU_PTRAUTH_ADDRESS: Enables Address Pointer authentication
>>   	  for the CPU and supported only on arm64 architecture.
>>   	  Must be requested if KVM_ARM_VCPU_PTRAUTH_GENERIC is also requested.
>> +	  Depends on KVM_CAP_ARM_PTRAUTH_ADDRESS.
> 
> What if KVM_CAP_ARM_PTRAUTH_ADDRESS is absent and
> KVM_ARM_VCPU_PTRAUTH_GENERIC is requested?  By these rules, we have a
> contradiction: userspace both must request and must not request
> KVM_ARM_VCPU_PTRAUTH_ADDRESS.
> 
> We could qualify as follows:
> 
> 	Depends on KVM_CAP_ARM_PTRAUTH_ADDRESS.
> 	Must be requested if KVM_CAP_ARM_PTRAUTH_ADDRESS is present and
> 	KVM_ARM_VCPU_PTRAUTH_GENERIC is also requested.
ok agree. This makes it clear.
> 
>>   	- KVM_ARM_VCPU_PTRAUTH_GENERIC: Enables Generic Pointer authentication
>>   	  for the CPU and supported only on arm64 architecture.
>>   	  Must be requested if KVM_ARM_VCPU_PTRAUTH_ADDRESS is also requested.
>> +	  Depends on KVM_CAP_ARM_PTRAUTH_GENERIC.
> 
> Similarly.
> 
> Or, we go back to having a single cap and a single feature, and add
> more caps/features later on if we decide it's possible to support
> address/generic auth separately later on.
> 
> Otherwise, we end up with complex rules that can't be tested.  This is a
> high price to pay for forwards compatibility: userspace's conformance to
> the rules can't be fully tested, so there's a fair chance it won't work
> properly anyway when hardware/KVM with just one auth type appears.
> 
> [...]
> 
> Thoughts?
I agree that single cpufeature/capability is a simple solution to 
implement. The bifurcation of feature was done to reflect the different 
ID register split up.

But the h/w implementation provides a same EL2 exception trap for both 
the features and hence current implementation ties both of the features 
together. I guess in future if this is limitation goes away then one 
auth type is possible. Here I am not sure if the future h/w will retain 
this merged exception trap and add 2 new separate exception trap in 
addition to it.

I guess it will be probably simple split-up of this merged exception 
trap. In this case there won't be any ABI change required as per current 
implementation.

Thanks,
Amit Daniel


> 
> Cheers
> ---Dave
> 
