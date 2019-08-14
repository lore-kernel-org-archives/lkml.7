Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7314E21743
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9iZEwFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfHNSsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:48:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35846 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfHNSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so3283342pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sfKXX+o4Qp2/I5oLyNwYp5frrb8P6SiEjD+Gvi5BkT0=;
        b=T9iZEwFJF+TJKY0hHgQxpaN4a7p8bUuNIhxCNxLQu39fiS3b6qpIngIlGx0/PsKPxL
         5BhpUZFNY4Y1uicrCiOl/ecaqtix8bpnBrPTriSTl+FU6MvKZhD40K1X9tpi1TJvUPHm
         ZcAJO5JN/u2+RtuXPVeqCXTc3hi688nlSKe/ziB84VAnL9rED7HxiWWfh4RFYEADZwot
         SFUn3RzcO/DdUz0dukUuu57PdnIWrfbgtu4pdiouqY8sD6tKNiQFqbIJ2WGGR0Ld88tt
         +rvamYv9LUD5NWc/6TOtfO5PHTojq78/3MAmbMdtuZTQZHWhgnPjE3bkqg75GhB2aJe5
         AbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sfKXX+o4Qp2/I5oLyNwYp5frrb8P6SiEjD+Gvi5BkT0=;
        b=gyIp49jTKRecI5I32wU7+hs9BymcYtdrRf74k47yoKrdhX3pSoQWeJSLRueCQM3hN4
         lmcHWG/PYTE48TdkXLurfAZwp1y0ewiBNsYnpHcZDDhi1Eb+mbC0G14DpzuT+PHHVqOt
         C3mrcC21/kCPSJP/o2vsYfP3mlGd6x66hRVDNEX3PUlptbGU8AnuMUxR+EOQ305/E3Wm
         r42r3ZV/ti/QYKvCyrsaBdbqT7LIq+xjPVtJGKT91xOOS21zSc5gcU9dT93dED63+1Et
         X0GGLxpoCVnD2yGr2/2kHvZL911WZuKM9svShcjcoMBG4ageFQrGZIFge3YivBTADrsX
         0gpg==
X-Gm-Message-State: APjAAAVM7u2KpHyk2A7YPCpJ1FrpxsC+qDy4lEepRJXQ9KnkXcnIQjy7
        W4zVggLx5HoDp5UvD2NTZR746zyY3AQ=
X-Google-Smtp-Source: APXvYqyti+/OTVYfzLGL5f/MtTZ6Q0iILK/4POxjmbTxxzDN0spGBwaiT/XdSekW3R43JNlWtf0cCw==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr1079972pjh.61.1565808446871;
        Wed, 14 Aug 2019 11:47:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:26 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 13/26] drm: kirin: Reanme dc_ops to kirin_drm_data
Date:   Wed, 14 Aug 2019 18:46:49 +0000
Message-Id: <20190814184702.54275-14-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch renames the
struct kirin_dc_ops to struct kirin_drm_data and cleans
up the related variable names.

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 16 ++++++++--------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 3ad1e290bf58..acae2815eded 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -1055,7 +1055,7 @@ static void ade_drm_cleanup(struct platform_device *pdev)
 {
 }
 
-const struct kirin_dc_ops ade_dc_ops = {
+struct kirin_drm_data ade_driver_data = {
 	.init = ade_drm_init,
 	.cleanup = ade_drm_cleanup
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index bfe0505ac4a0..60c164623f56 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -28,12 +28,12 @@
 
 #include "kirin_drm_drv.h"
 
-static struct kirin_dc_ops *dc_ops;
+static struct kirin_drm_data *driver_data;
 
 static int kirin_drm_kms_cleanup(struct drm_device *dev)
 {
 	drm_kms_helper_poll_fini(dev);
-	dc_ops->cleanup(to_platform_device(dev->dev));
+	driver_data->cleanup(to_platform_device(dev->dev));
 	drm_mode_config_cleanup(dev);
 
 	return 0;
@@ -67,7 +67,7 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 	kirin_drm_mode_config_init(dev);
 
 	/* display controller init */
-	ret = dc_ops->init(to_platform_device(dev->dev));
+	ret = driver_data->init(to_platform_device(dev->dev));
 	if (ret)
 		goto err_mode_config_cleanup;
 
@@ -98,7 +98,7 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 err_unbind_all:
 	component_unbind_all(dev->dev, dev);
 err_dc_cleanup:
-	dc_ops->cleanup(to_platform_device(dev->dev));
+	driver_data->cleanup(to_platform_device(dev->dev));
 err_mode_config_cleanup:
 	drm_mode_config_cleanup(dev);
 
@@ -196,8 +196,8 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *remote;
 
-	dc_ops = (struct kirin_dc_ops *)of_device_get_match_data(dev);
-	if (!dc_ops) {
+	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
+	if (!driver_data) {
 		DRM_ERROR("failed to get dt id data\n");
 		return -EINVAL;
 	}
@@ -215,13 +215,13 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 static int kirin_drm_platform_remove(struct platform_device *pdev)
 {
 	component_master_del(&pdev->dev, &kirin_drm_ops);
-	dc_ops = NULL;
+	driver_data = NULL;
 	return 0;
 }
 
 static const struct of_device_id kirin_drm_dt_ids[] = {
 	{ .compatible = "hisilicon,hi6220-ade",
-	  .data = &ade_dc_ops,
+	  .data = &ade_driver_data,
 	},
 	{ /* end node */ },
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index d47cbb427979..cd2eaa653db7 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -34,11 +34,11 @@ struct kirin_plane {
 };
 
 /* display controller init/cleanup ops */
-struct kirin_dc_ops {
+struct kirin_drm_data {
 	int (*init)(struct platform_device *pdev);
 	void (*cleanup)(struct platform_device *pdev);
 };
 
-extern const struct kirin_dc_ops ade_dc_ops;
+extern struct kirin_drm_data ade_driver_data;
 
 #endif /* __KIRIN_DRM_DRV_H__ */
-- 
2.17.1

