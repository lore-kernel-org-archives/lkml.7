Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F5DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58388215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WO3yaL50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfICPLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:11:13 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36129 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfICPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:11:12 -0400
Received: by mail-ua1-f65.google.com with SMTP id n6so2201100uaq.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D3e9W2yeYksy0f4fuNlRYAPcfLR8aSNbO/EU86R0hP4=;
        b=WO3yaL50caVRPNVVzECDC1KIYPSQoV/F/kmIrCspE7EpXM29WGxFHYDjMLBRTOcwWR
         /HDfH528vagRQJqA41CrJe3/GSu3MzBR4zrmCXJuNTzcH2jeXniIEpG7NXknajc8mHUt
         ak1CtU1+Fqfjmjp62RHNsgmkgWDWurtv+l/UlKP4e0RJEMtJQ9fs6DK1uPhx/D7ckQlD
         X15jTqnfvUwMdE6veV6PXWW+SujPbHo+BXVLG2O7bauSrqc2eEHpFDDATBRRkRWYUcha
         0w5iGr3k/BvfuScoE2q1GJaNcz97lo3GkFZZZHAams/1Nwwh7UWCl1t+XttNuoE09jJW
         Ea+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D3e9W2yeYksy0f4fuNlRYAPcfLR8aSNbO/EU86R0hP4=;
        b=gT5jpQYdnqaRpd+VUudCFgqZIYg3PHjyHWVoadUv68HXpsr9gvmzrKOWaxzLKRb1t9
         PFui/Y8sMKb8hLu686wipy7t4X9t8AkciWZkic71WUN5WMUNTXIzLuet7Lrie76MTagu
         70pVtsLV8KYGENNk2uVx5QdTIptB3OS1bqzRswU7YTFk2YKvvY95ZdBwSW8CuHwEg1UB
         CcAih+q9T2Xxqxk3Wk9HyM6a4RSHJOxzmD5uErGXr8r+pNfG5o0IHVW3S4lzFc+nyKUc
         r9PVwXJFvS2uC79c/CRUT91YvqZg+rfN2orgC1qeLcwmMEq4trrLBU8rHkv3tMDy//lP
         BfBA==
X-Gm-Message-State: APjAAAVyVTvJhfht0pfYdxeKuHZAVgTaGqZczWUchucBw1vFKbdaGapE
        bbuQ5TwCrdawYRetYxXQJisf5WdyE9BOdpSj8d+5sMmY
X-Google-Smtp-Source: APXvYqzZVbNhOosd22YGLbO9TXiU0/LmjJ+fiNJ65ysBR9g7sb/vcJNqesHJIz9Axt0Evic7ko3VJu8vP0VDM325ZeY=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr17513945uar.104.1567523471452;
 Tue, 03 Sep 2019 08:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190829183634.3376-1-tszucs@protonmail.ch>
In-Reply-To: <20190829183634.3376-1-tszucs@protonmail.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Sep 2019 17:10:35 +0200
Message-ID: <CAPDyKFpRtzS3CXAi4jKjyPOEd5KjCZ1Vqpi_fmm-F+O8eAqbmQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhi: fill in actual_clock
To:     =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 at 20:36, Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch> =
wrote:
>
> Save set clock in mmc_host actual_clock enabling exporting it via debugfs=
.
> This will indicate the precise SD clock in I/O settings rather than only =
the
> sometimes misleading requested clock.
>
> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
> index 64d3b5fb7fe5..4c9774dbcfc1 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -124,7 +124,7 @@ static unsigned int renesas_sdhi_clk_update(struct tm=
io_mmc_host *host,
>  {
>         struct renesas_sdhi *priv =3D host_to_priv(host);
>         unsigned int freq, diff, best_freq =3D 0, diff_min =3D ~0;
> -       int i, ret;
> +       int i;
>
>         /* tested only on R-Car Gen2+ currently; may work for others */
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> @@ -153,9 +153,9 @@ static unsigned int renesas_sdhi_clk_update(struct tm=
io_mmc_host *host,
>                 }
>         }
>
> -       ret =3D clk_set_rate(priv->clk, best_freq);
> +       clk_set_rate(priv->clk, best_freq);
>
> -       return ret =3D=3D 0 ? best_freq : clk_get_rate(priv->clk);
> +       return clk_get_rate(priv->clk);
>  }
>
>  static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
> @@ -166,10 +166,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_=
host *host,
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
>                 sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>
> -       if (new_clock =3D=3D 0)
> +       if (new_clock =3D=3D 0) {
> +               host->mmc->actual_clock =3D 0;
>                 goto out;
> +       }
>
> -       clock =3D renesas_sdhi_clk_update(host, new_clock) / 512;
> +       host->mmc->actual_clock =3D renesas_sdhi_clk_update(host, new_clo=
ck);
> +       clock =3D host->mmc->actual_clock / 512;
>
>         for (clk =3D 0x80000080; new_clock >=3D (clock << 1); clk >>=3D 1=
)
>                 clock <<=3D 1;
> --
> 2.11.0
>
