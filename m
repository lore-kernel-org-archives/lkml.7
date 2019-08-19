Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54806C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC2A22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWgmzgcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfHSXDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33500 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfHSXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so2048980pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yj68sd1eYwpU86YtcH+RSFue4gqH76sT4KzX/dwyzO0=;
        b=jWgmzgcM1i7NReZc5KCeo0QEYjt8aYxq4KuQ74NTGAlYRmuvYfF7LwkyS5FD/jBTQL
         OBgO+K8F+J8LV9REp0D4o5Dh2cXYJBL3QTEqYRBJhz9zzNVYyPWphz9l7xFYhvT18dCp
         pBdzcDxexJ5jPL7Sw+k7kAjQM5xfAmqkErQSv0ygKh65NYRuOzXyPfWdSe6AuOYpUfz9
         pHgeDuP1V37a/81wG04A08EQTPGY/Zr/ALCQMAjVRPbO2hhQLyLaUHHYVc44DYHRQgV5
         uTWevnSu3xP51+arFXtBI46wMZYGo6hrgcliqsp5gXAlb+PgO0vOsvxT37bYV/5eKlsx
         ditA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yj68sd1eYwpU86YtcH+RSFue4gqH76sT4KzX/dwyzO0=;
        b=AqVXyKQJzCH22o5u4aFd2eMslBBv64n/SpLaksw8n7HnZ2DbVL/6ft5EOKpVaSB8G+
         PTCktC9A/uxadWNyBI/B3Gd3Wfp6Sgodp4Fu8TSbW8HXYxtsh0K+ySx+TrLydhIMU/3H
         uvbdAu1dv6zzfCb3qAZwAWvXhgk8sl9xhU2rPBTMAnPmf2ZfLIJ9czfm62K9o92pryG7
         v2tANYHVnSQUNIWLiAZbzO3Bf/aqHbf05pjvDIZZtOCGzlwEQ/VxtdRsql1SqNnse8L1
         9w82KdToS4jZbk1q+iIJ6x/PEuI0XtOhVBikLNdyG79pJfcDaldpp38zx952vR1TrqvU
         /e2Q==
X-Gm-Message-State: APjAAAU4WwG5c8jLv19AJlLvQJ3TE2KZAiVrMhIXLQET8BHZlyk485HL
        tq7jQSdgF+RfBaxLcx8Qv4x0FA49YCg=
X-Google-Smtp-Source: APXvYqyyG2JQKgW7zVTrCOsLct0kVEH3lEoOnZMn335h3DFOFhgEOXxgTuPRyfeU5wuq83dSWU5c6Q==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr23289345pjt.33.1566255825237;
        Mon, 19 Aug 2019 16:03:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:44 -0700 (PDT)
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
Subject: [PATCH v4 13/25] drm: kirin: Move ade crtc/plane help functions to driver_data
Date:   Mon, 19 Aug 2019 23:03:09 +0000
Message-Id: <20190819230321.56480-14-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the crtc
and plane funcs/helper_funcs to the struct kirin_drm_data.

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
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 15 ++++++++++-----
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  5 +++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 6ff8417943c6..016a6057c5f6 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -602,13 +602,13 @@ static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	crtc->port = port;
 
 	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
-					&ade_crtc_funcs, NULL);
+					ade_driver_data.crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("failed to init crtc.\n");
 		return ret;
 	}
 
-	drm_crtc_helper_add(crtc, &ade_crtc_helper_funcs);
+	drm_crtc_helper_add(crtc, ade_driver_data.crtc_helper_funcs);
 
 	return 0;
 }
@@ -917,14 +917,15 @@ static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
 	if (ret)
 		return ret;
 
-	ret = drm_universal_plane_init(dev, &kplane->base, 1, &ade_plane_funcs,
-				       fmts, fmts_cnt, NULL, type, NULL);
+	ret = drm_universal_plane_init(dev, &kplane->base, 1,
+					ade_driver_data.plane_funcs, fmts,
+					fmts_cnt, NULL, type, NULL);
 	if (ret) {
 		DRM_ERROR("fail to init plane, ch=%d\n", kplane->ch);
 		return ret;
 	}
 
-	drm_plane_helper_add(&kplane->base, &ade_plane_helper_funcs);
+	drm_plane_helper_add(&kplane->base, ade_driver_data.plane_helper_funcs);
 
 	return 0;
 }
@@ -1056,6 +1057,10 @@ static void ade_drm_cleanup(struct platform_device *pdev)
 }
 
 struct kirin_drm_data ade_driver_data = {
+	.crtc_helper_funcs = &ade_crtc_helper_funcs,
+	.crtc_funcs = &ade_crtc_funcs,
+	.plane_helper_funcs = &ade_plane_helper_funcs,
+	.plane_funcs = &ade_plane_funcs,
 	.init = ade_drm_init,
 	.cleanup = ade_drm_cleanup
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index cd2eaa653db7..70b04e65789c 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -35,6 +35,11 @@ struct kirin_plane {
 
 /* display controller init/cleanup ops */
 struct kirin_drm_data {
+	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
+	const struct drm_crtc_funcs *crtc_funcs;
+	const struct drm_plane_helper_funcs *plane_helper_funcs;
+	const struct drm_plane_funcs  *plane_funcs;
+
 	int (*init)(struct platform_device *pdev);
 	void (*cleanup)(struct platform_device *pdev);
 };
-- 
2.17.1

