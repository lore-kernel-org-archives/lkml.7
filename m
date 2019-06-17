Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D6EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A859B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfFQPAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:00:00 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:12478 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfFQPAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:00:00 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id CB126A2359;
        Mon, 17 Jun 2019 16:59:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id YJPs0wxOn2B5; Mon, 17 Jun 2019 16:59:54 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 2/3 v7] serial: 8250: Add MSR/MCR TIOCM conversion wrapper functions
Date:   Mon, 17 Jun 2019 16:59:51 +0200
Message-Id: <20190617145952.4848-2-sr@denx.de>
In-Reply-To: <20190617145952.4848-1-sr@denx.de>
References: <20190617145952.4848-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds wrapper functions to convert MSR <-> TIOCM and also
MCR <-> TIOCM. These functions are used now in serial8250_do_set_mctrl()
and serial8250_do_get_mctrl().

Signed-off-by: Stefan Roese <sr@denx.de>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
v7:
- No change

v6:
- New patch

 drivers/tty/serial/8250/8250.h      | 54 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 25 ++-----------
 2 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd5bef5..793da2e510e0 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -139,6 +139,60 @@ void serial8250_rpm_put_tx(struct uart_8250_port *p);
 int serial8250_em485_init(struct uart_8250_port *p);
 void serial8250_em485_destroy(struct uart_8250_port *p);
 
+/* MCR <-> TIOCM conversion */
+static inline int serial8250_TIOCM_to_MCR(int tiocm)
+{
+	int mcr = 0;
+
+	if (tiocm & TIOCM_RTS)
+		mcr |= UART_MCR_RTS;
+	if (tiocm & TIOCM_DTR)
+		mcr |= UART_MCR_DTR;
+	if (tiocm & TIOCM_OUT1)
+		mcr |= UART_MCR_OUT1;
+	if (tiocm & TIOCM_OUT2)
+		mcr |= UART_MCR_OUT2;
+	if (tiocm & TIOCM_LOOP)
+		mcr |= UART_MCR_LOOP;
+
+	return mcr;
+}
+
+static inline int serial8250_MCR_to_TIOCM(int mcr)
+{
+	int tiocm = 0;
+
+	if (mcr & UART_MCR_RTS)
+		tiocm |= TIOCM_RTS;
+	if (mcr & UART_MCR_DTR)
+		tiocm |= TIOCM_DTR;
+	if (mcr & UART_MCR_OUT1)
+		tiocm |= TIOCM_OUT1;
+	if (mcr & UART_MCR_OUT2)
+		tiocm |= TIOCM_OUT2;
+	if (mcr & UART_MCR_LOOP)
+		tiocm |= TIOCM_LOOP;
+
+	return tiocm;
+}
+
+/* MSR <-> TIOCM conversion */
+static inline int serial8250_MSR_to_TIOCM(int msr)
+{
+	int tiocm = 0;
+
+	if (msr & UART_MSR_DCD)
+		tiocm |= TIOCM_CAR;
+	if (msr & UART_MSR_RI)
+		tiocm |= TIOCM_RNG;
+	if (msr & UART_MSR_DSR)
+		tiocm |= TIOCM_DSR;
+	if (msr & UART_MSR_CTS)
+		tiocm |= TIOCM_CTS;
+
+	return tiocm;
+}
+
 static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
 {
 	serial_out(up, UART_MCR, value);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2304a84eee3b..47f0a8d01a57 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1944,22 +1944,12 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int status;
-	unsigned int ret;
 
 	serial8250_rpm_get(up);
 	status = serial8250_modem_status(up);
 	serial8250_rpm_put(up);
 
-	ret = 0;
-	if (status & UART_MSR_DCD)
-		ret |= TIOCM_CAR;
-	if (status & UART_MSR_RI)
-		ret |= TIOCM_RNG;
-	if (status & UART_MSR_DSR)
-		ret |= TIOCM_DSR;
-	if (status & UART_MSR_CTS)
-		ret |= TIOCM_CTS;
-	return ret;
+	return serial8250_MSR_to_TIOCM(status);
 }
 EXPORT_SYMBOL_GPL(serial8250_do_get_mctrl);
 
@@ -1973,18 +1963,9 @@ static unsigned int serial8250_get_mctrl(struct uart_port *port)
 void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned char mcr = 0;
+	unsigned char mcr;
 
-	if (mctrl & TIOCM_RTS)
-		mcr |= UART_MCR_RTS;
-	if (mctrl & TIOCM_DTR)
-		mcr |= UART_MCR_DTR;
-	if (mctrl & TIOCM_OUT1)
-		mcr |= UART_MCR_OUT1;
-	if (mctrl & TIOCM_OUT2)
-		mcr |= UART_MCR_OUT2;
-	if (mctrl & TIOCM_LOOP)
-		mcr |= UART_MCR_LOOP;
+	mcr = serial8250_TIOCM_to_MCR(mctrl);
 
 	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
 
-- 
2.22.0

