Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009C0206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDZPmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:42:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfDZPmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:42:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DF1C3134338;
        Fri, 26 Apr 2019 15:42:12 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18C9F5C221;
        Fri, 26 Apr 2019 15:42:06 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 13/19] iommu/vt-d: Add nested translation support
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
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yi L <yi.l.liu@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-14-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <b567b35b-4547-89db-fd88-4cef526e2e72@redhat.com>
Date:   Fri, 26 Apr 2019 17:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-14-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 26 Apr 2019 15:42:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/24/19 1:31 AM, Jacob Pan wrote:
> Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
> With PASID granular translation type set to 0x11b, translation
> result from the first level(FL) also subject to a second level(SL)
> page table translation. This mode is used for SVA virtualization,
> where FL performs guest virtual to guest physical translation and
> SL performs guest physical to host physical translation.

The title of the patch sounds a bit misleading to me as this patch
"just" adds a helper to set the PASID table entry in nested mode. There
is no caller yet.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.h |  11 +++++
>  2 files changed, 112 insertions(+)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index d339e8f..04127cf 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -688,3 +688,104 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  
>  	return 0;
>  }
> +
> +/**
> + * intel_pasid_setup_nested() - Set up PASID entry for nested translation
> + * which is used for vSVA. The first level page tables are used for
> + * GVA-GPA translation in the guest, second level page tables are used
> + * for GPA to HPA translation.
> + *
> + * @iommu:      Iommu which the device belong to
> + * @dev:        Device to be set up for translation
> + * @pgd:        First level PGD, treated as GPA
nit: @gpgd

spec naming could be used as well: FLPTPTR: First Level Page
Translation Pointer
> + * @pasid:      PASID to be programmed in the device PASID table
> + * @flags:      Additional info such as supervisor PASID
> + * @domain:     Domain info for setting up second level page tables
> + * @addr_width: Address width of the first level (guest)
> + */
> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> +			struct device *dev, pgd_t *gpgd,
> +			int pasid, int flags,
> +			struct dmar_domain *domain,
> +			int addr_width)
> +{
> +	struct pasid_entry *pte;
> +	struct dma_pte *pgd;
> +	u64 pgd_val;
> +	int agaw;
> +	u16 did;
> +
> +	if (!ecap_nest(iommu->ecap)) {
> +		pr_err("No nested translation support on %s\n",
> +		       iommu->name);
IOMMU: %s: ;-)
> +		return -EINVAL;
> +	}
> +
> +	pte = intel_pasid_get_entry(dev, pasid);
> +	if (WARN_ON(!pte))
> +		return -EINVAL;
> +
> +	pasid_clear_entry(pte);
> +
> +	/* Sanity checking performed by caller to make sure address
> +	 * width matching in two dimensions:
> +	 * 1. CPU vs. IOMMU
> +	 * 2. Guest vs. Host.
> +	 */
> +	switch (addr_width) {
> +	case 57:
> +		pasid_set_flpm(pte, 1);
> +		break;
> +	case 48:
> +		pasid_set_flpm(pte, 0);
> +		break;
> +	default:
> +		dev_err(dev, "Invalid paging mode %d\n", addr_width);
> +		return -EINVAL;
> +	}
> +
> +	/* Setup the first level page table pointer in GPA */
> +	pasid_set_flptr(pte, (u64)gpgd);
> +	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
> +		if (!ecap_srs(iommu->ecap)) {
> +			pr_err("No supervisor request support on %s\n",
> +			       iommu->name);
> +			return -EINVAL;
> +		}
> +		pasid_set_sre(pte);
> +	}
> +
> +	/* Setup the second level based on the given domain */
> +	pgd = domain->pgd;
> +
> +	for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
> +		pgd = phys_to_virt(dma_pte_addr(pgd));
> +		if (!dma_pte_present(pgd)) {
> +			dev_err(dev, "Invalid domain page table\n");
> +			return -EINVAL;
> +		}
> +	}
> +	pgd_val = virt_to_phys(pgd);
> +	pasid_set_slptr(pte, pgd_val);
> +	pasid_set_fault_enable(pte);
> +
> +	did = domain->iommu_did[iommu->seq_id];
> +	pasid_set_domain_id(pte, did);
> +
> +	pasid_set_address_width(pte, agaw);
> +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> +
> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
> +	pasid_set_present(pte);
> +
> +	if (!ecap_coherent(iommu->ecap))
> +		clflush_cache_range(pte, sizeof(*pte));
> +
> +	if (cap_caching_mode(iommu->cap)) {
> +		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> +		iotlb_invalidation_with_pasid(iommu, did, pasid);
> +	} else
> +		iommu_flush_write_buffer(iommu);
a bunch of that code is duplicated from
intel_pasid_setup_second_level(). I wonder if you could devise a common
helper function?

Thanks

Eric
> +
> +	return 0;
> +}
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 0999dfe..c4fc1af 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -42,6 +42,7 @@
>   * to vmalloc or even module mappings.
>   */
>  #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
> +#define PASID_FLAG_NESTED		BIT(1)
>  
>  struct pasid_dir_entry {
>  	u64 val;
> @@ -51,6 +52,11 @@ struct pasid_entry {
>  	u64 val[8];
>  };
>  
> +#define PASID_ENTRY_PGTT_FL_ONLY	(1)
> +#define PASID_ENTRY_PGTT_SL_ONLY	(2)
> +#define PASID_ENTRY_PGTT_NESTED		(3)
> +#define PASID_ENTRY_PGTT_PT		(4)
> +
>  /* The representative of a PASID table */
>  struct pasid_table {
>  	void			*table;		/* pasid table pointer */
> @@ -77,6 +83,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
>  				   struct device *dev, int pasid);
> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> +			struct device *dev, pgd_t *pgd,
> +			int pasid, int flags,
> +			struct dmar_domain *domain,
> +			int addr_width);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  				 struct device *dev, int pasid);
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
> 
