Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16785C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFC121726
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9EGW8Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfHADov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:44:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37033 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfHADos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:44:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so33148023pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QjSI1b8alIth1E7HJtMuZLsPsx44ZXhw7/4SnNJJUk=;
        b=Z9EGW8Ep6iZzB6WcT1yvuoOLW03dKeUayVCnQHc9y9QdNBavUwlMez4gbLQk/LbsF7
         LCH59XX31xuyCrwxPuWmkqkwW4R+5tt+sQ+4V34L1ozXCXAfD0YQPEpvhU0WXzYBxxYH
         Snq3t4ydBqLPZ5R9Jzg0UofhXZmn7TAMwPahrPHrR6t1S9aYZGG782YeJDh/LKHSVfBh
         2KtqomAW9xZ0RasEXxXt9JoW4KsPD4khMr3lHmCzE+wu7Kodwgs1sba341KEQ8gb34XE
         xv+JAZQ46ubfd6OPx0vXFPAJ68eroDUg0X1hN8llrzdOkQ5FhfXZgjoi/RQ1unW7c8T4
         ec6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QjSI1b8alIth1E7HJtMuZLsPsx44ZXhw7/4SnNJJUk=;
        b=nNFj88UoWCBC1/uNEvciRm8f/ioZ5bADlfbFe3v6Qicb2zr8luEb9WIvyL/euvYYsC
         j50inYRuK9lmTBxSMnTmwplQ4+qHVSEIg4JzaRdD87vrTX8pz7uEJKP9spzhRpkrmpgA
         A3hCBQMRXaJR/P+vyab8EBtKTKpDvEZZ72ql/JsBwaKyhmFMPU/RAGMTtBqjyh1zvtgt
         BYhD+PM/WIXVMLyq+2/l1ISooBdGQdUOH5Qr/k0ELbftNMEO33MngJJrZ4QVCDKbfgpa
         RZaYFpB6iyW3TO2pkt5jGmQv0Hp71C1tSMUTmHOeSq8GWs2vhy13O9roGkKGUGI+xg/D
         +lPQ==
X-Gm-Message-State: APjAAAUjMELTYG1tYptnHUA+FWMVYUTZSFS4ShVcnhEK+e82JL1rXL3C
        qwB+paQwBEQL5OLAx7kEwOMiHwIxX18=
X-Google-Smtp-Source: APXvYqz5tjq2NsRmnAofXBfa6ee/WnT/EZxT80QAkU/SM9rc9yFnRqsKdy5zrDajaeuaEnnpa8mSsg==
X-Received: by 2002:a17:90a:9bca:: with SMTP id b10mr6190126pjw.90.1564631087485;
        Wed, 31 Jul 2019 20:44:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:46 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Da Lv <lvda3@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Yidong Lin <linyidong@huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 01/26] drm: kirin: Fix for hikey620 display offset problem
Date:   Thu,  1 Aug 2019 03:44:14 +0000
Message-Id: <20190801034439.98227-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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

