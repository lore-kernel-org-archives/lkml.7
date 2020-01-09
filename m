Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4ABC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A201E2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgAISeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:34:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:50001 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgAISeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:34:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 10:34:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="223418188"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 09 Jan 2020 10:34:05 -0800
Date:   Thu, 9 Jan 2020 10:39:08 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi L <yi.l.liu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Add nested translation helper
 function
Message-ID: <20200109103908.4c306b06@jacob-builder>
In-Reply-To: <6192b57c-12ab-ec6c-ab95-d9b9bff3efad@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1576524252-79116-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <6192b57c-12ab-ec6c-ab95-d9b9bff3efad@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 10:41:53 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi again,
> 
> On 12/17/19 3:24 AM, Jacob Pan wrote:
> > +/**
> > + * intel_pasid_setup_nested() - Set up PASID entry for nested
> > translation
> > + * which is used for vSVA. The first level page tables are used for
> > + * GVA-GPA or GIOVA-GPA translation in the guest, second level
> > page tables
> > + *  are used for GPA-HPA translation.
> > + *
> > + * @iommu:      Iommu which the device belong to
> > + * @dev:        Device to be set up for translation
> > + * @gpgd:       FLPTPTR: First Level Page translation pointer in
> > GPA
> > + * @pasid:      PASID to be programmed in the device PASID table
> > + * @pasid_data: Additional PASID info from the guest bind request
> > + * @domain:     Domain info for setting up second level page tables
> > + * @addr_width: Address width of the first level (guest)
> > + */
> > +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> > +			struct device *dev, pgd_t *gpgd,
> > +			int pasid, struct
> > iommu_gpasid_bind_data_vtd *pasid_data,
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
> > +		pr_err("IOMMU: %s: No nested translation
> > support\n",
> > +		       iommu->name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	pte = intel_pasid_get_entry(dev, pasid);
> > +	if (WARN_ON(!pte))
> > +		return -EINVAL;
> > +
> > +	pasid_clear_entry(pte);  
> 
> In some cases, e.g. nested mode for GIOVA-HPA, the PASID entry might
> have already been setup for second level translation. (This could be
> checked with the Present bit.) Hence, it's safe to flush caches here.
> 
> Or, maybe intel_pasid_tear_down_entry() is more suitable?
> 
We don't allow binding the same device-PASID twice, so if the PASID
entry was used for GIOVA/RID2PASID, it should unbind first, and
teardown flush included, right?

> Best regards,
> baolu

[Jacob Pan]
