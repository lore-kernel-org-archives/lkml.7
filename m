Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8D3C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28712133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gjB5a0Op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDIQ3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:29:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51410 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:29:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x39GSgZ0005420;
        Tue, 9 Apr 2019 11:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554827322;
        bh=Mp0B8CyCHd2ZGTNXrNC9MdMOgc02jXAh7ZWpaZF558o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gjB5a0Op1GsYiTwqGtwl0mV9AQW6TKF+NXZeCMmC2rgUEfTwzdJOQkD1Jsa6nQJxC
         T3UXS5HFc8E/V0JhwTuvtPEv4dNj4BIjazQmCR7Tk95DZ0JrK4cwvjWyHYs86qmJei
         tPdcB/AWEpn2Z1Epa0qlmnk5sa55ebGL2nZL0qzM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x39GSg5A033128
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 11:28:42 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 11:28:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 11:28:41 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x39GSVQE128531;
        Tue, 9 Apr 2019 11:28:39 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH 2/2] mtd: spi-nor: Rework hwcaps selection for the spi-mem case
Date:   Tue, 9 Apr 2019 21:56:51 +0530
Message-ID: <20190409162651.24593-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409162651.24593-1-vigneshr@ti.com>
References: <20190409162651.24593-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

The spi-mem layer provides a spi_mem_supports_op() function to check
whether a specific operation is supported by the controller or not.
This is much more accurate than the hwcaps selection logic based on
SPI_{RX,TX}_ flags.

Rework the hwcaps selection logic to use spi_mem_supports_op() when
nor->spimem != NULL.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
Chagnes wrt RFC:
Fix checkpatch issues
Rebase onto latest

 drivers/mtd/spi-nor/spi-nor.c | 164 ++++++++++++++++++++++++++--------
 include/linux/mtd/spi-nor.h   |  14 +++
 2 files changed, 142 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 03c8c346c9ae..d48ae3c9661d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2852,6 +2852,110 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
 	return ret;
 }
 
+static int spi_nor_spimem_check_readop(struct spi_nor *nor,
+				       const struct spi_nor_read_command *read)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(read->opcode, 1),
+					  SPI_MEM_OP_ADDR(3, 0, 1),
+					  SPI_MEM_OP_DUMMY(0, 1),
+					  SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(read->proto);
+	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(read->proto);
+	op.data.buswidth = spi_nor_get_protocol_data_nbits(read->proto);
+	op.dummy.buswidth = op.addr.buswidth;
+	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
+			  op.dummy.buswidth / 8;
+
+	/*
+	 * First test with 3 address bytes. The opcode itself might already
+	 * be a 4B addressing opcode but we don't care, because SPI controller
+	 * implementation should not check the opcode, but just the sequence.
+	 */
+	if (!spi_mem_supports_op(nor->spimem, &op))
+		return -ENOTSUPP;
+
+	/* Now test with 4 address bytes. */
+	op.addr.nbytes = 4;
+	if (!spi_mem_supports_op(nor->spimem, &op))
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static int spi_nor_spimem_check_progop(struct spi_nor *nor,
+				       const struct spi_nor_pp_command *pp)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(pp->opcode, 1),
+					  SPI_MEM_OP_ADDR(3, 0, 1),
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(0, NULL, 1));
+
+	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(pp->proto);
+	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(pp->proto);
+	op.data.buswidth = spi_nor_get_protocol_data_nbits(pp->proto);
+
+	/*
+	 * First test with 3 address bytes. The opcode itself might already
+	 * be a 4B addressing opcode but we don't care, because SPI controller
+	 * implementation should not check the opcode, but just the sequence.
+	 */
+	if (!spi_mem_supports_op(nor->spimem, &op))
+		return -ENOTSUPP;
+
+	/* Now test with 4 address bytes. */
+	op.addr.nbytes = 4;
+	if (!spi_mem_supports_op(nor->spimem, &op))
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static void
+spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor,
+			     const struct spi_nor_flash_parameter *params,
+			     u32 *hwcaps)
+{
+	unsigned int cap;
+
+	/* DTR modes are not supported yet, mask them all. */
+	*hwcaps &= ~SNOR_HWCAPS_DTR;
+
+	/* X-X-X modes are not supported yet, mask them all. */
+	*hwcaps &= ~SNOR_HWCAPS_X_X_X;
+
+	/* Start with read commands. */
+	for (cap = 0; cap < 32; cap++) {
+		int idx;
+
+		if (!(*hwcaps & BIT(cap)))
+			continue;
+
+		idx = spi_nor_hwcaps_read2cmd(BIT(cap));
+		if (idx < 0)
+			continue;
+
+		if (spi_nor_spimem_check_readop(nor, &params->reads[idx]))
+			*hwcaps &= ~BIT(cap);
+	}
+
+	/* Now check program commands. */
+	for (cap = 0; cap < 32; cap++) {
+		int idx;
+
+		if (!(*hwcaps & BIT(cap)))
+			continue;
+
+		idx = spi_nor_hwcaps_pp2cmd(BIT(cap));
+		if (idx < 0)
+			continue;
+
+		if (spi_nor_spimem_check_progop(nor,
+						&params->page_programs[idx]))
+			*hwcaps &= ~BIT(cap);
+	}
+}
+
 /**
  * spi_nor_read_sfdp_dma_unsafe() - read Serial Flash Discoverable Parameters.
  * @nor:	pointer to a 'struct spi_nor'
@@ -4259,16 +4363,25 @@ static int spi_nor_setup(struct spi_nor *nor,
 	 */
 	shared_mask = hwcaps->mask & params->hwcaps.mask;
 
-	/* SPI n-n-n protocols are not supported yet. */
-	ignored_mask = (SNOR_HWCAPS_READ_2_2_2 |
-			SNOR_HWCAPS_READ_4_4_4 |
-			SNOR_HWCAPS_READ_8_8_8 |
-			SNOR_HWCAPS_PP_4_4_4 |
-			SNOR_HWCAPS_PP_8_8_8);
-	if (shared_mask & ignored_mask) {
-		dev_dbg(nor->dev,
-			"SPI n-n-n protocols are not supported yet.\n");
-		shared_mask &= ~ignored_mask;
+	if (nor->spimem) {
+		/*
+		 * When called from spi_nor_probe(), all caps are set and we
+		 * need to discard some of them based on what the SPI
+		 * controller actually supports (using spi_mem_supports_op()).
+		 */
+		spi_nor_spimem_adjust_hwcaps(nor, params, &shared_mask);
+	} else {
+		/*
+		 * SPI n-n-n protocols are not supported when the SPI
+		 * controller directly implements the spi_nor interface.
+		 * Yet another reason to switch to spi-mem.
+		 */
+		ignored_mask = SNOR_HWCAPS_X_X_X;
+		if (shared_mask & ignored_mask) {
+			dev_dbg(nor->dev,
+				"SPI n-n-n protocols are not supported.\n");
+			shared_mask &= ~ignored_mask;
+		}
 	}
 
 	/* Select the (Fast) Read command. */
@@ -4591,11 +4704,11 @@ static int spi_nor_probe(struct spi_mem *spimem)
 	struct spi_device *spi = spimem->spi;
 	struct flash_platform_data *data;
 	struct spi_nor *nor;
-	struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ |
-			SNOR_HWCAPS_READ_FAST |
-			SNOR_HWCAPS_PP,
-	};
+	/*
+	 * Enable all caps by default. The core will mask them after
+	 * checking what's really supported using spi_mem_supports_op().
+	 */
+	struct spi_nor_hwcaps hwcaps = { .mask = SNOR_HWCAPS_ALL };
 	char *flash_name;
 	int ret;
 
@@ -4624,27 +4737,6 @@ static int spi_nor_probe(struct spi_mem *spimem)
 
 	spi_mem_set_drvdata(spimem, nor);
 
-	if (spi->mode & SPI_RX_OCTAL) {
-		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
-
-		if (spi->mode & SPI_TX_OCTAL)
-			hwcaps.mask |= (SNOR_HWCAPS_READ_1_8_8 |
-					SNOR_HWCAPS_PP_1_1_8 |
-					SNOR_HWCAPS_PP_1_8_8);
-	} else if (spi->mode & SPI_RX_QUAD) {
-		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
-
-		if (spi->mode & SPI_TX_QUAD)
-			hwcaps.mask |= (SNOR_HWCAPS_READ_1_4_4 |
-					SNOR_HWCAPS_PP_1_1_4 |
-					SNOR_HWCAPS_PP_1_4_4);
-	} else if (spi->mode & SPI_RX_DUAL) {
-		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
-
-		if (spi->mode & SPI_TX_DUAL)
-			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
-	}
-
 	if (data && data->name)
 		nor->mtd.name = data->name;
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index ac16745f5ef8..1d56c437f553 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -523,6 +523,20 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_PP_1_8_8	BIT(21)
 #define SNOR_HWCAPS_PP_8_8_8	BIT(22)
 
+#define SNOR_HWCAPS_X_X_X	(SNOR_HWCAPS_READ_2_2_2 |	\
+				 SNOR_HWCAPS_READ_4_4_4 |	\
+				 SNOR_HWCAPS_READ_8_8_8 |	\
+				 SNOR_HWCAPS_PP_4_4_4 |		\
+				 SNOR_HWCAPS_PP_8_8_8)
+
+#define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
+				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
+				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
+				 SNOR_HWCAPS_READ_1_8_8_DTR)
+
+#define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
+				 SNOR_HWCAPS_PP_MASK)
+
 /**
  * spi_nor_scan() - scan the SPI NOR
  * @nor:	the spi_nor structure
-- 
2.21.0

