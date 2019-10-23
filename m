Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6F1CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738F62084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbfJWH7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:59:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbfJWH7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:59:34 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A09A113FE714AAF0BAA1;
        Wed, 23 Oct 2019 15:59:30 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 15:59:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Felix.Kuehling@amd.com>, <Philip.Yang@amd.com>, <jgg@ziepe.ca>,
        <kraxel@redhat.com>, <tzimmermann@suse.de>, <tianci.yin@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'adev'
Date:   Wed, 23 Oct 2019 15:58:31 +0800
Message-ID: <20191023075831.33636-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1221:24: warning: variable adev set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:488:24: warning: variable adev set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:547:24: warning: variable adev set but not used [-Wunused-but-set-variable]

It is never used, so can removed it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a61b0d9..ba00262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -485,15 +485,12 @@ static int amdgpu_move_vram_ram(struct ttm_buffer_object *bo, bool evict,
 				struct ttm_operation_ctx *ctx,
 				struct ttm_mem_reg *new_mem)
 {
-	struct amdgpu_device *adev;
 	struct ttm_mem_reg *old_mem = &bo->mem;
 	struct ttm_mem_reg tmp_mem;
 	struct ttm_place placements;
 	struct ttm_placement placement;
 	int r;
 
-	adev = amdgpu_ttm_adev(bo->bdev);
-
 	/* create space/pages for new_mem in GTT space */
 	tmp_mem = *new_mem;
 	tmp_mem.mm_node = NULL;
@@ -544,15 +541,12 @@ static int amdgpu_move_ram_vram(struct ttm_buffer_object *bo, bool evict,
 				struct ttm_operation_ctx *ctx,
 				struct ttm_mem_reg *new_mem)
 {
-	struct amdgpu_device *adev;
 	struct ttm_mem_reg *old_mem = &bo->mem;
 	struct ttm_mem_reg tmp_mem;
 	struct ttm_placement placement;
 	struct ttm_place placements;
 	int r;
 
-	adev = amdgpu_ttm_adev(bo->bdev);
-
 	/* make space in GTT for old_mem buffer */
 	tmp_mem = *new_mem;
 	tmp_mem.mm_node = NULL;
@@ -1218,11 +1212,8 @@ static struct ttm_backend_func amdgpu_backend_func = {
 static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 					   uint32_t page_flags)
 {
-	struct amdgpu_device *adev;
 	struct amdgpu_ttm_tt *gtt;
 
-	adev = amdgpu_ttm_adev(bo->bdev);
-
 	gtt = kzalloc(sizeof(struct amdgpu_ttm_tt), GFP_KERNEL);
 	if (gtt == NULL) {
 		return NULL;
-- 
2.7.4


