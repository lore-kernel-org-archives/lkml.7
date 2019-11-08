Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9875C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25DE207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNDOmiP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfKHKkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:40:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbfKHKkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573209635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qrqWUJQWTmJgUkTe+8FskhOF7NgQLC9//N4YGCrm9N8=;
        b=bNDOmiP4JoidIYQZbo+bkMDtYDUBcq7BTpIbOnTrFKq/r7aDfY8HmhfywzBh+8fTpwlmG/
        tzSp45CIENmA96NKQDeYHCIgHZ781WSUfdrbhQfn612AoaLmH7zT0YO7XMDHvMFl6fSvkX
        lf4//JrdAPV+UBtzDkG+8f144qPEt54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-4vJuvT5GMNGLe6koCW6yLQ-1; Fri, 08 Nov 2019 05:40:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 237DD477;
        Fri,  8 Nov 2019 10:40:31 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7652A1001DC2;
        Fri,  8 Nov 2019 10:40:25 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
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
 <1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <d4902c68-57b7-a116-10fa-f4b292304f9a@redhat.com>
Date:   Fri, 8 Nov 2019 11:40:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4vJuvT5GMNGLe6koCW6yLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 10/24/19 9:54 PM, Jacob Pan wrote:
> When VT-d driver runs in the guest, PASID allocation must be
> performed via virtual command interface. This patch registers a
> custom IOASID allocator which takes precedence over the default
> XArray based allocator. The resulting IOASID allocation will always
> come from the host. This ensures that PASID namespace is system-
> wide.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/Kconfig       |  1 +
>  drivers/iommu/intel-iommu.c | 67 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/intel-iommu.h |  2 ++
>  3 files changed, 70 insertions(+)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index fd50ddffffbf..961fe5795a90 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -211,6 +211,7 @@ config INTEL_IOMMU_SVM
>  =09bool "Support for Shared Virtual Memory with Intel IOMMU"
>  =09depends on INTEL_IOMMU && X86
>  =09select PCI_PASID
> +=09select IOASID
>  =09select MMU_NOTIFIER
>  =09help
>  =09  Shared Virtual Memory (SVM) provides a facility for devices
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3f974919d3bd..ced1d89ef977 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1706,6 +1706,9 @@ static void free_dmar_iommu(struct intel_iommu *iom=
mu)
>  =09=09if (ecap_prs(iommu->ecap))
>  =09=09=09intel_svm_finish_prq(iommu);
>  =09}
> +=09if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> +=09=09ioasid_unregister_allocator(&iommu->pasid_allocator);
> +
>  #endif
>  }
> =20
> @@ -4910,6 +4913,44 @@ static int __init probe_acpi_namespace_devices(voi=
d)
>  =09return 0;
>  }
> =20
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *dat=
a)
> +{
> +=09struct intel_iommu *iommu =3D data;
> +=09ioasid_t ioasid;
> +
> +=09/*
> +=09 * VT-d virtual command interface always uses the full 20 bit
> +=09 * PASID range. Host can partition guest PASID range based on
> +=09 * policies but it is out of guest's control.
> +=09 */
> +=09if (min < PASID_MIN || max > intel_pasid_max_id)> +=09=09return INVAL=
ID_IOASID;

> +
> +=09if (vcmd_alloc_pasid(iommu, &ioasid))
> +=09=09return INVALID_IOASID;
> +
> +=09return ioasid;
> +}
> +
> +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> +{
> +=09struct intel_iommu *iommu =3D data;
> +
> +=09if (!iommu)
> +=09=09return;
> +=09/*
> +=09 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
> +=09 * We can only free the PASID when all the devices are unbond.
> +=09 */
> +=09if (ioasid_find(NULL, ioasid, NULL)) {
> +=09=09pr_alert("Cannot free active IOASID %d\n", ioasid);
> +=09=09return;
> +=09}
> +=09vcmd_free_pasid(iommu, ioasid);
> +}
> +#endif
> +
>  int __init intel_iommu_init(void)
>  {
>  =09int ret =3D -ENODEV;
> @@ -5020,6 +5061,32 @@ int __init intel_iommu_init(void)
>  =09=09=09=09       "%s", iommu->name);
>  =09=09iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
>  =09=09iommu_device_register(&iommu->iommu);
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +=09=09if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap)) {
> +=09=09=09pr_info("Register custom PASID allocator\n");
> +=09=09=09/*
> +=09=09=09 * Register a custom ASID allocator if we are running
> +=09=09=09 * in a guest, the purpose is to have a system wide PASID
> +=09=09=09 * namespace among all PASID users.
> +=09=09=09 * There can be multiple vIOMMUs in each guest but only
> +=09=09=09 * one allocator is active. All vIOMMU allocators will
> +=09=09=09 * eventually be calling the same host allocator.
> +=09=09=09 */
> +=09=09=09iommu->pasid_allocator.alloc =3D intel_ioasid_alloc;
> +=09=09=09iommu->pasid_allocator.free =3D intel_ioasid_free;
> +=09=09=09iommu->pasid_allocator.pdata =3D (void *)iommu;
> +=09=09=09ret =3D ioasid_register_allocator(&iommu->pasid_allocator);
> +=09=09=09if (ret) {
> +=09=09=09=09pr_warn("Custom PASID allocator registeration failed\n");
nit: registration
> +=09=09=09=09/*
> +=09=09=09=09 * Disable scalable mode on this IOMMU if there
> +=09=09=09=09 * is no custom allocator. Mixing SM capable vIOMMU
> +=09=09=09=09 * and non-SM vIOMMU are not supported:=20
nit; is not supported. But I guess you will reshape it according to
previous comments.
> +=09=09=09=09 */
> +=09=09=09=09intel_iommu_sm =3D 0;
> +=09=09=09}
> +=09=09}
> +#endif
>  =09}
> =20
>  =09bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 1d4b8dcdc5d8..c624733cb2e6 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -19,6 +19,7 @@
>  #include <linux/iommu.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/dmar.h>
> +#include <linux/ioasid.h>
> =20
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
> @@ -546,6 +547,7 @@ struct intel_iommu {
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  =09struct page_req_dsc *prq;
>  =09unsigned char prq_name[16];    /* Name for PRQ interrupt */
> +=09struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for =
PASIDs */
>  #endif
>  =09struct q_inval  *qi;            /* Queued invalidation info */
>  =09u32 *iommu_state; /* Store iommu states between suspend and resume.*/
>=20

Thanks

Eric

