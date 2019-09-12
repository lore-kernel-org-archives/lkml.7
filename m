Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8263CC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561F220693
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXZlHbQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfILQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 12:38:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43740 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbfILQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:38:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id l22so30308122qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ye6xQQ/sF83reTDnUCyM55UC2Rr32BLp4JT0MbP8r90=;
        b=GXZlHbQgjETSzC5lbRTxmInSczNYwP3qQkCLCxDBOf52E/Ta/DZ7l+gyiv+1rDWWzQ
         lJz/ZR9lur/MfdAB4y14nHz9U4SONByKfkAq8+KksZt5X4MHa/vqOJu6xPHiy8w9WgRs
         TGpngt2JvkKJsfYRcHshqF3XldOGKYGwwkoZO81YKjdHBj5Jb0ld2Bhx23lKy5pEnQM8
         gkBgFD4x3LExP0ca0835cifub8aphE1kLBU840o5E8+nS4vbeZyn9oIsYO9ikRTU+tYx
         m5Xw2KeuNQiNwv858+LIfvMacrEZSqUgyip1qHFCPA+iz6nRDAaFoAID+dSXWk2IFKcJ
         zfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye6xQQ/sF83reTDnUCyM55UC2Rr32BLp4JT0MbP8r90=;
        b=d0gcgqn8ZYh4/pBuVCy7Zcnyn32ChYqTiqZWH8gw6qW0d38HiIeQf0ZNAIPlS87leI
         T9aSDGkCaxavJBr9dFIFx+7mir9PXeqqH607V7Y7qTHV/ZhtLL6XPbniiC5r8HoB2nj+
         d8lqzQrjTv0vkDOAfurOeU6jljGpntwauK5DALJbsxIGuWcCifNAtgKXTZZpAArmy3ZK
         uV1I56bGWXUKTFSqiT4gs/oh2ZRx59kOeAeQT8+Rb1oW1iJL25iv/seZUVk0WbuaO+HO
         EYOJgWAPGdgBl5xdFU+KwZJ7ODeaszBzvrRwx9UT1O0Ru/VC6c0nPgQ4gusIHH9o2Lmn
         6j3g==
X-Gm-Message-State: APjAAAWm/4tj7eaOfQaWQrC9ldiCpqH9kT1020VinfqWyTrmBiAYZaP5
        hC0Z4E0fY5+w0rUjT8QmA7/Hna/WZPKSvV3gum4=
X-Google-Smtp-Source: APXvYqznG6Q1gmsGFY+PyPT+6CqR9jOjznF9RIqjhr26hCasSiqcRUMAK0i93+X0Ac6q23Ye4T0jwrdvZIasBwVvdaI=
X-Received: by 2002:a0c:b49a:: with SMTP id c26mr27598392qve.105.1568306334833;
 Thu, 12 Sep 2019 09:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7euf1kQpwOYiq-he8HveKKzkGdf8_-izEVfwa=QH24a3g@mail.gmail.com>
 <33ec2a52-91aa-6c4a-d900-1725f2970975@xilinx.com>
In-Reply-To: <33ec2a52-91aa-6c4a-d900-1725f2970975@xilinx.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Thu, 12 Sep 2019 12:38:43 -0400
Message-ID: <CAD56B7dvKtqQV9hkKEKB7VgoE8hqQGqMxHZiCXxg0sejUpsNCg@mail.gmail.com>
Subject: Re: Regression: commit c9712e333809 breaks xilinx_uartps
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 9dcc4d855ddd..ece7f6caa994 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -1565,6 +1565,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
> >
> >         cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
> >         if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER) {
> > +               /* If we end up defering then set uartps_major back to 0 */
> > +               uartps_major = 0;
> >                 rc = PTR_ERR(cdns_uart_data->pclk);
> >                 goto err_out_unregister_driver;
> >         }
> >
>
> I expect that this can be problematic for all failures in probe.
> What about this?
Makes sense, this worked for me. Although, I think the patch is
malformed by the email line lengths.

-Paul

> Just setting up global major number if first instance
> pass.
> Also cleanup should be likely done in remove function too.
>
>
>  diff --git a/drivers/tty/serial/xilinx_uartps.c
> b/drivers/tty/serial/xilinx_uartps.c
>  index f145946f659b..c1550b45d59b 100644
>  --- a/drivers/tty/serial/xilinx_uartps.c
>  +++ b/drivers/tty/serial/xilinx_uartps.c
>  @@ -1550,7 +1550,6 @@ static int cdns_uart_probe(struct platform_device
> *pdev)
>                  goto err_out_id;
>          }
>
>  -       uartps_major = cdns_uart_uart_driver->tty_driver->major;
>          cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
>
>          /*
>  @@ -1680,6 +1679,7 @@ static int cdns_uart_probe(struct platform_device
> *pdev)
>                  console_port = NULL;
>   #endif
>
>  +       uartps_major = cdns_uart_uart_driver->tty_driver->major;
>          cdns_uart_data->cts_override =
> of_property_read_bool(pdev->dev.of_node,
>
> "cts-override");
>          return 0;
>
> Thanks,
> Michal
