Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5FBC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200A32173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4LY1AVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfKFOIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:08:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36006 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfKFOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:08:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so5904098pgh.3;
        Wed, 06 Nov 2019 06:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGrpDRKjGtiRT6QlcUQ2diK8Wp4T7B3HNEKu57gaI70=;
        b=M4LY1AVpLRKaQ2PYpl4ihvdNmjYEbPsEsgJGBp5awZvOHExCB4h9/vK/P1ajy7wo4R
         eCznYQKQmR0sxuEQhx2oXaGnZRS0+eVNZY2kX4ZjBV+ps4U7af3uQx7sDze9vlQLznir
         0+HGyIcrR0PoJ69qYWqFpl7aLdHYCXI3x25DrYnY6IKnvJ8a3f1uICEEInJ1jqriXyOi
         AAPSaDfApqTsa50NTGrK4sl1f6wa1GLuun1S1qnjDGiOinOxUozoZUHhc192xjATsI1Z
         nG4xZajoba2Bx/4KevwV9PXpoOylk3TpskZAbiV/uma4ZsBPl4rEF50ZQ44nc2Od9vxI
         bmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGrpDRKjGtiRT6QlcUQ2diK8Wp4T7B3HNEKu57gaI70=;
        b=RQWpBBCjDw4ovNi0WCHAr6zD3iSp1fLPNv9Rj1y+8yZHSUymPiw8jOXnDM/8MLKan9
         085P2dRq6ck8Vb5mJDPiw41Nr6BKCC0heZB3AQhSP0BT4sSpFcKUwdmDCx1fAMNmCXZT
         bE+Bg1Y3ZInY7PVhF50FZ6FcdwzOsDqCYz9R6MvgbPtAHvHCp79IGAR4EH+IdSbO5qrB
         oksxUHyVIggYPQHcntFvlbeyRowI0H1MR4IF6sAlS1snQsBeSytAoX/LipyFMKu+C3Ot
         Qir9AUII3/ENMayj5bNfsM/912AfVAG/W1RNHv2Ra3+ek9bKPYdG2VpxAssgGGVPrYmY
         XmBA==
X-Gm-Message-State: APjAAAVrbrPUkA3OY8w6YJ6O4+Sjc/BnZxDvtmGQ5/5Dy7ctcdlDMW7k
        5UieQLSp5U0elN1NSHz42Pk=
X-Google-Smtp-Source: APXvYqyciAa1ghxUmSQPYlowrrMDo0Qpjz7jY0Ac/lNoa/xPayE7Fj+LDRfNpWCrFpdZ8Nu12OBZsg==
X-Received: by 2002:a65:5885:: with SMTP id d5mr3017512pgu.278.1573049326032;
        Wed, 06 Nov 2019 06:08:46 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id a16sm4707345pfc.56.2019.11.06.06.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:08:43 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 1/2] mtd: mtk-quadspi: add support for memory-mapped flash reading
Date:   Wed,  6 Nov 2019 22:07:47 +0800
Message-Id: <20191106140748.13100-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106140748.13100-1-gch981213@gmail.com>
References: <20191106140748.13100-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PIO reading mode on this controller is ridiculously inefficient
(one cmd+addr+dummy sequence reads only one byte)
This patch adds support for reading from memory-mapped flash area
which increases reading speed from 1MB/s to 5.6MB/s

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/spi-nor/mtk-quadspi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index 34db01ab6cab..ba8b3be39896 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -106,6 +106,7 @@ struct mtk_nor {
 	struct spi_nor nor;
 	struct device *dev;
 	void __iomem *base;	/* nor flash base address */
+	void __iomem *flash_base;
 	struct clk *spi_clk;
 	struct clk *nor_clk;
 };
@@ -272,6 +273,11 @@ static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
 	mtk_nor_set_read_mode(mtk_nor);
 	mtk_nor_set_addr(mtk_nor, addr);
 
+	if (mtk_nor->flash_base) {
+		memcpy_fromio(buffer, mtk_nor->flash_base + from, length);
+		return length;
+	}
+
 	for (i = 0; i < length; i++) {
 		ret = mtk_nor_execute_cmd(mtk_nor, MTK_NOR_PIO_READ_CMD);
 		if (ret < 0)
@@ -475,6 +481,11 @@ static int mtk_nor_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(mtk_nor->base))
 		return PTR_ERR(mtk_nor->base);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	mtk_nor->flash_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mtk_nor->flash_base))
+		mtk_nor->flash_base = NULL;
+
 	mtk_nor->spi_clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(mtk_nor->spi_clk))
 		return PTR_ERR(mtk_nor->spi_clk);
-- 
2.21.0

