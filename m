Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2F9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF3E20578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502127AbfIWM4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:56:18 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:45518 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439722AbfIWM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:56:07 -0400
Received: from localhost (unknown [192.168.167.227])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7C69B5CB2C;
        Mon, 23 Sep 2019 20:48:07 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14169T140710336407296S1569242883858959_;
        Mon, 23 Sep 2019 20:48:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <95f5866d2024431c3e32ce476f28709a>
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
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/36] drm/radeon: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:47:36 +0800
Message-Id: <1569242880-182878-2-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242880-182878-1-git-send-email-hjc@rock-chips.com>
References: <1569242880-182878-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c      | 10 +++++-----
 drivers/gpu/drm/radeon/r100.c               |  4 ++--
 drivers/gpu/drm/radeon/radeon_display.c     |  6 +++---
 drivers/gpu/drm/radeon/radeon_fb.c          |  2 +-
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c | 14 +++++++-------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index da2c9e2..e8a033f 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -1285,7 +1285,7 @@ static int dce4_crtc_do_set_base(struct drm_crtc *crtc,
 
 				/* Calculate the macrotile mode index. */
 				tile_split_bytes = 64 << tile_split;
-				tileb = 8 * 8 * target_fb->format->cpp[0];
+				tileb = 8 * target_fb->format->bpp[0];
 				tileb = min(tile_split_bytes, tileb);
 
 				for (index = 0; tileb > 64; index++)
@@ -1293,14 +1293,14 @@ static int dce4_crtc_do_set_base(struct drm_crtc *crtc,
 
 				if (index >= 16) {
 					DRM_ERROR("Wrong screen bpp (%u) or tile split (%u)\n",
-						  target_fb->format->cpp[0] * 8,
+						  target_fb->format->bpp[0],
 						  tile_split);
 					return -EINVAL;
 				}
 
 				num_banks = (rdev->config.cik.macrotile_mode_array[index] >> 6) & 0x3;
 			} else {
-				switch (target_fb->format->cpp[0] * 8) {
+				switch (target_fb->format->bpp[0]) {
 				case 8:
 					index = 10;
 					break;
@@ -1423,7 +1423,7 @@ static int dce4_crtc_do_set_base(struct drm_crtc *crtc,
 	WREG32(EVERGREEN_GRPH_X_END + radeon_crtc->crtc_offset, target_fb->width);
 	WREG32(EVERGREEN_GRPH_Y_END + radeon_crtc->crtc_offset, target_fb->height);
 
-	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->cpp[0];
+	fb_pitch_pixels = target_fb->pitches[0] / (target_fb->format->bpp[0] / 8);
 	WREG32(EVERGREEN_GRPH_PITCH + radeon_crtc->crtc_offset, fb_pitch_pixels);
 	WREG32(EVERGREEN_GRPH_ENABLE + radeon_crtc->crtc_offset, 1);
 
@@ -1639,7 +1639,7 @@ static int avivo_crtc_do_set_base(struct drm_crtc *crtc,
 	WREG32(AVIVO_D1GRPH_X_END + radeon_crtc->crtc_offset, target_fb->width);
 	WREG32(AVIVO_D1GRPH_Y_END + radeon_crtc->crtc_offset, target_fb->height);
 
-	fb_pitch_pixels = target_fb->pitches[0] / target_fb->format->cpp[0];
+	fb_pitch_pixels = target_fb->pitches[0] / (target_fb->format->bpp[0] / 8);
 	WREG32(AVIVO_D1GRPH_PITCH + radeon_crtc->crtc_offset, fb_pitch_pixels);
 	WREG32(AVIVO_D1GRPH_ENABLE + radeon_crtc->crtc_offset, 1);
 
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 7089dfc..85b3081 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -3229,7 +3229,7 @@ void r100_bandwidth_update(struct radeon_device *rdev)
 			rdev->mode_info.crtcs[0]->base.primary->fb;
 
 		mode1 = &rdev->mode_info.crtcs[0]->base.mode;
-		pixel_bytes1 = fb->format->cpp[0];
+		pixel_bytes1 = fb->format->bpp[0] / 8;
 	}
 	if (!(rdev->flags & RADEON_SINGLE_CRTC)) {
 		if (rdev->mode_info.crtcs[1]->base.enabled) {
@@ -3237,7 +3237,7 @@ void r100_bandwidth_update(struct radeon_device *rdev)
 				rdev->mode_info.crtcs[1]->base.primary->fb;
 
 			mode2 = &rdev->mode_info.crtcs[1]->base.mode;
-			pixel_bytes2 = fb->format->cpp[0];
+			pixel_bytes2 = fb->format->bpp[0] / 8;
 		}
 	}
 
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index e81b01f..066202c 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -540,19 +540,19 @@ static int radeon_crtc_page_flip_target(struct drm_crtc *crtc,
 	if (!ASIC_IS_AVIVO(rdev)) {
 		/* crtc offset is from display base addr not FB location */
 		base -= radeon_crtc->legacy_display_base_addr;
-		pitch_pixels = fb->pitches[0] / fb->format->cpp[0];
+		pitch_pixels = fb->pitches[0] / fb->format->bpp[0] / 8;
 
 		if (tiling_flags & RADEON_TILING_MACRO) {
 			if (ASIC_IS_R300(rdev)) {
 				base &= ~0x7ff;
 			} else {
-				int byteshift = fb->format->cpp[0] * 8 >> 4;
+				int byteshift = fb->format->bpp[0] >> 4;
 				int tile_addr = (((crtc->y >> 3) * pitch_pixels +  crtc->x) >> (8 - byteshift)) << 11;
 				base += tile_addr + ((crtc->x << byteshift) % 256) + ((crtc->y % 8) << 8);
 			}
 		} else {
 			int offset = crtc->y * pitch_pixels + crtc->x;
-			switch (fb->format->cpp[0] * 8) {
+			switch (fb->format->bpp[0]) {
 			case 8:
 			default:
 				offset *= 1;
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 2c564f4..5c6057f 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -138,7 +138,7 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
 	u32 cpp;
 
 	info = drm_get_format_info(rdev->ddev, mode_cmd);
-	cpp = info->cpp[0];
+	cpp = info->bpp[0] / 8;
 
 	/* need to align pitch with crtc limits */
 	mode_cmd->pitches[0] = radeon_align_pitch(rdev, mode_cmd->width, cpp,
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
index a1985a5..21f6b25 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
@@ -400,7 +400,7 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
 	else
 		target_fb = crtc->primary->fb;
 
-	switch (target_fb->format->cpp[0] * 8) {
+	switch (target_fb->format->bpp[0]) {
 	case 8:
 		format = 2;
 		break;
@@ -474,9 +474,9 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
 
 	crtc_offset_cntl = 0;
 
-	pitch_pixels = target_fb->pitches[0] / target_fb->format->cpp[0];
-	crtc_pitch = DIV_ROUND_UP(pitch_pixels * target_fb->format->cpp[0] * 8,
-				  target_fb->format->cpp[0] * 8 * 8);
+	pitch_pixels = target_fb->pitches[0] / target_fb->format->bpp[0] / 8;
+	crtc_pitch = DIV_ROUND_UP(pitch_pixels * target_fb->format->bpp[0],
+				  target_fb->format->bpp[0] * 8);
 	crtc_pitch |= crtc_pitch << 16;
 
 	crtc_offset_cntl |= RADEON_CRTC_GUI_TRIG_OFFSET_LEFT_EN;
@@ -501,14 +501,14 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
 			crtc_tile_x0_y0 = x | (y << 16);
 			base &= ~0x7ff;
 		} else {
-			int byteshift = target_fb->format->cpp[0] * 8 >> 4;
+			int byteshift = target_fb->format->bpp[0] >> 4;
 			int tile_addr = (((y >> 3) * pitch_pixels +  x) >> (8 - byteshift)) << 11;
 			base += tile_addr + ((x << byteshift) % 256) + ((y % 8) << 8);
 			crtc_offset_cntl |= (y % 16);
 		}
 	} else {
 		int offset = y * pitch_pixels + x;
-		switch (target_fb->format->cpp[0] * 8) {
+		switch (target_fb->format->bpp[0]) {
 		case 8:
 			offset *= 1;
 			break;
@@ -599,7 +599,7 @@ static bool radeon_set_crtc_timing(struct drm_crtc *crtc, struct drm_display_mod
 		}
 	}
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 		format = 2;
 		break;
-- 
2.7.4



