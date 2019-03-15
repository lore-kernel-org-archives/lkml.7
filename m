Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BDDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63902184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNFMk+gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfCOJIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:08:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39425 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfCOJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:08:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id i20so5891673pfo.6;
        Fri, 15 Mar 2019 02:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQuWJiaahoVGruZwKY+4GHvBiDxUpo5ZETYkLiKhcXY=;
        b=hNFMk+gLWKwV7otyRME333Rh0w4aXpbdIli9zhjpDTnxgPt6aHIoYS8YtLGgvrDHc3
         DYQD7mjl+MRE11GWoHQws0xx4vQhLH6N/pZuRHNnWZWE8yf+E3CQL0PF7XUJ9PHaDW1m
         nijqSt6w4U3rGkqWyVRK+cM2qa/n9Xx9D35w3453EXaEEKRD1rCC6Is/oMkaFcVtYVOd
         RxZGP6hGuzNJAlsCoKgpkr5dtEIQAQ05mZYj96g87+wyHcM2mVCWdvJmoLWPA0Rp5glh
         C0A7O/mVBb8t2sKmekMaAKswAWq492zzoHCzZf8XuE6/M2EwKGABpJPzXgJUOu7vUxU2
         Ex9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQuWJiaahoVGruZwKY+4GHvBiDxUpo5ZETYkLiKhcXY=;
        b=pDZ/R/1R49p8CjAsEEyol2X9O6t+7hNvHoBbGVeEKzI2Rx+Lbs4hxlfynjyDysVQsH
         y4Bk8q1Iyef/jLIJ1rneu3f0WyLGW2TSvZSMPxbfnh7gQq+pPQ24H+aSLF1gfYOpwKsf
         pt5g5i4Vp8QF/z4qC6SpYIIGjYUnCvMo3NQx2rjloXI9GxfECj28WAAe9aKs/3MDr+01
         8+/NgVCDEsPj1PFS8AfGW/gkAx8iYS2DkyJXuIwsUV/BgYK+L4M74LIwAcXFqMo+A4JD
         ncd+DNcqnMCIvG1Hq23xcE9KpvzE0rZwC4Ojtp6WMYI+a3boMSCh5BlNwyQ8I8tuyetP
         hmNA==
X-Gm-Message-State: APjAAAX9Yg0DdHo+dxDf758jNr4YM5daEUb1mXD0tY1wnm18qONuuAwh
        fsjenCeyd1V8jkXLT2CYf/jeH4y9o/Roa1VPAZ8=
X-Google-Smtp-Source: APXvYqyqmh4mImfByZPHBrLJaiK+jU2dsJ9f8DkNpWlgA9COO6KNpGptzJ78do0+5C9IVfr8HhX+40bnccX+xKcIde0=
X-Received: by 2002:aa7:930b:: with SMTP id 11mr2926855pfj.49.1552640892802;
 Fri, 15 Mar 2019 02:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net> <1552602855-26086-46-git-send-email-info@metux.net>
In-Reply-To: <1552602855-26086-46-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Mar 2019 11:08:01 +0200
Message-ID: <CAHp75Vf1F_WQxNRiya=aTqFTEGWDVrD9JTr1VB4pOW0RayDmoA@mail.gmail.com>
Subject: Re: [PATCH v2 45/45] drivers: tty: serial: mux: use devm_* functions
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        macro@linux-mips.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, baohua@kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:37 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the safer devm versions of memory mapping functions.

If you are going to use devm_*_free(), what's the point to have this
change from the beginning?

P.S. Disregard that this is untested series...

> --- a/drivers/tty/serial/mux.c
> +++ b/drivers/tty/serial/mux.c
> @@ -456,8 +456,9 @@ static int __init mux_probe(struct parisc_device *dev)
>         printk(KERN_INFO "Serial mux driver (%d ports) Revision: 0.6\n", port_count);
>
>         dev_set_drvdata(&dev->dev, (void *)(long)port_count);
> -       request_mem_region(dev->hpa.start + MUX_OFFSET,
> -                           port_count * MUX_LINE_OFFSET, "Mux");

> +       devm_request_mem_region(&dev->dev,
> +                               dev->hpa.start + MUX_OFFSET,
> +                               port_count * MUX_LINE_OFFSET, "Mux");

...and on top of this where is error checking?

>
>         if(!port_cnt) {
>                 mux_driver.cons = MUX_CONSOLE;
> @@ -474,7 +475,9 @@ static int __init mux_probe(struct parisc_device *dev)
>                 port->iobase    = 0;
>                 port->mapbase   = dev->hpa.start + MUX_OFFSET +
>                                                 (i * MUX_LINE_OFFSET);
> -               port->membase   = ioremap_nocache(port->mapbase, MUX_LINE_OFFSET);
> +               port->membase   = devm_ioremap_nocache(port->dev,
> +                                                      port->mapbase,
> +                                                      MUX_LINE_OFFSET);
>                 port->iotype    = UPIO_MEM;
>                 port->type      = PORT_MUX;
>                 port->irq       = 0;
> @@ -517,10 +520,12 @@ static int __exit mux_remove(struct parisc_device *dev)
>
>                 uart_remove_one_port(&mux_driver, port);
>                 if(port->membase)
> -                       iounmap(port->membase);
> +                       devm_iounmap(port->dev, port->membase);
>         }
>
> -       release_mem_region(dev->hpa.start + MUX_OFFSET, port_count * MUX_LINE_OFFSET);
> +       devm_release_mem_region(&dev->dev,
> +                               dev->hpa.start + MUX_OFFSET,
> +                               port_count * MUX_LINE_OFFSET);
>         return 0;
>  }


-- 
With Best Regards,
Andy Shevchenko
