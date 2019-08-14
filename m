Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B576721852
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/K3nksX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfHNSrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46867 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbfHNSrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so5812174pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g6uAv27tRz5L9wSjxLNVl9yJGuoTJBSlGcSrGIG0dc8=;
        b=Q/K3nksXnTewrgH66PEsGInqHk3G5CSsI2MmO0bGyulaasGK4GnUHI4STA2aXzrRz4
         D0B7N1vpWKlYXzTEzek6IXpuHE4Ye51+L0AWYXGcXZLqitG/qBEgEUu/AZmCNwPFaKHU
         taiQH2TBjCAka8jXpuyNUDKgJEJds4vdeIIjZPNFxDROhXDFhUkpW66TJ/87mhbw5D/b
         kBY/0l4Yq0C9A6Dq9qmXYcI1gbtFB1VTjUJVOypUM0UeMW8Sr79f3I5D7nG7VSp9iZVW
         /rUuvIxHQCdB2EYgVcWynoQwr8d36hSXtEAgjF5iV2u0nnJrQXwLU3+4/T7Nn3qGoqT5
         wz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6uAv27tRz5L9wSjxLNVl9yJGuoTJBSlGcSrGIG0dc8=;
        b=S1Ug3uQwuy3Cpg/Vege+9RXWvaPk64lZjdEwSCwsIQDqzT8is1LYcQbUTYnZTebvE/
         FOmSifp9oMzn+cRJsEs4UOPUwGs4e5oM6IJs3PO8H6dB/96gIRpD/pCfalsPfdfY/BSS
         YgwSfXpbtj1ljv5v5CV2sQ4cI5lkhrY72LrL3bfoWMWp1RhvdoxrZ88KABozL/cfeleH
         7OGvzeBcgu9kUy4OfsXLFeyFQKeXrlNvs/sR7wkAGZUzfOZ+EWKAtXOMw6NttyIqlrKG
         DgENXeWC3SsuIvN1GsT/ynYk/0p2ouRGieODGIsG9oJdgBZxFjmzPYwm8yCqDMypYjLT
         ODjA==
X-Gm-Message-State: APjAAAWL9PS1JC8YPRDlBlqDbbffsFErWRoc0zR8bZO/Be1NKI/CJc0L
        hh9QsBpkDStYnvO0gDd7oCN+rZNKadQ=
X-Google-Smtp-Source: APXvYqww/O9lEEjFWec4hq2+MxoQOn1KDh79uOYPC/WRYrDlO23Pgp6bxoz/dkBfwH1RluR4paFsEg==
X-Received: by 2002:a17:90a:9f4b:: with SMTP id q11mr1030317pjv.105.1565808465169;
        Wed, 14 Aug 2019 11:47:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:44 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 25/26] drm: kirin: Pass driver data to crtc init and plane init
Date:   Wed, 14 Aug 2019 18:47:01 +0000
Message-Id: <20190814184702.54275-26-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Whitespace fixups, commit message tweaks suggested by Sam.
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index f729a1de6e14..ab0c5d03903d 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -572,7 +572,8 @@ static const struct drm_crtc_funcs ade_crtc_funcs = {
 };
 
 static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-			 struct drm_plane *plane)
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
-					ade_driver_data.plane_funcs,
-					ade_driver_data.channel_formats,
-					ade_driver_data.channel_formats_cnt,
-					NULL, type, NULL);
+				       driver_data->plane_funcs,
+				       driver_data->channel_formats,
+				       driver_data->channel_formats_cnt,
+				       NULL, type, NULL);
 	if (ret) {
 		DRM_ERROR("fail to init plane, ch=%d\n", kplane->ch);
 		return ret;
 	}
 
-	drm_plane_helper_add(&kplane->base, ade_driver_data.plane_helper_funcs);
+	drm_plane_helper_add(&kplane->base, driver_data->plane_helper_funcs);
 
 	return 0;
 }
@@ -1024,14 +1026,15 @@ static int ade_drm_init(struct platform_device *pdev)
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		ret = kirin_drm_plane_init(dev, kplane, type);
+		ret = kirin_drm_plane_init(dev, kplane, type, &ade_driver_data);
 		if (ret)
 			return ret;
 	}
 
 	/* crtc init */
 	ret = kirin_drm_crtc_init(dev, &kcrtc->base,
-				&ade->planes[ade_driver_data.prim_plane].base);
+				&ade->planes[ade_driver_data.prim_plane].base,
+				&ade_driver_data);
 	if (ret)
 		return ret;
 
-- 
2.17.1

