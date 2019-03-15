Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FD0218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JhgJXMxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfCORBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:01:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53230 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfCORBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:01:19 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F8E7998;
        Fri, 15 Mar 2019 18:01:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552669277;
        bh=aVY5f6PMZdwzbI1d/sLGxRVQepXzKdr0SDBDUq7PiNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhgJXMxpkqGmt8O125KpUQynm8FHb8oYPrpczwYaK4GHTTIVRN98P88uOTWBXwPZ8
         dsAkfY7sRvwJN9aA3gDQc6bestwknN4fwLLXZanxOJ7Yh1a8gshU9WL1r31+0RhIb2
         hhc5Zs2o/idgYsahDrXqm13Tcto93WC2PyFmw824=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] drm: rcar-du: Add pre/post commit CRTC helpers
Date:   Fri, 15 Mar 2019 17:01:07 +0000
Message-Id: <20190315170110.23280-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide helpers to allow CRTC configuration to be separated from the power
state handling. rcar_du_crtc_atomic_post_commit() is a no-op, but maintained
for API symmetry.

---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  5 +++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c  |  2 ++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 6109a97b0bb9..2606de788688 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -515,8 +515,6 @@ static int rcar_du_crtc_enable(struct rcar_du_crtc *rcrtc)
 	if (ret < 0)
 		goto error_group;
 
-	rcar_du_crtc_setup(rcrtc);
-
 	return 0;
 
 error_group:
@@ -683,6 +681,29 @@ int rcar_du_crtc_atomic_enter_standby(struct drm_device *dev,
 	return 0;
 }
 
+int rcar_du_crtc_atomic_pre_commit(struct drm_device *dev,
+				   struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	unsigned int i;
+
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+
+		if (crtc_state->active_changed && crtc_state->active)
+			rcar_du_crtc_setup(rcrtc);
+	}
+
+	return 0;
+}
+
+int rcar_du_crtc_atomic_post_commit(struct drm_device *dev,
+				    struct drm_atomic_state *state)
+{
+	return 0;
+}
+
 static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 				       struct drm_crtc_state *old_state)
 {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index d12d4a788e9f..0b60a6e0b753 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -105,6 +105,11 @@ int rcar_du_crtc_atomic_exit_standby(struct drm_device *dev,
 int rcar_du_crtc_atomic_enter_standby(struct drm_device *dev,
 				      struct drm_atomic_state *state);
 
+int rcar_du_crtc_atomic_pre_commit(struct drm_device *dev,
+				   struct drm_atomic_state *state);
+int rcar_du_crtc_atomic_post_commit(struct drm_device *dev,
+				    struct drm_atomic_state *state);
+
 void rcar_du_crtc_dsysr_clr_set(struct rcar_du_crtc *rcrtc, u32 clr, u32 set);
 
 #endif /* __RCAR_DU_CRTC_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index b8da4dfc79d2..e4befb1937f8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -304,12 +304,14 @@ static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
 
 	/* Apply the atomic update. */
 	rcar_du_crtc_atomic_exit_standby(dev, old_state);
+	rcar_du_crtc_atomic_pre_commit(dev, old_state);
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 	drm_atomic_helper_commit_planes(dev, old_state,
 					DRM_PLANE_COMMIT_ACTIVE_ONLY);
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
 
+	rcar_du_crtc_atomic_post_commit(dev, old_state);
 	rcar_du_crtc_atomic_enter_standby(dev, old_state);
 
 	drm_atomic_helper_commit_hw_done(old_state);
-- 
2.19.1

