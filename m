Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B6C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E703C21851
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hzt/VeOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfHNSrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45156 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbfHNSrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so8830149pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fr+/Pi2S9B6wdoWpzoVvTrtF22yjLCzedfYpDICy2D4=;
        b=Hzt/VeOQAtc+O3ahVY5yzSd/gQ2fP+233P1dAlG8ZFYWfpXRv2yfBBpmlp4s74nw+p
         bIdHX1J6cXzJMQwUL4Qmle5pzI+YfInoL1NGdUXnfT2nECm8GMUSJyR+8CwOxZJD/Om2
         LY8Zr3ttUQCTgeUJJQWIo3hkiAm0ymc4LKv7eMviU4lAhBZSqppMPoCftbyGG79EggsL
         /GN87Qxsr31JNXngR026FyQM6YYj8e+yQ20e2Q0oAKa+UTJhu0YAoaaAGfkTeBKC67lP
         nTboFyQegkbmQFjAx0R2XXZqb+liiIrJE1UWQ7HxcaOo1nfgl60mZmNNEsv33aJZWbWZ
         NmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fr+/Pi2S9B6wdoWpzoVvTrtF22yjLCzedfYpDICy2D4=;
        b=AeB6V//+37CRE14TgfihX4K7eMdRGH+MQIK08g0ePAsk9Ng0FADRZZVq+XJKPNtbhq
         d7Zn1Q4v5XaTyGRNOK7JYDs4y7bvPGhwksRYC9E8iVqQG2a49UMcQtISas7HtWMo1yuZ
         FtQWyoTAt4vfSDfBLpKsVJIHqtl2zhuUytNSEy8XL00gnXyUqB6qkooQ/vxrZhPk/SuN
         t5KL2ey1RRQHiIZJ4lWR3T9JH2DcOlsQtjUzepwWQ9uvLxWxVLkrIUiJD+EdZZCRNTBu
         nYph+JCBv14RR2TGBWoOy8vnOFkj9ARKgkmA//Lajnquvfr+pEtPDi2s4L8xE9z7Mw7m
         WJAQ==
X-Gm-Message-State: APjAAAVXFWSrzhJNRjITugO9I6TrUXBmmdOt7JKqBMXIC6AROQmLgRvA
        942127xPYVulDVRsh1qC+7AFy8NS8zI=
X-Google-Smtp-Source: APXvYqz25qEBowXuYDmJdMucOPok8ZyYp867yZ9aS4rBNEzKeqLTvI4N3IJIi7WYdVx+Z132OlVR4Q==
X-Received: by 2002:a17:90a:db06:: with SMTP id g6mr1123686pjv.60.1565808439301;
        Wed, 14 Aug 2019 11:47:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:18 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 08/26] drm: kirin: Rename ade_crtc to kirin_crtc
Date:   Wed, 14 Aug 2019 18:46:44 +0000
Message-Id: <20190814184702.54275-9-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch renames the
struct ade_crtc to kirin_crtc.

The struct kirin_crtc will later used by both kirin620 and
future kirin960 driver, and will be moved to a common
kirin_drm_drv.h in a future patch

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
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 74 +++++++++----------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index c09040876e68..ee3dc3d0f738 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -38,8 +38,8 @@
 #define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
 #define ADE_DEBUG	1
 
-#define to_ade_crtc(crtc) \
-	container_of(crtc, struct ade_crtc, base)
+#define to_kirin_crtc(crtc) \
+	container_of(crtc, struct kirin_crtc, base)
 
 #define to_kirin_plane(plane) \
 	container_of(plane, struct kirin_plane, base)
@@ -56,9 +56,9 @@ struct ade_hw_ctx {
 	int irq;
 };
 
-struct ade_crtc {
+struct kirin_crtc {
 	struct drm_crtc base;
-	struct ade_hw_ctx *ctx;
+	void *hw_ctx;
 	struct work_struct display_reset_wq;
 	bool enable;
 };
@@ -70,7 +70,7 @@ struct kirin_plane {
 };
 
 struct ade_data {
-	struct ade_crtc acrtc;
+	struct kirin_crtc crtc;
 	struct kirin_plane planes[ADE_CH_NUM];
 	struct ade_hw_ctx ctx;
 };
@@ -184,8 +184,8 @@ static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
 				const struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
 {
-	struct ade_crtc *acrtc = to_ade_crtc(crtc);
-	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
 
 	adjusted_mode->clock =
 		clk_round_rate(ctx->ade_pix_clk, mode->clock * 1000) / 1000;
@@ -317,8 +317,8 @@ static void ade_set_medianoc_qos(struct ade_hw_ctx *ctx)
 
 static int ade_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct ade_crtc *acrtc = to_ade_crtc(crtc);
-	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
 	void __iomem *base = ctx->base;
 
 	if (!ctx->power_on)
@@ -332,8 +332,8 @@ static int ade_crtc_enable_vblank(struct drm_crtc *crtc)
 
 static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct ade_crtc *acrtc = to_ade_crtc(crtc);
-	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
 	void __iomem *base = ctx->base;
 
 	if (!ctx->power_on) {
@@ -347,7 +347,7 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static void drm_underflow_wq(struct work_struct *work)
 {
-	struct ade_crtc *acrtc = container_of(work, struct ade_crtc,
+	struct kirin_crtc *acrtc = container_of(work, struct kirin_crtc,
 					      display_reset_wq);
 	struct drm_device *drm_dev = (&acrtc->base)->dev;
 	struct drm_atomic_state *state;
@@ -358,9 +358,9 @@ static void drm_underflow_wq(struct work_struct *work)
 
 static irqreturn_t ade_irq_handler(int irq, void *data)
 {
-	struct ade_crtc *acrtc = data;
-	struct ade_hw_ctx *ctx = acrtc->ctx;
-	struct drm_crtc *crtc = &acrtc->base;
+	struct kirin_crtc *kcrtc = data;
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
+	struct drm_crtc *crtc = &kcrtc->base;
 	void __iomem *base = ctx->base;
 	u32 status;
 
@@ -377,7 +377,7 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
 				MASK(1), 1);
 		DRM_ERROR("LDI underflow!");
-		schedule_work(&acrtc->display_reset_wq);
+		schedule_work(&kcrtc->display_reset_wq);
 	}
 
 	return IRQ_HANDLED;
@@ -499,11 +499,11 @@ static void ade_dump_regs(void __iomem *base) { }
 static void ade_crtc_atomic_enable(struct drm_crtc *crtc,
 				   struct drm_crtc_state *old_state)
 {
-	struct ade_crtc *acrtc = to_ade_crtc(crtc);
-	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
 	int ret;
 
-	if (acrtc->enable)
+	if (kcrtc->enable)
 		return;
 
 	if (!ctx->power_on) {
@@ -516,27 +516,27 @@ static void ade_crtc_atomic_enable(struct drm_crtc *crtc,
 	ade_display_enable(ctx);
 	ade_dump_regs(ctx->base);
 	drm_crtc_vblank_on(crtc);
-	acrtc->enable = true;
+	kcrtc->enable = true;
 }
 
 static void ade_crtc_atomic_disable(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
-	struct ade_crtc *acrtc = to_ade_crtc(crtc);
-	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
 
-	if (!acrtc->enable)
+	if (!kcrtc->enable)
 		return;
 
 	drm_crtc_vblank_off(crtc);
 	ade_power_down(ctx);
-	acrtc->enable = false;
+	kcrtc->enable = false;
 }
 
 static void ade_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
-	struct ade_crtc *acrtc = to_ade_crtc(crtc);
-	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
 	struct drm_display_mode *mode = &crtc->state->mode;
 	struct drm_display_mode *adj_mode = &crtc->state->adjusted_mode;
 
@@ -548,8 +548,8 @@ static void ade_crtc_mode_set_nofb(struct drm_crtc *crtc)
 static void ade_crtc_atomic_begin(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_state)
 {
-	struct ade_crtc *acrtc = to_ade_crtc(crtc);
-	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
 	struct drm_display_mode *mode = &crtc->state->mode;
 	struct drm_display_mode *adj_mode = &crtc->state->adjusted_mode;
 
@@ -562,13 +562,13 @@ static void ade_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_state)
 
 {
-	struct ade_crtc *acrtc = to_ade_crtc(crtc);
-	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
+	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
 	struct drm_pending_vblank_event *event = crtc->state->event;
 	void __iomem *base = ctx->base;
 
 	/* only crtc is enabled regs take effect */
-	if (acrtc->enable) {
+	if (kcrtc->enable) {
 		ade_dump_regs(base);
 		/* flush ade registers */
 		writel(ADE_ENABLE, base + ADE_EN);
@@ -1007,7 +1007,7 @@ static int ade_drm_init(struct platform_device *pdev)
 	struct drm_device *dev = platform_get_drvdata(pdev);
 	struct ade_data *ade;
 	struct ade_hw_ctx *ctx;
-	struct ade_crtc *acrtc;
+	struct kirin_crtc *kcrtc;
 	struct kirin_plane *kplane;
 	enum drm_plane_type type;
 	int ret;
@@ -1021,8 +1021,8 @@ static int ade_drm_init(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ade);
 
 	ctx = &ade->ctx;
-	acrtc = &ade->acrtc;
-	acrtc->ctx = ctx;
+	kcrtc = &ade->crtc;
+	kcrtc->hw_ctx = ctx;
 
 	ret = ade_dts_parse(pdev, ctx);
 	if (ret)
@@ -1046,15 +1046,15 @@ static int ade_drm_init(struct platform_device *pdev)
 	}
 
 	/* crtc init */
-	ret = ade_crtc_init(dev, &acrtc->base, &ade->planes[PRIMARY_CH].base);
+	ret = ade_crtc_init(dev, &kcrtc->base, &ade->planes[PRIMARY_CH].base);
 	if (ret)
 		return ret;
 
 	/* vblank irq init */
 	ret = devm_request_irq(dev->dev, ctx->irq, ade_irq_handler,
-			       IRQF_SHARED, dev->driver->name, acrtc);
+			       IRQF_SHARED, dev->driver->name, kcrtc);
 
-	INIT_WORK(&acrtc->display_reset_wq, drm_underflow_wq);
+	INIT_WORK(&kcrtc->display_reset_wq, drm_underflow_wq);
 
 	if (ret)
 		return ret;
-- 
2.17.1

