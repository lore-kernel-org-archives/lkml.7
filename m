Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2920FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE76320828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCZEMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:12:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfCZEMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:12:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3586A80D;
        Mon, 25 Mar 2019 21:12:07 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DF593F59C;
        Mon, 25 Mar 2019 21:12:03 -0700 (PDT)
Subject: Re: [PATCH v7 8/10] KVM: arm64: Add capability to advertise ptrauth
 for guest
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-9-git-send-email-amit.kachhap@arm.com>
 <1ea6ab95-a52e-3f14-a514-b0b747b85f3a@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <b46cd65c-6e4f-c946-cfb4-df95a718c48f@arm.com>
Date:   Tue, 26 Mar 2019 09:42:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1ea6ab95-a52e-3f14-a514-b0b747b85f3a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/26/19 1:35 AM, Kristina Martsenko wrote:
> On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
>> This patch advertises the capability of pointer authentication
>> when system supports pointer authentication and VHE mode present.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> ---
>>   arch/arm64/kvm/reset.c   | 4 ++++
>>   include/uapi/linux/kvm.h | 1 +
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 00f0639..a3b269e 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -92,6 +92,10 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   	case KVM_CAP_ARM_VM_IPA_SIZE:
>>   		r = kvm_ipa_limit;
>>   		break;
>> +	case KVM_CAP_ARM_PTRAUTH:
>> +		r = has_vhe() && system_supports_address_auth() &&
>> +			system_supports_generic_auth();
>> +		break;
>>   	default:
>>   		r = 0;
>>   	}
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 6d4ea4b..a553477 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -988,6 +988,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_ARM_VM_IPA_SIZE 165
>>   #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
>>   #define KVM_CAP_HYPERV_CPUID 167
>> +#define KVM_CAP_ARM_PTRAUTH 168
> 
> Since we now have two separate vcpu flags, then I think we also need two
> capabilities here (one for address auth and one for generic auth). This
> will allow us to support the features separately in the future if we
> need to.
I have no objection to your suggestion. Infact all other KVM_ARM_VCPU_* 
features have there own capability defined. I will check other 
architectures if they define separate capability for major/minor features.

Thanks,
Amit D
> 
> Thanks,
> Kristina
> 
