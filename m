Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B989C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32196218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfB1JZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:25:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfB1JZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:25:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25AFDEBD;
        Thu, 28 Feb 2019 01:25:08 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F2663F738;
        Thu, 28 Feb 2019 01:25:04 -0800 (PST)
Subject: Re: [PATCH v6 4/6] arm64/kvm: add a userspace option to enable
 pointer authentication
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-5-git-send-email-amit.kachhap@arm.com>
 <20190221123416.GD33673@lakrids.cambridge.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <eab4eb68-826e-84af-6e7a-088f45cec22d@arm.com>
Date:   Thu, 28 Feb 2019 14:55:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221123416.GD33673@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/19 6:04 PM, Mark Rutland wrote:
> On Tue, Feb 19, 2019 at 02:54:29PM +0530, Amit Daniel Kachhap wrote:
>> This feature will allow the KVM guest to allow the handling of
>> pointer authentication instructions or to treat them as undefined
>> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
>> supply this parameter instead of creating a new API.
>>
>> A new register is not created to pass this parameter via
>> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
>> supplied is enough to enable this feature.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> ---
>>   Documentation/arm64/pointer-authentication.txt |  9 +++++----
>>   Documentation/virtual/kvm/api.txt              |  4 ++++
>>   arch/arm64/include/asm/kvm_host.h              |  3 ++-
>>   arch/arm64/include/uapi/asm/kvm.h              |  1 +
>>   arch/arm64/kvm/handle_exit.c                   |  2 +-
>>   arch/arm64/kvm/hyp/ptrauth-sr.c                | 16 +++++++++++++++-
>>   arch/arm64/kvm/reset.c                         |  3 +++
>>   arch/arm64/kvm/sys_regs.c                      | 26 +++++++++++++-------------
>>   include/uapi/linux/kvm.h                       |  1 +
>>   9 files changed, 45 insertions(+), 20 deletions(-)
>>
>> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
>> index a25cd21..0529a7d 100644
>> --- a/Documentation/arm64/pointer-authentication.txt
>> +++ b/Documentation/arm64/pointer-authentication.txt
>> @@ -82,7 +82,8 @@ pointers).
>>   Virtualization
>>   --------------
>>   
>> -Pointer authentication is not currently supported in KVM guests. KVM
>> -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
>> -the feature will result in an UNDEFINED exception being injected into
>> -the guest.
>> +Pointer authentication is enabled in KVM guest when virtual machine is
>> +created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
>> +to be enabled. Without this flag, pointer authentication is not enabled
>> +in KVM guests and attempted use of the feature will result in an UNDEFINED
>> +exception being injected into the guest.
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 356156f..1e646fb 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -2642,6 +2642,10 @@ Possible features:
>>   	  Depends on KVM_CAP_ARM_PSCI_0_2.
>>   	- KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
>>   	  Depends on KVM_CAP_ARM_PMU_V3.
>> +	- KVM_ARM_VCPU_PTRAUTH: Emulate Pointer authentication for the CPU.
>> +	  Depends on KVM_CAP_ARM_PTRAUTH and only on arm64 architecture. If
>> +	  set, then the KVM guest allows the execution of pointer authentication
>> +	  instructions. Otherwise, KVM treats these instructions as undefined.
> 
> I think that we should have separate flags for address auth and generic
> auth, to match the ID register split.
> 
> For now, we can have KVM only support the case where both are set, but
> it gives us freedom to support either in isolation if we have to in
> future, without an ABI break.
yes agree with you about having two address and generic ptrauth flags. 
Will add in next iteration.

Thanks,
Amit D
> 
> Thanks,
> Mark.
> 
