Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3CEC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF4A22DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="im5eLTod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfHTXGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37886 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfHTXGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id 129so95155pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UWiGXBfNJ86mDn5vZAb7KTs6jR4hl8/Ldv9PC03GxK8=;
        b=im5eLTodcpvNyYnvYfKclfPWmk5IUJ/g/C/c2m9NEVUHIuNQ2eHed4taHOze1kwaBw
         /k5jCxwp3/XS53RsLk0B+/s9PsXzJe0e8yPuOysMN2KjnMRvjRhKfGLDX1VQiUZAlEI7
         TRJtpAwNUF1f94QjOU7ib737yMsqAJcLaC1kALQ/6RNW7ZZK6ezT0QikKFBhc9qzo0Yz
         LXEPg0he5RI7DAmFAkAzsMDnAU7mSbxjUctQ+S5tiZsx7tVs+LKORaMe0PTposQ+jkHI
         /HkmmQMM5WoBkTZMu906bIuDQjRD24C2/Rv2zLAM8RO1NAt832o5zjIL6Nk3y9TIk0fd
         kfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UWiGXBfNJ86mDn5vZAb7KTs6jR4hl8/Ldv9PC03GxK8=;
        b=UXtgpz8ljCgVBJdlcnfi5i7uFi+t+P8JK7ur778FoPjSTg5+ZdRGiLM6CROv+mYH8o
         YyhNZWA5ZqxaUDIigGG/HBOhKrHpMPoTwZRDk6UtHVd9MeUdaplnjanZRpQe/3vh5UUe
         2vi6IvL9YgvEXKNpmaRSLNWfhUoOO3DYU8zB4aZNtBlbeIeLEI9hK5bI/bDvB0gbAHbq
         UaU++wg9n5TrUw3McRm5lpH9Pd95b6GTMqsUw3ym4BEy/DEs79eHwkeYZw0NvFzgw2Ie
         Docs9vDkXPmWs/Bg5H0GWnH4d59dvHyCBi3XIZKpC2Y9fl38gM6Aik4wwa2zRlYThalm
         cmmQ==
X-Gm-Message-State: APjAAAVgRX7a6S7vbbPFCUNOBFRyMGHOsGkstZ2u6chfA3aEmtHZGgS7
        ebnE+EXecXCYqchyNROz/cQVDtA3Q0w=
X-Google-Smtp-Source: APXvYqyc1r8mZYOYYKLNm/N/REvq5aLrho9hXyYPn+B42LLFv7FF3gqKsZoKqWWkrt98E7/Z/+qnqw==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr2371628pjo.94.1566342404395;
        Tue, 20 Aug 2019 16:06:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:43 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 10/25] drm: kirin: Move workqueue to ade_hw_ctx structure
Date:   Tue, 20 Aug 2019 23:06:11 +0000
Message-Id: <20190820230626.23253-11-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue used to reset the display when we hit an LDI
underflow error is ADE specific, so since this patch series
works to make the kirin_crtc structure more generic, move the
workqueue to the ade_hw_ctx structure instead.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index d0a7c1d0adbe..da9f477679a3 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -52,6 +52,7 @@ struct ade_hw_ctx {
 	struct clk *media_noc_clk;
 	struct clk *ade_pix_clk;
 	struct reset_control *reset;
+	struct work_struct display_reset_wq;
 	bool power_on;
 	int irq;
 
@@ -61,7 +62,6 @@ struct ade_hw_ctx {
 struct kirin_crtc {
 	struct drm_crtc base;
 	void *hw_ctx;
-	struct work_struct display_reset_wq;
 	bool enable;
 };
 
@@ -349,9 +349,9 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static void drm_underflow_wq(struct work_struct *work)
 {
-	struct kirin_crtc *acrtc = container_of(work, struct kirin_crtc,
+	struct ade_hw_ctx *ctx = container_of(work, struct ade_hw_ctx,
 					      display_reset_wq);
-	struct drm_device *drm_dev = (&acrtc->base)->dev;
+	struct drm_device *drm_dev = ctx->crtc->dev;
 	struct drm_atomic_state *state;
 
 	state = drm_atomic_helper_suspend(drm_dev);
@@ -362,7 +362,6 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 {
 	struct ade_hw_ctx *ctx = data;
 	struct drm_crtc *crtc = ctx->crtc;
-	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
 	void __iomem *base = ctx->base;
 	u32 status;
 
@@ -379,7 +378,7 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
 				MASK(1), 1);
 		DRM_ERROR("LDI underflow!");
-		schedule_work(&kcrtc->display_reset_wq);
+		schedule_work(&ctx->display_reset_wq);
 	}
 
 	return IRQ_HANDLED;
@@ -1016,6 +1015,7 @@ static void *ade_hw_ctx_alloc(struct platform_device *pdev,
 	if (ret)
 		return ERR_PTR(-EIO);
 
+	INIT_WORK(&ctx->display_reset_wq, drm_underflow_wq);
 	ctx->crtc = crtc;
 
 	return ctx;
@@ -1071,8 +1071,6 @@ static int ade_drm_init(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	INIT_WORK(&kcrtc->display_reset_wq, drm_underflow_wq);
-
 	return 0;
 }
 
-- 
2.17.1

