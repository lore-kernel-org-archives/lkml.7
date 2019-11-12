Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E55C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB24F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpPneiWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKLJzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:55:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48929 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbfKLJzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573552503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+FxLvEY0C/giy8/h+xtIwqhQ621a6X8ZoITux0zyQI=;
        b=XpPneiWRg95ZtH7qw3DD6o7MAv5comKy16cAtxa6iW4Xz+QrMSyEQbXt0LlKijngH9Liww
        uXwaRIyBuO+h2qzZOE/sJzzM1PePuJ9gWUy36w8L5Q1Uynyni1luvq6oe/LBLUMFAQv1b4
        sBgXicX7hog/0neE5w6StnDorFLs0lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-uiQ0zLRMOBaPn5-IwFwgYg-1; Tue, 12 Nov 2019 04:55:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 735E91800D7A;
        Tue, 12 Nov 2019 09:54:58 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB5785C1C3;
        Tue, 12 Nov 2019 09:54:50 +0000 (UTC)
Subject: Re: [PATCH v7 04/11] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <b69e22f9-a0cf-51e2-6840-44ac523e9e28@redhat.com>
 <20191108145506.6bcb6f9e@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <cef0be33-7864-7f29-f07e-b0880d018856@redhat.com>
Date:   Tue, 12 Nov 2019 10:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191108145506.6bcb6f9e@jacob-builder>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: uiQ0zLRMOBaPn5-IwFwgYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/8/19 11:55 PM, Jacob Pan wrote:
> On Fri, 8 Nov 2019 12:30:31 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
>=20
>> Hi Jacob,
>>
>> On 10/24/19 9:54 PM, Jacob Pan wrote:
>>> Make use of generic IOASID code to manage PASID allocation,
>>> free, and lookup. Replace Intel specific code.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>  drivers/iommu/intel-iommu.c | 12 ++++++------
>>>  drivers/iommu/intel-pasid.c | 36
>>> ------------------------------------ drivers/iommu/intel-svm.c   |
>>> 39 +++++++++++++++++++++++---------------- 3 files changed, 29
>>> insertions(+), 58 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c
>>> b/drivers/iommu/intel-iommu.c index ced1d89ef977..2ea09b988a23
>>> 100644 --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -5311,7 +5311,7 @@ static void auxiliary_unlink_device(struct
>>> dmar_domain *domain, domain->auxd_refcnt--;
>>> =20
>>>  =09if (!domain->auxd_refcnt && domain->default_pasid > 0)
>>> -=09=09intel_pasid_free_id(domain->default_pasid);
>>> +=09=09ioasid_free(domain->default_pasid);
>>>  }
>>> =20
>>>  static int aux_domain_add_dev(struct dmar_domain *domain,
>>> @@ -5329,10 +5329,10 @@ static int aux_domain_add_dev(struct
>>> dmar_domain *domain, if (domain->default_pasid <=3D 0) {
>>>  =09=09int pasid;
>>> =20
>>> -=09=09pasid =3D intel_pasid_alloc_id(domain, PASID_MIN,
>>> -
>>> pci_max_pasids(to_pci_dev(dev)),
>>> -=09=09=09=09=09     GFP_KERNEL);
>>> -=09=09if (pasid <=3D 0) {
>>> +=09=09/* No private data needed for the default pasid */
>>> +=09=09pasid =3D ioasid_alloc(NULL, PASID_MIN,
>>> pci_max_pasids(to_pci_dev(dev)) - 1,
>>> +=09=09=09=09NULL);
>>> +=09=09if (pasid =3D=3D INVALID_IOASID) {
>>>  =09=09=09pr_err("Can't allocate default pasid\n");
>>>  =09=09=09return -ENODEV;
>>>  =09=09}
>>> @@ -5368,7 +5368,7 @@ static int aux_domain_add_dev(struct
>>> dmar_domain *domain, spin_unlock(&iommu->lock);
>>>  =09spin_unlock_irqrestore(&device_domain_lock, flags);
>>>  =09if (!domain->auxd_refcnt && domain->default_pasid > 0)
>>> -=09=09intel_pasid_free_id(domain->default_pasid);
>>> +=09=09ioasid_free(domain->default_pasid);
>>> =20
>>>  =09return ret;
>>>  }
>>> diff --git a/drivers/iommu/intel-pasid.c
>>> b/drivers/iommu/intel-pasid.c index d81e857d2b25..e79d680fe300
>>> 100644 --- a/drivers/iommu/intel-pasid.c
>>> +++ b/drivers/iommu/intel-pasid.c
>>> @@ -26,42 +26,6 @@
>>>   */
>>>  static DEFINE_SPINLOCK(pasid_lock);
>>>  u32 intel_pasid_max_id =3D PASID_MAX;
>>> -static DEFINE_IDR(pasid_idr);
>>> -
>>> -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
>>> -{
>>> -=09int ret, min, max;
>>> -
>>> -=09min =3D max_t(int, start, PASID_MIN);
>>> -=09max =3D min_t(int, end, intel_pasid_max_id);
>>> -
>>> -=09WARN_ON(in_interrupt());
>>> -=09idr_preload(gfp);
>>> -=09spin_lock(&pasid_lock);
>>> -=09ret =3D idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
>>> -=09spin_unlock(&pasid_lock);
>>> -=09idr_preload_end();
>>> -
>>> -=09return ret;
>>> -}
>>> -
>>> -void intel_pasid_free_id(int pasid)
>>> -{
>>> -=09spin_lock(&pasid_lock);
>>> -=09idr_remove(&pasid_idr, pasid);
>>> -=09spin_unlock(&pasid_lock);
>>> -}
>>> -
>>> -void *intel_pasid_lookup_id(int pasid)
>>> -{
>>> -=09void *p;
>>> -
>>> -=09spin_lock(&pasid_lock);
>>> -=09p =3D idr_find(&pasid_idr, pasid);
>>> -=09spin_unlock(&pasid_lock);
>>> -
>>> -=09return p;
>>> -}
>>> =20
>>>  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
>>> *pasid) {
>>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>>> index 9b159132405d..a9a7f85a09bc 100644
>>> --- a/drivers/iommu/intel-svm.c
>>> +++ b/drivers/iommu/intel-svm.c
>>> @@ -17,6 +17,7 @@
>>>  #include <linux/dmar.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/mm_types.h>
>>> +#include <linux/ioasid.h>
>>>  #include <asm/page.h>
>>> =20
>>>  #include "intel-pasid.h"
>>> @@ -318,16 +319,15 @@ int intel_svm_bind_mm(struct device *dev, int
>>> *pasid, int flags, struct svm_dev_ if (pasid_max >
>>> intel_pasid_max_id) pasid_max =3D intel_pasid_max_id;
>>> =20
>>> -=09=09/* Do not use PASID 0 in caching mode (virtualised
>>> IOMMU) */
>>> -=09=09ret =3D intel_pasid_alloc_id(svm,
>>> -=09=09=09=09=09   !!cap_caching_mode(iommu->cap),
>>> -=09=09=09=09=09   pasid_max - 1,
>>> GFP_KERNEL);
>>> -=09=09if (ret < 0) {
>>> +=09=09/* Do not use PASID 0, reserved for RID to PASID */
>>> +=09=09svm->pasid =3D ioasid_alloc(NULL, PASID_MIN,
>>> +=09=09=09=09=09pasid_max - 1, svm); =20
>> pasid_max -1 is inclusive. whereas max param in intel_pasid_alloc_id()
>> is exclusive right? If you fixed an issue, you can mention it in the
>> commit message.
> yes, i should mention that. intel_pasid_alloc_id() uses IDR which is
> end exclusive. ioasid uses xarray, which is inclusive.=20
>>> +=09=09if (svm->pasid =3D=3D INVALID_IOASID) { =20
>>>  =09=09=09kfree(svm);>
>>> kfree(sdev); =20
>>> +=09=09=09ret =3D ENOSPC; =20
>> -ENOSPC.
>> Nit: in 2/11 vcmd_alloc_pasid returned -ENOMEM
> yes, it should be -ENOSPC as well.
>=20
>>>  =09=09=09goto out;
>>>  =09=09}
>>> -=09=09svm->pasid =3D ret;
>>>  =09=09svm->notifier.ops =3D &intel_mmuops;
>>>  =09=09svm->mm =3D mm;
>>>  =09=09svm->flags =3D flags;
>>> @@ -337,7 +337,7 @@ int intel_svm_bind_mm(struct device *dev, int
>>> *pasid, int flags, struct svm_dev_ if (mm) {
>>>  =09=09=09ret =3D
>>> mmu_notifier_register(&svm->notifier, mm); if (ret) {
>>> -=09=09=09=09intel_pasid_free_id(svm->pasid);
>>> +=09=09=09=09ioasid_free(svm->pasid);
>>>  =09=09=09=09kfree(svm);
>>>  =09=09=09=09kfree(sdev);
>>>  =09=09=09=09goto out;
>>> @@ -353,7 +353,7 @@ int intel_svm_bind_mm(struct device *dev, int
>>> *pasid, int flags, struct svm_dev_ if (ret) {
>>>  =09=09=09if (mm)
>>>  =09=09=09=09mmu_notifier_unregister(&svm->notifier,
>>> mm);
>>> -=09=09=09intel_pasid_free_id(svm->pasid);
>>> +=09=09=09ioasid_free(svm->pasid);
>>>  =09=09=09kfree(svm);
>>>  =09=09=09kfree(sdev);
>>>  =09=09=09goto out;
>>> @@ -401,7 +401,12 @@ int intel_svm_unbind_mm(struct device *dev,
>>> int pasid) if (!iommu)
>>>  =09=09goto out;
>>> =20
>>> -=09svm =3D intel_pasid_lookup_id(pasid);
>>> +=09svm =3D ioasid_find(NULL, pasid, NULL);
>>> +=09if (IS_ERR(svm)) {
>>> +=09=09ret =3D PTR_ERR(svm);
>>> +=09=09goto out;
>>> +=09}
>>> +
>>>  =09if (!svm)
>>>  =09=09goto out;
>>> =20
>>> @@ -423,7 +428,9 @@ int intel_svm_unbind_mm(struct device *dev, int
>>> pasid) kfree_rcu(sdev, rcu);
>>> =20
>>>  =09=09=09=09if (list_empty(&svm->devs)) {
>>> -
>>> intel_pasid_free_id(svm->pasid);
>>> +=09=09=09=09=09/* Clear private data so
>>> that free pass check */> +
>>> ioasid_set_data(svm->pasid, NULL); =20
>> I don't get the above comment. Why is it needed?
> Having private data associated with an IOASID is an indicator that this
> IOASID is busy. So we have to clear it to signal it is free.
> Actually, I am planning to introduce a refcount per IOASID since there
> will be multiple users of IOASID, e.g. IOMMU driver and KVM. When
> refcount =3D=3D 0, we can free.
Ah OK I missed that. This is a specificity of the intel custom PASID
allocator, ie intel_ioasid_free and not a generic behavior.

Thanks

Eric
>=20
>>> +=09=09=09=09=09ioasid_free(svm->pasid);
>>>  =09=09=09=09=09if (svm->mm)
>>>  =09=09=09=09=09=09mmu_notifier_unregister(&svm->notifier,
>>> svm->mm);=20
>>> @@ -458,10 +465,11 @@ int intel_svm_is_pasid_valid(struct device
>>> *dev, int pasid) if (!iommu)
>>>  =09=09goto out;
>>> =20
>>> -=09svm =3D intel_pasid_lookup_id(pasid);
>>> -=09if (!svm)
>>> +=09svm =3D ioasid_find(NULL, pasid, NULL);
>>> +=09if (IS_ERR(svm)) {
>>> +=09=09ret =3D PTR_ERR(svm);
>>>  =09=09goto out;
>>> -
>>> +=09}
>>>  =09/* init_mm is used in this case */
>>>  =09if (!svm->mm)
>>>  =09=09ret =3D 1;
>>> @@ -568,13 +576,12 @@ static irqreturn_t prq_event_thread(int irq,
>>> void *d)=20
>>>  =09=09if (!svm || svm->pasid !=3D req->pasid) {
>>>  =09=09=09rcu_read_lock();
>>> -=09=09=09svm =3D intel_pasid_lookup_id(req->pasid);
>>> +=09=09=09svm =3D ioasid_find(NULL, req->pasid, NULL);
>>>  =09=09=09/* It *can't* go away, because the driver
>>> is not permitted
>>>  =09=09=09 * to unbind the mm while any page faults
>>> are outstanding.
>>>  =09=09=09 * So we only need RCU to protect the
>>> internal idr code. */ rcu_read_unlock();
>>> -
>>> -=09=09=09if (!svm) {
>>> +=09=09=09if (IS_ERR(svm) || !svm) {
>>>  =09=09=09=09pr_err("%s: Page request for
>>> invalid PASID %d: %08llx %08llx\n", iommu->name, req->pasid,
>>> ((unsigned long long *)req)[0], ((unsigned long long *)req)[1]);
>>>  =20
>> Thanks
>>
>> Eric
>>
>=20
> [Jacob Pan]
>=20

