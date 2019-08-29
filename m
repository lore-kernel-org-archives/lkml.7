Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CBDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10B92173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfH2MHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:07:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37470 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfH2MHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:07:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EB45200767;
        Thu, 29 Aug 2019 14:07:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 98460200336;
        Thu, 29 Aug 2019 14:07:37 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 92A3B402DE;
        Thu, 29 Aug 2019 20:07:30 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     tudor.ambarus@microchip.com, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ashish Kumar <Ashish.Kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH v4] mtd: spi-nor: Rename n25q512a to mt25qu512a(n25q512a)
Date:   Thu, 29 Aug 2019 17:37:25 +0530
Message-Id: <1567080445-32695-2-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567080445-32695-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1567080445-32695-1-git-send-email-Ashish.Kumar@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt25qu512a is rebranded after its spinoff from STM, so it is
different only in term of operating frequency, JEDEC id
is same as that of n25q512a.
SPI_NOR_4B_OPCODES is appended to flash property.
This flash is tested for Single I/O and QUAD I/O mode on LS1046FRWY.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
v4:
-Reword commit message as per review comments from
tudor.
- split into seperate patch 
v3:
-Reword commits msg
-rebase to top of mtd-linux spi-nor/next
v2:
Incorporate review comments from Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 73172d7f512b..b585f3fee4f0 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1876,7 +1876,18 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+
+	/* Micron */
+	/* n25q512a is rebraned as mt25qu512a after spin-off from ST,
+	 * JEDEC id remains same.
+	 * Operational frequency and Read Performance has increased
+	 */
+	{
+		"mt25qu512a(n25q512a)", INFO(0x20bb20, 0, 64 * 1024, 1024,
+			SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
+	},
+
 	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
-- 
2.17.1

