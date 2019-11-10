Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F76C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE682184C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353635;
	bh=Skao6+giRM+BTw2RKzLY/18Rl/+xSoa8wM3mstDU30g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXMwQXwTNs4QFl2BGI/posXhQPlezMPw2EKrFG34MW4QKE4kHJ/SHFT5RTYNb67Gv
	 n6QZR5ZWErP6BiV3Jy3m6uX+CQ7QrUrz2k4WDo3ppz13DZRQxhCzDy3gaDIgseTHOv
	 oL5xRP45Z92nUc/FwkkspSy3dlZmiHPZwlKKXOeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKJCkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfKJCk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:40:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36EAB215EA;
        Sun, 10 Nov 2019 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353626;
        bh=Skao6+giRM+BTw2RKzLY/18Rl/+xSoa8wM3mstDU30g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ja4vbyxDU1v5WBJ7GeClUfSZ/TXYGWwTJo4zKxulcF2K+vlPv9ixbxOkljKmjlfYc
         Us/bJ4KL2EO9JsKtSWCFisU0dZvgkmjQlUA2CsqlTHI4alD8DpXBuJXBGJN2n3mc2/
         w+drl0Agxt/0CxtyuoVIE6d/2Mq5uqW3ZOrdWLxQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 010/191] serial: uartps: Fix suspend functionality
Date:   Sat,  9 Nov 2019 21:37:12 -0500
Message-Id: <20191110024013.29782-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

[ Upstream commit 4b9d33c6a30688344a3e95179654ea31b07f59b7 ]

The driver's suspend/resume functions were buggy.
If UART node contains any child node in the DT and
the child is established a communication path with
the parent UART. The relevant /dev/ttyPS* node will
be not available for other operations.
If the driver is trying to do any operations like
suspend/resume without checking the tty->dev status
it leads to the kernel crash/hang.

This patch fix this issue by call the device_may_wake()
with the generic parameter of type struct device.
in the uart suspend and resume paths.

It also fixes a race condition in the uart suspend
path(i.e uart_suspend_port() should be called at the
end of cdns_uart_suspend API this path updates the same)

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c | 41 +++++++++---------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 77efa0a43fe76..66d49d5118853 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1279,24 +1279,11 @@ static struct uart_driver cdns_uart_uart_driver = {
 static int cdns_uart_suspend(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
-	struct tty_struct *tty;
-	struct device *tty_dev;
-	int may_wake = 0;
-
-	/* Get the tty which could be NULL so don't assume it's valid */
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		tty_dev = tty->dev;
-		may_wake = device_may_wakeup(tty_dev);
-		tty_kref_put(tty);
-	}
+	int may_wake;
 
-	/*
-	 * Call the API provided in serial_core.c file which handles
-	 * the suspend.
-	 */
-	uart_suspend_port(&cdns_uart_uart_driver, port);
-	if (!(console_suspend_enabled && !may_wake)) {
+	may_wake = device_may_wakeup(device);
+
+	if (console_suspend_enabled && may_wake) {
 		unsigned long flags = 0;
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -1311,7 +1298,11 @@ static int cdns_uart_suspend(struct device *device)
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
-	return 0;
+	/*
+	 * Call the API provided in serial_core.c file which handles
+	 * the suspend.
+	 */
+	return uart_suspend_port(&cdns_uart_uart_driver, port);
 }
 
 /**
@@ -1325,17 +1316,9 @@ static int cdns_uart_resume(struct device *device)
 	struct uart_port *port = dev_get_drvdata(device);
 	unsigned long flags = 0;
 	u32 ctrl_reg;
-	struct tty_struct *tty;
-	struct device *tty_dev;
-	int may_wake = 0;
-
-	/* Get the tty which could be NULL so don't assume it's valid */
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		tty_dev = tty->dev;
-		may_wake = device_may_wakeup(tty_dev);
-		tty_kref_put(tty);
-	}
+	int may_wake;
+
+	may_wake = device_may_wakeup(device);
 
 	if (console_suspend_enabled && !may_wake) {
 		struct cdns_uart *cdns_uart = port->private_data;
-- 
2.20.1

