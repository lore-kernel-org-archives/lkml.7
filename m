Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2602DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047FE20449
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfFXQBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:01:11 -0400
Received: from smtprz15.163.net ([106.3.154.248]:9418 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbfFXQBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:01:11 -0400
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
        by freemail01.tom.com (Postfix) with ESMTP id 120301C819E4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 00:00:59 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app01 (TOM SMTP Server) with SMTP ID -1293139326
          for <linux-kernel@vger.kernel.org>;
          Tue, 25 Jun 2019 00:00:59 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 059DC1C81A7C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 00:00:59 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 072BD1001982
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 00:00:58 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vCMF3mqm9TeS for <linux-kernel@vger.kernel.org>;
        Tue, 25 Jun 2019 00:00:56 +0800 (CST)
Received: from localhost (unknown [222.209.17.143])
        by antispam1.tom.com (Postfix) with ESMTPA id 7BCBF100177F;
        Tue, 25 Jun 2019 00:00:55 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, tudor.ambarus@microchip.com,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH v4] mtd: spi-nor: fix nor->addr_width when its value configured from SFDP does not match the actual width
Date:   Tue, 25 Jun 2019 00:00:46 +0800
Message-Id: <1561392046-10487-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS25LP256 gets BFPT_DWORD1_ADDRESS_BYTES_3_ONLY from BFPT table for
address width. But in actual fact the flash can support 4-byte address.
Use a post bfpt fixup hook to overwrite the address width advertised by
the BFPT.

Suggested-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>

---

Changes in v4:
 update the comment suggested by Tudor.
---
 drivers/mtd/spi-nor/spi-nor.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 73172d7..ce153c4 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1687,6 +1687,28 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 		.flags = SPI_NOR_NO_FR | SPI_S3AN,
 
 static int
+is25lp256_post_bfpt_fixups(struct spi_nor *nor,
+			   const struct sfdp_parameter_header *bfpt_header,
+			   const struct sfdp_bfpt *bfpt,
+			   struct spi_nor_flash_parameter *params)
+{
+	/*
+	 * IS25LP256 supports 4B opcodes, but the BFPT advertises a
+	 * BFPT_DWORD1_ADDRESS_BYTES_3_ONLY address width.
+	 * Overwrite the address width advertised by the BFPT.
+	 */
+	if ((bfpt->dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) ==
+		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
+		nor->addr_width = 4;
+
+	return 0;
+}
+
+static struct spi_nor_fixups is25lp256_fixups = {
+	.post_bfpt = is25lp256_post_bfpt_fixups,
+};
+
+static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
 			    const struct sfdp_bfpt *bfpt,
@@ -1827,7 +1849,8 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 			SECT_4K | SPI_NOR_DUAL_READ) },
 	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 512,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_4B_OPCODES) },
+			SPI_NOR_4B_OPCODES)
+			.fixups = &is25lp256_fixups },
 	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128,
-- 
1.9.1

