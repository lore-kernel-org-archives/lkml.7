Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734EBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48565238C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567527970;
	bh=j4U6Ljf6O8MuuDNBh0JD/FTMKkRy5XfBCdGOCI5OmOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pb6A77UpNq0+JhbZsWxHFu+uzn7a62XKSk4pBlLX7eL92kCuXhsEk+cnw4qsbHnDH
	 s5Z6FA5Si1rOlYTeii0DX09PK20oXh4p2FtANnmG7W6Cp5Lnp6ZBWS2gGaa/vgAksY
	 FA7yCVDboltrbLzEZEyUb9tW6R5A3rAzakRjr1oE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfICQ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfICQZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:25:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DFD2343A;
        Tue,  3 Sep 2019 16:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527952;
        bh=j4U6Ljf6O8MuuDNBh0JD/FTMKkRy5XfBCdGOCI5OmOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjqJpx0pChAiv26AZgrp2JFSRchiyz2tduBiAVRFtf9EcAnBLWaOOebesqW/8+NYC
         EZZ7rP0xHAAhp7DurgqYX7PGqRmIaIEw2tRxj2KoSzG0c6AydKmsASvxZsBbNcRsVH
         /uBRXRBztNqNo6FatH4A9rcKP8SoWYJJaZCYivZ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>, ronald@innovation.ch,
        Sasha Levin <sashal@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 018/167] drm/i915/gen9+: Fix initial readout for Y tiled framebuffers
Date:   Tue,  3 Sep 2019 12:22:50 -0400
Message-Id: <20190903162519.7136-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit 914a4fd8cd28016038ce749a818a836124a8d270 ]

If BIOS configured a Y tiled FB we failed to set up the backing object
tiling accordingly, leading to a lack of GT fence installed and a
garbled console.

The problem was bisected to
commit 011f22eb545a ("drm/i915: Do NOT skip the first 4k of stolen memory for pre-allocated buffers v2")
but it just revealed a pre-existing issue.

Kudos to Ville who suspected a missing fence looking at the corruption
on the screen.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: <ronald@innovation.ch>
Cc: <stable@vger.kernel.org>
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reported-by: <ronald@innovation.ch>
Tested-by: <ronald@innovation.ch>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108264
Fixes: bc8d7dffacb1 ("drm/i915/skl: Provide a Skylake version of get_plane_config()")
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181016160011.28347-1-imre.deak@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/intel_display.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index f5367bdc04049..2622dfc7d2d9a 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -2712,6 +2712,17 @@ intel_alloc_initial_plane_obj(struct intel_crtc *crtc,
 	if (size_aligned * 2 > dev_priv->stolen_usable_size)
 		return false;
 
+	switch (fb->modifier) {
+	case DRM_FORMAT_MOD_LINEAR:
+	case I915_FORMAT_MOD_X_TILED:
+	case I915_FORMAT_MOD_Y_TILED:
+		break;
+	default:
+		DRM_DEBUG_DRIVER("Unsupported modifier for initial FB: 0x%llx\n",
+				 fb->modifier);
+		return false;
+	}
+
 	mutex_lock(&dev->struct_mutex);
 	obj = i915_gem_object_create_stolen_for_preallocated(dev_priv,
 							     base_aligned,
@@ -2721,8 +2732,17 @@ intel_alloc_initial_plane_obj(struct intel_crtc *crtc,
 	if (!obj)
 		return false;
 
-	if (plane_config->tiling == I915_TILING_X)
-		obj->tiling_and_stride = fb->pitches[0] | I915_TILING_X;
+	switch (plane_config->tiling) {
+	case I915_TILING_NONE:
+		break;
+	case I915_TILING_X:
+	case I915_TILING_Y:
+		obj->tiling_and_stride = fb->pitches[0] | plane_config->tiling;
+		break;
+	default:
+		MISSING_CASE(plane_config->tiling);
+		return false;
+	}
 
 	mode_cmd.pixel_format = fb->format->format;
 	mode_cmd.width = fb->width;
@@ -8812,6 +8832,7 @@ skylake_get_initial_plane_config(struct intel_crtc *crtc,
 		fb->modifier = I915_FORMAT_MOD_X_TILED;
 		break;
 	case PLANE_CTL_TILED_Y:
+		plane_config->tiling = I915_TILING_Y;
 		if (val & PLANE_CTL_RENDER_DECOMPRESSION_ENABLE)
 			fb->modifier = I915_FORMAT_MOD_Y_TILED_CCS;
 		else
-- 
2.20.1

