Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA68C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12982080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qA8hqU2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfFRHbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:31:12 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35768 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFRHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:31:11 -0400
Received: by mail-ua1-f65.google.com with SMTP id r7so4923745ual.2;
        Tue, 18 Jun 2019 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzxq9Q+CmBAS6p9XrEBeJs+drpYx4BuE8Dk9SbAHAjw=;
        b=qA8hqU2YCIjQpLMCE3WZm/woZixj/UpXTuQJW654Eox3QeHNxJPbilY9jM8V+BQ9m5
         /Ml2ZBPfuXNV8yE/FBtIoBqYnvTKC0TiDlIkx6Gz0bQ38e7sILqX8IobsamXp6vTYEhf
         lz1Yf+O8u2SIpTE2o9NSPypLUg2bInhwzD7oLriaKlAJsXmKZ92oc5grerXnYD2r2K3j
         zWtXUHSqqNmXTynHAlFtgmUT3J4nyThJG7lSyUpScJ0cx0ov2qw/5fonA0OA6Zeu4qky
         b8vEiFFyqifYe4/oIsNe3GzJuoDi3eOPoqk2iMKrcp/Z0j2RstYaE76/I1/hYGcgFPyD
         dP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzxq9Q+CmBAS6p9XrEBeJs+drpYx4BuE8Dk9SbAHAjw=;
        b=sXdn0tq0ED6aTxg2gS8rkH4YPuQa4OUBzb9Tu2Stj2KQXbWjMUKUZ6zlCKM4BqwIhF
         Qt1kbyNp1powIsFgZtNVVUfI4TvqfOaA3ZyUdpMPc5sDUD0v6wjaOczkDTNIu/xWZMjR
         ibEGzzzEBSkwN377nlRUzUkyLz5BXOo9aYL6sxgSF2gHdMxqVR4PsbaPean3Sk3U3bUz
         zAZDguo1BFqknfOY/YEKzJRfuSS7jlAM7r8lE2Tl7Kx6+jhsmDWyAf0xisGMLcbhr3kD
         akbmSuI/eC5WFlyhN0mJ9lEzvfDViXIWt4nmk5JsP769yzDcA3VDX/ioU8ZJ7AE7oFot
         ibQQ==
X-Gm-Message-State: APjAAAVxZgFO8qZi3cE1e7d8IWRrwA8ou8WKDw0/vjBwxcucnyZSo3fV
        C2tN4kR1dlj0cTcYWO3ZMIeZC4fBt2kzz5lAnRc=
X-Google-Smtp-Source: APXvYqwo0tvQpHWn/m3K8koln5/ruBA79h9JB5rh6JmvlgRqwJxjTPJvnNT1455KqKFax+syu7hgd+6V2jajtYxiX+8=
X-Received: by 2002:ab0:3316:: with SMTP id r22mr7346377uao.90.1560843070371;
 Tue, 18 Jun 2019 00:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190617145952.4848-1-sr@denx.de> <20190617145952.4848-3-sr@denx.de>
In-Reply-To: <20190617145952.4848-3-sr@denx.de>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Tue, 18 Jun 2019 09:30:45 +0200
Message-ID: <CAGm1_kvf8UVBRnPRiutGnSY5KH-n5vczvZ3eSYg80cJEi9=chg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v7] tty/serial/8250: use mctrl_gpio helpers
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 5:00 PM Stefan Roese <sr@denx.de> wrote:
>
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.
>
> Changed by Stefan:
> Only call mctrl_gpio_init(), if the device has no ACPI companion device
> to not break existing ACPI based systems. Also only use the mctrl_gpio_
> functions when "gpios" is available.
>
> Use MSR / MCR <-> TIOCM wrapper functions.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Yegor Yefremov <yegorslists@googlemail.com>

Thanks for reviving my initial patch series and bringing them into shape.

Yegor

> ---
> v7:
> - Change serial8250_do_get_mctrl() so that systems with a "mixed setup"
>   (i.e. CTS controlled by UART but other status pins controlled by GPIO)
>   are also supported again (Yegor)
>
> v6:
> - Use newly introduced TIOCM <-> MCR/MSR wrapper functions
> - serial8250_in_MCR(): Don't save the already read MCR bits in TIOCM
>   format but "or" them later to the GPIO MCR value
> - Correctly use "!up->gpios" (Andy)
> - Removed Mika's reviewed by tag (because of changes)
>
> v5:
> - Dropped a few "if (up->gpios)" checks, as the mctrl_gpio_foo() API
>   handles gpios == NULL (return)
> - 8250_omap: Changed "IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios, ...))"
>   to "up->gpios == NULL", as mctrl_gpio_to_gpiod() does not handle
>   gpios == NULL correctly.
>
> v4:
> - Added Mika's reviewed by tag
> - Added Johan to Cc
>
> v3:
> - Only call mctrl_gpio_init(), if the device has no ACPI companion device
>   to not break existing ACPI based systems, as suggested by Andy
>
> v2:
> - No change
>
> Please note that this patch was already applied before [1]. And later
> reverted [2] because it introduced problems on some x86 based boards
> (ACPI GPIO related). Here a detailed description of the issue at that
> time:
>
> https://lkml.org/lkml/2016/8/9/357
> http://www.spinics.net/lists/linux-serial/msg23071.html
>
> This is a re-send of the original patch that was applied at that time.
> With patch 1/2 from this series this issue should be fixed now (please
> note that I can't test it on such an x86 platform causing these
> problems).
>
> Andy (or Mika), perhaps it would be possible for you to test this
> patch again, now with patch 1/2 of this series applied as well?
> That would be really helpful.
>
> Thanks,
> Stefan
>
> [1] 4ef03d328769 ("tty/serial/8250: use mctrl_gpio helpers")
> [2] 5db4f7f80d16 ("Revert "tty/serial/8250: use mctrl_gpio helpers"")
>
>  .../devicetree/bindings/serial/8250.txt       | 19 ++++++++++++
>  drivers/tty/serial/8250/8250.h                | 18 +++++++++++-
>  drivers/tty/serial/8250/8250_core.c           | 17 +++++++++++
>  drivers/tty/serial/8250/8250_omap.c           | 29 ++++++++++---------
>  drivers/tty/serial/8250/8250_port.c           | 11 ++++++-
>  drivers/tty/serial/8250/Kconfig               |  1 +
>  include/linux/serial_8250.h                   |  1 +
>  7 files changed, 81 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> index 3cba12f855b7..20d351f268ef 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -53,6 +53,9 @@ Optional properties:
>    programmable TX FIFO thresholds.
>  - resets : phandle + reset specifier pairs
>  - overrun-throttle-ms : how long to pause uart rx when input overrun is encountered.
> +- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
> +  line respectively. It will use specified GPIO instead of the peripheral
> +  function pin for the UART feature. If unsure, don't specify this property.
>
>  Note:
>  * fsl,ns16550:
> @@ -74,3 +77,19 @@ Example:
>                 interrupts = <10>;
>                 reg-shift = <2>;
>         };
> +
> +Example for OMAP UART using GPIO-based modem control signals:
> +
> +       uart4: serial@49042000 {
> +               compatible = "ti,omap3-uart";
> +               reg = <0x49042000 0x400>;
> +               interrupts = <80>;
> +               ti,hwmods = "uart4";
> +               clock-frequency = <48000000>;
> +               cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
> +               rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
> +               dtr-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +               dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +               dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> +               rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> +       };
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 793da2e510e0..75c7c5449461 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -11,6 +11,8 @@
>  #include <linux/serial_reg.h>
>  #include <linux/dmaengine.h>
>
> +#include "../serial_mctrl_gpio.h"
> +
>  struct uart_8250_dma {
>         int (*tx_dma)(struct uart_8250_port *p);
>         int (*rx_dma)(struct uart_8250_port *p);
> @@ -196,11 +198,25 @@ static inline int serial8250_MSR_to_TIOCM(int msr)
>  static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
>  {
>         serial_out(up, UART_MCR, value);
> +
> +       if (up->gpios)
> +               mctrl_gpio_set(up->gpios, serial8250_MCR_to_TIOCM(value));
>  }
>
>  static inline int serial8250_in_MCR(struct uart_8250_port *up)
>  {
> -       return serial_in(up, UART_MCR);
> +       int mctrl;
> +
> +       mctrl = serial_in(up, UART_MCR);
> +
> +       if (up->gpios) {
> +               unsigned int mctrl_gpio = 0;
> +
> +               mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
> +               mctrl |= serial8250_TIOCM_to_MCR(mctrl_gpio);
> +       }
> +
> +       return mctrl;
>  }
>
>  #if defined(__alpha__) && !defined(CONFIG_PCI)
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index e441221e04b9..a4470771005f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -14,6 +14,7 @@
>   *           serial8250_register_8250_port() ports
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/ioport.h>
> @@ -982,6 +983,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>
>         uart = serial8250_find_match_or_unused(&up->port);
>         if (uart && uart->port.type != PORT_8250_CIR) {
> +               struct mctrl_gpios *gpios;
> +
>                 if (uart->port.dev)
>                         uart_remove_one_port(&serial8250_reg, &uart->port);
>
> @@ -1016,6 +1019,20 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>                 if (up->port.flags & UPF_FIXED_TYPE)
>                         uart->port.type = up->port.type;
>
> +               /*
> +                * Only call mctrl_gpio_init(), if the device has no ACPI
> +                * companion device
> +                */
> +               if (!has_acpi_companion(uart->port.dev)) {
> +                       gpios = mctrl_gpio_init(&uart->port, 0);
> +                       if (IS_ERR(gpios)) {
> +                               if (PTR_ERR(gpios) != -ENOSYS)
> +                                       return PTR_ERR(gpios);
> +                       } else {
> +                               uart->gpios = gpios;
> +                       }
> +               }
> +
>                 serial8250_set_defaults(uart);
>
>                 /* Possibly override default I/O functions.  */
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 0a8316632d75..d5bbfc8f2284 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -141,18 +141,20 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
>
>         serial8250_do_set_mctrl(port, mctrl);
>
> -       /*
> -        * Turn off autoRTS if RTS is lowered and restore autoRTS setting
> -        * if RTS is raised
> -        */
> -       lcr = serial_in(up, UART_LCR);
> -       serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> -       if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
> -               priv->efr |= UART_EFR_RTS;
> -       else
> -               priv->efr &= ~UART_EFR_RTS;
> -       serial_out(up, UART_EFR, priv->efr);
> -       serial_out(up, UART_LCR, lcr);
> +       if (!up->gpios) {
> +               /*
> +                * Turn off autoRTS if RTS is lowered and restore autoRTS
> +                * setting if RTS is raised
> +                */
> +               lcr = serial_in(up, UART_LCR);
> +               serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +               if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
> +                       priv->efr |= UART_EFR_RTS;
> +               else
> +                       priv->efr &= ~UART_EFR_RTS;
> +               serial_out(up, UART_EFR, priv->efr);
> +               serial_out(up, UART_LCR, lcr);
> +       }
>  }
>
>  /*
> @@ -453,7 +455,8 @@ static void omap_8250_set_termios(struct uart_port *port,
>         priv->efr = 0;
>         up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
>
> -       if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
> +       if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW &&
> +           !up->gpios) {
>                 /* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
>                 up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
>                 priv->efr |= UART_EFR_CTS;
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 47f0a8d01a57..ff3dd0c1c90a 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1662,6 +1662,8 @@ static void serial8250_disable_ms(struct uart_port *port)
>         if (up->bugs & UART_BUG_NOMSR)
>                 return;
>
> +       mctrl_gpio_disable_ms(up->gpios);
> +
>         up->ier &= ~UART_IER_MSI;
>         serial_port_out(port, UART_IER, up->ier);
>  }
> @@ -1674,6 +1676,8 @@ static void serial8250_enable_ms(struct uart_port *port)
>         if (up->bugs & UART_BUG_NOMSR)
>                 return;
>
> +       mctrl_gpio_enable_ms(up->gpios);
> +
>         up->ier |= UART_IER_MSI;
>
>         serial8250_rpm_get(up);
> @@ -1944,12 +1948,17 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
>  {
>         struct uart_8250_port *up = up_to_u8250p(port);
>         unsigned int status;
> +       unsigned int val;
>
>         serial8250_rpm_get(up);
>         status = serial8250_modem_status(up);
>         serial8250_rpm_put(up);
>
> -       return serial8250_MSR_to_TIOCM(status);
> +       val = serial8250_MSR_to_TIOCM(status);
> +       if (up->gpios)
> +               return mctrl_gpio_get(up->gpios, &val);
> +
> +       return val;
>  }
>  EXPORT_SYMBOL_GPL(serial8250_do_get_mctrl);
>
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 296115f6a4d8..509f6a3bb9ff 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -8,6 +8,7 @@ config SERIAL_8250
>         tristate "8250/16550 and compatible serial support"
>         depends on !S390
>         select SERIAL_CORE
> +       select SERIAL_MCTRL_GPIO if GPIOLIB
>         ---help---
>           This selects whether you want to include the driver for the standard
>           serial ports.  The standard answer is Y.  People who might say N
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index 5e0b59422a68..bb2bc99388ca 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -110,6 +110,7 @@ struct uart_8250_port {
>                                                  *   if no_console_suspend
>                                                  */
>         unsigned char           probe;
> +       struct mctrl_gpios      *gpios;
>  #define UART_PROBE_RSA (1 << 0)
>
>         /*
> --
> 2.22.0
>
