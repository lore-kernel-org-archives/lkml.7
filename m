Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529B0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147A4218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Undrc2yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfDWXVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36917 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfDWXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so8272010ply.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MSWdAG5VWJ9ruY+QIEAe/DWWyhDDBrXkAQEyNQpRh7I=;
        b=Undrc2yujPz9BHO8ZYDZwQgjbX9U8mUottC4PSHk1grQkFtNsdC5fKyBvwk9oJ0TUZ
         zxbC2QgmW1uH7J+Vwd2kw/IJOR6byz0LF9rXkp+t+UfZEnTCQQlEsReoEMKqLvaFkEaQ
         4kCf6cD6IX2jndhtqkzxgojhtssD7DbgB5jHh7AVjOJzkhajgWndHjJjH1UnBjcI/YQA
         izmoWxzClQUddI5qaZhsMf+5uO1JONfWqB1hpyfmedSED9IvWmXTT/xK+sCDo13SmMXO
         st3CMl1jd/2z+4Mk6Oiy5qbAWOIl2CdRfCY1jtFIKPRV2+V0ZrfFqzMTNEqJ1c4fEbax
         V/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MSWdAG5VWJ9ruY+QIEAe/DWWyhDDBrXkAQEyNQpRh7I=;
        b=B7H9LzAoZNpdevWwX/TT3K15MsB8Q4wOY4wSx66dBhZKR6k4dBTLCajx+3CuVhd3ss
         OkDmrKKc+hGuqQvFynqR78pQSJsWgeebsN+dyiGvTRl3LwL5+62mXmbgg0gjFS9dXYGV
         19ixRlUHDo2GXkVmlOB6E73CpgbAqzApqBNy86CbbQxJ5EHXHMdUbaV+efnjT71j7il1
         iVMARHnBrQxrb6zUUnwyW20l5sZErgAPzqe8vIUBDam/LFmfdf3jyUgGnzz6iRI0iI2F
         maTbDSFlZSCfIICJ7Gaf79w9vT+njQhgzI/3TZ66xUA39CGms+A118BHtL9Yxmx/+D0s
         p7MA==
X-Gm-Message-State: APjAAAUIe5v+/YToDITvMWQc3HBs3EUXumgKkSmNfmgxMbeaN8MlNQKa
        47w5YQXC7d/NFkL+EBszwEYNuA/LiFo=
X-Google-Smtp-Source: APXvYqxnEx6l5bQ9FjuGPp9T12WPdNKX/NJmS2VthRc+O+JxUxxHEOVWqS+Abvpfp1Kz/mqPRj3chA==
X-Received: by 2002:a17:902:3183:: with SMTP id x3mr28891345plb.170.1556061686166;
        Tue, 23 Apr 2019 16:21:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:25 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 18/25] drm: kirin: Move drm driver to driver data
Date:   Tue, 23 Apr 2019 16:20:49 -0700
Message-Id: <1556061656-1733-19-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
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

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 27 ++++++++++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 38 +------------------------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  1 +
 3 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 8f15269..bdd1b00 100644
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
index 70fee30..c987b4e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -94,41 +94,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
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
@@ -136,11 +101,10 @@ static int compare_of(struct device *dev, void *data)
 
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
index af27acc..61fb0da 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -46,6 +46,7 @@ struct kirin_drm_data {
 	u32 num_planes;
 	u32 prim_plane;
 
+	struct drm_driver *driver;
 	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
 	const struct drm_crtc_funcs *crtc_funcs;
 	const struct drm_plane_helper_funcs *plane_helper_funcs;
-- 
2.7.4

