Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C4BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4DA22CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3ZHOgJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfHSXEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:04:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34726 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfHSXEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:04:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id b24so2089968pfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffOhLSrwkZ0FoYckf3kTJH2dZNi42NmCSonPnEyy2Hc=;
        b=u3ZHOgJd502s/aInsx0EzPcO26A1FA+uOEiIkhJKCiZ5hAcXzU0zAQA5eqfrge34yi
         HAgWlvz/zeQt8miwKSyTesRUl1qArKIpHtaIH+G98V0fKGHBkGDCIBoP4QyLv+B7zHbq
         37bE3GwOVky5lEbBJqQSMAo1roqIKmn2AWPjyso7Tas2OIQ9zPgSffUeorOIz5D4N/iM
         ZpXMH1NNPT9hmJNqSvjyRqLzMG8OC+SlIUZBUSe2Xb7YctyFGwY04qyxJNFIuOnIX3QH
         HEt/eAuQu2E5dQ9B+3n1qJIurFSg7Rp4/Uy8Qk7EuLxvU/vssVWSA90jn9ry/YwoNGeI
         xr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ffOhLSrwkZ0FoYckf3kTJH2dZNi42NmCSonPnEyy2Hc=;
        b=MBO53GBvMS0buOHgO5gq2OcJjNTux1BhWdH+WlYSOVfmR5Vsl346VIwMRocVlgTBor
         ldINrZgc5ydrd29q6E2TzHpLXKq3FqWiC1zgVzefic1dVzo9SbIV3EzqozWMIFrxeaJI
         locpvylQGc5BO+/G9mQNdyhVXFF+OUDIsla8EuJkSXWJkrFMHLM897fYnrHhDCnb48xh
         EyfEBjw87qLArboAXkQdxgfe/ktFN5+iCf9SXXkOZSonOdkIFIo1u/I6nT+QoOAFfYl7
         aR+EmqS68RszGHJOodw5KUGqFDSHprCFu4NkSSICBGvgTgUGcZTYOuhbipLsXjZ2VLih
         KyXw==
X-Gm-Message-State: APjAAAWQeYjTeEKBsLT/HGpKwRpvMzbPl/9nPt2z7wbOL2japnUWn38T
        aAJ8H9MsJE/V/xt8XlfdJNmPGlJ/NHM=
X-Google-Smtp-Source: APXvYqxoxiFV08/B/uo/2/sQJgEIGK7Iy84PjzPkwa/66GDBThzwEXIfxiZD56GFZFTRHw7CIvuc6w==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr21987280pgd.241.1566255840875;
        Mon, 19 Aug 2019 16:04:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:04:00 -0700 (PDT)
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
Subject: [PATCH v4 23/25] drm: kirin: Add alloc_hw_ctx/clean_hw_ctx ops in driver data
Date:   Mon, 19 Aug 2019 23:03:19 +0000
Message-Id: <20190819230321.56480-24-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
index a7fe2fc57bf7..5caf0921c26c 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -999,7 +999,7 @@ static int ade_drm_init(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
+	ctx = ade_driver_data.alloc_hw_ctx(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
 		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
 		return -EINVAL;
@@ -1038,6 +1038,10 @@ static int ade_drm_init(struct platform_device *pdev)
 	return 0;
 }
 
+static void ade_hw_ctx_cleanup(void *hw_ctx)
+{
+}
+
 static void ade_drm_cleanup(struct platform_device *pdev)
 {
 }
@@ -1087,6 +1091,9 @@ struct kirin_drm_data ade_driver_data = {
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

