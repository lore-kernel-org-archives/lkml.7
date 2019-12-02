Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB43C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558EA2071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tE/RcnU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLBVrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:47:19 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:48745 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfLBVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:47:19 -0500
Received: by mail-pj1-f73.google.com with SMTP id o34so683588pjb.15
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tv65YlSAEZ1AZ+C4f4YFmN8tMU2gW3K2G0SFIfpGo5w=;
        b=tE/RcnU/Tvs1iYlFu2Unv7wP+KcRQ91eUfJ3vfGXaR5pAdi8cPvE8FOFEVSckFR72q
         znSv5yLFeZxCGbacYocTlBH/DXMQA181wWTKbDu/39cT0ezfhb/VEHLPSfx4zvQYc5Ts
         +aKEQVn/mw/ntsiSVaiueR3CFPuhwpx7eJlG5V3Vp/Uscvc5PkrDEGOz+VTWlfKOdfLj
         hvyY9TJzTmD8YnhbFE2xKTS8TOpfNCzS0VUUnFzHL1hlVQIFQ/Gd/wu6Ev6QkfpJNwfc
         MRKIC9UZDmqe2rfEvF5lh4C3nH3mTgNyIKOs3yx5NWAY6zKtU01v3wzxtKLoCfx5/JMf
         rNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tv65YlSAEZ1AZ+C4f4YFmN8tMU2gW3K2G0SFIfpGo5w=;
        b=lm7wPKI99BCxpn+T7gRxWFynyes/q6hyV41Omdw12o9wrcBMu7Ylk0+wfc/KiIabvc
         d73bqN+lRG1yTsy6F5U8e+JWTTcwbJEFxO4aPlgRDlchpoVADz7FAVw8vFKBKa1liSvh
         vG4rTIDiW9X0lxHJgSjfaL2RMEma7xRernJYUEvZZd+SvzGhgq6BV6iHxHTYv+CbEzn3
         3nrRwfPE47kBqL8uOjouXtMJRojGzU7CjfW6ebzYlWtQiOgJiPL/WlaN5p8js5FrzyFj
         HbEQgFfO5wuQv8BOaatXnrEF4cQ0kEMlO1/PoSZgN+duP7F/30cV+D28xq9+zy6iRC0a
         n/vQ==
X-Gm-Message-State: APjAAAVDBK3eWzRbBgILkQlIp2gcEsdzsquyOQXvS66P6eHvhhaf39QG
        baK80k+ZBi2orsJbUiUFDR082hFfsDHYNOF2ORTePg==
X-Google-Smtp-Source: APXvYqxjercgrhFvw26C7tu67vRuvMwVkhb7I8GvZqDMrQzPa9NbsLse2rcZx9gOQDCneeLM95WwPRQFSasGSNTrSvEx5Q==
X-Received: by 2002:a63:d66:: with SMTP id 38mr1323627pgn.233.1575323238172;
 Mon, 02 Dec 2019 13:47:18 -0800 (PST)
Date:   Mon,  2 Dec 2019 13:47:13 -0800
Message-Id: <20191202214713.41001-1-thomasanderson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2] drm/amd/display: Reduce HDMI pixel encoding if max clock
 is exceeded
From:   Thomas Anderson <thomasanderson@google.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Anderson <thomasanderson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For high-res (8K) or HFR (4K120) displays, using uncompressed pixel
formats like YCbCr444 would exceed the bandwidth of HDMI 2.0, so the
"interesting" modes would be disabled, leaving only low-res or low
framerate modes.

This change lowers the pixel encoding to 4:2:2 or 4:2:0 if the max TMDS
clock is exceeded. Verified that 8K30 and 4K120 are now available and
working with a Samsung Q900R over an HDMI 2.0b link from a Radeon 5700.

Signed-off-by: Thomas Anderson <thomasanderson@google.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7aac9568d3be..803e59d97411 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3356,27 +3356,21 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
 	return color_space;
 }
 
-static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
-{
-	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
-		return;
-
-	timing_out->display_color_depth--;
-}
-
-static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
-						const struct drm_display_info *info)
+static bool adjust_colour_depth_from_display_info(
+	struct dc_crtc_timing *timing_out,
+	const struct drm_display_info *info)
 {
+	enum dc_color_depth depth = timing_out->display_color_depth;
 	int normalized_clk;
-	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
-		return;
 	do {
 		normalized_clk = timing_out->pix_clk_100hz / 10;
 		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
 		if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
 			normalized_clk /= 2;
 		/* Adjusting pix clock following on HDMI spec based on colour depth */
-		switch (timing_out->display_color_depth) {
+		switch (depth) {
+		case COLOR_DEPTH_888:
+			break;
 		case COLOR_DEPTH_101010:
 			normalized_clk = (normalized_clk * 30) / 24;
 			break;
@@ -3387,14 +3381,15 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
 			normalized_clk = (normalized_clk * 48) / 24;
 			break;
 		default:
-			return;
+			/* The above depths are the only ones valid for HDMI. */
+			return false;
 		}
-		if (normalized_clk <= info->max_tmds_clock)
-			return;
-		reduce_mode_colour_depth(timing_out);
-
-	} while (timing_out->display_color_depth > COLOR_DEPTH_888);
-
+		if (normalized_clk <= info->max_tmds_clock) {
+			timing_out->display_color_depth = depth;
+			return true;
+		}
+	} while (--depth > COLOR_DEPTH_666);
+	return false;
 }
 
 static void fill_stream_properties_from_drm_display_mode(
@@ -3474,8 +3469,14 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
-	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		adjust_colour_depth_from_display_info(timing_out, info);
+	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
+		    drm_mode_is_420_also(info, mode_in) &&
+		    timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+			adjust_colour_depth_from_display_info(timing_out, info);
+		}
+	}
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
-- 
2.24.0.393.g34dc348eaf-goog

