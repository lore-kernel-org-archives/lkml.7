Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB112C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C351C213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCTMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:47:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727269AbfCTMrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:47:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DA1B5F83B5C7B2082090;
        Wed, 20 Mar 2019 20:47:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Mar 2019 20:47:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/ttm: remove set but not used variable 'rdev'
Date:   Wed, 20 Mar 2019 12:59:39 +0000
Message-ID: <20190320125939.74347-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/radeon/radeon_ttm.c: In function 'radeon_move_vram_ram':
drivers/gpu/drm/radeon/radeon_ttm.c:254:24: warning:
 variable 'rdev' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/radeon/radeon_ttm.c: In function 'radeon_move_ram_vram':
drivers/gpu/drm/radeon/radeon_ttm.c:301:24: warning:
 variable 'rdev' set but not used [-Wunused-but-set-variable]

It's not used since a987fcaa805f ("ttm: Make parts of a struct ttm_bo_device
global.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 557bdd7a2fc8..5d42f8d8e68d 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -251,14 +251,12 @@ static int radeon_move_vram_ram(struct ttm_buffer_object *bo,
 				struct ttm_mem_reg *new_mem)
 {
 	struct ttm_operation_ctx ctx = { interruptible, no_wait_gpu };
-	struct radeon_device *rdev;
 	struct ttm_mem_reg *old_mem = &bo->mem;
 	struct ttm_mem_reg tmp_mem;
 	struct ttm_place placements;
 	struct ttm_placement placement;
 	int r;
 
-	rdev = radeon_get_rdev(bo->bdev);
 	tmp_mem = *new_mem;
 	tmp_mem.mm_node = NULL;
 	placement.num_placement = 1;
@@ -298,14 +296,12 @@ static int radeon_move_ram_vram(struct ttm_buffer_object *bo,
 				struct ttm_mem_reg *new_mem)
 {
 	struct ttm_operation_ctx ctx = { interruptible, no_wait_gpu };
-	struct radeon_device *rdev;
 	struct ttm_mem_reg *old_mem = &bo->mem;
 	struct ttm_mem_reg tmp_mem;
 	struct ttm_placement placement;
 	struct ttm_place placements;
 	int r;
 
-	rdev = radeon_get_rdev(bo->bdev);
 	tmp_mem = *new_mem;
 	tmp_mem.mm_node = NULL;
 	placement.num_placement = 1;



