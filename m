Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE87C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CB72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfDOU2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:28:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:28:11 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N2lv2-1gqaYG3eI8-0133p3; Mon, 15 Apr 2019 22:28:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARM: ks8695, serial: skip manual tx IRQ ack
Date:   Mon, 15 Apr 2019 22:24:17 +0200
Message-Id: <20190415202501.941196-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
References: <20190415202501.941196-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fEwh5/IPHWOscGE54ScL7hGHn8WgdBcrjrH0vEu6XJJU5jU6x09
 arQS3T+kqphfbWD9RyZq5xcWC84Df5vj/PtVzPPnjiSxR5RFTFivpoQJgGj5I7To3nszDES
 fje9eP5M3lRHm3MGKMIZUyuc3C4x5WPcQoc0AcAQfGQoQIq5h5Z4ByzsEqBxwhM62vwfLTt
 E5G2O2HjGZYXtHPGu41KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XEW0CJHj1Lw=:QOVt6hMFCo3Y1RyVLtmzuO
 r8RtNtuy7qnoXWN5A0UEl8mVlahrAxQnSDV7+3NifjLNIZUsvPmtU8IY2N2eQPfmWQoLBgjKx
 G+sCfNF7c0kDsUnmwvVluee0ScFzuXXQWXMhb6fGHe/7IVhDVoZo1SEPCv7w8xOTGfmVh+S6M
 VH8EHalWipmnbFmJfkOWS/OM+MeRogHYtXo7AcCZx6lOzHjG6OtYtQUNt48A8ksEJYAi4/4YR
 8zs2tcDC+2bVI11tQpgNBGe8HoJeMUvZI6szzFs7KUBXy7KwDk09BH1g/Xgg8/lNsgk1ql9y2
 AzZRCQ3H+UBIvE9T6QFUCLactN/7aBsN/Gmlvg5GXXpWfmiOtDh+GTFZUdNMP0JKl/S8xeeG+
 Fu57+dYEJi1bhbku3O8qRg2V8wG59Fo2yYSx8ZLcEpNhbXqkAqto+Xej6zG54pUqvFIhQOsg/
 UBZNrDSvtzowWaCEeFGlg2xRifCSrCL00mVudY++XHC4DsAFn6/Eq+04S+GCdz+MGkzN22qw+
 ztybp5fu0vgotxjgoTOgECC/KYX1x6KAFtIFKZu2o5WevOyo6ByRxkjo84obT2lWY8WheMftB
 mVDTB+qsOCZSP2WDtWPvRNXAUdLEhZtB+cntllFg1dQQn+HxoP9ijpvTKzVAAgfuq7cyoA6Ef
 oXHyyWoGbXFp36Y6vfWkjkefOOQ9P/KbCTSjmL2V9LiGrY1y7k4F6KmBGZ/lMe/gnsl/9sGZn
 8cSaMQEkDxQFLS51y30UyGraIplEtq6123J2eg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TX interrupt is marked as edge triggered, so it will
already be acked by the top-level irq code, and does not
need the ack in the driver.

Removing this avoids a nasty dependency on the regs-irq.h
file that is otherwise reserved for the interrupt controller
driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/serial_ks8695.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index b461d791188c..6c5e9900e69d 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -21,7 +21,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/regs-uart.h>
-#include <mach/regs-irq.h>
 
 #if defined(CONFIG_SERIAL_KS8695_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -52,8 +51,6 @@
 #define UART_GET_BRDR(p)	__raw_readl((p)->membase + KS8695_URBD)
 #define UART_PUT_BRDR(p, c)	__raw_writel((c), (p)->membase + KS8695_URBD)
 
-#define KS8695_CLR_TX_INT()	__raw_writel(1 << KS8695_IRQ_UART_TX, KS8695_IRQ_VA + KS8695_INTST)
-
 #define UART_DUMMY_LSR_RX	0x100
 #define UART_PORT_SIZE		(KS8695_USR - KS8695_URRB + 4)
 
@@ -207,7 +204,6 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
 	unsigned int count;
 
 	if (port->x_char) {
-		KS8695_CLR_TX_INT();
 		UART_PUT_CHAR(port, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
@@ -221,7 +217,6 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
 
 	count = 16;	/* fifo size */
 	while (!uart_circ_empty(xmit) && (count-- > 0)) {
-		KS8695_CLR_TX_INT();
 		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
 
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-- 
2.20.0

