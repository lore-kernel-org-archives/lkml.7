Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA7C20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfDQHz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:55:28 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:53383 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbfDQHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:55:25 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 147FA240016;
        Wed, 17 Apr 2019 07:55:21 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 08/20] drm/malidp: Convert to generic image format library
Date:   Wed, 17 Apr 2019 09:54:34 +0200
Message-Id: <acf493e5663f6ea7848331ccd73387d913a66459.1555487650.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a generic image format libary, let's convert drivers to
use it so that we can deprecate the old DRM one.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/arm/malidp_drv.c    | 1 +
 drivers/gpu/drm/arm/malidp_hw.c     | 4 ++--
 drivers/gpu/drm/arm/malidp_planes.c | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 9e5240c2d5c7..6fddb70894cb 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -10,6 +10,7 @@
  * ARM Mali DP500/DP550/DP650 KMS/DRM driver
  */
 
+#include <linux/image-formats.h>
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/component.h>
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 1c9e869f4c52..24c01ff458d5 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -382,8 +382,8 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 
 int malidp_format_get_bpp(u32 fmt)
 {
-	const struct drm_format_info *info = drm_format_info(fmt);
-	int bpp = drm_format_info_plane_cpp(info, 0) * 8;
+	const struct image_format_info *info = image_format_drm_lookup(fmt);
+	int bpp = image_format_info_plane_cpp(info, 0) * 8;
 
 	if (bpp == 0) {
 		switch (fmt) {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 9874f98f2aa5..b9d4d7d9a960 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -150,7 +150,7 @@ static void malidp_plane_atomic_print_state(struct drm_printer *p,
 bool malidp_format_mod_supported(struct drm_device *drm,
 				 u32 format, u64 modifier)
 {
-	const struct drm_format_info *info;
+	const struct image_format_info *info;
 	const u64 *modifiers;
 	struct malidp_drm *malidp = drm->dev_private;
 	const struct malidp_hw_regmap *map = &malidp->dev->hw->map;
@@ -201,7 +201,7 @@ bool malidp_format_mod_supported(struct drm_device *drm,
 		return false;
 	}
 
-	info = drm_format_info(format);
+	info = image_format_drm_lookup(format);
 
 	if (info->num_planes != 1) {
 		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
@@ -227,7 +227,7 @@ bool malidp_format_mod_supported(struct drm_device *drm,
 
 	if (modifier & AFBC_SPLIT) {
 		if (!info->is_yuv) {
-			if (drm_format_info_plane_cpp(info, 0) <= 2) {
+			if (image_format_info_plane_cpp(info, 0) <= 2) {
 				DRM_DEBUG_KMS("RGB formats <= 16bpp are not supported with SPLIT\n");
 				return false;
 			}
-- 
git-series 0.9.1
