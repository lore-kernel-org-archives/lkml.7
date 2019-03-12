Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4B8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDA4214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCLKMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:12:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43251 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLKML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:12:11 -0400
Received: from [5.158.153.52] (helo=ares.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <volker.haspel@linutronix.de>)
        id 1h3eOC-0006TU-U3; Tue, 12 Mar 2019 11:12:05 +0100
From:   Volker Haspel <volker.haspel@linutronix.de>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, han.xu@nxp.com,
        volker.haspel@linutronix.de, john.ogness@linutronix.de
Subject: [PATCH v2 1/1] spi: spi-fsl-qspi: use devm_spi_register_controller
Date:   Tue, 12 Mar 2019 11:12:03 +0100
Message-Id: <20190312101203.14207-2-volker.haspel@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190312101203.14207-1-volker.haspel@linutronix.de>
References: <20190312101203.14207-1-volker.haspel@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not clearly unregister the spi controller.
Therefore calling an unbind and bind again will end up in a
Kernel crash.

The function devm_spi_register_controller will automatically
be unregister the SPI device.

Signed-off-by: Volker Haspel <volker.haspel@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6a713f78a62e..41a49b93ca60 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -882,7 +882,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
-- 
2.11.0

