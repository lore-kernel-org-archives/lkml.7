Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F305C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659C82070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKKwKRs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393497AbfIFTtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:49:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfIFTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:49:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so4077608pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uAzFuMJFC8Qs6zalTfHoEOACCJjWE6SxXCJNlMiufmc=;
        b=RKKwKRs2N6yoI0pB2oH4Uv9SbRzRWQEW0woC725TrgQ5hhPfgqJWWtes733p+nCc4u
         ds98ZXgCub53C6qaASOae9vIW3w2C7hXik/fsEOhicdwKkxuKJcR6hWAE4HsDXbnU9U0
         5gNeKjfnE2BGZhJNJ8AAVceGHsbxrZOOpmfEkOef6xgNdcNdw/DE1xZIQ8TUu9MinI/j
         OxfwccCtnukauMPYWIs4U4jT+wlBUWnze7aTbQThbkKOBNuwJbBeouUFufFHctIO45OV
         lXZikXmPFrQJsxk871LQr1cv4vXt4Gc5+hdxl/AAKi+K5cUaYMyhCEp7HTne/9AyBaDS
         WrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uAzFuMJFC8Qs6zalTfHoEOACCJjWE6SxXCJNlMiufmc=;
        b=Bid/zszyssFDNi2gFQX7CP5qUcsuZs4nJiH6gU+viw+66o8LUaaeLEn0QAl4Lt5Cgq
         5lOUGbAHBVszelptpvOJCFkhDPzI4lGOTgEL+c6QD/iA+pLWEJjg5+ray4eZfp6PunAz
         FIayf0YXLzYkRLnl4EzpY2jQ+YLqFoaXJ+d5vGFR764Stb1GIGaFST6jmssPwfhnTtYu
         UoKV/tZZ2TWgg1UiaIWMEczwoKMC8E7BCCYyQ8raiYtlFYgpuR5WYugS1L7j0rDRHfDQ
         zgdrKZiaLJRx5QZPhFxoo4oS0ENAB+IoDQNgSYdwgsoRsOF0NhEkAiCKOhr1IfFpVMpo
         iyFg==
X-Gm-Message-State: APjAAAWHYLgW9eB9k0ePorHYgxoclDtISZP/6cA9JxVbY+kcD9mb7Uaj
        qPYakz1shFyVgvNbwbEs1+I=
X-Google-Smtp-Source: APXvYqzYnh/9vJNadE0cCHveRlhb7dIY5iG/blPZ0Hq8le4ixP+lhRxijP9d4wDs0X4pvqNWVypmWA==
X-Received: by 2002:a17:90a:2e15:: with SMTP id q21mr11395700pjd.97.1567799351470;
        Fri, 06 Sep 2019 12:49:11 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c127sm9830119pfb.5.2019.09.06.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 12:49:10 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     kdasu.kdev@gmail.com
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: nand: brcmnand: Add support for flash-dma v0
Date:   Fri,  6 Sep 2019 15:47:15 -0400
Message-Id: <20190906194719.15761-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support for flash dma v0.0.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 33310b8a6eb8..1eade9dc3b0d 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -117,6 +117,18 @@ enum flash_dma_reg {
 	FLASH_DMA_CURRENT_DESC_EXT,
 };
 
+/* flash_dma registers v0*/
+static const u16 flash_dma_regs_v0[] = {
+	[FLASH_DMA_REVISION]		= 0x00,
+	[FLASH_DMA_FIRST_DESC]		= 0x04,
+	[FLASH_DMA_CTRL]		= 0x08,
+	[FLASH_DMA_MODE]		= 0x0c,
+	[FLASH_DMA_STATUS]		= 0x10,
+	[FLASH_DMA_INTERRUPT_DESC]	= 0x14,
+	[FLASH_DMA_ERROR_STATUS]	= 0x18,
+	[FLASH_DMA_CURRENT_DESC]	= 0x1c,
+};
+
 /* flash_dma registers v1*/
 static const u16 flash_dma_regs_v1[] = {
 	[FLASH_DMA_REVISION]		= 0x00,
@@ -597,6 +609,8 @@ static void brcmnand_flash_dma_revision_init(struct brcmnand_controller *ctrl)
 	/* flash_dma register offsets */
 	if (ctrl->nand_version >= 0x0703)
 		ctrl->flash_dma_offsets = flash_dma_regs_v4;
+	else if (ctrl->nand_version == 0x0602)
+		ctrl->flash_dma_offsets = flash_dma_regs_v0;
 	else
 		ctrl->flash_dma_offsets = flash_dma_regs_v1;
 }
@@ -1673,8 +1687,11 @@ static void brcmnand_dma_run(struct brcmnand_host *host, dma_addr_t desc)
 
 	flash_dma_writel(ctrl, FLASH_DMA_FIRST_DESC, lower_32_bits(desc));
 	(void)flash_dma_readl(ctrl, FLASH_DMA_FIRST_DESC);
-	flash_dma_writel(ctrl, FLASH_DMA_FIRST_DESC_EXT, upper_32_bits(desc));
-	(void)flash_dma_readl(ctrl, FLASH_DMA_FIRST_DESC_EXT);
+	if (ctrl->nand_version > 0x0602) {
+		flash_dma_writel(ctrl, FLASH_DMA_FIRST_DESC_EXT,
+				 upper_32_bits(desc));
+		(void)flash_dma_readl(ctrl, FLASH_DMA_FIRST_DESC_EXT);
+	}
 
 	/* Start FLASH_DMA engine */
 	ctrl->dma_pending = true;
-- 
2.17.1

