Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02ADC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B5522389
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e1kJc7Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfGWFej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:34:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfGWFej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:34:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so20138023plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjH/NM5oVv7H9uBQXA0g2+9MGVMLUo5V2j2Ab6tkFdQ=;
        b=e1kJc7Imcps/BQqLY9JmYE7KcH1qEhz6vGEQ+C0CKAzI/MjVacKJotEbbRy0agAQOz
         4nEtxt1HkMl/8nWwPwR66ZLEWyBveI3poPvukJtoGULPge/MvVnQV+k3KLC1TWG8xZfe
         /b4J5AI4dM5RoSybeX1bjyIM2fCjBF8/ZKa5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjH/NM5oVv7H9uBQXA0g2+9MGVMLUo5V2j2Ab6tkFdQ=;
        b=d/PzFsjdAjXl89Vq7MED3fwX/fN4vJuCWyV/+zO1uLmmHu50d8vYs+XLoyNrJSom/6
         aq/HVqt57CF4DYeTh1gxjvuRYEvMDgQlUc6ul/L8CY4ufBGWWvaFjfIMhfCXKodthEaS
         5kxpSD12UYsf/Z2iLBfqOkNp7Ajv2ZFaotvtliC3HvTEsygKV78+BUMPM3Zx+540Fh2Q
         Z2IYZFAKGeHbvEFJuBrnRQYRSlRLrJKdDl6A5jEL3jpwPLNgcaVsX8UDwvopHTe57sxI
         ODgWDuqKCYff8akhKUxLXXPJOQIPU63uRPuIHSCjNeTimq984qUe5KOxbARc+j4YgIOd
         Q9sw==
X-Gm-Message-State: APjAAAUOXVnMx9dowMqM7ckfrpYIzxwme1BosyPD8WQk82BYtV1sGB60
        0QxeT22Ya0o9Qo5vFCybdt78cw==
X-Google-Smtp-Source: APXvYqxYnjCQS0yig4uPvUOAHO/NOMq/4OMIXXTGrOWktJAfQ6s+A2dzqTm04IEgzj2OO9MW8RnltA==
X-Received: by 2002:a17:902:e011:: with SMTP id ca17mr80393568plb.328.1563860078113;
        Mon, 22 Jul 2019 22:34:38 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id a3sm44030666pfi.63.2019.07.22.22.34.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 22:34:37 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] drm/mediatek: make imported PRIME buffers contiguous
Date:   Tue, 23 Jul 2019 14:34:21 +0900
Message-Id: <20190723053421.179679-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver requires imported PRIME buffers to appear contiguously in
its IO address space. Make sure this is the case by setting the maximum
DMA segment size to a better value than the default 64K on the DMA
device, and use said DMA device when importing PRIME buffers.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 47 ++++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 95fdbd0fbcac..4ad4770fab13 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -213,6 +213,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	struct mtk_drm_private *private = drm->dev_private;
 	struct platform_device *pdev;
 	struct device_node *np;
+	struct device *dma_dev;
 	int ret;
 
 	if (!iommu_present(&platform_bus_type))
@@ -275,7 +276,27 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 		goto err_component_unbind;
 	}
 
-	private->dma_dev = &pdev->dev;
+	dma_dev = &pdev->dev;
+	private->dma_dev = dma_dev;
+
+	/*
+	 * Configure the DMA segment size to make sure we get contiguous IOVA
+	 * when importing PRIME buffers.
+	 */
+	if (!dma_dev->dma_parms) {
+		private->dma_parms_allocated = true;
+		dma_dev->dma_parms =
+			devm_kzalloc(drm->dev, sizeof(*dma_dev->dma_parms),
+				     GFP_KERNEL);
+	}
+	if (!dma_dev->dma_parms)
+		goto err_component_unbind;
+
+	ret = dma_set_max_seg_size(dma_dev, (unsigned int)DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(dma_dev, "Failed to set DMA segment size\n");
+		goto err_unset_dma_parms;
+	}
 
 	/*
 	 * We don't use the drm_irq_install() helpers provided by the DRM
@@ -285,13 +306,16 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	drm->irq_enabled = true;
 	ret = drm_vblank_init(drm, MAX_CRTC);
 	if (ret < 0)
-		goto err_component_unbind;
+		goto err_unset_dma_parms;
 
 	drm_kms_helper_poll_init(drm);
 	drm_mode_config_reset(drm);
 
 	return 0;
 
+err_unset_dma_parms:
+	if (private->dma_parms_allocated)
+		dma_dev->dma_parms = NULL;
 err_component_unbind:
 	component_unbind_all(drm->dev, drm);
 err_config_cleanup:
@@ -302,9 +326,14 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 
 static void mtk_drm_kms_deinit(struct drm_device *drm)
 {
+	struct mtk_drm_private *private = drm->dev_private;
+
 	drm_kms_helper_poll_fini(drm);
 	drm_atomic_helper_shutdown(drm);
 
+	if (private->dma_parms_allocated)
+		private->dma_dev->dma_parms = NULL;
+
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
 }
@@ -320,6 +349,18 @@ static const struct file_operations mtk_drm_fops = {
 	.compat_ioctl = drm_compat_ioctl,
 };
 
+/*
+ * We need to override this because the device used to import the memory is
+ * not dev->dev, as drm_gem_prime_import() expects.
+ */
+struct drm_gem_object *mtk_drm_gem_prime_import(struct drm_device *dev,
+						struct dma_buf *dma_buf)
+{
+	struct mtk_drm_private *private = dev->dev_private;
+
+	return drm_gem_prime_import_dev(dev, dma_buf, private->dma_dev);
+}
+
 static struct drm_driver mtk_drm_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME |
 			   DRIVER_ATOMIC,
@@ -331,7 +372,7 @@ static struct drm_driver mtk_drm_driver = {
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_export = drm_gem_prime_export,
-	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_import = mtk_drm_gem_prime_import,
 	.gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
 	.gem_prime_mmap = mtk_drm_gem_mmap_buf,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 598ff3e70446..e03fea12ff59 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -51,6 +51,8 @@ struct mtk_drm_private {
 	} commit;
 
 	struct drm_atomic_state *suspend_state;
+
+	bool dma_parms_allocated;
 };
 
 extern struct platform_driver mtk_ddp_driver;
-- 
2.22.0.657.g960e92d24f-goog

