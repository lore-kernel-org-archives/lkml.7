Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4205C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F60222D1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFNDPIL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfCXMFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:05:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43679 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXMFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:05:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id l11so4516299pgq.10;
        Sun, 24 Mar 2019 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owc2ByLdDxxFMFUHNo7Yt3g3vAjePvz1W9146O9DYRQ=;
        b=jFNDPIL4f+V3qq3xxxHDeQNJypdVFibVB4Oz4Z7F/bbeH60pY9M71CGDho7kTS/7+G
         NANZ5jJD9zwvKbJ0RwNvbIbntZuy8zF/3HnZUBvMs4s9XEyvyC3EjbG/bumkTjpIlLoR
         6koWlcwvKcOkurUdaDiVI5Nr6KOYkLk+fJjXnFWYT3M5CHDG7VayoId9MIgFvbNLU8mJ
         0/hGKXgX+Y0IXsVrlVk3ucedfWbtukfTNTS2Mrfi1G/hj3SVYyJMdgy/9AZ5/q0J2w6J
         WitPSPWwE3dNNtBl82vgb3ehMIe7OnAf3gaFatfg11Iy8xBzA7rWnGxSubvJARSGCxwg
         Zsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owc2ByLdDxxFMFUHNo7Yt3g3vAjePvz1W9146O9DYRQ=;
        b=P369h/m8cGExMipb88/f6u77eJZXRv0QLqA4xZpyw90p0KNLZRuhkqqqJw5IBNDTkQ
         8bb0680/wZi2Y8ZYJmQuOENG7gQID2hZxk0FCxSIcJNAS1neODTA2oEKktawWKzDJf7/
         s/+om38on+qpJbrD42AvHOhkAUdr24Q+pbRq9rSYqME4Etzo3UPbZ/yzjC3WyMtS0gKr
         rUTGbTQGMl6YRzSqIQDQwImUiXfHjDWVKI5lGBoqMeaAFM6CvqJ1zAQGbor1da5lEkOg
         OXILempQwtlKyiQr/4evObbiD8WXTcyEjRugmIcSv90SiowkWxe3elgpOjhGzkHmmpy+
         pLbg==
X-Gm-Message-State: APjAAAX7aV6dAp4PSJhiG7vUTHKWgSNtROp/za3kbpprcOObMVqAR6CH
        8d6zGzobIUQEqrdn3/jDGyMwQzZtxti7Cq3t4dw=
X-Google-Smtp-Source: APXvYqxN1JARMDjKJmjrxf9KHQcViSm8uzQZVoz+kBmfQs9aHVCZpfj7PyXbcY/vY0inOzUoUa8CGAO0ttzOBt/gO+g=
X-Received: by 2002:a17:902:a9c8:: with SMTP id b8mr19708101plr.12.1553429121137;
 Sun, 24 Mar 2019 05:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190323225313.12325-1-pakki001@umn.edu>
In-Reply-To: <20190323225313.12325-1-pakki001@umn.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Mar 2019 14:05:09 +0200
Message-ID: <CAHp75VdeB=jPaqY_VNDA7YeCiEdyVFJAmOmC4sDvZLBv-7KQ0w@mail.gmail.com>
Subject: Re: [PATCH v2] tty: 8250: fix a missing check for pci_ioremap_bar
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 12:55 AM Aditya Pakki <pakki001@umn.edu> wrote:
>
> pci_ioremap_bar could fail. The fix captures the failure and
> pass an error code upstream. This can avoid potential NULL
> pointer dereferences in the future.
>

NAK.
This will break non-DMA case.

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
> Jiri Slaby
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..1dc67897dcf8 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -161,7 +161,7 @@ static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
>         .multi_block = {0},
>  };
>
> -static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
> +static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  {
>         struct uart_8250_dma *dma = &lpss->dma;
>         struct dw_dma_chip *chip = &lpss->dma_chip;
> @@ -172,12 +172,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>         chip->dev = &pdev->dev;
>         chip->irq = pci_irq_vector(pdev, 0);
>         chip->regs = pci_ioremap_bar(pdev, 1);
> +       if (!chip->regs)
> +               return -EIO;
>         chip->pdata = &qrk_serial_dma_pdata;
>
>         /* Falling back to PIO mode if DMA probing fails */
>         ret = dw_dma_probe(chip);
>         if (ret)
> -               return;
> +               return ret;
>
>         pci_try_set_mwi(pdev);
>
> @@ -191,6 +193,7 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>         param->hs_polarity = true;
>
>         lpss->dma_maxburst = 8;
> +       return 0;
>  }
>
>  static void qrk_serial_exit_dma(struct lpss8250 *lpss)
> @@ -202,7 +205,11 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>         dw_dma_remove(&lpss->dma_chip);
>  }
>  #else  /* CONFIG_SERIAL_8250_DMA */
> -static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> +static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
> +{
> +       return 0;
> +}
> +
>  static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
>  #endif /* !CONFIG_SERIAL_8250_DMA */
>
> @@ -219,8 +226,7 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>
>         port->irq = pci_irq_vector(pdev, 0);
>
> -       qrk_serial_setup_dma(lpss, port);
> -       return 0;
> +       return qrk_serial_setup_dma(lpss, port);
>  }
>
>  static void qrk_serial_exit(struct lpss8250 *lpss)
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
