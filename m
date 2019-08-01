Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4FFC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5AE21726
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEzEX4JH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfHADpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbfHADpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so33164264pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6mhNt9xKY3uV6IZqhaRNS+0qqJSN5zpoSD/eavy3uU=;
        b=vEzEX4JHVuUi5sYWo6MR1DLYLnODyR9Lkq+GuIce+gy0uur0/q7RL3aqHaX60sB2QY
         e0vT1vQfQB3bxmbNeWqNTHaoJxk/z/Mr567FQbh3EVVuekusAb0zloFF5PbR8W8/f1uW
         G8vwxvMZtt2GoBiEwTUHQ5U6UJTEfwa98UVB8mimPQphNKA4h6Fio4aEHXmUgz+/Gx8H
         yoQjKUIehHdbRSvgLX5jcXqYYRfqE88vbn8IHAe3WQXjHUurf1B4FRZUOhc7Y4DSl+lW
         86BsFdYSqDfLWQe1fr/jA1WUeGK+v+9v8IfI8BJMI741YvdP+y+A9a63vDkGZjWePEWh
         94vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F6mhNt9xKY3uV6IZqhaRNS+0qqJSN5zpoSD/eavy3uU=;
        b=TtLKufI3GnYfFWSv4a2nJSav7ki+mi22wlQ3xVidg0GuoZvAp45iLnIgDgoFSVmMFe
         O+K5RUml5irFX1w7iBLia8+gU+D8F+T8eY325BlDIxOxHJQxLswr72q4nolMjmLbQvoz
         S8SwEHDV1bKi4dwWICBjbnA0v/bfxBvzCZ0GfJqteMiXlUofJYPbZDnvCxX9Y0KkfzRC
         Ud4miucXwe9Dvzys9Gi0+6TbLCPuX1hHjCRZr7rH7NAdl7yokQUUuYHq0pLoa/RGcKRK
         qD8pmv/OcNVlqK609YLOZ7CMc90qMCWverx1gQ1ssCvHgkfSne2cbOpqHaLeYp/59+jx
         c6wQ==
X-Gm-Message-State: APjAAAW6ct2iOpn2s1aYfq3FEHfhzrF0H5qcm+xTTvYOghU+m2T29gSE
        oD9fc1FT7CUSOM6eQrGNdGwobmcHaro=
X-Google-Smtp-Source: APXvYqzUf9MX/78dPWJhL5pQmUlIgIXdOyov3muaXgm6GM6xJ64ZGPwiBUJA5inxS8yWFTdCXCsnuw==
X-Received: by 2002:aa7:93bb:: with SMTP id x27mr52442349pff.10.1564631102402;
        Wed, 31 Jul 2019 20:45:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:01 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 11/26] drm: kirin: Move workqueue to ade_hw_ctx structure
Date:   Thu,  1 Aug 2019 03:44:24 +0000
Message-Id: <20190801034439.98227-12-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue used to reset the display when we hit an LDI
underflow error is ADE specific, so since this patch series
works to make the kirin_crtc structure more generic, move the
workqueue to the ade_hw_ctx structure instead.

Cc: Rongrong Zou <zourongrong@gmail.com>
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

