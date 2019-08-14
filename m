Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D45C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50BE217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOsITZch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfHNSrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39031 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbfHNSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so50104778pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OApmoIvKEwANRXPyc/6OWQeR4K/MRqLWVFQnZsIe75s=;
        b=lOsITZchiLFnULc5mm91WsaNs9MBzbyapHeMMb56+cdMOduZItbjK07Tu3gtHNJgwj
         1mrPMeWj+3uA9BZum5sPSqe3wz4YHEcHXg0cAFV4S0JuHOb7Y36+EGsRZsl2q4Ebhugn
         RKMYnwMA23IRUelOo1yGFV7o/+Eso8NGPvNoQhNdO8FoZwxjC1cZC0NUYPGIeNmSXjgq
         flXmnQE9BmgM7AW1v2WbDZszd9ZxIoURO9WUoJf/XrHCfnx4BfoN+tSHUELB+rdPJxii
         zCLmsU+8GMqy6mPvkBUciI/vnNU7Kq34UXXWakMulrT4byK/uz3KcotFWFSfc4V3mrRp
         uFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OApmoIvKEwANRXPyc/6OWQeR4K/MRqLWVFQnZsIe75s=;
        b=naUWT33QyEO0us0XEUyzw5FQUop/OF3hUirluONzsVE8qmKy3+nKMqN70LaxUfWxOD
         UAdEwmEgEheV/FtxpDUQnR4nFr2YNHY2L7CMbAYp2c73Fy0va1Knj7KkWOqM+X6epubX
         62JCYaSNeNvAboPl0gSMNzPlRGBDh+owy3iwHShxQtkMnwuATuB2/Ahhf6sGST5NMQpV
         tPGorI9ZqP31Ttvj8vEJVfqfoAcwjGqZAAkmSY8LgqvrQajgJsj67Om7YtCN9yDqbvkC
         cr0SliBtM5c0qPBZ8nAaFSZPTQc0aUNphFlTYB0cW9DvIQhdIzhhaio1spHYOLXKunz9
         t8eA==
X-Gm-Message-State: APjAAAWQgg6E87ZSdj2nZ52vgShGZq+Ya/kmZg74S3kygYVRWVIhjOTz
        tRVE3ss86hihDiWdCXbCjtSdDSc0W3I=
X-Google-Smtp-Source: APXvYqxw5prX4LW+ZcDIKAOXQz6YaysquJkWFMIYp85rfI2NOXgEqGmIgDd6MFSlYm0Djjk4WrsLpA==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr1051669pju.117.1565808462290;
        Wed, 14 Aug 2019 11:47:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:41 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 23/26] drm: kirin: Make driver_data variable non-global
Date:   Wed, 14 Aug 2019 18:46:59 +0000
Message-Id: <20190814184702.54275-24-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index f1853b84ab58..cc79bd4ecec2 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -28,18 +28,9 @@
 
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
+				const struct kirin_drm_data *driver_data)
 {
 	int ret;
 
@@ -95,6 +86,21 @@ static int compare_of(struct device *dev, void *data)
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
@@ -131,15 +137,21 @@ static int kirin_drm_connectors_register(struct drm_device *dev)
 
 static int kirin_drm_bind(struct device *dev)
 {
+	struct kirin_drm_data *driver_data;
 	struct drm_device *drm_dev;
 	int ret;
 
+	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
+	if (driver_data == NULL)
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
 
@@ -189,12 +201,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
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
@@ -208,7 +214,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 static int kirin_drm_platform_remove(struct platform_device *pdev)
 {
 	component_master_del(&pdev->dev, &kirin_drm_ops);
-	driver_data = NULL;
 	return 0;
 }
 
-- 
2.17.1

