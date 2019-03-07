Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5584C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9517B20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfCGKa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:30:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCGKaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:30:25 -0500
Received: from [5.158.153.52] (helo=ares.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <volker.haspel@linutronix.de>)
        id 1h1qIA-0005KP-HT; Thu, 07 Mar 2019 11:30:22 +0100
From:   Volker Haspel <volker.haspel@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Mark Brown <broonie@kernel.org>, john.ogness@linutronix.de,
        volker.haspel@linutronix.de
Subject: [PATCH] spi: spi-fsl-qspi: call spi_unregister_controller
Date:   Thu,  7 Mar 2019 11:30:08 +0100
Message-Id: <20190307103008.19841-1-volker.haspel@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not clearly unregister the spi controller.
Therefore calling an unbind and bind again will end up in a
Kernel crash.
Each driver who calls spi_register_controller() in the probe function
has to call spi_unregister_controller() too.

Signed-off-by: Volker Haspel <volker.haspel@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/spi/spi-fsl-qspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6a713f78a62e..373c4a82e8e3 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -248,6 +248,7 @@ struct fsl_qspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
+	struct spi_controller *ctlr;
 };
 
 static inline int needs_swap_endian(struct fsl_qspi *q)
@@ -812,6 +813,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 			  SPI_TX_DUAL | SPI_TX_QUAD;
 
 	q = spi_controller_get_devdata(ctlr);
+	q->ctlr = ctlr;
 	q->dev = dev;
 	q->devtype_data = of_device_get_match_data(dev);
 	if (!q->devtype_data) {
@@ -912,6 +914,7 @@ static int fsl_qspi_remove(struct platform_device *pdev)
 	fsl_qspi_clk_disable_unprep(q);
 
 	mutex_destroy(&q->lock);
+	spi_unregister_controller(q->ctlr);
 
 	return 0;
 }
-- 
2.11.0

