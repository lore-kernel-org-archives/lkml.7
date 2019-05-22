Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C83C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE6520675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyqOX/4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfEVMMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:12:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34604 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:12:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so4577071wma.1;
        Wed, 22 May 2019 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYJ/nfLJmC0TO4NxJBMrWMFh/gFCCFsSv70Uxc0987w=;
        b=PyqOX/4ULp2JocPc9hXbAAKRX5O4NlZPPJ7z4JLHjvsemaFkFJISs8BQYk+BJUCYCs
         bCM+VvhjF+99wgiQmtejmA04Ubb+d13qBUlgu+Y+y4l3Cva8Ra97LTzF/UALFa1rWs0m
         6nv6qaAP4MIS0yYK6K7TzelyUxRHzczYV2oE0bySqNJXh7EoQXYV3D3uQUTGb3IuHbA/
         fsGYCSjw8aYIaUO18h1ZEUdOrprgO2ofPVHUt6U7AWxNywJZvWo92Lwc6EJ3eFujmiAy
         A+jYIeNZyNT+3n7uQPYI2LU73S9qKYAC7hcUzPsr6C9Bz7Xlc7HnXAK39mHILdakBas1
         AjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYJ/nfLJmC0TO4NxJBMrWMFh/gFCCFsSv70Uxc0987w=;
        b=Eqxery9mpOE92lk5tFw5oXurCvuuKy6lVYUhFLqgCTYYzBdcT0eeEV5jRbpf5yv6RO
         LpDtvH7Rj7QQWu7t2H3C8+Jav1x8z9rHq2unI2KXj2auWes1rLpIqRM2IsNliMeL73/G
         ploSdUvh8QKZttx12nN7lPZw6Evqm+Ju2TyBZvAe4kvK+G84bWtY9vd51C4vqi7W9KRC
         Aehl1aXo6rUVSmOCQzNoGm0AEchEi6QVCdbKQ7oP4qiTsMxomcHQn80FLbQf0LLuie/o
         ANKF/1p2SBe95WL1b/hZhbdP/g39M+C30nHJPdcy2m4iKe06nTgCAY3oyGDxLlDsHQbw
         Twyg==
X-Gm-Message-State: APjAAAW5/SGJFhjXU750Xmd3MXL/XUg/a85xdoKBJpxoMLUm+2B3Vcug
        SNvkaEAL3JWwEQ0k0M4oMBSrzL7XlcU=
X-Google-Smtp-Source: APXvYqxmKP+GGWbxBpsL8AStwplVS0GJXZdRxJt5kLUNJD4wOC2fq/RqLj35RRPrRqjGcpcZAHY04Q==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr7147520wmi.53.1558527165510;
        Wed, 22 May 2019 05:12:45 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id k8sm12373106wrp.74.2019.05.22.05.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 05:12:44 -0700 (PDT)
Date:   Wed, 22 May 2019 14:12:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 01/12] irqchip: tegra: do not disable COP IRQ during
 suspend
Message-ID: <20190522121243.GG30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:12PM -0700, Sowjanya Komatineni wrote:
> BPMP-lite still need IRQ function to finish SC7 suspend sequence for
> Tegra210.
>=20
> This patch has fix for leaving the COP IRQ enabled for Tegra210 during
> interrupt controller suspend operation.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/irqchip/irq-tegra.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
> index 0abc0cd1c32e..1882373fa1fd 100644
> --- a/drivers/irqchip/irq-tegra.c
> +++ b/drivers/irqchip/irq-tegra.c
> @@ -53,18 +53,24 @@ static unsigned int num_ictlrs;
> =20
>  struct tegra_ictlr_soc {
>  	unsigned int num_ictlrs;
> +	bool has_bpmpl;

Maybe spell out "has_bpmp_lite" to avoid potential confusion.

>  };
> =20
> +static const struct tegra_ictlr_soc *soc;
> +

Can you make this a field in struct tegra_ictlr_info to avoid having too
many global variables?

>  static const struct tegra_ictlr_soc tegra20_ictlr_soc =3D {
>  	.num_ictlrs =3D 4,
> +	.has_bpmpl =3D false,
>  };
> =20
>  static const struct tegra_ictlr_soc tegra30_ictlr_soc =3D {
>  	.num_ictlrs =3D 5,
> +	.has_bpmpl =3D false,
>  };
> =20
>  static const struct tegra_ictlr_soc tegra210_ictlr_soc =3D {
>  	.num_ictlrs =3D 6,
> +	.has_bpmpl =3D true,
>  };
> =20
>  static const struct of_device_id ictlr_matches[] =3D {
> @@ -157,7 +163,8 @@ static int tegra_ictlr_suspend(void)
>  		lic->cop_iep[i] =3D readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
> =20
>  		/* Disable COP interrupts */
> -		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
> +		if (!soc->has_bpmpl)
> +			writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);

Maybe adjust the comment to explain. It may not immediately be obvious
to anyone how BPMP-lite is related to COP.

> =20
>  		/* Disable CPU interrupts */
>  		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
> @@ -286,7 +293,6 @@ static int __init tegra_ictlr_init(struct device_node=
 *node,
>  {
>  	struct irq_domain *parent_domain, *domain;
>  	const struct of_device_id *match;
> -	const struct tegra_ictlr_soc *soc;

As mentioned above, perhaps keep this here and assign this to lic->soc
later on so that we have only a single global variable.

Thierry

>  	unsigned int i;
>  	int err;
> =20
> --=20
> 2.7.4
>=20

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlPLgACgkQ3SOs138+
s6FoVxAAookjMpqnfDG8CiztrIQhY+NnonposNlGzUzMMfITDrIXCPxZikwnX0R5
Fk+HZ0QBMLlstRckRGmlZVy30odomy2zJjs4jtpfzSRWT21CRQsS/QaJCtQEXcVk
DQAz7llb8GneFENSJouMasmRvcwxPw0Myxe2em/pPV9T7LF7J2tHKtaLZgooukgs
+hy0W7J4iRadjrOdB3iB6kiTvjzUO/KYrhmKWJardD+DFkB/BY/qXHhzcuQU5U//
oFRF4d+b1sso/vbQMrKQistPSUuFH0NPgVy5izBMII+raawK9nXQT1kJRQsivzuB
i6X2nk5csj+QLleuUEtWA5RQ/Z5O5xT/vzorns17oYpx7lBYHQzLJZDhKHi1a7w4
BqaUwfA2Uj0Gq1V5gQx52jW/4wQLHtLInE/QPd2dODMO0nYVKcU5aGc4w5a+i9n2
UMABedHzNDUH7u5MiIY8TgXCV5hePHrNJJvdv25uh0eXjBt680IKWtM1QcTTRifK
7FoVaJA8sukrlw7iufYlK4hNhteFPT5MIMyKo4SK45BIjT+ElKMxNBLDQr29lFD/
jN8yFV5MEk5bJMk6skAyAs1ja00OnhSs5aT9HNXftjUlq/k0B4kCXWDgKx5T+4+D
l+oecslt/E41gZdJ5X1A6F1adulcHzlzHWLMSZrqvG8uEd+4NYE=
=kbZY
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--
