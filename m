Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306A6C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAD222DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ultjCohi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHTXGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45652 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfHTXGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so207659plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JD7m4tZwO+IDa1xgX/FwZAd/NdHORHjMi+i9qNb5uKs=;
        b=ultjCohiF3aF5SKoBtMgvK3996QvDB4DB8LMN4ZJXzQ/IADuWxwM6RXS0aL1KWxhky
         f17ioMxRO2j+E5oyHoDncbYXqO0/p/6EdVY/+hlXpqUJvTKFAQ5imnrAr6qbwaLIbTXt
         JqijIJ7KAIMXd5/ir6UAwmV1WRSe3nm0N+Lbx1TS1rsEy3eAOKW6W7ooAnK1KJG3s6Bj
         XsKnzgBNlzhkM+dqHOFHXBVYDrRkqQJaJFR9JiJUVtwohJyi0I1YEDOEDGaaFwf1W6dS
         fBqwUySj7mnJbpGcZVapSGC6x2bu9M+D/iThbVPJ8PejNTx3fyX9iaxAXbf6VGxVzivY
         O9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JD7m4tZwO+IDa1xgX/FwZAd/NdHORHjMi+i9qNb5uKs=;
        b=uaffujqLIjWQA5Pqc2/awLkodMcyba8UF6R2FoD4+4zt5kjRBGHx8VkgNJX5krfxp5
         sF3nmUGb1hCqVFosTTr032skj1GBD2paDPtJqVR775wUJqfBywSl5bYz/zctLl1dWvVH
         LAhQLF/5E8JzChWfqG72w7YNAbJoTgHE8Pt/sd8Mqt1SD3g73yehSqpYmqd6jffCcvmq
         kFXqf++OFC0K3/OdnAYWgNRPv9v9ZrXjMKmsYqJtFRgoATTp/hOCyHtJXVcP1JD/bcnm
         CqNSu4hDvLaAJQE+b1Y4+BdtTlJ9VIYaA9rg6ONV9RHUdXjwMARuhw2D3zhmGkNeNt3A
         xR1A==
X-Gm-Message-State: APjAAAVhtVgdRArI1KS3nT5VOVrNPLw5EXYGtK45CZHDHxlp8bfftbEC
        hawuVcXhRa6p0hVkW1VbeWEdZmUO1Z4=
X-Google-Smtp-Source: APXvYqyjR3pev/6MPv1S4rx9Fw8zhNrO4paP3w4iaxvHJPNck874/OAEJfh9LV3ko11Ugqjy3Y3w0g==
X-Received: by 2002:a17:902:5a46:: with SMTP id f6mr28717477plm.319.1566342401294;
        Tue, 20 Aug 2019 16:06:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:40 -0700 (PDT)
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
Subject: [PATCH v5 08/25] drm: kirin: Dynamically allocate the hw_ctx
Date:   Tue, 20 Aug 2019 23:06:09 +0000
Message-Id: <20190820230626.23253-9-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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

