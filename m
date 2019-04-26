Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C309DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC28208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDZQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:42:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfDZQmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:42:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ACA57BAFC13D27132B9F;
        Sat, 27 Apr 2019 00:42:22 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Apr 2019
 00:42:09 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
        <brian.starkey@arm.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/komeda: remove set but not used variable 'kcrtc'
Date:   Sat, 27 Apr 2019 00:42:02 +0800
Message-ID: <20190426164202.34932-1-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/arm/display/komeda/komeda_plane.c: In function komeda_plane_atomic_check:
drivers/gpu/drm/arm/display/komeda/komeda_plane.c:49:22: warning: variable kcrtc set but not used [-Wunused-but-set-variable]

It is never used since introduction in
commit 7d31b9e7a550 ("drm/komeda: Add komeda_plane/plane_helper_funcs")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
index 07ed0cc..0753892 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -55,7 +55,6 @@ komeda_plane_atomic_check(struct drm_plane *plane,
 	struct komeda_plane_state *kplane_st = to_kplane_st(state);
 	struct komeda_layer *layer = kplane->layer;
 	struct drm_crtc_state *crtc_st;
-	struct komeda_crtc *kcrtc;
 	struct komeda_crtc_state *kcrtc_st;
 	struct komeda_data_flow_cfg dflow;
 	int err;
@@ -73,7 +72,6 @@ komeda_plane_atomic_check(struct drm_plane *plane,
 	if (!crtc_st->active)
 		return 0;
 
-	kcrtc = to_kcrtc(state->crtc);
 	kcrtc_st = to_kcrtc_st(crtc_st);
 
 	err = komeda_plane_init_data_flow(state, &dflow);
-- 
2.7.4


