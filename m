Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D989C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E272339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3n3QKSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHTXHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfHTXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so100685pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jrafS1xNw8QuY6208vzcwdkt7ZoMFEpwTrneiMG+q3Y=;
        b=x3n3QKSmp9O/+aB+dueAM4VMGwlrka/AjLuZQIGhfTSRJL3h02hR4DaP89vrNglcLI
         aODrVQVO3nmXcjujtmB3WzPKUMa+WmElxF3+if7c1eZP01jl8XqgpnGczM6DmIkXpkQH
         ptOIvlb9Q1cpl3/EqkR7Pydd77uHQKpN5/2+Ik3+M6wm/RRUGhCYtfKI/RdDrCEbHNs8
         +rNB2vyOBpyF33L/rs1vEeWPRRAsSdUsKuycuh+Y/uluizXm1IMZFFpwNAAZEYHnTEFy
         nqJihsNLgRZJ4mo3uEYtpqusja+UoX7Z2if/FpH2vg1OTMR7qiTnJJ03u/WdDYnr0FDW
         8o+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jrafS1xNw8QuY6208vzcwdkt7ZoMFEpwTrneiMG+q3Y=;
        b=BNAk2z4sTJTyfNln3pYDZ8UJfIpsrOfmUNik8DGFYRs1gliv4EUxxApIqSBJo3v8Py
         GoM0/pIHCgLMHbS3lQ0sg/hsZwJDXWSZH0P/EEGuYIcYBfzuwp9EHKOzvmsdlGYH4D7S
         nbF3SJ1/KYs4HisCsPRXE/X8PblcjIY+R+KXE3kJYeLfu5XE1aF+GqHFWRjzviYtBJVk
         TD9p5A3E+/lg7/MGBg1PggYbF2OwCTWt5Cy5qIToWbJjN7C5ztetZwRVt2R2SXkJqpda
         8GwsBAp/PiGgv+3XvKtDoudpzhS8/EDjx13Mcmp7rrZHvni/FK34ShTjx/CdVuaLGFzF
         Wm6Q==
X-Gm-Message-State: APjAAAUdmLMqbqBf00a7asNER7tiQ86RsaYZZNBNx03f+OxT+u13zEF5
        sIvDf9+VlmMsGmFgzhDOw6CLKKS2nFU=
X-Google-Smtp-Source: APXvYqyquopmDIvJN+OnfrRPasNzNke/5ztk9S/nht4GczZwiyytgvvzq6gNRK0k3RRvbAzdh+5hmA==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr2408433pjb.27.1566342407060;
        Tue, 20 Aug 2019 16:06:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:46 -0700 (PDT)
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
Subject: [PATCH v5 12/25] drm: kirin: Reanme dc_ops to kirin_drm_data
Date:   Tue, 20 Aug 2019 23:06:13 +0000
Message-Id: <20190820230626.23253-13-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
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
index 3fbf099597c1..4c6646dfc465 100644
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
index fcdd6b1e167d..3d22f944a840 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -29,12 +29,12 @@
 
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
@@ -68,7 +68,7 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 	kirin_drm_mode_config_init(dev);
 
 	/* display controller init */
-	ret = dc_ops->init(to_platform_device(dev->dev));
+	ret = driver_data->init(to_platform_device(dev->dev));
 	if (ret)
 		goto err_mode_config_cleanup;
 
@@ -99,7 +99,7 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 err_unbind_all:
 	component_unbind_all(dev->dev, dev);
 err_dc_cleanup:
-	dc_ops->cleanup(to_platform_device(dev->dev));
+	driver_data->cleanup(to_platform_device(dev->dev));
 err_mode_config_cleanup:
 	drm_mode_config_cleanup(dev);
 
@@ -194,8 +194,8 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *remote;
 
-	dc_ops = (struct kirin_dc_ops *)of_device_get_match_data(dev);
-	if (!dc_ops) {
+	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
+	if (!driver_data) {
 		DRM_ERROR("failed to get dt id data\n");
 		return -EINVAL;
 	}
@@ -213,13 +213,13 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
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

