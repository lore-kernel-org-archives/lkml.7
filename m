Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96BCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B8F2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCTLMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:12:54 -0400
Received: from foss.arm.com ([217.140.101.70]:38134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfCTLMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:12:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D8E91650;
        Wed, 20 Mar 2019 04:12:53 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 626FD3F575;
        Wed, 20 Mar 2019 04:12:49 -0700 (PDT)
Subject: Re: [PATCH] kvm: arm: Fix handling of stage2 huge mappings
To:     marc.zyngier@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        will.deacon@arm.com, catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry@arm.com, wanghaibin.wang@huawei.com,
        lious.lilei@hisilicon.com, lishuo1@hisilicon.com,
        zhengxiang9@huawei.com, yuzenghui@huawei.com,
        christoffer.dall@arm.com
References: <25971fd5-3774-3389-a82a-04707480c1e0@huawei.com>
 <1553004668-23296-1-git-send-email-suzuki.poulose@arm.com>
 <86d0mmynaz.wl-marc.zyngier@arm.com>
 <5e7e40b4-7983-4440-179a-6f107cee5994@arm.com>
 <20190320101126.11ff63af@why.wild-wind.fr.eu.org>
 <4daf0783-fc50-3346-0732-1e3f53c8ccbc@arm.com>
 <20190320103511.11d777b9@why.wild-wind.fr.eu.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c27d5828-3924-e209-82b6-c9168007867b@arm.com>
Date:   Wed, 20 Mar 2019 11:12:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320103511.11d777b9@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On 20/03/2019 10:35, Marc Zyngier wrote:
> On Wed, 20 Mar 2019 10:23:39 +0000
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
> Hi Suzuki,
> 
>> Marc,
>>
>> On 20/03/2019 10:11, Marc Zyngier wrote:
>>> On Wed, 20 Mar 2019 09:44:38 +0000
>>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>    
>>>> Hi Marc,
>>>>
>>>> On 20/03/2019 08:15, Marc Zyngier wrote:
>>>>> Hi Suzuki,
>>>>>
>>>>> On Tue, 19 Mar 2019 14:11:08 +0000,
>>>>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

...

>>>>>> +		if (!pmd_thp_or_huge(old_pmd)) {
>>>>>> +			unmap_stage2_range(kvm, addr & S2_PMD_MASK, S2_PMD_SIZE);
>>>>>> +			goto retry;
>>>>>   
>>
>>>>>> +		if (!stage2_pud_huge(kvm, old_pud)) {
>>>>>> +			unmap_stage2_range(kvm, addr & S2_PUD_MASK, S2_PUD_SIZE);
>>>>>   
>>
>>>> We should really get rid of the S2_P{U/M}D_* definitions, as they are
>>>> always the same as the host. The only thing that changes is the PGD size
>>>> which varies according to the IPA and the concatenation.
>>>>   
>>
>> Also what do you think about using  P{M,U}D_* instead of S2_P{M,U}D_*
>> above ? I could make that change with the respin.
> 
> Given that this is a fix, I'd like it to be as small as obvious as
> possible, making it easier to backport.
> 
> I'm happy to take another patch for 5.2 that will drop the whole S2_P*
> if we still think that this should be the case (though what I'd really
> like is to have architectural levels instead of these arbitrary
> definitions).

I only meant the two new instances added above in the patch. Of course, I
could send something to fix the existing ones.

Cheers
Suzuki
