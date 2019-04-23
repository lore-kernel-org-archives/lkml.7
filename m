Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA9C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D20218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRUGQM90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfDWXVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46522 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbfDWXVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id o7so6013402pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CaDQKtmoJIrSmTozd8EuBlUja2GH18dHC9/QnJ1EnV0=;
        b=GRUGQM90BHyiEZRiNX+NUKgtw0znVvvXJmoarXas0EkZYjMBVWaBh5BSb1FfmEjkEl
         EcQJc5zmZ957OsDrFJd2XEKFrIjd3cIuJxV6vFitrPu2pSSR9S+rVKGLA7njA44gRFVX
         OgmLv8F4WLWIGqlMK7tSXqNj5bm06Oz7FGOBVuIUlpjqi8RpPTG0uPEkQPtU/UXXrR0m
         cxKhPqUSAWnr1zhR2Uyg8L7g+dEpe5LZFTIb0IJypWwhF8qP7h2L4rvVCJnfh5H5o8DZ
         tjTZRmwr7Tzo7lN8NkfWEG+YZqf73MNY1uvEuZVCnEJAH47fO36cKxSvqjf3YFYVvSWZ
         Z+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CaDQKtmoJIrSmTozd8EuBlUja2GH18dHC9/QnJ1EnV0=;
        b=mW2YBP8ytKyFR4Zd9w+I7JdgQJRm24mz5tTW4YZHhwdBrBs1WmcCu2DE0NhvjpLXwJ
         BV9h527NLENFQu31K8MVZolb0C5AORd3PzqNLsO0hc/p2qDSdhj3JAaqcqFf4q6uJqZB
         onJeQ27+8fwE+Lwy5jCJCIWbhFs8N/y+8rFX0ki3wam8IRdrEKDu60XQugrBwJnsQtSD
         Tq0t1UG1d2AJIBgQKV5hq+qzjHIPAwB3reEUp8tDZuc+4AmiG4zHb1FY0khVk+RLuMpF
         0yYv1skWNch6GMnLnijteQtC+ma61ppXf88eGUig5GFmhoxLVJNiESTvQpqmUHd1bTbe
         bNXw==
X-Gm-Message-State: APjAAAVtT6JQP/e1sOgU+7RiMwM/Vd9JqqHMwaKaxRd+d4SgNl5Wjz37
        MPNF9nvTfAxrC2Of/2i1j/g1tJzLPo0=
X-Google-Smtp-Source: APXvYqx6GhW3MwgQc0Z4atGss2HmuRGSfxvNHOR/nmwRjSjppjo/kNExudaCLMo7krOJ2zFYPx1oBQ==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr28997997plb.115.1556061673428;
        Tue, 23 Apr 2019 16:21:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:12 -0700 (PDT)
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
Subject: [PATCH 09/25] drm: kirin: Move request irq handle in ade hw ctx alloc
Date:   Tue, 23 Apr 2019 16:20:40 -0700
Message-Id: <1556061656-1733-10-git-send-email-john.stultz@linaro.org>
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
initialization routines so the devm_request_irq() function
is called as part of the allocation function.

This will be needed in the future when we will have different
allocation functions to allocate hardware specific hw_ctx
structures, which will setup the vblank irq differently.

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 29 +++++++++++++++----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 0aa716e..94dcad0 100644
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
+							  struct drm_crtc *crtc)
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
 	INIT_WORK(&kcrtc->drm_device_wq, drm_underflow_wq);
 
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.7.4

