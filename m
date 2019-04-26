Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE97C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33007206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfDZVyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:54:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:18333 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfDZVyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:54:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 14:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,399,1549958400"; 
   d="scan'208";a="154101973"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2019 14:54:23 -0700
Date:   Fri, 26 Apr 2019 14:57:07 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yi L <yi.l.liu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 13/19] iommu/vt-d: Add nested translation support
Message-ID: <20190426145707.50ddb8f5@jacob-builder>
In-Reply-To: <b567b35b-4547-89db-fd88-4cef526e2e72@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-14-git-send-email-jacob.jun.pan@linux.intel.com>
        <b567b35b-4547-89db-fd88-4cef526e2e72@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 17:42:05 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 4/24/19 1:31 AM, Jacob Pan wrote:
> > Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
> > With PASID granular translation type set to 0x11b, translation
> > result from the first level(FL) also subject to a second level(SL)
> > page table translation. This mode is used for SVA virtualization,
> > where FL performs guest virtual to guest physical translation and
> > SL performs guest physical to host physical translation.  
> 
> The title of the patch sounds a bit misleading to me as this patch
> "just" adds a helper to set the PASID table entry in nested mode.
> There is no caller yet.
right, will rename to "Add nested translation helper function"
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  drivers/iommu/intel-pasid.c | 101
> > ++++++++++++++++++++++++++++++++++++++++++++
> > drivers/iommu/intel-pasid.h |  11 +++++ 2 files changed, 112
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index d339e8f..04127cf 100644
> > --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -688,3 +688,104 @@ int intel_pasid_setup_pass_through(struct
> > intel_iommu *iommu, 
> >  	return 0;
> >  }
> > +
> > +/**
> > + * intel_pasid_setup_nested() - Set up PASID entry for nested
> > translation
> > + * which is used for vSVA. The first level page tables are used for
> > + * GVA-GPA translation in the guest, second level page tables are
> > used
> > + * for GPA to HPA translation.
> > + *
> > + * @iommu:      Iommu which the device belong to
> > + * @dev:        Device to be set up for translation
> > + * @pgd:        First level PGD, treated as GPA  
> nit: @gpgd
> 
> spec naming could be used as well: FLPTPTR: First Level Page
> Translation Pointer
more precise. sounds good

> > + * @pasid:      PASID to be programmed in the device PASID table
> > + * @flags:      Additional info such as supervisor PASID
> > + * @domain:     Domain info for setting up second level page tables
> > + * @addr_width: Address width of the first level (guest)
> > + */
> > +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> > +			struct device *dev, pgd_t *gpgd,
> > +			int pasid, int flags,
> > +			struct dmar_domain *domain,
> > +			int addr_width)
> > +{
> > +	struct pasid_entry *pte;
> > +	struct dma_pte *pgd;
> > +	u64 pgd_val;
> > +	int agaw;
> > +	u16 did;
> > +
> > +	if (!ecap_nest(iommu->ecap)) {
> > +		pr_err("No nested translation support on %s\n",
> > +		       iommu->name);  
> IOMMU: %s: ;-)
will do

> > +		return -EINVAL;
> > +	}
> > +
> > +	pte = intel_pasid_get_entry(dev, pasid);
> > +	if (WARN_ON(!pte))
> > +		return -EINVAL;
> > +
> > +	pasid_clear_entry(pte);
> > +
> > +	/* Sanity checking performed by caller to make sure address
> > +	 * width matching in two dimensions:
> > +	 * 1. CPU vs. IOMMU
> > +	 * 2. Guest vs. Host.
> > +	 */
> > +	switch (addr_width) {
> > +	case 57:
> > +		pasid_set_flpm(pte, 1);
> > +		break;
> > +	case 48:
> > +		pasid_set_flpm(pte, 0);
> > +		break;
> > +	default:
> > +		dev_err(dev, "Invalid paging mode %d\n",
> > addr_width);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Setup the first level page table pointer in GPA */
> > +	pasid_set_flptr(pte, (u64)gpgd);
> > +	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
> > +		if (!ecap_srs(iommu->ecap)) {
> > +			pr_err("No supervisor request support on
> > %s\n",
> > +			       iommu->name);
> > +			return -EINVAL;
> > +		}
> > +		pasid_set_sre(pte);
> > +	}
> > +
> > +	/* Setup the second level based on the given domain */
> > +	pgd = domain->pgd;
> > +
> > +	for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
> > +		pgd = phys_to_virt(dma_pte_addr(pgd));
> > +		if (!dma_pte_present(pgd)) {
> > +			dev_err(dev, "Invalid domain page
> > table\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +	pgd_val = virt_to_phys(pgd);
> > +	pasid_set_slptr(pte, pgd_val);
> > +	pasid_set_fault_enable(pte);
> > +
> > +	did = domain->iommu_did[iommu->seq_id];
> > +	pasid_set_domain_id(pte, did);
> > +
> > +	pasid_set_address_width(pte, agaw);
> > +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> > +
> > +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
> > +	pasid_set_present(pte);
> > +
> > +	if (!ecap_coherent(iommu->ecap))
> > +		clflush_cache_range(pte, sizeof(*pte));
> > +
> > +	if (cap_caching_mode(iommu->cap)) {
> > +		pasid_cache_invalidation_with_pasid(iommu, did,
> > pasid);
> > +		iotlb_invalidation_with_pasid(iommu, did, pasid);
> > +	} else
> > +		iommu_flush_write_buffer(iommu);  
> a bunch of that code is duplicated from
> intel_pasid_setup_second_level(). I wonder if you could devise a
> common helper function?
> 
indeed, duplicated code. will do.
> Thanks
> 
> Eric
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/iommu/intel-pasid.h
> > b/drivers/iommu/intel-pasid.h index 0999dfe..c4fc1af 100644
> > --- a/drivers/iommu/intel-pasid.h
> > +++ b/drivers/iommu/intel-pasid.h
> > @@ -42,6 +42,7 @@
> >   * to vmalloc or even module mappings.
> >   */
> >  #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
> > +#define PASID_FLAG_NESTED		BIT(1)
> >  
> >  struct pasid_dir_entry {
> >  	u64 val;
> > @@ -51,6 +52,11 @@ struct pasid_entry {
> >  	u64 val[8];
> >  };
> >  
> > +#define PASID_ENTRY_PGTT_FL_ONLY	(1)
> > +#define PASID_ENTRY_PGTT_SL_ONLY	(2)
> > +#define PASID_ENTRY_PGTT_NESTED		(3)
> > +#define PASID_ENTRY_PGTT_PT		(4)
> > +
> >  /* The representative of a PASID table */
> >  struct pasid_table {
> >  	void			*table;		/*
> > pasid table pointer */ @@ -77,6 +83,11 @@ int
> > intel_pasid_setup_second_level(struct intel_iommu *iommu, int
> > intel_pasid_setup_pass_through(struct intel_iommu *iommu, struct
> > dmar_domain *domain, struct device *dev, int pasid);
> > +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> > +			struct device *dev, pgd_t *pgd,
> > +			int pasid, int flags,
> > +			struct dmar_domain *domain,
> > +			int addr_width);
> >  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> >  				 struct device *dev, int pasid);
> >  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> > *pasid); 

[Jacob Pan]
