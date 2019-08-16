Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A803CC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840BD206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfHPCqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:46:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:31494 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHPCqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:46:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 19:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="171292545"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 19:46:15 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v6 5/8] iommu: Add bounce page APIs
To:     Joerg Roedel <joro@8bytes.org>
References: <20190730045229.3826-1-baolu.lu@linux.intel.com>
 <20190730045229.3826-6-baolu.lu@linux.intel.com>
 <20190814083842.GB22669@8bytes.org>
 <445624e7-eb57-8089-8eb3-8687a65b1258@linux.intel.com>
 <20190815154845.GA18327@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ec1dc4e2-626c-9c12-f17c-b51420fc2e81@linux.intel.com>
Date:   Fri, 16 Aug 2019 10:45:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815154845.GA18327@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 8/15/19 11:48 PM, Joerg Roedel wrote:
> On Thu, Aug 15, 2019 at 02:15:32PM +0800, Lu Baolu wrote:
>> iommu_map/unmap() APIs haven't parameters for dma direction and
>> attributions. These parameters are elementary for DMA APIs. Say,
>> after map, if the dma direction is TO_DEVICE and a bounce buffer is
>> used, we must sync the data from the original dma buffer to the bounce
>> buffer; In the opposite direction, if dma is FROM_DEVICE, before unmap,
>> we need to sync the data from the bounce buffer onto the original
>> buffer.
> 
> The DMA direction from DMA-API maps to the protections in iommu_map():
> 
> 	DMA_FROM_DEVICE:	IOMMU_WRITE
> 	DMA_TO_DEVICE:		IOMMU_READ
> 	DMA_BIDIRECTIONAL	IOMMU_READ | IOMMU_WRITE
> 
> And for the sync DMA-API also has separate functions for either
> direction. So I don't see why these extra functions are needed in the
> IOMMU-API.
>

Okay. I understand that adding these APIs in iommu.c is not a good idea.
And, I also don't think merging the bounce buffer implementation into
iommu_map() is feasible since iommu_map() is not DMA API centric.

The bounce buffer implementation will eventually be part of DMA APIs
defined in dma-iommu.c, but currently those APIs are not ready for x86
use yet. So I will put them in iommu/vt-d driver for this time being and
will move them to dma-iommu.c later.

Does this work for you?

Best regards,
Lu Baolu
