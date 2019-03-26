Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB2FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C04720811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfCZDzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:55:43 -0400
Received: from foss.arm.com ([217.140.101.70]:58852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbfCZDzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:55:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CEC180D;
        Mon, 25 Mar 2019 20:55:42 -0700 (PDT)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6F353F59C;
        Mon, 25 Mar 2019 20:55:38 -0700 (PDT)
Subject: Re: [PATCH v7 5/10] KVM: arm/arm64: preserve host MDCR_EL2 value
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
 <1552984243-7689-6-git-send-email-amit.kachhap@arm.com>
 <19c2bdb3-6917-286e-3f2a-35fd71f69f51@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <bce98120-b844-f4a2-cd44-a0e8418dfd13@arm.com>
Date:   Tue, 26 Mar 2019 09:25:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <19c2bdb3-6917-286e-3f2a-35fd71f69f51@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/26/19 1:34 AM, Kristina Martsenko wrote:
> On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
>> Save host MDCR_EL2 value during kvm HYP initialisation and restore
>> after every switch from host to guest. There should not be any
>> change in functionality due to this.
>>
>> The value of mdcr_el2 is now stored in struct kvm_cpu_context as
>> both host and guest can now use this field in a common way.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
> 
> [...]
> 
>>   /**
>> - * kvm_arm_init_debug - grab what we need for debug
>> - *
>> - * Currently the sole task of this function is to retrieve the initial
>> - * value of mdcr_el2 so we can preserve MDCR_EL2.HPMN which has
>> - * presumably been set-up by some knowledgeable bootcode.
>> - *
>> - * It is called once per-cpu during CPU hyp initialisation.
>> - */
>> -
>> -void kvm_arm_init_debug(void)
>> -{
>> -	__this_cpu_write(mdcr_el2, kvm_call_hyp_ret(__kvm_get_mdcr_el2));
>> -}
> 
> The __kvm_get_mdcr_el2 function is no longer used anywhere, so can also
> be removed.
Nice catch. Will do.

Thanks,
Amit D
> 
> Thanks,
> Kristina
> 
