Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E941FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CBB22CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUn1iLVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfHSXEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:04:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35602 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbfHSXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:04:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so2088916pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YSUSZvC/MmkBb2A0U71VegVq9IwUqDyTaMf1Jm6kttM=;
        b=lUn1iLVWN3M/Tavd+lGuDsv+sjHbrx8GA9ZiY8qNOT04SvbHkmMQaFc10dzXCV2nL0
         v0IFt7+4KM5RkGel8iZf268c9c5XOBDQjeWCHpNZHij2ar4vItOFkNorSBg2T9vlFkK9
         n5iSbXpVkRmPjGEe6/eHcsJJPytYpdT+3cK3V2yHVs0acHXIJRDAPih50km1ipZX1TAR
         WgU2p6s7q+A69kPVgtzwgh/xJKB7s3DeX9/jPOljSf1z6/0i7PyWA7ZSCYV2nChVIDkc
         Kun9g4EEXdAYn9iBmJYQ/T4F4mI3fEh+4Hu6664kAaPuWPGLoqVlscoQCf3odGCbALJP
         /tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YSUSZvC/MmkBb2A0U71VegVq9IwUqDyTaMf1Jm6kttM=;
        b=B1PP7aFH8BhRqRHAMGpTAGBObq6RrL8tVGuxyZJ+ss1z69o/ze5FXtEXQXHTW13TNs
         ss5ocFGZQ4P8cM9GUe/0oKcJ5u46BDS+AZ+7zJOLOJrS4jQi7MntH9qctAxsVrkaCMug
         ShKJOmrRpXVr4/xQvwMLAsmNF+Ky2Jud702G3d9BOuFMg1KWddUmNDbE7UgkHFW2b1D8
         LiBuwuupMmY1BzOBWNQpWGGYFSEgM1GdIHlGj7rj0qaS7caRDyutkRrJZ/o48M0/v6LQ
         WUEbPqqH2ijAJw87uyhkAfVoOL9Pgo5p93l23jxVY86gb+wS7FOFzeRT1v0iIXe5uC2V
         eC0w==
X-Gm-Message-State: APjAAAVWWqa3mTHfMmVtGqHyZocv31UQ+RxsuwApPfsbNdGBwcnbwhhB
        bRyuwFVc1M4QJyr9UNz6ce6OAUeFhrU=
X-Google-Smtp-Source: APXvYqwuD5lU5Za2D+Vjnplf9zhdygBc0WW1Zmxbw+NTVMd+56KwwU6JvtLjPPrSlN2QSTYdxT3KDA==
X-Received: by 2002:a63:5807:: with SMTP id m7mr21941754pgb.371.1566255842444;
        Mon, 19 Aug 2019 16:04:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:04:01 -0700 (PDT)
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
Subject: [PATCH v4 24/25] drm: kirin: Pass driver data to crtc init and plane init
Date:   Mon, 19 Aug 2019 23:03:20 +0000
Message-Id: <20190819230321.56480-25-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 5caf0921c26c..559e521add43 100644
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

