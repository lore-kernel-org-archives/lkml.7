Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313CAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084AD20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfDQHzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:55:35 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41683 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731380AbfDQHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:55:30 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 66EE3240014;
        Wed, 17 Apr 2019 07:55:27 +0000 (UTC)
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
Subject: [PATCH 10/20] drm/exynos: Convert to generic image format library
Date:   Wed, 17 Apr 2019 09:54:36 +0200
Message-Id: <77b68a688cf9970f14b97a87b19be0b309788e30.1555487650.git-series.maxime.ripard@bootlin.com>
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
 drivers/gpu/drm/exynos/exynos_drm_ipp.c    | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.h    | 4 +++-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 23226a0212e8..ba012840fe07 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -562,7 +562,7 @@ static int exynos_drm_ipp_check_format(struct exynos_drm_ipp_task *task,
 	if (buf->buf.width == 0 || buf->buf.height == 0)
 		return -EINVAL;
 
-	buf->format = drm_format_info(buf->buf.fourcc);
+	buf->format = image_format_drm_lookup(buf->buf.fourcc);
 	for (i = 0; i < buf->format->num_planes; i++) {
 		unsigned int width = (i == 0) ? buf->buf.width :
 			     DIV_ROUND_UP(buf->buf.width, buf->format->hsub);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.h b/drivers/gpu/drm/exynos/exynos_drm_ipp.h
index 0b27d4a9bf94..c6cd21f185e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.h
@@ -71,12 +71,14 @@ struct exynos_drm_ipp {
 	wait_queue_head_t done_wq;
 };
 
+struct image_format_info;
+
 struct exynos_drm_ipp_buffer {
 	struct drm_exynos_ipp_task_buffer buf;
 	struct drm_exynos_ipp_task_rect rect;
 
 	struct exynos_drm_gem *exynos_gem[MAX_FB_BUFFER];
-	const struct drm_format_info *format;
+	const struct image_format_info *format;
 	dma_addr_t dma_addr[MAX_FB_BUFFER];
 };
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index ed1dd1aec902..c9791a2013cf 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/component.h>
 #include <linux/err.h>
+#include <linux/image-formats.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -301,7 +302,7 @@ static inline void scaler_set_rotation(struct scaler_context *scaler,
 }
 
 static inline void scaler_set_csc(struct scaler_context *scaler,
-	const struct drm_format_info *fmt)
+	const struct image_format_info *fmt)
 {
 	static const u32 csc_mtx[2][3][3] = {
 		{ /* YCbCr to RGB */
-- 
git-series 0.9.1
