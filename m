Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1F3C41514
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED555229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfGYNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:04:22 -0400
Received: from verein.lst.de ([213.95.11.211]:35198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfGYNEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:04:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 557F068B02; Thu, 25 Jul 2019 15:04:16 +0200 (CEST)
Date:   Thu, 25 Jul 2019 15:04:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
        m.szyprowski@samsung.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size
 call
Message-ID: <20190725130416.GA4992@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com> <20190722145509.1284-3-eric.auger@redhat.com> <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com> <20190723153851.GE720@lst.de> <fa0fbad5-9b44-d937-e0fd-65fb20c90666@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0fbad5-9b44-d937-e0fd-65fb20c90666@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 01:53:49PM +0200, Auger Eric wrote:
> I am confused: if vring_use_dma_api() returns false if the dma_mask is
> unset (ie. vring_use_dma_api() returns false), the virtio-blk-pci device
> will not be able to get translated addresses and won't work properly.
> 
> The patch above allows the dma api to be used and only influences the
> max_segment_size and it works properly.
> 
> So is it normal the dma_mask is unset in my case?

Its not normal.  I assume you use virtio-nmio?  Due to the mess with
the dma_mask being a pointer a lot of subsystems forgot to set a dma
mask up, and oddly enough seem to mostly get away with it.
