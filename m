Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848D6218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ijPCW5HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfCORBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:01:30 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53230 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbfCORBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:01:21 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EFB8B31C;
        Fri, 15 Mar 2019 18:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552669279;
        bh=UrfvHm4krdxd+GSoFuwj+gLFgwQemAeuopWT3GWRU8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijPCW5HAxATraOvu67NAR19c1c6oEH1b+czXMHg9YH+7oLLxJL1jQ3C38bamO5yM8
         xn232+98pZt456J4YItcjWLXvJbZr8XxKBA9IQTMyeDquZXDUgKcdmhvxedIW5lJD/
         /PDy3iIAQ8DgjcgRq1gcwnukzrjv48vEtSIKskBA=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/6] drm: rcar-du: Create a group state object
Date:   Fri, 15 Mar 2019 17:01:09 +0000
Message-Id: <20190315170110.23280-6-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new private state object for the DU groups, and move the
initialisation of a group object to a new function rcar_du_group_init().

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
v2:
 - No change

 drivers/gpu/drm/rcar-du/rcar_du_group.c | 81 +++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_group.h | 22 +++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 27 ++-------
 3 files changed, 107 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 9eee47969e77..9c82d666f170 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -26,6 +26,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_device.h>
+
 #include "rcar_du_drv.h"
 #include "rcar_du_group.h"
 #include "rcar_du_regs.h"
@@ -351,3 +355,80 @@ int rcar_du_group_set_routing(struct rcar_du_group *rgrp)
 
 	return rcar_du_set_dpad0_vsp1_routing(rgrp->dev);
 }
+
+static struct drm_private_state *
+rcar_du_group_atomic_duplicate_state(struct drm_private_obj *obj)
+{
+	struct rcar_du_group_state *state;
+
+	if (WARN_ON(!obj->state))
+		return NULL;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (state == NULL)
+		return NULL;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->state);
+
+	return &state->state;
+}
+
+static void rcar_du_group_atomic_destroy_state(struct drm_private_obj *obj,
+					       struct drm_private_state *state)
+{
+	kfree(to_rcar_group_state(state));
+}
+
+static const struct drm_private_state_funcs rcar_du_group_state_funcs = {
+	.atomic_duplicate_state = rcar_du_group_atomic_duplicate_state,
+	.atomic_destroy_state = rcar_du_group_atomic_destroy_state,
+};
+
+/*
+ * rcar_du_group_init - Initialise and reset a group object
+ *
+ * Return 0 in case of success or a negative error code otherwise.
+ */
+int rcar_du_group_init(struct rcar_du_device *rcdu, struct rcar_du_group *rgrp,
+		       unsigned int index)
+{
+	static const unsigned int mmio_offsets[] = {
+		DU0_REG_OFFSET, DU2_REG_OFFSET
+	};
+
+	struct rcar_du_group_state *state;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	drm_atomic_private_obj_init(rcdu->ddev, &rgrp->private, &state->state,
+				    &rcar_du_group_state_funcs);
+
+	mutex_init(&rgrp->lock);
+
+	rgrp->dev = rcdu;
+	rgrp->mmio_offset = mmio_offsets[index];
+	rgrp->index = index;
+	/* Extract the channel mask for this group only. */
+	rgrp->channels_mask = (rcdu->info->channels_mask >> (2 * index))
+			    & GENMASK(1, 0);
+	rgrp->num_crtcs = hweight8(rgrp->channels_mask);
+
+	/*
+	 * If we have more than one CRTC in this group pre-associate
+	 * the low-order planes with CRTC 0 and the high-order planes
+	 * with CRTC 1 to minimize flicker occurring when the
+	 * association is changed.
+	 */
+	rgrp->dptsr_planes = rgrp->num_crtcs > 1
+			   ? (rcdu->info->gen >= 3 ? 0x04 : 0xf0)
+			   : 0;
+
+	return 0;
+}
+
+void rcar_du_group_cleanup(struct rcar_du_group *rgrp)
+{
+	drm_atomic_private_obj_fini(&rgrp->private);
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/rcar-du/rcar_du_group.h
index 87950c1f6a52..4b812e167987 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
@@ -12,12 +12,15 @@
 
 #include <linux/mutex.h>
 
+#include <drm/drm_atomic.h>
+
 #include "rcar_du_plane.h"
 
 struct rcar_du_device;
 
 /*
  * struct rcar_du_group - CRTCs and planes group
+ * @private: The base drm private object
  * @dev: the DU device
  * @mmio_offset: registers offset in the device memory map
  * @index: group index
@@ -32,6 +35,8 @@ struct rcar_du_device;
  * @need_restart: the group needs to be restarted due to a configuration change
  */
 struct rcar_du_group {
+	struct drm_private_obj private;
+
 	struct rcar_du_device *dev;
 	unsigned int mmio_offset;
 	unsigned int index;
@@ -49,6 +54,19 @@ struct rcar_du_group {
 	bool need_restart;
 };
 
+#define to_rcar_group(s) container_of(s, struct rcar_du_group, private)
+
+/**
+ * struct rcar_du_group_state - Driver-specific group state
+ * @state: base DRM private state
+ */
+struct rcar_du_group_state {
+	struct drm_private_state state;
+};
+
+#define to_rcar_group_state(s) \
+	container_of(s, struct rcar_du_group_state, state)
+
 u32 rcar_du_group_read(struct rcar_du_group *rgrp, u32 reg);
 void rcar_du_group_write(struct rcar_du_group *rgrp, u32 reg, u32 data);
 
@@ -60,4 +78,8 @@ int rcar_du_group_set_routing(struct rcar_du_group *rgrp);
 
 int rcar_du_set_dpad0_vsp1_routing(struct rcar_du_device *rcdu);
 
+int rcar_du_group_init(struct rcar_du_device *rcdu, struct rcar_du_group *rgrp,
+		       unsigned int index);
+void rcar_du_group_cleanup(struct rcar_du_group *rgrp);
+
 #endif /* __RCAR_DU_GROUP_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index ece92cff2137..eb01bea1ab83 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -23,6 +23,7 @@
 #include "rcar_du_crtc.h"
 #include "rcar_du_drv.h"
 #include "rcar_du_encoder.h"
+#include "rcar_du_group.h"
 #include "rcar_du_kms.h"
 #include "rcar_du_regs.h"
 #include "rcar_du_vsp.h"
@@ -516,10 +517,6 @@ static int rcar_du_vsps_init(struct rcar_du_device *rcdu)
 
 int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 {
-	static const unsigned int mmio_offsets[] = {
-		DU0_REG_OFFSET, DU2_REG_OFFSET
-	};
-
 	struct drm_device *dev = rcdu->ddev;
 	struct drm_encoder *encoder;
 	struct rcar_du_group *rgrp;
@@ -566,25 +563,9 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	/* Initialize the groups. */
 	for_each_rcdu_group(rcdu, rgrp, i) {
-		mutex_init(&rgrp->lock);
-
-		rgrp->dev = rcdu;
-		rgrp->mmio_offset = mmio_offsets[i];
-		rgrp->index = i;
-		/* Extract the channel mask for this group only. */
-		rgrp->channels_mask = (rcdu->info->channels_mask >> (2 * i))
-				   & GENMASK(1, 0);
-		rgrp->num_crtcs = hweight8(rgrp->channels_mask);
-
-		/*
-		 * If we have more than one CRTCs in this group pre-associate
-		 * the low-order planes with CRTC 0 and the high-order planes
-		 * with CRTC 1 to minimize flicker occurring when the
-		 * association is changed.
-		 */
-		rgrp->dptsr_planes = rgrp->num_crtcs > 1
-				   ? (rcdu->info->gen >= 3 ? 0x04 : 0xf0)
-				   : 0;
+		ret = rcar_du_group_init(rcdu, rgrp, i);
+		if (ret < 0)
+			return ret;
 
 		if (!rcar_du_has(rcdu, RCAR_DU_FEATURE_VSP1_SOURCE)) {
 			ret = rcar_du_planes_init(rgrp);
-- 
2.19.1

