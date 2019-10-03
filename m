Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD916C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5620679
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbfJCVk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:40:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58807 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbfJCVkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:40:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iG8qA-00071M-5a; Thu, 03 Oct 2019 21:40:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: remove redundant variable r and redundant return statement
Date:   Thu,  3 Oct 2019 22:40:49 +0100
Message-Id: <20191003214049.23067-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a return statement that is not reachable and a variable that
is not used.  Remove them.

Addresses-Coverity: ("Structurally dead code")
Fixes: de7b45babd9b ("drm/amdgpu: cleanup creating BOs at fixed location (v2)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 481e4c381083..814159f15633 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1636,7 +1636,6 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
 static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 {
 	uint64_t vram_size = adev->gmc.visible_vram_size;
-	int r;
 
 	adev->fw_vram_usage.va = NULL;
 	adev->fw_vram_usage.reserved_bo = NULL;
@@ -1651,7 +1650,6 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->fw_vram_usage.reserved_bo,
 					  &adev->fw_vram_usage.va);
-	return r;
 }
 
 /**
-- 
2.20.1

