Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B669C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2B1218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQmaSI6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfDWXWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43530 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfDWXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so8244110plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xTm116jbzqBEXo1zbyHHVrRjnaN2HZMnf5sPll9zTbw=;
        b=iQmaSI6qMUz6Cmn3MAJaIzmnZjHAJOpl6IiabW5xVfy4iQLZ0Dw5AwDnOCUR4bkap4
         LXSb39TrOxCo8f/ADnd/pKEZQEQdHh6WFj14PoTcv8SV0FvZEODFg0uXy/xrn8kXH0en
         GnFVY12TrHTMDPBQrHToJu7LFzJ3xSRuHCT8s3x+IHpMxkFEcm2rPrAElzrz/WuDMsS6
         filnJMkHdg6n3/S0Vn6mnkGlIz8Tva2hPAwy0jS9vyFVfglvxeuHsXYuOKS+v4fWCpwx
         ul7M4gutNYptU3lCDZviwc3l9UNjf+08FowMjODa6EpbvuFy0jDnfPspn94fKl1NMbEs
         5P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xTm116jbzqBEXo1zbyHHVrRjnaN2HZMnf5sPll9zTbw=;
        b=qwXQL6bxHktjhwcWMfiz6GTpPWAhVTbwM4KCK/7a1fV52ScKo2fEIrvtEOBrBTPfPJ
         eAnHfdIFf1ta6/yHhqzsU5CFOvUgMMFypFshKsk+3jy9QdydaDQlPnmLQtgBZA7zZZA4
         FRS9hg3GFiwI5oy4qliME7rxkafFyCcV/spDVam8XQW4S8K7Bbtn4koga2T8BKoOrnkx
         eBB517uk+ZnrSfsVnkot2a7b3n/6K/TS6Uidbx0a1FbAgZUIf29y5KPgZ2LY0oShKNjH
         ONJN3WkfbTg3j/sDTKY3D0PDJG+RJ+GEaAN9xGJ5j31lkEqEPslOsdi/W7gOn4m+fEJv
         JXoQ==
X-Gm-Message-State: APjAAAUmMxNc2tMTP6zfT9pu/LAr0DQ6wmwBjJKBJJEzXRBV/pf77zRZ
        rj4A17Aap7Ox6kRkINeEGAPvPxBBqUA=
X-Google-Smtp-Source: APXvYqywTXKIf62IMwvoI+e2f34rybm50ANUcnv+iKH/YohFQP0Xgd9A95IgogAWE4lL9vspQkXEYg==
X-Received: by 2002:a17:902:e684:: with SMTP id cn4mr28490956plb.71.1556061674718;
        Tue, 23 Apr 2019 16:21:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:13 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: [PATCH 10/25] drm: kirin: Move workqueue to ade_hw_ctx structure
Date:   Tue, 23 Apr 2019 16:20:41 -0700
Message-Id: <1556061656-1733-11-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue used to reset the display when we hit an LDI
underflow error is ADE specific, so since this patch series
works to make the kirin_crtc structure more generic, move the
workqueue to the ade_hw_ctx structure instead.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 94dcad0..f54cf99 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -52,6 +52,7 @@ struct ade_hw_ctx {
 	struct clk *media_noc_clk;
 	struct clk *ade_pix_clk;
 	struct reset_control *reset;
+	struct work_struct drm_device_wq;
 	bool power_on;
 	int irq;
 
@@ -61,7 +62,6 @@ struct ade_hw_ctx {
 struct kirin_crtc {
 	struct drm_crtc base;
 	void *hw_ctx;
-	struct work_struct drm_device_wq;
 	bool enable;
 };
 
@@ -349,9 +349,9 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static void drm_underflow_wq(struct work_struct *work)
 {
-	struct kirin_crtc *acrtc = container_of(work, struct kirin_crtc,
+	struct ade_hw_ctx *ctx = container_of(work, struct ade_hw_ctx,
 					      drm_device_wq);
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
-		schedule_work(&kcrtc->drm_device_wq);
+		schedule_work(&ctx->drm_device_wq);
 	}
 
 	return IRQ_HANDLED;
@@ -1016,6 +1015,7 @@ static void *ade_hw_ctx_alloc(struct platform_device *pdev,
 	if (ret)
 		return ERR_PTR(-EIO);
 
+	INIT_WORK(&ctx->drm_device_wq, drm_underflow_wq);
 	ctx->crtc = crtc;
 
 	return ctx;
@@ -1071,8 +1071,6 @@ static int ade_drm_init(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	INIT_WORK(&kcrtc->drm_device_wq, drm_underflow_wq);
-
 	return 0;
 }
 
-- 
2.7.4

