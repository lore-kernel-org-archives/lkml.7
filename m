Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A94CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD78218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCTSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:07:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfCTSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:06:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09CF8A78;
        Wed, 20 Mar 2019 11:06:59 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CC453F614;
        Wed, 20 Mar 2019 11:06:55 -0700 (PDT)
Subject: Re: [PATCH v7 9/10] KVM: arm64: docs: document KVM support of pointer
 authentication
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
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
        James Morse <james.morse@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-10-git-send-email-amit.kachhap@arm.com>
 <7bf19035-02ba-ae47-b08c-7d7622a45dbf@arm.com>
 <648d66dd-519c-7567-a3e1-c23208f68cf2@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <52d3f9c8-fc27-bf3d-f8f3-1b3921508a8c@arm.com>
Date:   Wed, 20 Mar 2019 18:06:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <648d66dd-519c-7567-a3e1-c23208f68cf2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2019 15:04, Kristina Martsenko wrote:
> On 20/03/2019 13:37, Julien Thierry wrote:
>> Hi Amit,
>>
>> On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
>>> This adds sections for KVM API extension for pointer authentication.
>>> A brief description about usage of pointer authentication for KVM guests
>>> is added in the arm64 documentations.
> 
> [...]
> 
>>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>>> index 7de9eee..b5c66bc 100644
>>> --- a/Documentation/virtual/kvm/api.txt
>>> +++ b/Documentation/virtual/kvm/api.txt
>>> @@ -2659,6 +2659,12 @@ Possible features:
>>>  	  Depends on KVM_CAP_ARM_PSCI_0_2.
>>>  	- KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
>>>  	  Depends on KVM_CAP_ARM_PMU_V3.
>>> +	- KVM_ARM_VCPU_PTRAUTH_ADDRESS:
>>> +	- KVM_ARM_VCPU_PTRAUTH_GENERIC:
>>> +	  Enables Pointer authentication for the CPU.
>>> +	  Depends on KVM_CAP_ARM_PTRAUTH and only on arm64 architecture. If
>>> +	  set, then the KVM guest allows the execution of pointer authentication
>>> +	  instructions. Otherwise, KVM treats these instructions as undefined.
>>>  
>>
>> Overall I feel one could easily get confused to whether
>> PTRAUTH_ADDRESS/GENERIC are two individual features, whether one is a
>> superset of the other, if the names are just an alias of one another, etc...
>>
>> I think the doc should at least stress out that *both* flags are
>> required to enable ptrauth in a guest. However it raises the question,
>> if we don't plan to support the features individually (because we
>> can't), should we really expose two feature flags? I seems odd to
>> introduce two flags that only do something if used together...
> 
> Why can't we support the features individually? For example, if we ever
> get a system where all CPUs support address authentication and none of
> them support generic authentication, then we could still support address
> authentication in the guest.
> 
> 

That's a good point, I didn't think of that.

Although, currently we don't have a way to detect that we are in such a
configuration. So as is, both flags are required to enable either
feature, and I feel the documentation should be clear on that aspect.

Another option would be to introduce a flag that enables both for now,
and if one day we decide to support the configuration you mentioned we
could add "more modular" flags that allow you to control those features
individually. While a bit cumbersome, I would find that less awkward
than having two flags that only do something if both are present.

Thanks,

-- 
Julien Thierry
