Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F993C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D71217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P98WmS/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfDEDFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:05:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41732 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfDEDFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:05:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so4330796otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 20:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acerVwGXVYRB1QaSa8rRXqPFWxvmvFOp/eGpIp+tp1I=;
        b=P98WmS/rusRQerU4Rn+NTuayxV0xqBtlyHwlIZ8efPQZ7iEFjnJIHZY4ljgFX3q07v
         1Ba0VIe7q8AtcYh0KzGCkS/zCoVxmueWti833UrczBI/sqmsCSw0dsMwxMpGXhKyaChq
         d29rmmME/Xi1VsdvMZjiP7MkDVLNhxJW1FSseaZVygBfQ6O1P73eBJfmH0h3VjH5Osts
         IKEdJ4vhc5E+MBKrmzCj//PbofS7H3gnOolmkpGV1mjZSKXxEDoi7TuGYli2hZY/ChRN
         Tj1CkkTaUhz0khvD+Bo45wL1NH+KhdAnNx/4OPw7vsgrFHd0Gr4aQ0i2SLHvOy0Y8oDU
         CcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acerVwGXVYRB1QaSa8rRXqPFWxvmvFOp/eGpIp+tp1I=;
        b=QBtomcWr9b5VeVyQa3agJVofS/X+/DroUGr0VLF/sOPhCXvrJw5ab+lBoQUTN3p3oL
         rIOTl3d62Zgy0zuxe7pG2SaAySx7gXh3n+jMfAlccUiWjllOYsCSkKh9K4U5WS34GBz8
         ksR1hWGCQ2cB2dbxO8u+T0LW85gtDvGtt8Q6NsXLi4huzrywL4NNmjlRAl/9Ms6GsYec
         7zlf1TpE2UhijNj+3MYOXymzR6DJO6E2Jpy7dDiANOSAXWn46okzpX8CsgVtUy8sYseo
         fOkdFoDjbrFuJIjXkpbCGHgyCu8xI9iJI8/Hrx4+m1TI/5SRcdcHvn/tRVXLqW6KTCW+
         hJXw==
X-Gm-Message-State: APjAAAWsXMrh2wP85VG2tXfNskzzQ28VuPrXkTySbS3nVQGwYPciwVfc
        r0fwBoRzPGJaBqK5ryo0DetQx0TJrL0jfAhVEB0=
X-Google-Smtp-Source: APXvYqyw9jbEWw+A2nLH/1Kay9ZHogPE7kiq6p5epmpD2BoZeHe3lOkKuZYnxKwHe8shtTsqB2QJf+Aswr5rhrT90a8=
X-Received: by 2002:a9d:68cb:: with SMTP id i11mr6758007oto.237.1554433537604;
 Thu, 04 Apr 2019 20:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190404185235.5257-1-nilhase25@gmail.com>
In-Reply-To: <20190404185235.5257-1-nilhase25@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 5 Apr 2019 11:05:26 +0800
Message-ID: <CAJsYDVKHmW7TtvuUb8mhZ0X1Or15EEA39eNtQqVf9F8vqVoEig@mail.gmail.com>
Subject: Re: [PATCH] MT7621-SPI: spi-mt7621: Fix alignment and style problems
 Fixed Coding function and style issues
To:     Nilesh Hase <nilhase25@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>, Stefan Roese <sr@denx.de>,
        sankalpnegi2310@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Apr 5, 2019 at 2:53 AM Nilesh Hase <nilhase25@gmail.com> wrote:
>
> Fix checkpatch issues: "CHECK: Alignment should match open parenthesis"
>
> Signed-off-by: Nilesh Hase <nilhase25@gmail.com>
> ---
>  drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
> index b509f9fe3346..6fa9876f5a92 100644
> --- a/drivers/staging/mt7621-spi/spi-mt7621.c
> +++ b/drivers/staging/mt7621-spi/spi-mt7621.c
FYI This file doesn't exist now. The driver has been moved into
drivers/spi by this commit:
cbd66c626e16 spi: mt7621: Move SPI driver out of staging

It's in linux-next-20190329 and later tags.
> @@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
>         struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
>
>         if ((spi->max_speed_hz == 0) ||
> -               (spi->max_speed_hz > (rs->sys_freq / 2)))
> +           (spi->max_speed_hz > (rs->sys_freq / 2)))
>                 spi->max_speed_hz = (rs->sys_freq / 2);
>
>         if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
> --
> 2.20.1
>
Regards,
 Chuanhong Guo
