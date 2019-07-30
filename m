Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D5BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1685220C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GMsUVWRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfG3STS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:19:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35901 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbfG3SQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so30474318pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5RXXsJ4e7VkeUHqrbY1IBvBfJ/z9E69a8edPnsDJdQ=;
        b=GMsUVWRU1aTB1hWSiYZ1yAHVCz3KA2ZakCDiEbHmhhMz9lBM+S7FVB4L5n5H6H5b7I
         a+V6A1cm8rKTkEVe9O10c9KE01cFXuO2I7/xyU9a+3JPf7Ypvy+wJIzcwPaX5a1UeMtN
         YRxWZCQShkBcbMB3nfX0+dBg/+B4Nb/ZW5yMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5RXXsJ4e7VkeUHqrbY1IBvBfJ/z9E69a8edPnsDJdQ=;
        b=sp7LQXbQBiMA+uzVVzC7hmdXlqc9FXAdxezFqzb6/nrMdnQnk2+9/TfjxfZjLUtAkZ
         Nfb/VEojoEbSeoL+AfO94MJGdyM5Fwh/1icZl0upMrMKjwc7RL1XzpIiF/fTHnpAicXB
         Kp31v3O3IF5fCQ7wKPY3xr7+uozXTKC3tSWcuhr+SyNnsn9F87qS8D2ysJLd2e1gk3/N
         4cZ4AJ8i5Ms5nVUTdReu9ezOD8RW1WKViIEwI4quN9JA8yynDtQgDJG/FbF6fHmTHoJK
         LsWwul2KQdn5siEXxrsyAXeZ9hTQ9QXoKofyWjJyL8JgluV4e9uUfY6pTd/TZd1HzQ6B
         sDKw==
X-Gm-Message-State: APjAAAXTZRwU2WmgS5omhhpiQfjubGXCDjH6vlHrl7wJTA/KT1QaCwXA
        i2xZFl/I2MWbm/3pwh8Z6g5EWFElwemaNw==
X-Google-Smtp-Source: APXvYqzdmoE2JLem/gbX1r3OvXzJEHBzGCQNGOjvOY6r5ot2LQEojL9LCQ0tBaIgf+wJXvZLyLIL+A==
X-Received: by 2002:a65:4304:: with SMTP id j4mr112698627pgq.419.1564510583820;
        Tue, 30 Jul 2019 11:16:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 30/57] mtd: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:30 -0700
Message-Id: <20190730181557.90391-31-swboyd@chromium.org>
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

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/mtd/devices/spear_smi.c        | 1 -
 drivers/mtd/nand/raw/denali_dt.c       | 4 +---
 drivers/mtd/nand/raw/hisi504_nand.c    | 4 +---
 drivers/mtd/nand/raw/lpc32xx_mlc.c     | 1 -
 drivers/mtd/nand/raw/marvell_nand.c    | 4 +---
 drivers/mtd/nand/raw/meson_nand.c      | 4 +---
 drivers/mtd/nand/raw/mtk_ecc.c         | 4 +---
 drivers/mtd/nand/raw/mtk_nand.c        | 1 -
 drivers/mtd/nand/raw/omap2.c           | 8 ++------
 drivers/mtd/nand/raw/sh_flctl.c        | 4 +---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 5 +----
 drivers/mtd/nand/raw/sunxi_nand.c      | 4 +---
 drivers/mtd/spi-nor/cadence-quadspi.c  | 4 +---
 13 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index 986f81d2f93e..7f6f6f1d965f 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -933,7 +933,6 @@ static int spear_smi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENODEV;
-		dev_err(&pdev->dev, "invalid smi irq\n");
 		goto err;
 	}
 
diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 5e14836f6bd5..df992554a66f 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -167,10 +167,8 @@ static int denali_dt_probe(struct platform_device *pdev)
 
 	denali->dev = dev;
 	denali->irq = platform_get_irq(pdev, 0);
-	if (denali->irq < 0) {
-		dev_err(dev, "no irq defined\n");
+	if (denali->irq < 0)
 		return denali->irq;
-	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "denali_reg");
 	denali->reg = devm_ioremap_resource(dev, res);
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 6a4626a8bf95..0b48be54ba6f 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -751,10 +751,8 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	mtd  = nand_to_mtd(chip);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->iobase = devm_ioremap_resource(dev, res);
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 78b31f845c50..241b58b83240 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -773,7 +773,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		dev_err(&pdev->dev, "failed to get platform irq\n");
 		res = -EINVAL;
 		goto release_dma_chan;
 	}
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index fc49e13d81ec..fb5abdcfb007 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2862,10 +2862,8 @@ static int marvell_nfc_probe(struct platform_device *pdev)
 		return PTR_ERR(nfc->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	nfc->core_clk = devm_clk_get(&pdev->dev, "core");
 
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ea57ddcec41e..84b82d823952 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1398,10 +1398,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no NFC IRQ resource\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	ret = meson_nfc_clk_init(nfc);
 	if (ret) {
diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index 74595b644b7c..75f1fa3d4d35 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -527,10 +527,8 @@ static int mtk_ecc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
 	if (ret) {
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 373d47d1ba4c..b8305e39ab51 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1540,7 +1540,6 @@ static int mtk_nfc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no nfi irq resource\n");
 		ret = -EINVAL;
 		goto clk_disable;
 	}
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 8d881a28140e..dccc927c5fa5 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1967,10 +1967,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 
 	case NAND_OMAP_PREFETCH_IRQ:
 		info->gpmc_irq_fifo = platform_get_irq(info->pdev, 0);
-		if (info->gpmc_irq_fifo <= 0) {
-			dev_err(dev, "Error getting fifo IRQ\n");
+		if (info->gpmc_irq_fifo <= 0)
 			return -ENODEV;
-		}
 		err = devm_request_irq(dev, info->gpmc_irq_fifo,
 				       omap_nand_irq, IRQF_SHARED,
 				       "gpmc-nand-fifo", info);
@@ -1982,10 +1980,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 		}
 
 		info->gpmc_irq_count = platform_get_irq(info->pdev, 1);
-		if (info->gpmc_irq_count <= 0) {
-			dev_err(dev, "Error getting IRQ count\n");
+		if (info->gpmc_irq_count <= 0)
 			return -ENODEV;
-		}
 		err = devm_request_irq(dev, info->gpmc_irq_count,
 				       omap_nand_irq, IRQF_SHARED,
 				       "gpmc-nand-count", info);
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index e509c93737c4..058e99d0cbcf 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1129,10 +1129,8 @@ static int flctl_probe(struct platform_device *pdev)
 	flctl->fifo = res->start + 0x24; /* FLDTFIFO */
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get flste irq data: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, flctl_handle_flste, IRQF_SHARED,
 			       "flste", flctl);
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index e63acc077c18..1cc70fe2a4d7 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1912,11 +1912,8 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "IRQ error missing or invalid\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, stm32_fmc2_irq, 0,
 			       dev_name(dev), fmc2);
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 89773293c64d..37a4ac0dd85b 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2071,10 +2071,8 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 		return PTR_ERR(nfc->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	nfc->ahb_clk = devm_clk_get(dev, "ahb");
 	if (IS_ERR(nfc->ahb_clk)) {
diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 67f15a1f16fd..172d7a0a2454 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -1375,10 +1375,8 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	/* Obtain IRQ line. */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Cannot obtain IRQ.\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
-- 
Sent by a computer through tubes

