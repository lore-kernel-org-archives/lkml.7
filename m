Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6828C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAAD206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLRHSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:18:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfLRHSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:18:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 20:11:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,328,1571727600"; 
   d="scan'208";a="227730233"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2019 20:11:47 -0800
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 08/10] iommu/vt-d: Add custom allocator for IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1576524252-79116-9-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9c9c818c-ccb1-544d-2041-cf7017c4d898@linux.intel.com>
Date:   Wed, 18 Dec 2019 12:10:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576524252-79116-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/17/19 3:24 AM, Jacob Pan wrote:
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
>   drivers/iommu/intel-iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/intel-iommu.h |  2 ++
>   2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index e90102c7540d..b0c0bb6f740e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1700,6 +1700,9 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>   		if (ecap_prs(iommu->ecap))
>   			intel_svm_finish_prq(iommu);
>   	}
> +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> +		ioasid_unregister_allocator(&iommu->pasid_allocator);
> +
>   #endif
>   }
>   
> @@ -3181,6 +3184,75 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>   	return ret;
>   }
>   
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
> +{
> +	struct intel_iommu *iommu = data;
> +	ioasid_t ioasid;
> +

Check !iommu just like the free api?

> +	/*
> +	 * VT-d virtual command interface always uses the full 20 bit
> +	 * PASID range. Host can partition guest PASID range based on
> +	 * policies but it is out of guest's control.
> +	 */
> +	if (min < PASID_MIN || max > intel_pasid_max_id)
> +		return INVALID_IOASID;
> +
> +	if (vcmd_alloc_pasid(iommu, &ioasid))
> +		return INVALID_IOASID;
> +
> +	return ioasid;
> +}
> +
> +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> +{
> +	struct intel_iommu *iommu = data;
> +
> +	if (!iommu)
> +		return;
> +	/*
> +	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
> +	 * We can only free the PASID when all the devices are unbound.
> +	 */
> +	if (ioasid_find(NULL, ioasid, NULL)) {
> +		pr_alert("Cannot free active IOASID %d\n", ioasid);
> +		return;
> +	}
> +	vcmd_free_pasid(iommu, ioasid);
> +}
> +
> +static void register_pasid_allocator(struct intel_iommu *iommu)
> +{
> +	if (!intel_iommu_sm) {

Use sm_supported(iommu) instead.

> +		pr_warn("VT-d scalable mode not enabled\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Register a custom PASID allocator if we are running in a guest,
> +	 * guest PASID must be obtained via virtual command interface.
> +	 * There can be multiple vIOMMUs in each guest but only one allocator
> +	 * is active. All vIOMMU allocators will eventually be calling the same
> +	 * host allocator.
> +	 */
> +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap)) {
> +		pr_info("Register custom PASID allocator\n");
> +		iommu->pasid_allocator.alloc = intel_ioasid_alloc;
> +		iommu->pasid_allocator.free = intel_ioasid_free;
> +		iommu->pasid_allocator.pdata = (void *)iommu;
> +		if (!ioasid_register_allocator(&iommu->pasid_allocator)) {
> +			pr_warn("Custom PASID allocator failed, scalable mode disabled\n");
> +			/*
> +			 * Disable scalable mode on this IOMMU if there
> +			 * is no custom allocator. Mixing SM capable vIOMMU
> +			 * and non-SM vIOMMU are not supported.
> +			 */
> +			intel_iommu_sm = 0;
> +		}
> +	}
> +}
> +#endif
> +
>   static int __init init_dmars(void)
>   {
>   	struct dmar_drhd_unit *drhd;
> @@ -3298,6 +3370,9 @@ static int __init init_dmars(void)
>   	 */
>   	for_each_active_iommu(iommu, drhd) {
>   		iommu_flush_write_buffer(iommu);
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +		register_pasid_allocator(iommu);
> +#endif
>   		iommu_set_root_entry(iommu);
>   		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
>   		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 1e11560b0e59..8c30b23bd838 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -19,6 +19,7 @@
>   #include <linux/iommu.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/dmar.h>
> +#include <linux/ioasid.h>
>   
>   #include <asm/cacheflush.h>
>   #include <asm/iommu.h>
> @@ -557,6 +558,7 @@ struct intel_iommu {
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   	struct page_req_dsc *prq;
>   	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> +	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
>   #endif
>   	struct q_inval  *qi;            /* Queued invalidation info */
>   	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
> 

Best regards,
baolu
