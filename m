Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59089C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057DC214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="h792JkW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfKGJeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:34:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33050 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:34:02 -0500
Received: by mail-io1-f65.google.com with SMTP id j13so1571727ioe.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ddi/Qylbfpp2oxofKrDUVCzp+G9XSLmFPLx6I0neCjE=;
        b=h792JkW4wS+F9sRz00e6rEBCaNgh5zdRZXusco5EFaVbIudMmSvqpYWSOK3nTAOAit
         PVem+1vuYKfyVNvPKgiJ2WIJgdpzKKWFY4EwgAk5cMosZrPfjnMHSZR0My6vhEZrKdbU
         DYm2QXmwB0FaY2fevtb28HMlkJi8P3uYVJZ9hDO/2CCWuHLg/FTAi0GB+Uzu23F3lDUd
         w3T6PmqXF+S7oQz20g09/lWN/VW6/61yXiReGvE4RiTHclC7aAng199Lp2emBFxY4rwb
         2/s0OM63lHOgAJG/uUrYAtNkYlcyyQHEG8Y5oWGTxIZGVZpB276Pk+zTT0qZmX2H3oAf
         96DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ddi/Qylbfpp2oxofKrDUVCzp+G9XSLmFPLx6I0neCjE=;
        b=P7v845jFYPcvIAMPs9t21rYgJy1WACrwXTmQpr+1kOcGTWvLf89/ZHQudm4Jxo34Dj
         CM0HVS/qfbcd2uN9C2gNkNSy0fAlOO1GmJD/F5DVwYHvpm81RpkLyGvHcid1r7y4eNNx
         pDtFZwQUjKTtG5IQo9GL+ERaIU4sKwOhrXh72/RvBi6gqJXveLwulWkzTZO2qXEtBUkN
         +RkqDNSwAoSB//dhiQzsX1ak6W6kUWJUCLEhQrGlw6Hh/l7fNkBtyN3mMUOICtpkv7Eb
         E2jVBksWWJb6Z6OUlBP4HRzBwChAFy8GocNqeyN7y9nI+bR5/bsAvjL00/23C8ll9w9n
         /s5Q==
X-Gm-Message-State: APjAAAXxeeXNBQRzFFQkQ049G0F6E9/dmribVyLHrjSTJ02dS2m5KeGZ
        n+GhbobRnOZY7DKqDvICAZH6sZwSaeU30+fz2/MOUA==
X-Google-Smtp-Source: APXvYqx1c+fH9XHcdSDx/OZj3G94jPGVRKobUSUaNqwMCxgEJ3lWsNxgyUcsDF0spunllk+DLBfXIXSntXQz/0V+t0E=
X-Received: by 2002:a05:6638:11a:: with SMTP id x26mr3094319jao.47.1573119241396;
 Thu, 07 Nov 2019 01:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20191023114634.13657-0-mholenko@antmicro.com> <20191023114634.13657-4-mholenko@antmicro.com>
 <20191026001331.GB10810@bogus>
In-Reply-To: <20191026001331.GB10810@bogus>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Thu, 7 Nov 2019 10:33:50 +0100
Message-ID: <CAPk366Q7PErGY2DqK0OsDfYXR5wNbDext7i_Zd_n=9G7p1n8FA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drivers/tty/serial: add LiteUART driver
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 26 pa=C5=BA 2019 o 02:13 Rob Herring <robh@kernel.org> napisa=C5=82(a=
):
>
> On Wed, Oct 23, 2019 at 11:47:23AM +0200, Mateusz Holenko wrote:
> > From: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> >
> > This commit adds driver for the FPGA-based LiteUART serial controller
> > from LiteX SoC builder.
> >
> > The current implementation supports LiteUART configured
> > for 32 bit data width and 8 bit CSR bus width.
> >
> > It does not support IRQ.
> >
> > Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > ---
> > Changes in v2:
> > - used register access functions from newly introduced litex.h
> > - patch number changed from 3 to 4
> >
> >  MAINTAINERS                      |   1 +
> >  drivers/tty/serial/Kconfig       |  30 +++
> >  drivers/tty/serial/Makefile      |   1 +
> >  drivers/tty/serial/liteuart.c    | 373 +++++++++++++++++++++++++++++++
> >  include/uapi/linux/serial_core.h |   3 +
> >  5 files changed, 408 insertions(+)
> >  create mode 100644 drivers/tty/serial/liteuart.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1dc783c9edb7..c24a37833e78 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9499,6 +9499,7 @@ M:      Mateusz Holenko <mholenko@antmicro.com>
> >  S:   Maintained
> >  F:   include/linux/litex.h
> >  F:   Documentation/devicetree/bindings/*/litex,*.yaml
> > +F:   drivers/tty/serial/liteuart.c
> >
> >  LIVE PATCHING
> >  M:   Josh Poimboeuf <jpoimboe@redhat.com>
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 4789b5d62f63..b01fe12a1411 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1571,6 +1571,36 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
> >         receives all kernel messages and warnings and which allows logi=
ns in
> >         single user mode).
> >
> > +config SERIAL_LITEUART
> > +     tristate "LiteUART serial port support"
> > +     depends on HAS_IOMEM
> > +     depends on OF
> > +     select SERIAL_CORE
> > +     help
> > +       This driver is for the FPGA-based LiteUART serial controller fr=
om LiteX
> > +       SoC builder.
> > +
> > +       Say 'Y' here if you wish to use the LiteUART serial controller.
> > +       Otherwise, say 'N'.
> > +
> > +config SERIAL_LITEUART_NR_PORTS
> > +     int "Number of LiteUART ports"
> > +     depends on SERIAL_LITEUART
> > +     default "1"
> > +     help
> > +       Set this to the number of serial ports you want the driver
> > +       to support.
>
> It's better if the driver supports a dynamic number of ports.

Do you mean that the number of ports should be taken from the device
tree when booting the kernel?
This is exactly how it works right now. The SERIAL_LITEUART_NR_PORTS just
defines the maximum number of supported ports.
I can rename the config to SERIAL_LITEUART_MAX_NR_PORTS to make it
clearer, what do you think?

> > +
> > +config SERIAL_LITEUART_CONSOLE
> > +     bool "LiteUART serial port console support"
> > +     depends on SERIAL_LITEUART=3Dy
> > +     select SERIAL_CORE_CONSOLE
> > +     help
> > +       Say 'Y' here if you wish to use the FPGA-based LiteUART serial =
controller
> > +       from LiteX SoC builder as the system console (the system consol=
e is the
> > +       device which receives all kernel messages and warnings and whic=
h allows
> > +       logins in single user mode). Otherwise, say 'N'.
> > +
> >  endmenu
> >
> >  config SERIAL_MCTRL_GPIO
> > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> > index 863f47056539..c8d7e2046284 100644
> > --- a/drivers/tty/serial/Makefile
> > +++ b/drivers/tty/serial/Makefile
> > @@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_OWL)    +=3D owl-uart.o
> >  obj-$(CONFIG_SERIAL_RDA)     +=3D rda-uart.o
> >  obj-$(CONFIG_SERIAL_MILBEAUT_USIO) +=3D milbeaut_usio.o
> >  obj-$(CONFIG_SERIAL_SIFIVE)  +=3D sifive.o
> > +obj-$(CONFIG_SERIAL_LITEUART) +=3D liteuart.o
> >
> >  # GPIOLIB helpers for modem control lines
> >  obj-$(CONFIG_SERIAL_MCTRL_GPIO)      +=3D serial_mctrl_gpio.o
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuar=
t.c
> > new file mode 100644
> > index 000000000000..e142f78df57a
> > --- /dev/null
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -0,0 +1,373 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * LiteUART serial controller (LiteX) Driver
> > + *
> > + * Copyright (C) 2019 Antmicro Ltd <www.antmicro.com>
> > + */
> > +
> > +#include <linux/console.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/serial.h>
> > +#include <linux/serial_core.h>
> > +#include <linux/timer.h>
> > +#include <linux/tty_flip.h>
> > +#include <linux/litex.h>
> > +
> > +/* module-related defines */
> > +#define DRIVER_NAME  "liteuart"
> > +#define DRIVER_MAJOR 0
> > +#define DRIVER_MINOR 0
> > +#define DEV_NAME     "ttyLXU"
> > +
> > +/* base address offsets */
> > +#define OFF_RXTX     0x00
> > +#define OFF_TXFULL   0x04
> > +#define OFF_RXEMPTY  0x08
> > +#define OFF_EV_STATUS        0x0c
> > +#define OFF_EV_PENDING       0x10
> > +#define OFF_EV_ENABLE        0x14
> > +
> > +/* events */
> > +#define EV_TX        0x1
> > +#define EV_RX        0x2
> > +
> > +struct liteuart_port {
> > +     struct uart_port port;
> > +     struct timer_list timer;
> > +};
> > +
> > +#define to_liteuart_port(port)       container_of(port, struct liteuar=
t_port, port)
> > +
> > +static struct liteuart_port liteuart_ports[CONFIG_SERIAL_LITEUART_NR_P=
ORTS];
> > +
> > +#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
> > +static struct console liteuart_console;
> > +#endif
> > +
> > +static struct uart_driver liteuart_driver =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .driver_name =3D DRIVER_NAME,
> > +     .dev_name =3D DEV_NAME,
> > +     .major =3D DRIVER_MAJOR,
> > +     .minor =3D DRIVER_MINOR,
> > +     .nr =3D CONFIG_SERIAL_LITEUART_NR_PORTS,
> > +#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
> > +     .cons =3D &liteuart_console,
> > +#endif
> > +};
> > +
> > +static void liteuart_timer(struct timer_list *t)
> > +{
> > +     struct liteuart_port *uart =3D from_timer(uart, t, timer);
> > +     struct uart_port *port =3D &uart->port;
> > +     unsigned char __iomem *membase =3D port->membase;
> > +     unsigned int flg =3D TTY_NORMAL;
> > +     int ch;
> > +     unsigned int status;
> > +
> > +     while ((status =3D !LITEX_READ_REG_OFF(membase, OFF_RXEMPTY)) =3D=
=3D 1) {
> > +             ch =3D LITEX_READ_REG_OFF(membase, OFF_RXTX);
> > +             port->icount.rx++;
> > +
> > +             /* necessary for RXEMPTY to refresh its value */
> > +             LITEX_WRITE_REG_OFF(EV_TX | EV_RX, membase, OFF_EV_PENDIN=
G);
> > +
> > +             /* no overflow bits in status */
> > +             if (!(uart_handle_sysrq_char(port, ch)))
> > +                     uart_insert_char(port, status, 0, ch, flg);
> > +
> > +             tty_flip_buffer_push(&port->state->port);
> > +     }
> > +
> > +     mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > +}
> > +
> > +static void liteuart_putchar(struct uart_port *port, int ch)
> > +{
> > +     while (LITEX_READ_REG_OFF(port->membase, OFF_TXFULL))
> > +             cpu_relax();
> > +
> > +     LITEX_WRITE_REG_OFF(ch, port->membase, OFF_RXTX);
> > +}
> > +
> > +static unsigned int liteuart_tx_empty(struct uart_port *port)
> > +{
> > +     /* not really tx empty, just checking if tx is not full */
> > +     if (!LITEX_READ_REG_OFF(port->membase, OFF_TXFULL))
> > +             return TIOCSER_TEMT;
> > +
> > +     return 0;
> > +}
> > +
> > +static void liteuart_set_mctrl(struct uart_port *port, unsigned int mc=
trl)
> > +{
> > +     /* modem control register is not present in LiteUART */
> > +}
> > +
> > +static unsigned int liteuart_get_mctrl(struct uart_port *port)
> > +{
> > +     return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> > +}
> > +
> > +static void liteuart_stop_tx(struct uart_port *port)
> > +{
> > +}
> > +
> > +static void liteuart_start_tx(struct uart_port *port)
> > +{
> > +     struct circ_buf *xmit =3D &port->state->xmit;
> > +     unsigned char ch;
> > +
> > +     if (unlikely(port->x_char)) {
> > +             LITEX_WRITE_REG_OFF(port->x_char, port->membase, OFF_RXTX=
);
> > +             port->icount.tx++;
> > +             port->x_char =3D 0;
> > +     } else if (!uart_circ_empty(xmit)) {
> > +             while (xmit->head !=3D xmit->tail) {
> > +                     ch =3D xmit->buf[xmit->tail];
> > +                     xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE=
 - 1);
> > +                     port->icount.tx++;
> > +                     liteuart_putchar(port, ch);
> > +             }
> > +     }
> > +
> > +     if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > +             uart_write_wakeup(port);
> > +}
> > +
> > +static void liteuart_stop_rx(struct uart_port *port)
> > +{
> > +     struct liteuart_port *uart =3D to_liteuart_port(port);
> > +
> > +     /* just delete timer */
> > +     del_timer(&uart->timer);
> > +}
> > +
> > +static void liteuart_break_ctl(struct uart_port *port, int break_state=
)
> > +{
> > +     /* LiteUART doesn't support sending break signal */
> > +}
> > +
> > +static int liteuart_startup(struct uart_port *port)
> > +{
> > +     struct liteuart_port *uart =3D to_liteuart_port(port);
> > +
> > +     /* disable events */
> > +     LITEX_WRITE_REG_OFF(0, port->membase, OFF_EV_ENABLE);
> > +
> > +     /* prepare timer for polling */
> > +     timer_setup(&uart->timer, liteuart_timer, 0);
> > +     mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > +
> > +     return 0;
> > +}
> > +
> > +static void liteuart_shutdown(struct uart_port *port)
> > +{
> > +}
> > +
> > +static void liteuart_set_termios(struct uart_port *port, struct ktermi=
os *new,
> > +                              struct ktermios *old)
> > +{
> > +     unsigned int baud;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +
> > +     /* update baudrate */
> > +     baud =3D uart_get_baud_rate(port, new, old, 0, 460800);
> > +     uart_update_timeout(port, new->c_cflag, baud);
> > +
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +}
> > +
> > +static const char *liteuart_type(struct uart_port *port)
> > +{
> > +     return (port->type =3D=3D PORT_LITEUART) ? DRIVER_NAME : NULL;
> > +}
> > +
> > +static void liteuart_release_port(struct uart_port *port)
> > +{
> > +}
> > +
> > +static int liteuart_request_port(struct uart_port *port)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void liteuart_config_port(struct uart_port *port, int flags)
> > +{
> > +     if (flags & UART_CONFIG_TYPE)
> > +             port->type =3D PORT_LITEUART;
> > +}
> > +
> > +static int liteuart_verify_port(struct uart_port *port,
> > +                             struct serial_struct *ser)
> > +{
> > +     if (port->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_LITEUART)
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct uart_ops liteuart_ops =3D {
> > +     .tx_empty       =3D liteuart_tx_empty,
> > +     .set_mctrl      =3D liteuart_set_mctrl,
> > +     .get_mctrl      =3D liteuart_get_mctrl,
> > +     .stop_tx        =3D liteuart_stop_tx,
> > +     .start_tx       =3D liteuart_start_tx,
> > +     .stop_rx        =3D liteuart_stop_rx,
> > +     .break_ctl      =3D liteuart_break_ctl,
> > +     .startup        =3D liteuart_startup,
> > +     .shutdown       =3D liteuart_shutdown,
> > +     .set_termios    =3D liteuart_set_termios,
> > +     .type           =3D liteuart_type,
> > +     .release_port   =3D liteuart_release_port,
> > +     .request_port   =3D liteuart_request_port,
> > +     .config_port    =3D liteuart_config_port,
> > +     .verify_port    =3D liteuart_verify_port,
> > +};
> > +
> > +static int liteuart_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *np =3D pdev->dev.of_node;
> > +     struct liteuart_port *uart;
> > +     struct uart_port *port;
> > +     int dev_id;
> > +
> > +     /* no device tree */
> > +     if (!np)
> > +             return -ENODEV;
> > +
> > +     dev_id =3D of_alias_get_id(np, "serial");
> > +     if (dev_id < 0 || dev_id >=3D CONFIG_SERIAL_LITEUART_NR_PORTS)
> > +             return -EINVAL;
>
> aliases should be optional. There's a helper to get a free index without
> an alias you can use.

Sure, we will fix it in v4.


--=20
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
