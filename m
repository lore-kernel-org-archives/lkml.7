Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0E4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC202218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtmWoZBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfDWXVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34162 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfDWXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so8267531pfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/bl8KjJZ8VdKQUaQRpB+hHEQjF/aOlCQlEyUX72UB6E=;
        b=OtmWoZBIcZcpMPhq5QJY7URkVpfaVsaraS6hIv67HgjGOoxqt57yVNkoo6100XtjNx
         kBnwpBmgfo5Ta4Cq1nVSgLojL8KlHU/Z3ytxnOQISl+0ockKjuwM9vsPDkKXhFHIjVhm
         obMXeYCsaNw6s033mdWlROD0fpuMO1WntVXFqmdt4dF1yifXbIAcvvs6l/e2qp7GUKpj
         exbe91fcZi/UYhi8rWQdXk7fBLbLhBq2ifYh0ZUpYwhliv/JigIRtClhoVm9eIVAApud
         468K0QK2vuGUEpUFcS1okbeGuAWNqzFvLfdt3OCSGv0Rg+HHkbry27Q4ppANyq73P5ud
         1+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/bl8KjJZ8VdKQUaQRpB+hHEQjF/aOlCQlEyUX72UB6E=;
        b=GlNBu3mX3ONhnfBbGydZJsk9j7NbBvZKK5JNSgniL0kJcmTKG1G3/tbR2s6cFJq05A
         C9XzjIM9w0uCSrnvcbMT2x0t40v8BTzCk3n3FHDAuiaNt6G3NHd9LO9MiGW9YjiS8IrP
         spePYn8R1+uW2CKxHFENwArsHyrJAJUwJVwRDXUI6mVxyaHtSZBLdAetLdgUog//SFx/
         aZzeRLQjAcaMC9M0YqOgkeCRY7Mx8sQvD4uusXqUYLUhyZifjdd55qAV7q5/Os/aT626
         XUN5TE6gl8jVJS+owe+ex9qAvDfCVxkd34Ws5r0KNAx9DX41KcNCKZw36ej3A6SBn0YE
         fmeQ==
X-Gm-Message-State: APjAAAXdwWoBMTsh2vAZP9sfYBsktNKSpNAm80wL8Q4XHC9IkSzKJTbb
        T2JOwVMqUuuglWAwx0AKacXJiE9Yohs=
X-Google-Smtp-Source: APXvYqybCUl1ESlOHxixy4zHex8X6auuxEd3pYgD+rEA0e1A5nQ0uG8/073n5wgpDK5+PbJOxhszuQ==
X-Received: by 2002:a62:1d94:: with SMTP id d142mr29806248pfd.83.1556061667802;
        Tue, 23 Apr 2019 16:21:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:07 -0700 (PDT)
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
Subject: [PATCH 05/25] drm: kirin: Remove out_format from ade_crtc
Date:   Tue, 23 Apr 2019 16:20:36 -0700
Message-Id: <1556061656-1733-6-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 56a55d9..27a5441 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -60,7 +60,6 @@ struct ade_crtc {
 	struct ade_hw_ctx *ctx;
 	struct work_struct drm_device_wq;
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
2.7.4

