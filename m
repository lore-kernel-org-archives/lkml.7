Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEE4C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F6221852
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhjafeeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfHNSr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32920 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfHNSrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so54106383pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wO5ks8srjtZHHtpXOR5yQLjWhZNf1ho4YCPtcrf1Uww=;
        b=JhjafeeSnqrY96MJ/4i5IWZwtutSY/+sjrJKNymWybFyvALBIrAwaLrXnNm+qRQJFR
         SDwJLC5JbCWTXnmsCh3xFFheswBW72hayuwa4XzQtbYFMdz98f6PUkLTEzuFhrxa7dcT
         +iK9J7/7XZ11mPfH+4rhV1qlHJOE9Cbn15Spe7OBIDglTWmOC5JJDFXGFEcNnn85sFph
         nfFKbeM6gQtUvUA8ojdH0NUEOCMibVOA4ayu7r6zMI0uF1kb47k3aDvlNGBm4X8Ogop4
         hkGyHkjIk+KzXra8pKLmPtOod3J6cD2P2fAQ5iuRAiSTVcRNwKTGrTg6uMRvhyxo9f9c
         BKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wO5ks8srjtZHHtpXOR5yQLjWhZNf1ho4YCPtcrf1Uww=;
        b=GYwksOfZWJlh0lOGB2UOXat2ZxLoQBscYepo4HHkA/8NVFvgD2CcjSqjqMxJReP4fM
         IHpcymvI0AqbizWpT98T12ZUtbPBuuFd5BK4qQEWMEhMnHuOuDzIK+MOXuXddfLkm96m
         Cl4+yuBFDZS95iEAe1lGVM8GBlPdlcldWdLGHTp9tcYVRieY4Hj4S1y2LtZzXCgKlJFC
         LmhMlwmjCHxnZaPZgiCqpC7JojIZGH7i9TAT2ceP82pGtWIOWlRB0L4K5bQ+1fO2qpow
         uXEXg5szTcQBvjade0QvBLHlMbk4u5z0j/uxPM7/Clty82uF8BGEpfX2rU1+Mvc4LpM8
         orHQ==
X-Gm-Message-State: APjAAAVFjyCaxcfU6CWAQKayhzkiT0HVBZF+C5+3AyyP9QZmqcX4yG91
        1zl/eYJN8UXxDdFWSwY4YBFgSQPWMIk=
X-Google-Smtp-Source: APXvYqxW9O5O6lN6D75dJ6FsTbeutZUOicVbvKl6O0GFXkGTiyx7uCBE3n4NRfwQBEVHRq3DIGsO2w==
X-Received: by 2002:a17:90a:ec07:: with SMTP id l7mr1055601pjy.39.1565808463626;
        Wed, 14 Aug 2019 11:47:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:42 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 24/26] drm: kirin: Add alloc_hw_ctx/clean_hw_ctx ops in driver data
Date:   Wed, 14 Aug 2019 18:47:00 +0000
Message-Id: <20190814184702.54275-25-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes the
alloc/clean_hw_ctx functions to be called via driver_data
specific funciton pointers.

This will allow the ade_drm_init to later be made generic and
moved to kirin_drm_drv.c

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 9 ++++++++-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 09dc2c07533d..f729a1de6e14 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -999,7 +999,7 @@ static int ade_drm_init(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
+	ctx = ade_driver_data.alloc_hw_ctx(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
 		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
 		return -EINVAL;
@@ -1038,6 +1038,10 @@ static int ade_drm_init(struct platform_device *pdev)
 	return 0;
 }
 
+static void ade_hw_ctx_cleanup(void *hw_ctx)
+{
+}
+
 static void ade_drm_cleanup(struct platform_device *pdev)
 {
 }
@@ -1090,6 +1094,9 @@ struct kirin_drm_data ade_driver_data = {
 	.plane_funcs = &ade_plane_funcs,
 	.mode_config_funcs = &ade_mode_config_funcs,
 
+	.alloc_hw_ctx = ade_hw_ctx_alloc,
+	.cleanup_hw_ctx = ade_hw_ctx_cleanup,
+
 	.init = ade_drm_init,
 	.cleanup = ade_drm_cleanup
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 95f56c9960d5..1663610d2cd8 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -49,6 +49,11 @@ struct kirin_drm_data {
 	const struct drm_plane_helper_funcs *plane_helper_funcs;
 	const struct drm_plane_funcs  *plane_funcs;
 	const struct drm_mode_config_funcs *mode_config_funcs;
+
+	void *(*alloc_hw_ctx)(struct platform_device *pdev,
+			      struct drm_crtc *crtc);
+	void (*cleanup_hw_ctx)(void *hw_ctx);
+
 	int (*init)(struct platform_device *pdev);
 	void (*cleanup)(struct platform_device *pdev);
 };
-- 
2.17.1

