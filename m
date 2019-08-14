Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F63FC32757
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6949A21743
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbE+WUXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfHNSsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:48:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37943 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfHNSrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so8762767pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oF/wbsoL0VS/wbGpdQ82+BUReXpcSGsjNr6ZOoxveCE=;
        b=fbE+WUXen307U/StI9D2O7GIdMzehRpD6EtZen5vznPou1FPyMwl/2Xxzt4nMi0Wa8
         rcWMpKaVL9QJEqXN1S1DhwMt81wV9iG1G/6oKUsCcVJ5yLGNWbBn2ED85dp96DmG8N5Y
         3+MAEKD7CVRKwn5TU2L+IcKTbCd99tingrjVosZlgwpzyfITUpDY0VnmL4vTXg2ojAWI
         Fq6dpbIOcMiD7DsNZ/R2k3ON8TyRwH0VP+IYRWl9UmU1cf1YzSoAv6oGBf29neQ31Lvq
         7gUwiKmxVzWTxufpHByAIwKdCWpsjinRfA/5l5yIUNiE8pnt6qG+KCo/eXCYHWwOTyQg
         yk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oF/wbsoL0VS/wbGpdQ82+BUReXpcSGsjNr6ZOoxveCE=;
        b=H68xD+wxv0xuHRQUzFpTIefj1r21l/Nt5f/pUrimBhiVKVt0rxhgAvB38JSLTU6PdZ
         SMCoasnbrpJpdxRjR4+T4vcVnbYsllBJjqA8/JLK3sd16vcA72Mwu362tQxrzHAcP10f
         JQMzLC9V2jjUpt0VGxvHD589b/oHin4BodhUTpI3DM1sxG9RTMS1QfL6Af7RMFDYX1HR
         AmSVvvaQmxkcx6pQjGKfNYk3LyGs+XOSaq4i4MZQ3fbug2byYxWtTgPA4LAwkh38iBv/
         ynpTEA4zATdn2w8iGBDik2LcbwsWE8AxU2Thto1goM4bYn6gTIphjLNtwfGFr5zp0ZZE
         XPwg==
X-Gm-Message-State: APjAAAUCrDeghZzygzAM/IvF6H9D4Z0w+WqfUABCc3bd6hEif6WZOY64
        +4IDD1fqtx9sV/PnsTaD5j/e21DUyak=
X-Google-Smtp-Source: APXvYqxwrcP6tgZ+Cn/BGiRQhmX25xrIEbmdHjEGFfzqljCsAWuX2UCiX97DGxggqL+Pgk1BdiMUpA==
X-Received: by 2002:a63:b346:: with SMTP id x6mr519112pgt.218.1565808443994;
        Wed, 14 Aug 2019 11:47:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:23 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [RESEND][PATCH v3 11/26] drm: kirin: Move workqueue to ade_hw_ctx structure
Date:   Wed, 14 Aug 2019 18:46:47 +0000
Message-Id: <20190814184702.54275-12-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 0e0fe1cb945f..ec4857e45b6e 100644
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

