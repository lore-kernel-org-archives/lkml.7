Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE32EC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC1D216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDJ24+fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfHNSre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45028 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbfHNSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so5091699pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7xmifYrtKTPY0d7eMeK1iDayOhz0vPlAHH86GCYxNMs=;
        b=MDJ24+fbIYI2njKcl0UW8QdPWZN8z1ATr0nx6vvAzkELs6AP29eMQJTHu8d0g96Q4b
         UuPmYWS7jw2bXtpk7W6DFFP8vlkWnvmGPPh88msA1DwYuIx8y+I1kq1Njcfp8yMRH8c9
         N70+9g6ljOKsaJp9uEPGm/jwV5vbNlU5x6TOs8nb1Ien0pW9XgJDNFRl6FwxEx1hspc9
         ntZABvazZYTCa4WQVeQ/ybz/jr1nv5NlWW9bKAa/RL4g0UaiOb+brObMbjFFd3SO/K6S
         XWlksBKNIl0pRalg9v/j3jCsHpMMWD5yTdWY2GyvgUAJOH+6CQMBVp+zP4BCWVCPHUGs
         R9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7xmifYrtKTPY0d7eMeK1iDayOhz0vPlAHH86GCYxNMs=;
        b=Ju2w/zyM/xWTXSUKNdB+pRS0UET3kOuDqdzsJra1cZkC5AaYUYNGE2IaM6NCz9odzq
         FkKhTm6FMH+n3R05xJIJ10sygQj3OSlphdqcn1M2k2aoTGKV8/KqjUhvcNO73RvFaXmo
         eZyQgRWeqB9Fg8UXRyEEdlW8pPLiwrbetWU+bjVzetCnPSgJsrS99Sw8FyDjx7fDqPE1
         Gup2O/oxc/GXaAig5oHWiDMr8fjXA99tLQaNCG3+YP/ZrG9lZd0vrzUh/RbjqP1yfYc5
         6qb5JbstyZmxyhpc8qzaybVO/c0FcUw53ucC43fUXbkJeadwyPkYT9hArApNfmTVhi5p
         zu1Q==
X-Gm-Message-State: APjAAAVc/13UBog19suZU4egJBsCByHTDZHelC6ztYGnIQKSckzbwt/z
        wplnqmCr1zFeiFHyapU6bdPZcwbFkhY=
X-Google-Smtp-Source: APXvYqxW0U5tK9Ms1Ev3Ni5SJx77as/7G+tySsw0so+NqkPxOdCRIc7atSRk9kaGa7tKOVtfUzh7YQ==
X-Received: by 2002:aa7:9790:: with SMTP id o16mr1419890pfp.51.1565808451659;
        Wed, 14 Aug 2019 11:47:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:30 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 16/26] drm: kirin: Move mode config function to driver_data
Date:   Wed, 14 Aug 2019 18:46:52 +0000
Message-Id: <20190814184702.54275-17-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 10 ++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c |  8 +-------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 99dfd15af771..bca080e14009 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -30,6 +30,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
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
index 60c164623f56..bf1e601fb367 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -39,12 +39,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
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
@@ -53,7 +47,7 @@ static void kirin_drm_mode_config_init(struct drm_device *dev)
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

