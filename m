Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F24CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D0F20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCso8YSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbfJ2MRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:17:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26750 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfJ2MRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572351439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5TVCYf2MyQ5m7UVpCqBCLIUTH2CBfxMSLxMHSp3UXw=;
        b=gCso8YSQKB2mbv431nmp+frf4w9LlzMZOobkUSCWl3MDrh8dZ8jzJxlCx38AK+/WbY4K0I
        edSxoWzpf/Ej+aGgACN58tAQ116KAEnbpXiQ0oGIZvXtOB3H2ibQTFppiyOS/mOAKek5mm
        IAv7a/tgOu48TGpjonSmZeoABPGyF8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-1I3Ni04hMhG__5_pXeNLHQ-1; Tue, 29 Oct 2019 08:17:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29E9C107AD28;
        Tue, 29 Oct 2019 12:17:14 +0000 (UTC)
Received: from [10.36.118.15] (unknown [10.36.118.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 728CC600C4;
        Tue, 29 Oct 2019 12:17:10 +0000 (UTC)
Subject: Re: [PATCH 3/3] KVM: arm/arm64: vgic: Don't rely on the wrong pending
 table
To:     Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-4-yuzenghui@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5e4d1a2f-7107-efe3-9dde-626662e31ac5@redhat.com>
Date:   Tue, 29 Oct 2019 13:17:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191029071919.177-4-yuzenghui@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 1I3Ni04hMhG__5_pXeNLHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui, Marc,

On 10/29/19 8:19 AM, Zenghui Yu wrote:
> It's possible that two LPIs locate in the same "byte_offset" but target
> two different vcpus, where their pending status are indicated by two
> different pending tables.  In such a scenario, using last_byte_offset
> optimization will lead KVM relying on the wrong pending table entry.
> Let us use last_ptr instead, which can be treated as a byte index into
> a pending table and also, can be vcpu specific.
>=20
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>=20
> If this patch has done the right thing, we can even add the:
>=20
> Fixes: 280771252c1b ("KVM: arm64: vgic-v3: KVM_DEV_ARM_VGIC_SAVE_PENDING_=
TABLES")
>=20
> But to be honest, I'm not clear about what has this patch actually fixed.
> Pending tables should contain all zeros before we flush vgic_irq's pendin=
g
> status into guest's RAM (thinking that guest should never write anything
> into it). So the pending table entry we've read from the guest memory
> seems always be zero. And we will always do the right thing even if we
> rely on the wrong pending table entry.
>=20
> I think I must have some misunderstanding here... Please fix me.
>=20
>  virt/kvm/arm/vgic/vgic-v3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index 5ef93e5041e1..7cd2e2f81513 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -363,8 +363,8 @@ int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, =
struct vgic_irq *irq)
>  int vgic_v3_save_pending_tables(struct kvm *kvm)
>  {
>  =09struct vgic_dist *dist =3D &kvm->arch.vgic;
> -=09int last_byte_offset =3D -1;
>  =09struct vgic_irq *irq;
> +=09gpa_t last_ptr =3D -1;
>  =09int ret;
>  =09u8 val;
> =20
> @@ -384,11 +384,11 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
>  =09=09bit_nr =3D irq->intid % BITS_PER_BYTE;
>  =09=09ptr =3D pendbase + byte_offset;
> =20
> -=09=09if (byte_offset !=3D last_byte_offset) {
> +=09=09if (ptr !=3D last_ptr) {
>  =09=09=09ret =3D kvm_read_guest_lock(kvm, ptr, &val, 1);
>  =09=09=09if (ret)
>  =09=09=09=09return ret;
> -=09=09=09last_byte_offset =3D byte_offset;
> +=09=09=09last_ptr =3D ptr;
>  =09=09}
> =20
>  =09=09stored =3D val & (1U << bit_nr);
>=20
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks for fixing this.

Eric


