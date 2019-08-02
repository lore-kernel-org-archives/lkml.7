Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F336C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41790206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="R3+zgINs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbfHBGKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:10:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33629 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHBGKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:10:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id r6so68565574qtt.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 23:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFWaj3cSyAp5cCruqVAXM269R+jXFA+hpQyudleBW8I=;
        b=R3+zgINs75dLpE9xitGDlrbGtE/wzbCCZrUQRqXd1DkFAauk+rXBs5F/P6isRb82rQ
         fGCdP+uzBdeSYGqQpFlJB3PO3LQtniJfZDwC7aTY1w7I/MNKmSqPPLN5EwZ2gGwtY3KB
         /kjIdOGt+CsMNaXLGf9WLJI4inkssBNReoyCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFWaj3cSyAp5cCruqVAXM269R+jXFA+hpQyudleBW8I=;
        b=K0I3LYmKudq7AQ0K1eRe0pbGG2jFk9X1Pivjme5sOX2J/4UIVuWeIpx/qG21zahvJ5
         TwJz0Yke0o5aT3Rim2/8ceq/JS1oaaEGw5SpvwnsMLU3CoiXuH8jPDVogbvtZxinsQir
         Kgi95Obcttj3cDAfD20SCHcQMiEyix6bMkRGDEKzhutHeFcdIMUN1q9w66We2xv0HOp3
         hrboXS1GfhgZJKI/nzY2gsDveyKY6u5y0M0q9OPPY906QVXoTWYNVvHzWan9c14hpNTN
         9vP9BIXY1BoSIhqK+S8UlNbOkXQr6fyZkZTey/heMVcRd6pDdH6ZbHJf1cg7K/SSjMmo
         P0xg==
X-Gm-Message-State: APjAAAXdEyflv555oBi6A7oVVlJqgptUBeovksmHljuDf58TlxHLuK1+
        Xrp6T3sCxHUMo0AxtwwgK7tYEVp75KPP34Dw4FU=
X-Google-Smtp-Source: APXvYqz7bb22+a5Wv4AkSi0btb/AAI8H35mfK49hqP0WgDG+Ezce+iETXBjueb2NE8qmF9oHprwt/CYIrmsrIe0PbKY=
X-Received: by 2002:a05:6214:1306:: with SMTP id a6mr97906903qvv.38.1564726208597;
 Thu, 01 Aug 2019 23:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190730081832.271125-1-avifishman70@gmail.com>
In-Reply-To: <20190730081832.271125-1-avifishman70@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 2 Aug 2019 06:09:56 +0000
Message-ID: <CACPK8XeqDRNYJC+=xC_XySSTX6mHi5r94UDaeMPQv3DFV1HYQw@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Add Winbond w25q256jvm
To:     Avi Fishman <avifishman70@gmail.com>
Cc:     tudor.ambarus@microchip.com, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        miquel.raynal@bootlin.com, Richard Weinberger <richard@nod.at>,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 at 08:19, Avi Fishman <avifishman70@gmail.com> wrote:
>
> Similar to w25q256 (besides not supporting QPI mode) but with different ID.
> The "JVM" suffix is in the datasheet.
> The datasheet indicates DUAL and QUAD are supported.
> https://www.winbond.com/resource-files/w25q256jv%20spi%20revi%2010232018%20plus.pdf
>
> Signed-off-by: Avi Fishman <avifishman70@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 03cc788511d5..74b41ec92414 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2151,6 +2151,8 @@ static const struct flash_info spi_nor_ids[] = {
>         { "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
>         { "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
>         { "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
> +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
>                         SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
>
> --
> 2.18.0
>
