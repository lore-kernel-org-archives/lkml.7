Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEDFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E4521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTE/TVhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfCTImQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:42:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38120 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:42:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so1734394wrm.5;
        Wed, 20 Mar 2019 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fy2HKvlE+gyBQ9KS7A/ahLiYfVTIS/H2mk14TrZAuHc=;
        b=GTE/TVhczMAaHRdkrSQC6oOKM7kOdaYHnVb1yPwxtSZiDhlesf4bytQpZ67tqmySFi
         XkEmZrkkJ0wQh8poPxh/VRJ4K2PsIBQkVksHzn8hiQ3D/yQ0g9SQuoVjPQLxwMEXzJSA
         7I8sGqFUsC1GxWZ1v75cPpVrmfCr4QR8oPxSiSqG3COlC2A+oNFoZkmDYicwlJMBxj/A
         /aVg+MBZAeTUZ81y7vzROsk/jBE9airnzPhyRjhTLrIhnFuqaKlxrVKdJpMlBpfUCGM9
         nAypYlCGf21uiJvl6LGDci8/psNLlrbzWere5ukT0CKcEhpno5PWq9HD8ZiZdTDlmN0s
         A3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fy2HKvlE+gyBQ9KS7A/ahLiYfVTIS/H2mk14TrZAuHc=;
        b=smWalAa9eZwcfGJO04mEdxlNTKNlOB8aMeh3LkmqYAkshCdzCNZmftG0LdK0CCmhn+
         P5fr+2P0phPuKvZVbXZtGVfvqqwrCtI3hMptbYQO5gVYpjBitljGW44edfppxseFuXyG
         A8iOzic9+Um3G64qBGtmYPuarzzj8jPm1XouZEucaq6d82HP7ixCnqCaWEgqPMVwyerC
         nuUwRKyT7r3ntoopC2xc5qo+9pFswjORuFiFfcUeNG6Ch8tqd71ehoslw68Nlaks7bsC
         jDPGw+UaLzPQjiy2VghPU1DBEhVDXJAJX3aIT57Qf0wrVESr4JJ9pzbwuzK+K8W9xo/f
         Dt9g==
X-Gm-Message-State: APjAAAVWnzSp4f3DtCbRSqL/TeVZlNQl9Id/wtkDQpy6I4u5RTb/HlD7
        7tLagocTMpNYMQsapbIZ2Ls=
X-Google-Smtp-Source: APXvYqymMJalI/X0Ogrf+nXmwl5cjwYqwEVE2FfxGEdLV9h1O9KVZj2fQoIAkWk3fy6J4D17vLg2zg==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr9054477wrp.268.1553071333941;
        Wed, 20 Mar 2019 01:42:13 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id m15sm1401458wrx.30.2019.03.20.01.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 01:42:13 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:42:11 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jckuo@nvidia.com, kishon@ti.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH -next] phy: tegra: xusb: Make two functions static
Message-ID: <20190320084211.GB6043@ulmo>
References: <20190319153219.4196-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20190319153219.4196-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 11:32:19PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>=20
> Fix sparse warning:
>=20
> drivers/phy/tegra/xusb-tegra186.c:250:6: warning: symbol 'tegra_phy_xusb_=
utmi_pad_power_on' was not declared. Should it be static?
> drivers/phy/tegra/xusb-tegra186.c:281:6: warning: symbol 'tegra_phy_xusb_=
utmi_pad_power_down' was not declared. Should it be static?
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sigh... I evidently need to improve my build scripts.

Acked-by: Thierry Reding <treding@nvidia.com>

> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-t=
egra186.c
> index 11ad6e4..7a308b4 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -247,7 +247,7 @@ static void tegra186_utmi_bias_pad_power_off(struct t=
egra_xusb_padctl *padctl)
>  	mutex_unlock(&padctl->lock);
>  }
> =20
> -void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
> +static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
>  {
>  	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
>  	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> @@ -278,7 +278,7 @@ void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>  }
> =20
> -void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
> +static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
>  {
>  	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
>  	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> --=20
> 2.7.4
>=20
>=20

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyR/OMACgkQ3SOs138+
s6EFXg//e+QC0f53RB2Uvq0TIRG2Hv8pWteQzCdIfGJo0BsysI7l9RiMkUJLzT/r
/0DkeOg3DpiOcivXXqaOONggMduMqLwFIVML5+yupRjZ0NooFzZd3Dz7twi50lpc
dSjIvXL0VpVJ4Ii4E20l02zjaMTz5I1sPE9yDTZhWVwEojcAVcsKVIzjzuygZTC4
Gmtb0fR8u/Qc2UVkb0RhUzh3TU/4K900tlp3sKornxW0BEMd9WUTH9R+9R1eq0j6
5e3epfx0BkUIXEDzGE2ggmGsyWGC8HbXgrrWlrmJi2cj/TBV/M6RaEvs+1OOwEBZ
gq3GyAbcMkqrr6IbinF9azw6bnnNX8vxIacD0ohITgWPB1Ui2kl2UuPRrWP547jc
Sq4cqLPOiz58Hy5HuI368XgC4XgJY29A60Rm6OH9rhzDt48B3idfP+nUELzeJEbG
hiAI6e+FkUvCGQ+pFsIVjN9+/ft16rB6OHZwHc5QTHgjvOobutDxVywtjrPD12Lm
Wyb67eGPqHAsBrip0IPdGjZ4cQeGzhUL2gAFPicP2tY7EeyYor8ToFGpvgkIjB2V
YfHi6DKvL1jhCNOAk+RzWZq4bTLuSFPEYqord9qup8Js4nadBL8gAzZdLOdkHTDx
k4lbsJ+P4zZSo3DE4Ej7kOQC4Tgwj1jXbi1vsvBgP989A9JbGXA=
=NJhj
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
