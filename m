Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897AEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DBE20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfKOJr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:47:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41250 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKOJr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:47:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iVYCo-0002Zt-Iq; Fri, 15 Nov 2019 09:47:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu/powerplay: fix dereference before null check of pointer hwmgr
Date:   Fri, 15 Nov 2019 09:47:54 +0000
Message-Id: <20191115094754.40920-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of adev dereferences pointer hwmgr before hwmgr is null
checked, hence there is a potential null pointer deference issue. Fix
this by assigning adev after the null check.

Addresses-Coverity: ("Dereference before null check")
Fixes: 0896d2f7ba4d ("drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index 443625c83ec9..d2909c91d65b 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -81,7 +81,7 @@ static void hwmgr_init_workload_prority(struct pp_hwmgr *hwmgr)
 
 int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 {
-	struct amdgpu_device *adev = hwmgr->adev;
+	struct amdgpu_device *adev;
 
 	if (!hwmgr)
 		return -EINVAL;
@@ -96,6 +96,8 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 	hwmgr_init_workload_prority(hwmgr);
 	hwmgr->gfxoff_state_changed_by_workload = false;
 
+	adev = hwmgr->adev;
+
 	switch (hwmgr->chip_family) {
 	case AMDGPU_FAMILY_CI:
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-- 
2.20.1

