Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85174C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A03220716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvJa+Phx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLSMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:54:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43651 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLSMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:54:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so5845717wre.10;
        Thu, 19 Dec 2019 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a9bVfZ7WMzX1N8f5a3GxdlpzITsSd1uqvrT666b5bSc=;
        b=FvJa+PhxdC8ihoWSKM3n9dXy0YMA4fKnQushxe+SLNtkWXqk1edq8JLm85xFzYUDHv
         qPW77paxcPfPHP3uVyZ5XWg0/ut+jXe99fjg+HdI31/9iVxq3kjGwHz+FwAUzj1S0tLe
         w75yPChMiDTpUGFuLrio7JMLbGkcHHxGIFTW1gK73yxQg4UokDbddz34X9pzbaxZZSkv
         cFyo13jfszsI8TfOinFNCbXS2VN30R54zQTTupAsJNTlYuPGyY51iZIJrg+og5c8PRAp
         j4fUfK6UPVOLduMd1RDk9F8mB0mGL083A1IN/xsYpobn4094IGee2pNmy4iEvYcUPxGc
         gW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9bVfZ7WMzX1N8f5a3GxdlpzITsSd1uqvrT666b5bSc=;
        b=TAzaaB+UrLse109rsbZ6h940nU5JbO6VByzkZZn2ex9d2ZKTSseum7UHTWh475hsQ9
         jCg5R97lrrEUROnwvFNNUaWgvmuiVgr7y0gxF5ytJ7x2vmQ3nwo6BpmXKGljGIx6uwC5
         ujF/3Qwuzn2GUbD15L9eIFxNk6ri3TAkqU3tqlkKGzy5zjpqH5LyaauJDabE1Dyqaj8y
         QryEjKUvayalhDMNAeyGYVGAYBSFksGl45X8XIomA1KySD7pGTm6KOWqEq9mpepSa5Wg
         boUs6ja3iXJxwBZoiBeXAHCs8tWVcH/D4FOm+LlNkDBLjrWl+GT8RwXnslaDZlHzmo5s
         hutw==
X-Gm-Message-State: APjAAAVz6ZS09kjJp3t/Rdk7nHnyBV5+ydFkRyWxtzPMOiMNMFKHKJbn
        KmetDhHUL6Wc1DdItiJA+1E=
X-Google-Smtp-Source: APXvYqxY6psW3Cwj0AtWfU3NArY5Wgpa1nJcjvh8Or7IXttLBPwHNaBFS5JKPGE7GrGsCqvf99Wx/g==
X-Received: by 2002:adf:c147:: with SMTP id w7mr9567593wre.389.1576760079184;
        Thu, 19 Dec 2019 04:54:39 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id n67sm6148229wmf.46.2019.12.19.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 04:54:37 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:54:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] usb: phy: tegra: Perform general clean up of the
 code
Message-ID: <20191219125437.GB1440537@ulmo>
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20191218175313.16235-4-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 08:53:12PM +0300, Dmitry Osipenko wrote:
> This patch fixes few dozens of legit checkpatch warnings, adds missed
> handling of potential error-cases, fixes ULPI clk-prepare refcounting and
> prettifies code where makes sense. All these clean-up changes are quite
> minor and do not fix any problems.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/phy/phy-tegra-usb.c | 367 +++++++++++++++++---------------
>  1 file changed, 197 insertions(+), 170 deletions(-)

This could've been multiple patches to make it easier to review, but
either way:

Acked-by: Thierry Reding <treding@nvidia.com>

One minor comment below...

> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-=
usb.c
> index 15bd253d53c9..76949dbbbdc2 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
[...]
> @@ -310,13 +315,16 @@ static void ulpi_close(struct tegra_usb_phy *phy)
>  	}
>  }
> =20
> -static void utmip_pad_power_on(struct tegra_usb_phy *phy)
> +static int utmip_pad_power_on(struct tegra_usb_phy *phy)
>  {
> -	unsigned long val, flags;
> -	void __iomem *base =3D phy->pad_regs;
>  	struct tegra_utmip_config *config =3D phy->config;
> +	void __iomem *base =3D phy->pad_regs;
> +	unsigned long val, flags;

I think technically the "val" variable would have to be u32 because
that's what readl() and writel() operate on. That could be a separate
patch, though and isn't really a big problem.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37cw0ACgkQ3SOs138+
s6HXoQ//enaIv+19+8YhDuO73TpetmdsTfhTcNwIw276WtV7j53pQ/KcHAKir3H7
PBCui7fiZXLj2b90PFucEjenupecmSC07u1Gc2pjTHCYWSHJLr2N0EDNkUiina00
9ebxKCNPttnMFZAdcCldRTQ/lgDF6crUUoXpwSc+j9n6Pl+OhMFb3XhQ2/NNYPaM
D7MnZU0sz4zN3/OcaBX42nhENrG6bUqXChImGkfAZnxXQgjFFLpR3GYjMX0pMy3g
j+c3Q35I8QE9QbHmIyOEWuX94wc/j1ZUQbw3KmQwGQdx+OfAShvjynj4x+orA85o
6cIF/WVoQk4ybulnKOvh7RkXf10BoNgQz17a6Nq0JSWMR8ju4XjmL1L9RN6hFcgC
dq4cs8H4RFVMVX4Rb9cbbqysF3oMHKyIBbxLf3gw82KeVVT70/fZ0fpwyaKR9dDk
6Cui0PlS8Eb/Ya5RC9rMmXOQQtUyXXtwVeNS3ye3fXC5uGNsSWqVrn/mUz1SR/FB
5/qoq7jtk4wNzRMz6LsUW6iRLSYpnZZrgK73wAlM6pPJykwsq3Hjx4KrVDrgMiGH
A9ZvXLkIeDWLKa6/d8GCvRvnb3jy7W5ivez65Ut1zDCkPh1ASqnOrEjlsAr7BT5z
lcidEPxRLCoAj1GIK6LYYZgWDSpxoPulrnDbySY5l5MRgZBZNU8=
=nQyV
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
