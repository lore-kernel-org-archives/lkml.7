Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CB9C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D407A2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfGSBqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:46:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbfGSBqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:46:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF09970995D2006834BB;
        Fri, 19 Jul 2019 09:46:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 19 Jul 2019 09:45:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <imre.deak@intel.com>, <madhav.chauhan@intel.com>,
        <vandita.kulkarni@intel.com>, <chris@chris-wilson.co.uk>,
        <ville.syrjala@linux.intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] drm/i915/dsi: remove set but not used variable 'hfront_porch'
Date:   Fri, 19 Jul 2019 01:51:36 +0000
Message-ID: <20190719015136.103988-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/i915/display/icl_dsi.c: In function 'gen11_dsi_set_transcoder_timings':
drivers/gpu/drm/i915/display/icl_dsi.c:768:6: warning:
 variable 'hfront_porch' set but not used [-Wunused-but-set-variable]

It is never used and can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 4d952accfaaa..a42348be0438 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -763,7 +763,7 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 	enum transcoder dsi_trans;
 	/* horizontal timings */
 	u16 htotal, hactive, hsync_start, hsync_end, hsync_size;
-	u16 hfront_porch, hback_porch;
+	u16 hback_porch;
 	/* vertical timings */
 	u16 vtotal, vactive, vsync_start, vsync_end, vsync_shift;
 
@@ -772,8 +772,6 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 	hsync_start = adjusted_mode->crtc_hsync_start;
 	hsync_end = adjusted_mode->crtc_hsync_end;
 	hsync_size  = hsync_end - hsync_start;
-	hfront_porch = (adjusted_mode->crtc_hsync_start -
-			adjusted_mode->crtc_hdisplay);
 	hback_porch = (adjusted_mode->crtc_htotal -
 		       adjusted_mode->crtc_hsync_end);
 	vactive = adjusted_mode->crtc_vdisplay;



