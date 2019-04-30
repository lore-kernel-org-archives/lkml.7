Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B157FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D3521655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfD3Aql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:46:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:44888 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfD3Aqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:46:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 17:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; 
   d="scan'208";a="295632067"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2019 17:46:37 -0700
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] iommu: Add helper to get minimal page size of
 domain
To:     Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-2-baolu.lu@linux.intel.com>
 <05eca601-0264-8141-ceeb-7ef7ad5d5650@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <48ac694e-4551-40e2-f914-6942da810489@linux.intel.com>
Date:   Tue, 30 Apr 2019 08:40:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <05eca601-0264-8141-ceeb-7ef7ad5d5650@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 4/29/19 6:55 PM, Robin Murphy wrote:
> On 21/04/2019 02:17, Lu Baolu wrote:
>> This makes it possible for other modules to know the minimal
>> page size supported by a domain without the knowledge of the
>> structure details.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index a5007d035218..46679ef19b7e 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -377,6 +377,14 @@ static inline void iommu_tlb_sync(struct 
>> iommu_domain *domain)
>>           domain->ops->iotlb_sync(domain);
>>   }
>> +static inline unsigned long domain_minimal_pgsize(struct iommu_domain 
>> *domain)
>> +{
>> +    if (domain && domain->pgsize_bitmap)
>> +        return 1 << __ffs(domain->pgsize_bitmap);
> 
> Nit: this would probably be more efficient on most architectures as:
> 
>      if (domain)
>          return domain->pgsize_bitmap & -domain->pgsize_bitmap;
> 

It looks reasonable to me.

> 
> I'd also suggest s/minimal/min/ in the name, just to stop it getting too 
> long. Otherwise, though, I like the idea, and there's at least one other 
> place (in iommu-dma) that can make use of it straight away.

Okay, I will change the name to domain_min_pgsize().

> 
> Robin.
> 

Best regards,
Lu Baolu

>> +
>> +    return 0;
>> +}
>> +
>>   /* PCI device grouping function */
>>   extern struct iommu_group *pci_device_group(struct device *dev);
>>   /* Generic device grouping function */
>> @@ -704,6 +712,11 @@ const struct iommu_ops 
>> *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>>       return NULL;
>>   }
>> +static inline unsigned long domain_minimal_pgsize(struct iommu_domain 
>> *domain)
>> +{
>> +    return 0;
>> +}
>> +
>>   #endif /* CONFIG_IOMMU_API */
>>   #ifdef CONFIG_IOMMU_DEBUGFS
>>
> 
