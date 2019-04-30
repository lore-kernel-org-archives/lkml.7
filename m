Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5013C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A332087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="XN4FjTyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfD3OEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:04:21 -0400
Received: from first.geanix.com ([116.203.34.67]:57656 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfD3OEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:04:21 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 66BC2308E86;
        Tue, 30 Apr 2019 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556633050; bh=Y2VPQSPuz/HYW2F4Zh+SwcM7NRCP5eYmV/nturgNG+w=;
        h=From:To:Cc:Subject:Date;
        b=XN4FjTyXs41/MiI4Cypba0gV+bP/hNqXIrh3S2ZwW8TEsnOfWL3ZwEc56Sm0PxpCw
         jWvJcfpCxFbi17eZnMnlDn9jbhuGxe5YicJFQMkLI5Wk+YbIJinGFLfUlu1zLLpFcW
         NfvbXxg7mIXkLhMNU2MOvyxqfq99AsZ2gdQoaluf7QM17b3kdquevzVYY43YtoIGnz
         O+IyMCrJyrEAIAXCxpd5xW4CrDK2nCjrQsweannBiD3Hhy+RpP9jwhYU8ZgyZLjxrb
         tLCNNGRkLsHNpbYDVymJKD/py50MUdWOCx3iHplEJXrfffii/ZqF0/m6DoyuwS7IOB
         H42EIDyu1ZaJg==
From:   Esben Haabendal <esben@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: Add support for using platform_device resources
Date:   Tue, 30 Apr 2019 16:04:13 +0200
Message-Id: <20190430140416.4707-1-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow getting memory resource (mapbase or iobase) as well as irq from
platform_device resources.

The UPF_DEV_RESOURCES flag must be set for devices where platform_device
resources are to be used.  When not set, driver behaves as before.

This allows use of the serial8250 driver together with devices with
resources added by platform_device_add_resources(), such as mfd child
devices added with mfd_add_devices().

Remaining platform_data fields (other than mapbase, iobase, mapsize and
irq) are used just as before.  Note

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/8250/8250_core.c | 56 +++++++++++++++++++++++++++++++++----
 drivers/tty/serial/8250/8250_port.c | 15 ++++++----
 include/linux/serial_core.h         |  1 +
 3 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e441221..9df6a98 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -788,6 +788,48 @@ void serial8250_resume_port(int line)
 }
 EXPORT_SYMBOL(serial8250_resume_port);
 
+static int serial8250_probe_resources(struct platform_device *pdev,
+				      unsigned int num,
+				      struct plat_serial8250_port *p,
+				      struct uart_8250_port *uart)
+{
+	struct resource *r;
+	int irq;
+
+	switch (p->iotype) {
+	case UPIO_AU:
+	case UPIO_TSI:
+	case UPIO_MEM32:
+	case UPIO_MEM32BE:
+	case UPIO_MEM16:
+	case UPIO_MEM:
+		r = platform_get_resource(pdev, IORESOURCE_MEM, num);
+		if (!r)
+			return -ENODEV;
+		uart->port.mapbase = r->start;
+		uart->port.mapsize = resource_size(r);
+		uart->port.flags |= UPF_IOREMAP;
+		break;
+	case UPIO_HUB6:
+	case UPIO_PORT:
+		r = platform_get_resource(pdev, IORESOURCE_IO, num);
+		if (!r)
+			return -ENODEV;
+		uart->port.iobase = r->start;
+		uart->port.mapsize = resource_size(r);
+		break;
+	}
+
+	irq = platform_get_irq(pdev, num);
+	if (irq == -ENXIO)
+		uart->port.irq = 0; /* no interrupt -> use polling */
+	else if (irq < 0)
+		return irq;
+	uart->port.irq = irq;
+
+	return 0;
+}
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -805,15 +847,19 @@ static int serial8250_probe(struct platform_device *dev)
 		irqflag = IRQF_SHARED;
 
 	for (i = 0; p && p->flags != 0; p++, i++) {
-		uart.port.iobase	= p->iobase;
-		uart.port.membase	= p->membase;
-		uart.port.irq		= p->irq;
+		uart.port.flags		= p->flags;
+		if (p->flags & UPF_DEV_RESOURCES) {
+			serial8250_probe_resources(dev, i, p, &uart);
+		} else {
+			uart.port.iobase	= p->iobase;
+			uart.port.mapbase	= p->mapbase;
+			uart.port.membase	= p->membase;
+			uart.port.irq		= p->irq;
+		}
 		uart.port.irqflags	= p->irqflags;
 		uart.port.uartclk	= p->uartclk;
 		uart.port.regshift	= p->regshift;
 		uart.port.iotype	= p->iotype;
-		uart.port.flags		= p->flags;
-		uart.port.mapbase	= p->mapbase;
 		uart.port.hub6		= p->hub6;
 		uart.port.private_data	= p->private_data;
 		uart.port.type		= p->type;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d2f3310..7fa1e49 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2863,7 +2863,8 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 		if (!port->mapbase)
 			break;
 
-		if (!request_mem_region(port->mapbase, size, "serial")) {
+		if (!(port->flags & UPF_DEV_RESOURCES) &&
+		    !request_mem_region(port->mapbase, size, "serial")) {
 			ret = -EBUSY;
 			break;
 		}
@@ -2871,7 +2872,8 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 		if (port->flags & UPF_IOREMAP) {
 			port->membase = ioremap_nocache(port->mapbase, size);
 			if (!port->membase) {
-				release_mem_region(port->mapbase, size);
+				if (!(port->flags & UPF_DEV_RESOURCES))
+					release_mem_region(port->mapbase, size);
 				ret = -ENOMEM;
 			}
 		}
@@ -2879,7 +2881,8 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 
 	case UPIO_HUB6:
 	case UPIO_PORT:
-		if (!request_region(port->iobase, size, "serial"))
+		if (!(port->flags & UPF_DEV_RESOURCES) &&
+		    !request_region(port->iobase, size, "serial"))
 			ret = -EBUSY;
 		break;
 	}
@@ -2906,12 +2909,14 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 			port->membase = NULL;
 		}
 
-		release_mem_region(port->mapbase, size);
+		if (!(port->flags & UPF_DEV_RESOURCES))
+			release_mem_region(port->mapbase, size);
 		break;
 
 	case UPIO_HUB6:
 	case UPIO_PORT:
-		release_region(port->iobase, size);
+		if (!(port->flags & UPF_DEV_RESOURCES))
+			release_region(port->iobase, size);
 		break;
 	}
 }
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5fe2b03..87b4ed3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -207,6 +207,7 @@ struct uart_port {
 #define UPF_BUGGY_UART		((__force upf_t) ASYNC_BUGGY_UART     /* 14 */ )
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) ASYNC_MAGIC_MULTIPLIER /* 16 */ )
 
+#define UPF_DEV_RESOURCES	((__force upf_t) (1 << 18))
 #define UPF_NO_THRE_TEST	((__force upf_t) (1 << 19))
 /* Port has hardware-assisted h/w flow control */
 #define UPF_AUTO_CTS		((__force upf_t) (1 << 20))
-- 
2.4.11

