Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5F9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9CE218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FSR1sGQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfCORBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:01:23 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53214 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfCORBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:01:21 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1CC8531A;
        Fri, 15 Mar 2019 18:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552669278;
        bh=l2WHBzQ97fiRRw8HGm0U75led6lghgKRdWH14hpemIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSR1sGQU1c5Qk1B3P08XfEC+4C/vE0yoTp53Fky8eQLb7pFpGotnAZM0vP+bAAD+H
         BbA1arLp1KZjcPkD5obAS/D5JR7Up5RND2vqH554GeBloo2wZNsAQi6NH40tkgaD5+
         L5Qj3MBYQ6UtocYqracYZClNVSfZCJn4Lmd1nh4U=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] drm: rcar-du: Provide for_each_group helper
Date:   Fri, 15 Mar 2019 17:01:08 +0000
Message-Id: <20190315170110.23280-5-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190315170110.23280-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring of the group control code will soon require more iteration
over the available groups. Simplify this process by introducing a group
iteration helper.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
v2:
 - no change

 drivers/gpu/drm/rcar-du/rcar_du_drv.h |  5 +++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 10 ++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 1327cd0df90a..1e9dd494e8ac 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -96,6 +96,11 @@ struct rcar_du_device {
 	unsigned int vspd1_sink;
 };
 
+#define for_each_rcdu_group(__rcdu, __group, __i) \
+	for ((__i) = 0; (__group = &(rcdu)->groups[__i]), \
+	     (__i) < DIV_ROUND_UP((rcdu)->num_crtcs, 2); \
+	     __i++)
+
 static inline bool rcar_du_has(struct rcar_du_device *rcdu,
 			       unsigned int feature)
 {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index e4befb1937f8..ece92cff2137 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -522,9 +522,9 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	struct drm_device *dev = rcdu->ddev;
 	struct drm_encoder *encoder;
+	struct rcar_du_group *rgrp;
 	unsigned int dpad0_sources;
 	unsigned int num_encoders;
-	unsigned int num_groups;
 	unsigned int swindex;
 	unsigned int hwindex;
 	unsigned int i;
@@ -565,11 +565,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 		return ret;
 
 	/* Initialize the groups. */
-	num_groups = DIV_ROUND_UP(rcdu->num_crtcs, 2);
-
-	for (i = 0; i < num_groups; ++i) {
-		struct rcar_du_group *rgrp = &rcdu->groups[i];
-
+	for_each_rcdu_group(rcdu, rgrp, i) {
 		mutex_init(&rgrp->lock);
 
 		rgrp->dev = rcdu;
@@ -606,8 +602,6 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	/* Create the CRTCs. */
 	for (swindex = 0, hwindex = 0; swindex < rcdu->num_crtcs; ++hwindex) {
-		struct rcar_du_group *rgrp;
-
 		/* Skip unpopulated DU channels. */
 		if (!(rcdu->info->channels_mask & BIT(hwindex)))
 			continue;
-- 
2.19.1

