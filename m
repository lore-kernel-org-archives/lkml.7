Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D74C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F9F20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDIO5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:57:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:53573 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfDIO5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:57:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 07:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="132773295"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 09 Apr 2019 07:57:14 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDsBU-0004UC-VC; Tue, 09 Apr 2019 17:57:12 +0300
Date:   Tue, 9 Apr 2019 17:57:12 +0300
From:   Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
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
        Lu Baolu <baolu.lu@linux.intel.com>, Liu@smile.fi.intel.com,
        Yi L <yi.l.liu@linux.intel.com>
Subject: Re: [PATCH 18/18] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20190409145712.GR9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-19-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554767973-30125-19-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:59:33PM -0700, Jacob Pan wrote:
> When Shared Virtual Address (SVA) is enabled for a guest OS via
> vIOMMU, we need to provide invalidation support at IOMMU API and driver
> level. This patch adds Intel VT-d specific function to implement
> iommu passdown invalidate API for shared virtual address.
> 
> The use case is for supporting caching structure invalidation
> of assigned SVM capable devices. Emulated IOMMU exposes queue
> invalidation capability and passes down all descriptors from the guest
> to the physical IOMMU.
> 
> The assumption is that guest to host device ID mapping should be
> resolved prior to calling IOMMU driver. Based on the device handle,
> host IOMMU driver can replace certain fields before submit to the
> invalidation queue.

> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct iommu_cache_invalidate_info *inv_info)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +	int cache_type;
> +	u8 bus, devfn;
> +	u16 did, sid;
> +	int ret = 0;
> +	u64 granu;
> +	u64 size;
> +
> +	if (!inv_info || !dmar_domain ||
> +		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +		return -EINVAL;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +

> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;

How dev is used in above call? Can be dev NULL there optional and give non-NULL
iommu?

> +		switch (1 << cache_type) {

BIT() ?

> +		case IOMMU_CACHE_INV_TYPE_IOTLB:
> +			if (size && (inv_info->addr_info.addr & ((1 << (VTD_PAGE_SHIFT + size)) - 1))) {

BIT() ?

> +				pr_err("Address out of range, 0x%llx, size order %llu\n",
> +					inv_info->addr_info.addr, size);
> +				ret = -ERANGE;
> +				goto out_unlock;
> +			}
> +
> +			qi_flush_piotlb(iommu, did, mm_to_dma_pfn(inv_info->addr_info.addr),
> +					inv_info->addr_info.pasid,
> +					size, granu);
> +
> +			/*
> +			 * Always flush device IOTLB if ATS is enabled since guest
> +			 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
> +			 * down. REVISIT: cannot assume Linux guest
> +			 */
> +			if (info->ats_enabled) {
> +				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
> +						inv_info->addr_info.pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			}
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +			if (info->ats_enabled) {
> +				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
> +						inv_info->addr_info.pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			} else
> +				pr_warn("Passdown device IOTLB flush w/o ATS!\n");
> +
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_PASID:
> +			qi_flush_pasid_cache(iommu, did, granu, inv_info->pasid);
> +
> +			break;
> +		default:
> +			dev_err(dev, "Unsupported IOMMU invalidation type %d\n",
> +				cache_type);
> +			ret = -EINVAL;
> +		}

> +out_unlock:
> +	spin_unlock(&iommu->lock);
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


