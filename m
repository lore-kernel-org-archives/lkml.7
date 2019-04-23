Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F3CC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2435C218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaCMAzKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfDWXW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44287 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbfDWXVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id y12so5683091plk.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nanMR9WGZAGOt8W9FCJsIT2NdvldMFJeYO2gST1GNm0=;
        b=aaCMAzKK87Q6UwN6wPqpfWKm4r5h4W2daAKhhs0a/xCwkqMd1/t7RzCSkZgdGoC5JE
         VS9i7z2Ar4OSACfCAcsHuYKZHPdyhV8p0ipQakZUFPC1Gc7BboDmYHjLbsIIOBOFEC/7
         I0o6VV0Vi/JJ7HwoCvocaunOnRsFyrXffVeqj6abGZ4fFc0/lvJXULVa1WL3Mj9bLxb8
         G8SMg6onZZKW+7CQlUMuYU18/cH4NFd3Dad6t9Ia9wPOls+G0PpLzAWGwrMUcWO6jSE0
         wHyAM9jM7qDS8Ll7wmv7jzwMwSFV12Lg+vw1/LyDzXw2KirEp/cWHudNU9TcvoSnbE8J
         n76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nanMR9WGZAGOt8W9FCJsIT2NdvldMFJeYO2gST1GNm0=;
        b=O3rpLCfJz1q9aslWT4wR1peT/j3IOp2CjuZfoFT2ZFdF+WWned07NrtBAAY4oeNAMZ
         ZpEdvJ6E9STCo2UA7WA7qZFAX7a9EzxYeIam65D6+wuNGQwtuJJjB3YYaAIctKLPZXVa
         5SZ//jSRfGZqgxawLFzKiBmYuKff9+jXLQOEZBZJiznry/7xJTEXIhFlW9LwbM9doqFq
         CEldLcD15zqPEHISC0PfwWcRSuElHMEs6sVNqkFK3IqjmavF3asdHP8iyoOzjBx6DPYZ
         jBFWovyOzxy5G7+FHlSeWnjHfWtJCKgYFFpZIxREgvHQymp90i8+8fMGtBNU7TxY1zWQ
         bsFA==
X-Gm-Message-State: APjAAAWRXKFgrotnLj/HZROZqfN2GqdUMOYnx7KRo99raFD1mQFLvBjp
        rw905b6gOslGLbjSdHdNpyCJrxoiw2Q=
X-Google-Smtp-Source: APXvYqyALxw5aburaoX8Cho1JkZDKW/0Bhym/vqMYkT0zsTkkFhaiQrNR0Zl20E/oAv3pySG0Kta6g==
X-Received: by 2002:a17:902:8a8b:: with SMTP id p11mr28494162plo.227.1556061678919;
        Tue, 23 Apr 2019 16:21:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:18 -0700 (PDT)
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
Subject: [PATCH 13/25] drm: kirin: Move ade crtc/plane help functions to driver_data
Date:   Tue, 23 Apr 2019 16:20:44 -0700
Message-Id: <1556061656-1733-14-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
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

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 15 ++++++++++-----
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  5 +++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 221bfbb..6aa529f 100644
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
index 276b159..05161ff 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -39,6 +39,11 @@ struct kirin_plane {
 
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
2.7.4

