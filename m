Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E47C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C826D206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575560223;
	bh=8g5WQaj4R8Z6JbCzii1HHDVdWvegq5C0/h5DPZauWrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DkAq4Izh7cy9KdKSNzv79Ths5aMsN/rrwRaKobDax9QkYCYQplrePWu0mtdEzlds6
	 yDa3CHjBfErhfs/4bWFr8445Zn1PbyNhwJ3rIlwbne8aFKIjAnr3SZTkMHjgeYMWe8
	 DBNcw7iFt7ubUuWz1+sLbWRxDeV1L7Ue5CBzNtdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfLEPhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:37:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLEPhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:37:02 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D9E924648;
        Thu,  5 Dec 2019 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575560221;
        bh=8g5WQaj4R8Z6JbCzii1HHDVdWvegq5C0/h5DPZauWrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=afZoFyU8oAIo1hr36eD0VKgwP7ZPm6YNcHaBrsSzoxWdBW7+ijPvI72HvK4s3Y+2C
         1HSl5VGvnN97CjaRiXNcZNNLrxXRF3AbRFZrhB20jOjHGiSjZNy6nPs5DkfRKM4/4P
         Err56hIxQp/XVz+/IXOxdm3+Pe+4LFnDCPaKPAzk=
Received: by mail-lf1-f41.google.com with SMTP id b15so2836027lfc.4;
        Thu, 05 Dec 2019 07:37:00 -0800 (PST)
X-Gm-Message-State: APjAAAXVd7WTaD38Dzxi2K0Q+xuvHf2L7F6j3WrY+e9zQQHOIJDBVMKb
        KKF2/OQxELwAunei1MD7UE45xusJSAmuLaurNV8=
X-Google-Smtp-Source: APXvYqwek8DVv/vM+L3oBCOoYeEJuHSeXNWUabOdTxLPiPQBiEfVcEbnen+l04q5P0K9l4MHNCylkIMnDfQSrCrZcno=
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr1692900lfp.106.1575560219202;
 Thu, 05 Dec 2019 07:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20191201075914.23512-1-kkoos00@naver.com> <20191201080314.GA3716559@kroah.com>
In-Reply-To: <20191201080314.GA3716559@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 5 Dec 2019 16:36:48 +0100
X-Gmail-Original-Message-ID: <CAJKOXPet=RyJ3nrcOooHdN0GSO33Ce82-9L_X0oYC2MjN7nOig@mail.gmail.com>
Message-ID: <CAJKOXPet=RyJ3nrcOooHdN0GSO33Ce82-9L_X0oYC2MjN7nOig@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: samsung: support driver modulization
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hyunki Koo <kkoos00@naver.com>, jslaby@suse.com,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kkoos00@gmail.com, Shinbeom Choi <sbeom.choi@samsung.com>,
        Hyunki Koo <hyunki00.koo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2019 at 09:05, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Dec 01, 2019 at 04:59:14PM +0900, Hyunki Koo wrote:
> > From: Shinbeom Choi <sbeom.choi@samsung.com>
> >
> > This commit enables modulization of samsung uart driver.
> >
> > There was no way to make use of this driver in other module,
> > because uart functions were static.
> >
> > By exporting required functions, user can use this driver
> > in other module.
> >
> > Signed-off-by: Shinbeom Choi <sbeom.choi@samsung.com>
> > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > ---
> >  drivers/tty/serial/samsung.h     | 32 ++++++++++++
> >  drivers/tty/serial/samsung_tty.c | 85 +++++++++++++++-----------------
> >  2 files changed, 73 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
> > index f93022113f59..25be0962284d 100644
> > --- a/drivers/tty/serial/samsung.h
> > +++ b/drivers/tty/serial/samsung.h
> > @@ -144,4 +144,36 @@ static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
> >       local_irq_restore(flags);
> >  }
> >
> > +#if defined(CONFIG_ARCH_EXYNOS)
> > +#define EXYNOS_COMMON_SERIAL_DRV_DATA                                \
> > +     .info = &(struct s3c24xx_uart_info) {                   \
> > +             .name           = "Samsung Exynos UART",        \
> > +             .type           = PORT_S3C6400,                 \
> > +             .has_divslot    = 1,                            \
> > +             .rx_fifomask    = S5PV210_UFSTAT_RXMASK,        \
> > +             .rx_fifoshift   = S5PV210_UFSTAT_RXSHIFT,       \
> > +             .rx_fifofull    = S5PV210_UFSTAT_RXFULL,        \
> > +             .tx_fifofull    = S5PV210_UFSTAT_TXFULL,        \
> > +             .tx_fifomask    = S5PV210_UFSTAT_TXMASK,        \
> > +             .tx_fifoshift   = S5PV210_UFSTAT_TXSHIFT,       \
> > +             .def_clk_sel    = S3C2410_UCON_CLKSEL0,         \
> > +             .num_clks       = 1,                            \
> > +             .clksel_mask    = 0,                            \
> > +             .clksel_shift   = 0,                            \
> > +     },                                                      \
> > +     .def_cfg = &(struct s3c2410_uartcfg) {                  \
> > +             .ucon           = S5PV210_UCON_DEFAULT,         \
> > +             .ufcon          = S5PV210_UFCON_DEFAULT,        \
> > +             .has_fracval    = 1,                            \
> > +     }                                                       \
> > +
> > +#endif
> > +
> > +int s3c24xx_serial_get_ports(struct s3c24xx_uart_port **ourport, int index);
> > +int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> > +                                 struct platform_device *platdev);
> > +int s3c24xx_serial_unregister_port(struct platform_device *dev);
> > +int s3c24xx_serial_suspend(struct device *dev);
> > +int s3c24xx_serial_resume(struct device *dev);
> > +int s3c24xx_serial_resume_noirq(struct device *dev);
> >  #endif
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index 83fd51607741..15414ecd9008 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -1735,7 +1735,7 @@ static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
> >   * initialise a single serial port from the platform device given
> >   */
> >
> > -static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> > +int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> >                                   struct platform_device *platdev)
> >  {
> >       struct uart_port *port = &ourport->port;
> > @@ -1842,12 +1842,24 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> >       /* reset the fifos (and setup the uart) */
> >       s3c24xx_serial_resetport(port, cfg);
> >
> > +     if (!s3c24xx_uart_drv.state) {
> > +             ret = uart_register_driver(&s3c24xx_uart_drv);
> > +             if (ret < 0) {
> > +                     dev_err(port->dev, "Failed to register Samsung UART driver\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     dbg("%s: adding port\n", __func__);
> > +     uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> > +
> >       return 0;
> >
> >  err:
> >       port->mapbase = 0;
> >       return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(s3c24xx_serial_init_port);
>
> Why are you exporting all of these functions?  What other code uses
> them?  Why are you converting them all to global functions I don't see
> any other in-kernel callers, so why are those changes needed here?
>
> totally confused,

I cannot find the original email from Hyunki on mailing lists (neither
LKML nor serial) so this was not even public till Greg replied.

Anyway, probably this is for new Android and some out-of-tree usage...
but it is wrong.

Best regards,
Krzysztof
