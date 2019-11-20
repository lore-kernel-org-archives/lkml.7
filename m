Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08DCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82DF20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTmc1NlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKTVGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:06:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbfKTVGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574283996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t22FsjCBe/pgglckOhOYEXus63aVy7knMeEl8aZlZwM=;
        b=FTmc1NlRqAxv9MbFlmoVdMyDYwu1m9v3jYrBsoIb/gmKlPV9P79NuOM+MO3dGtmlkNkBGz
        Eq2RtxwYo1NRf1onFparUbus9xRvAJGRGbbqFuQu1ea3Ry5tMkY0FLJO64W3INu01BaVgK
        jM3rTz4csa+cneE6Kd4GSsv/9iuBK0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-Y-aXBW0EM-CnElzS9mDa3g-1; Wed, 20 Nov 2019 16:06:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A069EDC29;
        Wed, 20 Nov 2019 21:06:30 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 868F350A93;
        Wed, 20 Nov 2019 21:06:27 +0000 (UTC)
Subject: Re: [PATCH v3 6/8] iommu/vt-d: Replace Intel specific PASID allocator
 with IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574186193-30457-7-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5ead3e84-d6b6-8f97-c83b-236bbe53be86@redhat.com>
Date:   Wed, 20 Nov 2019 22:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Y-aXBW0EM-CnElzS9mDa3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/19/19 6:56 PM, Jacob Pan wrote:
> Make use of generic IOASID code to manage PASID allocation,
> free, and lookup. Replace Intel specific code.
> IOASID allocator is inclusive for both start and end of the allocation
> range. The current code is based on IDR, which is exclusive for
> the end of the allocation range. This patch fixes the off-by-one
> error in intel_svm_bind_mm, where pasid_max - 1 is used for the end of
> allocation range.
no more as this is handled in 5/8
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/Kconfig       |  1 +
>  drivers/iommu/intel-iommu.c | 13 +++++++------
>  drivers/iommu/intel-pasid.c | 36 ------------------------------------
>  drivers/iommu/intel-svm.c   | 39 +++++++++++++++++++++++++--------------
>  4 files changed, 33 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index fd50ddffffbf..43ce450a40d3 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -212,6 +212,7 @@ config INTEL_IOMMU_SVM
>  =09depends on INTEL_IOMMU && X86
>  =09select PCI_PASID
>  =09select MMU_NOTIFIER
> +=09select IOASID
>  =09help
>  =09  Shared Virtual Memory (SVM) provides a facility for devices
>  =09  to access DMA resources through process address space by
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d598168e410d..a84f0caa33a0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5238,7 +5238,7 @@ static void auxiliary_unlink_device(struct dmar_dom=
ain *domain,
>  =09domain->auxd_refcnt--;
> =20
>  =09if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -=09=09intel_pasid_free_id(domain->default_pasid);
> +=09=09ioasid_free(domain->default_pasid);
>  }
> =20
>  static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5256,10 +5256,11 @@ static int aux_domain_add_dev(struct dmar_domain =
*domain,
>  =09if (domain->default_pasid <=3D 0) {
>  =09=09int pasid;
> =20
> -=09=09pasid =3D intel_pasid_alloc_id(domain, PASID_MIN,
> -=09=09=09=09=09     pci_max_pasids(to_pci_dev(dev)),
> -=09=09=09=09=09     GFP_KERNEL);
> -=09=09if (pasid <=3D 0) {
> +=09=09/* No private data needed for the default pasid */
> +=09=09pasid =3D ioasid_alloc(NULL, PASID_MIN,
> +=09=09=09=09     pci_max_pasids(to_pci_dev(dev)) - 1,
> +=09=09=09=09     NULL);
> +=09=09if (pasid =3D=3D INVALID_IOASID) {
>  =09=09=09pr_err("Can't allocate default pasid\n");
>  =09=09=09return -ENODEV;
>  =09=09}
> @@ -5295,7 +5296,7 @@ static int aux_domain_add_dev(struct dmar_domain *d=
omain,
>  =09spin_unlock(&iommu->lock);
>  =09spin_unlock_irqrestore(&device_domain_lock, flags);
>  =09if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -=09=09intel_pasid_free_id(domain->default_pasid);
> +=09=09ioasid_free(domain->default_pasid);
> =20
>  =09return ret;
>  }
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 732bfee228df..3cb569e76642 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -26,42 +26,6 @@
>   */
>  static DEFINE_SPINLOCK(pasid_lock);
>  u32 intel_pasid_max_id =3D PASID_MAX;
> -static DEFINE_IDR(pasid_idr);
> -
> -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
> -{
> -=09int ret, min, max;
> -
> -=09min =3D max_t(int, start, PASID_MIN);
> -=09max =3D min_t(int, end, intel_pasid_max_id);
> -
> -=09WARN_ON(in_interrupt());
> -=09idr_preload(gfp);
> -=09spin_lock(&pasid_lock);
> -=09ret =3D idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
> -=09spin_unlock(&pasid_lock);
> -=09idr_preload_end();
> -
> -=09return ret;
> -}
> -
> -void intel_pasid_free_id(int pasid)
> -{
> -=09spin_lock(&pasid_lock);
> -=09idr_remove(&pasid_idr, pasid);
> -=09spin_unlock(&pasid_lock);
> -}
> -
> -void *intel_pasid_lookup_id(int pasid)
> -{
> -=09void *p;
> -
> -=09spin_lock(&pasid_lock);
> -=09p =3D idr_find(&pasid_idr, pasid);
> -=09spin_unlock(&pasid_lock);
> -
> -=09return p;
> -}
> =20
>  /*
>   * Per device pasid table management:
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index e90d0b914afe..71b85b892c56 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -17,6 +17,7 @@
>  #include <linux/dmar.h>
>  #include <linux/interrupt.h>
>  #include <linux/mm_types.h>
> +#include <linux/ioasid.h>
>  #include <asm/page.h>
> =20
>  #include "intel-pasid.h"
> @@ -335,16 +336,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasi=
d, int flags, struct svm_dev_
>  =09=09if (pasid_max > intel_pasid_max_id)
>  =09=09=09pasid_max =3D intel_pasid_max_id;
> =20
> -=09=09/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
> -=09=09ret =3D intel_pasid_alloc_id(svm,
> -=09=09=09=09=09   !!cap_caching_mode(iommu->cap),
> -=09=09=09=09=09   pasid_max, GFP_KERNEL);
> -=09=09if (ret < 0) {
> +=09=09/* Do not use PASID 0, reserved for RID to PASID */
> +=09=09svm->pasid =3D ioasid_alloc(NULL, PASID_MIN,
> +=09=09=09=09=09  pasid_max - 1, svm);
> +=09=09if (svm->pasid =3D=3D INVALID_IOASID) {
>  =09=09=09kfree(svm);
>  =09=09=09kfree(sdev);
> +=09=09=09ret =3D -ENOSPC;
>  =09=09=09goto out;
>  =09=09}
> -=09=09svm->pasid =3D ret;
>  =09=09svm->notifier.ops =3D &intel_mmuops;
>  =09=09svm->mm =3D mm;
>  =09=09svm->flags =3D flags;
> @@ -354,7 +354,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid,=
 int flags, struct svm_dev_
>  =09=09if (mm) {
>  =09=09=09ret =3D mmu_notifier_register(&svm->notifier, mm);
>  =09=09=09if (ret) {
> -=09=09=09=09intel_pasid_free_id(svm->pasid);
> +=09=09=09=09ioasid_free(svm->pasid);
>  =09=09=09=09kfree(svm);
>  =09=09=09=09kfree(sdev);
>  =09=09=09=09goto out;
> @@ -370,7 +370,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid,=
 int flags, struct svm_dev_
>  =09=09if (ret) {
>  =09=09=09if (mm)
>  =09=09=09=09mmu_notifier_unregister(&svm->notifier, mm);
> -=09=09=09intel_pasid_free_id(svm->pasid);
> +=09=09=09ioasid_free(svm->pasid);
>  =09=09=09kfree(svm);
>  =09=09=09kfree(sdev);
>  =09=09=09goto out;
> @@ -418,7 +418,15 @@ int intel_svm_unbind_mm(struct device *dev, int pasi=
d)
>  =09if (!iommu)
>  =09=09goto out;
> =20
> -=09svm =3D intel_pasid_lookup_id(pasid);
> +=09svm =3D ioasid_find(NULL, pasid, NULL);
> +=09if (!svm)
> +=09=09goto out;
> +
> +=09if (IS_ERR(svm)) {
> +=09=09ret =3D PTR_ERR(svm);
> +=09=09goto out;
> +=09}
> +
>  =09if (!svm)
>  =09=09goto out;
> =20
> @@ -440,7 +448,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid=
)
>  =09=09=09=09kfree_rcu(sdev, rcu);
> =20
>  =09=09=09=09if (list_empty(&svm->devs)) {
> -=09=09=09=09=09intel_pasid_free_id(svm->pasid);
> +=09=09=09=09=09ioasid_free(svm->pasid);
>  =09=09=09=09=09if (svm->mm)
>  =09=09=09=09=09=09mmu_notifier_unregister(&svm->notifier, svm->mm);
> =20
> @@ -475,10 +483,14 @@ int intel_svm_is_pasid_valid(struct device *dev, in=
t pasid)
>  =09if (!iommu)
>  =09=09goto out;
> =20
> -=09svm =3D intel_pasid_lookup_id(pasid);
> +=09svm =3D ioasid_find(NULL, pasid, NULL);
>  =09if (!svm)
>  =09=09goto out;
> =20
> +=09if (IS_ERR(svm)) {
> +=09=09ret =3D PTR_ERR(svm);
> +=09=09goto out;
> +=09}
>  =09/* init_mm is used in this case */
>  =09if (!svm->mm)
>  =09=09ret =3D 1;
> @@ -585,13 +597,12 @@ static irqreturn_t prq_event_thread(int irq, void *=
d)
> =20
>  =09=09if (!svm || svm->pasid !=3D req->pasid) {
>  =09=09=09rcu_read_lock();
> -=09=09=09svm =3D intel_pasid_lookup_id(req->pasid);
> +=09=09=09svm =3D ioasid_find(NULL, req->pasid, NULL);
>  =09=09=09/* It *can't* go away, because the driver is not permitted
>  =09=09=09 * to unbind the mm while any page faults are outstanding.
>  =09=09=09 * So we only need RCU to protect the internal idr code. */
>  =09=09=09rcu_read_unlock();
> -
> -=09=09=09if (!svm) {
> +=09=09=09if (IS_ERR_OR_NULL(svm)) {
>  =09=09=09=09pr_err("%s: Page request for invalid PASID %d: %08llx %08llx=
\n",
>  =09=09=09=09       iommu->name, req->pasid, ((unsigned long long *)req)[=
0],
>  =09=09=09=09       ((unsigned long long *)req)[1]);
>=20
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

