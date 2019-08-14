Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436F8C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8D72083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfHNIio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:38:44 -0400
Received: from 8bytes.org ([81.169.241.247]:49186 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfHNIio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:38:44 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 20E3C2E2; Wed, 14 Aug 2019 10:38:43 +0200 (CEST)
Date:   Wed, 14 Aug 2019 10:38:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
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
Message-ID: <20190814083842.GB22669@8bytes.org>
References: <20190730045229.3826-1-baolu.lu@linux.intel.com>
 <20190730045229.3826-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730045229.3826-6-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu Baolu,

On Tue, Jul 30, 2019 at 12:52:26PM +0800, Lu Baolu wrote:
> * iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
>   - Map a buffer start at DMA address @addr in bounce page
>     manner. For buffer parts that doesn't cross a whole
>     minimal IOMMU page, the bounce page policy is applied.
>     A bounce page mapped by swiotlb will be used as the DMA
>     target in the IOMMU page table. Otherwise, the physical
>     address @paddr is mapped instead.
> 
> * iommu_bounce_unmap(dev, addr, size, dir, attrs)
>   - Unmap the buffer mapped with iommu_bounce_map(). The bounce
>     page will be torn down after the bounced data get synced.
> 
> * iommu_bounce_sync(dev, addr, size, dir, target)
>   - Synce the bounced data in case the bounce mapped buffer is
>     reused.

I don't really get why this API extension is needed for your use-case.
Can't this just be done using iommu_map/unmap operations? Can you please
elaborate a bit why these functions are needed?


Regards,

	Joerg
