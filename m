Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0ABC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 04:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C623206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 04:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfHPEqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 00:46:18 -0400
Received: from verein.lst.de ([213.95.11.211]:52019 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPEqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 00:46:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F247F68AFE; Fri, 16 Aug 2019 06:46:13 +0200 (CEST)
Date:   Fri, 16 Aug 2019 06:46:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
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
Message-ID: <20190816044613.GC4093@lst.de>
References: <20190730045229.3826-1-baolu.lu@linux.intel.com> <20190730045229.3826-6-baolu.lu@linux.intel.com> <20190814083842.GB22669@8bytes.org> <445624e7-eb57-8089-8eb3-8687a65b1258@linux.intel.com> <20190815154845.GA18327@8bytes.org> <ec1dc4e2-626c-9c12-f17c-b51420fc2e81@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec1dc4e2-626c-9c12-f17c-b51420fc2e81@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:45:13AM +0800, Lu Baolu wrote:
> Okay. I understand that adding these APIs in iommu.c is not a good idea.
> And, I also don't think merging the bounce buffer implementation into
> iommu_map() is feasible since iommu_map() is not DMA API centric.
>
> The bounce buffer implementation will eventually be part of DMA APIs
> defined in dma-iommu.c, but currently those APIs are not ready for x86
> use yet. So I will put them in iommu/vt-d driver for this time being and
> will move them to dma-iommu.c later.

I think they are more or less ready actually, we just need more people
reviewing the conversions.  Tom just reposted the AMD one which will need
a few more reviews, and he has an older patchset for intel-iommu as well
that could use a some more eyes.
