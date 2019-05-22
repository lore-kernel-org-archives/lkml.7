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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3701C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88CC2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkJ5CRTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfEVNCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:02:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34529 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbfEVNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:02:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so4679382wma.1;
        Wed, 22 May 2019 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zz2ioNCmFjTofhgAEdFd1DNbCCZtg7y/SkQgjZjgen8=;
        b=TkJ5CRTSAWfj0ZAj451i0uhm61l2H3n1Mu9cnQUoiYfa50CImxukOpezOjU2zXiiW+
         FJvlk7b4PkIVSwRyYgtuIdMWiuujz8u8PjYOFbtEIiFO8h0UcH5CVrAqZ0EwxOGLVTps
         WCAX/bRRx5txFxJWN6m7R8aOYIfvPyDWhKex5NzR/ygLfcaaQO+qFRDjDbJrG47LqMlV
         062Bs0uqTlWcGhwm2g3AfqDp4V5za8moRlJuSZVz8AHV4sShoi6cBbur3s+fSvJCuQrp
         PDUekaDds2HS+ILpC06CdX6ypZwE1nKPZLo+G2FekerwB3wGvAv6KxliKUV/xw33VSke
         iM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zz2ioNCmFjTofhgAEdFd1DNbCCZtg7y/SkQgjZjgen8=;
        b=pk5PBDI9apVp+0VXuD9ClnfalW1ytB7MrYq5Qk2Lvb3aFx2hS81WjWTVZLXWWA8ZSJ
         3TnnH1j/oChWFD3MiFHhG96R8DkGYR72h0rqF89dGGtXyeg6ZpJfaCuY6K9WRLZrwUhS
         lcEdAwcoaxWVV4MEyRYN8F4c729RG9ZK34EQSPIBc+tV/pOSCPyM0is/amaM8CMTjnSz
         +j6ckjCG2uviSpAPqXCR7TWFIhpqKZxGtl85/5zOAqXMwGbBJ2GIvtumi2TasrKReSxp
         3KsgxYBvgVwGumP449g5Lu5I0kmyN1FJHPbAGyE28trhYIzUuxvlTy4rpZOq4BzP0vch
         aZ9w==
X-Gm-Message-State: APjAAAXD3udbFR/yO0P13pQkfP65nB6Md65AcBJ8WKaWXrStXS38cmfi
        W1AJC7kIAUvzV1yDrJjLzKN8oB1rYpw=
X-Google-Smtp-Source: APXvYqxZlsNkCTKAmXzZdvS0mNzmxdAyOMYhcK/FhRONnLBvNlvlG5AXKJLKeHRRg6+tMo8NC7M0Bw==
X-Received: by 2002:a7b:c5c4:: with SMTP id n4mr7047109wmk.151.1558530157149;
        Wed, 22 May 2019 06:02:37 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id o4sm7618503wmo.20.2019.05.22.06.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:02:36 -0700 (PDT)
Date:   Wed, 22 May 2019 15:02:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 08/12] soc/tegra: pmc: allow support for more tegra
 wake models
Message-ID: <20190522130235.GK30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-9-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-9-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:19PM -0700, Sowjanya Komatineni wrote:
> This patch allows to create separate irq_set_wake and irq_set_type
> implementations for different tegra designs PMC that has different
> wake models which require difference wake registers and different
> programming sequence.
>=20
> AOWAKE model support is available for Tegra186 and Tegra194 only
> and it resides within PMC and supports tiered wake architecture.
>=20
> Tegra210 and prior tegra designs uses PMC directly to receive wake
> events and coordinate the wake sequence.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

One more thing...

> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 5648e5c09ef5..f77ce4b827e3 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -235,6 +235,8 @@ struct tegra_pmc_soc {
>  	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
>  				   struct device_node *np,
>  				   bool invert);
> +	int (*pmc_irq_set_wake)(struct irq_data *data, unsigned int on);
> +	int (*pmc_irq_set_type)(struct irq_data *data, unsigned int type);

=2E.. drop the pmc_ prefix here. These are part of a struct tegra_pmc_soc
structure, so that pmc_ is redundant.

Thierry

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlSGsACgkQ3SOs138+
s6HxsxAAn4FIWyy16hYAw8H5oy8A4vJGWv2gUZTS5idKN2eKFrehhGUPdUkde3yg
zLfZM3pkzQ3vCHI6t9D3zBJv14CTwZjDCBXPSOCoiNDuy23YagCfpXAhqNz5hKOV
4iUTJNKGlHpLnNCG3WXRtzIJgbzNfN+bKuvHA1BuB+QLzejZfkMbS2BuW/Y43NxM
DX5zGG1VgCdDpX9vmSPYY2PvQdpjdXC/0JRYyOtK/3K4R8yb/oavoHIQoCBOyYN6
7PS6/jHI3gz5HI+nVcoYRTxfZ7RT/lbsATd8xKVlDpfYkKxSwOxFjzeHaBfs486N
PtP8CN0wfU5990qNERI3k1yf855GzH3+JwBiO5bV3QmpbNCCjm3+dMnmKKGBSXhs
ktiEkVwrhh75zMULkAkzvWEGbRp0/AM9gegASee6fbPgIr1X6Pctz1ss2MqRB0CI
u15VXwKSIl6JCQ0levuFkJM71GpAlW5jacRegl6+wUGgJh/YIjN4guV/2HJnaWdB
xrfD830h+fVSKHChbNRx02j5Y2x7/PnijTKLcjXIT6X5QBSeF3jB2ygXx+omcXuu
bcz/LG5gPXqe7nsmaaYwTWbrGa6qFqODT7bZdbooEWMmEQLV07zt2FPr1a7SSKrd
E2cGoh3GWoKQLcRc1W7qkLUusgIulOl1VjS1MThxutpHxc54fFs=
=I9/r
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--
