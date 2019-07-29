Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B98C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611C12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="njTypoIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfG2FeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:34:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42074 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfG2FeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:34:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so27380327pff.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 22:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFA6JHvF9RL4SlnrCsKvFmdFU03CeyVLjFDP1pS0wlw=;
        b=njTypoIWLBX0T+S5qtVUNVWH5W/9uNjn4BRJIz3vfNvxtl0S+NyxKpqLBct47BG1Zy
         jG7M/gdLx8a1y8x2IqY+SKnbvRs+uCiytvlgDk6hEm1PDGrT2ZSnxwuIq0ePvaRnnV8l
         UjTRa6FPm9CbDZnEOFLmGEoW1G0ZakKYXXSQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFA6JHvF9RL4SlnrCsKvFmdFU03CeyVLjFDP1pS0wlw=;
        b=fLTXhMbTByISDF86x6dUTlQKmt21sd76JF6HR1w/Po/78vpnO55xD/r0+vJEq5MWqr
         1+nCY2WzpvNuDvBUpjEdx40VQEr2b0c0OrRRkRwA7GLqc7XVZ2lePBVYIaLMh/JvWODr
         0QJYwvE3/lTJ1mQrSbnchjerEW67oPufwezEh+g/vEJWy0S/YN9FgaJ0ZuRION+94SUB
         XuUHkMm070j1bNDPXD1wICu381eogCVWqma+RuaPsTP5NzN3y74RkeHmh0ib50LNn47A
         kFmP8DZcTVAb2kf8y0Y3RQ2RtqEbRd3TZCu0BjndOnhuo7M54LiOmFxemRo+EWGsTcb2
         wakw==
X-Gm-Message-State: APjAAAWU/7hDZh5zHEIusiCwqJExpu5DB98+tOpaekFtqrYbV/RgPA26
        i6X73oQttkRyfDCqg/+JdHQ6Gg==
X-Google-Smtp-Source: APXvYqzkNeaQn+UkeE5CYItkb2celfQKxux5U1FpZg0SMhD7RWrrUnStw+c6KqDZ6DbluZXXZwbGSg==
X-Received: by 2002:a17:90a:2767:: with SMTP id o94mr106651693pje.25.1564378439306;
        Sun, 28 Jul 2019 22:33:59 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id z4sm93792810pfg.166.2019.07.28.22.33.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 22:33:58 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v2 2/2] drm/mediatek: set DMA max segment size
Date:   Mon, 29 Jul 2019 14:33:35 +0900
Message-Id: <20190729053335.251379-3-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190729053335.251379-1-acourbot@chromium.org>
References: <20190729053335.251379-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver requires imported PRIME buffers to appear contiguously in
its IO address space. Make sure this is the case by setting the maximum
DMA segment size to a more suitable value than the default 64KB.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 35 ++++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 8b18a00a58c7..c021d4c8324f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -213,6 +213,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	struct mtk_drm_private *private = drm->dev_private;
 	struct platform_device *pdev;
 	struct device_node *np;
+	struct device *dma_dev;
 	int ret;
 
 	if (!iommu_present(&platform_bus_type))
@@ -275,7 +276,29 @@ static int mtk_drm_kms_init(struct drm_device *drm)
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
+	if (!dma_dev->dma_parms) {
+		ret = -ENOMEM;
+		goto err_component_unbind;
+	}
+
+	ret = dma_set_max_seg_size(dma_dev, (unsigned int)DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(dma_dev, "Failed to set DMA segment size\n");
+		goto err_unset_dma_parms;
+	}
 
 	/*
 	 * We don't use the drm_irq_install() helpers provided by the DRM
@@ -285,13 +308,16 @@ static int mtk_drm_kms_init(struct drm_device *drm)
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
@@ -302,9 +328,14 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 
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
2.22.0.709.g102302147b-goog

