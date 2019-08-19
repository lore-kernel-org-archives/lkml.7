Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C13C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863822CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2V9cPKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfHSXEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:04:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38228 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfHSXDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so2037319pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+HPcPs0/zlCUibj+7sx/QSMq53DKHKeHt3X4baMNzZs=;
        b=l2V9cPKgC+xQf+M9Eq7V3R8A3hyhWD12bHUmsJxWIyt0fstaXxqCmLfeGxRgmVOXqy
         7B1Apsgv8PJHo4NM/w9wVyo2A83K3EejfwDWpzf/9jW7IpeJTjDRkJKdwAvN4ABQVs/T
         fVyIrAOR44GEq3ZqXg6hS5HgyrNA1aO74nqpvIdI2IG9dSUUkVeBZtCx9SCoI3eEe25L
         AYrm9KmrTi6I0zf05rvkRW/Qcdwl8mYmmX0sGPiRfgn10oRr9LFfYeWsQjU6v3kbpzvT
         xAWummgxsvsYfQWrtNRvuIYBsP92PNtkufKW7vNvuhVChCUj0Bmg+T+zSHkPFrlvsBEz
         yTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+HPcPs0/zlCUibj+7sx/QSMq53DKHKeHt3X4baMNzZs=;
        b=oqWSsuQoJFiWI9+5PQqKrH+l+FJkm0tjJXoHW2oJk/NrWRBtYiDAwEf45KcSPB5mZo
         3tRtsCGd8rzhZ70aBj63I7nqKVT/yi8J/OSRfrqH75PDDlAEYJ+3f85I2hvn6+PTKX/w
         HiV1cbiGJDrHm+XXtvwHVpRWhB72mDCpQxeYUvN1f5JyZv6RqyDhGAB40rcMuSBuwnPR
         zkrnxWBS9o5nGfoUokayCMslWvBNQbRg8WAjT6vwla9oPNsUlGDmyBZBBRRWvCh5IyHx
         maDL0DQHwGFhaA8wObGOLLcTNgXcjbwpauqX12TntsepFsXIKzik9jA6SFGC7UUov/6V
         BQug==
X-Gm-Message-State: APjAAAWVAbEi1ykFVHA+/HR3wNj7Qi30WsGdk6gWOuRcltgJGhja5/Gy
        8IQaedGieqmhDyKLk5D4mQ3SKAwdUsY=
X-Google-Smtp-Source: APXvYqyw7LbadLphD6JSmUioN4e4iV4Ibw8oT+is92wCfKEWMmhG+Ndg2xlLGksLs39nRlBJXygTng==
X-Received: by 2002:a17:90b:8c5:: with SMTP id ds5mr23549322pjb.142.1566255820961;
        Mon, 19 Aug 2019 16:03:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:40 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 10/25] drm: kirin: Move workqueue to ade_hw_ctx structure
Date:   Mon, 19 Aug 2019 23:03:06 +0000
Message-Id: <20190819230321.56480-11-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue used to reset the display when we hit an LDI
underflow error is ADE specific, so since this patch series
works to make the kirin_crtc structure more generic, move the
workqueue to the ade_hw_ctx structure instead.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 8f50115a22d8..191ee59f68b6 100644
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

