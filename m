Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72F8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA71020842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393523AbfIFNxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:53:39 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53801 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405336AbfIFNxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:53:37 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2F486FF805;
        Fri,  6 Sep 2019 13:53:33 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu,
        VenkataRajesh.Kalakodima@in.bosch.com
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, airlied@linux.ie,
        daniel@ffwll.ch, koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] drm: rcar-du: Claim CMM support for Gen3 SoCs
Date:   Fri,  6 Sep 2019 15:54:31 +0200
Message-Id: <20190906135436.10622-5-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906135436.10622-1-jacopo+renesas@jmondi.org>
References: <20190906135436.10622-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CMM to the list of supported features for Gen3 SoCs that provide it:
- R8A7795
- R8A7796
- R8A77965
- R8A7799x

Leave R8A77970 out as V3M and V3H are the only Gen3 SoCs that do not
support CMM.

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 12 ++++++++----
 drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 6df37c2a9678..018480a8f35c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -276,7 +276,8 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
 		  | RCAR_DU_FEATURE_INTERLACED
-		  | RCAR_DU_FEATURE_TVM_SYNC,
+		  | RCAR_DU_FEATURE_TVM_SYNC
+		  | RCAR_DU_FEATURE_CMM,
 	.channels_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -309,7 +310,8 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
 		  | RCAR_DU_FEATURE_INTERLACED
-		  | RCAR_DU_FEATURE_TVM_SYNC,
+		  | RCAR_DU_FEATURE_TVM_SYNC
+		  | RCAR_DU_FEATURE_CMM,
 	.channels_mask = BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -338,7 +340,8 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
 		  | RCAR_DU_FEATURE_INTERLACED
-		  | RCAR_DU_FEATURE_TVM_SYNC,
+		  | RCAR_DU_FEATURE_TVM_SYNC
+		  | RCAR_DU_FEATURE_CMM,
 	.channels_mask = BIT(3) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -386,7 +389,8 @@ static const struct rcar_du_device_info rcar_du_r8a77970_info = {
 static const struct rcar_du_device_info rcar_du_r8a7799x_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_CMM,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 1327cd0df90a..a00dccc447aa 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -28,6 +28,7 @@ struct rcar_du_encoder;
 #define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(1)	/* Has inputs from VSP1 */
 #define RCAR_DU_FEATURE_INTERLACED	BIT(2)	/* HW supports interlaced */
 #define RCAR_DU_FEATURE_TVM_SYNC	BIT(3)	/* Has TV switch/sync modes */
+#define RCAR_DU_FEATURE_CMM		BIT(4)	/* Has CMM */
 
 #define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)	/* Align pitches to 128 bytes */
 
-- 
2.23.0

