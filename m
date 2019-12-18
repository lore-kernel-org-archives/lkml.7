Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD6B2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfLRCCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:02:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:39100 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfLRCCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:02:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 18:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="227704686"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2019 18:02:09 -0800
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Add nested translation helper
 function
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1576524252-79116-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <eeb67c06-a66c-fbbc-e273-09c4ab1f62b1@linux.intel.com>
Date:   Wed, 18 Dec 2019 10:01:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576524252-79116-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 12/17/19 3:24 AM, Jacob Pan wrote:
> Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
> With PASID granular translation type set to 0x11b, translation
> result from the first level(FL) also subject to a second level(SL)
> page table translation. This mode is used for SVA virtualization,
> where FL performs guest virtual to guest physical translation and
> SL performs guest physical to host physical translation.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>   drivers/iommu/intel-pasid.c | 213 ++++++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel-pasid.h |  12 +++
>   include/linux/intel-iommu.h |   3 +
>   include/uapi/linux/iommu.h  |   5 +-
>   4 files changed, 232 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 3cb569e76642..b178ad9e47ae 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -359,6 +359,76 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
>   	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
>   }
>   
> +/*
> + * Setup the Extended Memory Type(EMT) field (Bits 91-93)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_emt(struct pasid_entry *pe, u64 value)
> +{
> +	pasid_set_bits(&pe->val[1], GENMASK_ULL(29, 27), value << 27);
> +}
> +
> +/*
> + * Setup the Page Attribute Table (PAT) field (Bits 96-127)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pat(struct pasid_entry *pe, u64 value)
> +{
> +	pasid_set_bits(&pe->val[1], GENMASK_ULL(63, 32), value << 27);

The last input should be "value << 32".

> +}
> +
> +/*
> + * Setup the Cache Disable (CD) field (Bit 89)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_cd(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[1], 1 << 25, 1);

The last input should be "1 << 25".

> +}
> +
> +/*
> + * Setup the Extended Memory Type Enable (EMTE) field (Bit 90)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_emte(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[1], 1 << 26, 1);

The last input should be "1 << 26".

> +}
> +
> +/*
> + * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_eafe(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[2], 1 << 7, 1);

The last input should be "1 << 7".

> +}
> +
> +/*
> + * Setup the Page-level Cache Disable (PCD) field (Bit 95)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pcd(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[1], 1 << 31, 1);

The last input should be "1 << 31".

> +}
> +
> +/*
> + * Setup the Page-level Write-Through (PWT)) field (Bit 94)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pwt(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[1], 1 << 30, 1);

The last input should be "1 << 30".

> +}
> +
>   static void
>   pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>   				    u16 did, int pasid)
> @@ -599,3 +669,146 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>   
>   	return 0;
>   }
> +
> +static int intel_pasid_setup_bind_data(struct intel_iommu *iommu,
> +				struct pasid_entry *pte,
> +				struct iommu_gpasid_bind_data_vtd *pasid_data)
> +{
> +	/*
> +	 * Not all guest PASID table entry fields are passed down during bind,
> +	 * here we only set up the ones that are dependent on guest settings.
> +	 * Execution related bits such as NXE, SMEP are not meaningful to IOMMU,
> +	 * therefore not set. Other fields, such as snoop related, are set based
> +	 * on host needs regardless of  guest settings.
> +	 */
> +	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_SRE) {
> +		if (!ecap_srs(iommu->ecap)) {
> +			pr_err("No supervisor request support on %s\n",
> +			       iommu->name);
> +			return -EINVAL;
> +		}
> +		pasid_set_sre(pte);
> +	}
> +
> +	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> +		if (!ecap_eafs(iommu->ecap)) {
> +			pr_err("No extended access flag support on %s\n",
> +				iommu->name);
> +			return -EINVAL;
> +		}
> +		pasid_set_eafe(pte);
> +	}
> +
> +	/*
> +	 * Memory type is only applicable to devices inside processor coherent
> +	 * domain. PCIe devices are not included. We can skip the rest of the
> +	 * flags if IOMMU does not support MTS.
> +	 */
> +	if (ecap_mts(iommu->ecap)) {
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EMTE) {
> +			pasid_set_emte(pte);
> +			pasid_set_emt(pte, pasid_data->emt);
> +		}
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PCD)
> +			pasid_set_pcd(pte);
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PWT)
> +			pasid_set_pwt(pte);
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_CD)
> +			pasid_set_cd(pte);
> +		pasid_set_pat(pte, pasid_data->pat);
> +	} else if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EMT_MASK) {
> +		pr_warn("No memory type support for bind guest PASID on %s\n",
> +			iommu->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +/**
> + * intel_pasid_setup_nested() - Set up PASID entry for nested translation
> + * which is used for vSVA. The first level page tables are used for

Please remove "which is used for vSVA". It should be a generic interface
for setting up nested translation mode?

> + * GVA-GPA or GIOVA-GPA translation in the guest, second level page tables
> + *  are used for GPA-HPA translation.

Nit: align with the last line.

> + *
> + * @iommu:      Iommu which the device belong to
> + * @dev:        Device to be set up for translation
> + * @gpgd:       FLPTPTR: First Level Page translation pointer in GPA
> + * @pasid:      PASID to be programmed in the device PASID table
> + * @pasid_data: Additional PASID info from the guest bind request
> + * @domain:     Domain info for setting up second level page tables
> + * @addr_width: Address width of the first level (guest)
> + */
> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> +			struct device *dev, pgd_t *gpgd,
> +			int pasid, struct iommu_gpasid_bind_data_vtd *pasid_data,
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
> +		pr_err("IOMMU: %s: No nested translation support\n",
> +		       iommu->name);
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
> +	case ADDR_WIDTH_5LEVEL:
> +		pasid_set_flpm(pte, 1);
> +		break;
> +	case ADDR_WIDTH_4LEVEL:
> +		pasid_set_flpm(pte, 0);
> +		break;
> +	default:
> +		dev_err(dev, "Invalid paging mode %d\n", addr_width);

Invalid guest address width?

> +		return -EINVAL;
> +	}
> +
> +	pasid_set_flptr(pte, (u64)gpgd);
> +
> +	intel_pasid_setup_bind_data(iommu, pte, pasid_data);

Do you want to check and handle the errors returned from this function?

> +
> +	/* Setup the second level based on the given domain */
> +	pgd = domain->pgd;
> +
> +	for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
> +		pgd = phys_to_virt(dma_pte_addr(pgd));
> +		if (!dma_pte_present(pgd)) {
> +			pasid_clear_entry(pte);
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
> +	pasid_flush_caches(iommu, pte, pasid, did);
> +
> +	return 0;
> +}
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index fc8cd8f17de1..95ed160b1947 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -36,6 +36,7 @@
>    * to vmalloc or even module mappings.
>    */
>   #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
> +#define PASID_FLAG_NESTED		BIT(1)
>   
>   struct pasid_dir_entry {
>   	u64 val;
> @@ -45,6 +46,11 @@ struct pasid_entry {
>   	u64 val[8];
>   };
>   
> +#define PASID_ENTRY_PGTT_FL_ONLY	(1)
> +#define PASID_ENTRY_PGTT_SL_ONLY	(2)
> +#define PASID_ENTRY_PGTT_NESTED		(3)
> +#define PASID_ENTRY_PGTT_PT		(4)
> +
>   /* The representative of a PASID table */
>   struct pasid_table {
>   	void			*table;		/* pasid table pointer */
> @@ -93,6 +99,12 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>   int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>   				   struct dmar_domain *domain,
>   				   struct device *dev, int pasid);
> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> +			struct device *dev, pgd_t *pgd,
> +			int pasid,
> +			struct iommu_gpasid_bind_data_vtd *pasid_data,
> +			struct dmar_domain *domain,
> +			int addr_width);
>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>   				 struct device *dev, int pasid);
>   
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 74b79e2e6a73..19bf9ff180ae 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -34,6 +34,9 @@
>   #define VTD_STRIDE_SHIFT        (9)
>   #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
>   
> +#define ADDR_WIDTH_5LEVEL	(57)
> +#define ADDR_WIDTH_4LEVEL	(48)
> +
>   #define DMA_PTE_READ (1)
>   #define DMA_PTE_WRITE (2)
>   #define DMA_PTE_LARGE_PAGE (1 << 7)
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 4ad3496e5c43..fcafb6401430 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
>   	__u32 pat;
>   	__u32 emt;
>   };
> -
> +#define IOMMU_SVA_VTD_GPASID_EMT_MASK	(IOMMU_SVA_VTD_GPASID_CD | \
> +					 IOMMU_SVA_VTD_GPASID_EMTE | \
> +					 IOMMU_SVA_VTD_GPASID_PCD |  \
> +					 IOMMU_SVA_VTD_GPASID_PWT)

Might need a seperated patch?

>   /**
>    * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
>    * @version:	Version of this data structure
> 

Best regards,
baolu
