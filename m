Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E87C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891B72071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKVL53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:57:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbfKVL53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:57:29 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 23638AEFA52CB2BDF56B;
        Fri, 22 Nov 2019 19:57:27 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 22 Nov 2019 19:57:16 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v2] tty: serial: samsung: remove variable 'ufstat' set but not used
Date:   Fri, 22 Nov 2019 20:04:18 +0800
Message-ID: <1574424258-138975-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574421159-113624-1-git-send-email-chenwandun@huawei.com>
References: <1574421159-113624-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/tty/serial/samsung_tty.c: In function s3c24xx_serial_rx_chars_dma:
drivers/tty/serial/samsung_tty.c:549:24: warning: variable ufstat set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/tty/serial/samsung_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 83fd516..ab3c7d1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -546,7 +546,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport);
 
 static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 {
-	unsigned int utrstat, ufstat, received;
+	unsigned int utrstat, received;
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
@@ -556,7 +556,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	struct dma_tx_state state;
 
 	utrstat = rd_regl(port, S3C2410_UTRSTAT);
-	ufstat = rd_regl(port, S3C2410_UFSTAT);
+	rd_regl(port, S3C2410_UFSTAT);
 
 	spin_lock_irqsave(&port->lock, flags);
 
-- 
2.7.4

