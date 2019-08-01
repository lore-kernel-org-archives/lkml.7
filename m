Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54959C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB67216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5j8hBfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfHADpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39504 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbfHADp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so29162224pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gE/41V3p8E7KtwwzgftBMLTA6SAC75G2Kpa5UKCO8Qo=;
        b=C5j8hBfr3aQsA/OwNaVL8RCHkNAn9o85zTFnFGuituGatDhp15FNjaHXBlQlTMU6rz
         R9Ueq+9X6/0S14B9yYKbMcun3w2oWE/LS2TLZtVeagOiBxnh6zj4VD9+wgFm8U/37cqw
         FsiOGw/k9+82qWFd/6b3+1sKJwJmKS4rmnrGjNbWYe/U+gCgkMNLxgOdd0CFCrmaOV43
         0K5yQZTMiRJy7XWuING4I+3VjkycyWBXP3G9qfOOFokyx0en29yAN4ha6CvcK7Fe3d0k
         PuqkPSdckPrm32/FuFGSFPpayCgH1l5vV3xwmBy4dlS/yIVPUbWbBRiOLkgguX/cQqYm
         g3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gE/41V3p8E7KtwwzgftBMLTA6SAC75G2Kpa5UKCO8Qo=;
        b=GAut5+vWD3TISEmUJKRfjRMNA+rE7ghQy4MFC1nOMP7jus4V2wZ8qAfXYb5BoN23Ru
         sLwWvm0Kum97JtOBlmK0E2dKcgzm8lnAV97m3u2IOM8JdE9LVkNilhyRu5WNQqjLrFgp
         AAIP5CS7jD8SikojdvLs/zFduLoLv3MQIOaXA+Qgr0DUxBILmHZZ0cSgV3LYyYpvyzAu
         r9eDNTJQB5eDi01+1Fs6U59iJleiVCkCTwZsiaG239v/e09aXGmVkFiQdcrKWcjL84oD
         qJx/W60dcEFkff529da7i9YkRhZ0t9VGGCa0ABolcazdzGvN8CHCT2yGYJIBz0mbtelK
         lb0w==
X-Gm-Message-State: APjAAAXHLirC3rActVd/JCsLns2EPrHbNSmecWxMvhJ33KN1k6dNpgBm
        fY8RTvKA9X3Ms0AdVNEhTvG8hB5QCFA=
X-Google-Smtp-Source: APXvYqwT1VFMzc9tchbe9OkpDTvnzfmXSm4NMZYpWM+g4G4Q0+yWy9eVQ91PrnNFB3Ofujh71vMk+Q==
X-Received: by 2002:a63:5c7:: with SMTP id 190mr114583297pgf.67.1564631124394;
        Wed, 31 Jul 2019 20:45:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:23 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 25/26] drm: kirin: Pass driver data to crtc init and plane init
Date:   Thu,  1 Aug 2019 03:44:38 +0000
Message-Id: <20190801034439.98227-26-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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

