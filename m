Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A26C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 04:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D5821019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 04:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404237AbfIJERG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 00:17:06 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:24546 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbfIJERG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 00:17:06 -0400
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d81 with ME
        id zgH32000R3xPcdm03gH4Xg; Tue, 10 Sep 2019 06:17:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 10 Sep 2019 06:17:04 +0200
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     manivannan.sadhasivam@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tty: serial: rda: Fix the link time qualifier of 'rda_uart_exit()'
Date:   Tue, 10 Sep 2019 06:17:02 +0200
Message-Id: <20190910041702.7357-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'exit' functions should be marked as __exit, not __init.

Fixes: c10b13325ced ("tty: serial: Add RDA8810PL UART driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/rda-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index c1b0d7662ef9..ff9a27d48bca 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -815,7 +815,7 @@ static int __init rda_uart_init(void)
 	return ret;
 }
 
-static void __init rda_uart_exit(void)
+static void __exit rda_uart_exit(void)
 {
 	platform_driver_unregister(&rda_uart_platform_driver);
 	uart_unregister_driver(&rda_uart_driver);
-- 
2.20.1

