Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A615EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836F3206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfH0D7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:59:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:9631 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbfH0D7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:59:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 20:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="355640671"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 26 Aug 2019 20:59:00 -0700
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
Subject: [PATCH v2 3/3] mtd: spi-nor: cadence-quadspi: disable the auto-poll for Intel LGM
Date:   Tue, 27 Aug 2019 11:58:27 +0800
Message-Id: <20190827035827.21024-4-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190827035827.21024-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190827035827.21024-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
index 69fa13e95110..94aa40e868a1 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -134,6 +134,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_RD_INSTR_TYPE_DATA_MASK	0x3
 #define CQSPI_REG_RD_INSTR_DUMMY_MASK		0x1F
 
+#define CQSPI_REG_WR_COMPLETION_CTRL		0x38
+#define CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL	BIT(14)
 #define CQSPI_REG_WR_INSTR			0x08
 #define CQSPI_REG_WR_INSTR_OPCODE_LSB		0
 #define CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
@@ -470,6 +472,18 @@ static int cqspi_command_write_addr(struct spi_nor *nor,
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
@@ -507,6 +521,11 @@ static int cqspi_read_setup(struct spi_nor *nor)
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
 
@@ -631,6 +650,11 @@ static int cqspi_write_setup(struct spi_nor *nor)
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

