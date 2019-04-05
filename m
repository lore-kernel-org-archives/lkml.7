Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B87217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ih/pm8Oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfDEAOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:14:50 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6469 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbfDEAOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69df00000>; Thu, 04 Apr 2019 17:14:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:36 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:36 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:35 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:35 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69deb0000>; Thu, 04 Apr 2019 17:14:35 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 17/20] spi: add a method for configuring CS timing
Date:   Thu, 4 Apr 2019 17:14:16 -0700
Message-ID: <1554423259-26056-17-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423280; bh=yYi0UrUtMHHtP9i2rMmF5tslLkBm87A6yTmqmEVnwV4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Ih/pm8Oj+5bpx16nvw0DsYQIhOTXcJjlsvEJZYEN7UR7U2BOZq5JaNuWI4YlyiqQ+
         dM+6K+v0oy+mqK5fHrAS4niuogD4foNAWfJdf1lyaJhBDQCy6uHhhQLkoyd1u9vNWT
         JCRex7HIY3zfxs/DT0VRQtdK7uiFYZlzN/v4vh6tXayqI+4KeQuuCGhS5B8lDiilnj
         +mT/c3H8ZoyQuRaDw9wswpzKYypfxnVqHfHjJ3UQovCLk2q/1HGahyYpeTd8XHPZjP
         U5y5LRzjkJrtej4ETnHUmD5RyDnOXcHpUoAv37Nymt/TPoILYMmpiwpGM4Fn6NPlz0
         8ZNiVpS34ugbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates set_cs_timing SPI master optional method for
SPI masters to implement configuring CS timing if applicable.

This patch also creates spi_cs_timing accessory for SPI clients to
use for requesting SPI master controllers to configure device requested
CS setup time, hold time and inactive delay.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi.c       | 15 +++++++++++++++
 include/linux/spi/spi.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 97ce047a776b..0f92329e990f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2995,6 +2995,21 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
+/**
+ * spi_set_cs_timing - configure CS setup, hold, and inactive delays
+ * @spi: the device that requires specific CS timing configuration
+ * @setup: CS setup time in terms of clock count
+ * @hold: CS hold time in terms of clock count
+ * @inactive_dly: CS inactive delay between transfers in terms of clock count
+ */
+void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
+		       u8 inactive_dly)
+{
+	if (spi->controller->set_cs_timing)
+		spi->controller->set_cs_timing(spi, setup, hold, inactive_dly);
+}
+EXPORT_SYMBOL_GPL(spi_set_cs_timing);
+
 static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d5c86b763f43..fc4d21b4c2e4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -331,6 +331,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	must fail if an unrecognized or unsupported mode is requested.
  *	It's always safe to call this unless transfers are pending on
  *	the device whose settings are being modified.
+ * @set_cs_timing: optional hook for SPI devices to request SPI master
+ * controller for configuring specific CS setup time, hold time and inactive
+ * delay interms of clock counts
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
@@ -364,6 +367,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @unprepare_transfer_hardware: there are currently no more messages on the
  *	queue so the subsystem notifies the driver that it may relax the
  *	hardware by issuing this call
+ *
  * @set_cs: set the logic level of the chip select line.  May be called
  *          from interrupt context.
  * @prepare_message: set up the controller to transfer a single message,
@@ -489,6 +493,17 @@ struct spi_controller {
 	 */
 	int			(*setup)(struct spi_device *spi);
 
+	/*
+	 * set_cs_timing() method is for SPI controllers that supports
+	 * configuring CS timing.
+	 *
+	 * This hook allows SPI client drivers to request SPI controllers
+	 * to configure specific CS timing through spi_set_cs_timing() after
+	 * spi_setup().
+	 */
+	void (*set_cs_timing)(struct spi_device *spi, u8 setup_clk_cycles,
+			      u8 hold_clk_cycles, u8 inactive_clk_cycles);
+
 	/* bidirectional bulk transfers
 	 *
 	 * + The transfer() method may not sleep; its main role is
-- 
2.7.4

