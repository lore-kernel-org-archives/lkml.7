Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2E9C17442
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 05:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EB521924
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 05:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrI0mXi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKJFVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 00:21:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39613 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfKJFVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 00:21:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so7909460pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 21:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ITuc3/EbXNp+U9B5Okc4zxW+jSvy8I6mUAG/x+04NA=;
        b=QrI0mXi/pUYaShNhrdkwb/zDqfns0lptxfNNJ2ClmqLWNmb3NK+udb3X4OiBZWARIT
         BgudGtWl4Le6Eq36QZ/852P4+8Sl/fp3BQGYUrl7ZfMfTPXgDX+cs0JLw7+WJg+AZpIr
         2YKY+grJxf73XYofMvypHJT/tOI37BN/PupM56IbZ23ISPuTtwgn1NGysCpOHJXLFRjD
         9A6oKuySSnrhy094rQP/v/E47xRWEoZmut2fAlCYecspBbONQ3gYoeX1euAOVXgVsYRd
         fNr+CpR4xcnp7Zkm+p05c3xtTMuf4hnh82TNmhePrRPpPoAlLW7iUaxLpfAC8zmsAUMO
         IsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ITuc3/EbXNp+U9B5Okc4zxW+jSvy8I6mUAG/x+04NA=;
        b=bhZZAQtnGxjWMxdDIJmnwh1OQE4F3pN/gFoILbK2L4jSnMsysV5iBWlfCcf4kku+XS
         z7LrYGl2Quo1WtjcMCa5bEPBNksmxQ6nsMiB5dp4ZW/Wx+Yx+Gd/TIUXyg+7noNQbQf2
         eb8N+CNK4EmRWi/eyDqTdxzzJUYtYsFOcCqLoREhJGorw5cIK9dqyE9nOzfddcBauC5h
         VBTNuHE7AA71ZH6XO/nBYrjL/aTxsNh0ELFdKSAjTZyrFmKkqDzRKZw/ZGrcbK85fN2L
         cZadUzSe7Y/WGyy6wcfrzpmWc/TQ73jY31TfaPICh+4bidEcsHamL3Lh08q6LGfDhWLl
         8f+Q==
X-Gm-Message-State: APjAAAUNFZ43aFf4V2+K0q6MS+XXY2S5B4yVMd6EgQVsigJ3Ot+xUM0t
        YnHGfj52NNUBuzzlLLHdj9s=
X-Google-Smtp-Source: APXvYqz38qmGlTu6irHIzXwq6E1qIqAZdTkRlEXf5i+owvXl66qNobg3mB7Q/Hg+mtvZ8+5CBJaPkA==
X-Received: by 2002:a63:e249:: with SMTP id y9mr21232293pgj.383.1573363296186;
        Sat, 09 Nov 2019 21:21:36 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id y2sm10728754pfe.126.2019.11.09.21.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 21:21:35 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: mtk-quadspi: misuse 1_1_2 read mode for custom read opcode
Date:   Sun, 10 Nov 2019 13:21:01 +0800
Message-Id: <20191110052104.5502-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191110052104.5502-1-gch981213@gmail.com>
References: <20191110052104.5502-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1_1_1 reading mode on this controller only support 0x03 and 0x0b
as opcode, but spi-nor framework uses nor->read for SFDP reading
as well.
Add a check for opcode and if it's not supported, misuse 1_1_2
reading and extract corresponding bits from returned data.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/spi-nor/mtk-quadspi.c | 78 ++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index ac0e531ce80c..46bf27c0e6e8 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -357,8 +357,8 @@ static ssize_t mtk_nor_read_dma_bounce(struct mtk_nor *mtk_nor, loff_t from,
 	return length;
 }
 
-static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
-			    u_char *buffer)
+static ssize_t mtk_nor_flash_read(struct spi_nor *nor, loff_t from,
+				  size_t length, u_char *buffer)
 {
 	struct mtk_nor *mtk_nor = nor->priv;
 
@@ -372,6 +372,80 @@ static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
 	return mtk_nor_read_dma(mtk_nor, from, length, buffer);
 }
 
+static ssize_t mtk_nor_generic_read(struct spi_nor *nor, loff_t from,
+				    size_t length, u_char *buffer)
+{
+	struct mtk_nor *mtk_nor = nor->priv;
+	ssize_t nor_unaligned_len = from % MTK_NOR_DMA_ALIGN;
+	loff_t read_from = from & ~(MTK_NOR_DMA_ALIGN - 1);
+	ssize_t read_len;
+	u_char *buf, *bouncebuf, tmp;
+	size_t mem_unaligned_len, i;
+	dma_addr_t dma_addr;
+	int ret;
+
+	if (length > MTK_NOR_MAX_BBUF_READ / 2)
+		length = MTK_NOR_MAX_BBUF_READ / 2;
+	read_len = ((length + nor_unaligned_len) * 2 + MTK_NOR_DMA_ALIGN) &
+		   ~(MTK_NOR_DMA_ALIGN - 1);
+
+	buf = kmalloc(read_len + MTK_NOR_DMA_ALIGN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mem_unaligned_len = (u32)buf % MTK_NOR_DMA_ALIGN;
+	bouncebuf = (buf + MTK_NOR_DMA_ALIGN) - mem_unaligned_len;
+
+	writeb(nor->read_opcode, mtk_nor->base + MTK_NOR_PRGDATA3_REG);
+	writeb(MTK_NOR_DUAL_READ_EN, mtk_nor->base + MTK_NOR_DUAL_REG);
+	mtk_nor_set_addr_width(mtk_nor);
+
+	dma_addr = dma_map_single(mtk_nor->dev, bouncebuf, read_len,
+				  DMA_FROM_DEVICE);
+	ret = dma_mapping_error(mtk_nor->dev, dma_addr);
+	if (ret) {
+		dev_err(mtk_nor->dev, "failed to map dma buffer.");
+		goto err;
+	}
+
+	writel(read_from, mtk_nor->base + MTK_NOR_FDMA_FADR_REG);
+	writel(dma_addr, mtk_nor->base + MTK_NOR_FDMA_DADR_REG);
+	writel((u32)dma_addr + read_len,
+	       mtk_nor->base + MTK_NOR_FDMA_END_DADR_REG);
+	ret = mtk_nor_dma_exec(mtk_nor);
+	dma_unmap_single(mtk_nor->dev, dma_addr, read_len, DMA_FROM_DEVICE);
+
+	if (ret)
+		goto err;
+
+	/* extract bits from DO line */
+	for (i = 0; i < length; i++) {
+		tmp = bouncebuf[(i + nor_unaligned_len) * 2];
+		buffer[i] = (tmp & BIT(7)) | ((tmp & BIT(5)) << 1) |
+			    ((tmp & BIT(3)) << 2) | ((tmp & BIT(1)) << 3);
+		tmp = bouncebuf[(i + nor_unaligned_len) * 2 + 1];
+		buffer[i] |= (tmp & BIT(7)) >> 4 | ((tmp & BIT(5)) >> 3) |
+			     ((tmp & BIT(3)) >> 2) | ((tmp & BIT(1)) >> 1);
+	}
+	ret = length;
+err:
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
+			    u_char *buffer)
+{
+	if ((nor->read_proto != SNOR_PROTO_1_1_1) ||
+	    (nor->read_opcode == SPINOR_OP_READ) ||
+	    (nor->read_opcode == SPINOR_OP_READ_FAST))
+		return mtk_nor_flash_read(nor, from, length, buffer);
+	else if (nor->read_dummy == 8)
+		return mtk_nor_generic_read(nor, from, length, buffer);
+	else
+		return -EOPNOTSUPP;
+}
+
 static int mtk_nor_write_single_byte(struct mtk_nor *mtk_nor,
 				     int addr, int length, u8 *data)
 {
-- 
2.21.0

