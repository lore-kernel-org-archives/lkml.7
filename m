Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F02CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375662175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCTBvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:51:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbfCTBvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:51:09 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C0FEEE3C4F473C6925E4;
        Wed, 20 Mar 2019 09:51:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Mar 2019 09:50:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/ttm: remove set but not used variable 'vgdev'
Date:   Wed, 20 Mar 2019 02:03:08 +0000
Message-ID: <20190320020308.12745-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_init_mem_type':
drivers/gpu/drm/virtio/virtgpu_ttm.c:117:28: warning:
 variable 'vgdev' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_bo_swap_notify':
drivers/gpu/drm/virtio/virtgpu_ttm.c:300:28: warning:
 variable 'vgdev' set but not used [-Wunused-but-set-variable]

It is never used since introduction in dc5698e80cf7 ("Add virtio gpu driver.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/virtio/virtgpu_ttm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index d6225ba20b30..eb007c2569d8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -114,10 +114,6 @@ static const struct ttm_mem_type_manager_func virtio_gpu_bo_manager_func = {
 static int virtio_gpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 				    struct ttm_mem_type_manager *man)
 {
-	struct virtio_gpu_device *vgdev;
-
-	vgdev = virtio_gpu_get_vgdev(bdev);
-
 	switch (type) {
 	case TTM_PL_SYSTEM:
 		/* System memory */
@@ -297,10 +293,8 @@ static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
 static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
 {
 	struct virtio_gpu_object *bo;
-	struct virtio_gpu_device *vgdev;
 
 	bo = container_of(tbo, struct virtio_gpu_object, tbo);
-	vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
 
 	if (bo->pages)
 		virtio_gpu_object_free_sg_table(bo);



