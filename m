Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8971F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfDCGsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:48:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfDCGsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:48:35 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [10.3.19.208])
        by Forcepoint Email with ESMTP id 5730F5B35612833AC5EC;
        Wed,  3 Apr 2019 14:48:33 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 14:48:23 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <jcrouse@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/msm/a6xx: Fix build with !CONFIG_DEBUG_FS
Date:   Wed, 3 Apr 2019 14:48:11 +0800
Message-ID: <20190403064811.25832-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

When building CONFIG_DEBUG_FS is not set
gcc warn this:

drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c: In function a6xx_show:
drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:1124:2: error: implicit declaration of function adreno_show; did you mean adreno_dump? [-Werror=implicit-function-declaration]
  adreno_show(gpu, state, p);
  ^~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index e686331..d327eb5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1121,7 +1121,9 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 	if (IS_ERR_OR_NULL(state))
 		return;
 
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
 	adreno_show(gpu, state, p);
+#endif
 
 	drm_puts(p, "registers:\n");
 	for (i = 0; i < a6xx_state->nr_registers; i++) {
-- 
2.7.0


