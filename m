Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1469C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EE72465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576743611;
	bh=ep6dfch26/sju6OYnNCOEEdN1gdMsvc07IzfLFpfFE0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=a2SD3A9eeZTAAYei61jteu33iu5hcPR6iYLyi4o5cIwtCu4PWtZOdUFfBn5VLUJ+b
	 Uhvl+d/qiKmPn9xX2sIX4EVJNWDC/Y9HYGD2TQ02ld+7EUDBDb/MMq7h0L52cUm5yP
	 wLg29pceHRymzVPrZrfrS2H4dqWUBSxByo+pLGR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfLSIUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfLSIUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:20:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A4D227BF;
        Thu, 19 Dec 2019 08:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576743609;
        bh=ep6dfch26/sju6OYnNCOEEdN1gdMsvc07IzfLFpfFE0=;
        h=Date:From:To:Cc:Subject:From;
        b=zvvebl13loZZzfUrtPdbyzYc03Rrn5bAspkQpza+mt3yHza7Xgc6rsCqyvukJ3e8m
         wn90fwt7X7/A9UceN/T0eJywb50n0s/2iVa8C2qI//28HzUEkgCNZmrkQ02Ho0h7eI
         3Jx1yVdR9ZFotii7WsD6TjyRJSYYxpVjZ0flNk4M=
Date:   Thu, 19 Dec 2019 09:20:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] tty: serial: 21285: stop using the unused[] variable from
 struct uart_port
Message-ID: <20191219082006.GA1001454@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Much like the samsung_tty driver (now I know where they copied the idea
from), the 21285 uart driver uses 2 bytes from the "unused" array of
struct uart_port to keep tx/rx enabled/disabled state.  Those fields are
going away (they were never really needed in the first place), so fix up
the 21285 driver by another horrible hack.

Instead of creating a whole structure for just 2 bytes, just use two
bits from the private_data pointer instead, as that pointer is never
used.  The two bits reflect if tx/rx is now enabled/disabled.

Astute readers will note that once rx is disabled, nothing ever seems to
turn it back on, making one wonder if anyone has ever done this.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/21285.c | 55 +++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 32b3acf8150a..b1615cd78182 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -41,8 +41,43 @@
 
 static const char serial21285_name[] = "Footbridge UART";
 
-#define tx_enabled(port)	((port)->unused[0])
-#define rx_enabled(port)	((port)->unused[1])
+/*
+ * We only need 2 bits of data, so instead of creating a whole structure for
+ * this, use bits of the private_data pointer of the uart port structure.
+ */
+#define tx_enabled_bit	0
+#define rx_enabled_bit	1
+
+static bool is_enabled(struct uart_port *port, int bit)
+{
+	unsigned long private_data = (unsigned long)port->private_data;
+
+	if (test_bit(bit, &private_data))
+		return true;
+	return false;
+}
+
+static void enable(struct uart_port *port, int bit)
+{
+	unsigned long private_data = (unsigned long)port->private_data;
+
+	set_bit(bit, &private_data);
+}
+
+static void disable(struct uart_port *port, int bit)
+{
+	unsigned long private_data = (unsigned long)port->private_data;
+
+	set_bit(bit, &private_data);
+}
+
+#define is_tx_enabled(port)	is_enabled(port, tx_enabled_bit)
+#define tx_enable(port)		enable(port, tx_enabled_bit)
+#define tx_disable(port)	disable(port, tx_enabled_bit)
+
+#define is_rx_enabled(port)	is_enabled(port, rx_enabled_bit)
+#define rx_enable(port)		enable(port, rx_enabled_bit)
+#define rx_disable(port)	disable(port, rx_enabled_bit)
 
 /*
  * The documented expression for selecting the divisor is:
@@ -57,25 +92,25 @@ static const char serial21285_name[] = "Footbridge UART";
 
 static void serial21285_stop_tx(struct uart_port *port)
 {
-	if (tx_enabled(port)) {
+	if (is_tx_enabled(port)) {
 		disable_irq_nosync(IRQ_CONTX);
-		tx_enabled(port) = 0;
+		tx_disable(port);
 	}
 }
 
 static void serial21285_start_tx(struct uart_port *port)
 {
-	if (!tx_enabled(port)) {
+	if (!is_tx_enabled(port)) {
 		enable_irq(IRQ_CONTX);
-		tx_enabled(port) = 1;
+		tx_enable(port);
 	}
 }
 
 static void serial21285_stop_rx(struct uart_port *port)
 {
-	if (rx_enabled(port)) {
+	if (is_rx_enabled(port)) {
 		disable_irq_nosync(IRQ_CONRX);
-		rx_enabled(port) = 0;
+		rx_disable(port);
 	}
 }
 
@@ -185,8 +220,8 @@ static int serial21285_startup(struct uart_port *port)
 {
 	int ret;
 
-	tx_enabled(port) = 1;
-	rx_enabled(port) = 1;
+	tx_enable(port);
+	rx_enable(port);
 
 	ret = request_irq(IRQ_CONRX, serial21285_rx_chars, 0,
 			  serial21285_name, port);
-- 
2.24.1

