Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED89C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5678B218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQairEvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfDWXXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:23:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40350 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfDWXVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so8361220pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vuhHNfWnMx8uWZhY+QeUk1qBtGP4f5NldA6jQRHm+6s=;
        b=NQairEvLvSGh1SguVJ2rpCemcsun3HCniG1nJhW94XLuu7Ucb+iUdicNtGfflaMyUt
         MkrpWYirbCzWneqOb6R778tc9wbpCvxtcsrXfukpO27qUFuVsgTpP46Y5lrOKq9SR+zY
         ggMFp7R1m+u3dwTHZ2tIJW17pfMqlvGUsrZChyaGacT8cyxLEUyN9Qfc6jSMCBMGOZLl
         tHl5Phh9o8xC65tjxfg+VOplgFnhiaYcsGeR9QqyVVZJdXv+hRopVBIckebvJOQpVQNj
         FbpPMtEnmslUKSHEwPR1cmD/JV6yo9G1WlwxkY7QWyb2LCkNk64yJ7ARC+xgLv0rkL9c
         YD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vuhHNfWnMx8uWZhY+QeUk1qBtGP4f5NldA6jQRHm+6s=;
        b=ejRNq/c/AiB/pTFPTQEETdS0DqqNxHJRth4NKFspo0GxSRFYaExuW1zkyZnUoYyF+l
         uNzLzKubb7uevjDT20jR141ptG/w97kNEzDxAn2EU4DzuWlE96SgRqqezBC7FZ6PnViA
         vlN5L7L3cGa12wkSQ8TDXOJAMD7iC6P4nY/Q9tsC7SoSgwfUi1UNg6IvsdJOlRI2Amqk
         NDyNJw12BdAHb1Y76+nR4U+OeRjwyICyJwJYPRGJc4vEkWKSx9wWBm3tdtQBdR6NjAaf
         taq2u6hsz1s4nGzPBDoX9LiM/AG5z0XZ0AtV/bWiuUMHWG+PkubPDtMuKhp/BIKZ7OX7
         0k9A==
X-Gm-Message-State: APjAAAX9CtMmzjcts/ayALuazcv4mx9kb/s6bLUFL0F8sQ9a6pza9pxX
        T+swQGdsW/KFTVi1TwM5nReSeG+zguM=
X-Google-Smtp-Source: APXvYqyU5nndpzr0QoWum+fQJyhtInddKfe6IAExSW1yiBxCfRbTNkbhkh/AY20A0+K5tMxuOD6cUA==
X-Received: by 2002:a62:1c87:: with SMTP id c129mr4927145pfc.113.1556061666498;
        Tue, 23 Apr 2019 16:21:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:05 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 04/25] drm: kirin: Remove uncessary parameter indirection
Date:   Tue, 23 Apr 2019 16:20:35 -0700
Message-Id: <1556061656-1733-5-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

In a few functions, we pass in a struct ade_crtc, which we only
use to get to the underlying struct ade_hw_ctx.

Thus this patch refactors the functions to just take the
struct ade_hw_ctx directly.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index beb2a3c..56a55d9 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -210,11 +210,10 @@ static void ade_set_pix_clk(struct ade_hw_ctx *ctx,
 	adj_mode->clock = clk_get_rate(ctx->ade_pix_clk) / 1000;
 }
 
-static void ade_ldi_set_mode(struct ade_crtc *acrtc,
+static void ade_ldi_set_mode(struct ade_hw_ctx *ctx,
 			     struct drm_display_mode *mode,
 			     struct drm_display_mode *adj_mode)
 {
-	struct ade_hw_ctx *ctx = acrtc->ctx;
 	void __iomem *base = ctx->base;
 	u32 width = mode->hdisplay;
 	u32 height = mode->vdisplay;
@@ -301,9 +300,8 @@ static void ade_power_down(struct ade_hw_ctx *ctx)
 	ctx->power_on = false;
 }
 
-static void ade_set_medianoc_qos(struct ade_crtc *acrtc)
+static void ade_set_medianoc_qos(struct ade_hw_ctx *ctx)
 {
-	struct ade_hw_ctx *ctx = acrtc->ctx;
 	struct regmap *map = ctx->noc_regmap;
 
 	regmap_update_bits(map, ADE0_QOSGENERATOR_MODE,
@@ -515,7 +513,7 @@ static void ade_crtc_atomic_enable(struct drm_crtc *crtc,
 			return;
 	}
 
-	ade_set_medianoc_qos(acrtc);
+	ade_set_medianoc_qos(ctx);
 	ade_display_enable(acrtc);
 	ade_dump_regs(ctx->base);
 	drm_crtc_vblank_on(crtc);
@@ -545,7 +543,7 @@ static void ade_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 	if (!ctx->power_on)
 		(void)ade_power_up(ctx);
-	ade_ldi_set_mode(acrtc, mode, adj_mode);
+	ade_ldi_set_mode(ctx, mode, adj_mode);
 }
 
 static void ade_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -558,7 +556,7 @@ static void ade_crtc_atomic_begin(struct drm_crtc *crtc,
 
 	if (!ctx->power_on)
 		(void)ade_power_up(ctx);
-	ade_ldi_set_mode(acrtc, mode, adj_mode);
+	ade_ldi_set_mode(ctx, mode, adj_mode);
 }
 
 static void ade_crtc_atomic_flush(struct drm_crtc *crtc,
-- 
2.7.4

