Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76820C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0F521851
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qy1YElo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfHNSsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:48:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43838 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbfHNSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so6309247pfn.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvs2sCjFBJ8XOKE0DuOatJnI8ohKITzd4uZXKHqLHj4=;
        b=Qy1YElo0lJ4Mf6kN0jaRh2yIv0ViKyJtzsyZBUhZluecH4U150hrQ83VWkx8QzXBK3
         AV5sKvB1a7h+tqmBY3lJgKcd+lbjRio/sK3GvLSgX15cDSD8R7yBqKKpvu2iBeuGwEXq
         AqWDp/GasCV/C4aRRFVUSA2m2SN8HqAxne8QcM0ZjFLZCKgGK86eMw5Bm2KkHZ3e07nu
         MzWUDDIBuqrtQAdb5uhOjYFDhO0i2hT3t31UiihjKQ9fyd+yuDxvQK9D474U6YU3kDtS
         aWPmCZOZLa1ZNBh++OUx3a0AOC+nR3ofGKP1c7oGwbuha8y8tJN1h+UGHcvjrNw4TKHC
         P2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lvs2sCjFBJ8XOKE0DuOatJnI8ohKITzd4uZXKHqLHj4=;
        b=e0uI0RvKN9AXirAW0fRBIj+DXnz8VZKGSlk1WEJYln6TnN9Ee+zudh+t+8AaxtseSE
         laYmyZbZUH8bNAc7gTvQZ11HK6mw1AkvuGEiavfMsCgJNQwIK7bIBarMZ1U2/o4pJ4pp
         vSDlkjkIwE5k8yEZ1ENC1TDnjZLOR7/5jXTseKJChvyvlT73NKwbZzOtWDzsRYZjdcpz
         j9ezR59jfuquDviFJ3pXZKFWDO/6jGQcB6Dn2SNyYgM4PvUKo5X8qhLKT6P6FJ5R3023
         18Tc6HhhzU4JHnZuqlOkr0GEqfSBtpkpbinEJisreNxACjep6C1eQD+D4nBwvRW6K52w
         RJcg==
X-Gm-Message-State: APjAAAWxwwL13vAVvXLoDAoE9YVz8lFlJF/YtXInDfvWyYXppEUHP8zX
        imvN/hUWZU8Gb6bpfumbvBgLUNq7Ciw=
X-Google-Smtp-Source: APXvYqxxHQvsB1s/SEiK5v/iMZji4sqIw5BCV4QU4QLiSAN374eua3x6HznNA2qVuxDoXmCglbCI6A==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr1377305pfv.195.1565808434877;
        Wed, 14 Aug 2019 11:47:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:14 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 05/26] drm: kirin: Remove uncessary parameter indirection
Date:   Wed, 14 Aug 2019 18:46:41 +0000
Message-Id: <20190814184702.54275-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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

