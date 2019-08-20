Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44DA2341C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gU8ZcIiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfHTXHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38368 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfHTXHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:07:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so157656pga.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VMYo3cmyj5mjY37f6pl3U9ULsw2dRbJPHRfoYta4hK0=;
        b=gU8ZcIiNsbUNjEDU4QjWJ18XVrvz8lEmU3ppSLa8L3REyQwkogE286YOh/RV+SS7bK
         dzkEXC8NFkYiQu0pEDlrrWCFHsw3x6XTDQbfUSId/HntLnnMVaVmQAol0l9wYXFnAb5/
         8u4GoC+2Y0OeBIaOu55i7DAptqIs488dPDRMi8qvm+E992oefr+YMpKZ8A/KdT+XUK8q
         Tp3+q7eThBZbXJ0XimqCKowZsiM3PkZokQj39DtGWkGe9ohYAh7C/ztK4b3a+sYzp5e8
         P2/GfsazWdbIG77RFAy3zoB68GVn24r0Zqu6lHJroKkdWlxS73tzCy+RKm+PFWoanfNU
         QB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VMYo3cmyj5mjY37f6pl3U9ULsw2dRbJPHRfoYta4hK0=;
        b=sLzuy+RYFymUetZaI2ilHZbbyRYwlrxdSUMb5T1+glbUJ43k0jkV+g+QreUBG3njno
         ae5ljQARxx2GC446UEhdSvR+dl/sCdmwrn/MOJKl6eRqg7EWg2j/17f64JAFERwR2KN7
         JRIuxuQNxghej/In3hW0+7R+y5UnKQSWWadPjgYNxzM4+xjhqy+p3765SRVWQnmks2Nk
         h06mZGJjsVbxAg4K9yrEL4tS1rb+3ku4ZFmILCn2QD/NrcLskz3yAGI+1c3MT9/HQIUp
         bPOOgfEWZn8yneFbcSMJImAy4DerjYW85y0cq78kePQd9tSKj0XCfH5YviJVYy90sGpV
         EnGw==
X-Gm-Message-State: APjAAAUUvPanhZ5l3Ld/JCrqcuPetfWiEvbzpRWThCZPfkXe4KOK8tRF
        im0HgUyXb8cuh0VfcQLW05CfxfLi3QM=
X-Google-Smtp-Source: APXvYqxz1oVW6l7QOBSV8Pa4RGmsgh08w6fiIaPxG+0QGrfNNncnOJsGH7SP4TJXtPquEw8GHTDdyw==
X-Received: by 2002:a62:1d93:: with SMTP id d141mr13758767pfd.40.1566342428229;
        Tue, 20 Aug 2019 16:07:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:07:07 -0700 (PDT)
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
Subject: [PATCH v5 24/25] drm: kirin: Pass driver data to crtc init and plane init
Date:   Tue, 20 Aug 2019 23:06:25 +0000
Message-Id: <20190820230626.23253-25-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes the code
via a passed in driver_data pointer, rather than hardcoding
them via ade_driver_data variable.

This will allow those funcitons to be later moved to the
generic kirin_drm_drv.c using alternative driver_data structures
that support other hardware.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Whitespace fixups, commit message tweaks suggested by Sam.
v5: checkpatch --strict whitespace fixups noticed by Sam
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index a2bb2b75be4b..bbdfeac946a7 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -572,7 +572,8 @@ static const struct drm_crtc_funcs ade_crtc_funcs = {
 };
 
 static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-			       struct drm_plane *plane)
+			       struct drm_plane *plane,
+			       const struct kirin_drm_data *driver_data)
 {
 	struct device_node *port;
 	int ret;
@@ -589,13 +590,13 @@ static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	crtc->port = port;
 
 	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
-					ade_driver_data.crtc_funcs, NULL);
+					driver_data->crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("failed to init crtc.\n");
 		return ret;
 	}
 
-	drm_crtc_helper_add(crtc, ade_driver_data.crtc_helper_funcs);
+	drm_crtc_helper_add(crtc, driver_data->crtc_helper_funcs);
 
 	return 0;
 }
@@ -894,21 +895,22 @@ static struct drm_plane_funcs ade_plane_funcs = {
 
 static int kirin_drm_plane_init(struct drm_device *dev,
 				struct kirin_plane *kplane,
-				enum drm_plane_type type)
+				enum drm_plane_type type,
+				const struct kirin_drm_data *driver_data)
 {
 	int ret = 0;
 
 	ret = drm_universal_plane_init(dev, &kplane->base, 1,
-				       ade_driver_data.plane_funcs,
-				       ade_driver_data.channel_formats,
-				       ade_driver_data.channel_formats_cnt,
+				       driver_data->plane_funcs,
+				       driver_data->channel_formats,
+				       driver_data->channel_formats_cnt,
 				       NULL, type, NULL);
 	if (ret) {
 		DRM_ERROR("fail to init plane, ch=%d\n", kplane->ch);
 		return ret;
 	}
 
-	drm_plane_helper_add(&kplane->base, ade_driver_data.plane_helper_funcs);
+	drm_plane_helper_add(&kplane->base, driver_data->plane_helper_funcs);
 
 	return 0;
 }
@@ -1025,7 +1027,7 @@ static int ade_drm_init(struct platform_device *pdev)
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		ret = kirin_drm_plane_init(dev, kplane, type);
+		ret = kirin_drm_plane_init(dev, kplane, type, &ade_driver_data);
 		if (ret)
 			return ret;
 	}
@@ -1033,7 +1035,8 @@ static int ade_drm_init(struct platform_device *pdev)
 	/* crtc init */
 	prim_plane = ade_driver_data.prim_plane;
 	ret = kirin_drm_crtc_init(dev, &kcrtc->base,
-				  &ade->planes[prim_plane].base);
+				  &ade->planes[prim_plane].base,
+				  &ade_driver_data);
 	if (ret)
 		return ret;
 
-- 
2.17.1

