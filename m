Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DF2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AD523406
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSG1Ek3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfHTXHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40980 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfHTXHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:07:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so149598pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kYV4kILdbKA8eyGmIfSZvQNIJi3JDyMCa7aHVJs5K24=;
        b=dSG1Ek3wXoduCZ6bdSuQJ6zGn1REdKK3dH8Owh1BVf8Ldw3GKyoUXKYaXn2HjvWsG8
         0MlCq97ext2U9uYXyV/org/3fYSxurxIps7pVnWIju7CTI40kNCZgjnfK+xgXP/3KceD
         YG5T4TWr78XkSbRdmtVXsdo6ODmzIGweCY6eclvmzUTmzIYugRMn3xIwL6/kLv9usAsJ
         EtvvPiZ7Rxryd4Y0jImrXwmpmsjFCAV0/ljtjkKlK0DeVe2IgpfJ0ZT+qQJOSKUfcYI1
         +kb3OeO4iytf1/eFRCRYE6vc7RenGQ1wX1UcNLIW/+ziqlO1DOjcD/rnuwwTMLpzJyXR
         Lu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kYV4kILdbKA8eyGmIfSZvQNIJi3JDyMCa7aHVJs5K24=;
        b=mZDhA/Q7aJ0pXxDicFT8SSC8hooWF472UEJMq5WVE7GibsNLNyEJxqXcNuZrBQOJMC
         sFugZj/Z027lX8HDqhhb+hQubBZWnpgE51JiIy42gydgSmNSxN7bzrOoh7yqxF1+xF82
         8m+9M+BxMav87+SyB9ZFACsIQlkZR6+pRhE8TU6JcMmmrjZfdEr/LLDafrI7K/ko5vbl
         ySXiSfW5i0r0P4aq7o8OZoqHuJOX4o8iXkQ86EVDNnO4mHazHpNZm3DA/QZATm5sobrH
         sdj3B2utAqdjZOApTgWfFn8yXBKEtoO2tzBT/xRj0IRapp3T86X5csSiLmQ32mlK7aKU
         zAaA==
X-Gm-Message-State: APjAAAWjHHvlXAFt9RB44uimiRxGkoMjVpKSWkxkb79o0Reo2cMiflhk
        2pUu2pwMuJGMT6M4m4Q7AI6sn+rY08Y=
X-Google-Smtp-Source: APXvYqzk7Q18L54XsSE8B+hQfBteWjyw6GXtAXHv5na/lhxe1AhTuuoaZsEygqXrPAPNJJJfBzq22A==
X-Received: by 2002:aa7:93cc:: with SMTP id y12mr28989943pff.246.1566342426836;
        Tue, 20 Aug 2019 16:07:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:07:06 -0700 (PDT)
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
Subject: [PATCH v5 23/25] drm: kirin: Add alloc_hw_ctx/clean_hw_ctx ops in driver data
Date:   Tue, 20 Aug 2019 23:06:24 +0000
Message-Id: <20190820230626.23253-24-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes the
alloc/clean_hw_ctx functions to be called via driver_data
specific funciton pointers.

This will allow the ade_drm_init to later be made generic and
moved to kirin_drm_drv.c

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 9 ++++++++-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index d8e40fcff386..a2bb2b75be4b 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -1000,7 +1000,7 @@ static int ade_drm_init(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
+	ctx = ade_driver_data.alloc_hw_ctx(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
 		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
 		return -EINVAL;
@@ -1040,6 +1040,10 @@ static int ade_drm_init(struct platform_device *pdev)
 	return 0;
 }
 
+static void ade_hw_ctx_cleanup(void *hw_ctx)
+{
+}
+
 static void ade_drm_cleanup(struct platform_device *pdev)
 {
 }
@@ -1089,6 +1093,9 @@ struct kirin_drm_data ade_driver_data = {
 	.plane_funcs = &ade_plane_funcs,
 	.mode_config_funcs = &ade_mode_config_funcs,
 
+	.alloc_hw_ctx = ade_hw_ctx_alloc,
+	.cleanup_hw_ctx = ade_hw_ctx_cleanup,
+
 	.init = ade_drm_init,
 	.cleanup = ade_drm_cleanup
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 95f56c9960d5..1663610d2cd8 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -49,6 +49,11 @@ struct kirin_drm_data {
 	const struct drm_plane_helper_funcs *plane_helper_funcs;
 	const struct drm_plane_funcs  *plane_funcs;
 	const struct drm_mode_config_funcs *mode_config_funcs;
+
+	void *(*alloc_hw_ctx)(struct platform_device *pdev,
+			      struct drm_crtc *crtc);
+	void (*cleanup_hw_ctx)(void *hw_ctx);
+
 	int (*init)(struct platform_device *pdev);
 	void (*cleanup)(struct platform_device *pdev);
 };
-- 
2.17.1

