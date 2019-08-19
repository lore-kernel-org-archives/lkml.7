Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19EBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C01E20644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8UBp8pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfHSXDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41196 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfHSXDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so2033542pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JD7m4tZwO+IDa1xgX/FwZAd/NdHORHjMi+i9qNb5uKs=;
        b=K8UBp8pFTBCLS2af/ixfreNcrk0g7xTA0YI6qqiBVZtEfdhK+Ayf3sDdZ3ha3RVNzs
         MOq+rEP5I4yPMf1Jfbi4kDCsCkDVDbxLFnpbEIwdegzvs42kZPhm7l+/f1H4qgWj2TAD
         rgO7v7U5Z25QFpzo7q8f3cG/2uSP20a/P0mP0V/I55s18uALYAZUXMMG1dSjVNNlPPp+
         ULIwvEi9955TpK1QayL6VVQyXfjs9CwOxA6LZsLA1QJ1W9YCQ6Qjo6+nVuiYdOhE629W
         jMwbc02cMB2VVM99ZOpbwLrTY7ykc6ngFn3+jR/Wo9K3Jew7CKF0Mhnpwil/kkl5eVuo
         5L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JD7m4tZwO+IDa1xgX/FwZAd/NdHORHjMi+i9qNb5uKs=;
        b=Of+BDCIXjZ3F6kZLKjW5oq2ICZzc/ovFBkvRA2wDWqLh646F7OkNopsFzelYCGYQcO
         bOwJgN30GgJel3lZrBHWed3HsH/qNHcr1OM9lgG49v9BaCHe2DX/ZK7JMPPN7fVBO2Zx
         dRVKwuyicLvuZIQCTvVNGcw7TGH3pIWVek0DxKiMLRQfwWnw3KIUHqhTnuSn+SFoBZOF
         fsMOoPMVsOWpbatykG8SgUrB7wT8zVlqnIisnFoUxBp6x5Kda8VrvO2cmzyu1uYZApEM
         a07NiqzUu1fiZ0aVJj5f7Y6SQoWl/l4VDjeTy8BM1qWTMg1nKbT7kpo5+00iq7wNq92U
         YvTQ==
X-Gm-Message-State: APjAAAXSrMNFYHGy6zlvrWch/sXFbOQW8FVEDL45uHbj2uUHe6r2Fy8l
        CgWqRDbnecwtBBYT64UFO+Y5ujJ0Cog=
X-Google-Smtp-Source: APXvYqyqpP1PwbnaQJr6HO5/U9c9TYoGinZSl4NN8syYf4BdEDDa9pVcGA6gwkSAMsFc948LLVbWTQ==
X-Received: by 2002:a62:83c9:: with SMTP id h192mr26119646pfe.57.1566255817313;
        Mon, 19 Aug 2019 16:03:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:36 -0700 (PDT)
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
Subject: [PATCH v4 08/25] drm: kirin: Dynamically allocate the hw_ctx
Date:   Mon, 19 Aug 2019 23:03:04 +0000
Message-Id: <20190819230321.56480-9-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch modifies the
initialization function to dynamically allocate the ade_hw_ctx
structure previously kept as part of struct ade_data.

This is done so that later we can have the hw_ctx point to
hardware revision specific ctx structures.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index fce374ec69e8..ecb507985fea 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -72,7 +72,7 @@ struct kirin_plane {
 struct ade_data {
 	struct kirin_crtc crtc;
 	struct kirin_plane planes[ADE_CH_NUM];
-	struct ade_hw_ctx ctx;
+	struct ade_hw_ctx *hw_ctx;
 };
 
 /* ade-format info: */
@@ -951,55 +951,62 @@ static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
 	return 0;
 }
 
-static int ade_dts_parse(struct platform_device *pdev, struct ade_hw_ctx *ctx)
+static void *ade_hw_ctx_alloc(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
+	struct ade_hw_ctx *ctx = NULL;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		DRM_ERROR("failed to alloc ade_hw_ctx\n");
+		return ERR_PTR(-ENOMEM);
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctx->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ctx->base)) {
 		DRM_ERROR("failed to remap ade io base\n");
-		return  PTR_ERR(ctx->base);
+		return ERR_PTR(-EIO);
 	}
 
 	ctx->reset = devm_reset_control_get(dev, NULL);
 	if (IS_ERR(ctx->reset))
-		return PTR_ERR(ctx->reset);
+		return ERR_PTR(-ENODEV);
 
 	ctx->noc_regmap =
 		syscon_regmap_lookup_by_phandle(np, "hisilicon,noc-syscon");
 	if (IS_ERR(ctx->noc_regmap)) {
 		DRM_ERROR("failed to get noc regmap\n");
-		return PTR_ERR(ctx->noc_regmap);
+		return ERR_PTR(-ENODEV);
 	}
 
 	ctx->irq = platform_get_irq(pdev, 0);
 	if (ctx->irq < 0) {
 		DRM_ERROR("failed to get irq\n");
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
 	ctx->ade_core_clk = devm_clk_get(dev, "clk_ade_core");
 	if (IS_ERR(ctx->ade_core_clk)) {
 		DRM_ERROR("failed to parse clk ADE_CORE\n");
-		return PTR_ERR(ctx->ade_core_clk);
+		return ERR_PTR(-ENODEV);
 	}
 
 	ctx->media_noc_clk = devm_clk_get(dev, "clk_codec_jpeg");
 	if (IS_ERR(ctx->media_noc_clk)) {
 		DRM_ERROR("failed to parse clk CODEC_JPEG\n");
-		return PTR_ERR(ctx->media_noc_clk);
+		return ERR_PTR(-ENODEV);
 	}
 
 	ctx->ade_pix_clk = devm_clk_get(dev, "clk_ade_pix");
 	if (IS_ERR(ctx->ade_pix_clk)) {
 		DRM_ERROR("failed to parse clk ADE_PIX\n");
-		return PTR_ERR(ctx->ade_pix_clk);
+		return ERR_PTR(-ENODEV);
 	}
 
-	return 0;
+	return ctx;
 }
 
 static int ade_drm_init(struct platform_device *pdev)
@@ -1020,14 +1027,16 @@ static int ade_drm_init(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, ade);
 
-	ctx = &ade->ctx;
+	ctx = ade_hw_ctx_alloc(pdev);
+	if (IS_ERR(ctx)) {
+		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
+		return -EINVAL;
+	}
+	ade->hw_ctx = ctx;
+
 	kcrtc = &ade->crtc;
 	kcrtc->hw_ctx = ctx;
 
-	ret = ade_dts_parse(pdev, ctx);
-	if (ret)
-		return ret;
-
 	/*
 	 * plane init
 	 * TODO: Now only support primary plane, overlay planes
-- 
2.17.1

