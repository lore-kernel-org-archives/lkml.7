Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2513521721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cpfh3NWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfHNSr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46833 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbfHNSrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so5811607pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wvK/3ErN4wAOUGSP9sa1Evt1Opo7B3qrstIX5kiusy8=;
        b=Cpfh3NWHEHi6l8EB8XmZOgSh/8o8G7lgNUqtXNmdAYy46WXcYN7FqnitHrZpXc5hJY
         Z0IxbY5zrAsWaPqarNxK7pVLE2HV9yf4QyHvvh2iRKmb82vjnfg6yHckyMsFMPDVkw7t
         QSZ4qLug//fjGz/4FhMH/8rzP+v28cl4foKvATTs+UG6BEl9IY53kDq9fn91Jwf+pgBb
         ZFAiLfeCPjoJoGKIUoi5XauHXXHY43JTruTkK/FaJtEJm+/iwWEW35Nr6KqK4ImVQO25
         iMEvMJ1SkAxDIUaVQey+/5ch7rJmbiM7LS4qe/EsNitcUaOBDCRLq69FeyO6c1EMqlYp
         IdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wvK/3ErN4wAOUGSP9sa1Evt1Opo7B3qrstIX5kiusy8=;
        b=pesg3FipUe03mlCpUehKTc5kNEpLHQ6mZGY1qdqStjhHYTnaB12JRY5XqRd3GpjlJn
         PbL3sxP/1pK08uwik4L0Hj7EdNhraszoPfkxrYMfEQof/G7eyu804cxHQaX6h8ntlpIs
         HjOHbc/fZNAtIPGmD9ZUQZ8JkCo2sdKrG6MoOmTg39o62ixLp4qdGGY1pxhf3dbgCeks
         9ZN93pXUslfMTMACjbN1H3MSKWzwQf9tm1YTmTW6xKY10ismRgZQL2ck3tkTMJWcas9s
         wJOTGdhLvJ0jMiIt6ZGUu+lPGrxzjzPd9E0eROBXYVypC8GFwpxESJJvgrA/VN0PumGZ
         tMMQ==
X-Gm-Message-State: APjAAAWLab5YhFzQyXjgx6c7ZKwWvKu/jjK8sjB2xn0WBqyjBZUTRRFt
        kg7abduUtZb9KHQCSmUh9lboLs6wZkY=
X-Google-Smtp-Source: APXvYqyZGdbkXmqHNPSUFMNgCMhpoqA7AKg44U8bK842JHx9Nz1jPxGzeG5oT2vaCVVncT70GRIABw==
X-Received: by 2002:aa7:8dd2:: with SMTP id j18mr1419335pfr.88.1565808442309;
        Wed, 14 Aug 2019 11:47:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:21 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 10/26] drm: kirin: Move request irq handle in ade hw ctx alloc
Date:   Wed, 14 Aug 2019 18:46:46 +0000
Message-Id: <20190814184702.54275-11-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index ddcfe0c42d7c..0e0fe1cb945f 100644
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
 	INIT_WORK(&kcrtc->display_reset_wq, drm_underflow_wq);
 
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.17.1

