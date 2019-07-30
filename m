Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F004C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411E62064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltdGp0n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbfG3SQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:45 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33971 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388066AbfG3SQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:34 -0400
Received: by mail-pf1-f173.google.com with SMTP id b13so30263934pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LY1WwoQKlA0oziJ9kjjyUXkW+p97jOQ5086OAuAZECQ=;
        b=ltdGp0n/hOTbii9iXo9JRwLODulU135U1oqgBZgsM5F8NH7mxvHpZAbQ5aX/M21n2c
         9zcLQHPsbYmk3NEb/WB84XD/PdXySxlwRgANBgnlXQ1DOf67lmFoLJFG1UCcLeoyBBiC
         Mf1+Y5iExsn9vJOWD3DnggnyK9WPiBcUm2/04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LY1WwoQKlA0oziJ9kjjyUXkW+p97jOQ5086OAuAZECQ=;
        b=Yw6KcoL4Uzo2ibiQQN0oEAIzm5zOONbREVQNyognhA+kfNhvgiy/Nfi2omOIj40ji0
         Jy3cjDLZ/cYWeMALhU6NVejejoTSV5PBZ6H3lNf8ju8M/l1lmPcmlhfG4zSpCKA+ZSoQ
         xr7Z/URvFVa9Tggk+nabimnVhcV7Iw5e0/gAmQLpsyqhT/5gYzxQqkxp9KxTvHddFJLZ
         dg5CE3v0wMQLJjiyDMe52rmRpY4l2RGcd9FLoqsN88SHErik8Ih33a8jDDneGsIOMePe
         LF11dDn7ibox+UExB+rtM8cD5pNqrQaCdOKnlpoc0EbLsCeuHkHqbKQttARSu+3p+0LH
         UCDA==
X-Gm-Message-State: APjAAAUVBaJsQ5IiJwKU/emBIqJoM9GzQrHIpzM1F0CNfV08jmU+mp2O
        f6IQOHQSS4EPYqXu9MCTnZxxC6SWTJOwoQ==
X-Google-Smtp-Source: APXvYqzj1c9dVdUvFCpAR/vStlaxFMtTXEqTwndnMRN3UqiYF6seJokLOmyHO1pZlXVedVhtr0R0jQ==
X-Received: by 2002:aa7:843c:: with SMTP id q28mr43863220pfn.152.1564510593350;
        Tue, 30 Jul 2019 11:16:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH v6 42/57] staging: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:42 -0700
Message-Id: <20190730181557.90391-43-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/staging/emxx_udc/emxx_udc.c                          | 4 +---
 drivers/staging/goldfish/goldfish_audio.c                    | 4 +---
 drivers/staging/media/allegro-dvt/allegro-core.c             | 4 +---
 drivers/staging/media/hantro/hantro_drv.c                    | 4 +---
 drivers/staging/media/imx/imx7-media-csi.c                   | 4 +---
 drivers/staging/media/imx/imx7-mipi-csis.c                   | 4 +---
 drivers/staging/media/meson/vdec/esparser.c                  | 4 +---
 drivers/staging/media/omap4iss/iss.c                         | 1 -
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c               | 5 +----
 drivers/staging/most/dim2/dim2.c                             | 2 --
 drivers/staging/mt7621-dma/mtk-hsdma.c                       | 4 +---
 drivers/staging/nvec/nvec.c                                  | 4 +---
 drivers/staging/ralink-gdma/ralink-gdma.c                    | 4 +---
 .../vc04_services/interface/vchiq_arm/vchiq_2835_arm.c       | 4 +---
 14 files changed, 12 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 4f3c2c13a225..489cde4e915e 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -3094,10 +3094,8 @@ static int nbu2ss_drv_probe(struct platform_device *pdev)
 		return PTR_ERR(mmio_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 	status = devm_request_irq(&pdev->dev, irq, _nbu2ss_udc_irq,
 				  0, driver_name, udc);
 
diff --git a/drivers/staging/goldfish/goldfish_audio.c b/drivers/staging/goldfish/goldfish_audio.c
index 24a738238f9f..0c65a0121dde 100644
--- a/drivers/staging/goldfish/goldfish_audio.c
+++ b/drivers/staging/goldfish/goldfish_audio.c
@@ -302,10 +302,8 @@ static int goldfish_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
+	if (data->irq < 0)
 		return -ENODEV;
-	}
 	data->buffer_virt = dmam_alloc_coherent(&pdev->dev,
 						COMBINED_BUFFER_SIZE,
 						&buf_addr, GFP_KERNEL);
diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index f050c7347fd5..6f0cd0784786 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -2947,10 +2947,8 @@ static int allegro_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
+	if (irq < 0)
 		return irq;
-	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					allegro_hardirq,
 					allegro_irq_thread,
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index c3665f0e87a2..4a7afad2af92 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -733,10 +733,8 @@ static int hantro_probe(struct platform_device *pdev)
 			continue;
 
 		irq = platform_get_irq_byname(vpu->pdev, irq_name);
-		if (irq <= 0) {
-			dev_err(vpu->dev, "Could not get %s IRQ.\n", irq_name);
+		if (irq <= 0)
 			return -ENXIO;
-		}
 
 		ret = devm_request_irq(vpu->dev, irq,
 				       vpu->variant->irqs[i].handler, 0,
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 500b4c08d967..d7d38dd9f168 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1194,10 +1194,8 @@ static int imx7_csi_probe(struct platform_device *pdev)
 	}
 
 	csi->irq = platform_get_irq(pdev, 0);
-	if (csi->irq < 0) {
-		dev_err(dev, "Missing platform resources data\n");
+	if (csi->irq < 0)
 		return csi->irq;
-	}
 
 	csi->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(csi->regbase))
diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index d1cdf011c8f1..73d8354e618c 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -975,10 +975,8 @@ static int mipi_csis_probe(struct platform_device *pdev)
 		return PTR_ERR(state->regs);
 
 	state->irq = platform_get_irq(pdev, 0);
-	if (state->irq < 0) {
-		dev_err(dev, "Failed to get irq\n");
+	if (state->irq < 0)
 		return state->irq;
-	}
 
 	ret = mipi_csis_clk_get(state);
 	if (ret < 0)
diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index 3a21a8cec799..95102a4bdc62 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -301,10 +301,8 @@ int esparser_init(struct platform_device *pdev, struct amvdec_core *core)
 	int irq;
 
 	irq = platform_get_irq_byname(pdev, "esparser");
-	if (irq < 0) {
-		dev_err(dev, "Failed getting ESPARSER IRQ from dtb\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, esparser_isr, IRQF_SHARED,
 			       "esparserirq", core);
diff --git a/drivers/staging/media/omap4iss/iss.c b/drivers/staging/media/omap4iss/iss.c
index c8be1db532ab..1a966cb2f3a6 100644
--- a/drivers/staging/media/omap4iss/iss.c
+++ b/drivers/staging/media/omap4iss/iss.c
@@ -1276,7 +1276,6 @@ static int iss_probe(struct platform_device *pdev)
 	/* Interrupt */
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		dev_err(iss->dev, "No IRQ resource\n");
 		ret = -ENODEV;
 		goto error_iss;
 	}
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index c34aec7c6e40..9ce3a65903c5 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -160,11 +160,8 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 	dev->capabilities = variant->capabilities;
 
 	irq_dec = platform_get_irq(dev->pdev, 0);
-	if (irq_dec <= 0) {
-		dev_err(dev->dev, "Failed to get IRQ\n");
-
+	if (irq_dec <= 0)
 		return irq_dec;
-	}
 	ret = devm_request_irq(dev->dev, irq_dec, cedrus_irq,
 			       0, dev_name(dev->dev), dev);
 	if (ret) {
diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 31fbc1a75b06..c8bec3c34c2c 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -797,7 +797,6 @@ static int dim2_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, AHB0_INT_IDX);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get ahb0_int irq: %d\n", irq);
 		ret = irq;
 		goto err_shutdown_dim;
 	}
@@ -811,7 +810,6 @@ static int dim2_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, MLB_INT_IDX);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get mlb_int irq: %d\n", irq);
 		ret = irq;
 		goto err_shutdown_dim;
 	}
diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index 60db06768c8a..d964642d95a3 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -675,10 +675,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	tasklet_init(&hsdma->task, mtk_hsdma_tasklet, (unsigned long)hsdma);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 	ret = devm_request_irq(&pdev->dev, irq, mtk_hsdma_irq,
 			       0, dev_name(&pdev->dev), hsdma);
 	if (ret) {
diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 08027a36e0bc..1cbd7b71fc38 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -796,10 +796,8 @@ static int tegra_nvec_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	nvec->irq = platform_get_irq(pdev, 0);
-	if (nvec->irq < 0) {
-		dev_err(dev, "no irq resource?\n");
+	if (nvec->irq < 0)
 		return -ENODEV;
-	}
 
 	i2c_clk = devm_clk_get(dev, "div-clk");
 	if (IS_ERR(i2c_clk)) {
diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 5854551d0a52..900424db9b97 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -826,10 +826,8 @@ static int gdma_dma_probe(struct platform_device *pdev)
 	tasklet_init(&dma_dev->task, gdma_dma_tasklet, (unsigned long)dma_dev);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 	ret = devm_request_irq(&pdev->dev, irq, gdma_dma_irq,
 			       0, dev_name(&pdev->dev), dma_dev);
 	if (ret) {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 61c69f353cdb..8dc730cfe7a6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -141,10 +141,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 		return PTR_ERR(g_regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "failed to get IRQ\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	err = devm_request_irq(dev, irq, vchiq_doorbell_irq, IRQF_IRQPOLL,
 			       "VCHIQ doorbell", state);
-- 
Sent by a computer through tubes

