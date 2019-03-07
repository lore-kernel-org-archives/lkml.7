Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1252B20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfCGHN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:13:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:39227 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGHN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:13:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 23:13:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="325002030"
Received: from shcsbb05.sh.intel.com ([10.239.147.132])
  by fmsmga006.fm.intel.com with ESMTP; 06 Mar 2019 23:13:25 -0800
From:   xiao jin <jin.xiao@intel.com>
To:     jarkko.nikula@linux.intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Cc:     xiao jin <jin.xiao@intel.com>, he@vger.kernel.org,
        bo <bo.he@intel.com>
Subject: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during pxa2xx_spi_transfer_one()
Date:   Thu,  7 Mar 2019 15:24:24 +0800
Message-Id: <20190307072424.18820-1-jin.xiao@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-pxa2xx can't read and write data correctly on our board.
The pxa_ssp_type is LPSS_BXT_SSP in our case.

With more debug we find that it's related to restart the SPP
during pxa2xx_spi_transfer_one().

In the normal case the spi_transfer_one_message() calls spi-pxa2xx
cs_assert before transferring one message. After completing the
transfer it calls spi-pxa2xx cs_deassert. The spi-pxa2xx works
well.

But in some other case pxa2xx_spi_unprepare_transfer() is called
that clears SSCR0_SSE bit before the next transfer. In the next
transfer the spi-pxa2xx driver will restart the SSP as the SSE
bit is cleared. The cs_assert before the SSP restart can't ensure
spi-pxa2xx work well.

The patch is to do cs again if spi-pxa2xx restar the SSP during
pxa2xx_spi_transfer_one()

Signed-off-by: xiao jin <jin.xiao@intel.com>
Signed-off-by: he, bo <bo.he@intel.com>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff..1a2ea46858d9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -928,6 +928,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	u32 cr1;
 	int err;
 	int dma_mapped;
+	bool need_cs_change = false;
 
 	/* Check if we can DMA this transfer */
 	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
@@ -1056,6 +1057,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	if ((pxa2xx_spi_read(drv_data, SSCR0) != cr0)
 	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
 	    != (cr1 & change_mask)) {
+		/* It needs to deassert the chip selection
+		 * firstly before restart the SPP */
+		need_cs_change = true;
+		cs_deassert(spi);
+
 		/* stop the SSP, and update the other bits */
 		pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
 		if (!pxa25x_ssp_comp(drv_data))
@@ -1070,6 +1076,8 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
+	if (need_cs_change)
+		cs_assert(spi);
 	/*
 	 * Release the data by enabling service requests and interrupts,
 	 * without changing any mode bits
-- 
2.21.0

