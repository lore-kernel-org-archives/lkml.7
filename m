Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AF0C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E742184D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfCMIfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:35:16 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45081 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfCMIfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:35:16 -0400
Received: by mail-vs1-f65.google.com with SMTP id n14so484150vsp.12;
        Wed, 13 Mar 2019 01:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0iSqXJx8+z6SHwhSAJ48Nf3VAnrfBTdURCZr2r2inds=;
        b=b5KC4xUIf2PoFq3oqwNdar7Appp/vrun0emIMWVOrLpsEZRV/mAXT8w4o5nX2Wvrpt
         E6G7E6PLKJbOmOttzg7f6Uk8C2ibUXFiP7Ov7En4tZy3dufvI/54HV1u34PoaHVxnX86
         m9ZcbKQf1nGckfPIWSu6OPOJxrn1aqCI/q7g2j1Bof13I235a5/ksp1nUedwRSR/3KtS
         0YwuAeqp8rRUM+Uz7da4zNB8LGv5wxpgARdaibV9Cr5sFqCNmccNYbOOFdDVPDuV8BVv
         cv9894c9yM9oqJdLiZdzfKXbPJvBk4+pyEorXaO8l9QOE5b+ljKquMcHi2AdFFFJEpV4
         /bFA==
X-Gm-Message-State: APjAAAVWiSXFfyIqXSCJopLpBPCufnHh2zYc2JJEzh6oOTPKTNL5Gqi+
        RxTmFFyVAkohqQVDiI2b/XezHSZyOzrATX8RJ1g=
X-Google-Smtp-Source: APXvYqwXkwdvu49wXECKnDBE8WMcazYYxaXeoPD48glQZQ89yvhJqWXUrxdEufBxfCxr6qeJPY/1se77CiFxlYSkkHM=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr22441363vsp.166.1552466113131;
 Wed, 13 Mar 2019 01:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190312184331.13755-1-geert+renesas@glider.be>
In-Reply-To: <20190312184331.13755-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Mar 2019 09:35:00 +0100
Message-ID: <CAMuHMdUPEjtzq8wVz7aHQdohdZiXZA3e7GrVS5TnHZ3Y-HsFAg@mail.gmail.com>
Subject: Re: [PATCH] spi: rspi: Fix register initialization while runtime-suspended
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 7:43 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The Renesas RSPI/QSPI driver performs SPI controller register
> initialization in its spi_operations.setup() callback, without calling
> pm_runtime_get_sync() first, which may cause spurious failures.
>
> So far this went unnoticed, as this SPI controller is typically used
> with a single SPI NOR FLASH containing the boot loader:
>   1. If the device's module clock is still enabled (left enabled by the
>      bootloader, and not yet disabled by the clk_disable_unused() late
>      initcall), register initialization succeeds,
>   2. If the device's module clock is disabled, register writes don't
>      seem to cause lock-ups or crashes.
>      Data received in the first SPI message may be corrupted, though.
>      Subsequent SPI messages seem to be OK.
>      E.g. on r8a7791/koelsch, one bit is lost while receiving the 6th
>      byte of the JEDEC ID for the s25fl512s FLASH, corrupting that byte
>      and all later bytes.  But until commit a2126b0a010905e5 ("mtd:
>      spi-nor: refine Spansion S25FL512S ID"), the 6th byte was not
>      considered for FLASH identification.
>
> Fix this by moving all initialization from the .setup() to the
> .prepare_message() callback.  The latter is always called after the
> device has been runtime-resumed by the SPI core.
>
> This also makes the driver follow the rule that .setup() must not change
> global driver state or register values, as that might break a transfer
> in progress.
>
> Fixes: 490c97747d5dc77d ("spi: rspi: Add runtime PM support, using spi core auto_runtime_pm")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is a fix for v5.1-rc1, as a2126b0a010905e5 will be in v5.1-rc1.
> ---
>  drivers/spi/spi-rspi.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 556870dcdf7995f8..b30fed824e6643a2 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -868,28 +868,6 @@ static int qspi_transfer_one(struct spi_controller *ctlr,
>         }
>  }
>
> -static int rspi_setup(struct spi_device *spi)
> -{
> -       struct rspi_data *rspi = spi_controller_get_devdata(spi->controller);
> -
> -       rspi->max_speed_hz = spi->max_speed_hz;
> -
> -       rspi->spcmd = SPCMD_SSLKP;
> -       if (spi->mode & SPI_CPOL)
> -               rspi->spcmd |= SPCMD_CPOL;
> -       if (spi->mode & SPI_CPHA)
> -               rspi->spcmd |= SPCMD_CPHA;
> -
> -       /* CMOS output mode and MOSI signal from previous transfer */
> -       rspi->sppcr = 0;
> -       if (spi->mode & SPI_LOOP)
> -               rspi->sppcr |= SPPCR_SPLP;
> -
> -       set_config_register(rspi, 8);
> -
> -       return 0;
> -}
> -
>  static u16 qspi_transfer_mode(const struct spi_transfer *xfer)
>  {
>         if (xfer->tx_buf)
> @@ -959,8 +937,24 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
>                                 struct spi_message *msg)
>  {
>         struct rspi_data *rspi = spi_controller_get_devdata(ctlr);
> +       struct spi_device *spi = msg->spi;
>         int ret;
>
> +       rspi->max_speed_hz = spi->max_speed_hz;
> +
> +       rspi->spcmd = SPCMD_SSLKP;
> +       if (spi->mode & SPI_CPOL)
> +               rspi->spcmd |= SPCMD_CPOL;
> +       if (spi->mode & SPI_CPHA)
> +               rspi->spcmd |= SPCMD_CPHA;
> +
> +       /* CMOS output mode and MOSI signal from previous transfer */
> +       rspi->sppcr = 0;
> +       if (spi->mode & SPI_LOOP)
> +               rspi->sppcr |= SPPCR_SPLP;
> +
> +       set_config_register(rspi, 8);

Probably some of the operations in the (SoC-specific) set_config_register()
could be moved to .prepare_transfer_hardware(), but that can be done
in a future optimization.

> +
>         if (msg->spi->mode &
>             (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)) {
>                 /* Setup sequencer for messages with multiple transfer modes */
> @@ -1267,7 +1261,6 @@ static int rspi_probe(struct platform_device *pdev)
>         init_waitqueue_head(&rspi->wait);
>
>         ctlr->bus_num = pdev->id;
> -       ctlr->setup = rspi_setup;
>         ctlr->auto_runtime_pm = true;
>         ctlr->transfer_one = ops->transfer_one;
>         ctlr->prepare_message = rspi_prepare_message;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
