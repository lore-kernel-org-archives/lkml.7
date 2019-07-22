Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6564C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FA42190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfGVOz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:55:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfGVOzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:55:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64F94308A968;
        Mon, 22 Jul 2019 14:55:24 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1002A60A9F;
        Mon, 22 Jul 2019 14:55:21 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Date:   Mon, 22 Jul 2019 16:55:09 +0200
Message-Id: <20190722145509.1284-3-eric.auger@redhat.com>
In-Reply-To: <20190722145509.1284-1-eric.auger@redhat.com>
References: <20190722145509.1284-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 22 Jul 2019 14:55:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not call dma_max_mapping_size for devices that have no DMA
mask set, otherwise we can hit a NULL pointer dereference.

This occurs when a virtio-blk-pci device is protected with
a virtual IOMMU.

Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c8be1c4f5b55..37c143971211 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -262,7 +262,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
 {
 	size_t max_segment_size = SIZE_MAX;
 
-	if (vring_use_dma_api(vdev))
+	if (vring_use_dma_api(vdev) && vdev->dev.dma_mask)
 		max_segment_size = dma_max_mapping_size(&vdev->dev);
 
 	return max_segment_size;
-- 
2.20.1

