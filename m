Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6288CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB8B21734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYes92p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfJ2MtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:49:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729253AbfJ2MtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572353362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BV4BcyOxaroiRY1nHh/W3bkCNLJ+ckD/r50Gn1yPT0=;
        b=TYes92p0H7fd2VFu+U+M2eu77wlbQnYZ0ej4bTRVTBXYvh6aWfiv72Bt+u/VbFhTINImZl
        1i+Zvhlao17RoXnXBm2RgtXbFO62ApQlG9tdm0gOI0m5gtgrhUHS9RWGqg2yKihaIdJM38
        mYfFxhyqm0WtniCGfwlhPsFbZq4qXyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-xZ4E5mL8OxaCghK5UyvDWg-1; Tue, 29 Oct 2019 08:49:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30293800C80;
        Tue, 29 Oct 2019 12:49:17 +0000 (UTC)
Received: from [10.36.118.15] (unknown [10.36.118.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3123F600C4;
        Tue, 29 Oct 2019 12:49:13 +0000 (UTC)
Subject: Re: [PATCH 3/3] KVM: arm/arm64: vgic: Don't rely on the wrong pending
 table
To:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-4-yuzenghui@huawei.com> <86mudjykfa.wl-maz@kernel.org>
 <f8a30e65-7077-301a-1558-7fc504b5e891@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <e2141f6a-c530-46d5-d5d9-26806b02d55b@redhat.com>
Date:   Tue, 29 Oct 2019 13:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f8a30e65-7077-301a-1558-7fc504b5e891@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: xZ4E5mL8OxaCghK5UyvDWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 10/29/19 1:27 PM, Zenghui Yu wrote:
> Hi Marc,
>=20
> On 2019/10/29 17:23, Marc Zyngier wrote:
>> On Tue, 29 Oct 2019 07:19:19 +0000,
>> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>>
>>> It's possible that two LPIs locate in the same "byte_offset" but target
>>> two different vcpus, where their pending status are indicated by two
>>> different pending tables.=C2=A0 In such a scenario, using last_byte_off=
set
>>> optimization will lead KVM relying on the wrong pending table entry.
>>> Let us use last_ptr instead, which can be treated as a byte index into
>>> a pending table and also, can be vcpu specific.
>>>
>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>> ---
>>>
>>> If this patch has done the right thing, we can even add the:
>>>
>>> Fixes: 280771252c1b ("KVM: arm64: vgic-v3:
>>> KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES")
>>>
>>> But to be honest, I'm not clear about what has this patch actually
>>> fixed.
>>> Pending tables should contain all zeros before we flush vgic_irq's
>>> pending
>>> status into guest's RAM (thinking that guest should never write anythin=
g
>>> into it). So the pending table entry we've read from the guest memory
>>> seems always be zero. And we will always do the right thing even if we
>>> rely on the wrong pending table entry.
>>>
>>> I think I must have some misunderstanding here... Please fix me.
>>
>> I think you're spot on, and it is the code needs fixing, not you! The
>> problem is that we only read a byte once, irrespective of the vcpu the
>> interrupts is routed to. If we switch to another vcpu for the same
>> byte offset, we must reload it.
>>
>> This can be done by either checking the vcpu, or by tracking the guest
>> address that we read from (just like you do here).
>=20
> okay, the remaining question is that in vgic_v3_save_pending_tables():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0stored =3D val & (1U << bit_nr);
> =C2=A0=C2=A0=C2=A0=C2=A0if (stored =3D=3D irq->pending_latch)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0if (irq->pending_latch)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val |=3D 1 << bit_nr;
> =C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val &=3D ~(1 << bit_nr);
>=20
> Do we really have a scenario where irq->pending_latch=3D=3Dfalse and
> stored=3D=3Dtrue (corresponds to the above "else") and then we clear
> pending status of this LPI in guest memory?
> I can not think out one now.

if you save, restore and save again. On the 1st save the LPI may be
pending, it gets stored. On the second save the LPI may be not pending
anymore?

Thanks

Eric
>=20
>>
>> A small comment below:
>>
>>> =C2=A0 virt/kvm/arm/vgic/vgic-v3.c | 6 +++---
>>> =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
>>> index 5ef93e5041e1..7cd2e2f81513 100644
>>> --- a/virt/kvm/arm/vgic/vgic-v3.c
>>> +++ b/virt/kvm/arm/vgic/vgic-v3.c
>>> @@ -363,8 +363,8 @@ int vgic_v3_lpi_sync_pending_status(struct kvm
>>> *kvm, struct vgic_irq *irq)
>>> =C2=A0 int vgic_v3_save_pending_tables(struct kvm *kvm)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vgic_dist *dist =3D &kvm->arch.vg=
ic;
>>> -=C2=A0=C2=A0=C2=A0 int last_byte_offset =3D -1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vgic_irq *irq;
>>> +=C2=A0=C2=A0=C2=A0 gpa_t last_ptr =3D -1;
>>
>> This should be written as
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpa_t last_ptr =3D ~(gpa_t)0;
>=20
> Thanks for pointing it out.
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 val;
>>> =C2=A0 @@ -384,11 +384,11 @@ int vgic_v3_save_pending_tables(struct kvm=
 *kvm)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit_nr =3D irq->=
intid % BITS_PER_BYTE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr =3D pendbase=
 + byte_offset;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (byte_offset !=3D=
 last_byte_offset) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ptr !=3D last_ptr) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D kvm_read_guest_lock(kvm, ptr, &val, 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 las=
t_byte_offset =3D byte_offset;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 las=
t_ptr =3D ptr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stored =
=3D val & (1U << bit_nr);
>>
>> Otherwise, this looks good to me (no need to respin for the above
>> nit).
>=20
> Thanks,
>=20
> Zenghui
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

