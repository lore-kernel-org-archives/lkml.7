Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1694FC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBECC20643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLXJa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 04:30:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfLXJa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 04:30:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DCFEA2A35862A1C54780;
        Tue, 24 Dec 2019 17:30:55 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 17:30:47 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 4/4] tty/serial: 8250_exar: use true,false for bool variable
Date:   Tue, 24 Dec 2019 17:38:05 +0800
Message-ID: <1577180285-24904-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577180285-24904-1-git-send-email-zhengbin13@huawei.com>
References: <1577180285-24904-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/tty/serial/8250/8250_exar.c:189:6-17: WARNING: Assignment of 0/1 to bool variable
drivers/tty/serial/8250/8250_exar.c:197:3-14: WARNING: Assignment of 0/1 to bool variable
drivers/tty/serial/8250/8250_exar.c:199:3-14: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/tty/serial/8250/8250_exar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 108cd55..91e9b07 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -186,7 +186,7 @@ static int xr17v35x_startup(struct uart_port *port)
 static void exar_shutdown(struct uart_port *port)
 {
 	unsigned char lsr;
-	bool tx_complete = 0;
+	bool tx_complete = false;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct circ_buf *xmit = &port->state->xmit;
 	int i = 0;
@@ -194,9 +194,9 @@ static void exar_shutdown(struct uart_port *port)
 	do {
 		lsr = serial_in(up, UART_LSR);
 		if (lsr & (UART_LSR_TEMT | UART_LSR_THRE))
-			tx_complete = 1;
+			tx_complete = true;
 		else
-			tx_complete = 0;
+			tx_complete = false;
 		usleep_range(1000, 1100);
 	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);

--
2.7.4

