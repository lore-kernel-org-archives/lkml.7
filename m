Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDD7C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 04:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43F7206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 04:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ1FOaWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfLXEph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 23:45:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726853AbfLXEph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 23:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577162735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QvQOGSsD6BCQ/KZZeRtn8Sn6aNp+vhwPhxNJ2ctz9g=;
        b=iZ1FOaWV5uZvITwjE6ncOt0nums8TdMg4KvEuAaorFANAeDgxfpICHxKqK5fwYVANQI4fT
        f0utBJyGhthLX4ebyvFNlCVAgZ1j1dOQqNFFqcFWpxcAGUcSRWp8NwALxDLGJTUMk3KIg3
        IY3t/WmnDUjBd8Exv+HrFeI3p+G6qAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-Hoek3P4zOCSlBGu07fty_A-1; Mon, 23 Dec 2019 23:45:32 -0500
X-MC-Unique: Hoek3P4zOCSlBGu07fty_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAEBB184B461;
        Tue, 24 Dec 2019 04:45:30 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 141505DA60;
        Tue, 24 Dec 2019 04:45:20 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as
 RAZ
To:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>
Cc:     andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20191220111833.1422-1-yuzenghui@huawei.com>
 <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
 <c084aa29c029f97cdfb1b5dc9e6b29ac@www.loen.fr>
 <1225d839-3cf7-d513-778e-698e12e94875@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <12a1e25b-617d-6b04-6a5a-4c67a39565a5@redhat.com>
Date:   Tue, 24 Dec 2019 05:45:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1225d839-3cf7-d513-778e-698e12e94875@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 12/24/19 3:52 AM, Zenghui Yu wrote:
> Hi Marc, Eric,
>=20
> On 2019/12/23 22:07, Marc Zyngier wrote:
>> Hi Zenghui,
>>
>> On 2019-12-23 13:43, Zenghui Yu wrote:
>>> On 2019/12/20 19:18, Zenghui Yu wrote:
>>>> Although guest will hardly read and use the PTZ (Pending Table Zero)
>>>> bit in GICR_PENDBASER, let us emulate the architecture strictly.
>>>> As per IHI 0069E 9.11.30, PTZ field is WO, and reads as 0.
>>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>>> ---
>>>> Noticed when checking all fields of GICR_PENDBASER register.
>>>> But _not_ sure whether it's worth a fix, as Linux never sets
>>>> the PTZ bit before enabling LPI (set GICR_CTLR_ENABLE_LPIS).
>>>> And I wonder under which scenarios can this bit be written as 1.
>>>> It seems difficult for software to determine whether the pending
>>>> table contains all zeros when writing this bit.
>>>> virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
>>>> =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>>> b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>>> index 7dfd15dbb308..ebc218840fc2 100644
>>>> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>>> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>>> @@ -414,8 +414,11 @@ static unsigned long
>>>> vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 gpa_t addr, unsigned int len)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vgic_cpu *vgic_cpu =3D &vcpu->=
arch.vgic_cpu;
>>>> +=C2=A0=C2=A0=C2=A0 u64 value =3D vgic_cpu->pendbaser;
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return extract_bytes(vgic_cpu->pendbaser,=
 addr & 7, len);
>>>> +=C2=A0=C2=A0=C2=A0 value &=3D ~GICR_PENDBASER_PTZ;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return extract_bytes(value, addr & 7, len);
>>>> =C2=A0 }
>>>> =C2=A0 static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,
>>>>
>>>
>>> I noticed there is no userspace access callbacks for GICR_PENDBASER,
>>> so this patch will make the PTZ field also 'Read As Zero' by userspac=
e.
>>> Should we consider adding a uaccess_read callback for GICR_PENDBASER
>>> which just returns the unchanged vgic_cpu->pendbaser to userspace?
>>> (Though this is really not a big deal. We now always emulate the PTZ
>>> field to guest as RAZ. And 'vgic_cpu->pendbaser & GICR_PENDBASER_PTZ'
>>> only indicates whether KVM will optimize the LPI enabling process,
>>> where Read As Zero indicates never optimize..)
>>
>> I don't think adding a userspace accessor would help much. All this
>> bit tells userspace is that the guest has programmed a zero filled
>> table. On restore, we'd avoid a rescan of the table if there was
>> no LPI mapped.
>=20
> Yes, I agree.
>=20
>> And thinking of it, this fixes a bug for non-Linux guests: If you writ=
e
>> PTZ=3D1, we never clear it. Which means that if userspace saves and
>> restores
>> PENDBASER with PTZ set, we'll never restore the pending bits, which is
>> pretty bad (see vgic_enable_lpis()).
>=20
> But I'm afraid I can't follow this point. After reading the code (with
> Qemu) a bit further, the Redistributors are restored before the ITS.

This is also part of the kernel documentation:
Documentation/virt/kvm/devices/arm-vgic-its.txt (ITS restore sequence)
 So
> there should be _no_ LPI has been mapped when we're restoring GICR_CTLR
> and enabling LPI, which says we will not scan the whole pending table
> and restore pending by vgic_enable_lpis()/its_sync_lpi_pending_table(),
> regardless of what the PTZ is.
>=20
> Instead, vgic_its_restore_ite()/vgic_v3_lpi_sync_pending_status() is
> where we actually read the guest RAM and restore the LPI pending state.
yes the pending state is restored from
vgic_its_restore_ite/vgic_add_lpi/vgic_v3_lpi_sync_pending_status and
this path ignores the PTZ.

Thanks

Eric
> Which means we will still do the right thing even for non-Linux guests.
> Not sure if I've got things correctly here.
>=20
> In the end, let's keep the patch as it is.
>=20
>>
>> This patch on its own fixes more than one bug!
>>
>=20
> If so, just by luck ;-)
>=20
>=20
> Thanks,
> Zenghui
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

