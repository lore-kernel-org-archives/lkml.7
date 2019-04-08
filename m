Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A5BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87B12147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfDHOVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:21:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfDHOVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:21:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77926B011;
        Mon,  8 Apr 2019 14:21:27 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 5/6] tty: serial: Add 8250-core base IOC3 driver
Date:   Mon,  8 Apr 2019 16:20:57 +0200
Message-Id: <20190408142100.27618-6-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190408142100.27618-1-tbogendoerfer@suse.de>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 8250 IOC3 platform driver for serial ports connected via
a SuperIO chip to a SGI IOC3 chip.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/tty/serial/8250/8250_ioc3.c | 98 +++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     | 11 +++++
 drivers/tty/serial/8250/Makefile    |  1 +
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_ioc3.c

diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
new file mode 100644
index 000000000000..4c405f1b9c67
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_ioc3.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SGI IOC3 8250 UART driver
+ *
+ * Copyright (C) 2019 Thomas Bogendoerfer <tbogendoerfer@suse.de>
+ *
+ * based on code Copyright (C) 2005 Stanislaw Skowronek <skylark@unaligned.org>
+ *               Copyright (C) 2014 Joshua Kinard <kumba@gentoo.org>
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "8250.h"
+
+#define IOC3_UARTCLK (22000000 / 3)
+
+struct ioc3_8250_data {
+	int line;
+};
+
+static unsigned int ioc3_serial_in(struct uart_port *p, int offset)
+{
+	return readb(p->membase + (offset ^ 3));
+}
+
+static void ioc3_serial_out(struct uart_port *p, int offset, int value)
+{
+	writeb(value, p->membase + (offset ^ 3));
+}
+
+static int serial8250_ioc3_probe(struct platform_device *pdev)
+{
+	struct ioc3_8250_data *data;
+	struct uart_8250_port up;
+	struct resource *r;
+	void __iomem *membase;
+	int irq, line;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	membase = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
+	if (!membase)
+		return -ENOMEM;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		irq = 0; /* no interrupt -> use polling */
+
+	/* Register serial ports with 8250.c */
+	memset(&up, 0, sizeof(struct uart_8250_port));
+	up.port.iotype = UPIO_MEM;
+	up.port.uartclk = IOC3_UARTCLK;
+	up.port.type = PORT_16550A;
+	up.port.irq = irq;
+	up.port.flags = (UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ);
+	up.port.dev = &pdev->dev;
+	up.port.membase = membase;
+	up.port.mapbase = r->start;
+	up.port.serial_in = ioc3_serial_in;
+	up.port.serial_out = ioc3_serial_out;
+	line = serial8250_register_8250_port(&up);
+	if (line < 0)
+		return line;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+}
+
+static int serial8250_ioc3_remove(struct platform_device *pdev)
+{
+	struct ioc3_8250_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	return 0;
+}
+
+static struct platform_driver serial8250_ioc3_driver = {
+	.probe  = serial8250_ioc3_probe,
+	.remove = serial8250_ioc3_remove,
+	.driver = {
+		.name = "ioc3-serial8250",
+	}
+};
+
+module_platform_driver(serial8250_ioc3_driver);
+
+MODULE_AUTHOR("Thomas Bogendoerfer <tbogendoerfer@suse.de>");
+MODULE_DESCRIPTION("SGI IOC3 8250 UART driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..9d24615aabfb 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -364,6 +364,17 @@ config SERIAL_8250_EM
 	  port hardware found on the Emma Mobile line of processors.
 	  If unsure, say N.
 
+config SERIAL_8250_IOC3
+	tristate "SGI IOC3 8250 UART support"
+	depends on SGI_MFD_IOC3 && SERIAL_8250
+	select SERIAL_8250_EXTENDED
+	select SERIAL_8250_SHARE_IRQ
+	help
+	  Enable this if you have a SGI Origin or Octane machine. This module
+	  provides basic serial support by directly driving the UART chip
+	  behind the IOC3 device on those systems.  Maximum baud speed is
+	  38400bps using this driver.
+
 config SERIAL_8250_RT288X
 	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 18751bc63a84..79f74b4d57e5 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
+obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
 obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
 obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
 obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
-- 
2.13.7

