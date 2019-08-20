Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346F4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2531233A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpmUoFqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfHTXG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43450 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfHTXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so211187pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NvRBTkEpcrR5Rep8edui09Pbrs4gwjsFcJ1vUHe92C8=;
        b=SpmUoFqTQ+QJ0g9hL7qgwe495wxUfIF5aJWDRv8mSGtUIbWZzEoSG+rlz9UkFpecSy
         /0C7WUsQ44Y05xaq68bMfODCQWQ124ezsD9PsPxx8LQvOKarjb1trxJuayJiEJG4Ds8X
         eVCL3EiK8jPXMqsNg1hln1fi116iayO8WR21flpsPW9o9Dvb9h4kX6d1OMYPbxjt1Jb3
         PvD30Eb2rT0BAkR2GNDkO7kuW7tdX2G3epYPLwPZ2+TY9gmuvxa8xO/VrzdyvOVN4Bxm
         3LlBwM03+GBOB/X/kGUx4hvq/zCruqoIM3dTxfX+4MT9ka2Q3BjWShFP8pE4+WB5JGpv
         X47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NvRBTkEpcrR5Rep8edui09Pbrs4gwjsFcJ1vUHe92C8=;
        b=NuqPuS76h4BWWm4ayV4xJ1PaqbGuao0MxJ5reX5fRJ56+flxAfy+e0U1vKI9ooHkn0
         N7kPPL1RlY8gRV7fblj6uebPNni0tuLg0tACMzat3Xpjj6e9RK8xESfgTqc5KhAMTNJx
         UEItZvPChm0hk5CNM6z7EuSlYTknqProSXQstjTemjntIcHBoDXwkV0/+Oximv/G+axY
         ma1id9svHl1b+qeUGQj5ilcLD5Ebghoo4vLK+r7ELk82nYJDH/rNbrLawgVU0HU+8rlL
         P9F13qnUf67yn31troccvfqy/M2I+fsCqulAyk3D80rDVVmtbQnzPWTEPMG05TzNhtVY
         gyDg==
X-Gm-Message-State: APjAAAVdFXyvNmvJvt77Us3RvPAXXHRFtZwZR8MfBJBqXl633Gm8F4vN
        r56FXP0ed3K6kIvbzgcfBTBR2oQFVNI=
X-Google-Smtp-Source: APXvYqxk1+RpZrPxlzUTPywKtSA/GrnBztJYlBYhotscSB7kHX9LZWOXAZRnLh+wBMuGbZ8bR4CLNw==
X-Received: by 2002:a17:902:41:: with SMTP id 59mr8508124pla.268.1566342411457;
        Tue, 20 Aug 2019 16:06:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:50 -0700 (PDT)
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
Subject: [PATCH v5 15/25] drm: kirin: Move mode config function to driver_data
Date:   Tue, 20 Aug 2019 23:06:16 +0000
Message-Id: <20190820230626.23253-16-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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
index 0489b6378e01..94d74c467a81 100644
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

