Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8FEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0404021743
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3DL2zju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfHNSrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37327 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfHNSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id 129so7187249pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mTsaQr/BGfn/0oGZCU1NOuvNsQeVfs5BZ0y5MQK4HZo=;
        b=o3DL2zjuNDIUowRC65Y7G85lgkhRHxMh346JtwhfodzRxGUaYUKU+thJCSJsBe4WJi
         o7jmKjTDOR/IWLt4CEvdDBzJbCiK0WShw5JO4BzYTiMAqvi7HWFu5LYCg6b2i0126Fxm
         r5ZWEFL1w8WnqZj3ws34aNLYNJa1AdQPUI37trOnmxNtOVF83WFeJ6eLezTeE0zZ+AlO
         fE5d4qz1P03Cz5hCnJ56goR/ZbBos3YU7jph+HMsObrsY3og0t20I7qPD0xApbiUluqI
         GoH4QvAomVPnLnwvhXcLrPsEC2olYCDvoAdTpAYx2C8v1zSx97YBTjrhanjp7IytNT/6
         5V6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mTsaQr/BGfn/0oGZCU1NOuvNsQeVfs5BZ0y5MQK4HZo=;
        b=eJ1laTCKOV95HpcLxTS6BLNUVgdxyQPorJ/msHg7vu2T1V0MLnAvaWfAlxSm2eEO9S
         kZ52r1NSZBiI18VpRy+zfzIku4o5slX9alMbMmYAI2gGFEf0W2+GkkF+5mqIE5mBkahu
         FgrZ/R6V4uI+Ik6cUZtusgCV6xHulkmQ/sWPQaIf6xFbWI8klLo+hmAdSdzRcePhQf+Z
         nt9B78x/wwN12CnrVyIKDiyTE/Xum9wsdwpr2na8socaNx6UkqnH4tZX7jUeXjLVAPX2
         YyasvdNhuWVOvvm4rVun8yhZ53rSYh4TxJUuZfWJoiEcWQY40D9DDYVh9WNKuShXe0yd
         US3Q==
X-Gm-Message-State: APjAAAXoCMJnfTU/wHLKTwyW/VZUvOJNG4/f02SeFfLoosB2GqPAnrdB
        pXNJpMuPMTrxe7ZvXexMk7uTnFLzlFo=
X-Google-Smtp-Source: APXvYqz9sWuMrYnJ71oWGt4PPF5S0nMvyCRFGdTZmp2X1HPVn5mbdmlna+I0NEyr5eJPDQFLrW3tHw==
X-Received: by 2002:aa7:90c9:: with SMTP id k9mr1332133pfk.171.1565808436316;
        Wed, 14 Aug 2019 11:47:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:15 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 06/26] drm: kirin: Remove out_format from ade_crtc
Date:   Wed, 14 Aug 2019 18:46:42 +0000
Message-Id: <20190814184702.54275-7-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 756aefd5bcff..73dff21bed6a 100644
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

