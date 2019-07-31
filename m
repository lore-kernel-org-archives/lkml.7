Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC11C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5072206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ur4RswjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfGaCJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 22:09:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34327 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfGaCJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 22:09:37 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so132864429iot.1;
        Tue, 30 Jul 2019 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFgQyuzi8P9FL54Z0M1TxPqHgOnZN/olpyMNCaDDGCE=;
        b=ur4RswjWN0+4M/o9T9fW4/8qqPJy5u530QsBvEwWcZMYRkJpwk/3vhbZNLTv7Yl4lO
         2SkwukhzUMyzJUGpar0+bqC3ZHdNVbBdaQ5LnwYInQ1Y+FgTQGtS32SPstBrb2esfoiI
         91vTYf8U9IJLFV88NCIu9r1kPG46RBKIQO4ZRfWt3b952j8IuEYM8kbdoaZtOWXhZdP+
         BmyGrKBi3zg2utvVXHiQfteNevS9+hU9C0W3Cwr0h3HlytNBNZykCQMTuyy4yaEX2ovr
         50RbrLaln3TnS8Q2byf5B7PIHlMiLjN2NNQnZniZ3kfTj/bjyTCc7VfvTyeypz2imW1I
         7VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFgQyuzi8P9FL54Z0M1TxPqHgOnZN/olpyMNCaDDGCE=;
        b=jbLvCjEYcqN82CpmzbRtvjkDRr+TItVde3rUj/Ptd8pMKMkH2MCWs9QlEVd0bAxfyd
         BxYuOQmgoPv0AwaqEFsGgPDNQmeMs9bryTp4Rwnr09DZMn80iCMsS9K+uT46IWFd7Y4O
         Obk5ArUJxNrBQbSmkkAa0aDgVHrpKtkExIw2KrTmT9KTN0QDcZ36hBHJdGdMr6MVPiG1
         dw+rtZbs4jdny6gGl9tm5Lia3LVM+U7tUwGN6mepLgFewSn9KsWRF67rWuJT2/T5Eg4q
         WH4+98wd7jMP/Q/4vOzH1PQNH0mCyPLzBj2cXjHSHSEFtfrGNHMXBG6N8eSgjSzbjyLR
         pX9A==
X-Gm-Message-State: APjAAAXSZSB8uPDRnrrEFF5/f7IyV4FomIfLBjA+qF+1xET0EphFwWcS
        4necGa2YccupUlJqHTVIvpwI9lmgfQ+kFFIaRz4=
X-Google-Smtp-Source: APXvYqwkX75OkFE9A6SeIr4vgmxP3XbOopohv7bxJXGPsO8Bqhha84W0Dm8hnVR/qegmVuI8cbMEI+fS1tCYN1uxqYE=
X-Received: by 2002:a5d:9711:: with SMTP id h17mr37343638iol.280.1564538976505;
 Tue, 30 Jul 2019 19:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
 <20190729195226.8862-20-andrew.smirnov@gmail.com> <20190730155608.GA3990@kroah.com>
In-Reply-To: <20190730155608.GA3990@kroah.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 30 Jul 2019 19:09:25 -0700
Message-ID: <CAHQ1cqHJzmgcpd3SmchygNiOVGNCHWKZvwHcEBEWweboOiZu0w@mail.gmail.com>
Subject: Re: [PATCH 19/24] tty: serial: fsl_lpuart: Introduce lpuart_tx_dma_startup()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 8:56 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 29, 2019 at 12:52:21PM -0700, Andrey Smirnov wrote:
> > Code configure DMA TX path in lpuart_startup(), lpuart32_startup() and
> > lpuart_resume() is doing exactly the same thing, so move it into a
> > standalone subroutine.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Cory Tusar <cory.tusar@zii.aero>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 53 ++++++++++++++-------------------
> >  1 file changed, 23 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> > index 2ad5750fe511..558acf29cbed 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1434,6 +1434,26 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
> >       add_timer(&sport->lpuart_timer);
> >  }
> >
> > +static void lpuart_tx_dma_startup(struct lpuart_port *sport)
> > +{
> > +     u32 uartbaud;
> > +
> > +     if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> > +             init_waitqueue_head(&sport->dma_wait);
> > +             sport->lpuart_dma_tx_use = true;
> > +             if (lpuart_is_32(sport)) {
> > +                     uartbaud = lpuart32_read(&sport->port, UARTBAUD);
> > +                     lpuart32_write(&sport->port,
> > +                                    uartbaud | UARTBAUD_TDMAE, UARTBAUD);
> > +             } else {
> > +                     writeb(readb(sport->port.membase + UARTCR5) |
> > +                             UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> > +             }
> > +     } else {
> > +             sport->lpuart_dma_tx_use = false;
> > +     }
> > +}
> > +
> >  static int lpuart_startup(struct uart_port *port)
> >  {
> >       struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
> > @@ -1471,14 +1491,7 @@ static int lpuart_startup(struct uart_port *port)
> >               sport->lpuart_dma_rx_use = false;
> >       }
> >
> > -     if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
> > -             init_waitqueue_head(&sport->dma_wait);
> > -             sport->lpuart_dma_tx_use = true;
> > -             temp = readb(port->membase + UARTCR5);
> > -             writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
> > -     } else {
> > -             sport->lpuart_dma_tx_use = false;
> > -     }
> > +     lpuart_tx_dma_startup(port);
> >
> >       spin_unlock_irqrestore(&sport->port.lock, flags);
> >
> > @@ -1522,14 +1535,7 @@ static int lpuart32_startup(struct uart_port *port)
> >               sport->lpuart_dma_rx_use = false;
> >       }
> >
> > -     if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
> > -             init_waitqueue_head(&sport->dma_wait);
> > -             sport->lpuart_dma_tx_use = true;
> > -             temp = lpuart32_read(&sport->port, UARTBAUD);
> > -             lpuart32_write(&sport->port, temp | UARTBAUD_TDMAE, UARTBAUD);
> > -     } else {
> > -             sport->lpuart_dma_tx_use = false;
> > -     }
> > +     lpuart_tx_dma_startup(port);
> >
> >       if (sport->lpuart_dma_rx_use) {
> >               /* RXWATER must be 0 */
> > @@ -2581,20 +2587,7 @@ static int lpuart_resume(struct device *dev)
> >               }
> >       }
> >
> > -     if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> > -             init_waitqueue_head(&sport->dma_wait);
> > -             sport->lpuart_dma_tx_use = true;
> > -             if (lpuart_is_32(sport)) {
> > -                     temp = lpuart32_read(&sport->port, UARTBAUD);
> > -                     lpuart32_write(&sport->port,
> > -                                    temp | UARTBAUD_TDMAE, UARTBAUD);
> > -             } else {
> > -                     writeb(readb(sport->port.membase + UARTCR5) |
> > -                             UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> > -             }
> > -     } else {
> > -             sport->lpuart_dma_tx_use = false;
> > -     }
> > +     lpuart_tx_dma_startup(sport);
> >
> >       if (lpuart_is_32(sport)) {
> >               if (sport->lpuart_dma_rx_use) {
> > --
> > 2.21.0
> >
>
> This patch breaks the build:
>
> drivers/tty/serial/fsl_lpuart.c: In function lpuart_startup:
> drivers/tty/serial/fsl_lpuart.c:1494:24: error: passing argument 1 of lpuart_tx_dma_startup from incompatible pointer type [-Werror=incompatible-pointer-types]
>  1494 |  lpuart_tx_dma_startup(port);
>       |                        ^~~~
>       |                        |
>       |                        struct uart_port *
> drivers/tty/serial/fsl_lpuart.c:1438:55: note: expected struct lpuart_port * but argument is of type struct uart_port *
>  1438 | static void lpuart_tx_dma_startup(struct lpuart_port *sport)
>       |                                   ~~~~~~~~~~~~~~~~~~~~^~~~~
> drivers/tty/serial/fsl_lpuart.c: In function lpuart32_startup:
> drivers/tty/serial/fsl_lpuart.c:1537:24: error: passing argument 1 of lpuart_tx_dma_startup from incompatible pointer type [-Werror=incompatible-pointer-types]
>  1537 |  lpuart_tx_dma_startup(port);
>       |                        ^~~~
>       |                        |
>       |                        struct uart_port *
> drivers/tty/serial/fsl_lpuart.c:1438:55: note: expected struct lpuart_port * but argument is of type struct uart_port *
>  1438 | static void lpuart_tx_dma_startup(struct lpuart_port *sport)
>       |                                   ~~~~~~~~~~~~~~~~~~~~^~~~~
> cc1: some warnings being treated as errors
>
>
> So I've stopped applying the series here.
>
> Please fix up and resend the remaining ones.
>

Ugh, my bad, sorry about that. Will do in v2.

Thanks,
Andrey Smirnov
