Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74DBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F2A23406
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIK1wiCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfHSXDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34034 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfHSXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so2044450pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2NFlgdlfXYiRYG1vxux+gKs5v2QugFjbBoZ8Pynyolg=;
        b=mIK1wiCGCfCbW9eeYKsjGhEfiwX87TUJabWOr/z7riNobTnag2/wiOzDocjjPydHwk
         MHz7laeYwFopBqLOhN+pbIqU4csA2GjPSK+tnZ4KyZoz59wWajqDy9W5AkNjXNuIVQuX
         bjxvFHTVH7cEdxB+a7/i5rxeGf3k6Nxy8P9s3JmIxF/mBOzjXNiwFyTiSowA1cPRXJqC
         ULqerCtuQtvQjug5pS5mdfYhX0M/m4u7m3z8eZaZVYlrsaCQz53DrklKlBKInbP40o0l
         3hAIviRyvG7f+95YRh5I6MEUEkjll7Bh0iKStDESsJABXxXjjFkQA1mn24z7wQYbM2wb
         5UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2NFlgdlfXYiRYG1vxux+gKs5v2QugFjbBoZ8Pynyolg=;
        b=GNvFLf/BOeIL+GUGRWCWB4Ma98Y36hGZ+GL0cw2LyjUw5Jftrs/PVdw1QAk8k+PhTd
         FldCkb3sIfsRhTejsCucncr2s5mNx2TuBBZluwR4u6pGrANBJHiXOateLJ5Tzyx9EayE
         mKzwiSvodYRItYIs3OMeGkwXIRo2RxKsYZ+NaiXdb7VoHX6494O9gUTPt1dN1jigPk9H
         1pjejkh28DBHs5z75EpCqEKfWJbx3lzO/va+4BHTsHQEpu4hj1Xe8Mkd9lmCB1o6oAAK
         StLsLBun/raYRz/55qW+ZMcEh0jhVGHDAr+UAjhreV0J6GrDLe2GhogdW42zVN8C0frc
         hTaQ==
X-Gm-Message-State: APjAAAVkpGlSSnDXyvsuFzOcvibVRFPxNCSjbN2SpOtywUXrn3LK1+/9
        SBDqyYR9GrPNIZ5DlpTvrT1nv8txWtQ=
X-Google-Smtp-Source: APXvYqxGlTATZutwqllpn0Cdq6dR8Gqs5Xkn+OaYXid2MpAdEyXcQQ11zpaOyj6EORGBwrrjFzG+hA==
X-Received: by 2002:a17:90a:650c:: with SMTP id i12mr23034754pjj.11.1566255828114;
        Mon, 19 Aug 2019 16:03:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:47 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v4 15/25] drm: kirin: Move mode config function to driver_data
Date:   Mon, 19 Aug 2019 23:03:11 +0000
Message-Id: <20190819230321.56480-16-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the mode config
initialization values into the kirin_drm_data structure.

This will make it easier to add support for new devices
via a new kirin_drm_data structure.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 10 ++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c |  8 +-------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index cf542430a659..4001f060e580 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -30,6 +30,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 
 #include "kirin_drm_drv.h"
 #include "kirin_ade_reg.h"
@@ -1038,6 +1039,13 @@ static void ade_drm_cleanup(struct platform_device *pdev)
 {
 }
 
+static const struct drm_mode_config_funcs ade_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+
+};
+
 struct kirin_drm_data ade_driver_data = {
 	.channel_formats = channel_formats,
 	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
@@ -1045,6 +1053,8 @@ struct kirin_drm_data ade_driver_data = {
 	.crtc_funcs = &ade_crtc_funcs,
 	.plane_helper_funcs = &ade_plane_helper_funcs,
 	.plane_funcs = &ade_plane_funcs,
+	.mode_config_funcs = &ade_mode_config_funcs,
+
 	.init = ade_drm_init,
 	.cleanup = ade_drm_cleanup
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 3d22f944a840..25191824b64e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -40,12 +40,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 	return 0;
 }
 
-static const struct drm_mode_config_funcs kirin_drm_mode_config_funcs = {
-	.fb_create = drm_gem_fb_create,
-	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = drm_atomic_helper_commit,
-};
-
 static void kirin_drm_mode_config_init(struct drm_device *dev)
 {
 	dev->mode_config.min_width = 0;
@@ -54,7 +48,7 @@ static void kirin_drm_mode_config_init(struct drm_device *dev)
 	dev->mode_config.max_width = 2048;
 	dev->mode_config.max_height = 2048;
 
-	dev->mode_config.funcs = &kirin_drm_mode_config_funcs;
+	dev->mode_config.funcs = driver_data->mode_config_funcs;
 }
 
 static int kirin_drm_kms_init(struct drm_device *dev)
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 66916502a9e6..ce9ddccc67a8 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -42,7 +42,7 @@ struct kirin_drm_data {
 	const struct drm_crtc_funcs *crtc_funcs;
 	const struct drm_plane_helper_funcs *plane_helper_funcs;
 	const struct drm_plane_funcs  *plane_funcs;
-
+	const struct drm_mode_config_funcs *mode_config_funcs;
 	int (*init)(struct platform_device *pdev);
 	void (*cleanup)(struct platform_device *pdev);
 };
-- 
2.17.1

