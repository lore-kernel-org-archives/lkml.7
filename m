Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780F620C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e3InH3qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfG3SRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:17:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47075 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388114AbfG3SQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id k189so11433094pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62cGNpcNTfIudaOsi484Y4vAnYPY9SLDjap4W+ygVE8=;
        b=e3InH3qPJ5lVS3oAY57NRZtNCWSMhbc3ROa0vMNIsr/RejItZOTX4KjPd2Vm4Flg+h
         o6JtRiOEfdM6cC4iY2wc3iL3hRTELEBgxJGBsyhHfs3xDDhdUFp5t89kCPkRdY52f6ou
         7FejB+foRlrYoWuv/wMSKzLckIkUuU+P9zlE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62cGNpcNTfIudaOsi484Y4vAnYPY9SLDjap4W+ygVE8=;
        b=als+QflLp0n74XAVGNdNfUc8l3flqKh61A78FDLi2X8NHhDAyaxckdNgFzm8IVF7L2
         p8quIMqrbxhqw2U4LdjR6Gp7QplRadWcWwxmmqs/FYnabOWhuxoFu0WlPZM6x3fWjogJ
         OW1JUk18VorkZVzqXcqLtWbwi2vkl2hIGzP10F2V432Kp0tXx9oxf+fLuihZ6f98EP5A
         nhDK4CdML6kl9Q5uDQ64Ax5DFBXyE+sGxAMhfaGVXtDAvbihintFKGKAYD+oVHpFM9US
         2QP4uztQPUT8OCsCI5MX8PWXuS3DUbngvXIXlPcYxoUhG7xf/kdEqBKdllG0W/u+ZepN
         PPSw==
X-Gm-Message-State: APjAAAWyoAnUtSYRNxB6/HxSXyxV3hHcUWVf6Lmu+m3q3OVOPBtEdfka
        mLB3F9FT+VcWGDxtrALYcMa/ld4xEbOizg==
X-Google-Smtp-Source: APXvYqzeONTD1GNgyS3GA7f/9wZaQyLmfudF7hlxjKe0wODekESHm/1o6q/rFMOhAbLXJjMp+GBCvQ==
X-Received: by 2002:a62:6344:: with SMTP id x65mr45002659pfb.111.1564510600334;
        Tue, 30 Jul 2019 11:16:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:39 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 50/57] gpu: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:50 -0700
Message-Id: <20190730181557.90391-51-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c       | 4 +---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c     | 4 +---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c     | 1 -
 drivers/gpu/drm/exynos/exynos_drm_rotator.c | 4 +---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c  | 4 +---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c   | 4 +---
 drivers/gpu/drm/imx/imx-tve.c               | 4 +---
 drivers/gpu/drm/ingenic/ingenic-drm.c       | 4 +---
 drivers/gpu/drm/mediatek/mtk_cec.c          | 4 +---
 drivers/gpu/drm/mediatek/mtk_dpi.c          | 4 +---
 drivers/gpu/drm/mediatek/mtk_dsi.c          | 4 +---
 drivers/gpu/drm/meson/meson_dw_hdmi.c       | 4 +---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c    | 4 +---
 drivers/gpu/drm/sun4i/sun4i_tcon.c          | 4 +---
 drivers/gpu/drm/tegra/dc.c                  | 4 +---
 drivers/gpu/drm/tegra/dpaux.c               | 4 +---
 drivers/gpu/drm/tegra/sor.c                 | 4 +---
 drivers/gpu/host1x/dev.c                    | 4 +---
 18 files changed, 17 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 5418a1a87b2c..373077549aa4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1733,10 +1733,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 
 	/* Get Interrupt: */
 	gpu->irq = platform_get_irq(pdev, 0);
-	if (gpu->irq < 0) {
-		dev_err(dev, "failed to get irq: %d\n", gpu->irq);
+	if (gpu->irq < 0)
 		return gpu->irq;
-	}
 
 	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
 			       dev_name(gpu->dev), gpu);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 6926cee91b36..6b679c59c84d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1789,10 +1789,8 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	}
 
 	dsi->irq = platform_get_irq(pdev, 0);
-	if (dsi->irq < 0) {
-		dev_err(dev, "failed to request dsi irq resource\n");
+	if (dsi->irq < 0)
 		return dsi->irq;
-	}
 
 	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, dsi->irq, NULL,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 50904eee96f7..371419d3e8a6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1497,7 +1497,6 @@ static int g2d_probe(struct platform_device *pdev)
 
 	g2d->irq = platform_get_irq(pdev, 0);
 	if (g2d->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		ret = g2d->irq;
 		goto err_put_clk;
 	}
diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index 8ebad2740ad5..a355f444210a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -290,10 +290,8 @@ static int rotator_probe(struct platform_device *pdev)
 		return PTR_ERR(rot->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, rotator_irq_handler, 0, dev_name(dev),
 			       rot);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 9af096479e1c..cef771d5956c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -499,10 +499,8 @@ static int scaler_probe(struct platform_device *pdev)
 		return PTR_ERR(scaler->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,	scaler_irq_handler,
 					IRQF_ONESHOT, "drm_scaler", scaler);
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index e81daaaa5965..f56e9c44e8c9 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -269,10 +269,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	}
 
 	fsl_dev->irq = platform_get_irq(pdev, 0);
-	if (fsl_dev->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (fsl_dev->irq < 0)
 		return fsl_dev->irq;
-	}
 
 	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
 			&fsl_dcu_regmap_config);
diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index e725af8a0025..8b768e0cf167 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -594,10 +594,8 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					imx_tve_irq_handler, IRQF_ONESHOT,
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index e9f9e9fb9b17..faf8ac8ca1ef 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -630,10 +630,8 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get platform irq");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (soc_info->needs_dev_clk) {
 		priv->lcd_clk = devm_clk_get(dev, "lcd");
diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index cb29b649fcdb..332a4dfbdde7 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -208,10 +208,8 @@ static int mtk_cec_probe(struct platform_device *pdev)
 	}
 
 	cec->irq = platform_get_irq(pdev, 0);
-	if (cec->irq < 0) {
-		dev_err(dev, "Failed to get cec irq: %d\n", cec->irq);
+	if (cec->irq < 0)
 		return cec->irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, cec->irq, NULL,
 					mtk_cec_htplg_isr_thread,
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index bacd989cc9aa..87b848ca5f6c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -717,10 +717,8 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	}
 
 	dpi->irq = platform_get_irq(pdev, 0);
-	if (dpi->irq <= 0) {
-		dev_err(dev, "Failed to get irq: %d\n", dpi->irq);
+	if (dpi->irq <= 0)
 		return -EINVAL;
-	}
 
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
 					  NULL, &dpi->bridge);
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b91c4616644a..7a3aad0dc8a3 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1155,10 +1155,8 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	}
 
 	irq_num = platform_get_irq(pdev, 0);
-	if (irq_num < 0) {
-		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
+	if (irq_num < 0)
 		return -EPROBE_DEFER;
-	}
 
 	irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
 	ret = devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index df3f9ddd2234..e1099dab45b4 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -894,10 +894,8 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 		return PTR_ERR(dw_plat_data->regm);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get hdmi top irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_top_irq,
 					dw_hdmi_top_thread_irq, IRQF_SHARED,
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 252f5ebb1acc..9feabccd34d6 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -822,10 +822,8 @@ static int omap_dmm_probe(struct platform_device *dev)
 	}
 
 	omap_dmm->irq = platform_get_irq(dev, 0);
-	if (omap_dmm->irq < 0) {
-		dev_err(&dev->dev, "failed to get IRQ resource\n");
+	if (omap_dmm->irq < 0)
 		goto fail;
-	}
 
 	omap_dmm->dev = &dev->dev;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 64c43ee6bd92..7c4cb3f5d444 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -783,10 +783,8 @@ static int sun4i_tcon_init_irq(struct device *dev,
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Couldn't retrieve the TCON interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, sun4i_tcon_handler, 0,
 			       dev_name(dev), tcon);
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 4a75d149e368..e00bee26d29b 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2469,10 +2469,8 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		return PTR_ERR(dc->regs);
 
 	dc->irq = platform_get_irq(pdev, 0);
-	if (dc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (dc->irq < 0)
 		return -ENXIO;
-	}
 
 	err = tegra_dc_rgb_probe(dc);
 	if (err < 0 && err != -ENODEV) {
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 2d94da225e51..edf5cfa9fb74 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -446,10 +446,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 		return PTR_ERR(dpaux->regs);
 
 	dpaux->irq = platform_get_irq(pdev, 0);
-	if (dpaux->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (dpaux->irq < 0)
 		return -ENXIO;
-	}
 
 	if (!pdev->dev.pm_domain) {
 		dpaux->rst = devm_reset_control_get(&pdev->dev, "dpaux");
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 4ffe3794e6d3..651400485384 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3323,10 +3323,8 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	}
 
 	err = platform_get_irq(pdev, 0);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+	if (err < 0)
 		goto remove;
-	}
 
 	sor->irq = err;
 
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 5a3f797240d4..1fa55dc1a109 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -214,10 +214,8 @@ static int host1x_probe(struct platform_device *pdev)
 	}
 
 	syncpt_irq = platform_get_irq(pdev, 0);
-	if (syncpt_irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", syncpt_irq);
+	if (syncpt_irq < 0)
 		return syncpt_irq;
-	}
 
 	mutex_init(&host->devices_lock);
 	INIT_LIST_HEAD(&host->devices);
-- 
Sent by a computer through tubes

