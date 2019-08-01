Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B08FC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E91217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHlnFrgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfHADpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39468 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbfHADpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so29161706pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FV+Ip5UJVFLvXV2Kbx6mP8jgdekGleioA3N1UoXWC+U=;
        b=uHlnFrgC8+6Hfx3oZ5a9WhLfAgD+Y92NSQA89mb3ow8hsetvrvjs1DXJqOSilKtF0w
         TxSk2bWONbISR+w93knaEIZLQF2wPtpRx6eRi7kwtfpEhi4Auw17HwGJv9KybM3hSVoA
         0ZhJCRbwtDI6O0HBojX4g880aVI7TWIpvtdkgTOxBglM8ve1niAjB0BH+ZkZ8RQLT93z
         iP4kqyzWPA/f+w59h08TZL9M4Jw4qGanPUfn1ZYyr2g0fmeCuVvT0NtSP2fw3YhiG43W
         n0PsKHdzC9QJZ8SqbqGdfq5AKd/juAs/9kGGeqpSMmYrrASeJJs5bu1t/zBs3UbHkryo
         dLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FV+Ip5UJVFLvXV2Kbx6mP8jgdekGleioA3N1UoXWC+U=;
        b=B0CFj7f0KiOeQIvmM+9CemaCaBvAiLFS/xEgJAZHGABl7ZGFsPEfFy709PMcwjjz4j
         6WkwTZaJH5P8p0nOev1HH++mwRnemsJLvNwk1n5nmoIlBFQoV2wXQF8v67LQ5lLFEtos
         QYm4WKR7j0KReduMAVLpJs1PBNPvTajRphylLOF1sbhqSosSlcG9+mB1ZKbKoEkjv9n2
         gHx58igS16upTHulIQ5Wc2hbl0vUpobRCeptF4K+cjiQyz0OoMns1pVoyIuWR+61b7ir
         D+HOuoPMJ63Jvjs6/VQsOhhHJnOvTWnGfDiepz8C/EV9XiNooJ/5PjM/f8OnyJCc793F
         xGQQ==
X-Gm-Message-State: APjAAAVT/FQXysr5N5gCyuEWLL3m2XmphNPcSeZkIMTFH1O57weqNI0u
        Hnq3+wajEbBFDqr5fmMzywkec67xB/E=
X-Google-Smtp-Source: APXvYqxvh6sg9DNxbgSmyTVWeayZICBhMnV4QBgK8vE6UF4xYdS0IxloUbKEFvIE6TntZDtyx76h2g==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr42260227pfn.218.1564631105631;
        Wed, 31 Jul 2019 20:45:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:04 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 13/26] drm: kirin: Reanme dc_ops to kirin_drm_data
Date:   Thu,  1 Aug 2019 03:44:26 +0000
Message-Id: <20190801034439.98227-14-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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

