Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A4C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183CA20709
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLXCwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:52:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfLXCwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:52:37 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1582691D5E6EDCC03903;
        Tue, 24 Dec 2019 10:52:35 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 10:52:27 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as
 RAZ
To:     Marc Zyngier <maz@kernel.org>
CC:     <andre.przywara@arm.com>, <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>
References: <20191220111833.1422-1-yuzenghui@huawei.com>
 <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
 <c084aa29c029f97cdfb1b5dc9e6b29ac@www.loen.fr>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <1225d839-3cf7-d513-778e-698e12e94875@huawei.com>
Date:   Tue, 24 Dec 2019 10:52:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <c084aa29c029f97cdfb1b5dc9e6b29ac@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Eric,

On 2019/12/23 22:07, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2019-12-23 13:43, Zenghui Yu wrote:
>> On 2019/12/20 19:18, Zenghui Yu wrote:
>>> Although guest will hardly read and use the PTZ (Pending Table Zero)
>>> bit in GICR_PENDBASER, let us emulate the architecture strictly.
>>> As per IHI 0069E 9.11.30, PTZ field is WO, and reads as 0.
>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>> ---
>>> Noticed when checking all fields of GICR_PENDBASER register.
>>> But _not_ sure whether it's worth a fix, as Linux never sets
>>> the PTZ bit before enabling LPI (set GICR_CTLR_ENABLE_LPIS).
>>> And I wonder under which scenarios can this bit be written as 1.
>>> It seems difficult for software to determine whether the pending
>>> table contains all zeros when writing this bit.
>>> virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c 
>>> b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>> index 7dfd15dbb308..ebc218840fc2 100644
>>> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>> @@ -414,8 +414,11 @@ static unsigned long 
>>> vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
>>>                            gpa_t addr, unsigned int len)
>>>   {
>>>       struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>> +    u64 value = vgic_cpu->pendbaser;
>>>   -    return extract_bytes(vgic_cpu->pendbaser, addr & 7, len);
>>> +    value &= ~GICR_PENDBASER_PTZ;
>>> +
>>> +    return extract_bytes(value, addr & 7, len);
>>>   }
>>>   static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,
>>>
>>
>> I noticed there is no userspace access callbacks for GICR_PENDBASER,
>> so this patch will make the PTZ field also 'Read As Zero' by userspace.
>> Should we consider adding a uaccess_read callback for GICR_PENDBASER
>> which just returns the unchanged vgic_cpu->pendbaser to userspace?
>> (Though this is really not a big deal. We now always emulate the PTZ
>> field to guest as RAZ. And 'vgic_cpu->pendbaser & GICR_PENDBASER_PTZ'
>> only indicates whether KVM will optimize the LPI enabling process,
>> where Read As Zero indicates never optimize..)
> 
> I don't think adding a userspace accessor would help much. All this
> bit tells userspace is that the guest has programmed a zero filled
> table. On restore, we'd avoid a rescan of the table if there was
> no LPI mapped.

Yes, I agree.

> And thinking of it, this fixes a bug for non-Linux guests: If you write
> PTZ=1, we never clear it. Which means that if userspace saves and restores
> PENDBASER with PTZ set, we'll never restore the pending bits, which is
> pretty bad (see vgic_enable_lpis()).

But I'm afraid I can't follow this point. After reading the code (with
Qemu) a bit further, the Redistributors are restored before the ITS. So
there should be _no_ LPI has been mapped when we're restoring GICR_CTLR
and enabling LPI, which says we will not scan the whole pending table
and restore pending by vgic_enable_lpis()/its_sync_lpi_pending_table(),
regardless of what the PTZ is.

Instead, vgic_its_restore_ite()/vgic_v3_lpi_sync_pending_status() is
where we actually read the guest RAM and restore the LPI pending state.
Which means we will still do the right thing even for non-Linux guests.
Not sure if I've got things correctly here.

In the end, let's keep the patch as it is.

> 
> This patch on its own fixes more than one bug!
> 

If so, just by luck ;-)


Thanks,
Zenghui

