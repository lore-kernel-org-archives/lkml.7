Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE83ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB38E21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfIKGRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:17:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:1731 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfIKGRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:17:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 23:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="209565502"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 10 Sep 2019 23:17:45 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/5] swiotlb: Split size parameter to map/unmap APIs
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
 <20190906061452.30791-2-baolu.lu@linux.intel.com>
 <20190910151544.GA7585@char.us.oracle.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0b939480-cb99-46fe-374e-a31441d21486@linux.intel.com>
Date:   Wed, 11 Sep 2019 14:16:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910151544.GA7585@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/10/19 11:15 PM, Konrad Rzeszutek Wilk wrote:
> On Fri, Sep 06, 2019 at 02:14:48PM +0800, Lu Baolu wrote:
>> This splits the size parameter to swiotlb_tbl_map_single() and
>> swiotlb_tbl_unmap_single() into an alloc_size and a mapping_size
>> parameter, where the latter one is rounded up to the iommu page
>> size.
> It does a bit more too. You have the WARN_ON. Can you make it be
> more  verbose (as in details of which device requested it) and also use printk_once or so please?

How about this change?

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 89066efa3840..22a7848caca3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -466,8 +466,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device 
*hwdev,
                 pr_warn_once("%s is active and system is using DMA 
bounce buffers\n",
                              sme_active() ? "SME" : "SEV");

-       if (WARN_ON(mapping_size > alloc_size))
+       if (mapping_size > alloc_size) {
+               dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, 
alloc: %zd bytes)",
+                             mapping_size, alloc_size);
                 return (phys_addr_t)DMA_MAPPING_ERROR;
+       }

         mask = dma_get_seg_boundary(hwdev);

@@ -584,9 +587,6 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, 
phys_addr_t tlb_addr,
         int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
         phys_addr_t orig_addr = io_tlb_orig_addr[index];

-       if (WARN_ON(mapping_size > alloc_size))
-               return;
-
         /*
          * First, sync the memory before unmapping the entry
          */

Best regards,
Baolu
