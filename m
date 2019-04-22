Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC7F20643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963429;
	bh=p7DLkUNcQj6z2owi6qNZbpu2hBtOYk7Udeu4rvRoUVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LUyCVKOs2mWq/k+CbITIerlM441rUmfgKMczrfhIinWs19/BkKxZ+XzDqsxfC63nq
	 EFEAXq5J0lxDXf9eM1nLAYVL0D0io7l2yUpJKx4ldnwaAuqy8y3p3IdCvaqP6b7mHO
	 1e8NGlDeTfdq7Q49wof0Mi4pz4OIPT2zub5qJt0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfDVUDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbfDVTpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AACDE218B0;
        Mon, 22 Apr 2019 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962348;
        bh=p7DLkUNcQj6z2owi6qNZbpu2hBtOYk7Udeu4rvRoUVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvfOUUkvKzWsmHUsFlN67S6bv83j51iJWiayafH/uvUQNexXQkgC1+c+KqkEX3lke
         IJB6Y7bpCZCt6x73PxmE6W2lFkUTJHqy2agg2bpF6fZxssHMGdztbe61A7GvtabLAF
         nHlhBfy5iM+K8JZBf6lIsgTntr8C4Og1XX8F3ITk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrey Batyiev <batyiev@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/68] serial: ar933x_uart: Fix build failure with disabled console
Date:   Mon, 22 Apr 2019 15:44:25 -0400
Message-Id: <20190422194516.11634-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Štetiar <ynezz@true.cz>

[ Upstream commit 72ff51d8dd262d1fef25baedc2ac35116435be47 ]

Andrey has reported on OpenWrt's bug tracking system[1], that he
currently can't use ar93xx_uart as pure serial UART without console
(CONFIG_SERIAL_8250_CONSOLE and CONFIG_SERIAL_AR933X_CONSOLE undefined),
because compilation ends with following error:

 ar933x_uart.c: In function 'ar933x_uart_console_write':
 ar933x_uart.c:550:14: error: 'struct uart_port' has no
                               member named 'sysrq'

So this patch moves all the code related to console handling behind
series of CONFIG_SERIAL_AR933X_CONSOLE ifdefs.

1. https://bugs.openwrt.org/index.php?do=details&task_id=2152

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andrey Batyiev <batyiev@gmail.com>
Reported-by: Andrey Batyiev <batyiev@gmail.com>
Tested-by: Andrey Batyiev <batyiev@gmail.com>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/tty/serial/ar933x_uart.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index db5df3d54818..3bdd56a1021b 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -49,11 +49,6 @@ struct ar933x_uart_port {
 	struct clk		*clk;
 };
 
-static inline bool ar933x_uart_console_enabled(void)
-{
-	return IS_ENABLED(CONFIG_SERIAL_AR933X_CONSOLE);
-}
-
 static inline unsigned int ar933x_uart_read(struct ar933x_uart_port *up,
 					    int offset)
 {
@@ -508,6 +503,7 @@ static const struct uart_ops ar933x_uart_ops = {
 	.verify_port	= ar933x_uart_verify_port,
 };
 
+#ifdef CONFIG_SERIAL_AR933X_CONSOLE
 static struct ar933x_uart_port *
 ar933x_console_ports[CONFIG_SERIAL_AR933X_NR_UARTS];
 
@@ -604,14 +600,7 @@ static struct console ar933x_uart_console = {
 	.index		= -1,
 	.data		= &ar933x_uart_driver,
 };
-
-static void ar933x_uart_add_console_port(struct ar933x_uart_port *up)
-{
-	if (!ar933x_uart_console_enabled())
-		return;
-
-	ar933x_console_ports[up->port.line] = up;
-}
+#endif /* CONFIG_SERIAL_AR933X_CONSOLE */
 
 static struct uart_driver ar933x_uart_driver = {
 	.owner		= THIS_MODULE,
@@ -700,7 +689,9 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	baud = ar933x_uart_get_baud(port->uartclk, 0, AR933X_UART_MAX_STEP);
 	up->max_baud = min_t(unsigned int, baud, AR933X_UART_MAX_BAUD);
 
-	ar933x_uart_add_console_port(up);
+#ifdef CONFIG_SERIAL_AR933X_CONSOLE
+	ar933x_console_ports[up->port.line] = up;
+#endif
 
 	ret = uart_add_one_port(&ar933x_uart_driver, &up->port);
 	if (ret)
@@ -749,8 +740,9 @@ static int __init ar933x_uart_init(void)
 {
 	int ret;
 
-	if (ar933x_uart_console_enabled())
-		ar933x_uart_driver.cons = &ar933x_uart_console;
+#ifdef CONFIG_SERIAL_AR933X_CONSOLE
+	ar933x_uart_driver.cons = &ar933x_uart_console;
+#endif
 
 	ret = uart_register_driver(&ar933x_uart_driver);
 	if (ret)
-- 
2.19.1

