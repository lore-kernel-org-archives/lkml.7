Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81288C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1592084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K8z/d+aH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDKWBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:01:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52000 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDKWBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:01:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so8632808wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppI9nqpQVIT5EX87CEcKbfdI9W3paDlwzbHWj7vYXTg=;
        b=K8z/d+aH5mjiptQEK6iIvRF5y6r0lfHtJ2mmS1otxJlDG8x6bxBz44Ahm4f4XQfs1+
         cOqQ4+ESVP8nM6T7Wl724gJlOdaAjcOPaOmwPKL89bDgFvb/fka7ZPYKIgOZZe5vhABe
         ViA/k5YhxEIxOn0Zvwm88Sd2YC95kEMpRw5yOcTuDYt7zWsmMbIv/Q6pCXyUOo1OD61d
         XGyoSMgiOeNdP5ETplauulOv5IZIIWKVHWKVMABjThJHeukWIgDihy/TgBGDF8frgK2G
         U7p2RlmMPOerGXwlzEOai+8xI/JbK3EraMbgpSliTd4337GMu36XDqj2Rpk6WlctInq0
         zR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppI9nqpQVIT5EX87CEcKbfdI9W3paDlwzbHWj7vYXTg=;
        b=rTu6e9rfYmGbqFDQcDC1xXLOzwPwUSoq1VbCWqUaSJLfkEQPyF6vOKB+Ae0XMGtVc+
         Uh5ggHRdi5g3Sls4vOYPrfFFtvcbVqjCnNEDSRivVu8rovASByTXt0u7yWbog/wHI29h
         Pujp0HIjL162N6DqEPeDPqdumZ3LfxNJSjKEx5HJyKOlGfmN8x6V/zEgGr9f1XD92i+R
         I/zrpkPrGXcfYeI/UYdGbGPMuNeei7YViWXiRZcaCPvhipXzdoRJ3dKHXb81xRpq3uIs
         OEJ5kMzomuX8DbOXlnEF3gYvLTlS5ld01YgA5uf9IB9NE3G+pA/WUDcLq9T1Gkr5wF8x
         HR9A==
X-Gm-Message-State: APjAAAUboVIZGNq2VgomklnNa+Y4/vR5THvAe4zqrercpztRrmJBhKb5
        SRxzqFGkOh3QIJOtl2jHJSyEL1rb
X-Google-Smtp-Source: APXvYqzluhRlLS7+aeGTBMGtndLaXbk7pEcHusdW0T738cU+A7Iw4rH1UIR99+QzGesPhCuXYb/STQ==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr8160946wmh.32.1555020083782;
        Thu, 11 Apr 2019 15:01:23 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0009F15067C8D22C31.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:9f1:5067:c8d2:2c31])
        by smtp.googlemail.com with ESMTPSA id s189sm13266186wmf.45.2019.04.11.15.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:01:23 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     liang.yang@amlogic.com, linux-amlogic@lists.infradead.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        jianxin.pan@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/4] mtd: rawnand: meson: use a void pointer for meson_nfc_dma_buffer_setup
Date:   Fri, 12 Apr 2019 00:00:55 +0200
Message-Id: <20190411220056.19109-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the code because it gets rid of the casts to an
u8-pointer when passing "info_buf" from struct meson_nfc_nand_chip.
Also it gets rid of the cast of the u8 databuf pointer to a void
pointer.
The logic inside meson_nfc_dma_buffer_setup() doesn't care about the
pointer types themselves because it only passes them to dma_map_single
which accepts a void pointer.

No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 9a6023638101..57cc4bd3f665 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -470,15 +470,15 @@ static int meson_nfc_ecc_correct(struct nand_chip *nand, u32 *bitflips,
 	return ret;
 }
 
-static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, u8 *databuf,
-				      int datalen, u8 *infobuf, int infolen,
+static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, void *databuf,
+				      int datalen, void *infobuf, int infolen,
 				      enum dma_data_direction dir)
 {
 	struct meson_nfc *nfc = nand_get_controller_data(nand);
 	u32 cmd;
 	int ret = 0;
 
-	nfc->daddr = dma_map_single(nfc->dev, (void *)databuf, datalen, dir);
+	nfc->daddr = dma_map_single(nfc->dev, databuf, datalen, dir);
 	ret = dma_mapping_error(nfc->dev, nfc->daddr);
 	if (ret) {
 		dev_err(nfc->dev, "DMA mapping error\n");
@@ -645,7 +645,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
 		return ret;
 
 	ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
-					 data_len, (u8 *)meson_chip->info_buf,
+					 data_len, meson_chip->info_buf,
 					 info_len, DMA_TO_DEVICE);
 	if (ret)
 		return ret;
@@ -729,7 +729,7 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
 		return ret;
 
 	ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
-					 data_len, (u8 *)meson_chip->info_buf,
+					 data_len, meson_chip->info_buf,
 					 info_len, DMA_FROM_DEVICE);
 	if (ret)
 		return ret;
-- 
2.21.0

