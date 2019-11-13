Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEEDC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843A7204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKMCx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:53:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:13897 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfKMCx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:53:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 18:53:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,298,1569308400"; 
   d="scan'208";a="229611856"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2019 18:53:23 -0800
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
References: <20190725031717.32317-1-baolu.lu@linux.intel.com>
 <20190725031717.32317-3-baolu.lu@linux.intel.com>
 <20190725054413.GC24527@lst.de>
 <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
 <20190725114348.GA30957@lst.de>
 <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com>
 <20191112071640.GA3343@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com>
Date:   Wed, 13 Nov 2019 10:50:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112071640.GA3343@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 11/12/19 3:16 PM, Christoph Hellwig wrote:
> On Fri, Jul 26, 2019 at 09:56:51AM +0800, Lu Baolu wrote:
>> I think current code doesn't do the right thing. The user asks the iommu
>> driver to use identity domain for a device, but the driver force it back
>> to DMA domain because of the device address capability.
>>
>>> expensive.  I don't think that this change is a good idea, and even if
>>> we decide that this is a good idea after all that should be done in a
>>> separate prep patch that explains the rationale.
>>
>> Yes. Make sense.
> 
> Now that the bounce code has landed it might be good time to revisit
> this patch in isolation and with a better explanation.
> 

Yes. Thanks for bringing this up.

Currently, this is a block issue for using per-device dma ops in Intel
IOMMU driver. Hence block this driver from using the generic iommu dma
ops.

I'd like to align Intel IOMMU driver with other vendors. Use iommu dma
ops for devices which have been selected to go through iommu. And use
direct dma ops if selected to by pass.

One concern of this propose is that for devices with limited address
capability, shall we force it to use iommu or alternatively use swiotlb
if user decides to let it by pass iommu.

I understand that using swiotlb will cause some overhead due to the
bounced buffer, but Intel IOMMU is default on hence any users who use a
default kernel won't suffer this. We only need to document this so that
users understand this overhead when they decide to let such devices by
pass iommu. This is common to all vendor iommu drivers as far as I can
see.

Best regards,
baolu
