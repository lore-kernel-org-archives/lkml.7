Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D43CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FB82073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvscUwTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLMKzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:55:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25291 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbfLMKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576234516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kwjbmvTQEgQPtwglmAiSLhwOadpCH9FVfDLCODG9fU=;
        b=JvscUwTNN8cZEuVd1pPKnEzasjZgVWQd4Be1RJnCYVGUJswcjQUE15cg+uEvMLzBgde9aa
        pQvK4ueya2jHP/2RCKcqazmsBJ6uScDVh8mybvwPT0iBZZzDRqATncgRohsUIL91x89d8H
        eFhk1s25qtHEN1H9j/aQSQzFUmVDzGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-PdXFiR_lNhG6kYJICE0Xog-1; Fri, 13 Dec 2019 05:55:14 -0500
X-MC-Unique: PdXFiR_lNhG6kYJICE0Xog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92C77DB63;
        Fri, 13 Dec 2019 10:55:13 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BEFE10013A1;
        Fri, 13 Dec 2019 10:55:12 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped
 collections
To:     Marc Zyngier <maz@kernel.org>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
References: <20191213094237.19627-1-eric.auger@redhat.com>
 <2634d1361ac3d5518b3bea62dc40ab06@www.loen.fr>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <9d84b239-3901-f995-765b-97b7574d0d74@redhat.com>
Date:   Fri, 13 Dec 2019 11:55:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2634d1361ac3d5518b3bea62dc40ab06@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 12/13/19 11:43 AM, Marc Zyngier wrote:
> Hi Eric,
>=20
> On 2019-12-13 09:42, Eric Auger wrote:
>> Saving/restoring an unmapped collection is a valid scenario. For
>> example this happens if a MAPTI command was sent, featuring an
>> unmapped collection. At the moment the CTE fails to be restored.
>> Only compare against the number of online vcpus if the rdist
>> base is set.
>>
>> Cc: stable@vger.kernel.org # v4.11+
>> Fixes: ea1ad53e1e31a ("KVM: arm64: vgic-its: Collection table
>> save/restore")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> =C2=A0virt/kvm/arm/vgic/vgic-its.c | 3 ++-
>> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its=
.c
>> index 98c7360d9fb7..17920d1b350a 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -2475,7 +2475,8 @@ static int vgic_its_restore_cte(struct vgic_its
>> *its, gpa_t gpa, int esz)
>> =C2=A0=C2=A0=C2=A0=C2=A0 target_addr =3D (u32)(val >> KVM_ITS_CTE_RDBA=
SE_SHIFT);
>> =C2=A0=C2=A0=C2=A0=C2=A0 coll_id =3D val & KVM_ITS_CTE_ICID_MASK;
>>
>> -=C2=A0=C2=A0=C2=A0 if (target_addr >=3D atomic_read(&kvm->online_vcpu=
s))
>> +=C2=A0=C2=A0=C2=A0 if (target_addr !=3D COLLECTION_NOT_MAPPED &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_addr >=3D atomic_re=
ad(&kvm->online_vcpus))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 collection =3D find_collection(its, coll_id);
>=20
> Looks good to me. Out of curiosity, how was this spotted?

I am currently writing some kvm-unit-tests to better test ITS and its
migration.

Thanks

Eric
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.

