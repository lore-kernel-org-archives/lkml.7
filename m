Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0B20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfCFCyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:54:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:24371 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCFCyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:54:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 18:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,446,1544515200"; 
   d="scan'208";a="129343462"
Received: from shcsbb05.sh.intel.com ([10.239.147.132])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 18:54:29 -0800
From:   xiao jin <jin.xiao@intel.com>
To:     jarkko.nikula@linux.intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Cc:     "he, bo" <bo.he@intel.com>, xiao jin <jin.xiao@intel.com>,
        he@vger.kernel.org
Subject: [PATCH] spi-pxa2xx.c: modify the chip selection timing when spi transfer
Date:   Wed,  6 Mar 2019 11:05:19 +0800
Message-Id: <20190306030519.10746-1-jin.xiao@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "he, bo" <bo.he@intel.com>

We find spi can't work on board. More debug shows it's related
to the following patch that changed the chip selection assert and
deassert timing.

commit d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1

    spi: pxa2xx: Use core message processing loop

    Convert the pump_transfers() transfer tasklet to transfer_one()
    hook the SPI core calls to process single transfer instead of
    handling message processing and chip select handling in the driver.
    This not only simplifies the driver but also brings transfer
    statistics from the core.

We modify the chip selection timeing action back to before the patch.
The spi on the board works.

Signed-off-by: xiao jin <jin.xiao@intel.com>
Signed-off-by: he, bo <bo.he@intel.com>
---
 drivers/spi/spi-pxa2xx.c | 41 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ec4b65100..0affa09da 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -340,11 +340,9 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	}
 }
 
-static void lpss_ssp_select_cs(struct spi_device *spi,
+static void lpss_ssp_select_cs(struct driver_data *drv_data,
 			       const struct lpss_config *config)
 {
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
 	u32 value, cs;
 
 	if (!config->cs_sel_mask)
@@ -352,7 +350,7 @@ static void lpss_ssp_select_cs(struct spi_device *spi,
 
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
 
-	cs = spi->chip_select;
+	cs = drv_data->master->cur_msg->spi->chip_select;
 	cs <<= config->cs_sel_shift;
 	if (cs != (value & config->cs_sel_mask)) {
 		/*
@@ -371,17 +369,15 @@ static void lpss_ssp_select_cs(struct spi_device *spi,
 	}
 }
 
-static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
+static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 {
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
 	const struct lpss_config *config;
 	u32 value;
 
 	config = lpss_get_config(drv_data);
 
 	if (enable)
-		lpss_ssp_select_cs(spi, config);
+		lpss_ssp_select_cs(drv_data, config);
 
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
 	if (enable)
@@ -391,11 +387,10 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 }
 
-static void cs_assert(struct spi_device *spi)
+static void cs_assert(struct driver_data *drv_data)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 
 	if (drv_data->ssp_type == CE4100_SSP) {
 		pxa2xx_spi_write(drv_data, SSSR, chip->frm);
@@ -413,14 +408,13 @@ static void cs_assert(struct spi_device *spi)
 	}
 
 	if (is_lpss_ssp(drv_data))
-		lpss_ssp_cs_control(spi, true);
+		lpss_ssp_cs_control(drv_data, true);
 }
 
-static void cs_deassert(struct spi_device *spi)
+static void cs_deassert(struct driver_data *drv_data)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 	unsigned long timeout;
 
 	if (drv_data->ssp_type == CE4100_SSP)
@@ -443,15 +437,7 @@ static void cs_deassert(struct spi_device *spi)
 	}
 
 	if (is_lpss_ssp(drv_data))
-		lpss_ssp_cs_control(spi, false);
-}
-
-static void pxa2xx_spi_set_cs(struct spi_device *spi, bool level)
-{
-	if (level)
-		cs_deassert(spi);
-	else
-		cs_assert(spi);
+		lpss_ssp_cs_control(drv_data, false);
 }
 
 int pxa2xx_spi_flush(struct driver_data *drv_data)
@@ -610,6 +596,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 
+	cs_deassert(drv_data);
 	spi_finalize_current_transfer(drv_data->master);
 }
 
@@ -1070,6 +1057,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
+	cs_assert(drv_data);
 	/*
 	 * Release the data by enabling service requests and interrupts,
 	 * without changing any mode bits
@@ -1563,7 +1551,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->dma_alignment = DMA_ALIGNMENT;
 	master->cleanup = cleanup;
 	master->setup = setup;
-	master->set_cs = pxa2xx_spi_set_cs;
 	master->transfer_one = pxa2xx_spi_transfer_one;
 	master->handle_err = pxa2xx_spi_handle_err;
 	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
-- 
2.20.1

