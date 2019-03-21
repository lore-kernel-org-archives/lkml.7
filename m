Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F08C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F127A218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfCUIaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:30:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52266 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfCUIaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:30:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 722F580D;
        Thu, 21 Mar 2019 01:30:04 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EDE53F71A;
        Thu, 21 Mar 2019 01:30:00 -0700 (PDT)
Subject: Re: [PATCH v7 7/10] KVM: arm/arm64: context-switch ptrauth registers
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-8-git-send-email-amit.kachhap@arm.com>
 <a3252299-b1ac-3d39-31a4-ca653daa815f@arm.com>
 <44e16529-4792-0ec2-d2d5-f5c14c6bb2c4@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <7e17333e-c05f-0f05-82dc-2185e023e905@arm.com>
Date:   Thu, 21 Mar 2019 08:29:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <44e16529-4792-0ec2-d2d5-f5c14c6bb2c4@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2019 06:08, Amit Daniel Kachhap wrote:
> Hi Julien,
> 
> On 3/20/19 5:43 PM, Julien Thierry wrote:
>> Hi Amit,
>>
>> On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
>>> From: Mark Rutland <mark.rutland@arm.com>
>>>
>>> When pointer authentication is supported, a guest may wish to use it.
>>> This patch adds the necessary KVM infrastructure for this to work, with
>>> a semi-lazy context switch of the pointer auth state.
>>>
>>> Pointer authentication feature is only enabled when VHE is built
>>> in the kernel and present in the CPU implementation so only VHE code
>>> paths are modified.
>>>
>>> When we schedule a vcpu, we disable guest usage of pointer
>>> authentication instructions and accesses to the keys. While these are
>>> disabled, we avoid context-switching the keys. When we trap the guest
>>> trying to use pointer authentication functionality, we change to eagerly
>>> context-switching the keys, and enable the feature. The next time the
>>> vcpu is scheduled out/in, we start again. However the host key save is
>>> optimized and implemented inside ptrauth instruction/register access
>>> trap.
>>>
>>> Pointer authentication consists of address authentication and generic
>>> authentication, and CPUs in a system might have varied support for
>>> either. Where support for either feature is not uniform, it is hidden
>>> from guests via ID register emulation, as a result of the cpufeature
>>> framework in the host.
>>>
>>> Unfortunately, address authentication and generic authentication cannot
>>> be trapped separately, as the architecture provides a single EL2 trap
>>> covering both. If we wish to expose one without the other, we cannot
>>> prevent a (badly-written) guest from intermittently using a feature
>>> which is not uniformly supported (when scheduled on a physical CPU which
>>> supports the relevant feature). Hence, this patch expects both type of
>>> authentication to be present in a cpu.
>>>
>>> This switch of key is done from guest enter/exit assembly as preperation
>>> for the upcoming in-kernel pointer authentication support. Hence, these
>>> key switching routines are not implemented in C code as they may cause
>>> pointer authentication key signing error in some situations.
>>>
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> [Only VHE, key switch in full assembly, vcpu_has_ptrauth checks
>>> , save host key in ptrauth exception trap]
>>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>>> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>> Cc: kvmarm@lists.cs.columbia.edu
>>> ---
>>>   arch/arm64/include/asm/kvm_host.h        |  17 ++++++
>>>   arch/arm64/include/asm/kvm_ptrauth_asm.h | 100
>>> +++++++++++++++++++++++++++++++
>>>   arch/arm64/kernel/asm-offsets.c          |   6 ++
>>>   arch/arm64/kvm/guest.c                   |  14 +++++
>>>   arch/arm64/kvm/handle_exit.c             |  24 +++++---
>>>   arch/arm64/kvm/hyp/entry.S               |   7 +++
>>>   arch/arm64/kvm/reset.c                   |   7 +++
>>>   arch/arm64/kvm/sys_regs.c                |  46 +++++++++++++-
>>>   virt/kvm/arm/arm.c                       |   2 +
>>>   9 files changed, 212 insertions(+), 11 deletions(-)
>>>   create mode 100644 arch/arm64/include/asm/kvm_ptrauth_asm.h
>>>
> [...]
>>> +#ifdef    CONFIG_ARM64_PTR_AUTH
>>> +
>>> +#define PTRAUTH_REG_OFFSET(x)    (x - CPU_APIAKEYLO_EL1)
>>
>> I don't really see the point of this macro. You move the pointers of
>> kvm_cpu_contexts to point to where the ptr auth registers are (which is
>> in the middle of an array) by adding the offset of APIAKEYLO and then we
>> have to recompute all offsets with this macro.
>>
>> Why not just pass the kvm_cpu_context pointers to
>> ptrauth_save/restore_state and use the already defined offsets
>> (CPU_AP*_EL1) directly?
>>
>> I think this would also allow to use one less register for the
>> ptrauth_switch_to_* macros.
> Actually the values of CPU_AP*_EL1 are exceeding the immediate range
> (i.e 512), so this was done to keep the immediate offset within the range.
> The other way would have been to calculate the destination register but
> these would add one more add instruction everywhere.
> I should have mentioned them as comments somewhere.

Oh, I see. Yes, it would definitely be worth a comment.

Thanks,

-- 
Julien Thierry
