Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E4C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3CB21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfGELZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:25:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfGELZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:25:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3D5D6788578AE1B141F;
        Fri,  5 Jul 2019 19:24:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 5 Jul 2019 19:24:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <imre.deak@intel.com>, <dhinakaran.pandiyan@intel.com>,
        <ville.syrjala@linux.intel.com>, <chris@chris-wilson.co.uk>,
        <manasi.d.navare@intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/i915: Remove set but not used variable 'encoder'
Date:   Fri, 5 Jul 2019 11:31:12 +0000
Message-ID: <20190705113112.64715-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/i915/display/intel_dp.c: In function 'intel_dp_set_drrs_state':
drivers/gpu/drm/i915/display/intel_dp.c:6623:24: warning:
 variable 'encoder' set but not used [-Wunused-but-set-variable]

It's never used, so can be removed.Also remove related
variable 'dig_port'

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 8f7188d71d08..0bdb7ecc5a81 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6620,8 +6620,6 @@ static void intel_dp_set_drrs_state(struct drm_i915_private *dev_priv,
 				    const struct intel_crtc_state *crtc_state,
 				    int refresh_rate)
 {
-	struct intel_encoder *encoder;
-	struct intel_digital_port *dig_port = NULL;
 	struct intel_dp *intel_dp = dev_priv->drrs.dp;
 	struct intel_crtc *intel_crtc = to_intel_crtc(crtc_state->base.crtc);
 	enum drrs_refresh_rate_type index = DRRS_HIGH_RR;
@@ -6636,9 +6634,6 @@ static void intel_dp_set_drrs_state(struct drm_i915_private *dev_priv,
 		return;
 	}
 
-	dig_port = dp_to_dig_port(intel_dp);
-	encoder = &dig_port->base;
-
 	if (!intel_crtc) {
 		DRM_DEBUG_KMS("DRRS: intel_crtc not initialized\n");
 		return;



