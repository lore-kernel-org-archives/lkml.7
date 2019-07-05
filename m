Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1B6C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B95221852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfGELZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:25:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfGELZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:25:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1E009F0A5E052BED9DA3;
        Fri,  5 Jul 2019 19:25:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 5 Jul 2019 19:25:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <lucas.demarchi@intel.com>, <ville.syrjala@linux.intel.com>,
        <imre.deak@intel.com>, <jose.souza@intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/i915: Remove set but not used variable 'intel_dig_port'
Date:   Fri, 5 Jul 2019 11:31:38 +0000
Message-ID: <20190705113138.65880-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/i915/display/intel_ddi.c: In function 'intel_ddi_get_config':
drivers/gpu/drm/i915/display/intel_ddi.c:3774:29: warning:
 variable 'intel_dig_port' set but not used [-Wunused-but-set-variable]
  struct intel_digital_port *intel_dig_port;

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a4172595c8d8..30e48609db1d 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3771,7 +3771,6 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 	struct intel_crtc *intel_crtc = to_intel_crtc(pipe_config->base.crtc);
 	enum transcoder cpu_transcoder = pipe_config->cpu_transcoder;
-	struct intel_digital_port *intel_dig_port;
 	u32 temp, flags = 0;
 
 	/* XXX: DSI transcoder paranoia */
@@ -3810,7 +3809,6 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 	switch (temp & TRANS_DDI_MODE_SELECT_MASK) {
 	case TRANS_DDI_MODE_SELECT_HDMI:
 		pipe_config->has_hdmi_sink = true;
-		intel_dig_port = enc_to_dig_port(&encoder->base);
 
 		pipe_config->infoframes.enable |=
 			intel_hdmi_infoframes_enabled(encoder, pipe_config);



