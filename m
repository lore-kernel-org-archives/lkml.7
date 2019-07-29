Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B99C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66872070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyPymr7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfG2Fd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:33:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39847 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfG2Fd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:33:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so23399361pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 22:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIe2gKl7IS9bEEUigYBrn5UMc4ulaKfTb5ZjeayByNk=;
        b=JyPymr7EMJYfUCgqnJBNuymWkG668Al0+SCUrWpz/v5wCJZIOBsjRTa3gy0SrxcoKG
         Bhek67JgDhIS5UHC12lqf6Znlw4JRqGiw7KYcuVaYymDH0Nqfykb5RHltiCt+tD/IXk3
         FuUQETUxDxxj6fYlgN3LhukDLCa6qrcA3WsHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIe2gKl7IS9bEEUigYBrn5UMc4ulaKfTb5ZjeayByNk=;
        b=Lhcp6YnKITF+SX7meQ7rKqGPTR4yZO41x8XTxBzEsN7UotPtRRdreHxqBUdK/+hltA
         IaqYMNtMRm+bWz56J69TiwjQ24zduOi8kmH9FILMyc4XLnGpMzzWjRLgfzxbsQdPNeyH
         keyMTrmA4oqc2xv3Uqt1stUNJ4es2qzaa30lCnSvEJABTh9nk29N4OOV+LT2DiN6lKSG
         E/AzSdPtA/iudhscZIWdp3hyfiMEa4ByKR5v8VISnHtTzGe09P2a6hSz/GzEFXtl2vB0
         m3QwZsvC53b6yP3BZ9lfjKpDjPP82afPgSJGSl3gE2WMIZo2CaclaPJ60TMpSFRKTjlT
         JtTA==
X-Gm-Message-State: APjAAAUJ1yi0QkldFZfriwluRQpE87fKldWlo4JodcLMvDnxXpOt1te/
        Lc8nUaPaqiTVXB5xZ6e0mXHKaA==
X-Google-Smtp-Source: APXvYqx5JaT8+LjEPcm4XYg0mKRR4psCkXVJ2pN1v1DRnW7hKdBb53kqVkzPlXZkzj4x6gfpuX+l7w==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr26224715pfn.218.1564378436289;
        Sun, 28 Jul 2019 22:33:56 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id z4sm93792810pfg.166.2019.07.28.22.33.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 22:33:55 -0700 (PDT)
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
Subject: [PATCH v2 1/2] drm/mediatek: use correct device to import PRIME buffers
Date:   Mon, 29 Jul 2019 14:33:34 +0900
Message-Id: <20190729053335.251379-2-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190729053335.251379-1-acourbot@chromium.org>
References: <20190729053335.251379-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRIME buffers should be imported using the DMA device. To this end, use
a custom import function that mimics drm_gem_prime_import_dev(), but
passes the correct device.

Fixes: 119f5173628aa ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 95fdbd0fbcac..8b18a00a58c7 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -320,6 +320,18 @@ static const struct file_operations mtk_drm_fops = {
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
@@ -331,7 +343,7 @@ static struct drm_driver mtk_drm_driver = {
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_export = drm_gem_prime_export,
-	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_import = mtk_drm_gem_prime_import,
 	.gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
 	.gem_prime_mmap = mtk_drm_gem_mmap_buf,
-- 
2.22.0.709.g102302147b-goog

