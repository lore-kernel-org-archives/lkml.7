Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 11:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059392077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 11:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf5bZUfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLMLGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:06:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbfLMLGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576235204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Crmf5u8UvQ4Fiv2iDfiUjbDLUFVVvKN850I3N8dlMLg=;
        b=gf5bZUfCKh2TE1I0UZmkYvlBnd9iNt3vlOcVRkhJ8nVWxsp++wfuaAGo+y/PH3jiAHzZJn
        IMrbb84SZtV00f3KLQF/8adq5nlkrDfboqUNbyqn+moJQeYjnFEQmXP2YDmHVMcD2EiF+O
        E71xYewy7yYCF7Dtqo2gDe7he7udonQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-12UsN48CPvy5oIC1W_oLig-1; Fri, 13 Dec 2019 06:06:41 -0500
X-MC-Unique: 12UsN48CPvy5oIC1W_oLig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DAD218B5FA9;
        Fri, 13 Dec 2019 11:06:39 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 494E560BE1;
        Fri, 13 Dec 2019 11:06:37 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped
 collections
To:     Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
References: <20191213094237.19627-1-eric.auger@redhat.com>
 <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <604a28ab-3a4a-4b9f-a9fa-719edc915d0d@redhat.com>
Date:   Fri, 13 Dec 2019 12:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 12/13/19 11:53 AM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2019/12/13 17:42, Eric Auger wrote:
>> Saving/restoring an unmapped collection is a valid scenario. For
>> example this happens if a MAPTI command was sent, featuring an
>> unmapped collection. At the moment the CTE fails to be restored.
>> Only compare against the number of online vcpus if the rdist
>> base is set.
>=20
> Have you actually seen a problem and this patch fixed it?

It is not with a linux guest but with kvm-unit-test.

 To be honest,
> I'm surprised to find that we can map a LPI to an unmapped collection ;=
)
> (and prevent it to be delivered to vcpu with an INT_UNMAPPED_INTERRUPT
> error, until someone had actually mapped the collection).
> After a quick glance of spec (MAPTI), just as you said, this is valid.
>=20
> If Marc has no objection to this fix, please add
>=20
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Thank you for the review.

Eric
>=20
>=20
> Thanks,
> Zenghui
>=20
>>
>> Cc: stable@vger.kernel.org # v4.11+
>> Fixes: ea1ad53e1e31a ("KVM: arm64: vgic-its: Collection table
>> save/restore")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> =C2=A0 virt/kvm/arm/vgic/vgic-its.c | 3 ++-
>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its=
.c
>> index 98c7360d9fb7..17920d1b350a 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -2475,7 +2475,8 @@ static int vgic_its_restore_cte(struct vgic_its
>> *its, gpa_t gpa, int esz)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_addr =3D (u32)(val >> KVM_ITS_CT=
E_RDBASE_SHIFT);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 coll_id =3D val & KVM_ITS_CTE_ICID_MASK=
;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (target_addr >=3D atomic_read(&kvm->onli=
ne_vcpus))
>> +=C2=A0=C2=A0=C2=A0 if (target_addr !=3D COLLECTION_NOT_MAPPED &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_addr >=3D atomic_re=
ad(&kvm->online_vcpus))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 collection =3D find_collection(i=
ts, coll_id);
>>
>=20

