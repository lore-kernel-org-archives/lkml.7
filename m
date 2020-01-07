Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7B2C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01882081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSmeJOVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAGU27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:28:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40388 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgAGU27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:28:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so419545pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 12:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sjJ0uVz+2aygb69iiy5pJizL3B57FBYYiTtW4flheNU=;
        b=oSmeJOVJtz+EN6rqqOaJkUZ6gXxhmTzLCY2aUIKhBsSgNpwJVw3T17si3KBwsGUWso
         jduwUbPhlRdH93NKbsPt3m0n5uT9BgVgz0I9O7TA33v0XLrkjAoR5QBtuvXC9Z4hGFDb
         XIElsFMjIKYeRMLv21bbkDk6PWmurzzZhAe+C2y6v8ULniYclzNRCGr+s0RZbB69y3Ev
         9uFAHX6S0dYygPC2dKO4JjI7jFrdOA5D0P2lJxRD9lkD7S0i9dh5rkI6sL7iel/TkGN4
         /CpemFgsdssmvGCV+lGYsqrmVs9W5VRhC0IyWfniZztDESth4f02zvtRhsJqHNx0YhD2
         m+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sjJ0uVz+2aygb69iiy5pJizL3B57FBYYiTtW4flheNU=;
        b=ZnFaTZWa7aTsjUAxn3ErAEKixUtrVsZdEwlbc6oqqq+fZQq7I9RGEVXZhvEZGgdIt4
         LdFfASPlyqdXSOp9fGsz7ymIX5ZVudYV9Odx31UNWGEDs9rPTDISx82aMtkQd+I7iNXB
         2UnzK/kcpIes3Y5H94r9JyTgbHqEC3jHiMzM8mZvPfLfPyDHpWDChRSDfLSibvOOxobO
         RXMj9qpFe4qUNFmC7MvQ/5piAcoRtTZ10e4ABAV+vJNSx9CT8PUJHmogOuO20d+RiK22
         1FhGbD22E4+g0mUQ+cDIjRE4xcZsaXVed67x2y1QEIop2uz4VVbu69RKxKk/bocLVYJ7
         7WwA==
X-Gm-Message-State: APjAAAXoqeRpApE396k78sFz8HyHREVvJp1WsqBH8+SRQsxdkt0OjMWP
        /nc1pzLHiXmGeU1SvSaa6ZyV9qceUCs=
X-Google-Smtp-Source: APXvYqwEAN+GHayhfNfvNeQhmIvj2S/s9WBDSVe1DPPR2BH02UA4TWxlx+H1YxvcBlhuAl1xBjBL/g==
X-Received: by 2002:a62:b418:: with SMTP id h24mr1178771pfn.192.1578428938618;
        Tue, 07 Jan 2020 12:28:58 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id x33sm578934pga.86.2020.01.07.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 12:28:57 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH] drm: msm: Quiet down plane errors in atomic_check
Date:   Tue,  7 Jan 2020 20:28:52 +0000
Message-Id: <20200107202852.55819-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the db845c running AOSP, I see the following error on every
frame on the home screen:
  [drm:dpu_plane_atomic_check:915] [dpu error]plane33 invalid src 2880x1620+0+470 line:2560

This is due to the error paths in atomic_check using
DPU_ERROR_PLANE(), and the drm_hwcomposer using atomic_check
to decide how to composite the frame (thus it expects to see
atomic_check to fail).

In order to avoid spamming the logs, this patch converts the
DPU_ERROR_PLANE() calls to DPU_DEBUG_PLANE() calls in
atomic_check.

Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 58d5acbcfc5c..d19ae0b51d1c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -858,7 +858,7 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 					  pdpu->pipe_sblk->maxupscale << 16,
 					  true, true);
 	if (ret) {
-		DPU_ERROR_PLANE(pdpu, "Check plane state failed (%d)\n", ret);
+		DPU_DEBUG_PLANE(pdpu, "Check plane state failed (%d)\n", ret);
 		return ret;
 	}
 	if (!state->visible)
@@ -884,13 +884,13 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 		(!(pdpu->features & DPU_SSPP_SCALER) ||
 		 !(pdpu->features & (BIT(DPU_SSPP_CSC)
 		 | BIT(DPU_SSPP_CSC_10BIT))))) {
-		DPU_ERROR_PLANE(pdpu,
+		DPU_DEBUG_PLANE(pdpu,
 				"plane doesn't have scaler/csc for yuv\n");
 		return -EINVAL;
 
 	/* check src bounds */
 	} else if (!dpu_plane_validate_src(&src, &fb_rect, min_src_size)) {
-		DPU_ERROR_PLANE(pdpu, "invalid source " DRM_RECT_FMT "\n",
+		DPU_DEBUG_PLANE(pdpu, "invalid source " DRM_RECT_FMT "\n",
 				DRM_RECT_ARG(&src));
 		return -E2BIG;
 
@@ -899,19 +899,19 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 		   (src.x1 & 0x1 || src.y1 & 0x1 ||
 		    drm_rect_width(&src) & 0x1 ||
 		    drm_rect_height(&src) & 0x1)) {
-		DPU_ERROR_PLANE(pdpu, "invalid yuv source " DRM_RECT_FMT "\n",
+		DPU_DEBUG_PLANE(pdpu, "invalid yuv source " DRM_RECT_FMT "\n",
 				DRM_RECT_ARG(&src));
 		return -EINVAL;
 
 	/* min dst support */
 	} else if (drm_rect_width(&dst) < 0x1 || drm_rect_height(&dst) < 0x1) {
-		DPU_ERROR_PLANE(pdpu, "invalid dest rect " DRM_RECT_FMT "\n",
+		DPU_DEBUG_PLANE(pdpu, "invalid dest rect " DRM_RECT_FMT "\n",
 				DRM_RECT_ARG(&dst));
 		return -EINVAL;
 
 	/* check decimated source width */
 	} else if (drm_rect_width(&src) > max_linewidth) {
-		DPU_ERROR_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u\n",
+		DPU_DEBUG_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u\n",
 				DRM_RECT_ARG(&src), max_linewidth);
 		return -E2BIG;
 	}
-- 
2.17.1

