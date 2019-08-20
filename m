Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E1D233A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0v6vChM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfHTXHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45842 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfHTXG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so139457pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wvJMWqAUNb5jXlSdlJ418hl6Ngg4JxX27ryR36PDJ9Y=;
        b=H0v6vChMxN+/FQzorsOoz4YIWOLQ1cFQ7JP50K8oPSWmmhzG9FFy206mcOK0mlMk2w
         3sydKbEEN3ma79faN7FtUyVuSdCXDCIgCoMVOy7ZOKdM1XtKvVVi+/mBvK7qqDIf6LuJ
         HgdyhD42cfDzWIWlUBBTSW79gVlwO9Uj2WGimde4H6ILbpTJTza3gMO9snInbsTEYa65
         xz1tvmxD3dKuTzliZsxSXJPWOLa8I7qx/65zuUviK5nfO7Y+OSX46svH58e3IaJGlJyr
         qkyVzY8uQ/i10HR+M69rPmzi90jnUSx/s8toZfhfJw2Vbp9ooXFcXyswSbeZJTleQ5z7
         PuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wvJMWqAUNb5jXlSdlJ418hl6Ngg4JxX27ryR36PDJ9Y=;
        b=S0BEKwyhA+OdiH6A/b8wRI1B94ATTIBCklFtYIxb7F3sRXzleMGxVhOUqh06PsEsy4
         8Paoj9pmtKrskfgkhk1ZQ/XKSiRT1PFhU1reZZ2uNXmBgISrSdxXt6UJdi+WisH52X5Q
         H7cH1pAzx4K5BnSGZon4SMMwLmpFDEm6LNLhOrlY3syIpyJpDPiWBxlcAoKU1HgIimlT
         jbRzwwTri8tXnIvwRisQsAjRvaQw6s0ydMsOWFqHhlmvZqBcmorjUSQavLrqjqbHcMnT
         6+pVwAhHFXPkTaFRm+p3RWxLpc6S+Q/g97CKh2r2HnT6cxQGuI5L6imLbi5Fp0uivSA+
         ++eA==
X-Gm-Message-State: APjAAAWvW1WqbwwaOLoZI7J7/rZ/n1ykn8YzRAqTwvOn0fW687iuEj19
        EPMFilllZkKoyOXMMEr1OOzF0o3pb34=
X-Google-Smtp-Source: APXvYqxx+2v5ZATy2+cLItWwS8zkafSjVp6sI3jVJb6qgCj2ZVSWWMmA3ZUTkxhVuxiTJBSkUSFLaA==
X-Received: by 2002:a63:fa11:: with SMTP id y17mr26971937pgh.267.1566342417078;
        Tue, 20 Aug 2019 16:06:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:56 -0700 (PDT)
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
Subject: [PATCH v5 18/25] drm: kirin: Move drm driver to driver data
Date:   Tue, 20 Aug 2019 23:06:19 +0000
Message-Id: <20190820230626.23253-19-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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
index a4cf122375ea..21c5d457a97d 100644
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

