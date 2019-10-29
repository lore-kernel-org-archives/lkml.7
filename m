Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C30CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359E420659
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdkWbchM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJ2WwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:52:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47932 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbfJ2WwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572389538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYynz4GR5eOSd6n5cQs67I6ct64O6p/BlBconKMsNBU=;
        b=fdkWbchMrMra7M9oVGGPxOxQk026XQ4DLHTOn7VvdIi6RieFbkFbG2SvFo4eXIxVUg0Z7U
        56/KeZ97D3/jdqseKmrsWRX2HWyPk47tNuqUiQSsj8LRKyzuCmzaiWXCQvmU9MPX53wh50
        zgDvCt9AfDNk+LlIqOnrEX9BSgQI1Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-Z8l-CFl_NJWBKFINNW_lsQ-1; Tue, 29 Oct 2019 18:52:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4F62800C80;
        Tue, 29 Oct 2019 22:52:13 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE53119D70;
        Tue, 29 Oct 2019 22:52:10 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 3/3] KVM: arm/arm64: vgic: Don't rely on the wrong pending
 table
To:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        julien.thierry.kdev@gmail.com
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-4-yuzenghui@huawei.com> <86mudjykfa.wl-maz@kernel.org>
 <f8a30e65-7077-301a-1558-7fc504b5e891@huawei.com>
 <e2141f6a-c530-46d5-d5d9-26806b02d55b@redhat.com>
 <01638947-ce47-2e09-68f0-a95eb6e9b2d0@huawei.com>
Message-ID: <40c96640-49b3-942b-59f7-3f2f1592d8d6@redhat.com>
Date:   Tue, 29 Oct 2019 23:52:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <01638947-ce47-2e09-68f0-a95eb6e9b2d0@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Z8l-CFl_NJWBKFINNW_lsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 10/29/19 2:31 PM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2019/10/29 20:49, Auger Eric wrote:
>> On 10/29/19 1:27 PM, Zenghui Yu wrote:
>>> okay, the remaining question is that in vgic_v3_save_pending_tables():
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stored =3D val & (1U << bit_nr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (stored =3D=3D irq->pending_latch)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (irq->pending_latch)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val |=3D 1 << bit_nr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val &=3D ~(1 << bit_nr=
);
>>>
>>> Do we really have a scenario where irq->pending_latch=3D=3Dfalse and
>>> stored=3D=3Dtrue (corresponds to the above "else") and then we clear
>>> pending status of this LPI in guest memory?
>>> I can not think out one now.
>>
>> if you save, restore and save again. On the 1st save the LPI may be
>> pending, it gets stored. On the second save the LPI may be not pending
>> anymore?
>=20
> I assume you mean the "restore" by vgic_its_restore_ite().

yes that's what I meant

>=20
> While restoring a LPI, we will sync the pending status from guest
> pending table (into the software pending_latch), and clear the
> corresponding bit in guest memory.
> See vgic_v3_lpi_sync_pending_status().
>=20
> So on the second save, the LPI can be not pending, the guest pending
> table will also indicate not pending.

You're right; I did not remember vgic_v3_lpi_sync_pending_status (called
from vgic_its_restore_ite/vgic_add_lpi) "cleared the consumed data"
(44de9d683847  KVM: arm64: vgic-v3: vgic_v3_lpi_sync_pending_status).

So effectively after restore the pending table is zeroed and the above
code should be rewrittable in a more simple manner, ie. just update the
byte in case the pending_latch is set.

Nethertheless your patch indeed fixes an actual bug independently on
this cleanup, ie. the written byte may be incorrect if LPIs belonging to
this byte target different RDIST.

Thanks

Eric
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

