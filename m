Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C298EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E8120C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6WQ7sIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfHTXGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46125 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHTXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so134958pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IcvzzFr1yUCqUm7igC+fhVBaiFn8HJOuskJ5pNSj2cg=;
        b=s6WQ7sISarwjn/LoXRuWTs7T9mI5glGbXZ8EsPI3bJI84uER1hU+D4STDBevGNYS3Z
         eOvv5irY6DvPeWzChsKAuakSVEFkiW8fIPj9iEVuzTxRkakHzBvVbJl0FlVpnSJenv9d
         oUJ9gN9hBHJudtKn5GBt22PjFXTs1PV+hJA8u6D32MuR5+IQjqNaFWUvr7EnYQyDfM4e
         gRcM1L8/KdxdVssB84zN+ICvvYZKBrcOQUwjy8cozJJY6u/J9LfaZoSSyXmW9cieqa08
         AwWuH+bjNzMQG0fL+nLfeolv/+EHIUXxixtM7d/daNtzOmFYkW4AB5qLThiEB2YXp4Ay
         CTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IcvzzFr1yUCqUm7igC+fhVBaiFn8HJOuskJ5pNSj2cg=;
        b=YISrKbxOyOAiNISD3HH3hwrCSUDSCHt0YQPlZ43OPNFMKuYsPC2+NhSiJyYD/+AG8O
         HG7qfhDIwlalbjY8xT0LvZd/RSrMa5sCIUkASo+dRv07WtrOUHFGDbBJywc53iCE9db/
         0SVK1mdwWBBONjBlEKeLol0MUqwrsHbrtr1Yjn2IfWwVFpFydFBnNfFk2YxLNpIV0hGm
         Pozm2AXyiDzLyFhNIcmGp5uRu5KNCwccfUA0PExTbYSZ7+LxGAq0lWyRVMpPb4B+A/kW
         l2bcm/HMAMwLyOGv4C5dQ3JeHJwJnM7MhRleNGBdrRMsf47EWME5SLIn5QE7yv4P7bgu
         TIWQ==
X-Gm-Message-State: APjAAAVf/Aoj1X6iRwQjwdpUwJnPiGK65J5uxJsw205Pha7XfjWvYBVe
        XTex5sM8CcOBetljkh2YViyYijhzLao=
X-Google-Smtp-Source: APXvYqwhPnpN+NIoIIfhZvjoBsWXfZaXDVMAu7KdrUCnG//Qro9vlYsd9RANeyEKSV9ZPwGORsOy6w==
X-Received: by 2002:a63:5b23:: with SMTP id p35mr26142289pgb.366.1566342397025;
        Tue, 20 Aug 2019 16:06:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:36 -0700 (PDT)
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
Subject: [PATCH v5 05/25] drm: kirin: Remove out_format from ade_crtc
Date:   Tue, 20 Aug 2019 23:06:06 +0000
Message-Id: <20190820230626.23253-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch removes the out_format
field in the struct ade_crtc, which was only ever set to
LDI_OUT_RGB_888.

Thus this patch removes the field and instead directly uses
LDI_OUT_RGB_888.

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 45351934d919..65f1a57f7304 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -60,7 +60,6 @@ struct ade_crtc {
 	struct ade_hw_ctx *ctx;
 	struct work_struct display_reset_wq;
 	bool enable;
-	u32 out_format;
 };
 
 struct ade_plane {
@@ -383,11 +382,10 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void ade_display_enable(struct ade_crtc *acrtc)
+static void ade_display_enable(struct ade_hw_ctx *ctx)
 {
-	struct ade_hw_ctx *ctx = acrtc->ctx;
 	void __iomem *base = ctx->base;
-	u32 out_fmt = acrtc->out_format;
+	u32 out_fmt = LDI_OUT_RGB_888;
 
 	/* enable output overlay compositor */
 	writel(ADE_ENABLE, base + ADE_OVLYX_CTL(OUT_OVLY));
@@ -514,7 +512,7 @@ static void ade_crtc_atomic_enable(struct drm_crtc *crtc,
 	}
 
 	ade_set_medianoc_qos(ctx);
-	ade_display_enable(acrtc);
+	ade_display_enable(ctx);
 	ade_dump_regs(ctx->base);
 	drm_crtc_vblank_on(crtc);
 	acrtc->enable = true;
@@ -1024,7 +1022,6 @@ static int ade_drm_init(struct platform_device *pdev)
 	ctx = &ade->ctx;
 	acrtc = &ade->acrtc;
 	acrtc->ctx = ctx;
-	acrtc->out_format = LDI_OUT_RGB_888;
 
 	ret = ade_dts_parse(pdev, ctx);
 	if (ret)
-- 
2.17.1

