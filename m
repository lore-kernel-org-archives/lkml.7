Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA4C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DD321773
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UumO8T4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfHADpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38107 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbfHADpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so24455538pgu.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=565VaDK+D7HMx0tprEDJj/7+3RMbouv2sqfsU1m6AlI=;
        b=UumO8T4UFAhCGi2wV38MNxrxfoIXcvUhLIo+UDwQbHXJpPiR1UpNWfYhB56019xFWv
         omPeb7ZqVe6yVp2nQPcZ6ApLQuQP1OSiGXWpFkVVlcdbk6Cq07J2GzD46js/3ly8+xKv
         srjdVWGisDzNusPt2Uh2q0Ac+6ctEDx/QnIay++h5EihedQ/M/mEscL8pYbF8lbrUnpa
         I1tCZh+FL1GAVGLbG7zfNrvVd6tkPg7bT2qDqe3sDyjKnY9YGuKlhpcKhkYVlB2y2Xdf
         IGFLZpZU6+n0khrwqrwxZYIHFYm25OTwJ57mZSoMJz8esPYKZ6RcX8wC7VYsDaqBezDq
         pMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=565VaDK+D7HMx0tprEDJj/7+3RMbouv2sqfsU1m6AlI=;
        b=jH+Yf6g7LHT/OBWn5cGgdqvtmNHZwSzPbgl6LMdZjEWFXxg434APplk66tl9txDjw1
         8JqLnMgmG7RcoRryxMvzfFzsc/2mbv6dTAK8ZhqiSbs3BzuhSyBFxfVZeNhuyviB0aPz
         l/cArwc3sNo0vl6dZGPuij3x6YlZJQ86mOvZ8y5c1+wDsuFLRu2Oq9C9hDMtlEubVF9p
         l4Aat7tu5/UXMQcdK8b7Mknm58PiNwZsnqpmOYY8M5VMXY6dUncoWMQ3KGGijkztWiGJ
         LSC7iFycXRh4+bBc+TI+d/ka1JpQoHHEDml8OzG2ulaP7dbwU1QdOBC97Lc1EVUeZmkG
         vieA==
X-Gm-Message-State: APjAAAW5mFT5yKzPBvlFruOWeP4p4fBvwOLWPXpQylAG6O6NQB+5z57e
        uPic8q2tgTyd+Z6wcxl8dk9lOJm8rHo=
X-Google-Smtp-Source: APXvYqwGXw9jt9IUIQGF91k5z+BPfxgzP6NG+ZKR5TjWGB9fSyX1i6ISydNH+lA0AFfhosDJiT66CQ==
X-Received: by 2002:a62:1515:: with SMTP id 21mr52131943pfv.100.1564631110569;
        Wed, 31 Jul 2019 20:45:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:09 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 16/26] drm: kirin: Move mode config function to driver_data
Date:   Thu,  1 Aug 2019 03:44:29 +0000
Message-Id: <20190801034439.98227-17-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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

