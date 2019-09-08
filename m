Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30943C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D482067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947527;
	bh=ERRG1WAcuwqcV2Fq65t+WAXGXS4wFs2DDWfRyDNA7a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gRgSDtpsYvDe+PpPn6NeF0QHS10lpaRpcqiqiSp1JkT2wOzA4+GN4B5I8SQaVU4Cm
	 1lqe1U6l+NA4rrk97nkeuNXaY6YVP7nhcf/j/fPcY+R5ub8BdieiKGkqGrk+rMzDLY
	 GkAwFt91Qvq3HInWlvqnpRi0FpcXzcgCX7Wd57J8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfIHMqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbfIHMql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:46:41 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E29D20644;
        Sun,  8 Sep 2019 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946800;
        bh=ERRG1WAcuwqcV2Fq65t+WAXGXS4wFs2DDWfRyDNA7a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmGrhzCAP2t99K9s7Zclpta2Qp8CjkHrtGSR4QBPXJwLgaNnK70GVLQL8Kisozd6x
         4ZGc/hyVJpucs1bzDVyHG3fIRkxCbPgDUjz9CSCTN7M1WYWQWKQYtuH6Q3adVOa8Xy
         2bqLdGzYXoXGF85WgUlLg2id24ls6Myb+5HpCav8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 09/40] drm/mediatek: set DMA max segment size
Date:   Sun,  8 Sep 2019 13:41:42 +0100
Message-Id: <20190908121118.317307114@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121114.260662089@linuxfoundation.org>
References: <20190908121114.260662089@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 070955558e820b9a89c570b91b1f21762f62b288 ]

This driver requires imported PRIME buffers to appear contiguously in
its IO address space. Make sure this is the case by setting the maximum
DMA segment size to a more suitable value than the default 64KB.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 35 ++++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 4a89cd2e4f1c5..034b50080304f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -185,6 +185,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	struct mtk_drm_private *private = drm->dev_private;
 	struct platform_device *pdev;
 	struct device_node *np;
+	struct device *dma_dev;
 	int ret;
 
 	if (!iommu_present(&platform_bus_type))
@@ -242,7 +243,29 @@ static int mtk_drm_kms_init(struct drm_device *drm)
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
@@ -252,13 +275,16 @@ static int mtk_drm_kms_init(struct drm_device *drm)
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
@@ -269,9 +295,14 @@ err_config_cleanup:
 
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
index c3378c452c0a0..445dd45e65ebc 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -56,6 +56,8 @@ struct mtk_drm_private {
 	} commit;
 
 	struct drm_atomic_state *suspend_state;
+
+	bool dma_parms_allocated;
 };
 
 extern struct platform_driver mtk_ddp_driver;
-- 
2.20.1



