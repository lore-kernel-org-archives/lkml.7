Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC97BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A0F20725
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKOBAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:00:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:64110 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfKOBAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 17:00:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,306,1569308400"; 
   d="scan'208";a="230294252"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2019 17:00:30 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 02/10] iommu/vt-d: Use per-device dma_ops
To:     Christoph Hellwig <hch@lst.de>
References: <20190725031717.32317-3-baolu.lu@linux.intel.com>
 <20190725054413.GC24527@lst.de>
 <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
 <20190725114348.GA30957@lst.de>
 <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com>
 <20191112071640.GA3343@lst.de>
 <0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com>
 <20191113070312.GA2735@lst.de> <20191113095353.GA5937@lst.de>
 <0ddc8aff-783a-97b9-f5cc-9e27990de278@linux.intel.com>
 <20191114081423.GA27407@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6069128f-354c-e708-fa1d-d866dc186d57@linux.intel.com>
Date:   Fri, 15 Nov 2019 08:57:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114081423.GA27407@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/14/19 4:14 PM, Christoph Hellwig wrote:
> On Thu, Nov 14, 2019 at 01:14:11PM +0800, Lu Baolu wrote:
>> Could you please educate me what dma_supported() is exactly for? Will
>> it always get called during boot? When will it be called?
> 
> ->dma_supported is set when setting either the dma_mask or
> dma_coherent_mask. These days it serves too primary purposes: reject
> too small masks that can't be addressed, and provide any hooks needed
> in the driver based on the mask.

Thanks! So ->dma_supported might not be called before driver maps buffer
and start DMA. Right?

> 
>> In above implementation, why do we need to check dma_direct_supported()
>> at the beginning? And why
> 
> Because the existing driver called dma_direct_supported, which I added
> based on x86 arch overrides doings the same a while ago.  I suspect
> it is related to addressing for tiny dma masks, but I'm not entirely
> sure.  The longer term intel-iommu maintainers or x86 maintainers might
> be able to shed more light how this was supposed to work and/or how
> systems with the Intel IOMMU deal with e.g. ISA devices with 24-bit
> addressing.

Yes. Make sense.

> 
>>
>> 	if (!info || info == DUMMY_DEVICE_DOMAIN_INFO ||
>> 			info == DEFER_DEVICE_DOMAIN_INFO) {
>> 		dev->dma_ops_bypass = true;
> 
> This was supposed to transform the checks from iommu_dummy and
> identity_mapping.  But I think it actually isn't entirely correct and
> already went bad in the patch to remove identity_mapping.  Pleae check
> the branch I just re-pushed, which should be correct now.
> 

Okay. Thanks!

Best regard,
baolu
