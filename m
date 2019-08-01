Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04CAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9839021841
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dc3g+ccV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfHADpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35707 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbfHADpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so26970970pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sPsp2eqITZnw2b8QC7bn0VV3MJP+delfGQJVfFYbiRk=;
        b=dc3g+ccVISsD+XlJfNn6R+VKW6AYYAiONlIwe8IU3AI6iT5eUtwLhaCJbpLJzy4AmG
         JOLlaIB3eOSsJgUD2NpkU5i6OprDNKMJsnqPjgnhA5SzrHyNmul1V63b2JlhqtKgjaBy
         MeKUEwl22xTMvmP6z3Zb/x4Uv3k0S90nDT1h5sAnjEOY1Nn6jCZm3lZcNd/FBKJLoqI2
         Erbb7yS7qNkSo/m2YvpQ2vjqbVOIiLch05MzYqUN8WKeevWeK6P7FTuO5T6xJ6q/bK4H
         ac3vpQXKQaUmJf++/N6I04Sbo1rCscRkHBoFaWkSrOkbuwVtKqYWwLmhO/tprDj2HQ5Q
         BHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sPsp2eqITZnw2b8QC7bn0VV3MJP+delfGQJVfFYbiRk=;
        b=ezRTfZytcbfWiBWoD+G5y6BPLNaT8/L+2sjnkibOiIjWaQ4FDmfwn0ThotjRGs3Q1i
         OdMfUfLbAgziEvmsF0hoEao2BJT83CbCMFBW4nMnUbaeqmGNCiLS7jRlSOB/BF1c03YG
         ehwObL0rmSDG/t+cpGB7PAMbP+ZdiEc6qtte7YbH9RfzFrxVmTwb1eZryhskl90uCUqa
         8zcjfFNAJfL0hiSDa9FJlojHPHk5JHmxvW63B7tRqiNsL3bbLKH0Z/govRv7RY74w7Yx
         yOGatYtYOUBy730BJF7/iCVDeNNuNvVZs+kzkvI5yAet/TiTKdE34ir+62dNzWHgDiIk
         bYxg==
X-Gm-Message-State: APjAAAU3gMXDjdk/CY2pA+Hi1k0hBerGA8mz1SfwpVdjMoSLKkmzpnel
        iz7fDrDmIhmxqxQ4/hbxSD/9gmGwnRc=
X-Google-Smtp-Source: APXvYqz9J417rd70yrAxKPQ3YRSZltq4+t8BRMIPsxRjNDEPI645+q4kTkFqUGRKHPTAlVKDPrfaxQ==
X-Received: by 2002:aa7:81d9:: with SMTP id c25mr51766726pfn.255.1564631107496;
        Wed, 31 Jul 2019 20:45:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:06 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 14/26] drm: kirin: Move ade crtc/plane help functions to driver_data
Date:   Thu,  1 Aug 2019 03:44:27 +0000
Message-Id: <20190801034439.98227-15-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 15 ++++++++++-----
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  5 +++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index acae2815eded..029733864aa8 100644
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

