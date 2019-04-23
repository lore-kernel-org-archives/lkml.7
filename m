Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B559C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDB620652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfDWHia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:38:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:50028 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfDWHi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:38:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 00:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,385,1549958400"; 
   d="scan'208";a="339938795"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2019 00:38:25 -0700
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
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
Date:   Tue, 23 Apr 2019 15:32:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423061232.GB12762@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 4/23/19 2:12 PM, Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 09:58:19AM +0800, Lu Baolu wrote:
>> 554         for (i = 0; i < nslots; i++)
>> 555                 io_tlb_orig_addr[index+i] = orig_addr + (i <<
>> IO_TLB_SHIFT);
>>
>> Could the tlb orig address set to PAGE_ALIGN_DOWN(orig_addr)? We
>> couldn't assume the bounce buffer just starts from the beginning of the
>> slot. Or anything I missed?
> 
> I don't see why we need to align the orig_addr.  We only use
> io_tlb_orig_addr to find the address(es) for the swiotlb_bounce calls,
> and I don't see a good reason why we'd need to align those.
> 

Let me show you an example. Normally, if IOMMU is on, the device DMAs
with an iova. IOMMU takes the responsibility to translate the iova to
the physical address in paging mode.

                        Physical
    IOVA                 Buffer
.---------.          .---------.
| IOMMU   |          | IOMMU   |
| PAGE    |          | PAGE    |
.---------. -------> .---------.
| Buffer  |          | Buffer  |
'---------'          '---------'
|         |          |         |
|         |          |         |
'---------'          '---------'
             .-------.
             | IOMMU |
             '-------'

When we add the bounce buffer between IOVA and physical buffer, the
bounced buffer must starts from the same offset in a page, otherwise,
IOMMU can't work here.


                       Bouce             Physical
    IOVA               Buffer             Buffer
.---------.         .---------.       .---------.
|         | .-----> | Buffer  | <---. |         |
|         | |       '---------'     | |         |
.---------. |       |         |     | .---------.
| Buffer  |    NO   |         |  YES  | Buffer  |
'---------'         |         |       '---------'
|         |         |         |       |         |
|         |         |         |       |         |
'---------'         '---------'       '---------'
            .-------.         .---------.
            | IOMMU |         | swiotlb |
            '-------'         '---------'

A workable buffer location looks like below.


                       Bouce             Physical
    IOVA               Buffer             Buffer
.---------.         .---------.       .---------.
|         |         |         |       |         |
|         |         |         |       |         |
.---------. ------->.---------.<----- .---------.
| Buffer  |    YES  | Buffer  |  YES  | Buffer  |
'---------'         '---------'       '---------'
|         |         |         |       |         |
|         |         |         |       |         |
'---------'         '---------'       '---------'
            .-------.         .---------.
            | IOMMU |         | swiotlb |
            '-------'         '---------'

Best regards,
Lu Baolu
