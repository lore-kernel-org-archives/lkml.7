Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ABAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD672147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZSLpKB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfCXSr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:47:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42532 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXSr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:47:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so4784780pfn.9;
        Sun, 24 Mar 2019 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQstm92FW3ly5qHmfUez0JTBxcVvSYMnHU9LziNmEiE=;
        b=XZSLpKB8uyDnrBRYZ8jstSzUYtRktCSuLo3fedehK/N/dPHvJ07GlhoG1dY2dc9t63
         Xe5v1mbNsa37YHbYo7lxxR3KUOcwcl2gK4N5KJZh3alzmUbPUjZCVMzkv22TepfwvrlF
         ON5RaVLs5+YIhIo2OpE3b97CsTnyYX4Z/bV2sA5h0iiUbo7A+dksNoidGIarjExtgVT3
         Vdoz4eCaEiAQAEY3CVoLgsvfDs64Katm+PdJ9iExSsT4byH6UYGwmqtvPkxcchDNYfM2
         ifPT8+UvapT4yFE/6ulyEK85IqD/57LNEpMbxIn39nx2k59UpdOJ3WXOK68eVbCdU8LZ
         f9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQstm92FW3ly5qHmfUez0JTBxcVvSYMnHU9LziNmEiE=;
        b=oNZ+/Qk6cHDAcyaTu81il/fQpyRcV2kchmIDhUaINHXLsQLRj1RR5WDEXz/bTlzVJd
         3/hLs3bicR5pJXh749K7anmkJtDqWHUc53PaVmmOu9fgTcB6K+bNAnhBuUpkVsCHxOml
         qbsJ9B4egBmkvlZ4ObRr1XRV9XCP8RnRvEqSP1ybMlrF2fqNQyVH2o/hNS+cPjiIj0tf
         85uducn5iK6g520pi03SPldP2EYdnb+Qw7jz63IHhm+WLmuVd68AeUkVzD93i2gEcARO
         m7hgT0yLS0Ehvzjl+/ZiO+JmH+9o9cuX5Or/H6lFmO7yrYwTbheZOGfHuLTIoO053XK8
         s30A==
X-Gm-Message-State: APjAAAWsejM1cVgOqS8aH04vTe1h2a0ciDGtOItrYj28osUwRlIEuJlZ
        VBFhVUPcfS1VUh4+bYYjpF0OAcMZtAQkXXbwk+s=
X-Google-Smtp-Source: APXvYqzSRFy7nfov4ARIaNI+YInEaZ4uBqT7xiaPqbMvYoSzCEbxrjeec471kDfupgW9HfpbHK6Xrz7npJqNwBRf90c=
X-Received: by 2002:aa7:8c97:: with SMTP id p23mr20512702pfd.229.1553453277002;
 Sun, 24 Mar 2019 11:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190324164139.23899-1-pakki001@umn.edu>
In-Reply-To: <20190324164139.23899-1-pakki001@umn.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Mar 2019 20:47:45 +0200
Message-ID: <CAHp75VcXg1HFKS6ve3v_Xs_fH+9ogm1hsOgKEe4Z1OYhABfFgg@mail.gmail.com>
Subject: Re: [PATCH v4] tty: 8250: fix a missing check for pci_ioremap_bar
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 6:43 PM Aditya Pakki <pakki001@umn.edu> wrote:
>
> pci_ioremap_bar could fail. The patch returns in case of failure to
> acquire IOMEM. It also releases the acquired resource in the exit path.

This is good per se, but I'm so sorry I found another missed place.
When DMA ->probe() fails, we have to unmap as well.

>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v3: Change the order of pci_iounmap and dw_dma_remove
> v2: Failed to release resource in exit path and incorrect code in non
> DMA case, suggested by Andy Shevchenko
> v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
> Jiri Slaby
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..69d6e32da713 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -170,9 +170,11 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>         int ret;
>
>         chip->dev = &pdev->dev;
> +       chip->pdata = &qrk_serial_dma_pdata;
>         chip->irq = pci_irq_vector(pdev, 0);
>         chip->regs = pci_ioremap_bar(pdev, 1);
> -       chip->pdata = &qrk_serial_dma_pdata;
> +       if (!chip->regs)
> +               return;
>
>         /* Falling back to PIO mode if DMA probing fails */
>         ret = dw_dma_probe(chip);
> @@ -199,7 +201,10 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>
>         if (!param->dma_dev)
>                 return;
> +
>         dw_dma_remove(&lpss->dma_chip);
> +
> +       pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);
>  }
>  #else  /* CONFIG_SERIAL_8250_DMA */
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
