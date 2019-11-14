Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9526C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FB620718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfKNIO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:14:29 -0500
Received: from verein.lst.de ([213.95.11.211]:38174 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfKNIO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:14:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B6EC68BFE; Thu, 14 Nov 2019 09:14:23 +0100 (CET)
Date:   Thu, 14 Nov 2019 09:14:23 +0100
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
Message-ID: <20191114081423.GA27407@lst.de>
References: <20190725031717.32317-3-baolu.lu@linux.intel.com> <20190725054413.GC24527@lst.de> <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com> <20190725114348.GA30957@lst.de> <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com> <20191112071640.GA3343@lst.de> <0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com> <20191113070312.GA2735@lst.de> <20191113095353.GA5937@lst.de> <0ddc8aff-783a-97b9-f5cc-9e27990de278@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ddc8aff-783a-97b9-f5cc-9e27990de278@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 01:14:11PM +0800, Lu Baolu wrote:
> Could you please educate me what dma_supported() is exactly for? Will
> it always get called during boot? When will it be called?

->dma_supported is set when setting either the dma_mask or
dma_coherent_mask. These days it serves too primary purposes: reject
too small masks that can't be addressed, and provide any hooks needed
in the driver based on the mask.

> In above implementation, why do we need to check dma_direct_supported()
> at the beginning? And why

Because the existing driver called dma_direct_supported, which I added
based on x86 arch overrides doings the same a while ago.  I suspect
it is related to addressing for tiny dma masks, but I'm not entirely
sure.  The longer term intel-iommu maintainers or x86 maintainers might
be able to shed more light how this was supposed to work and/or how
systems with the Intel IOMMU deal with e.g. ISA devices with 24-bit
addressing.

>
> 	if (!info || info == DUMMY_DEVICE_DOMAIN_INFO ||
> 			info == DEFER_DEVICE_DOMAIN_INFO) {
> 		dev->dma_ops_bypass = true;

This was supposed to transform the checks from iommu_dummy and
identity_mapping.  But I think it actually isn't entirely correct and
already went bad in the patch to remove identity_mapping.  Pleae check 
the branch I just re-pushed, which should be correct now.
