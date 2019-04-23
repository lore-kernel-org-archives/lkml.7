Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43609C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1116218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYwdS5Pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfDWXVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43924 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfDWXVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so8348021pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BvIii0rpBLgX+wwqwL/0OsyeoCyTJ/LguEAz+P3IFTk=;
        b=CYwdS5PeelmfD2irWAn0bYe3ptymOpnIEYyoFy+PvmAdcp+pAwgymZkAQxtFyKifQH
         VJZFG0qu8dTg34cxK+/TKJab5K3exR9lc9UijG3AgKAJ4T9c2dVrCkM2aZOQVqtAzlQ3
         4ATCqPMlOvg44oJytrIRmcN6l/9Q3my5KBAjYeGrPBmWytTR/jVY9UGPdQORQdiY2WIV
         AmLrzYyd9gM6VrbwfcBqMrVzcKNpntVbYA8SLgpR6JUg0KvesAWeUq1ROXtSp7oM747U
         eW12liqDNdINlMAtvaRQBGMIF1KtlgbLjE+wMC54nHO8sH4wk90qdR94gBeET3LDHQ2F
         fkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BvIii0rpBLgX+wwqwL/0OsyeoCyTJ/LguEAz+P3IFTk=;
        b=FwzgQt06IS/3X6T1STytybL4nQBYyUKE9JuJH1DEJ2cIkjEn7uPbSpspKyTVCFZ4jF
         nxk+8y5cCq+Jul+Pk7K2l/gn8SdhgOwxZW4AqRqbrgztcE+3aCD34zAzC1LH5oFinRX+
         2Tsc/wySP1GpYqGAfSw9cUQznmAYWgE1uAu7zMlBSck4WRTTaxXRK5WSq9i68s3Dcrfo
         aSK2CLKGcwwbmYjGI3MdWn7jAVwe/8zggbd704art4SJ9/gREb8L78jLEWKp9yQMkQZt
         YJ041a3o4m/RYtPN4KbSZFpMcx3skOodEugNgwp7Q9jK1Yd6jgl/+lFy0FM3PAnrST6m
         wATA==
X-Gm-Message-State: APjAAAV73UsZ8SLSaJ1i+UwkAGt7lU3kC3yIBv7uLdogcozY6ISM7x4d
        sI+6LseD+HUh6WF1oFlp/474gxuTXdI=
X-Google-Smtp-Source: APXvYqzw+pUXyclfRXDV1TZekbBMMDVlL0SOVff5oY0DiBlSQhsq3d+eMnwM3635pkNkObZAkNmSbw==
X-Received: by 2002:a62:aa01:: with SMTP id e1mr29934003pff.43.1556061694850;
        Tue, 23 Apr 2019 16:21:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:33 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 24/25] drm: kirin: Pass driver data to crtc init and plane init
Date:   Tue, 23 Apr 2019 16:20:55 -0700
Message-Id: <1556061656-1733-25-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes funcitons
to pass the kirin_driver_data as a prameter.

This will allow those funcitons to be later moved to the
generic kirin_drm_drv.c

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 71671f8..876e25b 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -572,7 +572,8 @@ static const struct drm_crtc_funcs ade_crtc_funcs = {
 };
 
 static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-			 struct drm_plane *plane)
+				struct drm_plane *plane,
+				const struct kirin_drm_data *driver_data)
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
+				driver_data->plane_funcs,
+				driver_data->channel_formats,
+				driver_data->channel_formats_cnt,
+				NULL, type, NULL);
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
2.7.4

