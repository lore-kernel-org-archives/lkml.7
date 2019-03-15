Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9932C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1188218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D/p5+2g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfCORBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:01:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53214 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfCORBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:01:19 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 87027552;
        Fri, 15 Mar 2019 18:01:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552669276;
        bh=rOGNYI/hEJxwFTv/CYs23lxNz+218g6cV6+qc5zXYSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/p5+2g/xJxm2SFYHPMSqEsYpNEEcMx7qZOA1c8f7wFxd5XgxAWNA+2UQJ+fDxVie
         5mcAyej/tWKAp3d9m8Iws9SkRT83Wia9luVH6aPDtBrxCZ71rxAesD5dlk2Aun+762
         CQF1+9B1WSBTpBHOBruGTaIIOKWVfNSuTZDUcY2A=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/6] drm: rcar-du: Add CRTC standby helpers
Date:   Fri, 15 Mar 2019 17:01:06 +0000
Message-Id: <20190315170110.23280-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide helpers to manage the power state, and initial configuration of
the CRTC.

rcar_du_crtc_get() and rcar_du_crtc_get() are no longer used, and are
removed, simplifying the implementation and removing the initialized
flag which was needed to track the state of the CRTC.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---
v2:
 - Registers sequence confirmed unchanged
 - re-ordered in the series to handle before groups.
 - Do not merge rcar_du_crtc_setup(). (now handled by _crtc_pre_commit)

 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 69 +++++++++++++++-----------
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  7 ++-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c  |  4 ++
 3 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 471ce464654a..6109a97b0bb9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -499,17 +499,10 @@ static void rcar_du_crtc_setup(struct rcar_du_crtc *rcrtc)
 	drm_crtc_vblank_on(&rcrtc->crtc);
 }
 
-static int rcar_du_crtc_get(struct rcar_du_crtc *rcrtc)
+static int rcar_du_crtc_enable(struct rcar_du_crtc *rcrtc)
 {
 	int ret;
 
-	/*
-	 * Guard against double-get, as the function is called from both the
-	 * .atomic_enable() and .atomic_begin() handlers.
-	 */
-	if (rcrtc->initialized)
-		return 0;
-
 	ret = clk_prepare_enable(rcrtc->clock);
 	if (ret < 0)
 		return ret;
@@ -523,7 +516,6 @@ static int rcar_du_crtc_get(struct rcar_du_crtc *rcrtc)
 		goto error_group;
 
 	rcar_du_crtc_setup(rcrtc);
-	rcrtc->initialized = true;
 
 	return 0;
 
@@ -534,14 +526,12 @@ static int rcar_du_crtc_get(struct rcar_du_crtc *rcrtc)
 	return ret;
 }
 
-static void rcar_du_crtc_put(struct rcar_du_crtc *rcrtc)
+static void rcar_du_crtc_disable(struct rcar_du_crtc *rcrtc)
 {
 	rcar_du_group_put(rcrtc->group);
 
 	clk_disable_unprepare(rcrtc->extclock);
 	clk_disable_unprepare(rcrtc->clock);
-
-	rcrtc->initialized = false;
 }
 
 static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
@@ -655,6 +645,44 @@ static int rcar_du_crtc_atomic_check(struct drm_crtc *crtc,
 	return 0;
 }
 
+int rcar_du_crtc_atomic_exit_standby(struct drm_device *dev,
+				     struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	unsigned int i;
+
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+
+		if (crtc_state->active_changed && crtc_state->active) {
+			int ret = rcar_du_crtc_enable(rcrtc);
+
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+int rcar_du_crtc_atomic_enter_standby(struct drm_device *dev,
+				      struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	unsigned int i;
+
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+
+		if (crtc_state->active_changed && !crtc_state->active)
+			rcar_du_crtc_disable(rcrtc);
+	}
+
+	return 0;
+}
+
 static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 				       struct drm_crtc_state *old_state)
 {
@@ -662,8 +690,6 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(crtc->state);
 	struct rcar_du_device *rcdu = rcrtc->dev;
 
-	rcar_du_crtc_get(rcrtc);
-
 	/*
 	 * On D3/E3 the dot clock is provided by the LVDS encoder attached to
 	 * the DU channel. We need to enable its clock output explicitly if
@@ -691,7 +717,6 @@ static void rcar_du_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct rcar_du_device *rcdu = rcrtc->dev;
 
 	rcar_du_crtc_stop(rcrtc);
-	rcar_du_crtc_put(rcrtc);
 
 	if (rcdu->info->lvds_clk_mask & BIT(rcrtc->index) &&
 	    rstate->outputs == BIT(RCAR_DU_OUTPUT_DPAD0)) {
@@ -720,20 +745,6 @@ static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc,
 
 	WARN_ON(!crtc->state->enable);
 
-	/*
-	 * If a mode set is in progress we can be called with the CRTC disabled.
-	 * We thus need to first get and setup the CRTC in order to configure
-	 * planes. We must *not* put the CRTC in .atomic_flush(), as it must be
-	 * kept awake until the .atomic_enable() call that will follow. The get
-	 * operation in .atomic_enable() will in that case be a no-op, and the
-	 * CRTC will be put later in .atomic_disable().
-	 *
-	 * If a mode set is not in progress the CRTC is enabled, and the
-	 * following get call will be a no-op. There is thus no need to balance
-	 * it in .atomic_flush() either.
-	 */
-	rcar_du_crtc_get(rcrtc);
-
 	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
 		rcar_du_vsp_atomic_begin(rcrtc);
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index 11814eafef77..d12d4a788e9f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -29,7 +29,6 @@ struct rcar_du_vsp;
  * @extclock: external pixel dot clock (optional)
  * @mmio_offset: offset of the CRTC registers in the DU MMIO block
  * @index: CRTC software and hardware index
- * @initialized: whether the CRTC has been initialized and clocks enabled
  * @dsysr: cached value of the DSYSR register
  * @vblank_enable: whether vblank events are enabled on this CRTC
  * @event: event to post when the pending page flip completes
@@ -49,7 +48,6 @@ struct rcar_du_crtc {
 	struct clk *extclock;
 	unsigned int mmio_offset;
 	unsigned int index;
-	bool initialized;
 
 	u32 dsysr;
 
@@ -102,6 +100,11 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int swindex,
 
 void rcar_du_crtc_finish_page_flip(struct rcar_du_crtc *rcrtc);
 
+int rcar_du_crtc_atomic_exit_standby(struct drm_device *dev,
+				     struct drm_atomic_state *state);
+int rcar_du_crtc_atomic_enter_standby(struct drm_device *dev,
+				      struct drm_atomic_state *state);
+
 void rcar_du_crtc_dsysr_clr_set(struct rcar_du_crtc *rcrtc, u32 clr, u32 set);
 
 #endif /* __RCAR_DU_CRTC_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 3b7d50a8fb9b..b8da4dfc79d2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -303,11 +303,15 @@ static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
 	}
 
 	/* Apply the atomic update. */
+	rcar_du_crtc_atomic_exit_standby(dev, old_state);
+
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 	drm_atomic_helper_commit_planes(dev, old_state,
 					DRM_PLANE_COMMIT_ACTIVE_ONLY);
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
 
+	rcar_du_crtc_atomic_enter_standby(dev, old_state);
+
 	drm_atomic_helper_commit_hw_done(old_state);
 	drm_atomic_helper_wait_for_flip_done(dev, old_state);
 
-- 
2.19.1

