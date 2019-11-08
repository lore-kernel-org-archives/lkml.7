Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C7BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D55221882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBgZ+P1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKHQSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:18:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46497 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725941AbfKHQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573229907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEUGEbDEfPr/owp9u8Xo/PbGoTk1t896oZ4K9wNCr+I=;
        b=aBgZ+P1B9kSHofjM2UT7qGRIvYKMlfFsYNHR6Y0BnaZMzc3h7QyLVXUmApJpCngmo4SzYm
        Shtq82d5QddoPLfw5lU8E2+ffb6TJFJY1niVb1lhR3pZcxnuVlWEn21OB0QhGyUcKTKdDB
        FEgubkem0P3deyyrQP1/NbZziAD0H6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-lZCKI3h0Pv2OQ-r-J7Nqeg-1; Fri, 08 Nov 2019 11:18:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFF0B1800D7B;
        Fri,  8 Nov 2019 16:18:23 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17F695DA7F;
        Fri,  8 Nov 2019 16:18:11 +0000 (UTC)
Subject: Re: [PATCH v7 10/11] iommu/vt-d: Support flushing more translation
 cache types
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-11-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <467e60cc-efb1-83d4-2dea-f6131a60428b@redhat.com>
Date:   Fri, 8 Nov 2019 17:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lZCKI3h0Pv2OQ-r-J7Nqeg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 10/24/19 9:55 PM, Jacob Pan wrote:
> When Shared Virtual Memory is exposed to a guest via vIOMMU, scalable
> IOTLB invalidation may be passed down from outside IOMMU subsystems.
> This patch adds invalidation functions that can be used for additional
> translation cache types.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        | 46 +++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/iommu/intel-pasid.c |  3 ++-
>  include/linux/intel-iommu.h | 21 +++++++++++++++++----
>  3 files changed, 65 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 49bb7d76e646..0ce2d32ff99e 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1346,6 +1346,20 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16=
 did, u64 addr,
>  =09qi_submit_sync(&desc, iommu);
>  }
> =20
> +/* PASID-based IOTLB Invalidate */
> +void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 p=
asid,
> +=09=09unsigned int size_order, u64 granu, int ih)
> +{
> +=09struct qi_desc desc =3D {.qw2 =3D 0, .qw3 =3D 0};
> +
> +=09desc.qw0 =3D QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> +=09=09QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
> +=09desc.qw1 =3D QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(ih) |
> +=09=09QI_EIOTLB_AM(size_order);
> +
> +=09qi_submit_sync(&desc, iommu);
> +}
> +
>  void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  =09=09=09u16 qdep, u64 addr, unsigned mask)
>  {
> @@ -1369,6 +1383,38 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu,=
 u16 sid, u16 pfsid,
>  =09qi_submit_sync(&desc, iommu);
>  }
> =20
> +/* PASID-based device IOTLB Invalidate */
> +void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +=09=09u32 pasid,  u16 qdep, u64 addr, unsigned size_order, u64 granu)
> +{
> +=09struct qi_desc desc;
> +
> +=09desc.qw0 =3D QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> +=09=09QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> +=09=09QI_DEV_IOTLB_PFSID(pfsid);
> +=09desc.qw1 =3D QI_DEV_EIOTLB_GLOB(granu);
> +
> +=09/* If S bit is 0, we only flush a single page. If S bit is set,
> +=09 * The least significant zero bit indicates the invalidation address
> +=09 * range. VT-d spec 6.5.2.6.
> +=09 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
> +=09 */
> +=09if (!size_order) {
> +=09=09desc.qw0 |=3D QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
this is desc.qw1

With that fixed and the qi_flush_dev_piotlb init issue spotted by Lu,
feel free to add my

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> +=09} else {
> +=09=09unsigned long mask =3D 1UL << (VTD_PAGE_SHIFT + size_order);
> +=09=09desc.qw1 |=3D QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZ=
E;
> +=09}
> +=09qi_submit_sync(&desc, iommu);
> +}
> +
> +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,=
 int pasid)
> +{
> +=09struct qi_desc desc =3D {.qw1 =3D 0, .qw2 =3D 0, .qw3 =3D 0};
> +
> +=09desc.qw0 =3D QI_PC_PASID(pasid) | QI_PC_DID(did) | QI_PC_GRAN(granu) =
| QI_PC_TYPE;
> +=09qi_submit_sync(&desc, iommu);
> +}
>  /*
>   * Disable Queued Invalidation interface.
>   */
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index f846a907cfcf..6d7a701ef4d3 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -491,7 +491,8 @@ pasid_cache_invalidation_with_pasid(struct intel_iomm=
u *iommu,
>  {
>  =09struct qi_desc desc;
> =20
> -=09desc.qw0 =3D QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
> +=09desc.qw0 =3D QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> +=09=09QI_PC_PASID(pasid) | QI_PC_TYPE;
>  =09desc.qw1 =3D 0;
>  =09desc.qw2 =3D 0;
>  =09desc.qw3 =3D 0;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6c74c71b1ebf..a25fb3a0ea5b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -332,7 +332,7 @@ enum {
>  #define QI_IOTLB_GRAN(gran) =09(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFS=
ET-4))
>  #define QI_IOTLB_ADDR(addr)=09(((u64)addr) & VTD_PAGE_MASK)
>  #define QI_IOTLB_IH(ih)=09=09(((u64)ih) << 6)
> -#define QI_IOTLB_AM(am)=09=09(((u8)am))
> +#define QI_IOTLB_AM(am)=09=09(((u8)am) & 0x3f)
> =20
>  #define QI_CC_FM(fm)=09=09(((u64)fm) << 48)
>  #define QI_CC_SID(sid)=09=09(((u64)sid) << 32)
> @@ -350,16 +350,21 @@ enum {
>  #define QI_PC_DID(did)=09=09(((u64)did) << 16)
>  #define QI_PC_GRAN(gran)=09(((u64)gran) << 4)
> =20
> -#define QI_PC_ALL_PASIDS=09(QI_PC_TYPE | QI_PC_GRAN(0))
> -#define QI_PC_PASID_SEL=09=09(QI_PC_TYPE | QI_PC_GRAN(1))
> +/* PASID cache invalidation granu */
> +#define QI_PC_ALL_PASIDS=090
> +#define QI_PC_PASID_SEL=09=091
> =20
>  #define QI_EIOTLB_ADDR(addr)=09((u64)(addr) & VTD_PAGE_MASK)
>  #define QI_EIOTLB_IH(ih)=09(((u64)ih) << 6)
> -#define QI_EIOTLB_AM(am)=09(((u64)am))
> +#define QI_EIOTLB_AM(am)=09(((u64)am) & 0x3f)
>  #define QI_EIOTLB_PASID(pasid) =09(((u64)pasid) << 32)
>  #define QI_EIOTLB_DID(did)=09(((u64)did) << 16)
>  #define QI_EIOTLB_GRAN(gran) =09(((u64)gran) << 4)
> =20
> +/* QI Dev-IOTLB inv granu */
> +#define QI_DEV_IOTLB_GRAN_ALL=09=091
> +#define QI_DEV_IOTLB_GRAN_PASID_SEL=090
> +
>  #define QI_DEV_EIOTLB_ADDR(a)=09((u64)(a) & VTD_PAGE_MASK)
>  #define QI_DEV_EIOTLB_SIZE=09(((u64)1) << 11)
>  #define QI_DEV_EIOTLB_GLOB(g)=09((u64)g)
> @@ -655,8 +660,16 @@ extern void qi_flush_context(struct intel_iommu *iom=
mu, u16 did, u16 sid,
>  =09=09=09     u8 fm, u64 type);
>  extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  =09=09=09  unsigned int size_order, u64 type);
> +extern void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr=
,
> +=09=09=09u32 pasid, unsigned int size_order, u64 type, int ih);
>  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 p=
fsid,
>  =09=09=09u16 qdep, u64 addr, unsigned mask);
> +
> +extern void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 =
pfsid,
> +=09=09=09u32 pasid, u16 qdep, u64 addr, unsigned size_order, u64 granu);
> +
> +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64=
 granu, int pasid);
> +
>  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iomm=
u);
> =20
>  extern int dmar_ir_support(void);
>=20

