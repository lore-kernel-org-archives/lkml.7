Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20022C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4546208CE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRBnbdQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfKRVTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:19:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726272AbfKRVTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574111952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwb2bwcFnEMR2kD+UpG+jcPlEIshwrO3tV1AWtPKMJs=;
        b=FRBnbdQGQ8P5dTQSjK+HMJiBHhXJoy8p3ajbRH98IFwOFFk0osT1nuHguYkNaq+spHyjfp
        amdfwV88NF7yGjpEIhI3Gio3rsrGRmcyZXk8WUvzOnu/u3ExhKdryEQqWLtNkp/7Gdszm+
        2ZsxJSIppP97ilgm8fLE7sv/WGAlBJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-8hb4A3LoM3WaSexlLsJtrw-1; Mon, 18 Nov 2019 16:19:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D48E81802CFA;
        Mon, 18 Nov 2019 21:19:07 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D9289302;
        Mon, 18 Nov 2019 21:19:05 +0000 (UTC)
Subject: Re: [PATCH v2 08/10] iommu/vt-d: Fix PASID cache flush
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-9-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <38c0f6f0-b751-6b23-2292-5f08bdfff5c9@redhat.com>
Date:   Mon, 18 Nov 2019 22:19:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574106153-45867-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8hb4A3LoM3WaSexlLsJtrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,
On 11/18/19 8:42 PM, Jacob Pan wrote:
> Use the correct invalidation descriptor type and granularity.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 3cb569e76642..ee6ea1bbd917 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -365,7 +365,8 @@ pasid_cache_invalidation_with_pasid(struct intel_iomm=
u *iommu,
>  {
>  =09struct qi_desc desc;
> =20
> -=09desc.qw0 =3D QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
> +=09desc.qw0 =3D QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> +=09=09QI_PC_PASID(pasid) | QI_PC_TYPE;
Hum I am confused

#define QI_PC_PASID_SEL         (QI_PC_TYPE | QI_PC_GRAN(1))

So the original looks correct to me?

Thanks

Eric



>  =09desc.qw1 =3D 0;
>  =09desc.qw2 =3D 0;
>  =09desc.qw3 =3D 0;
>=20

