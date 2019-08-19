Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB76C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D58322D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgcwVUUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfHSXDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46870 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfHSXDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so2066558pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/TlFFqIFbnuilFAvaZfscTqwSZVj/Gq+GQdJwcM1CA0=;
        b=hgcwVUUFRgX2aXe6K9MjaC4D+BanRss2Q2jrB1rrfCaADjTGn5sDv45eNjCcFyKLIe
         PIvYw89RcFgIn81zquWXrnuIUpzGxzJtQUtvEyNosp9u+9O3t3gIEgbk1aZihbQcZTwh
         4fgPQ3madaFPBa+0VTrK2bKZd6MXpkDQ07NcXmikunyUGTBw6GBZ/edjVUT3iRiGrlZR
         JmRZ4jC8OrPe4WC6cHNXI18P9S66KgwPlv5+OmKp/4tmvLqnY09VpNDvcyxgyn/A7jpB
         DJcPeA+nnEyZ7p4oGU1SQ4sc80J9YwV8BTIoHgux3TWBzOPHNpdmiqxLEmKO10DQelVM
         HdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/TlFFqIFbnuilFAvaZfscTqwSZVj/Gq+GQdJwcM1CA0=;
        b=uX60zCnaM91MXSjMOPW7Bv4l++vYCNwtppKFuuL52bRIcNhWRwDy6agQ8yN/tlDTwC
         L33eeQ8R2WD8/iqPHRC+SwX/KmXOlHgOTnOQ7OhOe7npj4Na8qEHgTVhyEuMig3POnsA
         3fv4k7TrvYpmI2fQpHzqqPTkW9cTV18Cv4KUN4ZzqvtwiPV0sHcNvG3j/WroYlzg2J2z
         aSOygIvy8eOAGsYumR471R+Vouir5gJrAgTDWcDK8cde9bM6qfcMTaAWGyCK8LjhvEQn
         c6Iz5eGGcwwGFmf4auuo1YwEP0CILELroj4V/ovQ4UtYBk/LNxzJXO4cXbtR4buWsHH/
         GieQ==
X-Gm-Message-State: APjAAAUr1WKcTOknANAE60Sc8pbztnC0GZkZyvayjyayNb/8OCAECe6r
        Jw9mIKQygwMsBuvfKn0f7VZ1Mi0HFFU=
X-Google-Smtp-Source: APXvYqyWqYQNrDuG8LREU+B0avmfYSvzuL9p3zVo2uDjdgihR2paZfBlw3v2n8AwccWd68HPPn+P0w==
X-Received: by 2002:a62:1a45:: with SMTP id a66mr27430092pfa.142.1566255815916;
        Mon, 19 Aug 2019 16:03:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:35 -0700 (PDT)
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
Subject: [PATCH v4 07/25] drm: kirin: Rename ade_crtc to kirin_crtc
Date:   Mon, 19 Aug 2019 23:03:03 +0000
Message-Id: <20190819230321.56480-8-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 74 +++++++++----------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 19d279167694..fce374ec69e8 100644
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

