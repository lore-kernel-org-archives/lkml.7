Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC09C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDEC2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5cvThBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbfGSWg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 18:36:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43000 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfGSWgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:36:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so14751449pff.9;
        Fri, 19 Jul 2019 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAss8MkDxKIIgy8BTidUKVu2SDLEFNknmikznCRAAGQ=;
        b=k5cvThBK3wJKtD1Za30SOuiQVN1iVUYJBonh2XIGi63dUT89kDP3i+8bzFlL+MZnKj
         v3o1YKs4EZZmFxog2QKeLgINbq9xHA05MP9VXbQuqGuteIzW2vPhBoxCWcz3oDemK0fF
         7v/CZM70Y7BtfhiiNzldMmk+gnWFsQpgQBq5rleDKvu4Xsz+9KIx1fX//MA6GtFMzHM1
         jrvm+5gJ5pe/1fy1ZmHZYgllaz+jvxCZCV9JlPHUd1c5xxNdQ96jqqV63BmkofyIrIu4
         MsWFIA8pZXICSTilbdev8prHdM3jBKa7Z2pL7ZcpKvZCA9JQDZWGGtdykRbGKzEsF+rj
         ynPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAss8MkDxKIIgy8BTidUKVu2SDLEFNknmikznCRAAGQ=;
        b=AY5F1tV+AH0seVB3Tv7tTqlI4qwctZVZr3tcVbqaipoVwHtwY8InFzfpFyIUJpkye8
         UHO7+QVNvdBOf+I7Hgb5qCA5h8uMTSuF0k3B/i2f7c52Cc1tfBbEiPGxAMKF2gN+5F/g
         pvtbMmrj+oK2KzSNw3MBefgChqlyzIpqKEmd+JYkdHMEO05XvVzH6I7JlPcrvjxcdiub
         mB6+bCDW8zp4QlQUGTNEgD6ymofu9unpISSbvTKbDVfKQtEa5eMPyYCQiVACEH7SmCxQ
         PM31a2LDT6S4zxfXCfa/SOIwa7Xgj9i/QKEjqEjj49yr/VRx4cXoJ/OWHAEHFUrVEuPX
         HYAw==
X-Gm-Message-State: APjAAAUuUM9ejFr+ZtoGHGEowIItpOrVTE6VKpbtS15AyO9t+LxcBtOA
        uQznZZq5U8YpiZWXPnDeNlshV9EKaBoHBkZhraE=
X-Google-Smtp-Source: APXvYqxIAT2MjupmE3GE3TOk6AKXqWFa/nakBIR3qA8YjXoMbBdV3jA2tNJDKXUQYfZIYJzR3KZlUxm+uTiW0C+Nh3M=
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr60350469pjb.30.1563575814670;
 Fri, 19 Jul 2019 15:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190719151519.GO9224@smile.fi.intel.com> <20190719174848.24216-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190719174848.24216-1-navid.emamdoost@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Jul 2019 01:36:43 +0300
Message-ID: <CAHp75Ve_fLZukJ2amKCUgFkMxmvMgOEL03v1OojHcE2eVvO3bg@mail.gmail.com>
Subject: Re: [PATCH v2] 8250_lpss: check null return when calling pci_ioremap_bar
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        emamd001@umn.edu, Kangjie Lu <kjlu@umn.edu>, smccaman@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 12:45 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> pci_ioremap_bar may return null. This is eventually de-referenced at
> drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check
> is needed to prevent null de-reference. I am adding the check and in case
>  of failure. Thanks to Andy Shevchenko for the hint on the necessity of
> pci_iounmap when exiting.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..d07e431110d9 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -169,10 +169,12 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>         struct pci_dev *pdev = to_pci_dev(port->dev);
>         int ret;
>
> +       chip->pdata = &qrk_serial_dma_pdata;
>         chip->dev = &pdev->dev;
>         chip->irq = pci_irq_vector(pdev, 0);
>         chip->regs = pci_ioremap_bar(pdev, 1);
> -       chip->pdata = &qrk_serial_dma_pdata;
> +       if (!chip->regs)
> +               return;
>
>         /* Falling back to PIO mode if DMA probing fails */
>         ret = dw_dma_probe(chip);
> @@ -195,11 +197,15 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>
>  static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>  {
> +       struct dw_dma_chip *chip = &lpss->dma_chip;
>         struct dw_dma_slave *param = &lpss->dma_param;
>
>         if (!param->dma_dev)
>                 return;
> -       dw_dma_remove(&lpss->dma_chip);
> +
> +       dw_dma_remove(chip);
> +
> +       pci_iounmap(to_pci_dev(chip->dev), chip->regs);
>  }
>  #else  /* CONFIG_SERIAL_8250_DMA */
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
