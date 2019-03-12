Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB14B214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfCLHHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:07:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727377AbfCLHHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:07:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2551C80D1A2A6C29672;
        Tue, 12 Mar 2019 15:07:08 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 15:06:58 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] virtio_ring: Fix potential mem leak in virtqueue_add_indirect_packed
Date:   Tue, 12 Mar 2019 15:06:53 +0800
Message-ID: <20190312070653.16392-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

'desc' should be freed before leaving from err handing path.

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/virtio/virtio_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a0b07c3..9d95d9c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -991,6 +991,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
+		kfree(desc);
 		END_USE(vq);
 		return -ENOSPC;
 	}
-- 
2.7.0


