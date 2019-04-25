Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859FCC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D742084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4lNdIqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfDYLWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:22:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39011 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDYLWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:22:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id a9so12197965wrp.6;
        Thu, 25 Apr 2019 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=67J0Z4ZEik2WQWI4viGlV4CYN3Vqgn32ck65yVg2Ryk=;
        b=C4lNdIqEXOtZICoJRnAzIgvi6vefwcrZ0W1cnl2rTD9UkraVXVznFkPIcSKU3zsaEd
         UlC9cx26fHzw21HIoqS/u/62R8FxGJYbTm4/btXbIjMkTbP3IWbJasSNZxXrdCDGj3AD
         7rGmo8sU20eylzswE03x3EtvwfiYbextAKUJqEpWRvgLfdruqdHIOD11HP6JxszjdERM
         fzdQlKh1HEYkt00Bs7X42siRenFrVJMYEYVou4vI0T0iW70csSuKusgzO4KfWjoJMIkQ
         Ojl2qUc6Z7ajaRc+8ej3QMCnO97pJolrBGUOJ5QJChPPt/w+/2aLJqPz0n8MWO8XQ+Yo
         nDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=67J0Z4ZEik2WQWI4viGlV4CYN3Vqgn32ck65yVg2Ryk=;
        b=RgLHG8fxBERVeWc9FgnZdzYZLIZjwwLB49rsN6v7O0mxQIA1UGcp7GrRqRA3amozUW
         27ZIor5kk3hsIlW2Fc6OnCShxVWKkeO838d2oWf83N+UFNvSBsfJr7+D1ZA9K8hymZfn
         0dhENivgli6HgzxBJgnod18w3gHM+rhNjWVsaxkjhaPVrPM3ALbEv9TQIDl5xvuL0OGM
         OojCjyrgc4nqTA8ip9DIs1kKC+RQhm1hb0C8t6bMkK75B1rtHtjG0aurIAUvW8PNTlBS
         P2UzGE/TORNJA7WvQbVvfET++Eaa7FbnO3DUVi/ODGOwXILyBgbenfZc1x7a7+/JnFIT
         cxoA==
X-Gm-Message-State: APjAAAXoMlPXLRAVKHgnp/hDuryl4jlLmSH4lnTLPK+aBdpwH6ce1oR/
        dxerAODrivLAI5yt7/m91q0=
X-Google-Smtp-Source: APXvYqyx9CXHzRNex2LMeG4s/wD2FJLWDY1Apztj1v10rOiJ6YbrOtsSMbShRYvO19pc2Q8fuWfT/g==
X-Received: by 2002:adf:b611:: with SMTP id f17mr1325159wre.162.1556191364153;
        Thu, 25 Apr 2019 04:22:44 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z74sm33056914wmc.2.2019.04.25.04.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 04:22:43 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:22:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] mfd: max77620: Provide system power-off
 functionality
Message-ID: <20190425112241.GA10218@ulmo>
References: <20190424224900.8018-1-digetx@gmail.com>
 <20190424224900.8018-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20190424224900.8018-7-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 01:49:00AM +0300, Dmitry Osipenko wrote:
> Provide system power-off functionality that allows to turn off machine
> gracefully.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/max77620.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> index 9b0009c29610..e56223bde568 100644
> --- a/drivers/mfd/max77620.c
> +++ b/drivers/mfd/max77620.c
> @@ -37,6 +37,8 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> =20
> +static struct max77620_chip *max77620_scratch;
> +
>  static const struct resource gpio_resources[] =3D {
>  	DEFINE_RES_IRQ(MAX77620_IRQ_TOP_GPIO),
>  };
> @@ -481,6 +483,15 @@ static int max77620_read_es_version(struct max77620_=
chip *chip)
>  	return ret;
>  }
> =20
> +static void max77620_pm_power_off(void)
> +{
> +	struct max77620_chip *chip =3D max77620_scratch;
> +
> +	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
> +			   MAX77620_ONOFFCNFG1_SFT_RST,
> +			   MAX77620_ONOFFCNFG1_SFT_RST);
> +}

I think this is only partially correct. See here for a driver that I had
proposed a while back:

	https://github.com/thierryreding/linux/commit/d0eaa77b402f62bd236d76e3edeb=
3ccf296cbe81

Note that that driver is part of a larger series to move away from all
the pm_power_off hackery. There was a fair bit of discussion back when I
proposed the original power off driver for max77620:

	https://lkml.org/lkml/2017/1/12/470

I think I may have a more up-to-date local branch of the system-power
branch from my github repository if you're interested in looking at some
of that code. There wasn't a whole lot of feedback on the patches, but
the feedback I did get was generally positive. However, since it didn't
gain any traction I eventually abandoned that effort. It might be worth
picking it up again, since, as far as I can tell, the situation around
power off and restart hasn't changed in the meantime.

Thierry

> +
>  static int max77620_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -488,6 +499,7 @@ static int max77620_probe(struct i2c_client *client,
>  	struct max77620_chip *chip;
>  	const struct mfd_cell *mfd_cells;
>  	int n_mfd_cells;
> +	bool pm_off;
>  	int ret;
> =20
>  	chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> @@ -554,6 +566,13 @@ static int max77620_probe(struct i2c_client *client,
>  		return ret;
>  	}
> =20
> +	pm_off =3D of_property_read_bool(client->dev.of_node,
> +				       "maxim,system-power-controller");
> +	if (pm_off && !pm_power_off) {
> +		max77620_scratch =3D chip;
> +		pm_power_off =3D max77620_pm_power_off;
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.21.0
>=20

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzBmH4ACgkQ3SOs138+
s6FW4Q//WwGUmKeVX9G+JztP+onk6z3UHZYwUuKhumFVhdbzSPwmjvhzyU8cG44z
+n+aremYlkCHa+wQbZHe55kBqke9GFOUOWswgfYZIwRYzyMxklrNYHLaCjKnDiRU
0tstURpNyaYhGSKAWez5jAxJgZOBNJsn6VRiu9nc6dj3DlqtXG5azGdDXArwyZhn
7C3suAH9ktZ2wfFM3fZ8sI30of24Bqx4qgf1mRrxhS1dJtipQUwMyVAsFehf54c8
YsyDMbL4b4H4UtcsM+gF6lfyRFfakcMz9D6bzj2jdMfxYYRf/tz94FnQb4x8oMXX
O/FohlW3UyOCxjjXIrIibkC/z6C/0YI1zjwwesNsIg3qz1KaoUjbFvfyfNfk2Xzy
zmtEhwiHxAqxxVlemzYbiqFMtbWA+7FSKMycC3peszvQ4GbDgg3Masd42D4YFBFE
dIDG7qe6rVYCL7+lCYJVIgdO0DuaOkzqEmzZkSeO3iRFhO/24ZzUp6Y9fk3jcCn9
QxJb6L5pkWHRhJvqQEDM4tX6bj8XfYhhd0rY3AfOC4CRQiAz/5n/SRcCy+wYAHGE
HfO89UuNhAz75Md+jQCXUzevDvJcLBn7z/I4QZ4Is4qKcVlSwrRfbSxWmsTwVjz7
IfWA+z3BgnkARPUJZGZ41XhYKa/jVLMudMuc2vI7bbGUsolJuGo=
=2OHv
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
