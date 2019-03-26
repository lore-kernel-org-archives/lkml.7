Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1348C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5822075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD8t/kKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbfCZOom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:44:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35190 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:44:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so13245825wmd.0;
        Tue, 26 Mar 2019 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Vqy2Dy2bc2ahOyVVYsBMTFTMSbfvsk4qhtd2C/HsgM=;
        b=UD8t/kKdjfYjFUaek/OnOn8pI6ma/NKXMPCCPxVs24wVQwGaDfazRlxd0BBjCKdj4N
         qvGjhlMohF4FzaOQXEmi4jlShqSIEGRXwB5Ttd+VTHecIRrFNzqHQ8negbO07a9hAmfO
         UwgirAyiZTUjy89NqdpQQkLPHbfKhnPUzEEKkA49+/v82nMTpWooB9Pi0KWNtuAWvFqy
         XkjsXd6x0mwsPDem/LDBzxYnFTP+XFJnow8Z+D3R+Ep+Ilv+QRHbzBvWm2ueVfCbJIFp
         RqNizNfa3C1Vp80kqRkvbGyBjmZzvpifJSSMGs5l8bnx+8a8fy/imlnOS+7N6682uvd9
         sSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Vqy2Dy2bc2ahOyVVYsBMTFTMSbfvsk4qhtd2C/HsgM=;
        b=Db3wVEytWBCezxspRy4GOhR8m0df3w6kiam9kpiLmN8n5EHT9tsx5OtjeGV0EcV8fJ
         AoDw28qv/vInla9sKqWfI7yAaiN9bi1e2uBi0Bk7D495ddD6fCqlqzPuwY/N5JpSzgoY
         HYBcU6PyrQr450JZkzj+Nuz9wo6tw99tR3tXZoFlJmFOnhV1onKOY+1tLLk7Ltkk1+23
         iOE4URNFVBFHmBsuCdhWZ7NpoCpUAFDknG9hC7+39S/ak6ruwvEuyE7AYM689YqpPdmt
         n2fTt2IDpiZ2JdeGKK1UO19vkosmizPKqsT4fj6DHJ7waYhmb+j1YO0OY4QiztVEv8YO
         HL3w==
X-Gm-Message-State: APjAAAW/e/lk8aXeNZZep/aPnOrP9nQvGibbnF8DuY2bDonMysXlGjna
        tOuJ+4+GYRpYK3jsSPFz2n+wuvu6
X-Google-Smtp-Source: APXvYqz3rzy8GkHURLClJqIhDy+VpKhhYrBNVEXg7RL5Gr6xx9H2qhjjO5WYot9XSAI0nBunCcQVOw==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr9343301wmh.142.1553611479777;
        Tue, 26 Mar 2019 07:44:39 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id j184sm28745548wma.47.2019.03.26.07.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 07:44:38 -0700 (PDT)
Date:   Tue, 26 Mar 2019 15:44:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Randolph =?utf-8?Q?Maa=C3=9Fen?= <gaireg@gaireg.de>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: change chip select action order
Message-ID: <20190326144437.GA21654@ulmo>
References: <20190326143050.26232-1-gaireg@gaireg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20190326143050.26232-1-gaireg@gaireg.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 03:30:50PM +0100, Randolph Maa=C3=9Fen wrote:
> To transfer via SPI the tegra20-slink driver first sets the command
> register, which contains the chip select value, and after that the
> command2 register, which contains the chip select line. This leads to a
> small spike in the chip selct 0 line between the set of the value and
> the selection of the chip select line.
>=20
> This commit changes the order of the register writes so that first the
> chip select line is chosen and then the value is set, removing the
> spike.
>=20
> Signed-off-by: Randolph Maa=C3=9Fen <gaireg@gaireg.de>
> ---
>  drivers/spi/spi-tegra20-slink.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Looks good to me. Adding Sowjanya who has been looking into SPI
recently.

Thierry

> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-sl=
ink.c
> index 1427f343b39a..6d4679126213 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -717,9 +717,6 @@ static int tegra_slink_start_transfer_one(struct spi_=
device *spi,
>  	command2 =3D tspi->command2_reg;
>  	command2 &=3D ~(SLINK_RXEN | SLINK_TXEN);
> =20
> -	tegra_slink_writel(tspi, command, SLINK_COMMAND);
> -	tspi->command_reg =3D command;
> -
>  	tspi->cur_direction =3D 0;
>  	if (t->rx_buf) {
>  		command2 |=3D SLINK_RXEN;
> @@ -729,9 +726,18 @@ static int tegra_slink_start_transfer_one(struct spi=
_device *spi,
>  		command2 |=3D SLINK_TXEN;
>  		tspi->cur_direction |=3D DATA_DIR_TX;
>  	}
> +
> +	/*
> +	 * Writing to the command2 register bevore the command register prevents
> +	 * a spike in chip_select line 0. This selects the chip_select line
> +	 * before changing the chip_select value.
> +	 */
>  	tegra_slink_writel(tspi, command2, SLINK_COMMAND2);
>  	tspi->command2_reg =3D command2;
> =20
> +	tegra_slink_writel(tspi, command, SLINK_COMMAND);
> +	tspi->command_reg =3D command;
> +
>  	if (total_fifo_words > SLINK_FIFO_DEPTH)
>  		ret =3D tegra_slink_start_dma_based_transfer(tspi, t);
>  	else
> --=20
> 2.11.0
>=20

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyaOtEACgkQ3SOs138+
s6EE1A//Xgtd5RAaeIlQE1iF6N1TrDkckZBMA+MGB//cbClQCbyK/qoGPSCz+9hz
yariyY0fQlISkIFU2WEHbsI+j5DnKQFZoL7+It+jFyjKDx133yqwCH2RvFVu3GRK
S6NWE2LpRZyj2lCf3wa8YIOuY/vCylF4V8SHjXinhDwfYKkollLOj5tbh9y4vwTz
wOcTBEEc2/TqTZQkMeCQcLrSWT1RgKLwMtSxw/8UlOtOAd+Q9WZ+/aRgfpk2aKH7
WlmCCfdsT+Jg7i10S/vpXJpelGq6sgSB6oTsTFvyGyyLADMkeVfWjsLb67KKHPkQ
FspCeXI+Gz8sPd3eSPpoF+6yBiXAWuQ3xIrk2TJW1ZhcqpIUGc91zHl5zmY9loLL
Zej3ruowHgSMZLdNtw0EzZRqnDkOzz+itkvxPiKUa3T1hJtPierXmHoNlDU/mEtL
uYaPB3CRNOTqXaZT8lcYfRSn15WvcvI4F5wXmQhTY6Dn9bHtt9+qK1mL0/IYGciz
xwrc0E2IuBgwiQzn1EpmsMY++VmWYJuX+1qr2guc9Ol32Ki8cTaHlQ5pVs4x0p1e
+8iAAPF6E3gxdLrJApbc1bgxJ6/EbuC/69bzH23nxQNxJ2A1+rRr41Ba9lYpGT9y
0YceWTQZfq08wPve6U/pEUX913qYJUzAHL+181fUMs89rfdNmh4=
=nMZ4
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
