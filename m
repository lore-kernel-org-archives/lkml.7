Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD37C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F932147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUr58BId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfENKOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:14:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41822 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfENKOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so13739193lja.8;
        Tue, 14 May 2019 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CF3zUxT58FrI22dH2e8VkIScaME9jsEnqCoLXcGC50=;
        b=BUr58BIdfrb26hi1VznHTWRuNTvi6PE2HM/d43lB1/4mLrMjLQsJh0h4EajAa0wLvK
         W7gPUyAzH/kAtl78iqQr6puDgKqs2kteYoPBmP9j7Z7ozFE45hOf7xqcAAq6m/QvsdqC
         r3Dq8EE91W/Y0SdAXy13jCvQ7S2XMd405dw9WVn6wwdMXS/7M9+T4JyNCMUGXzrokQ7c
         KdlmlbBaEdEuF1441mKJlD53C+ObD+K6qSVWEvZ4cX/BVavJDNPsN7OJtw7Ogwo2LWBb
         ZJKdpj1mi1P2nPY16QYGVdKq+1EGfhyW7D8A8mBni+bMEa8hIM5z6HiKjbhp8I6Tl6Fm
         gmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CF3zUxT58FrI22dH2e8VkIScaME9jsEnqCoLXcGC50=;
        b=caAPVVIs2nQKHQ18LJ7AKXXmzY+C9Iy8aSwT6oeyIYzyYvAgYGZf7rryS2xS9J0sKG
         Gp1ETxOCiFfzSqh15Kwzgtayqm9dfilkHuPrYG7CXuzZnIYo8FrsyAl135slRAiO+1tM
         dW6cgaO4CAk2Ko/3yTd56AKbU5+ifmd+wU+u7oPXe7/aHo2QxEN2H/5WJv34heVeLDXW
         SXahQKKHlxejZ1xbLJaMm0jJ88uyTVNizELxNdWJk1VBe9MMQkC1n2gOfzXx1KvnZ9Lr
         gd/YpoSD8lY3dBNW+M3w4d5wqPrSGWXtR3IBW55OWW0x7UTQi4KtIrAsIxxtj41hboIS
         JdZw==
X-Gm-Message-State: APjAAAVvTv7X2JkKn8TN31k3EDGWNcNSSQyhc6c37SNh3k/9pozIBp4w
        Zpl0rdeeu7zgOsL+3fWuD/k=
X-Google-Smtp-Source: APXvYqwSVd6OkLCoa6TZGqISPUUOET/rwMPIIBMFxKzzi75QQFgeUI7iHRhG1dKdDCNBwDai7tW/PQ==
X-Received: by 2002:a2e:5d49:: with SMTP id r70mr17505169ljb.102.1557828873407;
        Tue, 14 May 2019 03:14:33 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id v2sm3126359ljg.6.2019.05.14.03.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:14:32 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] tty: max310x: Don't pass stacked buffers to SPI
Date:   Tue, 14 May 2019 13:14:11 +0300
Message-Id: <20190514101415.26754-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI transfer tx/rx buffers must be DMA-safe and the structure
documentation clearly states this. Data declared on the system stack isn't
DMA-safe [1]. Instead at least kernel memory should be used for the
buffers. In order to fix this here we can create the buffers at the device
probing stage and use them without any synchronization, since batch
read/write methods are called from non-reentrant contexts - either from
rx-event IRQ threaded handler or from the tx workqueue item.

[1] Documentation/DMA-API-HOWTO.txt

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 527f1476c24a..0e3dc89c459b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -258,6 +258,10 @@ struct max310x_one {
 	struct work_struct	tx_work;
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
+
+	u8 wr_header;
+	u8 rd_header;
+	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
 #define to_max310x_port(_port) \
 	container_of(_port, struct max310x_one, port)
@@ -608,11 +612,11 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
 {
-	u8 header[] = { (port->iobase + MAX310X_THR_REG) | MAX310X_WRITE_BIT };
+	struct max310x_one *one = to_max310x_port(port);
 	struct spi_transfer xfer[] = {
 		{
-			.tx_buf = &header,
-			.len = sizeof(header),
+			.tx_buf = &one->wr_header,
+			.len = sizeof(one->wr_header),
 		}, {
 			.tx_buf = txbuf,
 			.len = len,
@@ -623,11 +627,11 @@ static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
-	u8 header[] = { port->iobase + MAX310X_RHR_REG };
+	struct max310x_one *one = to_max310x_port(port);
 	struct spi_transfer xfer[] = {
 		{
-			.tx_buf = &header,
-			.len = sizeof(header),
+			.tx_buf = &one->rd_header,
+			.len = sizeof(one->rd_header),
 		}, {
 			.rx_buf = rxbuf,
 			.len = len,
@@ -638,8 +642,8 @@ static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int l
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int sts, ch, flag, i;
-	u8 buf[MAX310X_FIFO_SIZE];
 
 	if (port->read_status_mask == MAX310X_LSR_RXOVR_BIT) {
 		/* We are just reading, happily ignoring any error conditions.
@@ -654,7 +658,7 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 		 * */
 
 		sts = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
-		max310x_batch_read(port, buf, rxlen);
+		max310x_batch_read(port, one->rx_buf, rxlen);
 
 		port->icount.rx += rxlen;
 		flag = TTY_NORMAL;
@@ -666,7 +670,8 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 		}
 
 		for (i = 0; i < rxlen; ++i) {
-			uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT, buf[i], flag);
+			uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT,
+					 one->rx_buf[i], flag);
 		}
 
 	} else {
@@ -1298,6 +1303,10 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
+		/* Initialize SPI-transfer buffers */
+		s->p[i].wr_header = (s->p[i].port.iobase + MAX310X_THR_REG) |
+				    MAX310X_WRITE_BIT;
+		s->p[i].rd_header = (s->p[i].port.iobase + MAX310X_RHR_REG);
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
-- 
2.21.0

