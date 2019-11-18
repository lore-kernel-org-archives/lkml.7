Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383DDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DB82230F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8Rp/H+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRVMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:12:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbfKRVME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574111522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wuR8iAbLcZ8E+QIwRjyl/dUviuXJbioIM+3WsZH7a5k=;
        b=T8Rp/H+EUL2xq7NvOwDiX70892nrinaoJLc5nXUqrbyduVm5O3D99s+Eujayxx4CfDIXWd
        vYuq12KRlztlHa4K5YnufCkpvpQ9Ep6SLHOS0MDWbHY4TCouLeE+l5PcjhdGumwNusY6KR
        GpcHUQvsrvz/54oDJoDtP3YKdlaTc54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-IMBBP4fsONqDFmSX6RZW6w-1; Mon, 18 Nov 2019 16:11:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A07AB801E5B;
        Mon, 18 Nov 2019 21:11:57 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD8A55DD98;
        Mon, 18 Nov 2019 21:11:54 +0000 (UTC)
Subject: Re: [PATCH v2 07/10] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <14e130e8-abcb-534f-655f-25488ad3500b@redhat.com>
Date:   Mon, 18 Nov 2019 22:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574106153-45867-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: IMBBP4fsONqDFmSX6RZW6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/18/19 8:42 PM, Jacob Pan wrote:
> Make use of generic IOASID code to manage PASID allocation,
> free, and lookup. Replace Intel specific code.
> IOASID allocator is inclusive for both start and end of the allocation
> range. The current code is based on IDR, which is exclusive for
> the end of the allocation range. This patch fixes the off-by-one
> error in intel_svm_bind_mm, where pasid_max - 1 is used for the end of
> allocation range.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/Kconfig       |  1 +
>  drivers/iommu/intel-iommu.c | 13 +++++++------
>  drivers/iommu/intel-pasid.c | 36 ------------------------------------
>  drivers/iommu/intel-svm.c   | 41 +++++++++++++++++++++++++++------------=
--
>  4 files changed, 35 insertions(+), 56 deletions(-)
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
> index e90d0b914afe..26a2f57763ec 100644
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
> @@ -440,7 +448,9 @@ int intel_svm_unbind_mm(struct device *dev, int pasid=
)
>  =09=09=09=09kfree_rcu(sdev, rcu);
> =20
>  =09=09=09=09if (list_empty(&svm->devs)) {
> -=09=09=09=09=09intel_pasid_free_id(svm->pasid);
> +=09=09=09=09=09/* Clear private data so that free pass check */
> +=09=09=09=09=09ioasid_set_data(svm->pasid, NULL);
This still looks weird to me. clearing the private data before freeing
is a requirement from the custom allocation, if I am not wrong, ie. not
a requirement from the generic allocator. If confirmed, this should not
be part of this patch but added later on?


> +=09=09=09=09=09ioasid_free(svm->pasid);
>  =09=09=09=09=09if (svm->mm)
>  =09=09=09=09=09=09mmu_notifier_unregister(&svm->notifier, svm->mm);
> =20
> @@ -475,10 +485,14 @@ int intel_svm_is_pasid_valid(struct device *dev, in=
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
not related to this patch but in prq_event_thread
resp.qw0 and qw1 are not initialized in case (req->lpig ||
req->priv_data_present) is not true

> @@ -585,13 +599,12 @@ static irqreturn_t prq_event_thread(int irq, void *=
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

Thanks

Eric

