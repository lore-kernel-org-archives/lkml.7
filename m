Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C461AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFD12082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbfCZSBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:01:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732069AbfCZSBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:01:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 685501596;
        Tue, 26 Mar 2019 11:01:48 -0700 (PDT)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9713F614;
        Tue, 26 Mar 2019 11:01:45 -0700 (PDT)
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
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-8-git-send-email-amit.kachhap@arm.com>
 <64505666-8a1f-cf64-7067-4b2dd53b0b40@arm.com>
 <da7091a9-01b2-bead-3777-972fbb293def@arm.com>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
Message-ID: <949327ae-081c-0964-3315-ac2695243b5f@arm.com>
Date:   Tue, 26 Mar 2019 18:01:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <da7091a9-01b2-bead-3777-972fbb293def@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 04:03, Amit Daniel Kachhap wrote:
> Hi,
> 
> On 3/26/19 1:34 AM, Kristina Martsenko wrote:
>> On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
>>> From: Mark Rutland <mark.rutland@arm.com>
>>>
>>> When pointer authentication is supported, a guest may wish to use it.
>>> This patch adds the necessary KVM infrastructure for this to work, with
>>> a semi-lazy context switch of the pointer auth state.
>>
>> [...]
>>
>>> +    if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, vcpu->arch.features) ||
>>> +        test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, vcpu->arch.features)) {
>>> +        /* Verify that KVM startup matches the conditions for ptrauth */
>>> +        if (WARN_ON(!vcpu_has_ptrauth(vcpu)))
>>> +            return -EINVAL;
>>> +    }
>>
>> I think this now needs to have "goto out;" instead of "return -EINVAL;",
>> since 5.1-rcX contains commit e761a927bc9a ("KVM: arm/arm64: Reset the
>> VCPU without preemption and vcpu state loaded") which changed some of
>> this code.
> ok missed the changes for this commit.

One more thing - I think the WARN_ON() here should be removed. Otherwise
if panic_on_warn is set then userspace can panic the kernel. I think
WARN_ON is only for internal kernel errors (see comment in
include/asm-generic/bug.h).

Thanks,
Kristina
