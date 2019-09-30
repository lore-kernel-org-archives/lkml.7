Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B24C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E22E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="hKtMwoOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfI3NFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:05:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41271 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbfI3NFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:05:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id f5so9372328ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rDm4F6xAIBx7zS7Fh572W2b/u61hT6Bm5hatqQHHEW8=;
        b=hKtMwoOvgHHMcWURpw4e2C1KnDJLxU3ZuST+2T4RFRZqQrjtYiOD28zTjB2AYg493w
         rLckRorA1tJl+S+Rp/lqpyRvcNXp80FFS3v8zYspyg5PflPbkhjqAIGpvdBGpQfe1TIe
         hc/c4US7feJGxh1V+atKujgBn8kFBVwD65CY4KT6K7T20qWqXBu40U4HwvqfT88Qc/Kw
         3CcpPl5myeN6iMk2EXd7fjdb0hUbfxfD34EXhW1DAcLy2i/xB6cO55kwKbZzgGgCuK+x
         j7018SjTJj4lcl9hZ9bCpFylGyJ4b1MdW8Sj4weWoaiURMAJuRUth0gIC5eJj6B9E0da
         vQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rDm4F6xAIBx7zS7Fh572W2b/u61hT6Bm5hatqQHHEW8=;
        b=B4z28/xS31iWDHB/9yvAuZNhoVj8torFGIzYGWoBZEuJPx7HmaYtKMmFNjs2ZPQsYP
         nBbtAOL5slsnAgt1Ev3B/iHYj1DeU7kH1p+5dlmz/z2aiTq8FqzEeU9ZvpUnYAEOgWGr
         S+glFQdlCE/rptkHH66y3ZJ0xwb7rbfIjSTSUPhLXINHFCTfZ8tu30Y43vAw+Gs7o8fZ
         yw+IC8SNvtVTTocu6aRVyJRZO1l0Izfo9YdTcOlcZYZzXsTAj4CaouAR/w3A6X2KxDmY
         uMQVWPKoj6AqB8eNm/F9a9G3qB7OoSWseVSC+nzljY8uJkq8Xo5ic9Daj4NL5E39GWC/
         mxuA==
X-Gm-Message-State: APjAAAX6gqsMraahrlmoGkl/653QZET8t/s+TTmwlPzsW1Gfz9wLORLW
        LqHIdyBKyIY+gSwkwd8FQ8d0zA==
X-Google-Smtp-Source: APXvYqzyZg2wY6JU+RpcEolck9xKgbvNN2RGoGGtnyHfwJYe2itjG9HyYjJX4vBNv0wvJ5QdoCRWCQ==
X-Received: by 2002:a2e:63da:: with SMTP id s87mr11821448lje.79.1569848698591;
        Mon, 30 Sep 2019 06:04:58 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id z72sm3213822ljb.98.2019.09.30.06.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:04:57 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:04:52 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 3/3] drivers/tty/serial: add LiteUART driver
Message-ID: <20190930130452.GA9838@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

This commit adds driver for the FPGA-based LiteUART serial controller
from LiteX SoC builder.

The current implementation supports LiteUART configured
for 32 bit data width and 8 bit CSR bus width.

It does not support IRQ.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
 MAINTAINERS                      |   1 +
 drivers/tty/serial/Kconfig       |  30 +++
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/liteuart.c    | 382 +++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 5 files changed, 417 insertions(+)
 create mode 100644 drivers/tty/serial/liteuart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 65a6cf296..d108b6044 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9467,6 +9467,7 @@ M:	Karol Gugala <kgugala@antmicro.com>
 M:	Mateusz Holenko <mholenko@antmicro.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/litex,liteuart.txt
+F:	drivers/tty/serial/liteuart.c
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4789b5d62..b01fe12a1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1571,6 +1571,36 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  receives all kernel messages and warnings and which allows logins in
 	  single user mode).
 
+config SERIAL_LITEUART
+	tristate "LiteUART serial port support"
+	depends on HAS_IOMEM
+	depends on OF
+	select SERIAL_CORE
+	help
+	  This driver is for the FPGA-based LiteUART serial controller from LiteX
+	  SoC builder.
+
+	  Say 'Y' here if you wish to use the LiteUART serial controller.
+	  Otherwise, say 'N'.
+
+config SERIAL_LITEUART_NR_PORTS
+	int "Number of LiteUART ports"
+	depends on SERIAL_LITEUART
+	default "1"
+	help
+	  Set this to the number of serial ports you want the driver
+	  to support.
+
+config SERIAL_LITEUART_CONSOLE
+	bool "LiteUART serial port console support"
+	depends on SERIAL_LITEUART=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say 'Y' here if you wish to use the FPGA-based LiteUART serial controller
+	  from LiteX SoC builder as the system console (the system console is the
+	  device which receives all kernel messages and warnings and which allows
+	  logins in single user mode). Otherwise, say 'N'.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 863f47056..c8d7e2046 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
 obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
+obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
new file mode 100644
index 000000000..4c4eaa73f
--- /dev/null
+++ b/drivers/tty/serial/liteuart.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LiteUART serial controller (LiteX) Driver
+ *
+ * Copyright (C) 2019 Antmicro Ltd <www.antmicro.com>
+ */
+
+#include <linux/console.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/timer.h>
+#include <linux/tty_flip.h>
+
+/* module-related defines */
+#define DRIVER_NAME	"liteuart"
+#define DRIVER_MAJOR	0
+#define DRIVER_MINOR	0
+#define DEV_NAME	"ttyLXU"
+
+/* base address offsets */
+#define OFF_RXTX	0x00
+#define OFF_TXFULL	0x04
+#define OFF_RXEMPTY	0x08
+#define OFF_EV_STATUS	0x0c
+#define OFF_EV_PENDING	0x10
+#define OFF_EV_ENABLE	0x14
+
+/* events */
+#define EV_TX	0x1
+#define EV_RX	0x2
+
+/* setting/getting registers */
+#ifdef __LITTLE_ENDIAN
+# define PORT_REG_SET(port, off, val)	iowrite32(val, port->membase + \
+		OFF_##off)
+# define PORT_REG_GET(port, off)	ioread32(port->membase + OFF_##off)
+#else
+# define PORT_REG_SET(port, off, val)	iowrite32be(val, port->membase + \
+		OFF_##off)
+# define PORT_REG_GET(port, off)	ioread32be(port->membase + OFF_##off)
+#endif
+
+struct liteuart_port {
+	struct uart_port port;
+	struct timer_list timer;
+};
+
+#define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
+
+static struct liteuart_port liteuart_ports[CONFIG_SERIAL_LITEUART_NR_PORTS];
+
+#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
+static struct console liteuart_console;
+#endif
+
+static struct uart_driver liteuart_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = DRIVER_NAME,
+	.dev_name = DEV_NAME,
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+	.nr = CONFIG_SERIAL_LITEUART_NR_PORTS,
+#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
+	.cons = &liteuart_console,
+#endif
+};
+
+static void liteuart_timer(struct timer_list *t)
+{
+	struct liteuart_port *uart = from_timer(uart, t, timer);
+	struct uart_port *port = &uart->port;
+	unsigned int flg = TTY_NORMAL;
+	int ch;
+	unsigned int status;
+
+	while ((status = !PORT_REG_GET(port, RXEMPTY)) == 1) {
+		ch = PORT_REG_GET(port, RXTX);
+		port->icount.rx++;
+
+		/* necessary for RXEMPTY to refresh its value */
+		PORT_REG_SET(port, EV_PENDING, EV_TX | EV_RX);
+
+		/* no overflow bits in status */
+		if (!(uart_handle_sysrq_char(port, ch)))
+			uart_insert_char(port, status, 0, ch, flg);
+
+		tty_flip_buffer_push(&port->state->port);
+	}
+
+	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+}
+
+static void liteuart_putchar(struct uart_port *port, int ch)
+{
+	while (PORT_REG_GET(port, TXFULL))
+		cpu_relax();
+
+	PORT_REG_SET(port, RXTX, ch);
+}
+
+static unsigned int liteuart_tx_empty(struct uart_port *port)
+{
+	/* not really tx empty, just checking if tx is not full */
+	if (!PORT_REG_GET(port, TXFULL))
+		return TIOCSER_TEMT;
+
+	return 0;
+}
+
+static void liteuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* modem control register is not present in LiteUART */
+}
+
+static unsigned int liteuart_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+}
+
+static void liteuart_stop_tx(struct uart_port *port)
+{
+}
+
+static void liteuart_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned char ch;
+
+	if (unlikely(port->x_char)) {
+		PORT_REG_SET(port, RXTX, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+	} else if (!uart_circ_empty(xmit)) {
+		while (xmit->head != xmit->tail) {
+			ch = xmit->buf[xmit->tail];
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			port->icount.tx++;
+			liteuart_putchar(port, ch);
+		}
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static void liteuart_stop_rx(struct uart_port *port)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	/* just delete timer */
+	del_timer(&uart->timer);
+}
+
+static void liteuart_break_ctl(struct uart_port *port, int break_state)
+{
+	/* LiteUART doesn't support sending break signal */
+}
+
+static int liteuart_startup(struct uart_port *port)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	/* disable events */
+	PORT_REG_SET(port, EV_ENABLE, 0);
+
+	/* prepare timer for polling */
+	timer_setup(&uart->timer, liteuart_timer, 0);
+	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+
+	return 0;
+}
+
+static void liteuart_shutdown(struct uart_port *port)
+{
+}
+
+static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
+				 struct ktermios *old)
+{
+	unsigned int baud;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* update baudrate */
+	baud = uart_get_baud_rate(port, new, old, 0, 460800);
+	uart_update_timeout(port, new->c_cflag, baud);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *liteuart_type(struct uart_port *port)
+{
+	return (port->type == PORT_LITEUART) ? DRIVER_NAME : NULL;
+}
+
+static void liteuart_release_port(struct uart_port *port)
+{
+}
+
+static int liteuart_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void liteuart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type = PORT_LITEUART;
+}
+
+static int liteuart_verify_port(struct uart_port *port,
+				struct serial_struct *ser)
+{
+	if (port->type != PORT_UNKNOWN && ser->type != PORT_LITEUART)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct uart_ops liteuart_ops = {
+	.tx_empty	= liteuart_tx_empty,
+	.set_mctrl	= liteuart_set_mctrl,
+	.get_mctrl	= liteuart_get_mctrl,
+	.stop_tx	= liteuart_stop_tx,
+	.start_tx	= liteuart_start_tx,
+	.stop_rx	= liteuart_stop_rx,
+	.break_ctl	= liteuart_break_ctl,
+	.startup	= liteuart_startup,
+	.shutdown	= liteuart_shutdown,
+	.set_termios	= liteuart_set_termios,
+	.type		= liteuart_type,
+	.release_port	= liteuart_release_port,
+	.request_port	= liteuart_request_port,
+	.config_port	= liteuart_config_port,
+	.verify_port	= liteuart_verify_port,
+};
+
+static int liteuart_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct liteuart_port *uart;
+	struct uart_port *port;
+	int dev_id;
+
+	/* no device tree */
+	if (!np)
+		return -ENODEV;
+
+	dev_id = of_alias_get_id(np, "serial");
+	if (dev_id < 0 || dev_id >= CONFIG_SERIAL_LITEUART_NR_PORTS)
+		return -EINVAL;
+
+	uart = &liteuart_ports[dev_id];
+	port = &uart->port;
+
+	/* get {map,mem}base */
+	port->mapbase = platform_get_resource(pdev, IORESOURCE_MEM, 0)->start;
+	port->membase = of_iomap(np, 0);
+	if (!port->membase)
+		return -ENXIO;
+
+	/* values not from device tree */
+	port->dev = &pdev->dev;
+	port->iotype = UPIO_MEM;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->ops = &liteuart_ops;
+	port->regshift = 2;
+	port->fifosize = 16;
+	port->iobase = 1;
+	port->type = PORT_UNKNOWN;
+	port->line = dev_id;
+
+	return uart_add_one_port(&liteuart_driver,
+				 &liteuart_ports[dev_id].port);
+}
+
+static int liteuart_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id liteuart_of_match[] = {
+	{ .compatible = "litex,liteuart" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, liteuart_of_match);
+
+static struct platform_driver liteuart_platform_driver = {
+	.probe = liteuart_probe,
+	.remove = liteuart_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(liteuart_of_match),
+	},
+};
+
+#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
+
+static void liteuart_console_write(struct console *co, const char *s,
+	unsigned int count)
+{
+	struct uart_port *port = &liteuart_ports[co->index].port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	uart_console_write(port, s, count, liteuart_putchar);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int liteuart_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	port = &liteuart_ports[co->index].port;
+	if (!port->membase)
+		return -ENODEV;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct console liteuart_console = {
+	.name = DRIVER_NAME,
+	.write = liteuart_console_write,
+	.device = uart_console_device,
+	.setup = liteuart_console_setup,
+	.flags = CON_PRINTBUFFER,
+	.index = -1,
+	.data = &liteuart_driver,
+};
+
+static int __init liteuart_console_init(void)
+{
+	register_console(&liteuart_console);
+
+	return 0;
+}
+
+console_initcall(liteuart_console_init);
+#endif /* CONFIG_SERIAL_LITEUART_CONSOLE */
+
+static int __init liteuart_init(void)
+{
+	int res;
+
+	res = uart_register_driver(&liteuart_driver);
+	if (res)
+		return res;
+
+	res = platform_driver_register(&liteuart_platform_driver);
+	if (res) {
+		uart_unregister_driver(&liteuart_driver);
+		return res;
+	}
+
+	return 0;
+}
+
+static void __exit liteuart_exit(void)
+{
+	platform_driver_unregister(&liteuart_platform_driver);
+	uart_unregister_driver(&liteuart_driver);
+}
+
+module_init(liteuart_init);
+module_exit(liteuart_exit);
+
+MODULE_AUTHOR("Antmicro Ltd <www.antmicro.com>");
+MODULE_DESCRIPTION("LiteUART serial driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 0f4f87a6f..8fe6b0bf8 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -293,4 +293,7 @@
 /* Freescale Linflex UART */
 #define PORT_LINFLEXUART	121
 
+/* LiteUART */
+#define PORT_LITEUART	122
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.23.0

