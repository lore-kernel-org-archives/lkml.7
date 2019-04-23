Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1212A218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9dZ1wVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfDWXVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34303 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfDWXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so8277342plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZL7k6e/+E9bi/0it7T1LpM5/z2yHQD26NCZ4fJDDMXo=;
        b=e9dZ1wVLSPvWA/a7Am/iUIeh3p/2KfR17jKwh4ILeoBT1TFA6w2cGTm+5redia83kT
         NZLaz34vgkgOSq93x41VFcF8ZGOo93Fa+fhuuTFqu4uGONrzbEduvBmgco2DzKF9B7CY
         KnIAMAhlyqkhVN8Y2gBmw82LR73xjibvdiwjBWUhWU6sjpYuHsNAx3wC+wdWh4SSZ/5c
         lPP9mghFDRCC4UsYuozd4QxjmFyx9fmMr0UybTHs8nJfKr1CiLsQJtu0vRGC2EypQA0T
         dDehixG3Yxse6Uap9N4y+PQiM2M5jq2MXVW0JkFP7d0GwwOaQvneXn+rAWMXTxh54Vpq
         lbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZL7k6e/+E9bi/0it7T1LpM5/z2yHQD26NCZ4fJDDMXo=;
        b=NrrJU7EUIKLvTE2r287Qtw3qkVxlm8s/5+G2Kw72aBLYWdKpb21JFaMzzubEtkXCJj
         Q+qZT780lsBcQS7bf+LA2Vrcim4PHEdJyhYDCtwVBDviRmgJeXY2RIYMWXaYlxYiigl8
         ysx3I4rOvq6jJb+wkT0dWrXJa28atCQajOz6oZDnOWsIcdn8/w0JnMnc40T1B+bKzvm8
         ULLm4U+meLqX7PEpMCYbO5sWCaEIHAWjAJl1oRb+d1+uPFI+Vnj1e5Wia4fZ7kCPM3fi
         APq11nMGKrdnXxv29aQx3e8R0gYF/aC8m1jIldvQfSLQmYd5jzjifP4z9SvpOF1j1I5x
         FR9A==
X-Gm-Message-State: APjAAAUl1gcs37tRi1srJvXMfValXHuVmO00P4exissMijgdVwkF3biv
        U5nK563cU9umgw/14Tr5jWz2V9veJwY=
X-Google-Smtp-Source: APXvYqwe2/5g10OCkqetibI8U3Eh/TAGQv3PJF1E8wn4SUxctSU1TSdYDszeqlbbwNLKeQ2z0TEn3w==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr29137478plb.237.1556061672036;
        Tue, 23 Apr 2019 16:21:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:11 -0700 (PDT)
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
Subject: [PATCH 08/25] drm: kirin: Dynamically allocate the hw_ctx
Date:   Tue, 23 Apr 2019 16:20:39 -0700
Message-Id: <1556061656-1733-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 39 +++++++++++++++----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index c29ca75..0aa716e 100644
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
2.7.4

