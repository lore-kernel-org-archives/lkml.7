Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBA0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F80922CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdOoZu3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfHSXEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:04:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35597 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbfHSXD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so2088802pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KEp0elOXwEygi2UwLXppvJt7Q3Cx6Htjn7Pk6SXSqQ8=;
        b=pdOoZu3g7oZCCwI/bXh7Isj1qi7y7cuAYZjlN+hZ8RJndngrGKe3jT/YScIyRDgMNT
         pYPVudymwquCht5UccK02DFM0AWhxmeVDVk9bC7pe4gffL873wQNepON+skjV6CtE8H4
         Jg6wdtOlhCm0vdb7MzFzOQehTSRG39gQQ2HOIoDeqjTWTtSr7zFMlcEs6IRu4fx7BV5Q
         Lq03F/OWNw/VyGswq7MnHya73oZtDsyq0wG/DccFS6mpab9sVNYoOxLb5pRaUtxvv1oc
         zON5zefzInYHEyMcWe3tYkxeRyKDep2/fRF21Sdmw4m/xzXqqt5c+2JIPXzMqxdukfGQ
         FUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KEp0elOXwEygi2UwLXppvJt7Q3Cx6Htjn7Pk6SXSqQ8=;
        b=si4PZEPRR4DHWWyBbjDITGN/mZGC231YxeTq6PwIhEuuTJxxAPVROWjr1KMYIUYS5N
         Ou1gGO9JjHdEqMuEmzyboj5zRWyrHDwwdPv4V72kEprmdQu0RHXzaUoNFhjhJ6FFzHhk
         KFoCEdVrhgMnNiwz8gS3ITbG9NLhM72FroixlSJHF9EvSsxETCF3kFwmnkQD6MUXyMK5
         5JndYYOuBE5kOXpuv0cLg2SMvV78c2DFl+Oa0cl3NORGjLiTZUc6GV3xQDNCWSjrAW2T
         D8fTlmoNGpM4dk9fxBqwRYpadQSPedBMMWenKxVP9FlUjrG4yITUbYvAxzPwEvLuQC6B
         Y6sw==
X-Gm-Message-State: APjAAAVUu5tf4mgVoDGFKz8vVuvtPgON1PQoUOI5ehiyJZMZrDJDxv3V
        xBSlNM5z+AsNEiWn/K+mvDvNDIM5Pkc=
X-Google-Smtp-Source: APXvYqzy7dL1PlN9gj3IYtPQmc4I8figOnswPtwMOyqf8D1q6BzRiYl/2/7Jcm3uza9avL8EUpXNcA==
X-Received: by 2002:a17:90a:246f:: with SMTP id h102mr22983749pje.125.1566255837541;
        Mon, 19 Aug 2019 16:03:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:56 -0700 (PDT)
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
Subject: [PATCH v4 21/25] drm: kirin: Fix dev->driver_data setting
Date:   Mon, 19 Aug 2019 23:03:17 +0000
Message-Id: <20190819230321.56480-22-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 1 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index a0cc1285512b..a7fe2fc57bf7 100644
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
index f92b3f7de5c0..55c8dbb68be0 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -44,8 +44,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 {
 	int ret;
 
-	dev_set_drvdata(dev->dev, dev);
-
 	/* dev->mode_config initialization */
 	drm_mode_config_init(dev);
 	dev->mode_config.min_width = 0;
@@ -140,6 +138,7 @@ static int kirin_drm_bind(struct device *dev)
 	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
+	dev_set_drvdata(dev, drm_dev);
 
 	ret = kirin_drm_kms_init(drm_dev);
 	if (ret)
-- 
2.17.1

