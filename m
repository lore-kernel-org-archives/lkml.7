Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DBCC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFCB20673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfD2K4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:56:02 -0400
Received: from foss.arm.com ([217.140.101.70]:53370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbfD2K4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:56:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5756380D;
        Mon, 29 Apr 2019 03:56:01 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068C83F5AF;
        Mon, 29 Apr 2019 03:55:58 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] iommu: Add helper to get minimal page size of
 domain
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
        kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-2-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <05eca601-0264-8141-ceeb-7ef7ad5d5650@arm.com>
Date:   Mon, 29 Apr 2019 11:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190421011719.14909-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2019 02:17, Lu Baolu wrote:
> This makes it possible for other modules to know the minimal
> page size supported by a domain without the knowledge of the
> structure details.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a5007d035218..46679ef19b7e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -377,6 +377,14 @@ static inline void iommu_tlb_sync(struct iommu_domain *domain)
>   		domain->ops->iotlb_sync(domain);
>   }
>   
> +static inline unsigned long domain_minimal_pgsize(struct iommu_domain *domain)
> +{
> +	if (domain && domain->pgsize_bitmap)
> +		return 1 << __ffs(domain->pgsize_bitmap);

Nit: this would probably be more efficient on most architectures as:

	if (domain)
		return domain->pgsize_bitmap & -domain->pgsize_bitmap;


I'd also suggest s/minimal/min/ in the name, just to stop it getting too 
long. Otherwise, though, I like the idea, and there's at least one other 
place (in iommu-dma) that can make use of it straight away.

Robin.

> +
> +	return 0;
> +}
> +
>   /* PCI device grouping function */
>   extern struct iommu_group *pci_device_group(struct device *dev);
>   /* Generic device grouping function */
> @@ -704,6 +712,11 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>   	return NULL;
>   }
>   
> +static inline unsigned long domain_minimal_pgsize(struct iommu_domain *domain)
> +{
> +	return 0;
> +}
> +
>   #endif /* CONFIG_IOMMU_API */
>   
>   #ifdef CONFIG_IOMMU_DEBUGFS
> 
