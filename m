Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EAAC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C40B204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOnyX+EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395170AbfHBPRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:17:02 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34989 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbfHBPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:17:00 -0400
Received: by mail-vs1-f68.google.com with SMTP id u124so51552972vsu.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/2TKAA2eHey/AJMPKbULt2KgA6zmWugOWMLV/zLdIQ=;
        b=MOnyX+ENZwETJxfcOsqblof0a5+oHsd548wkWcaufdcOARpVP6mirV4rDTs4r7nNNz
         Q9PYFbuq0inCJjPWfvp39vJaHis4Nu+BLljBFrXmXlRwNDQQgCs69XrFlq414pfJRcaX
         ut5O1R9I3YkEUZ/nYExGXOuKC2JyQ/8GLhadgne5IeTAfdTLisHwcSrN5RuUDDyORs8e
         uviMnn0lHnuUeweHEmQg3w2gWVpi8/DCOGJ8MtKbxy0FKVf/WycngUTDR9yiAbo5zRcQ
         nO2R/Nx/Idv316NUzQqBsUUwRnfk/xMUvir/CPfTu7KmcA67Fw6b7kl6/iRqnN7j78zO
         CB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/2TKAA2eHey/AJMPKbULt2KgA6zmWugOWMLV/zLdIQ=;
        b=opR9PceD1N4OYSi0xaN4Yv/FVrnWA22LmvSGNdWrBMr5ATFszh4gIbuvU79SonBkht
         weMyytM73EZ4w0fR/x3BEyNwDTFE+WKV3dWNJpo61JNU8jo+L8qafUAp8Ca0MfUllbco
         +Z5drH29vGHQ7Nfnb6PNqfGeFTjcnKAyUgbenWlXQ0eBK519J63axDftpzV/Dbhm/NL4
         LZ4wIEhRpiBTWZuiTbOn9VNHeSCWsccSzQ3cyGv4ab7VAUaZ3T6tN78AB0W4y3ceZmwE
         vqQUTX5yYWS4gi+J84FPH5/SQjWfEOXA8m/le4nHQoUH76wsn7zWyfOi3u557Ys/jLPA
         sQ1Q==
X-Gm-Message-State: APjAAAVK0ghuHJTBn9s/bP0TzpCB9n/Z0HgRFpa10IUHG8Fh1OCCT3BR
        lBu2/oW3qQRTisUfSwUlbdClA5NZFd0+Wiepd3Tx1Q==
X-Google-Smtp-Source: APXvYqx9frm06YF1N5D53ooE2tPKeuM65QVyErgco5333MettoQsWU5nOdnhCLPi/9YXZJUk29Ou7PZ2QcY3Y8ZMcrw=
X-Received: by 2002:a67:8709:: with SMTP id j9mr86962584vsd.35.1564759019207;
 Fri, 02 Aug 2019 08:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190729000123.GA23902@embeddedor>
In-Reply-To: <20190729000123.GA23902@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 17:16:22 +0200
Message-ID: <CAPDyKFo9UjyiCrWpB2Xid=tWdZ3GUgdO7pnzrZ4JEKm7nPZAww@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 at 02:01, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/mmc/host/atmel-mci.c: In function 'atmci_get_cap':
> drivers/mmc/host/atmel-mci.c:2415:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.has_odd_clk_div = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2416:2: note: here
>   case 0x400:
>   ^~~~
> drivers/mmc/host/atmel-mci.c:2422:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.has_highspeed = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2423:2: note: here
>   case 0x200:
>   ^~~~
> drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.need_notbusy_for_read_ops = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2427:2: note: here
>   case 0x100:
>   ^~~~
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 9ee0bc0ce6d0..c26fbe5f2222 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2413,6 +2413,7 @@ static void atmci_get_cap(struct atmel_mci *host)
>         case 0x600:
>         case 0x500:
>                 host->caps.has_odd_clk_div = 1;
> +               /* Fall through */
>         case 0x400:
>         case 0x300:
>                 host->caps.has_dma_conf_reg = 1;
> @@ -2420,13 +2421,16 @@ static void atmci_get_cap(struct atmel_mci *host)
>                 host->caps.has_cfg_reg = 1;
>                 host->caps.has_cstor_reg = 1;
>                 host->caps.has_highspeed = 1;
> +               /* Fall through */
>         case 0x200:
>                 host->caps.has_rwproof = 1;
>                 host->caps.need_blksz_mul_4 = 0;
>                 host->caps.need_notbusy_for_read_ops = 1;
> +               /* Fall through */
>         case 0x100:
>                 host->caps.has_bad_data_ordering = 0;
>                 host->caps.need_reset_after_xfer = 0;
> +               /* Fall through */
>         case 0x0:
>                 break;
>         default:
> --
> 2.22.0
>
