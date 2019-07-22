Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F718C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E735E2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfGVPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:40:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGVPkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:40:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7D003082E72;
        Mon, 22 Jul 2019 15:40:05 +0000 (UTC)
Received: from redhat.com (ovpn-124-54.rdu2.redhat.com [10.10.124.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA11F60BEC;
        Mon, 22 Jul 2019 15:39:58 +0000 (UTC)
Date:   Mon, 22 Jul 2019 11:39:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Message-ID: <20190722113403-mutt-send-email-mst@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
 <20190722145509.1284-3-eric.auger@redhat.com>
 <20190722152710.GB3780@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722152710.GB3780@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 22 Jul 2019 15:40:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:27:10PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 04:55:09PM +0200, Eric Auger wrote:
> > Do not call dma_max_mapping_size for devices that have no DMA
> > mask set, otherwise we can hit a NULL pointer dereference.
> > 
> > This occurs when a virtio-blk-pci device is protected with
> > a virtual IOMMU.
> > 
> > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good.  virtio maintainers, let me know if you want to queue
> it up or if I should pick the patch up through the dma-mapping tree.

Personally I dislike this API because I feel presence of dma mask does
not strictly have to reflect max size. And generally the requirement to
check presence of mask feels like an undocumented hack to me.  Even
reading code will not help you avoid the warning, everyone will get it
wrong and get the warning splat in their logs.  So I would prefer just
v1 of the patch that makes dma API do the right thing for us.

However, if that's not going to be the case, let's fix it up in virtio.
In any case, for both v1 and v2 of the patches, you can merge them
through your tree:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST
