Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E33C74A44
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEAC20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbTQ+Azt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfGNPkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:40:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41271 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfGNPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:40:11 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so26116803ioj.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4bHQ1Jc5WTGlqwv+kn8JJgmRRoI96dt/IgZ72rjGBA=;
        b=EbTQ+Aztyq+1j51yJyaXlSrersnYBW/r0zoiVuDyu0dByJxIupmw500q+tV1XItn3f
         fGPvHEoox/Z2H3e03WWBHc79byethRqRi+k9uixTxTuO23jbUomxPKTd6GvYAtaiPQ/i
         BsMn4aPMKMHujUFkvPFJLSBEmaL9p1TQgxkZAySXVbi7K49mzgSmmLNPnEmwk6SQ5yEb
         RPT1qxMUSl+rvW9rcrl0PnK4LG/WCY1Agi8HMWmiSVUYe1jxwuT9MAvWrBkS6TR8+nnb
         Yt/QsX/b/hRkM9trNmZDyCSaOIFJGcWZzCLVA70oHtdzYR+04HE81/hQddh/Kfp2ap6x
         5wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4bHQ1Jc5WTGlqwv+kn8JJgmRRoI96dt/IgZ72rjGBA=;
        b=d7cmkzWs6kSfQKCzJTE7lUEIQsavnWcUbvZHDi0qF34vjspar02udBcuQ2fBAGucGV
         1TXMr+NKSPvKwb2NeWdgUv/mpoxmBi79YVukaHHt7fzqv0r3102fJvaz2ZkSuJTY9O35
         HiWQeaCiIoqpyeluElhGbiTIEcDdN9V/Y78+x/b7trivf4jAdORMapqWNjIJIkXXitqz
         54G3xdI2aCxk3RgkK68552sc7lMQ3I4LWDgdQQ58RFVhsVv5Ax4yPKqQkQZiYkx1HjEw
         9aKv3kzJ0KmcH8Dz17S/FzOTS9DLdU+3cZfrsnpLWKyBQ/tdMOVY75tKLpvafaXMr6u4
         IAYA==
X-Gm-Message-State: APjAAAWQ+yQnSzMfuage2IrTq1niVVW+YiU18GlVlKCM7b4vTbDcSCiA
        OWHUhvmifmTYCMJsKtqQ47ATzPJbpl4TEdRbzA==
X-Google-Smtp-Source: APXvYqz5e0ZMsmxeq3BvuV3Veo7tfSZ2IU3WmhirYiJwumXbxG0Wrfs4Jq9gZf52yJ643RUwyL5TZQdr1Y9XVtHMokQ=
X-Received: by 2002:a02:b90e:: with SMTP id v14mr22926814jan.122.1563118811187;
 Sun, 14 Jul 2019 08:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190702133444.444440-1-avifishman70@gmail.com>
In-Reply-To: <20190702133444.444440-1-avifishman70@gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Sun, 14 Jul 2019 18:39:29 +0300
Message-ID: <CAKKbWA7ZLLp4nmcG+rFQbc=f5GWSThoghgF=B5CiunDczYAz3w@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Add Winbond w25q256jvm
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        robimarko@gmail.com, Willis Chai <WillisC@supermicro.com.tw>,
        Jerry Wang <Jerry_Wang@supermicro.com.tw>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor, Boris & Tudor,

I see that you pushed this kind of commit of Winbond chip previously,
can you please approve also this?

On Tue, Jul 2, 2019 at 5:23 PM Avi Fishman <avifishman70@gmail.com> wrote:
>
> Similar to w25q256 (besides not supporting QPI mode) but with different ID.
> The "JVM" suffix is in the datasheet.
> The datasheet indicates DUAL and QUAD are supported.
> https://www.winbond.com/resource-files/w25q256jv%20spi%20revi%2010232018%20plus.pdf
>
> Signed-off-by: Avi Fishman <avifishman70@gmail.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 0c2ec1c21434..ccb217a24404 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2120,6 +2120,8 @@ static const struct flash_info spi_nor_ids[] = {
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


-- 
Regards,
Avi
