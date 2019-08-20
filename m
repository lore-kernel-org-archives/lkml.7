Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A467C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9992341C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeM2fPkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfHTXHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42519 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfHTXHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:07:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so82741pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MVBS6s/BS2iml31wX2/Rhd0nBzLwsiOkYjbfOZWZ4tw=;
        b=jeM2fPkbWnWSTtEljReDIHFfsfeHVQ01JqHJ9u2ShkYBcp+/+8KYKxqhYw3vJRtfW7
         QVPqk/3z38c4SPs8IzrPnm7uelkN5fbYcTCsyH17RHuZSVSNJXpYSnlPXTbgSEIDg3fz
         WI4Gu4RCVWN4uYRfzbWWXuHkT8DjXxSIKW/THCwmlSZIvU+aYIPe1yQ3f/BooYC1qeex
         Lgt5cV4PIgRLXnc7Xq4BkU2nuYMxZJ6yp0zDEMhyBn83wAsR6t5j9l8Cl+GBvNrG5kPV
         NPU0owlbQoPnSXK0TefSdAMsPcnLzi1X8CgwVKhtVh/K0uhgD62tZfDXhaW381uj/zNt
         upbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MVBS6s/BS2iml31wX2/Rhd0nBzLwsiOkYjbfOZWZ4tw=;
        b=Zhen4wEDgUu9V9m41X3vod1HNFMPoO0OU5eAVaEAqS6LZmJXn4g62pbrmo+892n8bm
         vyasB/Gaj5epGFtD7pE882vEc9BvtLj5iSwLPVDg8XSmQw4ybCjm9HJfty6N97R//dHE
         b6LZQS9MiRP9AhNsN2JsYCb3ArLzhFjqRx2RIfmsWqeJZDyABb4OqkSTDcQnwGcnzmPP
         Z+B6dmRDJLJ2u+wfGWJ+T7bmlbmvkasn7sMcbeMhwUZqWP+x/8IXFy+OJSLK9tA0gZlJ
         DvuSwTpEDhbH34PUyeKJS9ONJOxYGFraaoV5yAeeKU0cphcYm8lf75E46L5L0Kldsc4l
         eXFA==
X-Gm-Message-State: APjAAAWBNAYp0pib0XkZkiMdrw4RnmML5InDBb12cyQrEjxNSH9EiH3g
        MJzOxzWbvkRIgUoNPiTnJYozVeZUl0g=
X-Google-Smtp-Source: APXvYqwG9+bnLD4/Mpplbe8yIuvH+GlW31O8nnLcR91y1DkSlFoAAJKR0LUsiNpcJoVraKcZf5ZvIg==
X-Received: by 2002:a62:76d5:: with SMTP id r204mr32005336pfc.252.1566342425396;
        Tue, 20 Aug 2019 16:07:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:07:04 -0700 (PDT)
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
Subject: [PATCH v5 22/25] drm: kirin: Make driver_data variable non-global
Date:   Tue, 20 Aug 2019 23:06:23 +0000
Message-Id: <20190820230626.23253-23-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes the driver_data
value to not be a global variable. Instead the driver_data value
is accessed via the of_device_get_match_data() when needed.

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
v5: checkpatch --strict whitespace fixups noticed by Sam
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 7f8d4539b1a9..f5df88378591 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -29,18 +29,9 @@
 
 #include "kirin_drm_drv.h"
 
-static struct kirin_drm_data *driver_data;
 
-static int kirin_drm_kms_cleanup(struct drm_device *dev)
-{
-	drm_kms_helper_poll_fini(dev);
-	driver_data->cleanup(to_platform_device(dev->dev));
-	drm_mode_config_cleanup(dev);
-
-	return 0;
-}
-
-static int kirin_drm_kms_init(struct drm_device *dev)
+static int kirin_drm_kms_init(struct drm_device *dev,
+			      const struct kirin_drm_data *driver_data)
 {
 	int ret;
 
@@ -96,6 +87,21 @@ static int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static int kirin_drm_kms_cleanup(struct drm_device *dev)
+{
+	const struct kirin_drm_data *driver_data;
+
+	drm_kms_helper_poll_fini(dev);
+
+	driver_data = of_device_get_match_data(dev->dev);
+	if (driver_data->cleanup)
+		driver_data->cleanup(to_platform_device(dev->dev));
+
+	drm_mode_config_cleanup(dev);
+
+	return 0;
+}
+
 static int kirin_drm_connectors_register(struct drm_device *dev)
 {
 	struct drm_connector *connector;
@@ -132,15 +138,21 @@ static int kirin_drm_connectors_register(struct drm_device *dev)
 
 static int kirin_drm_bind(struct device *dev)
 {
+	struct kirin_drm_data *driver_data;
 	struct drm_device *drm_dev;
 	int ret;
 
+	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
+	if (!driver_data)
+		return -EINVAL;
+
 	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
 	dev_set_drvdata(dev, drm_dev);
 
-	ret = kirin_drm_kms_init(drm_dev);
+	/* display controller init */
+	ret = kirin_drm_kms_init(drm_dev, driver_data);
 	if (ret)
 		goto err_drm_dev_put;
 
@@ -190,12 +202,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *remote;
 
-	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
-	if (!driver_data) {
-		DRM_ERROR("failed to get dt id data\n");
-		return -EINVAL;
-	}
-
 	remote = of_graph_get_remote_node(np, 0, 0);
 	if (!remote)
 		return -ENODEV;
@@ -209,7 +215,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 static int kirin_drm_platform_remove(struct platform_device *pdev)
 {
 	component_master_del(&pdev->dev, &kirin_drm_ops);
-	driver_data = NULL;
 	return 0;
 }
 
-- 
2.17.1

