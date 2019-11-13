Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9933CC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C03A222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfKMHDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:03:20 -0500
Received: from verein.lst.de ([213.95.11.211]:60684 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfKMHDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:03:19 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3AA5868C4E; Wed, 13 Nov 2019 08:03:13 +0100 (CET)
Date:   Wed, 13 Nov 2019 08:03:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
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
Message-ID: <20191113070312.GA2735@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com> <20190725031717.32317-3-baolu.lu@linux.intel.com> <20190725054413.GC24527@lst.de> <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com> <20190725114348.GA30957@lst.de> <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com> <20191112071640.GA3343@lst.de> <0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:50:27AM +0800, Lu Baolu wrote:
> Currently, this is a block issue for using per-device dma ops in Intel
> IOMMU driver. Hence block this driver from using the generic iommu dma
> ops.

That is in fact the reason why I bring it up :)

> I'd like to align Intel IOMMU driver with other vendors. Use iommu dma
> ops for devices which have been selected to go through iommu. And use
> direct dma ops if selected to by pass.
>
> One concern of this propose is that for devices with limited address
> capability, shall we force it to use iommu or alternatively use swiotlb
> if user decides to let it by pass iommu.
>
> I understand that using swiotlb will cause some overhead due to the
> bounced buffer, but Intel IOMMU is default on hence any users who use a
> default kernel won't suffer this. We only need to document this so that
> users understand this overhead when they decide to let such devices by
> pass iommu. This is common to all vendor iommu drivers as far as I can
> see.

Indeed.  And one idea would be to lift the code in the powerpc
dma_iommu_ops that check a flag and use the direct ops to the generic
dma code and a flag in struct device.  We can then switch the intel
iommu ops (and AMD Gart) over to it.
