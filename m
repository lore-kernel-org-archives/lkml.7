Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D236C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA83A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfGPJaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfGPJaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F953550CF;
        Tue, 16 Jul 2019 09:30:21 +0000 (UTC)
Received: from [10.36.116.32] (ovpn-116-32.ams2.redhat.com [10.36.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF9375D71B;
        Tue, 16 Jul 2019 09:30:15 +0000 (UTC)
Subject: Re: [PATCH v4 14/22] iommu/vt-d: Add custom allocator for IOASID
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
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1560087862-57608-15-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <2f2ba561-793f-a6a0-5765-ef8e9a5a3ab6@redhat.com>
Date:   Tue, 16 Jul 2019 11:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1560087862-57608-15-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 09:30:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 6/9/19 3:44 PM, Jacob Pan wrote:
> When VT-d driver runs in the guest, PASID allocation must be
> performed via virtual command interface. This patch registers a
> custom IOASID allocator which takes precedence over the default
> XArray based allocator. The resulting IOASID allocation will always
> come from the host. This ensures that PASID namespace is system-
> wide.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/Kconfig       |  1 +
>  drivers/iommu/intel-iommu.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  2 ++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c40c4b5..5d1bc2a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -213,6 +213,7 @@ config INTEL_IOMMU_SVM
>  	bool "Support for Shared Virtual Memory with Intel IOMMU"
>  	depends on INTEL_IOMMU && X86
>  	select PCI_PASID
> +	select IOASID
>  	select MMU_NOTIFIER
>  	select IOASID
>  	help
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 09b8ff0..5b84994 100644
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
> @@ -4820,6 +4822,46 @@ static int __init platform_optin_force_iommu(void)
>  	return 1;
>  }
>  
> +#ifdef CONFIG_INTEL_IOMMU_SVM
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
> +	if (min < PASID_MIN || max > PASID_MAX)
> +		return -EINVAL;
ioasid_alloc() does not handle that error value, use INVALID_IOASID?
> +
> +	if (vcmd_alloc_pasid(iommu, &ioasid))
> +		return INVALID_IOASID;
> +
> +	return ioasid;
> +}
> +
> +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> +{
> +	struct iommu_pasid_alloc_info *svm;
> +	struct intel_iommu *iommu = data;
> +
> +	if (!iommu)
> +		return;
> +	/*
> +	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
> +	 * We can only free the PASID when all the devices are unbond.
> +	 */
> +	svm = ioasid_find(NULL, ioasid, NULL);
> +	if (!svm) {
> +		pr_warn("Freeing unbond IOASID %d\n", ioasid);
> +		return;
> +	}
> +	vcmd_free_pasid(iommu, ioasid);
> +}
> +#endif
> +
>  int __init intel_iommu_init(void)
>  {
>  	int ret = -ENODEV;
> @@ -4924,6 +4966,24 @@ int __init intel_iommu_init(void)
>  				       "%s", iommu->name);
>  		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
>  		iommu_device_register(&iommu->iommu);
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +		if (cap_caching_mode(iommu->cap) && sm_supported(iommu)) {
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
what if it fails, don't you want a tear down path?

Thanks

Eric
> +		}
> +#endif
>  	}
>  
>  	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index bff907b..8605c74 100644
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
> +	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
>  #endif
>  	struct q_inval  *qi;            /* Queued invalidation info */
>  	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
> 
