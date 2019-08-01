Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE2FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EEE214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvAaPqg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfHADpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38886 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfHADpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so33163883pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i9tvfzQD5GYsRh7YNElgPmwFI+U0VLLDkgmIyzror5U=;
        b=NvAaPqg/OKsgDwROr9SrTE84PizBpsBU2U6mbQoJNWffNUlem5m/Yh7dANZyMKA/FI
         dfdr4M5TLfEFnhUXw4uq8WRJAbF9MeSvijqNkjkw62arF3uXeLXWYhs33bgjkzXxE1N7
         pQAxj7FU+i1sHx4m4ZAy4WVt9aKd5psi7BPbkWLPXGWknTwdMdpY9k2Q8OPiNfs1uQ2H
         2X8MkgwM6uzTIcwh6hDYuWjSWHmgTsvBR76DBYxB91GJUx8cCG4hjKFV/rxAlbCbojQF
         bUOJ0qr0m2QVYfSWs39hfsCR97POLh4BjA9fLNcRzhsZXH8NxJSvkabw6pFJl4Xo5kEE
         LOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i9tvfzQD5GYsRh7YNElgPmwFI+U0VLLDkgmIyzror5U=;
        b=HKLQHP4kgQQFOzZyqX65Y5DWbRrnlYzCYGSDL73NF/8XyvxS648273nJlUDw38T8B+
         jtD/+EyGeAeoKGZ4yjUryDsS3fj4DffajI+Kf6Esi0TwOmqpProNQUJLSe+ryfD2Gj4L
         wdHKAZI4WQLNFAn2em++grSOCmu5kcSNqzqYgsSBB8yRvlqEQI7l9uH02+bbZ1Pz32vr
         W9KpPTY36BTROHsjay2C3vLinfla2HQEfDWLBOMR5NZUe9WGX3wDt72V3uLa/ZgQEow7
         kXSSuPLc11kFEIbTxFJGwplYj8/SVj3BSEWUC56+LUlkk5IGr81j6jICV9DKTwurILOt
         LIGw==
X-Gm-Message-State: APjAAAW/rsPDpxIU4+GU4OAYzlkmMXysivdTCbW2NYg8p4kdTgpl8WVo
        h0RR1sCpUxOc5pfV2a/97L0oCPq7+MU=
X-Google-Smtp-Source: APXvYqxXS0ixA/6BUpAhCw+3McQUY7SwDb3Y/AY61ODIUsKrYf+q0YrtOTqzm7TiGwQHRTO2l+8TKA==
X-Received: by 2002:a62:2784:: with SMTP id n126mr51725593pfn.61.1564631099327;
        Wed, 31 Jul 2019 20:44:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:58 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 09/26] drm: kirin: Dynamically allocate the hw_ctx
Date:   Thu,  1 Aug 2019 03:44:22 +0000
Message-Id: <20190801034439.98227-10-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index ee3dc3d0f738..ddcfe0c42d7c 100644
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

