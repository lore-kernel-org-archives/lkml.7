Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008D5C32755
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9A020820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfIWMsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:48:33 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:37076 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfIWMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:48:33 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id E60AA4A6;
        Mon, 23 Sep 2019 20:43:41 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3051T140289744058112S1569242621440080_;
        Mon, 23 Sep 2019 20:43:43 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <24fd09c575207babae724215753035c6>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Huang Rui <ray.huang@amd.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/36] drm/amd: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:41:10 +0800
Message-Id: <1569242500-182337-7-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index eb3569b..895a54c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -133,7 +133,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 	u32 cpp;
 
 	info = drm_get_format_info(adev->ddev, mode_cmd);
-	cpp = info->cpp[0];
+	cpp = info->bpp[0] / 8;
 
 	/* need to align pitch with crtc limits */
 	mode_cmd->pitches[0] = amdgpu_align_pitch(adev, mode_cmd->width, cpp,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 1ffd196..ebf548c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2034,7 +2034,7 @@ static int dce_v10_0_crtc_do_set_base(struct drm_crtc *crtc,
 	WREG32(mmGRPH_X_END + amdgpu_crtc->crtc_offset, target_fb->width);
 	WREG32(mmGRPH_Y_END + amdgpu_crtc->crtc_offset, target_fb->height);
 
-	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->cpp[0];
+	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->bpp[0] / 8;
 	WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset, fb_pitch_pixels);
 
 	dce_v10_0_grph_enable(crtc, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 9e0782b..4400a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2076,7 +2076,7 @@ static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
 	WREG32(mmGRPH_X_END + amdgpu_crtc->crtc_offset, target_fb->width);
 	WREG32(mmGRPH_Y_END + amdgpu_crtc->crtc_offset, target_fb->height);
 
-	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->cpp[0];
+	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->bpp[0] / 8;
 	WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset, fb_pitch_pixels);
 
 	dce_v11_0_grph_enable(crtc, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 4bf453e..fc74153 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1969,7 +1969,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 	WREG32(mmGRPH_X_END + amdgpu_crtc->crtc_offset, target_fb->width);
 	WREG32(mmGRPH_Y_END + amdgpu_crtc->crtc_offset, target_fb->height);
 
-	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->cpp[0];
+	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->bpp[0] / 8;
 	WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset, fb_pitch_pixels);
 
 	dce_v6_0_grph_enable(crtc, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index b23418c..94dfb4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1943,7 +1943,7 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
 	WREG32(mmGRPH_X_END + amdgpu_crtc->crtc_offset, target_fb->width);
 	WREG32(mmGRPH_Y_END + amdgpu_crtc->crtc_offset, target_fb->height);
 
-	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->cpp[0];
+	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->bpp[0] / 8;
 	WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset, fb_pitch_pixels);
 
 	dce_v8_0_grph_enable(crtc, true);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 760af66..d11ab18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2746,7 +2746,7 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 		plane_size->grph.surface_size.width = fb->width;
 		plane_size->grph.surface_size.height = fb->height;
 		plane_size->grph.surface_pitch =
-			fb->pitches[0] / fb->format->cpp[0];
+			fb->pitches[0] / fb->format->bpp[0] / 8;
 
 		address->type = PLN_ADDR_TYPE_GRAPHICS;
 		address->grph.addr.low_part = lower_32_bits(afb->address);
@@ -2759,7 +2759,7 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 		plane_size->video.luma_size.width = fb->width;
 		plane_size->video.luma_size.height = fb->height;
 		plane_size->video.luma_pitch =
-			fb->pitches[0] / fb->format->cpp[0];
+			fb->pitches[0] / fb->format->bpp[0] / 8;
 
 		plane_size->video.chroma_size.x = 0;
 		plane_size->video.chroma_size.y = 0;
@@ -2768,7 +2768,7 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 		plane_size->video.chroma_size.height = fb->height / 2;
 
 		plane_size->video.chroma_pitch =
-			fb->pitches[1] / fb->format->cpp[1];
+			fb->pitches[1] / fb->format->bpp[1] / 8;
 
 		address->type = PLN_ADDR_TYPE_VIDEO_PROGRESSIVE;
 		address->video_progressive.luma_addr.low_part =
-- 
2.7.4



