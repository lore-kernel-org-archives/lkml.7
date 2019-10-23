Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BFCCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8D120684
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="pnKXocl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404114AbfJWJre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:47:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37288 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404105AbfJWJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id g21so14407636lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LcvcC/pOcUbiXyDv4lNPdIPMzyGdp7SyLZu2/xHV+ag=;
        b=pnKXocl8uPpsCUsHEhT/TSYXMCdFakxAMMu0xcd2vn1u+WVz48JqNeMWTT3E1zQzS3
         VLFzNfv1rCXTeJ/zqGIhjAZUtqJf9brdUYD4K2TArbCC7Ve34DzapwEVmfa+eKmC3a2R
         3fl9EeEMYHzwzudS9agqxD1Pwo8VnEzgIbUb8EE/uGRjfQgI3V4LM9F0fn83AbDEq1if
         wcBaXMQ9pTe2kTxDC2CI2PNSgteJfTRxsQqVuQ9vVeFD8YEJKvDzVaEaVWWKH09saS7d
         YWmaZmwOITH6Q28RxQhYG408wGt4Gd1lkzYsNch0eaEuLlK6SVqTxRxhVbkYgthfa7yj
         YOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LcvcC/pOcUbiXyDv4lNPdIPMzyGdp7SyLZu2/xHV+ag=;
        b=n1MvhIuSN87r8mQ39lFx/Ixl+yG87yVvidhmfLTks40K5zP5qaGbgmR9XHdp7sQdef
         ouB+XWPEQfEDE6vR2cJOvEEMLfaAbs27jvE6qfDOs5ymmTBiOorWpAqdbvt3vhqCmyE1
         92Dpk/8WfzBP1hJnZccDK9JQxOLpFmxxQr3CKEMEwP4aynkn/fhB0dGDYV4bh/qQL/rE
         whvcpCQ7M/rQhw/96fjdgQg4PzgBwE5DIp60jLGNb+wntAmzn6NOA6VS5VgkCTXzHYFz
         K/d4LwJeipvhASqNnsRpozZkBoi3K/QhEl8FVYHvrKzaZ6FHYmGicT1HxiGqsWYDTwHc
         DMYw==
X-Gm-Message-State: APjAAAUa2jGeEQDGD2UMtAMDOPCnU+xtT6FcHSVtickwafabuwFOd5lT
        Hn2hVZ59dDv3m58ac30DmP5VDg==
X-Google-Smtp-Source: APXvYqybgAgbt4qsEScBEr37f5ZJfalQ8SWG0WuRSqb/rGsRO9dj181yGKXOWC27EmePcjZk/qlD3g==
X-Received: by 2002:ac2:4566:: with SMTP id k6mr21237900lfm.132.1571824049130;
        Wed, 23 Oct 2019 02:47:29 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id 90sm3184675ljc.0.2019.10.23.02.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:47:28 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:47:23 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drivers/tty/serial: add LiteUART driver
Message-ID: <20191023114634.13657-4-mholenko@antmicro.com>
References: <20191023114634.13657-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-0-mholenko@antmicro.com>
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
Changes in v2:
- used register access functions from newly introduced litex.h
- patch number changed from 3 to 4

 MAINTAINERS                      |   1 +
 drivers/tty/serial/Kconfig       |  30 +++
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/liteuart.c    | 373 +++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 5 files changed, 408 insertions(+)
 create mode 100644 drivers/tty/serial/liteuart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1dc783c9edb7..c24a37833e78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9499,6 +9499,7 @@ M:	Mateusz Holenko <mholenko@antmicro.com>
 S:	Maintained
 F:	include/linux/litex.h
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
+F:	drivers/tty/serial/liteuart.c
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4789b5d62f63..b01fe12a1411 100644
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
index 863f47056539..c8d7e2046284 100644
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
index 000000000000..e142f78df57a
--- /dev/null
+++ b/drivers/tty/serial/liteuart.c
@@ -0,0 +1,373 @@
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
+#include <linux/litex.h>
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
+	unsigned char __iomem *membase = port->membase;
+	unsigned int flg = TTY_NORMAL;
+	int ch;
+	unsigned int status;
+
+	while ((status = !LITEX_READ_REG_OFF(membase, OFF_RXEMPTY)) == 1) {
+		ch = LITEX_READ_REG_OFF(membase, OFF_RXTX);
+		port->icount.rx++;
+
+		/* necessary for RXEMPTY to refresh its value */
+		LITEX_WRITE_REG_OFF(EV_TX | EV_RX, membase, OFF_EV_PENDING);
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
+	while (LITEX_READ_REG_OFF(port->membase, OFF_TXFULL))
+		cpu_relax();
+
+	LITEX_WRITE_REG_OFF(ch, port->membase, OFF_RXTX);
+}
+
+static unsigned int liteuart_tx_empty(struct uart_port *port)
+{
+	/* not really tx empty, just checking if tx is not full */
+	if (!LITEX_READ_REG_OFF(port->membase, OFF_TXFULL))
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
+		LITEX_WRITE_REG_OFF(port->x_char, port->membase, OFF_RXTX);
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
+	LITEX_WRITE_REG_OFF(0, port->membase, OFF_EV_ENABLE);
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
index 0f4f87a6fd54..8fe6b0bf8014 100644
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

