Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ADFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8EA20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577110048;
	bh=5ZdMPyONpsn+aRFmlCXTEHarfDJUHETjn2QABN9mOfw=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=rEXQ9W5xInE3rfANtRdnWFZtRHPlolI0e3g30bssCNOf6jy0nYCLxTJSS1ThyP1Pf
	 cNK/9aXAcFPFKW3Gbmzcx6rmRWHq/B9jyMD73hRp/yWQxB20hNOrXU71QvfRfvzZFW
	 tvi2nC5XeXvedp1xLLFbItefKjnY4mTy0TGU5B+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLWOH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:07:27 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:50280 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbfLWOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:07:26 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ijOMh-0006s5-8h; Mon, 23 Dec 2019 15:07:19 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle =?UTF-8?Q?GICR=5FPENDBAS?=  =?UTF-8?Q?ER=2EPTZ=20filed=20as=20RAZ?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Dec 2019 14:07:19 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <andre.przywara@arm.com>, <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>
In-Reply-To: <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
References: <20191220111833.1422-1-yuzenghui@huawei.com>
 <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
Message-ID: <c084aa29c029f97cdfb1b5dc9e6b29ac@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, andre.przywara@arm.com, eric.auger@redhat.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2019-12-23 13:43, Zenghui Yu wrote:
> On 2019/12/20 19:18, Zenghui Yu wrote:
>> Although guest will hardly read and use the PTZ (Pending Table Zero)
>> bit in GICR_PENDBASER, let us emulate the architecture strictly.
>> As per IHI 0069E 9.11.30, PTZ field is WO, and reads as 0.
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>> Noticed when checking all fields of GICR_PENDBASER register.
>> But _not_ sure whether it's worth a fix, as Linux never sets
>> the PTZ bit before enabling LPI (set GICR_CTLR_ENABLE_LPIS).
>> And I wonder under which scenarios can this bit be written as 1.
>> It seems difficult for software to determine whether the pending
>> table contains all zeros when writing this bit.
>> virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c 
>> b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>> index 7dfd15dbb308..ebc218840fc2 100644
>> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
>> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>> @@ -414,8 +414,11 @@ static unsigned long 
>> vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
>>   					     gpa_t addr, unsigned int len)
>>   {
>>   	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>> +	u64 value = vgic_cpu->pendbaser;
>>   -	return extract_bytes(vgic_cpu->pendbaser, addr & 7, len);
>> +	value &= ~GICR_PENDBASER_PTZ;
>> +
>> +	return extract_bytes(value, addr & 7, len);
>>   }
>>   static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,
>>
>
> I noticed there is no userspace access callbacks for GICR_PENDBASER,
> so this patch will make the PTZ field also 'Read As Zero' by 
> userspace.
> Should we consider adding a uaccess_read callback for GICR_PENDBASER
> which just returns the unchanged vgic_cpu->pendbaser to userspace?
> (Though this is really not a big deal. We now always emulate the PTZ
> field to guest as RAZ. And 'vgic_cpu->pendbaser & GICR_PENDBASER_PTZ'
> only indicates whether KVM will optimize the LPI enabling process,
> where Read As Zero indicates never optimize..)

I don't think adding a userspace accessor would help much. All this
bit tells userspace is that the guest has programmed a zero filled
table. On restore, we'd avoid a rescan of the table if there was
no LPI mapped.

And thinking of it, this fixes a bug for non-Linux guests: If you write
PTZ=1, we never clear it. Which means that if userspace saves and 
restores
PENDBASER with PTZ set, we'll never restore the pending bits, which is
pretty bad (see vgic_enable_lpis()).

This patch on its own fixes more than one bug!

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
