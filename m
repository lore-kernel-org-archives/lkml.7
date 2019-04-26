Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDDDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E760720679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYJw+fEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDZQmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:42:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37195 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDZQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:42:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id b12so2326180lji.4;
        Fri, 26 Apr 2019 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzP0AR+ti/bqIxQypEOph2XNCqymISMdCKVOmHoTAW0=;
        b=mYJw+fEpKwfGv3W9+yz4OQZOogyQvXG4iChudvGNTNRdh94xryShu29kHDsNZzfeVV
         Zms7PPfIpkesYBp5DxHHdhVfm8KgKK+oM/cPOH+gb+hAwSjnlE0LIhftW1fqmtVI1QYb
         OujX/HNvH96Ir4xXi4UhqmEPy5oIhXf7/v3oOtOVVda+lIRtfAyEzbVc/2r80w+yend7
         ECUgfPKvtJx35ZcnGyQZzitt6BrdtlVJI4BjtIp6FigIchdJLisJJqZQVBMoXdcwXUzV
         LJlIrwuC+q9ryu8M3pBgMlSgdLCxQ8WuFsXks0lW/9zA3uwkKp5vrvn6pG/McsjlLSxe
         fzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzP0AR+ti/bqIxQypEOph2XNCqymISMdCKVOmHoTAW0=;
        b=FuR0LSS60gMN5exeUwOZqTJcBCJOO2J7cc/Q5tKE894jpy4jFdac2mT8vsqbVrQvd8
         objRIPYyeqxPMIeiB2o7SmJ79ePoqvptVFQ3WW1E8lHeP7IsvcOtVq6HJGAwgPtDX31q
         24HuXboqi/1IIP0NIdGJBBQk9oG6GgaU1+c2RsBtPS+vQTE+MstC7N7Dbi93SjA0EQUd
         62HMTCCAOvsRIJYZYd1Wk/O3+vFAASyvJHCCHxFL1fOchphSCSxQFRzTrJrT6uTAIOOo
         HZ1K60dw4MJxS1TBkWaCSY/W6tVZIVHh7D9k5YI9dGX6hYAg00Uiys4AXESvlr0UQuls
         5TFg==
X-Gm-Message-State: APjAAAXpUfEwBJ2HKP4R15gL9QdeFzfCmdM0Evs9q8K62+CpUHnbR4hA
        ByKkeWbMXO6XO0C7PzvEKOw=
X-Google-Smtp-Source: APXvYqzs7CP5V5+FUsRKnlBS83N6ImFLqrYYzWE+m/MWQdzJUonXvYNwdAqr5NLnWOwcqxJ7X+YLDg==
X-Received: by 2002:a2e:9687:: with SMTP id q7mr2908573lji.113.1556296952878;
        Fri, 26 Apr 2019 09:42:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:2492:ad61:69f1:23cc])
        by smtp.googlemail.com with ESMTPSA id q11sm5637807lfc.51.2019.04.26.09.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:42:32 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kyungmin.park@samsung.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/5] mtd: onenand/samsung: Unify resource order for controller variants
Date:   Fri, 26 Apr 2019 18:42:20 +0200
Message-Id: <20190426164224.11327-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

Before this patch, the order of memory resources requested by the driver
was controller base as first and OneNAND chip base as second for
S3C64xx/S5PC100 variant and the opposite for S5PC110/S5PV210 variant.

To make this more consistent, this patch swaps the order of resources
for the latter and updates platform code accordingly. As a nice side
effect there is a slight reduction in line count of probe function.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/mtd/nand/onenand/samsung.c | 48 ++++++++++++++----------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/nand/onenand/samsung.c b/drivers/mtd/nand/onenand/samsung.c
index e64d0fdf7eb5..a425f19a3876 100644
--- a/drivers/mtd/nand/onenand/samsung.c
+++ b/drivers/mtd/nand/onenand/samsung.c
@@ -126,14 +126,13 @@ struct s3c_onenand {
 	struct mtd_info	*mtd;
 	struct platform_device	*pdev;
 	enum soc_type	type;
-	void __iomem	*base;
-	void __iomem	*ahb_addr;
+	void __iomem	*ctrl_base;
+	void __iomem	*chip_base;
 	int		bootram_command;
 	void		*page_buf;
 	void		*oob_buf;
 	unsigned int	(*mem_addr)(int fba, int fpa, int fsa);
 	unsigned int	(*cmd_map)(unsigned int type, unsigned int val);
-	void __iomem	*dma_addr;
 	unsigned long	phys_base;
 	struct completion	complete;
 };
@@ -147,22 +146,22 @@ static struct s3c_onenand *onenand;
 
 static inline int s3c_read_reg(int offset)
 {
-	return readl(onenand->base + offset);
+	return readl(onenand->ctrl_base + offset);
 }
 
 static inline void s3c_write_reg(int value, int offset)
 {
-	writel(value, onenand->base + offset);
+	writel(value, onenand->ctrl_base + offset);
 }
 
 static inline int s3c_read_cmd(unsigned int cmd)
 {
-	return readl(onenand->ahb_addr + cmd);
+	return readl(onenand->chip_base + cmd);
 }
 
 static inline void s3c_write_cmd(int value, unsigned int cmd)
 {
-	writel(value, onenand->ahb_addr + cmd);
+	writel(value, onenand->chip_base + cmd);
 }
 
 #ifdef SAMSUNG_DEBUG
@@ -519,7 +518,7 @@ static int (*s5pc110_dma_ops)(dma_addr_t dst, dma_addr_t src, size_t count, int
 
 static int s5pc110_dma_poll(dma_addr_t dst, dma_addr_t src, size_t count, int direction)
 {
-	void __iomem *base = onenand->dma_addr;
+	void __iomem *base = onenand->ctrl_base;
 	int status;
 	unsigned long timeout;
 
@@ -563,7 +562,7 @@ static int s5pc110_dma_poll(dma_addr_t dst, dma_addr_t src, size_t count, int di
 
 static irqreturn_t s5pc110_onenand_irq(int irq, void *data)
 {
-	void __iomem *base = onenand->dma_addr;
+	void __iomem *base = onenand->ctrl_base;
 	int status, cmd = 0;
 
 	status = readl(base + S5PC110_INTC_DMA_STATUS);
@@ -585,7 +584,7 @@ static irqreturn_t s5pc110_onenand_irq(int irq, void *data)
 
 static int s5pc110_dma_irq(dma_addr_t dst, dma_addr_t src, size_t count, int direction)
 {
-	void __iomem *base = onenand->dma_addr;
+	void __iomem *base = onenand->ctrl_base;
 	int status;
 
 	status = readl(base + S5PC110_INTC_DMA_MASK);
@@ -634,7 +633,7 @@ static int s5pc110_read_bufferram(struct mtd_info *mtd, int area,
 	}
 
 	if (offset & 3 || (size_t) buf & 3 ||
-		!onenand->dma_addr || count != mtd->writesize)
+		!onenand->ctrl_base || count != mtd->writesize)
 		goto normal;
 
 	/* Handle vmalloc address */
@@ -864,23 +863,22 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 	s3c_onenand_setup(mtd);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	onenand->base = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(onenand->base))
-		return PTR_ERR(onenand->base);
-
+	onenand->ctrl_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(onenand->ctrl_base))
+		return PTR_ERR(onenand->ctrl_base);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	onenand->chip_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(onenand->chip_base))
+		return PTR_ERR(onenand->chip_base);
 	onenand->phys_base = r->start;
 
-	/* Set onenand_chip also */
-	this->base = onenand->base;
-
 	/* Use runtime badblock check */
 	this->options |= ONENAND_SKIP_UNLOCK_CHECK;
 
 	if (onenand->type != TYPE_S5PC110) {
-		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		onenand->ahb_addr = devm_ioremap_resource(&pdev->dev, r);
-		if (IS_ERR(onenand->ahb_addr))
-			return PTR_ERR(onenand->ahb_addr);
+		/* Set onenand_chip also */
+		this->base = onenand->ctrl_base;
 
 		/* Allocate 4KiB BufferRAM */
 		onenand->page_buf = devm_kzalloc(&pdev->dev, SZ_4K,
@@ -898,10 +896,8 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 		this->subpagesize = mtd->writesize;
 
 	} else { /* S5PC110 */
-		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		onenand->dma_addr = devm_ioremap_resource(&pdev->dev, r);
-		if (IS_ERR(onenand->dma_addr))
-			return PTR_ERR(onenand->dma_addr);
+		/* Set onenand_chip also */
+		this->base = onenand->chip_base;
 
 		s5pc110_dma_ops = s5pc110_dma_poll;
 		/* Interrupt support */
-- 
2.20.1

