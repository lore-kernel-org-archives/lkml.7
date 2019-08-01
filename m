Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D4C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304C206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRnBOW0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfHADpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44744 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfHADoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:44:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so31474221plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uEC63dbARYEuBlfRwpeBf8DWjhjcKGFjgUkUYEDal2c=;
        b=vRnBOW0k+1Eg+RO86kU/byWqXZO9hXCUEe93OtnP7i+y4PXdVg5McCbFb1f5MRy2RS
         RohLpJZEfhAUCcVrDUb4vJTMC3q6GO8q2UR1COosrAVvIlhSW7420qSKLOgAD4WBBBw6
         KuDaSl70QaywqUqFDR7ZWXlBwZRZtWIYue/PlUeHjPRHs5SgYp22jsIE4M4HeQocfLi6
         1ozKxtqdd6b7RIv+ldjSbyUdFo7DrXj3juTCByOncD0xGM2b/a1fU27HmmShG6Lme4kN
         fkaXleAJopS0b084QGZsCIxoo+gSizQEvdoo7ELcJsG2EyyfGtisIYjfZ26JGy0R6rYM
         ZekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uEC63dbARYEuBlfRwpeBf8DWjhjcKGFjgUkUYEDal2c=;
        b=ZbdLUStR7eKsqzYBY3cS/dmAmIYd2aKJsaQzIk627761v/szmxWJJe7FqUFESam9GL
         a+2VtAQkr2J4LQ6LM3zizYnXtDA9oqxBMoUk19XaF5f5iLMCn4H1/5W/2QPAPxmp3ju/
         aRTlcDFbDVOUf4VZ3SZG5j8q61hwQY7fo+M6Ttm8XaHoiGjWmkkaEljF4yDoIRELfYco
         qZ/8Tvv5ywm9fp5ihWXnZZVlHBpaHA/v72jhdqvMJ+FWJdaRI9hU9EmYfl+XayeaXjd3
         lOENMFUNj14bUgUwHaQvtZYeOwQ5vqSqx/R0WC4/58vDedpDSQ35E0wLlSherF5aHZLM
         6x4Q==
X-Gm-Message-State: APjAAAX35ZHWc9cjNTxxqwn2TTgiDHMlO1/sxsJtV3tOYm4upEbt4vlb
        r1xC9P8IaY75Pc4yzk2phQHd92C6OTQ=
X-Google-Smtp-Source: APXvYqyFPrpF1ZkyRxvqbslTyH9glBjcshx+BTBA0o+bExSUREc6tM4oDj8esscrMOpDE+uS5xwn+A==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr125030318pls.156.1564631093229;
        Wed, 31 Jul 2019 20:44:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:52 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 05/26] drm: kirin: Remove uncessary parameter indirection
Date:   Thu,  1 Aug 2019 03:44:18 +0000
Message-Id: <20190801034439.98227-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 9a9e3b688ba3..756aefd5bcff 100644
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

