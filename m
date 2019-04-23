Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA84C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CA9218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvFX/fer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfDWXVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36534 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfDWXVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so8374934pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyuYklvBayJptM/nAc9IL2K6XjtBGntJN95HuquLEL4=;
        b=YvFX/fern8eZoKAnjIxAf5RUz4Uvp8J4p+xGsXoGVflJquwMrkpMrG5g8ZV/A05vEL
         yW4+YKBR+RsZlQhjDsCS8pJ/EmpS7jY5Nxgx/1AQ3Ya5XcDNOjPb4k8GciQ+eajGnR/5
         RXoEnF4psLyE5PY753D8fvFFFGFUlRDP49VQujstxvFXl9/CyxSjTs159j/utvmq+X/s
         qPrI7Cib+zCask/1pHW5q5vdYjmF78xWdpJEJ86ShLuA6lz1CQltJKk0Roi5f1NAwx/B
         aYeJM1u+qRXXYRuBlkLqNqHVbjpQ7Qfb+aOQ9sDEROm0ngV+RtvVOxttKiHa++iOEKVP
         4CKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyuYklvBayJptM/nAc9IL2K6XjtBGntJN95HuquLEL4=;
        b=mGF7r3MV5saRxtW9GsJMpYk7/K14xsEt4W36nhx6q07FmFXu5e+2xvBI1ynyUUajZc
         +YUa3JEbdgB5cCQ0gQqhjlEJ2bq4ppd9PrOeHAJ5hSLcZwtf33++Jh43HYtQaSskc6fV
         0VbOgSz4PLmYun8mRs8TmpKbw39nf5tnunvgdviAuqjjpr9L1HwqyKrVFcQso3JNOtS1
         4wDs7UprX6P4/kGBY9q8MVxxJec55v7dz6GnkXBfHmOXM83D6uOyF0qtGouaJ0GSRCOp
         0y651lOJbDm8FasmdUgRj3CQKhe7ecptNDZM9E1tgxZKZU5wmX9p1H2yn8awK+dK3hql
         Z39w==
X-Gm-Message-State: APjAAAXFb+JLR9AnoKGyh3x8vKwQi1QUBqgUi47FJ643XKKTZTWm59mD
        Wby7TOp3Xg5LZ6bImc6S5smmSDJY/QE=
X-Google-Smtp-Source: APXvYqz8GDtuEf42eI35uaJpItKZLJSWWg9sDHjfvRMh4FewHjzW+BcTBuYF9lMJA4CyvbPWWnvOhw==
X-Received: by 2002:aa7:8518:: with SMTP id v24mr22541292pfn.219.1556061693163;
        Tue, 23 Apr 2019 16:21:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:32 -0700 (PDT)
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
Subject: [PATCH 23/25] drm: kirin: Add alloc_hw_ctx/clean_hw_ctx ops in driver data
Date:   Tue, 23 Apr 2019 16:20:54 -0700
Message-Id: <1556061656-1733-24-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 9 ++++++++-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 3d5bd3a..71671f8 100644
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
index 8818ccf..17c45b5 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -53,6 +53,11 @@ struct kirin_drm_data {
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
2.7.4

