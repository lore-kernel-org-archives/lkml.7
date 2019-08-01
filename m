Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E8BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F5021873
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RP6VNmIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfHADp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46032 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfHADpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so33147145pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rs9Szavz01lGhxB105GpAFsAJ0GA/GmuWwL2NPh/1Lc=;
        b=RP6VNmIXUw1IL4IlU/gJX7/aS4NwEOhx/k3T7v40iplb7HaAg2bBR7EI8juAW1lE55
         vw6RqUXZQn3tzgtDzP0XsTs3ja9B/7159KzfkX54QjTFKlyTP+7rUMdBpNEwM8f4H+Q1
         RQAJii8IzqE0kjvaAjt8x0QfrS6CnWwcPgJkWJ4u29rnqq4ZQrWc6T7B90GtioTl7Mej
         1zTbWRFa5mNN66sboTxlSVMNtib5QODg6O7jwD0QqAsNBUlDidIDNhI1tKeHcQHqb4pT
         /7z7Olx6LVMSexR8gg28q5lGFz3YVQXSjv55qaYe9xAdqIzMauUdjH45JsfirfZl4b/+
         84lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rs9Szavz01lGhxB105GpAFsAJ0GA/GmuWwL2NPh/1Lc=;
        b=lOB3uX2BFXvqhC22qjXXHWLnfDClQz7wLSPzYmKzny8gtuRMPBjPEHnjESvZkYYGAP
         odoFB1hRPjHcRZN+nvraF+lPB1Q5MgN/qW4l5dCmAruCIfKZiRIK1yQLobUbOCAU/N0+
         NNpDjNH01PFT2kARj1ZMYclVTaN2jKU6ZjjOhu+mqCfzfqPsUk0IsWjVtweM6HDPIcZ+
         MUPlTQoFNWqvnNNswuQHVyLhUgOruEBpNt3GDxqpSygOxCX+ylM5GMasBPtl+mrjhJ00
         mf42xqwr2DH0rKHw3v40rwQWwmDK5KinSklZpwB18ZmS3r2zQqGq5HoNbD6TnEhK48Wg
         d8Tw==
X-Gm-Message-State: APjAAAX1ng4uJG/HX5NYbim/uhQzXhzoBA1HdlMldd44KKRt52dBR86q
        Q5KvvoMXY1suoW+pPKXfSFaOtHj619c=
X-Google-Smtp-Source: APXvYqx6GQJiArHkNMY5CkBCvPwyOdt4fTOYA/3VTALL2+Rl1TPDFGIT8W/5hN361RUoQi54wouXQw==
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr6233618pjb.117.1564631121372;
        Wed, 31 Jul 2019 20:45:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:20 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 23/26] drm: kirin: Make driver_data variable non-global
Date:   Thu,  1 Aug 2019 03:44:36 +0000
Message-Id: <20190801034439.98227-24-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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

