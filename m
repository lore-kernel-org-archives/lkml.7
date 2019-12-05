Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB27C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E77D22464
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="urWzQr5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfLEG7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:59:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35004 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfLEG7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:59:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB56xMUj127508;
        Thu, 5 Dec 2019 00:59:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575529162;
        bh=Zs4wFI+xGXRtaEXRUxxfClobWeK4bRL925SuXwkMHLM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=urWzQr5jAR7yw79LmRbkUJoGK8KQ1FyBUG0PxBy1d649CdqWBaIgq/hE5gigTCtNQ
         +6JhnzdUUYntGTKLjCOdTcSjtnzgZU3w1ZGj4XkXT2xvwx/yHQLzqQ4bvwm6u5KgQI
         kKt7EYwxXgYso21z1DHat6DBlA7hIauPRtTOZ2u4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB56xMLS126424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Dec 2019 00:59:22 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 00:59:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 00:59:22 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB56xBT4097002;
        Thu, 5 Dec 2019 00:59:20 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] mtd: spi-nor: Add USE_FSR flag for n25q* entries
Date:   Thu, 5 Dec 2019 12:29:35 +0530
Message-ID: <20191205065935.5727-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205065935.5727-1-vigneshr@ti.com>
References: <20191205065935.5727-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USE_FSR flag to all variants of n25q entries that support Flag Status
Register.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index a5cb647378f0..1082b6bb1393 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2454,16 +2454,21 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
 	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
+	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K |
+			      USE_FSR | SPI_NOR_QUAD_READ) },
+	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K |
+			      USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "mt25ql256a",  INFO6(0x20ba19, 0x104400, 64 * 1024,  512,
 			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
+			      USE_FSR | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
 			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
+	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K |
+			      USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024,
 			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
@@ -2472,7 +2477,7 @@ static const struct flash_info spi_nor_ids[] = {
 			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K |
-			      SPI_NOR_QUAD_READ) },
+			      USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
-- 
2.24.0

