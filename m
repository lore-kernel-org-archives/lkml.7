Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF96C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C647217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFgRj5Nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbfISIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:40:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38661 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbfISIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:40:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id a23so2428443edv.5;
        Thu, 19 Sep 2019 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6gxprrxxWhNaep2gy6TkOgQmUEnXSE534x9gzQ10xM=;
        b=mFgRj5Nlqr4bPXljsKYcy6ZCY1XvPCnSsO1GMuxYyC3GfAMTblXf/a3EhcAElHiHYq
         x8O+jB0pNrZgvE6Shik4JDsS+4QRwFRqSz3zhiRZk/QfXwDUeRZVKrzdCHrV+YGqEh26
         EUf5WHpnuxb4ibWqE+rp4SBlL1rVeGUNTzDYzmRfRsvAXeP+39sFD+XlKJVKMKbDMGwO
         3RHZuFtsIzopkTDCyCmTvvsfj18EAKqb1MbDDQz8e2ak2aSEVrkTUnfZp7AJSoXK0Bmq
         EsM1iq9xWoXVpNfsRE2kc3X+sOmAVzycY/DNyQ/SYt15fsSn3VKC9THtQ8TZMSIvJXkn
         Dw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6gxprrxxWhNaep2gy6TkOgQmUEnXSE534x9gzQ10xM=;
        b=et9gS0IOFxLj8j4KuyppJ1TpA4JgXwbSvQzU2BF3njK/p6fbcSCQmBmdMwamS9splX
         F/xf5cKIuWdP3QzTYNB9VpyU3AjsueSU5YKChZDEbE6GMXg+POGjonjbv/S9xhPw0dje
         8Qe8LXDvl8UHJI2+MB91cH2FX2+/801ulnngMdojNRblGnN9Rr18ZBYrqHyhmQ5N0jSS
         GhrfGsoFFfLUiCDu0Qr/Aia5n/tCbLR25NvTXQK3moWbAjFnHKJ8V2jsz1W0w03Rfra2
         X/CfAEHeqbM2JJ0Kd1fuJ9W2s5IcR8RosQnhhfPjIXHsG3j15pLHdE1KywHDOKB1Md6L
         1pww==
X-Gm-Message-State: APjAAAUhq2AJNKQdbUlqirhOSB1P7bf2qZNFjVbeFoQXG+zJQHb6/L0q
        Vkzvfen1eDNK38xy2LtBlNVGD6x3
X-Google-Smtp-Source: APXvYqxoR5lUv9djP6jltC8gTYY7JsELTOjRd1IWs5TPBa8JWr/cg8E3TBCq9CiBiqs74XErNO6m8g==
X-Received: by 2002:a17:906:2ccc:: with SMTP id r12mr909850ejr.219.1568882406611;
        Thu, 19 Sep 2019 01:40:06 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id a20sm1492487edt.95.2019.09.19.01.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 01:40:05 -0700 (PDT)
Date:   Thu, 19 Sep 2019 10:40:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch V2] soc/tegra: fuse: Add fuse clock check in
 tegra_fuse_readl
Message-ID: <20190919084003.GA5041@ulmo>
References: <1567508212-1194-1-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <1567508212-1194-1-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 04:26:52PM +0530, Nagarjuna Kristam wrote:
> tegra_fuse_readl() can be called from drivers at any time. If this API is
> called before tegra_fuse_probe(), we end up enabling clock before it is
> registered. Add check for fuse clock in tegra_fuse_readl() and return
> corresponding error if any.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
> 	- Added Null and other error checks for fuse->clk.
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Hi ARM-SoC maintainers,

can you pick this up as a bugfix for v5.4-rc1? Would you prefer to pick
it up directly or do you want a pull request for this?

The patchwork link is:

	http://patchwork.ozlabs.org/patch/1156928/

And in that case:

Acked-by: Thierry Reding <treding@nvidia.com>

Thanks,
Thierry

> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse=
/fuse-tegra.c
> index 3eb44e6..58996c6 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -186,9 +186,12 @@ u32 __init tegra_fuse_read_early(unsigned int offset)
> =20
>  int tegra_fuse_readl(unsigned long offset, u32 *value)
>  {
> -	if (!fuse->read)
> +	if (!fuse->read || !fuse->clk)
>  		return -EPROBE_DEFER;
> =20
> +	if (IS_ERR(fuse->clk))
> +		return PTR_ERR(fuse->clk);
> +
>  	*value =3D fuse->read(fuse, offset);
> =20
>  	return 0;
> --=20
> 2.7.4
>=20

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2DPuAACgkQ3SOs138+
s6GmAg/+Jhj7yV6aaQ9kxLakkr2/Th9Tz8TCfLK/J6wyD1YDS+AV8shbj0xqaJ+9
dyfl226iOR8PVxbjjSFe0w7oiUNooDVS8HpQrrvGgMqCoZLX5eewx9krafWilYzc
sq0ayCUteJjJ4FjygmoBkaKDyqXqosYnXMr3NMC7f6uXBBUTbQKAcO6Mg0igk1Ss
OkV2Pa1W771tKqlWyPAQy/DLXDeKsvp/mW2DId9GZhJw8pgToZUcCNiJoL2yFPmq
KsZBE4mxacIelukWGjYaGwufIP4r8qKSzp/99aYOM+dmhToKPGZG1XDQMNDseatM
7yNBKguVXZatZbHy8wXseC6LZy8KhDY5xOeNhZK5Im5sff30Egs1RKMj+NAZgrNo
Js4quAlLe0SqWf4sOC3iiPrqa1VctDKttd1mQg3rx2svu7Rg6AFD55zcNyy9R6Mm
tMXO5wi/G8Wd776caNI9jL2vZth/29P/hs+3Wo6HZ3p+KtiaVdUIMAgG2wcK6mkQ
r/kmk6d+nlrKL6WLNJLASmgeV6Hw3QCiOj5HWxCfhUvjA+0edcANinlxUNl20Wbe
AVd30Pkh8ISJxO7Kls+zGfDiTqsPmNZn/+i/rlHE6BUw2Rhjze9Wl3w3qMfrV485
EgpG8wYwsomtCX4DBdNsZaAo5UdfxyDPwXDZZIecEAstyJ67ymw=
=W88y
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
