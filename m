Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1DCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F0820644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1pVzeLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfHSXDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34014 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfHSXDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so2044063pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sMMNrNPEyr5ojRnGMae00OuNvWMz/twMj42dMKt7nWI=;
        b=v1pVzeLVL4i2QM63LjdIG16cVunIA1wDrcWnGZLbSWTLQuViS6sU6eb1I4/agTCUDc
         t+ZtZed/2TMX58/fHKD78fEnRgbm335xveJAkCf4IuL/CxHn5fjilap0t8YkgZxLj0qe
         0bUhKZ5dwWZ0IdOmoETmqGDVV+rLoDNfdFgfidefk3MkiePU1eBGttWbh1PujCbR+A1u
         dR+mi7XMVr3BzexefjBdeM4Q3RhFtJT5LpJZWYnvW/OimWUTcNTYpKGLdLnhwwHTQjKH
         8Rw5PJSi5pDJnKmKfkR7Vsm7n+MME4k4sIfpwYhJi5DVvKW126bvgv0PgVOxqlviKzFT
         /Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sMMNrNPEyr5ojRnGMae00OuNvWMz/twMj42dMKt7nWI=;
        b=LWPsu2zvd/QNGwc1+KAA349r6fwZcMbmSS9PovP/g2r3/30/ivXIVxc1UI+Snc5rkF
         ugHOhj8ywqg14QKRehiuSzz41n1zaplIE3jAQYYmKiQicTqKsyGg5Pr0lAK+yGMe5ohd
         P8jWbKMWwgSUxysld0lMXbJucEhOQthLOzF9uAz+GY14AZk+dIGaaU5dVtiAFHg3P/6W
         h36vf0X5ZnrUO/A4+gCc7ZjeiDFA5q30u9FHoqlGIdVaJOl2obN4kzngssg0bhYkrPUw
         dQ6NPw2oESqTZabKotDjMd0jplljN7mIr5TTZ9PU3IZ1t2tHqw9AqIuBhDatAObXw5VL
         DsJg==
X-Gm-Message-State: APjAAAWJ291/Rfo5XaOf/2IEutS0UcF5rTLHY9nLQt1I+7ugtA7zfUmi
        SP+N9RgNI6TEYAG7B+Kcz8mdErkLis8=
X-Google-Smtp-Source: APXvYqwb1NlOHGixTVWfKWtPeGyyczgYsv1+r1jQRk7O0IlMpAWvAHx5RA2P2qeq/kAH+R2FQKrW1Q==
X-Received: by 2002:a65:6458:: with SMTP id s24mr21839142pgv.158.1566255811461;
        Mon, 19 Aug 2019 16:03:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:30 -0700 (PDT)
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
Subject: [PATCH v4 04/25] drm: kirin: Remove uncessary parameter indirection
Date:   Mon, 19 Aug 2019 23:03:00 +0000
Message-Id: <20190819230321.56480-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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

