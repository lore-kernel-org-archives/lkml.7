Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EF1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919B72184B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmouxbbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfHNSrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38742 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbfHNSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id m12so1473plt.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gw3U46bCPqQ3ETjFXBi+tKlBVOcmrTwPQEr2UHcNkBY=;
        b=pmouxbbveIAlwOzdvdJ0p2QuUl0N5XG++0VuOjCBBmWnVYFCP4/wQRHPGVv1pRGvYw
         4wg1Xf4d9fVYnzoyLtAeULaYrcSYtaYG0I1Z3y0FhIX2KJk1ocSo8T8h5Z71WP6z/hH5
         s4wFGm6zOHbqtkCTaoqfwS5uH1UECFUwKa8GMRieSlsL2z1NJirkTdgU/XR8LN8hjXkm
         rmCn+GHiNihGmUzm7VuuAORrLmjxRpgweMfjbCxY+7UHg0oXbkJPUByS0z9mHj8eEDZz
         zm3mQOQIY8TXhMNSWzud0C5PhOYdPkLBKq00eOqjrkRiO52X3Z/F8dlVIiLiAJlgApE/
         TCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gw3U46bCPqQ3ETjFXBi+tKlBVOcmrTwPQEr2UHcNkBY=;
        b=UIhTBAk5Z+zwfq7iivrSYge6wwk6dYOyA74Xt8StqbuhnXdEUhKf2C86jFbYMntjTT
         DTEUPyGw13fI6uN6iw0dA7WY13VqyVKYxDUxGbCkm48ziaIKP38BRmNgl9A7xRDuYQYq
         M7Ygi+mtBxXjjBWVOiIlMs3+gwYEt+PLLzOoE+dfnSOODXkdYpEOOPM/V07mDJCYDQbp
         O/PMAkuBt0T79agGAQa02dV1qkBTG2TI1RMFuk6MVNZx1MLxAuDPyez++1zMZIXJDsGa
         o5IT/9a6TICaNzbiCBTvz8oW87du3cgslSTYnkaAF4zeaWUN51wPEnb5pcRrblcIxpLc
         QqDw==
X-Gm-Message-State: APjAAAVdevbvNz1KPvaQXQvv5X6moeQ21RoukadxqiTJbRjKU27ComNj
        FhebyGwgR7uuF/k5wiBd26zgs31BCMg=
X-Google-Smtp-Source: APXvYqxf8PRCM/QdhrsCcFY9B3bUT+kDckdce2dIlrs5TtWi1x5QHwHYOwWNMfZiWnKyqYVld6Vd2Q==
X-Received: by 2002:a17:902:7686:: with SMTP id m6mr744989pll.239.1565808456343;
        Wed, 14 Aug 2019 11:47:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:35 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 19/26] drm: kirin: Move drm driver to driver data
Date:   Wed, 14 Aug 2019 18:46:55 +0000
Message-Id: <20190814184702.54275-20-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the drm_driver
structure to be under device specific driver data.

This will allow us to more easily add support for kirin960
hardware with later patches.

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
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 27 +++++++++++++
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 38 +------------------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  1 +
 3 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 68efd508d86b..0bc2e538913b 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -1049,6 +1049,32 @@ static const struct drm_mode_config_funcs ade_mode_config_funcs = {
 
 };
 
+DEFINE_DRM_GEM_CMA_FOPS(ade_fops);
+
+static struct drm_driver ade_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
+				  DRIVER_ATOMIC,
+	.fops = &ade_fops,
+	.gem_free_object_unlocked = drm_gem_cma_free_object,
+	.gem_vm_ops = &drm_gem_cma_vm_ops,
+	.dumb_create = drm_gem_cma_dumb_create_internal,
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
+	.gem_prime_export = drm_gem_prime_export,
+	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap = drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap = drm_gem_cma_prime_mmap,
+
+	.name = "kirin",
+	.desc = "Hisilicon Kirin620 SoC DRM Driver",
+	.date = "20150718",
+	.major = 1,
+	.minor = 0,
+};
+
 struct kirin_drm_data ade_driver_data = {
 	.num_planes = ADE_CH_NUM,
 	.prim_plane = ADE_CH1,
@@ -1056,6 +1082,7 @@ struct kirin_drm_data ade_driver_data = {
 	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
 	.config_max_width = 2048,
 	.config_max_height = 2048,
+	.driver = &ade_driver,
 	.crtc_helper_funcs = &ade_crtc_helper_funcs,
 	.crtc_funcs = &ade_crtc_funcs,
 	.plane_helper_funcs = &ade_plane_helper_funcs,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 7956d698d368..296661ba300f 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -92,41 +92,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 	return ret;
 }
 
-DEFINE_DRM_GEM_CMA_FOPS(kirin_drm_fops);
-
-static int kirin_gem_cma_dumb_create(struct drm_file *file,
-				     struct drm_device *dev,
-				     struct drm_mode_create_dumb *args)
-{
-	return drm_gem_cma_dumb_create_internal(file, dev, args);
-}
-
-static struct drm_driver kirin_drm_driver = {
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
-				  DRIVER_ATOMIC,
-	.fops			= &kirin_drm_fops,
-
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops		= &drm_gem_cma_vm_ops,
-	.dumb_create		= kirin_gem_cma_dumb_create,
-
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_export	= drm_gem_prime_export,
-	.gem_prime_import	= drm_gem_prime_import,
-	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
-
-	.name			= "kirin",
-	.desc			= "Hisilicon Kirin SoCs' DRM Driver",
-	.date			= "20150718",
-	.major			= 1,
-	.minor			= 0,
-};
-
 static int compare_of(struct device *dev, void *data)
 {
 	return dev->of_node == data;
@@ -134,11 +99,10 @@ static int compare_of(struct device *dev, void *data)
 
 static int kirin_drm_bind(struct device *dev)
 {
-	struct drm_driver *driver = &kirin_drm_driver;
 	struct drm_device *drm_dev;
 	int ret;
 
-	drm_dev = drm_dev_alloc(driver, dev);
+	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
 
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 43be65f82a03..fdbfc4a90f22 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -42,6 +42,7 @@ struct kirin_drm_data {
 	u32 num_planes;
 	u32 prim_plane;
 
+	struct drm_driver *driver;
 	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
 	const struct drm_crtc_funcs *crtc_funcs;
 	const struct drm_plane_helper_funcs *plane_helper_funcs;
-- 
2.17.1

