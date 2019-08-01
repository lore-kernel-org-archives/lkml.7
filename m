Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27DC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0882E214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ql0l5+P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfHADqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:46:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40716 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbfHADpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so33149872pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7V27YU7YMF+tZPi0O4Ugz3veVJN966k99LkEuw17xeY=;
        b=ql0l5+P+mf3WMVVy/yqVmjy+Oi65lqVK0DmdJ3uF8Nw4Wf5d0BwNFACRz3v7CkikjX
         Yd30hkInZkBXabP80PeIrme1yJ/Ip+O9cnqds2hbokZqg3RQNmjxWQl8Qbi4vmEIfqKK
         +F0amK2NQldKuKzSXexa/Nlj5Cgbu5FavZFzbN175XIAfRziR0JvosWELHfVqH8owdUc
         VMrKjDraq9FULY7g7KhFS9qzQOJ7XlP6lwLGP8knvtKBTv99kNZzmT9WmbcEfyB+6uLl
         Frv1ZK7q5RLYDrxqzNFNjCeURud/RAdSSsthXsdMdnbtscwgxnZzZ8M0c4NKTtzaWj5K
         jmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7V27YU7YMF+tZPi0O4Ugz3veVJN966k99LkEuw17xeY=;
        b=W6BCSpe8JHLBV51JcUrBBj2p4HTQDGgFz2hlXffXKht2cNRbyH6W/sf7cN/kS9DbMu
         6YqMj3tMMzA6ld8HfFHkGU665YSFKfyAemuZc5DBOOki9epUyY7CFKhPHbQ7JLAMjWkS
         7FY1HIg0KoXXAYXCU+QcYocvder+C5kCj6NvkA0JSYPNO1diPgxSpz0w0k8hEBrTzw94
         hviybzD0u3A1oij6/7WudNXjRKIpFDxE0hYTxgscWrQQc/jZW1CYHI+sX5xFEz79CLmi
         avEblnWJTs+76G7YtvCsNDkGDOPyilLFnwLYTgKyKXiidVWIRIPVM20agEpTs2nx0Mtk
         ymxg==
X-Gm-Message-State: APjAAAUP8Zh2l4WUHc+h0kaBjqtAfqB50Jc31zimAXjqgeGY8zvVApOd
        +Cb38yhFmXEgglIjDmZOMfp0pan1Z0U=
X-Google-Smtp-Source: APXvYqwEhFxACC26/Eik5Mctv+bkSEzw74Z5kusBkQCvg6V/F07XrF+4u0xrAKRk3NaklKsj9Z8wrA==
X-Received: by 2002:a63:a66:: with SMTP id z38mr21652140pgk.247.1564631100809;
        Wed, 31 Jul 2019 20:45:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:00 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 10/26] drm: kirin: Move request irq handle in ade hw ctx alloc
Date:   Thu,  1 Aug 2019 03:44:23 +0000
Message-Id: <20190801034439.98227-11-john.stultz@linaro.org>
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
initialization routines so the devm_request_irq() function
is called as part of the allocation function.

This will be needed in the future when we will have different
allocation functions to allocate hardware specific hw_ctx
structures, which will setup the vblank irq differently.

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

