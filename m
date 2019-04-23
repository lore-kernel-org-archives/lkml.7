Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08136C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1705218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOlspHR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfDWXVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39106 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfDWXVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so6469442plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ws3Dd9BPtQNXdrE11DrYoo1hw98ZqIgdLIuIoohWAI=;
        b=vOlspHR05P7wEGxI/4z2kZzKI04SunMOWWy1zhhr3rUFzMseipE5BG8dgRvRjT39r5
         TmB3GfVEW/EMe3pLxSJfOIvPul16TcafmVWyQfBsssAE2plbwkLhg1B5xp5RBfaGFygk
         9HA7w/JdxmUZkix8IpEpgAxLIanq034B0rpx+PqKuGD8jc9oYLf8d4A7SbFHA7q6uTIG
         bS1dvU1Z0pD233XfI+8MtIn0hV4Vxk1QSRnQchQozT7TOngkOE/+pNzgXV54J6ZJ7uM8
         hnumrjo13fCydbP9e+89R7W/yQVw52cut4pqQ5XbnqYJmQ5vyZHFlemrzFWJyj9OYADs
         7jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ws3Dd9BPtQNXdrE11DrYoo1hw98ZqIgdLIuIoohWAI=;
        b=FeVu5Qs0niLKpeDJJf0r4k46ZkglzaEQhZLcodOrVKKTj10o3mpTI6ZSGAXJn92cNk
         q0IX098MgvHN2gmJxBnUkiu5eU17OkT79QHST21iMtDbfK6cY8lCv75qYezTjoDACfwC
         EcvdmpPlzXYBLLdNh0m1TW4sj9J8FY9BD2OkEKzJCbNuThX1LP2s3qx6FlrL4HP8u892
         0iq5hfGvkhAH5gPFF+XPqv7Tyn3dkqtE0llfFcluOXwlKcR3aJ/usCBYn3loB3RL70xc
         Xe6v7KOfmV5sZ7tQLTCwLFxAs0k8QrdervvX7SItIRyIKjgPsiDoagA9VvPMTIo/NYq/
         E36Q==
X-Gm-Message-State: APjAAAXNwdOAGsN6jmUqHxQSViczSKJdw6rAo496yMXuGnm+FNqrSE9K
        ACbiPxTKGlX9cOZvjOEb/sLmXlEbidE=
X-Google-Smtp-Source: APXvYqwsyaUiw7o1uBnCgw9SPEnaS1Y92ydgJWTukVYM8eJMcb6g6lyEOjvMv/xGEOLTaxGwqm+f3w==
X-Received: by 2002:a17:902:263:: with SMTP id 90mr29348524plc.257.1556061661621;
        Tue, 23 Apr 2019 16:21:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:00 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Da Lv <lvda3@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yidong Lin <linyidong@huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 01/25] drm: kirin: Fix for hikey620 display offset problem
Date:   Tue, 23 Apr 2019 16:20:32 -0700
Message-Id: <1556061656-1733-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
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

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Da Lv <lvda3@hisilicon.com>
Signed-off-by: Yidong Lin <linyidong@huawei.com>
[jstultz: Reworded the commit message, checkpatch cleanups]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Minor cleanups
---
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h |  6 ++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
index 4cf281b7..ced40c6 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
@@ -87,6 +87,7 @@
 #define VSIZE_OFST			20
 #define LDI_INT_EN			0x741C
 #define FRAME_END_INT_EN_OFST		1
+#define UNDERFLOW_INT_EN_OFST		2
 #define LDI_CTRL			0x7420
 #define BPP_OFST			3
 #define DATA_GATE_EN			BIT(2)
@@ -97,6 +98,11 @@
 #define LDI_HDMI_DSI_GT			0x7434
 
 /*
+ *BIT_LDI_UNFLOW
+ */
+#define BIT_LDI_UNFLOW         BIT(2)
+
+/*
  * ADE media bus service regs
  */
 #define ADE0_QOSGENERATOR_MODE		0x010C
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 73611a9..beb2a3c 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -58,6 +58,7 @@ struct ade_hw_ctx {
 struct ade_crtc {
 	struct drm_crtc base;
 	struct ade_hw_ctx *ctx;
+	struct work_struct drm_device_wq;
 	bool enable;
 	u32 out_format;
 };
@@ -176,6 +177,7 @@ static void ade_init(struct ade_hw_ctx *ctx)
 	 */
 	ade_update_bits(base + ADE_CTRL, FRM_END_START_OFST,
 			FRM_END_START_MASK, REG_EFFECTIVE_IN_ADEEN_FRMEND);
+	ade_update_bits(base + LDI_INT_EN, UNDERFLOW_INT_EN_OFST, MASK(1), 1);
 }
 
 static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
@@ -345,6 +347,17 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
 			MASK(1), 0);
 }
 
+static void drm_underflow_wq(struct work_struct *work)
+{
+	struct ade_crtc *acrtc = container_of(work, struct ade_crtc,
+					      drm_device_wq);
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
@@ -362,6 +375,12 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 				MASK(1), 1);
 		drm_crtc_handle_vblank(crtc);
 	}
+	if (status & BIT_LDI_UNFLOW) {
+		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
+				MASK(1), 1);
+		DRM_ERROR("LDI underflow!");
+		schedule_work(&acrtc->drm_device_wq);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1038,6 +1057,9 @@ static int ade_drm_init(struct platform_device *pdev)
 	/* vblank irq init */
 	ret = devm_request_irq(dev->dev, ctx->irq, ade_irq_handler,
 			       IRQF_SHARED, dev->driver->name, acrtc);
+
+	INIT_WORK(&acrtc->drm_device_wq, drm_underflow_wq);
+
 	if (ret)
 		return ret;
 
-- 
2.7.4

