Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9DCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67D420874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfJ2M2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:28:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729317AbfJ2M2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:28:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 41C96AAB6D429E4EEA23;
        Tue, 29 Oct 2019 20:28:06 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 20:27:58 +0800
Subject: Re: [PATCH 3/3] KVM: arm/arm64: vgic: Don't rely on the wrong pending
 table
To:     Marc Zyngier <maz@kernel.org>
CC:     <eric.auger@redhat.com>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-4-yuzenghui@huawei.com> <86mudjykfa.wl-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f8a30e65-7077-301a-1558-7fc504b5e891@huawei.com>
Date:   Tue, 29 Oct 2019 20:27:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <86mudjykfa.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/10/29 17:23, Marc Zyngier wrote:
> On Tue, 29 Oct 2019 07:19:19 +0000,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
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
> 
> I think you're spot on, and it is the code needs fixing, not you! The
> problem is that we only read a byte once, irrespective of the vcpu the
> interrupts is routed to. If we switch to another vcpu for the same
> byte offset, we must reload it.
> 
> This can be done by either checking the vcpu, or by tracking the guest
> address that we read from (just like you do here).

okay, the remaining question is that in vgic_v3_save_pending_tables():

	stored = val & (1U << bit_nr);
	if (stored == irq->pending_latch)
		continue;

	if (irq->pending_latch)
		val |= 1 << bit_nr;
	else
		val &= ~(1 << bit_nr);

Do we really have a scenario where irq->pending_latch==false and
stored==true (corresponds to the above "else") and then we clear
pending status of this LPI in guest memory?
I can not think out one now.

> 
> A small comment below:
> 
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
> 
> This should be written as
> 
>       gpa_t last_ptr = ~(gpa_t)0;

Thanks for pointing it out.

> 
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
> 
> Otherwise, this looks good to me (no need to respin for the above
> nit).

Thanks,

Zenghui

