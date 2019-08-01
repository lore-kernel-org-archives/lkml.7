Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB03C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119922171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9+JMcr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfHADp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40329 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfHADpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so31451069pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2SJ1RQl/uOMyO19jnUD0lNyv6QH0nUllbiw6Ng6yqJk=;
        b=J9+JMcr9OJwYMvFdAQKEduvl+84Dbc0aKweDgAVS6yk5/OwhMtRLqwB4r2kVnlOsMu
         bD+I8lt4/jXDaMSPdSrQjRhh0kj+/khxqEWaq/lwumFQO39/kuBdW+LsU0+VQJVdVhqQ
         s+Wb186mN++XDw4Qg8lbk9cNdsBm+amjRFNKSkXherrYJvCoTTp4M8WXPiEyGPaxWQTa
         /5Ido9xiaIN1fyY7qYfW7VvSDOP+bR6ZtCdL+QsTyrlPttSRxJQt3lOWLTQF0kyIUaVB
         eEbr4nTKN01fimxQihjv76yuG01+ASJV/ENmAAxuw/dQOH8EGa+4yWpICxWzLaRPdPfJ
         gzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2SJ1RQl/uOMyO19jnUD0lNyv6QH0nUllbiw6Ng6yqJk=;
        b=K9Ifz/NczumawupQgon2lrtLUvNwIkM7PAXDqcpZLnalocavTex1Cq7ZldTDEnZPUl
         iFKd/T/XIhVgyOP9KNFqTsNCw+gwDjgoDiYSw/CY66M7FRrYVxid3pnxC+49U6TxVis+
         pYwS3E9K6X+JThMCIEXi+tgSAiO2MuSTzsg1FVWG3VI1pki314zd9M88ata3eO1AQi4R
         Moq2fLF0JqdwwHv5v/TfnAMm9OvbiuOw3HArEOdAPDM+vobkPHs0Op4vTSEGA0E77cY0
         bpiS33pv3ij3yXA91RmbSOOZ+6dYnWnnp9gczDWk9YGCpowjKBZYswSrcp19zoWa0wfY
         X1tA==
X-Gm-Message-State: APjAAAUVnHEL5vgNtTMP4aJc2Hlm/ZrFgTLfR/hti5WH8F09uKS3nkds
        BxN+/1/8kq0zBxplMUNz8ZRLb4cDKos=
X-Google-Smtp-Source: APXvYqx50bex+FQM4c27X8zuOaZqL10cOQtxFJhPZ+qvdQyb47LjqbwwFQWJCaJqsnROXuouyiIZuw==
X-Received: by 2002:a17:902:e2:: with SMTP id a89mr124513000pla.210.1564631122837;
        Wed, 31 Jul 2019 20:45:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:22 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 24/26] drm: kirin: Add alloc_hw_ctx/clean_hw_ctx ops in driver data
Date:   Thu,  1 Aug 2019 03:44:37 +0000
Message-Id: <20190801034439.98227-25-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 9 ++++++++-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 09dc2c07533d..f729a1de6e14 100644
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
@@ -1090,6 +1094,9 @@ struct kirin_drm_data ade_driver_data = {
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

