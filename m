Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC7AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715E82133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfJIGU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:20:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50952 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfJIGU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:20:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C16261A0394;
        Wed,  9 Oct 2019 08:20:52 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E1DAC1A00A7;
        Wed,  9 Oct 2019 08:20:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B22D7402EC;
        Wed,  9 Oct 2019 14:20:41 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] tty: serial: imx: Only get second/third IRQ when there is more than one IRQ
Date:   Wed,  9 Oct 2019 14:18:31 +0800
Message-Id: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All i.MX SoCs except i.MX1 have ONLY 1 IRQ, so it is better to check
the IRQ count before getting second/third IRQ to avoid below error
message during probe:

[    0.726219] imx-uart 30860000.serial: IRQ index 1 not found
[    0.731329] imx-uart 30860000.serial: IRQ index 2 not found

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 504d81c..081fa82 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2198,6 +2198,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	u32 ucr1;
 	struct resource *res;
 	int txirq, rxirq, rtsirq;
+	int irq_count;
 
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
@@ -2220,9 +2221,17 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	irq_count = platform_irq_count(pdev);
+	if (irq_count < 0)
+		return irq_count;
+
 	rxirq = platform_get_irq(pdev, 0);
-	txirq = platform_get_irq(pdev, 1);
-	rtsirq = platform_get_irq(pdev, 2);
+	if (irq_count > 1) {
+		txirq = platform_get_irq(pdev, 1);
+		rtsirq = platform_get_irq(pdev, 2);
+	} else {
+		txirq = rtsirq = -ENXIO;
+	}
 
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
-- 
2.7.4

