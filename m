Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F3BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9043D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfJ2Mao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:30:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfJ2Mao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:30:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 836A69BEE590D4A6CFA9;
        Tue, 29 Oct 2019 20:30:41 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 20:30:32 +0800
Subject: Re: [PATCH 3/3] KVM: arm/arm64: vgic: Don't rely on the wrong pending
 table
To:     Auger Eric <eric.auger@redhat.com>, <maz@kernel.org>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>
CC:     <wanghaibin.wang@huawei.com>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-4-yuzenghui@huawei.com>
 <5e4d1a2f-7107-efe3-9dde-626662e31ac5@redhat.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <825b87df-618f-7f2d-0fe9-4cec240c88bf@huawei.com>
Date:   Tue, 29 Oct 2019 20:30:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <5e4d1a2f-7107-efe3-9dde-626662e31ac5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/29 20:17, Auger Eric wrote:
> Hi Zenghui, Marc,
> 
> On 10/29/19 8:19 AM, Zenghui Yu wrote:
>> It's possible that two LPIs locate in the same "byte_offset" but target
>> two different vcpus, where their pending status are indicated by two
>> different pending tables.  In such a scenario, using last_byte_offset
>> optimization will lead KVM relying on the wrong pending table entry.
>> Let us use last_ptr instead, which can be treated as a byte index into
>> a pending table and also, can be vcpu specific.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>
>> If this patch has done the right thing, we can even add the:
>>
>> Fixes: 280771252c1b ("KVM: arm64: vgic-v3: KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES")
>>
>> But to be honest, I'm not clear about what has this patch actually fixed.
>> Pending tables should contain all zeros before we flush vgic_irq's pending
>> status into guest's RAM (thinking that guest should never write anything
>> into it). So the pending table entry we've read from the guest memory
>> seems always be zero. And we will always do the right thing even if we
>> rely on the wrong pending table entry.
>>
>> I think I must have some misunderstanding here... Please fix me.
>>
>>   virt/kvm/arm/vgic/vgic-v3.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
>> index 5ef93e5041e1..7cd2e2f81513 100644
>> --- a/virt/kvm/arm/vgic/vgic-v3.c
>> +++ b/virt/kvm/arm/vgic/vgic-v3.c
>> @@ -363,8 +363,8 @@ int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, struct vgic_irq *irq)
>>   int vgic_v3_save_pending_tables(struct kvm *kvm)
>>   {
>>   	struct vgic_dist *dist = &kvm->arch.vgic;
>> -	int last_byte_offset = -1;
>>   	struct vgic_irq *irq;
>> +	gpa_t last_ptr = -1;
>>   	int ret;
>>   	u8 val;
>>   
>> @@ -384,11 +384,11 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
>>   		bit_nr = irq->intid % BITS_PER_BYTE;
>>   		ptr = pendbase + byte_offset;
>>   
>> -		if (byte_offset != last_byte_offset) {
>> +		if (ptr != last_ptr) {
>>   			ret = kvm_read_guest_lock(kvm, ptr, &val, 1);
>>   			if (ret)
>>   				return ret;
>> -			last_byte_offset = byte_offset;
>> +			last_ptr = ptr;
>>   		}
>>   
>>   		stored = val & (1U << bit_nr);
>>
> Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks Eric,


Zenghui

