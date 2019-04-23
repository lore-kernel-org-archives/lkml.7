Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC7FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E280F218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwhOGLab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfDWXVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41866 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbfDWXVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so8345961pgs.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6PCKCPiU9SZdVwZNOi58l1CUoj0+t8ipJfFd6cL3prM=;
        b=GwhOGLabNj1ogmYVg2kJPECIFEX5dIE1sqaqYYlbpRHHj/MegxUZs2twDSbdDOpPrN
         qx89kGM6TT0YMzGJ6MR3VV0EwL1lxcGqj0LpzQaDwSmVNkF2DWg9mFYZ+A84x476fegM
         1zz7DdykbEVJVcC8SODv5cUQNdDmEU0d376ZzTUc0vDqc2uBDDGvi56f67ZyQJ9QcFH8
         u9KqgTLaRwfI/eF8vHHmmpBFydcY63EIrjH6C9+aH8pnCsj1jZjwIR5GyZAuNSGXGIoi
         moOSEzaEQ2i9BsEctw2ye1fGEZbjWQ/zUZ8tdCpXgnFk9ULihgT7SVZDCW/V0QE6REwv
         hR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6PCKCPiU9SZdVwZNOi58l1CUoj0+t8ipJfFd6cL3prM=;
        b=NY1FJZjnaMYNh65P8k94QCj5OEUXg8juiE8N5n274ebZsDj7ycpyKqoVznuRqN/T7M
         rJniqec3EBE3kq4FqoL7AXfRPyHJR4KBg3z0DZ78tzKKhsDXuse3TCJ0Rb+ewlhmCrRS
         vr1m16KPPOWEze5b8/FCiaIBgwqOK5Mr7nRxta1sc1GR9KANkrFfvDe2di2ko2ZHU5nx
         bGu36RspU3DwP4n75YVL7+bckaZuB0VVclAjRaKxy4jAYJmWi1DNGStrnMhNIW4qeVk8
         k2mxsLirgbs6Ptb17f8qsZ9Q9U+/oMHNj22xYiIfdvyGxLIau95c7ihAySA4YXMKbWL1
         ezDg==
X-Gm-Message-State: APjAAAU5Kg+1JuG5znhEi4jisrt9osWrnNVYpyYTrDFzXTi2tnwjZscB
        C0ZLqRD1eG4MDzInF+Wt6o/f2t4OqFk=
X-Google-Smtp-Source: APXvYqxgF42hSTlly68/9rDVQn5ZzCxjggQGa9A7iGZV0Pli2Urp/fkPZiDR+6p7r3hmRhWkcrG6hQ==
X-Received: by 2002:a63:28f:: with SMTP id 137mr27875194pgc.377.1556061677599;
        Tue, 23 Apr 2019 16:21:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:16 -0700 (PDT)
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
Subject: [PATCH 12/25] drm: kirin: Reanme dc_ops to kirin_drm_data
Date:   Tue, 23 Apr 2019 16:20:43 -0700
Message-Id: <1556061656-1733-13-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch renames the
struct kirin_dc_ops to struct kirin_drm_data and cleans
up the related variable names.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 16 ++++++++--------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 69604ad..221bfbb 100644
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
index c9297d6..b52c40d09 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -30,12 +30,12 @@
 
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
@@ -69,7 +69,7 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 	kirin_drm_mode_config_init(dev);
 
 	/* display controller init */
-	ret = dc_ops->init(to_platform_device(dev->dev));
+	ret = driver_data->init(to_platform_device(dev->dev));
 	if (ret)
 		goto err_mode_config_cleanup;
 
@@ -100,7 +100,7 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 err_unbind_all:
 	component_unbind_all(dev->dev, dev);
 err_dc_cleanup:
-	dc_ops->cleanup(to_platform_device(dev->dev));
+	driver_data->cleanup(to_platform_device(dev->dev));
 err_mode_config_cleanup:
 	drm_mode_config_cleanup(dev);
 
@@ -198,8 +198,8 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *remote;
 
-	dc_ops = (struct kirin_dc_ops *)of_device_get_match_data(dev);
-	if (!dc_ops) {
+	driver_data = (struct kirin_drm_data *)of_device_get_match_data(dev);
+	if (!driver_data) {
 		DRM_ERROR("failed to get dt id data\n");
 		return -EINVAL;
 	}
@@ -217,13 +217,13 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
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
index b6626f5..276b159 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -38,11 +38,11 @@ struct kirin_plane {
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
2.7.4

