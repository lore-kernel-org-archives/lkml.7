Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20270C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41079206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDQTQlro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKMRNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:13:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43260 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbfKMRNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573665203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jSlvNFHg6IbUCrmqPiwkPs953WRyG/IfAUfAH0jbow=;
        b=JDQTQlrocu8CMmBkF8NIe3akmkLsI6ANMXgi9QlBslRzIhlnrPbbvdEu5KZg2gFFW1Pp75
        NWDibwmfrPDxPWCys1K+kOPdsDBzsEQT9MdH0cjXqJ9Tfqaj/UK39pOp6+c+1b4alvN/O/
        NImZgDf+a8H29W4HHELwy9XMEdRGmaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Rhzwd5RWMB2ogwfEoeuiIw-1; Wed, 13 Nov 2019 12:13:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5130117125C;
        Wed, 13 Nov 2019 17:13:18 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1FDE5F761;
        Wed, 13 Nov 2019 17:13:15 +0000 (UTC)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Populate VMID field for
 CMDQ_OP_TLBI_NH_VA
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        will@kernel.org, robin.murphy@arm.com
Cc:     linuxarm@huawei.com, xuwei5@hisilicon.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <20191113161138.22336-1-shameerali.kolothum.thodi@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5bf7d4e1-5231-3ee5-b239-d05523c96e5e@redhat.com>
Date:   Wed, 13 Nov 2019 18:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191113161138.22336-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Rhzwd5RWMB2ogwfEoeuiIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On 11/13/19 5:11 PM, Shameer Kolothum wrote:
> CMDQ_OP_TLBI_NH_VA requires VMID and this was missing since
> commit 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask
> for CMD_TLBI_S2_IPA"). Add it back.
>=20
> Fixes: 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask for CMD_TL=
BI_S2_IPA")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric

> ---
> This came to light while verifying the "SMMUv3 Nested Stage Setup"
> series by Eric. Please find the discusiion here,
> https://lore.kernel.org/patchwork/cover/1099617/
> ---
>  drivers/iommu/arm-smmu-v3.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 8da93e730d6f..9b5274346df0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -856,6 +856,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct a=
rm_smmu_cmdq_ent *ent)
>  =09=09cmd[1] |=3D FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
>  =09=09break;
>  =09case CMDQ_OP_TLBI_NH_VA:
> +=09=09cmd[0] |=3D FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
>  =09=09cmd[0] |=3D FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
>  =09=09cmd[1] |=3D FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
>  =09=09cmd[1] |=3D ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
>=20

