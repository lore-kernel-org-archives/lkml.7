Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842ACC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBE32084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDKJo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:44:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39110 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfDKJo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:44:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCB9A374;
        Thu, 11 Apr 2019 02:44:57 -0700 (PDT)
Received: from [10.37.12.253] (unknown [10.37.12.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27BD23F59C;
        Thu, 11 Apr 2019 02:44:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] kvm: arm: Clean up the checking for huge mapping
To:     yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, julien.thierry@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        andrew.murray@arm.com, eric.auger@redhat.com,
        zhengxiang9@huawei.com, wanghaibin.wang@huawei.com
References: <1554909297-6753-1-git-send-email-suzuki.poulose@arm.com>
 <1554909832-7169-1-git-send-email-suzuki.poulose@arm.com>
 <1554909832-7169-2-git-send-email-suzuki.poulose@arm.com>
 <529f8515-a069-948b-cb63-96fa35b291a6@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ab173598-56a8-f9d3-1165-1bd748c2b8d6@arm.com>
Date:   Thu, 11 Apr 2019 10:47:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <529f8515-a069-948b-cb63-96fa35b291a6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2019 02:48 AM, Zenghui Yu wrote:
> 
> On 2019/4/10 23:23, Suzuki K Poulose wrote:
>> If we are checking whether the stage2 can map PAGE_SIZE,
>> we don't have to do the boundary checks as both the host
>> VMA and the guest memslots are page aligned. Bail the case
>> easily.
>>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   virt/kvm/arm/mmu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index a39dcfd..6d73322 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1624,6 +1624,10 @@ static bool 
>> fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
>>       hva_t uaddr_start, uaddr_end;
>>       size_t size;
>> +    /* The memslot and the VMA are guaranteed to be aligned to 
>> PAGE_SIZE */
>> +    if (map_size == PAGE_SIZE)
>> +        return true;
>> +
>>       size = memslot->npages * PAGE_SIZE;
>>       gpa_start = memslot->base_gfn << PAGE_SHIFT;
>>
> We can do a comment clean up as well in this patch.
> 
> s/<< PAGE_SIZE/<< PAGE_SHIFT/

Sure, I missed that. Will fix it in the next version.

Cheers
Suzuki
