Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD0421880
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phHUUaiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfHNSrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39319 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfHNSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so4259326pln.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LsxdKXlIE7uZ+/6eqxu7c+cok0i20/tbrH/8RDl0m7Y=;
        b=phHUUaiCNqUXb2OQDy2PL5HiT4EhT3jgLrPghrja3apIV/sP47ECUK+syGDP5dxS4A
         u+j4PGs/2h04W3SConQAkYMRWPkN+ePriNra7FScCzMkt73oDq1S0URnJY56t67cEP8L
         6Kde0bxm6ML74X5v2uYA4015JBOAg83kGePtdvjL3cba7JLAtSvNzHe++HBCOCCTGQ7M
         SdC5xiGI5kyWlBMRbN+p0GHUTH0QG9Kgu13fRBviu4FHdV9f6YQcgZcIwfyqaPamriYd
         cEKPVXU80fB+TBz/Yiz15pMIdJJF1l+oRZmcJ68sbU8zBUbcVVaqT7RShmx2KXd9TI3D
         cE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LsxdKXlIE7uZ+/6eqxu7c+cok0i20/tbrH/8RDl0m7Y=;
        b=jzXlCrxNQ8ftwOw8uC439sK4cvANaf1ADpTHCuBrdnRbgC1uXpimfUKUFydgwagVeF
         7cApsxAkb516uZHbXjdVVdiNfQMV93ym+yAG3PjAx8dHsADjsh9gSwwXQN3jSHJW9owv
         pEIW8NtKFwdKWHnSnUMAOnHhdCFRg0t2VCXunkoOfx5ClLD+0XmB+2kpOJyE/ZgPR0ev
         khiUOyNrgcKThp6w1jfySauJW0WRJ6dPrP5rPE2PwY++4HYaLDES+YjlmskjbSoiy52/
         qSZKF8fhfXLNUTNVxpPuBjTgasY4sZVQnu9tj9pVGZMXBULYJoiPY0ugoJw5b5efGpOx
         R9QQ==
X-Gm-Message-State: APjAAAX2N2vtL6ez7C9D19qTACNvPeLseMtjRHpFqStZHn4SOBefWrHo
        IVxgig/o1h2+UopEp9eNnrnm8BKuetY=
X-Google-Smtp-Source: APXvYqymhPQykXI8DyJnBWC3/2rfVnNZjSgYqV5xd4FwvmcqNtbeI6JIWHdpBIWAZKL/sL2ccjFXXA==
X-Received: by 2002:a17:902:2f24:: with SMTP id s33mr734052plb.314.1565808461082;
        Wed, 14 Aug 2019 11:47:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:40 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 22/26] drm: kirin: Fix dev->driver_data setting
Date:   Wed, 14 Aug 2019 18:46:58 +0000
Message-Id: <20190814184702.54275-23-john.stultz@linaro.org>
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
dev->driver_data to point to a drm_device, not ade_data.

Thus we set the driver data to drm device after alloc.

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 1 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 0bdcac981d8b..09dc2c07533d 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -998,7 +998,6 @@ static int ade_drm_init(struct platform_device *pdev)
 		DRM_ERROR("failed to alloc ade_data\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(pdev, ade);
 
 	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 1c9658e9565e..f1853b84ab58 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -43,8 +43,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 {
 	int ret;
 
-	dev_set_drvdata(dev->dev, dev);
-
 	/* dev->mode_config initialization */
 	drm_mode_config_init(dev);
 	dev->mode_config.min_width = 0;
@@ -139,6 +137,7 @@ static int kirin_drm_bind(struct device *dev)
 	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
+	dev_set_drvdata(dev, drm_dev);
 
 	ret = kirin_drm_kms_init(drm_dev);
 	if (ret)
-- 
2.17.1

