Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C266C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF6E2339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IB7XgmYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHTXID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:08:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44187 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHTXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so209763plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sMMNrNPEyr5ojRnGMae00OuNvWMz/twMj42dMKt7nWI=;
        b=IB7XgmYvkwQEJtHZlzt4hH6T5NopJkfBoayNv/GodStcZXxTvSt35M0eDDE9K3LV2X
         t34RV1DW6QSCYi7l5B5gjU/nC/lzfgqYLQUgPK/FHUm7Q90eU6Xs99OSlhMpSBUAFZu/
         Yimi+ol1E2NCdt3K/+oziOzE6uaD+OHWte422JmbCriql6H9kOHQKD/tsCDvM56LPSqq
         xcAGaApq98JTw0Q04lqdwrHP703sVt3Vds/7vEiDMpD3keehlJIiDsFeg+/lMwH4ucqu
         0nxmOsfgPHJW/SjDgWdvnebrKFcXAhGduTdxDSkzdCzBM1GIttYl8RXIDDS2rgs60whC
         iuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sMMNrNPEyr5ojRnGMae00OuNvWMz/twMj42dMKt7nWI=;
        b=IdII09aObfmDcZPVxXpStqhGt1UUE6bXTDsoiWDnhV+9zjQyqOkhjVtAnvfjvWfqoC
         WhA9LezXlsH9l4oos7+RnIpwqVnwL1jEDnTNJHNEFWBoAjYa/FZBSjm6Vw9TMBfh4vHg
         rtWUKsSZGNszbm+5Y6DFoendJAL331+WMv98UXGNBR2l1skR5v+GB6kXn3xFHFxFHHpM
         k0YaumB5QIxhMWs6Z97FCSCeETQW+3y3ZZF/d6UABZiztj/9dZ08f+3QNEFYAqww3iog
         pAb/VE0lQhLUbFB+J5UFXBclqQaUW+bycy129whGSOSSgFJTQ3T0f6kSq68eCkQ3StRO
         CtIg==
X-Gm-Message-State: APjAAAUU8UtMLzwr+MHSHnr044DDcfQwDC9kMD4/WmEsLJ7k7KiVGJjv
        h/MWJR53NbsNPx6RgiBvAC+gwf1Erx4=
X-Google-Smtp-Source: APXvYqxvBHkagafXH1CnZDG8/J2NJtGYyNSNZb9XstBXBy84ZynIq7jqLkNKO8FL/LW4w2k+JTFkdA==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr31408400pla.197.1566342395612;
        Tue, 20 Aug 2019 16:06:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:34 -0700 (PDT)
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
Subject: [PATCH v5 04/25] drm: kirin: Remove uncessary parameter indirection
Date:   Tue, 20 Aug 2019 23:06:05 +0000
Message-Id: <20190820230626.23253-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

In a few functions, we pass in a struct ade_crtc, which we only
use to get to the underlying struct ade_hw_ctx.

Thus this patch refactors the functions to just take the
struct ade_hw_ctx directly.

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index d972342527b8..45351934d919 100644
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
2.17.1

