Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D08C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8EB2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfD2FQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:16:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:29193 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfD2FQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:16:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 22:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="295363562"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2019 22:16:34 -0700
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
 <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
 <20190426150433.GA19930@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
Date:   Mon, 29 Apr 2019 13:10:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426150433.GA19930@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 4/26/19 11:04 PM, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019 at 10:07:19AM +0800, Lu Baolu wrote:
>> This is not VT-d specific. It's just how generic IOMMU works.
>>
>> Normally, IOMMU works in paging mode. So if a driver issues DMA with
>> IOVA  0xAAAA0123, IOMMU can remap it with a physical address 0xBBBB0123.
>> But we should never expect IOMMU to remap 0xAAAA0123 with physical
>> address of 0xBBBB0000. That's the reason why I said that IOMMU will not
>> work there.
> 
> Well, with the iommu it doesn't happen.  With swiotlb it obviosuly
> can happen, so drivers are fine with it.  Why would that suddenly
> become an issue when swiotlb is called from the iommu code?
> 

I would say IOMMU is DMA remapping, not DMA engine. :-)

Best regards,
Lu Baolu
