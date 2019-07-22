Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D0CC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2418E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfGVP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:27:12 -0400
Received: from verein.lst.de ([213.95.11.211]:33282 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfGVP1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:27:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D99068B20; Mon, 22 Jul 2019 17:27:10 +0200 (CEST)
Date:   Mon, 22 Jul 2019 17:27:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size
 call
Message-ID: <20190722152710.GB3780@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com> <20190722145509.1284-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722145509.1284-3-eric.auger@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:55:09PM +0200, Eric Auger wrote:
> Do not call dma_max_mapping_size for devices that have no DMA
> mask set, otherwise we can hit a NULL pointer dereference.
> 
> This occurs when a virtio-blk-pci device is protected with
> a virtual IOMMU.
> 
> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>

Looks good.  virtio maintainers, let me know if you want to queue
it up or if I should pick the patch up through the dma-mapping tree.
