Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA18C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFE221920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfIIKr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:47:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:17914 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfIIKrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:47:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 03:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="183782889"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2019 03:47:49 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        jwboyer@gmail.com, boris.brezillon@free-electrons.com,
        cyrille.pitchen@atmel.com, david.oberhollenzer@sigma-star.at,
        miquel.raynal@bootlin.com, tudor.ambarus@gmail.com,
        vigneshr@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v3 3/3] mtd: spi-nor: cadence-quadspi: disable the auto-poll for Intel LGM
Date:   Mon,  9 Sep 2019 18:47:33 +0800
Message-Id: <20190909104733.14273-4-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190909104733.14273-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190909104733.14273-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

On Intel's Lightning Mountain(LGM) SoC QSPI controller do not auto-poll.
This patch introduces to properly disable the auto-polling feature to
improve the performance of cadence-quadspi.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 73b9fbd1508a..60998eaad1cc 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -135,6 +135,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_RD_INSTR_TYPE_DATA_MASK	0x3
 #define CQSPI_REG_RD_INSTR_DUMMY_MASK		0x1F
 
+#define CQSPI_REG_WR_COMPLETION_CTRL		0x38
+#define CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL	BIT(14)
 #define CQSPI_REG_WR_INSTR			0x08
 #define CQSPI_REG_WR_INSTR_OPCODE_LSB		0
 #define CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
@@ -471,6 +473,18 @@ static int cqspi_command_write_addr(struct spi_nor *nor,
 	return cqspi_exec_flash_cmd(cqspi, reg);
 }
 
+static int cqspi_disable_auto_poll(struct cqspi_st *cqspi)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	reg |= CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL;
+	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+
+	return 0;
+}
+
 static int cqspi_read_setup(struct spi_nor *nor)
 {
 	struct cqspi_flash_pdata *f_pdata = nor->priv;
@@ -508,6 +522,11 @@ static int cqspi_read_setup(struct spi_nor *nor)
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (nor->addr_width - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+
+	/* Disable auto-polling */
+	if (!f_pdata->use_direct_mode)
+		cqspi_disable_auto_poll(cqspi);
+
 	return 0;
 }
 
@@ -627,6 +646,11 @@ static int cqspi_write_setup(struct spi_nor *nor)
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (nor->addr_width - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+
+	/* Disable auto-polling */
+	if (!f_pdata->use_direct_mode)
+		cqspi_disable_auto_poll(cqspi);
+
 	return 0;
 }
 
-- 
2.11.0

