Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868CCC004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 02:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A77205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 02:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEFCA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 22:00:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:54632 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfEFCA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 22:00:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 May 2019 19:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,435,1549958400"; 
   d="scan'208";a="146642395"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2019 19:00:55 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
References: <20190421011719.14909-3-baolu.lu@linux.intel.com>
 <20190422164555.GA31181@lst.de>
 <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
 <20190423061232.GB12762@lst.de>
 <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
 <20190424144532.GA21480@lst.de>
 <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
 <20190426150433.GA19930@lst.de>
 <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
 <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
 <20190429114401.GA30333@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7033f384-7823-42ec-6bda-ae74ef689f4f@linux.intel.com>
Date:   Mon, 6 May 2019 09:54:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429114401.GA30333@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 4/29/19 7:44 PM, Christoph Hellwig wrote:
> On Mon, Apr 29, 2019 at 12:06:52PM +0100, Robin Murphy wrote:
>>
>>  From the reply up-thread I guess you're trying to include an optimisation
>> to only copy the head and tail of the buffer if it spans multiple pages,
>> and directly map the ones in the middle, but AFAICS that's going to tie you
>> to also using strict mode for TLB maintenance, which may not be a win
>> overall depending on the balance between invalidation bandwidth vs. memcpy
>> bandwidth. At least if we use standard SWIOTLB logic to always copy the
>> whole thing, we should be able to release the bounce pages via the flush
>> queue to allow 'safe' lazy unmaps.
> 
> Oh.  The head and tail optimization is what I missed.  Yes, for that
> we'd need the offset.

Yes.

> 
>> Either way I think it would be worth just implementing the straightforward
>> version first, then coming back to consider optimisations later.
> 
> Agreed, let's start simple.  Especially as large DMA mappings or
> allocations should usually be properly aligned anyway, and if not we
> should fix that for multiple reasons.
> 

Agreed. I will prepare the next version simply without the optimization, 
so the offset is not required.

For your changes in swiotlb, will you formalize them in patches or want
me to do this?

Best regards,
Lu Baolu
