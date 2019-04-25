Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160CBC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 02:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB14E20652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 02:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfDYCNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 22:13:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:14114 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbfDYCNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 22:13:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 19:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="340574172"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 Apr 2019 19:13:31 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
To:     Christoph Hellwig <hch@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-3-baolu.lu@linux.intel.com>
 <20190422164555.GA31181@lst.de>
 <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
 <20190423061232.GB12762@lst.de>
 <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
 <20190424144532.GA21480@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
Date:   Thu, 25 Apr 2019 10:07:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424144532.GA21480@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/24/19 10:45 PM, Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 03:32:16PM +0800, Lu Baolu wrote:
>> When we add the bounce buffer between IOVA and physical buffer, the
>> bounced buffer must starts from the same offset in a page, otherwise,
>> IOMMU can't work here.
> 
> Why?  Even with the odd hardware descriptors typical in Intel land that
> only allow offsets in the first page, not the following ones, having
> a zero offset where we previously had one should be fine.
> 

This is not VT-d specific. It's just how generic IOMMU works.

Normally, IOMMU works in paging mode. So if a driver issues DMA with
IOVA  0xAAAA0123, IOMMU can remap it with a physical address 0xBBBB0123.
But we should never expect IOMMU to remap 0xAAAA0123 with physical
address of 0xBBBB0000. That's the reason why I said that IOMMU will not
work there.

                                 swiotlb                  System
                 IOVA          bounce page                Memory
              .---------.      .---------.             .---------.
              |         |      |         |             |         |
              |         |      |         |             |         |
buffer_start .---------.      .---------.buffer_start .---------.
              |         |----->|         |             |         |
              |         |      |         |************>|         |
              |         |      |         |   swiotlb   |         |
  IOMMU Page  '---------'      '---------'   mapping   '---------'
   Boundary   |         |                              |         |
              |         |                              |         |
              |         |                              |         |
              |         |----------------------------->|         |
              |         |        IOMMU mapping         |         |
              |         |                              |         |
  IOMMU Page  .---------.                              .---------.
   Boundary   |         |                              |         |
              |         |                              |         |
              |         |----------------------------->|         |
              |         |         IOMMU mapping        |         |
              |         |                              |         |
              |         |                              |         |
  IOMMU Page  .---------.      .---------.             .---------.
   Boundary   |         |      |         |             |         |
              |         |      |         |************>|         |
              |         |----->|         |   swiotlb   |         |
   buffer_end '---------'      '---------'   mapping   '---------'
              |         |      |         |             |         |
              |         |      |         |             |         |
              '---------'      '---------'             '---------'


This is the whole view of iommu bounce page. I expect the buffer_start
returned by swiotlb_tbl_map_single() starts from the same page_offset as
the buffer_start in IOVA.

Best regards,
Lu Baolu
