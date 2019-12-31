Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59267C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31312206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfLaGvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 01:51:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfLaGvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 01:51:03 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BDB2CAABD6973A0E411E;
        Tue, 31 Dec 2019 14:51:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 31 Dec 2019 14:50:51 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: get the BO from drm_fb rather than hibmc_fb
Date:   Tue, 31 Dec 2019 14:50:59 +0800
Message-ID: <1577775059-61116-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since we can get the BO from drm_fb rather than hibmc_fb,do not need
the hibmc_fb.so we delete the local variable hibmc_fb.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 6bf4334..12b38ac 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -105,14 +105,12 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
 	s64 gpu_addr = 0;
 	unsigned int line_l;
 	struct hibmc_drm_private *priv = plane->dev->dev_private;
-	struct hibmc_framebuffer *hibmc_fb;
 	struct drm_gem_vram_object *gbo;
 
 	if (!state->fb)
 		return;
 
-	hibmc_fb = to_hibmc_framebuffer(state->fb);
-	gbo = drm_gem_vram_of_gem(hibmc_fb->obj);
+	gbo = drm_gem_vram_of_gem(state->fb->obj[0]);
 
 	gpu_addr = drm_gem_vram_offset(gbo);
 	if (WARN_ON_ONCE(gpu_addr < 0))
-- 
2.7.4

