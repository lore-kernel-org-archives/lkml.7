Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3020EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2B0206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZX166Pzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfDZQ4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:56:07 -0400
Received: from first.geanix.com ([116.203.34.67]:51464 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfDZQ4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:56:04 -0400
Received: from localhost (87-49-45-205-mobile.dk.customer.tdc.net [87.49.45.205])
        by first.geanix.com (Postfix) with ESMTPSA id 21F15308E6D;
        Fri, 26 Apr 2019 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556297691; bh=KApsgCwz8eGTOt/9YVGyS9qiTnm/rlcgthIl/A16h4g=;
        h=From:To:Cc:Subject:Date;
        b=ZX166PzvsbAYE7LQFvzn3IfI7kAf5bgtxydBGT6eavjvTJxTDc/Hok3UHmlhtFFcs
         Kj1ycFAgCMKcqt1m42tSiaSJhRGdZQ3kzkyEH8RUSiJCBkW8+pjvqA21Z+fzNE/oMa
         9fey6alyhVCAMfpyDVP8xeUgzPAUljsVZTA5CJuuLibuAUB7sVycN+J2tA9ghfEBin
         x5aAUIbRoGdDv6QZc7fHUXjlDpEecPTOKf6rkmoeN/NIRJlomGOIGnpiT+iiEjVG0D
         dulO/GaUSteeH0jS0X090p3dJwIKaZgNyoHhZKFU3YlHm/O11kOYL9g+TJ9s9ksGDN
         g5dPS/+4GG2CA==
From:   Esben Haabendal <esben@geanix.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD function
Date:   Fri, 26 Apr 2019 18:55:54 +0200
Message-Id: <20190426165559.2656-1-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
to an MFD driver.

When calling mfd_add_device(), platform_data should be a pointer to a
struct plat_serial8250_port, with proper settings like .flags, .type,
.iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
passed as cell resources.

Do not include UPF_BOOT_AUTOCONF in platform_data.flags.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/8250/8250_mfd.c | 119 +++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |  12 ++++
 drivers/tty/serial/8250/Makefile   |   1 +
 3 files changed, 132 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_mfd.c

diff --git a/drivers/tty/serial/8250/8250_mfd.c b/drivers/tty/serial/8250/8250_mfd.c
new file mode 100644
index 0000000..eae1566
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_mfd.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Serial Port driver for 8250/16550-type MFD sub devices
+ *
+ *  This mimics the serial8250_probe of 8250_core.c, while allowing
+ *  use without UPF_BOOT_AUTOCONF, which is problematic for MFD, as
+ *  the request_mem_region() will typically fail as the region is
+ *  already requested by the MFD device.
+ *
+ *  Memory and irq are passed as platform resources, which allows easy
+ *  use together with (devm_)mfd_add_devices().
+ *
+ *  Other parameters are passed as struct plat_serial8250_port in
+ *  device platform_data.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/serial_8250.h>
+
+struct serial8250_mfd_data {
+	int			line;
+};
+
+static int serial8250_mfd_probe(struct platform_device *pdev)
+{
+	struct plat_serial8250_port *pdata = dev_get_platdata(&pdev->dev);
+	struct serial8250_mfd_data *data;
+	struct uart_8250_port up;
+	struct resource *r;
+	void __iomem *membase;
+
+	if (!pdata)
+		return -ENODEV;
+
+	memset(&up, 0, sizeof(up));
+
+	switch (pdata->iotype) {
+	case UPIO_AU:
+	case UPIO_TSI:
+	case UPIO_MEM32:
+	case UPIO_MEM32BE:
+	case UPIO_MEM16:
+	case UPIO_MEM:
+		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!r)
+			return -ENODEV;
+		membase = devm_ioremap_nocache(&pdev->dev,
+					       r->start, resource_size(r));
+		if (!membase)
+			return -ENOMEM;
+		up.port.mapbase = r->start;
+		up.port.membase = membase;
+		break;
+	case UPIO_HUB6:
+	case UPIO_PORT:
+		r = platform_get_resource(pdev, IORESOURCE_IO, 0);
+		if (!r)
+			return -ENODEV;
+		up.port.iobase = r->start;
+		break;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	up.port.irq = platform_get_irq(pdev, 0);
+	if (up.port.irq < 0)
+		up.port.irq = 0; /* no interrupt -> use polling */
+
+	/* Register with 8250_core.c */
+	up.port.irqflags = pdata->irqflags;
+	up.port.uartclk = pdata->uartclk;
+	up.port.regshift = pdata->regshift;
+	up.port.iotype = pdata->iotype;
+	up.port.flags = pdata->flags;
+	up.port.hub6 = pdata->hub6;
+	up.port.private_data = pdata->private_data;
+	up.port.type = pdata->type;
+	up.port.serial_in = pdata->serial_in;
+	up.port.serial_out = pdata->serial_out;
+	up.port.handle_irq = pdata->handle_irq;
+	up.port.handle_break = pdata->handle_break;
+	up.port.set_termios = pdata->set_termios;
+	up.port.set_ldisc = pdata->set_ldisc;
+	up.port.get_mctrl = pdata->get_mctrl;
+	up.port.pm = pdata->pm;
+	up.port.dev = &pdev->dev;
+	data->line = __serial8250_register_8250_port(&up, 0);
+	if (data->line < 0)
+		return data->line;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+}
+
+static int serial8250_mfd_remove(struct platform_device *pdev)
+{
+	struct serial8250_mfd_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	return 0;
+}
+
+static struct platform_driver serial8250_mfd_driver = {
+	.probe = serial8250_mfd_probe,
+	.remove = serial8250_mfd_remove,
+	.driver = {
+		.name = "serial8250-mfd",
+	},
+};
+
+module_platform_driver(serial8250_mfd_driver);
+
+MODULE_AUTHOR("Esben Haabendal <esben@geanix.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for 8250/16550-type MFD sub devices");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c54..ef1572b 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -58,6 +58,18 @@ config SERIAL_8250_PNP
 	  This builds standard PNP serial support. You may be able to
 	  disable this feature if you only need legacy serial support.
 
+config SERIAL_8250_MFD
+	bool "8250/16550 MFD function support"
+	depends on SERIAL_8250 && MFD_CORE
+	default n
+	help
+	  This builds support for using 8250/16550-type UARTs as MFD
+	  functions.
+
+	  MFD drivers needing this should select it automatically.
+
+	  If unsure, say N.
+
 config SERIAL_8250_FINTEK
 	bool "Support for Fintek F81216A LPC to 4 UART RS485 API"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 18751bc..da8e139 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250-y					:= 8250_core.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
+8250-$(CONFIG_SERIAL_8250_MFD)		+= 8250_mfd.o
 8250_base-y				:= 8250_port.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
-- 
2.4.11

