Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5449BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB8722CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ab9GXq7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfHSXD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42663 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHSXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so2075861pfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q1UYVKf1UgYkHQbbceABIVFSdc5VY9rhqkw1qWPFE+g=;
        b=ab9GXq7B96HrAHyFfqyB0/SPavCGYM0CBq1M7QwaRzyzcOoG/3afd74oYCMfInshTg
         hLsyEwv60UKNsjwuct55PsKKKt/LAKLHOLVqL9Mj0cEXTXGHXes9s5sPWoiuurdNSIn7
         NeQD+IVzTENa7LlNjPbWMcq7Yy1ZbkRtcy8KwdyPrpPX6Rb7IxVFUiPnqcDi5gbKcQcY
         ZJ4OZZ4rWPSYllkJ9V69GoBfhuRrQckHdmX4huxA34pVbHm38CUuOKoQfMnyY0fadCyQ
         x7PbuyTavmtPMYQG9lgXCL4Ay8L7QeMVU1lmEUSA9//y0YKtAD12EPaHuqYelCkVhPMD
         hN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q1UYVKf1UgYkHQbbceABIVFSdc5VY9rhqkw1qWPFE+g=;
        b=Lbyw5p+/2jiEvBah4GsrJfCiMx8HqGj1LFHyb4uW5AAW4O/QTJuN+kDMvuzwCazFnE
         3O4H0EczB2f3/kHrLD5zcCIbjDqPDJcpNtA1HMINzkRHsk59XeYFKDjV1Rhvvs/9gE1O
         YzHEmq7xGm0uLHQhYjwNEaI14QCytdZ8Xmdg4adbMzyA3tphaPluaKyJCjRBIV/9DbNA
         EMtkIXTowD1YRXQX5B4ZDAiuc4hCf/sgvQoDan/vU1Fs7/HD/KXXpyE/dAbv+vifNPBm
         1zlcyAGxnrc67u+tVRg5sK2eY67umTyImtdaBa34BZE4YZdsqX5vaB5Kt8+wVSVbosi/
         BKhw==
X-Gm-Message-State: APjAAAU1AqykjRwRz/UzjO35lO8RXD5O+URs7qK7onobFuIk20l1etQd
        gslrZyr7K36qTaphaRfnfnJfCjHRCCw=
X-Google-Smtp-Source: APXvYqyB8vL4FN4upHc3oHtcKzz/huky90s19ONqkA7aY0oJxDED+syrRBcbnqlw5cJ6oJHc8Ob/4A==
X-Received: by 2002:a17:90a:c20e:: with SMTP id e14mr24271052pjt.0.1566255807044;
        Mon, 19 Aug 2019 16:03:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:26 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Da Lv <lvda3@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Yidong Lin <linyidong@huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v4 01/25] drm: kirin: Fix for hikey620 display offset problem
Date:   Mon, 19 Aug 2019 23:02:57 +0000
Message-Id: <20190819230321.56480-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Da Lv <lvda3@hisilicon.com>

The original HiKey (620) board has had a long running issue
where when using a 1080p montior, the display would occasionally
blink and come come back with a horizontal offset (usually also
shifting the colors, depending on the value of the offset%4).

After lots of analysis by HiSi developers, they found the issue
was due to when running at 1080p, it was possible to hit the
device memory bandwidth limits, which could cause the DSI signal
to get out of sync.

Unfortunately the DSI logic doesn't have the ability to
automatically recover from this situation, but we can get a an
LDI underflow interrupt when it happens.

To then correct the issue, when we get an LDI underflow irq, we
we can simply suspend and resume the display, which resets the
hardware.

Thus, this patch enables the ldi underflow interrupt, and
initializes a workqueue that is used to suspend/resume the
display to recover. Then when the irq occurs we clear it and
schedule the workqueue to reset display engine.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Da Lv <lvda3@hisilicon.com>
Signed-off-by: Yidong Lin <linyidong@huawei.com>
[jstultz: Reworded the commit message, checkpatch cleanups]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Minor cleanups

v3: Rename workqueue entry for clarity (suggested by Sam)
---
 .../gpu/drm/hisilicon/kirin/kirin_ade_reg.h   |  1 +
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
index e2ac09894a6d..0da860200410 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
@@ -83,6 +83,7 @@
 #define VSIZE_OFST			20
 #define LDI_INT_EN			0x741C
 #define FRAME_END_INT_EN_OFST		1
+#define UNDERFLOW_INT_EN_OFST		2
 #define LDI_CTRL			0x7420
 #define BPP_OFST			3
 #define DATA_GATE_EN			BIT(2)
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 0df1afdf319d..d972342527b8 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -58,6 +58,7 @@ struct ade_hw_ctx {
 struct ade_crtc {
 	struct drm_crtc base;
 	struct ade_hw_ctx *ctx;
+	struct work_struct display_reset_wq;
 	bool enable;
 	u32 out_format;
 };
@@ -176,6 +177,7 @@ static void ade_init(struct ade_hw_ctx *ctx)
 	 */
 	ade_update_bits(base + ADE_CTRL, FRM_END_START_OFST,
 			FRM_END_START_MASK, REG_EFFECTIVE_IN_ADEEN_FRMEND);
+	ade_update_bits(base + LDI_INT_EN, UNDERFLOW_INT_EN_OFST, MASK(1), 1);
 }
 
 static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
@@ -345,6 +347,17 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
 			MASK(1), 0);
 }
 
+static void drm_underflow_wq(struct work_struct *work)
+{
+	struct ade_crtc *acrtc = container_of(work, struct ade_crtc,
+					      display_reset_wq);
+	struct drm_device *drm_dev = (&acrtc->base)->dev;
+	struct drm_atomic_state *state;
+
+	state = drm_atomic_helper_suspend(drm_dev);
+	drm_atomic_helper_resume(drm_dev, state);
+}
+
 static irqreturn_t ade_irq_handler(int irq, void *data)
 {
 	struct ade_crtc *acrtc = data;
@@ -362,6 +375,12 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 				MASK(1), 1);
 		drm_crtc_handle_vblank(crtc);
 	}
+	if (status & BIT(UNDERFLOW_INT_EN_OFST)) {
+		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
+				MASK(1), 1);
+		DRM_ERROR("LDI underflow!");
+		schedule_work(&acrtc->display_reset_wq);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1038,6 +1057,9 @@ static int ade_drm_init(struct platform_device *pdev)
 	/* vblank irq init */
 	ret = devm_request_irq(dev->dev, ctx->irq, ade_irq_handler,
 			       IRQF_SHARED, dev->driver->name, acrtc);
+
+	INIT_WORK(&acrtc->display_reset_wq, drm_underflow_wq);
+
 	if (ret)
 		return ret;
 
-- 
2.17.1

