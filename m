Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F40C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB6D206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlDD1nb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKLK2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:28:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54368 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbfKLK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573554529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7VAmLwuSokfepJ74+qyoE8W9U+YWj8RoIT+AdURp3P4=;
        b=QlDD1nb+p7bXU5X70s0K5D6Yw3pQ9PJYVSylk8SFRSdt/aCAkqtcXPBWL74GCgeXMVt4Ml
        /yRZIZj3+YpLLWrxuUFuRs2jQDLLvdkrSEW2pLI4wuN51Pt+8QiVm5eaOoITASRZKIepun
        QFhlyMeBlBf2nBoXkI97sQvRf6AkM7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-72ydc0LgNr6ncOYKwQfSbg-1; Tue, 12 Nov 2019 05:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C99B6DB61;
        Tue, 12 Nov 2019 10:28:44 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B9B819C69;
        Tue, 12 Nov 2019 10:28:38 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
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
 <1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <56c3222f-0457-8e1f-73aa-0360f49d66a7@redhat.com>
Date:   Tue, 12 Nov 2019 11:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 72ydc0LgNr6ncOYKwQfSbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 10/24/19 9:55 PM, Jacob Pan wrote:
> When Shared Virtual Address (SVA) is enabled for a guest OS via
> vIOMMU, we need to provide invalidation support at IOMMU API and driver
> level. This patch adds Intel VT-d specific function to implement
> iommu passdown invalidate API for shared virtual address.
>=20
> The use case is for supporting caching structure invalidation
> of assigned SVM capable devices. Emulated IOMMU exposes queue
> invalidation capability and passes down all descriptors from the guest
> to the physical IOMMU.
>=20
> The assumption is that guest to host device ID mapping should be
> resolved prior to calling IOMMU driver. Based on the device handle,
> host IOMMU driver can replace certain fields before submit to the
> invalidation queue.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 170 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 170 insertions(+)
>=20
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 5fab32fbc4b4..a73e76d6457a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5491,6 +5491,175 @@ static void intel_iommu_aux_detach_device(struct =
iommu_domain *domain,
>  =09aux_domain_remove_dev(to_dmar_domain(domain), dev);
>  }
> =20
> +/*
> + * 2D array for converting and sanitizing IOMMU generic TLB granularity =
to
> + * VT-d granularity. Invalidation is typically included in the unmap ope=
ration
> + * as a result of DMA or VFIO unmap. However, for assigned device where =
guest
> + * could own the first level page tables without being shadowed by QEMU.=
 In
above sentence needs to be rephrased.
> + * this case there is no pass down unmap to the host IOMMU as a result o=
f unmap
> + * in the guest. Only invalidations are trapped and passed down.
> + * In all cases, only first level TLB invalidation (request with PASID) =
can be
> + * passed down, therefore we do not include IOTLB granularity for reques=
t
> + * without PASID (second level).
> + *
> + * For an example, to find the VT-d granularity encoding for IOTLB
for example
> + * type and page selective granularity within PASID:
> + * X: indexed by iommu cache type
> + * Y: indexed by enum iommu_inv_granularity
> + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
> + *
> + * Granu_map array indicates validity of the table. 1: valid, 0: invalid
> + *
> + */
> +const static int inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_G=
RANU_NR] =3D {
> +=09/* PASID based IOTLB, support PASID selective and page selective */
I would rather use the generic terminology, ie. IOTLB invalidation
supports PASID and ADDR granularity
> +=09{0, 1, 1},> +=09/* PASID based dev TLBs, only support all PASIDs or s=
ingle PASID */
Device IOLTB invalidation supports DOMAIN and PASID granularities
> +=09{1, 1, 0},
> +=09/* PASID cache */
PASID cache invalidation support DOMAIN and PASID granularity
> +=09{1, 1, 0}
> +};
> +
> +const static u64 inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV=
_GRANU_NR] =3D {
> +=09/* PASID based IOTLB */
> +=09{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
> +=09/* PASID based dev TLBs */
> +=09{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
> +=09/* PASID cache */
> +=09{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
> +};
> +
> +static inline int to_vtd_granularity(int type, int granu, u64 *vtd_granu=
)
nit: this looks a bit weird to me to manipulate an u64 here. Why not use
a int
> +{
> +=09if (type >=3D IOMMU_CACHE_INV_TYPE_NR || granu >=3D IOMMU_INV_GRANU_N=
R ||
> +=09=09!inv_type_granu_map[type][granu])
> +=09=09return -EINVAL;
> +
> +=09*vtd_granu =3D inv_type_granu_table[type][granu];> +
> +=09return 0;
> +}
> +
> +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
> +{
> +=09u64 nr_pages =3D (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
> +
> +=09/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9 for 2MB, e=
tc.
> +=09 * IOMMU cache invalidate API passes granu_size in bytes, and number =
of
> +=09 * granu size in contiguous memory.
> +=09 */
> +=09return order_base_2(nr_pages);
> +}
> +
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> +=09=09struct device *dev, struct iommu_cache_invalidate_info *inv_info)
> +{
> +=09struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +=09struct device_domain_info *info;
> +=09struct intel_iommu *iommu;
> +=09unsigned long flags;
> +=09int cache_type;
> +=09u8 bus, devfn;
> +=09u16 did, sid;
> +=09int ret =3D 0;
> +=09u64 size;
> +
> +=09if (!inv_info || !dmar_domain ||
> +=09=09inv_info->version !=3D IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +=09=09return -EINVAL;
> +
> +=09if (!dev || !dev_is_pci(dev))
> +=09=09return -ENODEV;
> +
> +=09iommu =3D device_to_iommu(dev, &bus, &devfn);
> +=09if (!iommu)
> +=09=09return -ENODEV;
> +
> +=09spin_lock_irqsave(&device_domain_lock, flags);
> +=09spin_lock(&iommu->lock);
> +=09info =3D iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
> +=09if (!info) {
> +=09=09ret =3D -EINVAL;
> +=09=09goto out_unlock;
> +=09}
> +=09did =3D dmar_domain->iommu_did[iommu->seq_id];
> +=09sid =3D PCI_DEVID(bus, devfn);
> +=09size =3D to_vtd_size(inv_info->addr_info.granule_size, inv_info->addr=
_info.nb_granules);
> +
> +=09for_each_set_bit(cache_type, (unsigned long *)&inv_info->cache, IOMMU=
_CACHE_INV_TYPE_NR) {
> +=09=09u64 granu =3D 0;
> +=09=09u64 pasid =3D 0;
> +
> +=09=09ret =3D to_vtd_granularity(cache_type, inv_info->granularity, &gra=
nu);
> +=09=09if (ret) {
> +=09=09=09pr_err("Invalid cache type and granu combination %d/%d\n", cach=
e_type,
> +=09=09=09=09inv_info->granularity);
> +=09=09=09break;
> +=09=09}
> +
> +=09=09/* PASID is stored in different locations based on granularity */
> +=09=09if (inv_info->granularity =3D=3D IOMMU_INV_GRANU_PASID)
> +=09=09=09pasid =3D inv_info->pasid_info.pasid;
you need to check IOMMU_INV_ADDR_FLAGS_PASID in flags
> +=09=09else if (inv_info->granularity =3D=3D IOMMU_INV_GRANU_ADDR)
> +=09=09=09pasid =3D inv_info->addr_info.pasid;
same
> +=09=09else {
> +=09=09=09pr_err("Cannot find PASID for given cache type and granularity\=
n");
> +=09=09=09break;
> +=09=09}
> +
> +=09=09switch (BIT(cache_type)) {
> +=09=09case IOMMU_CACHE_INV_TYPE_IOTLB:
> +=09=09=09if (size && (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + =
size)) - 1))) {
> +=09=09=09=09pr_err("Address out of range, 0x%llx, size order %llu\n",
don't you mean address not correctly aligned?
> +=09=09=09=09=09inv_info->addr_info.addr, size);
> +=09=09=09=09ret =3D -ERANGE;
> +=09=09=09=09goto out_unlock;
> +=09=09=09}
> +
> +=09=09=09qi_flush_piotlb(iommu, did, mm_to_dma_pfn(inv_info->addr_info.a=
ddr),
> +=09=09=09=09=09pasid, size, granu, inv_info->addr_info.flags & IOMMU_INV=
_ADDR_FLAGS_LEAF);
> +
> +=09=09=09/*
> +=09=09=09 * Always flush device IOTLB if ATS is enabled since guest
> +=09=09=09 * vIOMMU exposes CM =3D 1, no device IOTLB flush will be passe=
d
> +=09=09=09 * down.
> +=09=09=09 */
> +=09=09=09if (info->ats_enabled) {
> +=09=09=09=09qi_flush_dev_piotlb(iommu, sid, info->pfsid,
> +=09=09=09=09=09=09pasid, info->ats_qdep,
> +=09=09=09=09=09=09inv_info->addr_info.addr, size,
> +=09=09=09=09=09=09granu);
> +=09=09=09}
> +=09=09=09break;
> +=09=09case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +=09=09=09if (info->ats_enabled) {
> +=09=09=09=09qi_flush_dev_piotlb(iommu, sid, info->pfsid,
> +=09=09=09=09=09=09inv_info->addr_info.pasid, info->ats_qdep,
> +=09=09=09=09=09=09inv_info->addr_info.addr, size,
> +=09=09=09=09=09=09granu);
> +=09=09=09} else
> +=09=09=09=09pr_warn("Passdown device IOTLB flush w/o ATS!\n");
> +
> +=09=09=09break;
> +=09=09case IOMMU_CACHE_INV_TYPE_PASID:
> +=09=09=09qi_flush_pasid_cache(iommu, did, granu, inv_info->pasid_info.pa=
sid);
> +
> +=09=09=09break;
> +=09=09default:
> +=09=09=09dev_err(dev, "Unsupported IOMMU invalidation type %d\n",
> +=09=09=09=09cache_type);
> +=09=09=09ret =3D -EINVAL;
> +=09=09}
> +=09}
> +out_unlock:
> +=09spin_unlock(&iommu->lock);
> +=09spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +=09return ret;
> +}
> +#endif
> +
>  static int intel_iommu_map(struct iommu_domain *domain,
>  =09=09=09   unsigned long iova, phys_addr_t hpa,
>  =09=09=09   size_t size, int iommu_prot)
> @@ -6027,6 +6196,7 @@ const struct iommu_ops intel_iommu_ops =3D {
>  =09.is_attach_deferred=09=3D intel_iommu_is_attach_deferred,
>  =09.pgsize_bitmap=09=09=3D INTEL_IOMMU_PGSIZES,
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> +=09.cache_invalidate=09=3D intel_iommu_sva_invalidate,
>  =09.sva_bind_gpasid=09=3D intel_svm_bind_gpasid,
>  =09.sva_unbind_gpasid=09=3D intel_svm_unbind_gpasid,
>  #endif
>=20
Thanks

Eric

