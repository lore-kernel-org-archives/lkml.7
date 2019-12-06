Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF208C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02702466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLFIJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:09:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfLFIJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:09:58 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4CD1E7533FAA2136108F;
        Fri,  6 Dec 2019 16:09:56 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Dec 2019 16:09:50 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] tty: serial: amba-pl011: remove set but unused variable
Date:   Fri, 6 Dec 2019 16:05:26 +0800
Message-ID: <1575619526-34482-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:
drivers/tty/serial/amba-pl011.c: In function check_apply_cts_event_workaround:
drivers/tty/serial/amba-pl011.c:1461:15: warning: variable dummy_read set but not used [-Wunused-but-set-variable]

The data read is useless and can be dropped.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/tty/serial/amba-pl011.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4b28134..c5e9475 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1452,8 +1452,6 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 
 static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 {
-	unsigned int dummy_read;
-
 	if (!uap->vendor->cts_event_workaround)
 		return;
 
@@ -1465,8 +1463,8 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 	 * single apb access will incur 2 pclk(133.12Mhz) delay,
 	 * so add 2 dummy reads
 	 */
-	dummy_read = pl011_read(uap, REG_ICR);
-	dummy_read = pl011_read(uap, REG_ICR);
+	pl011_read(uap, REG_ICR);
+	pl011_read(uap, REG_ICR);
 }
 
 static irqreturn_t pl011_int(int irq, void *dev_id)
-- 
1.7.12.4

