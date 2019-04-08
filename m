Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B83C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B0120883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDHIvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:51:49 -0400
Received: from foss.arm.com ([217.140.101.70]:44274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfDHIvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:51:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7787215AD;
        Mon,  8 Apr 2019 01:51:48 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 375663F718;
        Mon,  8 Apr 2019 01:51:44 -0700 (PDT)
Subject: Re: [PATCH v8 8/9] KVM: arm64: Add capability to advertise ptrauth
 for guest
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <1554172037-4516-1-git-send-email-amit.kachhap@arm.com>
 <1554172037-4516-9-git-send-email-amit.kachhap@arm.com>
 <20190405110339.GU3567@e103592.cambridge.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <d50f78e4-6608-fb8a-6b8a-b4c246387d72@arm.com>
Date:   Mon, 8 Apr 2019 14:21:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190405110339.GU3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/5/19 4:33 PM, Dave Martin wrote:
> On Tue, Apr 02, 2019 at 07:57:16AM +0530, Amit Daniel Kachhap wrote:
>> This patch advertises the capability of two cpu feature called address
>> pointer authentication and generic pointer authentication. These
>> capabilities depend upon system support for pointer authentication and
>> VHE mode.
>>
>> The current arm64 KVM partially implements pointer authentication and
>> support of address/generic authentication are tied together. However,
>> separate ABI requirements for both of them is added so that the future
>> isolated implementation will not require any ABI changes.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> ---
>>
>> Changes since v7:
>> * Created 2 capabilities KVM_CAP_ARM_PTRAUTH_ADDRESS and KVM_CAP_ARM_PTRAUTH_GENERIC
>>    instead of one KVM_CAP_ARM_PTRAUTH [Kristina Martsenko].
>> * Added documentation here itself instead of in a new patch.
>>
>>   Documentation/virtual/kvm/api.txt | 3 +++
>>   arch/arm64/kvm/reset.c            | 6 ++++++
>>   include/uapi/linux/kvm.h          | 2 ++
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index aaa048d..9b56892 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -2661,8 +2661,11 @@ Possible features:
>>   	  Depends on KVM_CAP_ARM_PMU_V3.
>>   	- KVM_ARM_VCPU_PTRAUTH_ADDRESS: Enables Address Pointer authentication
>>   	  for the CPU and supported only on arm64 architecture.
>> +	  Depends on KVM_CAP_ARM_PTRAUTH_ADDRESS.
>>   	- KVM_ARM_VCPU_PTRAUTH_GENERIC: Enables Generic Pointer authentication
>>   	  for the CPU and supported only on arm64 architecture.
>> +	  Depends on KVM_CAP_ARM_PTRAUTH_GENERIC.
>>   
>>   
>>   4.83 KVM_ARM_PREFERRED_TARGET
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 717afed..8aa8982 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -92,6 +92,12 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   	case KVM_CAP_ARM_VM_IPA_SIZE:
>>   		r = kvm_ipa_limit;
>>   		break;
>> +	case KVM_CAP_ARM_PTRAUTH_ADDRESS:
>> +		r = has_vhe() && system_supports_address_auth();
>> +		break;
>> +	case KVM_CAP_ARM_PTRAUTH_GENERIC:
>> +		r = has_vhe() && system_supports_generic_auth();
>> +		break;
> 
> If some hardware supports just one auth type, we would report just one
> of these caps.  Although we have the rule that userspace is not allowed
> to request these independently in KVM_ARM_VCPU_INIT anyway, I think it
> would be easier for userspace if we suppress both caps if either auth
> type isn't available on the host.  e.g.:
> 
> 	case KVM_ARM_ARM_PTRAUTH_ADDRESS:
> 	case KVM_ARM_ARM_PTRAUTH_GENERIC:
> 		r = has_vhe() && system_supports_address_auth() &&
> 			system_supports_generic_auth();
> 
> We could revert back to the above code later on, and apply the ABI
> relaxations described in my response to the vcpu features patch, if
> someday we add support to KVM for coping with host hardware that
> supports just one auth type.
These 2 different capabilities are introduced in this iteration so I was 
not clear whether to expose the suppression in capability ioctl level or 
KVM_ARM_VCPU_INIT ioctl level. But agree that this way will be more 
clearer to userspace.
> 
> 
> I'd like Mark to comment on this, since he's more aware of the
> architectural situation than I am.
ok.

Thanks,
Amit D.
> 
> Cheers
> ---Dave
> 
