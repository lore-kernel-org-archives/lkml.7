Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC8722DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lf3X1kiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfHTXGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32848 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfHTXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so169923pgn.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHOpC8CLMCy6vYTMkD3TApEoOIR8Z3RyhkmjOSjWV48=;
        b=Lf3X1kiV6Q+88ALsWCTXpUPKE3BXimIMLls1hjiLvA+69eGl5zRh7EytASAO1J72oH
         Opd16Ho9fTavo08W9QtWEH0ivz4UelAAjsLR1AWdxgi0arlaoSOnE216Hm2g67F/0+N3
         umGrniElDd5TBOo82p/a1vzDMo4xb9eY15B94Esn6GLXZwTNlwBCnU0+m0W0DMzkcs1N
         h+W16udncU+Jx955N0uLwOwNJ83OLYC/1ssJL4qLKuJI+2WrclJIlr9qiLA+QvwK8Hbk
         gRrePxJrP6z6mHRedFi5bhbzujcM+2b7X8j8q0VzcJBskcODPiwvx06rQ6n/IOJoR5tw
         Bcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHOpC8CLMCy6vYTMkD3TApEoOIR8Z3RyhkmjOSjWV48=;
        b=mD7to6mRprf587+dCKgJVGse/NhF+LG3qrLpIeFAM82W9mKtyfqqlFy0s+pT8h9XIt
         uTVCzyNKcapdy8cb+EZe+TTUVhG5SVm+rrqogsF4RYboSiuFQRYPlMeTq6I9H8F4ubyY
         eUvX+JzLGMZ18iHVkcuuPgvF6tee6ZdIwNyGGO8MKdHMRz3WotwlmeIt/WJlZbUr4OYk
         w36N3Xb5Z4LMkMnUiq72Ws3wFdCdSNV+MNTJqH5WCPf1kpqe2RLW64CtPJP0VYRnHypc
         4tjger+/iWiZon228v/RfDHkNaJGlA3GsBzxBf9YLlu65b+3PFvfIrfpIXUNSIOa4JgH
         dTMA==
X-Gm-Message-State: APjAAAVr4/J1sKumFNF5F9EUBkzZGyPSEm3tmPOEhoDGGis9HOD/ouoJ
        yAAlumHwOWvJvE5gmTr0L7zkWK/9QGU=
X-Google-Smtp-Source: APXvYqwFyS1sAlRP8XG80pzzyhQTF9viVgJhczs8w38ldtloeV/kE7MMCAlmSY0+sBENvGQCc7gM0A==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr2369044pjq.50.1566342402912;
        Tue, 20 Aug 2019 16:06:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:42 -0700 (PDT)
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
Subject: [PATCH v5 09/25] drm: kirin: Move request irq handle in ade hw ctx alloc
Date:   Tue, 20 Aug 2019 23:06:10 +0000
Message-Id: <20190820230626.23253-10-john.stultz@linaro.org>
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
initialization routines so the devm_request_irq() function
is called as part of the allocation function.

This will be needed in the future when we will have different
allocation functions to allocate hardware specific hw_ctx
structures, which will setup the vblank irq differently.

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
v5: checkpatch --strict whitespace fixups noticed by Sam
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index ecb507985fea..d0a7c1d0adbe 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -54,6 +54,8 @@ struct ade_hw_ctx {
 	struct reset_control *reset;
 	bool power_on;
 	int irq;
+
+	struct drm_crtc *crtc;
 };
 
 struct kirin_crtc {
@@ -358,9 +360,9 @@ static void drm_underflow_wq(struct work_struct *work)
 
 static irqreturn_t ade_irq_handler(int irq, void *data)
 {
-	struct kirin_crtc *kcrtc = data;
-	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
-	struct drm_crtc *crtc = &kcrtc->base;
+	struct ade_hw_ctx *ctx = data;
+	struct drm_crtc *crtc = ctx->crtc;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
 	void __iomem *base = ctx->base;
 	u32 status;
 
@@ -951,12 +953,14 @@ static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
 	return 0;
 }
 
-static void *ade_hw_ctx_alloc(struct platform_device *pdev)
+static void *ade_hw_ctx_alloc(struct platform_device *pdev,
+			      struct drm_crtc *crtc)
 {
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct ade_hw_ctx *ctx = NULL;
+	int ret;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
@@ -1006,6 +1010,14 @@ static void *ade_hw_ctx_alloc(struct platform_device *pdev)
 		return ERR_PTR(-ENODEV);
 	}
 
+	/* vblank irq init */
+	ret = devm_request_irq(dev, ctx->irq, ade_irq_handler,
+			       IRQF_SHARED, dev->driver->name, ctx);
+	if (ret)
+		return ERR_PTR(-EIO);
+
+	ctx->crtc = crtc;
+
 	return ctx;
 }
 
@@ -1027,7 +1039,7 @@ static int ade_drm_init(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, ade);
 
-	ctx = ade_hw_ctx_alloc(pdev);
+	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
 		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
 		return -EINVAL;
@@ -1059,15 +1071,8 @@ static int ade_drm_init(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* vblank irq init */
-	ret = devm_request_irq(dev->dev, ctx->irq, ade_irq_handler,
-			       IRQF_SHARED, dev->driver->name, kcrtc);
-
 	INIT_WORK(&kcrtc->display_reset_wq, drm_underflow_wq);
 
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.17.1

