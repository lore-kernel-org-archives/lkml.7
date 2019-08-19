Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D48DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D753E2341A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDl7w3VE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfHSXE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:04:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42471 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbfHSXDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so1678076plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xtc8YOCqaZZ1cFKsJ32BIebxmxyffX6TKZKTWf0ZB3U=;
        b=LDl7w3VEwYJGEAWm+n9mH4b6C5mMs9WVT1LRZG+vOuZf25V5X133ACFSJU3htofPOw
         jQ6ufPJzGnkeWWdesKsOVhd2HLjxrnBLyOUfevOR9+0ovUgjxTorHsJwT1895rbKJv8I
         o6RcQXOv4mNwlJP1WvafJvsxSjlQl1bkQa6g7iADZJpP8YMppVPzrhtXFmbaQr+wKgau
         FIus3JIVGxA9Y6g7pfNBavmocUaT8F1d3dc4EE0uL0+MVwWi2/7t9BWERxCb+vWlaZKW
         S6hIBkVzNbtJUrDtZGpHoM27iFpmNmHTCqnGviGtSaXitUPrEexH4GbnrNmR8mCxSCpV
         8rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xtc8YOCqaZZ1cFKsJ32BIebxmxyffX6TKZKTWf0ZB3U=;
        b=KBzmbkeIAYblHHQagLjvteiJAnjC4fDWIn9GED2v+8FLKUYytF1ywTquRLIH1SmP/v
         gxbm15X9BLVf0NvJut1HK+uZwhP4HEAvfxZQKq1C5dIcF5RzMfQfreW/Myl2II/th2mX
         QPdqllf9y/2VJqQ9yxA21dvyhsTJz9G8pcJILX/FYtmdGUVT4zDzCUI5MYX4e1td28+m
         o4nTJneP9wlVsb3Dgi4LOjk+ZLilqStJCySfyb5RTob6Xeinvqjc4Kwa8wghsrwPCir/
         m/U52k5DG2bUeDZeqphNoTXoruijA438aiiuvumHAF/sB4yYEXdPY37Ymb/sGK4tSYY4
         W3WQ==
X-Gm-Message-State: APjAAAV9VXFFOPM+zufd/HchxP8bleqwyFLkI9TN2G33j5f6g8YKLCgR
        revcPmroiADgtu567+X51zTsUOC661U=
X-Google-Smtp-Source: APXvYqxoyTvVmfTWQisDIjAh1zW6bHXsxn85+zUFUhjXI22YOeaKbLw1toj8yQHSWNqNT4useLHjVw==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr25514788plc.78.1566255832855;
        Mon, 19 Aug 2019 16:03:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:52 -0700 (PDT)
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
Subject: [PATCH v4 18/25] drm: kirin: Move drm driver to driver data
Date:   Mon, 19 Aug 2019 23:03:14 +0000
Message-Id: <20190819230321.56480-19-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 24 +++++++++++++
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 35 +------------------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  1 +
 3 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 2e29a228f3f4..7db2cf93a245 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -1049,6 +1049,29 @@ static const struct drm_mode_config_funcs ade_mode_config_funcs = {
 
 };
 
+DEFINE_DRM_GEM_CMA_FOPS(ade_fops);
+
+static struct drm_driver ade_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops = &ade_fops,
+	.gem_free_object_unlocked = drm_gem_cma_free_object,
+	.gem_vm_ops = &drm_gem_cma_vm_ops,
+	.dumb_create = drm_gem_cma_dumb_create_internal,
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
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
@@ -1056,6 +1079,7 @@ struct kirin_drm_data ade_driver_data = {
 	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
 	.config_max_width = 2048,
 	.config_max_height = 2048,
+	.driver = &ade_driver,
 	.crtc_helper_funcs = &ade_crtc_helper_funcs,
 	.crtc_funcs = &ade_crtc_funcs,
 	.plane_helper_funcs = &ade_plane_helper_funcs,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 2ab32c2e3f95..c9faaa848cc6 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -93,38 +93,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
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
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
-	.fops			= &kirin_drm_fops,
-
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops		= &drm_gem_cma_vm_ops,
-	.dumb_create		= kirin_gem_cma_dumb_create,
-
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
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
@@ -132,11 +100,10 @@ static int compare_of(struct device *dev, void *data)
 
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

