Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EC722DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJ0xYmr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfHTXGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39477 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHTXGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id z3so221531pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q1UYVKf1UgYkHQbbceABIVFSdc5VY9rhqkw1qWPFE+g=;
        b=RJ0xYmr+le6e0PlBTw1zfPraNay7cF0OyB+nOHMyagiieh4nJXKPXaQvS3aMZyvjTO
         Dmk6dfoWGfWJkSpVdRwNjNYFsKpUZv/XyhMjb5cR/jkPe1xfhvU5GQb/mYk98XWCrRC/
         hPu6nj+BMp2Yp5fK72qMJzbYwo/+3+MvQ0/3QmbQb7UvOVNhCwuys+knWVVbUj/WGzrq
         5t+Z0pcOS3tIeJzDbdFTrjDoTkODIjDU1gC9ZudISnCQ7kbGGkZrDEswpYDtE30wx3tb
         Sd3hLENL8vNNiIh5S1hSRAhpRF/ZlPpW72Vs+AgHzTX5T6wwgAg08by4npeNAxrO3ZDu
         i6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q1UYVKf1UgYkHQbbceABIVFSdc5VY9rhqkw1qWPFE+g=;
        b=Csx2DRrMfQfjI2zbA+5D9tmKbHljROwj8UwuuWX2v7WHYRh55tiKONjxYNvLGifBfm
         5/DPrBBqallOAONXjATJveDQgqs0+I4AY78/LqgCsP9SRbDwlsC1V9+5sjexXV8OMN+H
         ujehli9jqnhaBX+Dne0wO6MjTj+zcRiApQYL41xe+WV6jI0Vac/xb2IFp4banZdaHkTF
         mwj68gtOKrMm26fkIVVFXGgGCyPv7DbtNP2KqpHn3Mdb02aCsqhFPXJybkDYe12QQcyA
         8cdmDoQ/OtjkbFCRc6MwSKbG34UdCOajje5Enf3NCKPcojQXUpVP8lWltMgFYEkIIBV4
         dk1A==
X-Gm-Message-State: APjAAAWmDz++2WY3Yi2Ox6pGjguz0KxcgcPsUs1myvKM4fiY1ko+E03l
        3ukWG5QnUk3lz/6TBbqjwboNVvSseGI=
X-Google-Smtp-Source: APXvYqw5D4BZDetSBcN2Jnla7obS49bgLF/nwN7GXXGmMfCHVZaEj82kGnEeoSYhj3aNYpuZGpkXRg==
X-Received: by 2002:a17:902:9895:: with SMTP id s21mr16299078plp.255.1566342391778;
        Tue, 20 Aug 2019 16:06:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:31 -0700 (PDT)
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
Subject: [PATCH v5 01/25] drm: kirin: Fix for hikey620 display offset problem
Date:   Tue, 20 Aug 2019 23:06:02 +0000
Message-Id: <20190820230626.23253-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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

