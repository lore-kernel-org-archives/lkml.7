Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F95C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EE42190C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390500AbfDXR1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:27:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbfDXR1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 301B72DE416;
        Wed, 24 Apr 2019 17:27:33 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26BBC60C64;
        Wed, 24 Apr 2019 17:27:27 +0000 (UTC)
Subject: Re: [PATCH v2 10/19] iommu/vt-d: Add custom allocator for IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-11-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <7a79c1cd-eef2-2233-3b31-4d93a6c3b48d@redhat.com>
Date:   Wed, 24 Apr 2019 19:27:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 24 Apr 2019 17:27:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/24/19 1:31 AM, Jacob Pan wrote:
> When VT-d driver runs in the guest, PASID allocation must be
> performed via virtual command interface. This patch register a
registers
> custom IOASID allocator which takes precedence over the default
> IDR based allocator.
nit: s/IDR based// . It is xarray based now.
 The resulting IOASID allocation will always
> come from the host. This ensures that PASID namespace is system-
> wide.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  2 ++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d93c4bd..ec6f22d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1711,6 +1711,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>  		if (ecap_prs(iommu->ecap))
>  			intel_svm_finish_prq(iommu);
>  	}
> +	ioasid_unregister_allocator(&iommu->pasid_allocator);
> +
>  #endif
>  }
>  
> @@ -4811,6 +4813,46 @@ static int __init platform_optin_force_iommu(void)
>  	return 1;
>  }
>  
> +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
> +{
> +	struct intel_iommu *iommu = data;
> +	ioasid_t ioasid;
> +
> +	/*
> +	 * VT-d virtual command interface always uses the full 20 bit
> +	 * PASID range. Host can partition guest PASID range based on
> +	 * policies but it is out of guest's control.
> +	 */
The above comment does not exactly relate to the check below
> +	if (min < PASID_MIN || max > PASID_MAX)
> +		return -EINVAL;
> +
> +	if (vcmd_alloc_pasid(iommu, &ioasid))
> +		return INVALID_IOASID;
> +
> +	return ioasid;
> +}
> +
> +static int intel_ioasid_free(ioasid_t ioasid, void *data)
> +{
> +	struct iommu_pasid_alloc_info *svm;
> +	struct intel_iommu *iommu = data;
> +
> +	if (!iommu || !cap_caching_mode(iommu->cap))
> +		return -EINVAL;
can !cap_caching_mode(iommu->cap) be true as the allocator only is set
if CM?
> +	/*
> +	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
> +	 * We can only free the PASID when all the devices are unbond.
> +	 */
> +	svm = ioasid_find(NULL, ioasid, NULL);
> +	if (!svm) {
you can avoid using the local svm variable.
> +		pr_warn("Freeing unbond IOASID %d\n", ioasid);
unbound
> +		return -EBUSY;
-EINVAL?
> +	}
> +	vcmd_free_pasid(iommu, ioasid);
> +
> +	return 0;
> +}
> +
>  int __init intel_iommu_init(void)
>  {
>  	int ret = -ENODEV;
> @@ -4912,6 +4954,22 @@ int __init intel_iommu_init(void)
>  				       "%s", iommu->name);
>  		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
>  		iommu_device_register(&iommu->iommu);
> +		if (cap_caching_mode(iommu->cap) && sm_supported(iommu)) {
so shouldn't you test VCCAP_REG as well?
> +			/*
> +			 * Register a custom ASID allocator if we are running
> +			 * in a guest, the purpose is to have a system wide PASID
> +			 * namespace among all PASID users.
> +			 * There can be multiple vIOMMUs in each guest but only
> +			 * one allocator is active. All vIOMMU allocators will
> +			 * eventually be calling the same host allocator.
> +			 */
> +			iommu->pasid_allocator.alloc = intel_ioasid_alloc;
> +			iommu->pasid_allocator.free = intel_ioasid_free;
> +			iommu->pasid_allocator.pdata = (void *)iommu;
> +			ret = ioasid_register_allocator(&iommu->pasid_allocator);
> +			if (ret)
> +				pr_warn("Custom PASID allocator registeration failed\n");
registration
> +		}
>  	}
>  
>  	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index bff907b..c24c8aa 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -31,6 +31,7 @@
>  #include <linux/iommu.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/dmar.h>
> +#include <linux/ioasid.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
> @@ -549,6 +550,7 @@ struct intel_iommu {
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> +	struct ioasid_allocator pasid_allocator; /* Custom allocator for PASIDs */
>  #endif
>  	struct q_inval  *qi;            /* Queued invalidation info */
>  	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
> 

Thanks

Eric
