Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA701C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 05:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3A42070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 05:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPue6pH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKWF3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 00:29:06 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50177 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWF3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 00:29:05 -0500
Received: by mail-pf1-f201.google.com with SMTP id e13so5699736pff.17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 21:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bVyv4YX7sBcmbg/cjO2xV4ng37xlI4Fx14aOVCg/YPk=;
        b=IPue6pH+iGFcyTATyXECvU11P2erhBngc5DZDw11DE48T3vmrNrq3F/wuawLSgPQS8
         uAeMHCTJgtnFhivGAdK4UJdOvjZSSSqf8AUr5PEJVudhYEHTdTOtwzFL20vc96kkNn+X
         3DUz6HFHP+idBPxiFTl9yALA7j71nWC8lCZJPo65yjXErrbFZjlZA+30+pimC9oFmjRR
         IG2ISB2Ah3gctyeBATexyLgYHYVnYW1euFzZLOT10vAogI0L8dTou99IJtiIpQmalROi
         kuVR4o/5csF44JRTjcb+pBKbrh96WXRg04ta3T99TBtzrOfzhV1rnLnbKIR8FIeoTHBB
         BozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bVyv4YX7sBcmbg/cjO2xV4ng37xlI4Fx14aOVCg/YPk=;
        b=PHX57AVil3YMbJ3zhgOUn0YwAJLmrQQbQEAMcSiP53TfvZP4VB5IZWkh/dblYFCQb+
         CMgTh3C8GxnhRqBmsftSaC1SI9U1wbCHRDsL1oWFL8/tUvI24gQToR+FZh+CMRFKNC/9
         XEH3Xvq8itbzNGHr1zx9mQVE2X2KHpngq4a7POEE5rah0ZhmJ6pMTbSyB8kccb06kmFl
         ry+HEWM53jOoSVuORsxUsgCFoStzLM1yw76Wr8Cmb7QIACmOoMXsUk6Wn7ARdCrKy6PM
         xYXrl3BB7LmHyYf8nS97Kj45mAJ2E5QJydXQP+QMMI9ktCGoOs8CtdpTk9+gsNr7Q4wY
         tO3w==
X-Gm-Message-State: APjAAAU4+PAgQQ1CQHmY/sNujTcn5EA/ztRGDCl+DvCZ0VJ9icxab3Th
        Z07ZCHSyVPiHkJu7njYAekxuhAkd9jNQ2tkMIc+mLQ==
X-Google-Smtp-Source: APXvYqxjRM9ai1CA9dNK82G+vFlip7YVCLCIXbLIH1Csg4LCLSDnDb0tkEU778iwITRS6ZGh5nPtALd01sCBSgOx+P7pbA==
X-Received: by 2002:a63:368c:: with SMTP id d134mr19610973pga.321.1574486944440;
 Fri, 22 Nov 2019 21:29:04 -0800 (PST)
Date:   Fri, 22 Nov 2019 21:29:00 -0800
Message-Id: <20191123052900.77205-1-thomasanderson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] drm/amd/display: Reduce HDMI pixel encoding if max clock is exceeded
From:   Thomas Anderson <thomasanderson@google.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4139f129eafb..a507a6f04c82 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3269,13 +3269,15 @@ static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
 	timing_out->display_color_depth--;
 }
 
-static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
-						const struct drm_display_info *info)
+static void adjust_timing_from_display_info(
+	struct dc_crtc_timing *timing_out,
+	const struct drm_display_info *info,
+	const struct drm_display_mode *mode_in)
 {
 	int normalized_clk;
-	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
+	if (timing_out->display_color_depth < COLOR_DEPTH_888)
 		return;
-	do {
+	while (timing_out->display_color_depth > COLOR_DEPTH_888) {
 		normalized_clk = timing_out->pix_clk_100hz / 10;
 		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
 		if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
@@ -3297,9 +3299,23 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
 		if (normalized_clk <= info->max_tmds_clock)
 			return;
 		reduce_mode_colour_depth(timing_out);
+	}
 
-	} while (timing_out->display_color_depth > COLOR_DEPTH_888);
-
+	/* The color depth is 888 and cannot be reduced any further, but the
+	 * clock would still exceed the max tmds clock. Try reducing the pixel
+	 * encoding next.
+	 */
+	if (timing_out->pixel_encoding == PIXEL_ENCODING_RGB ||
+	    timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
+		/* YCBCR422 is always supported. */
+		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
+		normalized_clk = (timing_out->pix_clk_100hz * 3) / 40;
+		if (normalized_clk <= info->max_tmds_clock)
+			return;
+	}
+	/* YCBCR420 may only be supported on specific modes. */
+	if (drm_mode_is_420_also(info, mode_in))
+		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 }
 
 static void fill_stream_properties_from_drm_display_mode(
@@ -3366,7 +3382,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		adjust_colour_depth_from_display_info(timing_out, info);
+		adjust_timing_from_display_info(timing_out, info, mode_in);
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
-- 
2.24.0.432.g9d3f5f5b63-goog

