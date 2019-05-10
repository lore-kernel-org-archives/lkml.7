Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B58C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E3217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfEJLJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:09:11 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47029 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfEJLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:09:08 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E48A5FF80F;
        Fri, 10 May 2019 11:09:05 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emil Velikov <emil.velikov@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 6/6] drm: Replace instances of drm_format_info by drm_get_format_info
Date:   Fri, 10 May 2019 13:08:51 +0200
Message-Id: <5859d68664b8f0804a56e7386937f6db986b9e0f.1557486447.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_get_format_info directly calls into drm_format_info, but takes directly
a struct drm_mode_fb_cmd2 pointer, instead of the fourcc directly. It's
shorter to not dereference it, and we can customise the behaviour at the
driver level if we want to, so let's switch to it where it makes sense.

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 4 ++--
 drivers/gpu/drm/gma500/framebuffer.c   | 2 +-
 drivers/gpu/drm/omapdrm/omap_fb.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 06e73a343724..6edae6458be8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -121,8 +121,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 					 struct drm_mode_fb_cmd2 *mode_cmd,
 					 struct drm_gem_object **gobj_p)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev,
-								 mode_cmd);
+	const struct drm_format_info *info;
 	struct amdgpu_device *adev = rfbdev->adev;
 	struct drm_gem_object *gobj = NULL;
 	struct amdgpu_bo *abo = NULL;
@@ -133,6 +132,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 	int height = mode_cmd->height;
 	u32 cpp;
 
+	info = drm_get_format_info(adev->ddev, mode_cmd);
 	cpp = drm_format_info_plane_cpp(info, 0);
 
 	/* need to align pitch with crtc limits */
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index a9d3a4a30ab8..1794ab90b2cc 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -232,7 +232,7 @@ static int psb_framebuffer_init(struct drm_device *dev,
 	 * Reject unknown formats, YUV formats, and formats with more than
 	 * 4 bytes per pixel.
 	 */
-	info = drm_format_info(mode_cmd->pixel_format);
+	info = drm_get_format_info(dev, mode_cmd);
 	if (!info || !info->depth || info->cpp[0] > 4)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index cfb641363a32..6557b2d6e16e 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -339,7 +339,7 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 			dev, mode_cmd, mode_cmd->width, mode_cmd->height,
 			(char *)&mode_cmd->pixel_format);
 
-	format = drm_format_info(mode_cmd->pixel_format);
+	format = drm_get_format_info(dev, mode_cmd);
 
 	for (i = 0; i < ARRAY_SIZE(formats); i++) {
 		if (formats[i] == mode_cmd->pixel_format)
-- 
git-series 0.9.1
