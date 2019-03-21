Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5759C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7585621874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtWPbhBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfCUPFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:05:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34195 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCUPFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:05:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so7032130wrq.1;
        Thu, 21 Mar 2019 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hv6yaAsToGvbLG7fV3tYjLLtSOAX2hhCHcJKvmm8/j0=;
        b=LtWPbhBbaeM/6kiw9/bf4bT5upFTXnCB8EQOSQRP7fiGhzO/Em2GZsLpbeXs5YJYS+
         nGtGw9uwDXKUUsyUaAEClVCKM1dZ5cephP7SJD6kkKYVHdwESVnt7weUwWmrgtPKqCub
         x0l7MGxrsk404YCfBVvcI5vYeWHh9mKUuNGJ+lrzwE7eZBVvQzmJzbaKwJeuPFQR7A8g
         Q9Ai6RG3xbcfwzBgvgeeKXkwEb5AUVhzASoxhx5RlelrSE6QPsm7ayM1tsRNJ6oj+xc5
         OleHmklbXtgKX1It7sTU+2uuUELLzs1gj/+sfJm3coTAyPBrWMqHvKaP3IILCMg+G7gw
         70rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hv6yaAsToGvbLG7fV3tYjLLtSOAX2hhCHcJKvmm8/j0=;
        b=rbszDyspvrMLZDn+27OV4Cjnp3iZtMsHf9pevhuwSejZ5vSYfFlSZnqOgpn8xdb7Fk
         W7Ec9GRSvDNIEBVcsb72uPpB6NHmtb7DwnrqobsFEaL4iTp4hZSmHximBpTTy3U4VFzb
         zDWlu1ntKHx0GdDQqlzkcUgJ3EejYPpaiNRa+X8BRrmHO2NrCNHlehUjwotBKAICcW7R
         FQgg5a6gXwILQnpqMK+3MuinCV6BP0y7hZ333zG3A3qUMO02auGZrPzYwVH5B/I6i57f
         c0GCI7G2HnpbneN+76gZ2yZcnzyhOwttDzuW95FvYDScJkZEmigT0EEqow6gCwdjfqeL
         CrbQ==
X-Gm-Message-State: APjAAAVlZbelL2jDlWR+pKUiKJtOxsoNFC8yTpCEXUAlIsF/NStnTvU7
        8gU8p3OqMafB8Tfz6/elU+0=
X-Google-Smtp-Source: APXvYqz3hFI/aF9+2vGeU270TQzX6YfvEjR6X1BaASRX5e1HXCnFXFFRoqLo1zkLCKGpUupGH26KXQ==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr2900898wrx.93.1553180739840;
        Thu, 21 Mar 2019 08:05:39 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id a10sm8888479wrs.19.2019.03.21.08.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 08:05:38 -0700 (PDT)
Date:   Thu, 21 Mar 2019 16:05:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] phy: tegra: xusb: fix typo in
 tegra186_usb2_pad_probe()
Message-ID: <20190321150537.GB8939@ulmo>
References: <20190321085436.94975-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <20190321085436.94975-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 08:54:36AM +0000, Wei Yongjun wrote:
> Fix a typo in tegra186_usb2_pad_probe(), 'usb2->clk' should be
> 'priv->usb2_trk_clk'.
>=20
> Fixes: b8998e928030 ("phy: tegra: xusb: Add Tegra186 support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Good catch!

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-t=
egra186.c
> index 11ad6e4e4711..a627fe0b8e54 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -467,8 +467,8 @@ tegra186_usb2_pad_probe(struct tegra_xusb_padctl *pad=
ctl,
>  	}
> =20
>  	priv->usb2_trk_clk =3D devm_clk_get(&pad->dev, "trk");
> -	if (IS_ERR(usb2->clk)) {
> -		err =3D PTR_ERR(usb2->clk);
> +	if (IS_ERR(priv->usb2_trk_clk)) {
> +		err =3D PTR_ERR(priv->usb2_trk_clk);
>  		dev_dbg(&pad->dev, "failed to get usb2 trk clock: %d\n", err);
>  		goto unregister;
>  	}
>=20
>=20
>=20

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyTqD0ACgkQ3SOs138+
s6GUgw/9HS6iD2OHPaeTstUqq7OVEzmQN7eRKd8nYqtSLLswJhubqAlJALcbM2pH
1S3dgKjBNmmEsFcLw293WZuMZHLAXzmX4fdKFYwNAnNmNBQflXQsy0DhAjDtupyK
Fts/ASsmq3EKfunnAhog7Ld9xBIrEBA73ahPjY1nOv+prlpiTuq6oZvx+xSayt6G
uTG1Zl2eBWV1DRwy+oTQo6lqy5OkaRDLRTxdq5Tzv1uwlG3EQ0b18T+cKJR905Pg
PInaYNeJsFuu3pusoHdqcKgwzMmYP/EXXLH6oUcBhX4qHZJoHn0mIz86ZZA97cA6
l6oL0+7ZM28jkbjRN0cHP0C6Zlr0vd2iPCxsz7G5rkr0fiVoHGYVOt6+vLhGCsLI
GRCjYZ0L58fEW90L7nIM/sXKVT5iixS+wRBrxTq9+6ix5AzMnkDFPbiKvQH683ZY
9EyQb8DUye0AKycFME/atCJtsjQF2t85YXEuQxJ3W2EINzPlvkOw/4mJdxR/nKts
2GwOxIw9wF073JegGqXWpe0+T1gaJ71om+pIv3QFhe4rCEgSLklHN0wyLTUf/8uO
+aUkY3CjFIv0rS5vFYUDJAGJSClHd+mY8HYgvTdqmQacC7DppaW7X0YruSVtG1XN
k1SxuHT8YfqNybwgtjeZhRn/7f02DuDVHDhl4g0uTcigXtjJALE=
=VM3Q
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
