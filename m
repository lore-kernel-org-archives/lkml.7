Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA20EC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCED52190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfGVPqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:46:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbfGVPpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:45:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E684C034DF3;
        Mon, 22 Jul 2019 15:45:35 +0000 (UTC)
Received: from redhat.com (ovpn-124-54.rdu2.redhat.com [10.10.124.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id 954295B681;
        Mon, 22 Jul 2019 15:45:28 +0000 (UTC)
Date:   Mon, 22 Jul 2019 11:45:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        hch@lst.de, m.szyprowski@samsung.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Message-ID: <20190722114117-mutt-send-email-mst@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
 <20190722145509.1284-3-eric.auger@redhat.com>
 <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 22 Jul 2019 15:45:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:36:09PM +0100, Robin Murphy wrote:
> On 22/07/2019 15:55, Eric Auger wrote:
> > Do not call dma_max_mapping_size for devices that have no DMA
> > mask set, otherwise we can hit a NULL pointer dereference.
> > 
> > This occurs when a virtio-blk-pci device is protected with
> > a virtual IOMMU.
> > 
> > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   drivers/virtio/virtio_ring.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c8be1c4f5b55..37c143971211 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -262,7 +262,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
> >   {
> >   	size_t max_segment_size = SIZE_MAX;
> > -	if (vring_use_dma_api(vdev))
> > +	if (vring_use_dma_api(vdev) && vdev->dev.dma_mask)
> 
> Hmm, might it make sense to roll that check up into vring_use_dma_api()
> itself? After all, if the device has no mask then it's likely that other DMA
> API ops wouldn't really work as expected either.
> 
> Robin.

Nope, Eric pointed out it's just dma_addressing_limited that is broken.

Other APIs call dma_get_mask which handles the NULL mask case fine.


> >   		max_segment_size = dma_max_mapping_size(&vdev->dev);
> >   	return max_segment_size;
> > 
