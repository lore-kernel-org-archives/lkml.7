Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFCCC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5D72082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfEQQhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:37:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45538 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfEQQhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:37:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A3581715;
        Fri, 17 May 2019 09:37:32 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B05A63F575;
        Fri, 17 May 2019 09:37:31 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     liviu.dudau@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/arm/hdlcd: Actually validate CRTC modes
Date:   Fri, 17 May 2019 17:37:21 +0100
Message-Id: <9db0bac184d9fa69c4f65bf954ab59b53d431e15.1558111042.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than allowing any old mode through, then subsequently refusing
unmatchable clock rates in atomic_check when it's too late to back out
and pick a different mode, let's do that validation up-front where it
will cause unsupported modes to be correctly pruned in the first place.

This also eliminates an issue whereby a perceived clock rate of 0 would
cause atomic disable to fail and prevent the module from being unloaded.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

This supersedes my previous patch here:
https://patchwork.freedesktop.org/patch/288553/
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 0b2b62f8fa3c..ecac6fe0b213 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -186,20 +186,19 @@ static void hdlcd_crtc_atomic_disable(struct drm_crtc *crtc,
 	clk_disable_unprepare(hdlcd->clk);
 }
 
-static int hdlcd_crtc_atomic_check(struct drm_crtc *crtc,
-				   struct drm_crtc_state *state)
+static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
+		const struct drm_display_mode *mode)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
-	struct drm_display_mode *mode = &state->adjusted_mode;
 	long rate, clk_rate = mode->clock * 1000;
 
 	rate = clk_round_rate(hdlcd->clk, clk_rate);
 	if (rate != clk_rate) {
 		/* clock required by mode not supported by hardware */
-		return -EINVAL;
+		return MODE_NOCLOCK;
 	}
 
-	return 0;
+	return MODE_OK;
 }
 
 static void hdlcd_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -220,7 +219,7 @@ static void hdlcd_crtc_atomic_begin(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs hdlcd_crtc_helper_funcs = {
-	.atomic_check	= hdlcd_crtc_atomic_check,
+	.mode_valid	= hdlcd_crtc_mode_valid,
 	.atomic_begin	= hdlcd_crtc_atomic_begin,
 	.atomic_enable	= hdlcd_crtc_atomic_enable,
 	.atomic_disable	= hdlcd_crtc_atomic_disable,
-- 
2.21.0.dirty

