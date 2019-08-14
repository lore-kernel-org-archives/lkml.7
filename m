Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF2BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38962216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3js0ydL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfHNSrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37315 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfHNSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id 129so7187092pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GHk9KBu+sjfwQVMBr88lecQJQ9kDr2JBg8OISzQ0Mo8=;
        b=r3js0ydLYVWv6kjs69b3EVE1ebVkkwcc0gHPBRxrBdj5PUspzHKliJWKYfdPUe9exc
         BBWPiDyCuEF1CjJoE8NLFSNJ2j+swzsxOWhruAH7tyUc8LCVjpK7EYZMfPY+M4ozAqdI
         ygeplTC6loMcRsXZtCZMmg20miPSkeLfpNbWzSZp81PRoaKm/+ZDuvIetQxatEFVlSUP
         aBumVfT8CeGVChSbv4ezqeES7jPEPvmet3pEXtYcUmR8lm2H98F5p0jsSM9HV7fAYAE3
         La9uyxTBdwFwUH9a0pKDG/npZUN6X51gssLmFdc0ywQ9ptvc+owN6JbK8PGf4ESVKgVt
         RYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GHk9KBu+sjfwQVMBr88lecQJQ9kDr2JBg8OISzQ0Mo8=;
        b=pBv9ddy/yHV+S0Kr7vqRuhY4ZYmFHuqH5yDddnz9pxHwhtyS4C3SvJZKHqyK7hmJ05
         85ZAUXgwf4eGjRI2PihO9cd1tbPRMTOCaQJcdiH03a6ldjdwyQj9pe5nh0KJI/XK6Pg2
         1hUWCbscJQUyjxpsajGAqCUgeZFL6NZrrZhksMF0nX868C/m56dRyxr9WYf08KJdKyaq
         yOT0cXP7Y/aN1qBjA8ECVTb9unCMtV2NG9jVUHYXgHSoTCzaYMglTVbs8fv5YCz7uHFg
         1kyMO8piM3bqhGtzIT5kj5LoBeoST9cSgPjjd7mwh/kbe4JfGK7rM7JEWB93oNty4kHG
         FHig==
X-Gm-Message-State: APjAAAV2VwUjSwcuYPI3R8QGhH9ctR2TXwFiOd9wu+ATIK2F+umuR2NU
        x8mwlbY+wgCtP+sziNWFOj1a+htR3m4=
X-Google-Smtp-Source: APXvYqyFZdKw4i6UT0LjD3UmiAGGwKCO+QBIqvUBmuZT9H+t+etcgS2PPN0TS7bzXvAdSNzcyscwKw==
X-Received: by 2002:a63:61cd:: with SMTP id v196mr484242pgb.263.1565808428888;
        Wed, 14 Aug 2019 11:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:08 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Da Lv <lvda3@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Yidong Lin <linyidong@huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [RESEND][PATCH v3 01/26] drm: kirin: Fix for hikey620 display offset problem
Date:   Wed, 14 Aug 2019 18:46:37 +0000
Message-Id: <20190814184702.54275-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Da Lv <lvda3@hisilicon.com>

The original HiKey (620) board has had a long running issue
where when using a 1080p montior, the display would occasionally
blink and come come back with a horizontal offset (usually also
shifting the colors, depending on the value of the offset%4).

After lots of analysis by HiSi developers, they found the issue
was due to when running at 1080p, it was possible to hit the
device memory bandwidth limits, which could cause the DSI signal
to get out of sync.

Unfortunately the DSI logic doesn't have the ability to
automatically recover from this situation, but we can get a an
LDI underflow interrupt when it happens.

To then correct the issue, when we get an LDI underflow irq, we
we can simply suspend and resume the display, which resets the
hardware.

Thus, this patch enables the ldi underflow interrupt, and
initializes a workqueue that is used to suspend/resume the
display to recover. Then when the irq occurs we clear it and
schedule the workqueue to reset display engine.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Da Lv <lvda3@hisilicon.com>
Signed-off-by: Yidong Lin <linyidong@huawei.com>
[jstultz: Reworded the commit message, checkpatch cleanups]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Minor cleanups

v3: Rename workqueue entry for clarity (suggested by Sam)
---
 .../gpu/drm/hisilicon/kirin/kirin_ade_reg.h   |  1 +
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
index e2ac09894a6d..0da860200410 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
@@ -83,6 +83,7 @@
 #define VSIZE_OFST			20
 #define LDI_INT_EN			0x741C
 #define FRAME_END_INT_EN_OFST		1
+#define UNDERFLOW_INT_EN_OFST		2
 #define LDI_CTRL			0x7420
 #define BPP_OFST			3
 #define DATA_GATE_EN			BIT(2)
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index ad7042ae2241..d69b5d458950 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -54,6 +54,7 @@ struct ade_hw_ctx {
 struct ade_crtc {
 	struct drm_crtc base;
 	struct ade_hw_ctx *ctx;
+	struct work_struct display_reset_wq;
 	bool enable;
 	u32 out_format;
 };
@@ -172,6 +173,7 @@ static void ade_init(struct ade_hw_ctx *ctx)
 	 */
 	ade_update_bits(base + ADE_CTRL, FRM_END_START_OFST,
 			FRM_END_START_MASK, REG_EFFECTIVE_IN_ADEEN_FRMEND);
+	ade_update_bits(base + LDI_INT_EN, UNDERFLOW_INT_EN_OFST, MASK(1), 1);
 }
 
 static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
@@ -341,6 +343,17 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
 			MASK(1), 0);
 }
 
+static void drm_underflow_wq(struct work_struct *work)
+{
+	struct ade_crtc *acrtc = container_of(work, struct ade_crtc,
+					      display_reset_wq);
+	struct drm_device *drm_dev = (&acrtc->base)->dev;
+	struct drm_atomic_state *state;
+
+	state = drm_atomic_helper_suspend(drm_dev);
+	drm_atomic_helper_resume(drm_dev, state);
+}
+
 static irqreturn_t ade_irq_handler(int irq, void *data)
 {
 	struct ade_crtc *acrtc = data;
@@ -358,6 +371,12 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 				MASK(1), 1);
 		drm_crtc_handle_vblank(crtc);
 	}
+	if (status & BIT(UNDERFLOW_INT_EN_OFST)) {
+		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
+				MASK(1), 1);
+		DRM_ERROR("LDI underflow!");
+		schedule_work(&acrtc->display_reset_wq);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1034,6 +1053,9 @@ static int ade_drm_init(struct platform_device *pdev)
 	/* vblank irq init */
 	ret = devm_request_irq(dev->dev, ctx->irq, ade_irq_handler,
 			       IRQF_SHARED, dev->driver->name, acrtc);
+
+	INIT_WORK(&acrtc->display_reset_wq, drm_underflow_wq);
+
 	if (ret)
 		return ret;
 
-- 
2.17.1

