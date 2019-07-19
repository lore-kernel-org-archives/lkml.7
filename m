Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB6C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E0220873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfGSCfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 22:35:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbfGSCfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:35:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 313D2F73CA5F42628F4B;
        Fri, 19 Jul 2019 10:35:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 19 Jul 2019 10:35:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <ville.syrjala@linux.intel.com>,
        <maarten.lankhorst@linux.intel.com>, <matthew.d.roper@intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] drm/i915/icl: Remove set but not used variable 'src_y'
Date:   Fri, 19 Jul 2019 02:41:00 +0000
Message-ID: <20190719024100.64738-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/i915/display/intel_sprite.c: In function 'g4x_sprite_check_scaling':
drivers/gpu/drm/i915/display/intel_sprite.c:1494:13: warning:
 variable 'src_y' set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_sprite.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/i915/display/intel_sprite.c
index 34586f29be60..9c3367491f04 100644
--- a/drivers/gpu/drm/i915/display/intel_sprite.c
+++ b/drivers/gpu/drm/i915/display/intel_sprite.c
@@ -1491,7 +1491,7 @@ g4x_sprite_check_scaling(struct intel_crtc_state *crtc_state,
 	const struct drm_framebuffer *fb = plane_state->base.fb;
 	const struct drm_rect *src = &plane_state->base.src;
 	const struct drm_rect *dst = &plane_state->base.dst;
-	int src_x, src_y, src_w, src_h, crtc_w, crtc_h;
+	int src_x, src_w, src_h, crtc_w, crtc_h;
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->base.adjusted_mode;
 	unsigned int cpp = fb->format->cpp[0];
@@ -1502,7 +1502,6 @@ g4x_sprite_check_scaling(struct intel_crtc_state *crtc_state,
 	crtc_h = drm_rect_height(dst);
 
 	src_x = src->x1 >> 16;
-	src_y = src->y1 >> 16;
 	src_w = drm_rect_width(src) >> 16;
 	src_h = drm_rect_height(src) >> 16;



