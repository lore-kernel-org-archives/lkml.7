Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9477C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5752073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfH2Kdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfH2KdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:33:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C221710F23EA;
        Thu, 29 Aug 2019 10:33:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B08696061E;
        Thu, 29 Aug 2019 10:33:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D5D7031F2B; Thu, 29 Aug 2019 12:33:04 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 18/18] drm/virtio: add fence sanity check
Date:   Thu, 29 Aug 2019 12:33:01 +0200
Message-Id: <20190829103301.3539-19-kraxel@redhat.com>
In-Reply-To: <20190829103301.3539-1-kraxel@redhat.com>
References: <20190829103301.3539-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 29 Aug 2019 10:33:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we don't leak half-initialized fences outside the driver.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_fence.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index a0514f5bd006..a4b9881ca1d3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -41,6 +41,10 @@ bool virtio_fence_signaled(struct dma_fence *f)
 {
 	struct virtio_gpu_fence *fence = to_virtio_fence(f);
 
+	if (WARN_ON_ONCE(fence->f.seqno == 0))
+		/* leaked fence outside driver before completing
+		 * initialization with virtio_gpu_fence_emit */
+		return false;
 	if (atomic64_read(&fence->drv->last_seq) >= fence->f.seqno)
 		return true;
 	return false;
-- 
2.18.1

