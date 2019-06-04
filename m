Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F3BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20AB24A58
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfFDK7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:59:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49981 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfFDK7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:59:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hY79g-0003xG-6K; Tue, 04 Jun 2019 10:59:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: rawnand: gpmi: remove double assignment to block_size
Date:   Tue,  4 Jun 2019 11:58:59 +0100
Message-Id: <20190604105859.16627-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable block_size is being assigned to itself and to
geo->ecc_chunk_size.  Clean up the double assignment by removing
the assignment to itself.

Addresses-Coverity: ("Evaluation order violation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 5db84178edff..334fe3130285 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1428,7 +1428,7 @@ static void gpmi_bch_layout_std(struct gpmi_nand_data *this)
 	struct bch_geometry *geo = &this->bch_geometry;
 	unsigned int ecc_strength = geo->ecc_strength >> 1;
 	unsigned int gf_len = geo->gf_len;
-	unsigned int block_size = block_size = geo->ecc_chunk_size;
+	unsigned int block_size = geo->ecc_chunk_size;
 
 	this->bch_flashlayout0 =
 		BF_BCH_FLASH0LAYOUT0_NBLOCKS(geo->ecc_chunk_count - 1) |
-- 
2.20.1

