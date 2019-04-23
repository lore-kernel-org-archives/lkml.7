Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2067CC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17A0218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVWn/lsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfDWXV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40367 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfDWXVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so8361480pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J7WS362NKRHc8TtGj/Vn0nXkl/YG6bO8Uc5paDKycAo=;
        b=oVWn/lsEfBEEg1ittPmeAehdCZlbXDUOseKSawgAKA3xZqf0ekcOV18j8vkRNyihvx
         MgjjxKIYgGwKqhogozHZKjyLPMqPpULYvEtGoKp6v0xcebU2Hln5+4jYVO4Q9oYer/p9
         0bM5jzkvdJoYToIQ4pk/EjhL2RojThFQRfrXjTfb7PpYlSqiOfwoE0kDPKNKZjKdIKsg
         /cO6w///QLDG6GSt9t0DQmTxaBm7mg8Oid8l0Shpg6rRAe3di95hCJJDFRJz3anrPEmm
         mTFr1nMp7kZKLtR6/FnICTn834D3axUuxaBVpfe8ijqHc79RzJBLoCuRVmtGQxbGrII2
         vCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J7WS362NKRHc8TtGj/Vn0nXkl/YG6bO8Uc5paDKycAo=;
        b=t4OBOgAD73CdV8ZLW+JgDMSHOYi1NR6e/J7fedWD+e2HLwG+DfnapV4/UYYIZkpo1L
         p7sKolsxhiLsBdmbYJCGuLWcpQKM9xLrW7YfXyVwVRC+EP165XbmTujocz1qA97GtnvZ
         lE65FNTw8fuSndcfFxyU7ZfYaxVcw3/AEp+neiurob2v2LnKzmjLM9zKnJVtwBxmuJDW
         0irh3HFizMoQWdVm9hqfSs4PTPGOT05ryElNXs66Qdo+sR+Izd60Z2HxSOS5rXBvkFsF
         NahCDw0B0ydWdT6KM/EanKVkwLwDLJhJVVCLNYjSRXjT53X5keMvS1HUZXFqqX89Ulgn
         VFUA==
X-Gm-Message-State: APjAAAWYDSP/Wop3hTL/I22kjdHCw+DfJfF8eNDYLolI/HFLasKwQXbF
        O3Do1EqCuOhbZnghoKQhVcZjA1C4VUw=
X-Google-Smtp-Source: APXvYqy5jPd8/syV+26q23zSB0JKQ5Qd5Jtzd9xqtc4PXOznIW7qKcD5ehVs7FCVSQ79/L2Nt5arVA==
X-Received: by 2002:aa7:8e55:: with SMTP id d21mr29525492pfr.62.1556061682009;
        Tue, 23 Apr 2019 16:21:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:21 -0700 (PDT)
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
Subject: [PATCH 15/25] drm: kirin: Move mode config function to driver_data
Date:   Tue, 23 Apr 2019 16:20:46 -0700
Message-Id: <1556061656-1733-16-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the mode config
initialization values into the kirin_drm_data structure.

This will make it easier to add support for new devices
via a new kirin_drm_data structure.

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 10 ++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c |  8 +-------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 0ebe715..0e68257 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -30,6 +30,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 
 #include "kirin_drm_drv.h"
 #include "kirin_ade_reg.h"
@@ -1038,6 +1039,13 @@ static void ade_drm_cleanup(struct platform_device *pdev)
 {
 }
 
+static const struct drm_mode_config_funcs ade_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+
+};
+
 struct kirin_drm_data ade_driver_data = {
 	.channel_formats = channel_formats,
 	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
@@ -1045,6 +1053,8 @@ struct kirin_drm_data ade_driver_data = {
 	.crtc_funcs = &ade_crtc_funcs,
 	.plane_helper_funcs = &ade_plane_helper_funcs,
 	.plane_funcs = &ade_plane_funcs,
+	.mode_config_funcs = &ade_mode_config_funcs,
+
 	.init = ade_drm_init,
 	.cleanup = ade_drm_cleanup
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index b52c40d09..4b210ea 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -41,12 +41,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 	return 0;
 }
 
-static const struct drm_mode_config_funcs kirin_drm_mode_config_funcs = {
-	.fb_create = drm_gem_fb_create,
-	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = drm_atomic_helper_commit,
-};
-
 static void kirin_drm_mode_config_init(struct drm_device *dev)
 {
 	dev->mode_config.min_width = 0;
@@ -55,7 +49,7 @@ static void kirin_drm_mode_config_init(struct drm_device *dev)
 	dev->mode_config.max_width = 2048;
 	dev->mode_config.max_height = 2048;
 
-	dev->mode_config.funcs = &kirin_drm_mode_config_funcs;
+	dev->mode_config.funcs = driver_data->mode_config_funcs;
 }
 
 static int kirin_drm_kms_init(struct drm_device *dev)
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index f688612..700a203 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -46,7 +46,7 @@ struct kirin_drm_data {
 	const struct drm_crtc_funcs *crtc_funcs;
 	const struct drm_plane_helper_funcs *plane_helper_funcs;
 	const struct drm_plane_funcs  *plane_funcs;
-
+	const struct drm_mode_config_funcs *mode_config_funcs;
 	int (*init)(struct platform_device *pdev);
 	void (*cleanup)(struct platform_device *pdev);
 };
-- 
2.7.4

