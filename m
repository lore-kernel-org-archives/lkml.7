Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94704C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694D1205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILXi7Xaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfE0OFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:05:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39705 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE0OFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:05:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id e2so8303150wrv.6;
        Mon, 27 May 2019 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6hb/vstt/ckjUS8P3ICK1pDxDvXAAKGAvOGmGjTozso=;
        b=ILXi7XaabQUJqUxjZfUsX5+MLPvqGwZoDgOIVgTx+k7VxIBmaTM/qoIDHDIpssg4fb
         ayOHxS9IMhO6c1hVx3UxATna7KBU4t7Gf3NysO9sYzQIfBnEiQStAqEypOpJMzv3TKBL
         78fr1EcLtajpbpDQS/BaD46tpODku5rob0V0FnLNm9XGRIpGlSETrWIcnNlmN79jAB3M
         whtEHmX2yHqVeRMd3cvxJIyVnkb3FdZ5BgBh9ERK9btPlsaMgA/+7kgwrzeez34a6ne9
         eCU7GZf+gtIDQHOZdpX/tz5RkMAYK3US8Ce7Ibj0W/WcAU5YzU3k0EHkPevX//ZiJtyd
         lCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6hb/vstt/ckjUS8P3ICK1pDxDvXAAKGAvOGmGjTozso=;
        b=CW7xy8sZlRFXuZ9FoSL3KdQCEy1ZlbjlyvvjDK2rqSFfkGNi0AJ5sPkQoDwmePvb5W
         Z2+IrDR5gesAB0JqJp3Fmmi2uptx821QPWL8iy5yVV1Q3yWLlFNsUbB8Bg3f7xkRJFbu
         wfXI94gAbgbddhelLzvvBmXzBIYEAmdR0ifHGEmK5xe65QbBL1LJvBSc6brdAsbZwwlL
         Dvxk4+26tPqT2Jd3DHyQpeuTly0EaY6o2FWPpE9DV2jsmvKIqJa65JyyUS4hWDl8DYhA
         cKcDslA14IqHyQwBXKnJ0bws6GsXIGN4kKKfSP5eDzLIPoXEjnplZx4v/UmqIczj9UON
         pKrA==
X-Gm-Message-State: APjAAAXaP2hruuclSzZ8N1q5FYE3ElDB4R1BAZh6FqoInC+Tla656wHO
        oBIUlQE2TS9o8ElP3TrhdpM=
X-Google-Smtp-Source: APXvYqzgoVqrwLdg/mjCyGNk8/7Z7B4scH8z/XC+PUSO/6lo6kJLx3qIlP+ss41dIHMQ78GrhQL/QQ==
X-Received: by 2002:a5d:4581:: with SMTP id p1mr2672975wrq.228.1558965951119;
        Mon, 27 May 2019 07:05:51 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n7sm233080wrw.64.2019.05.27.07.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 07:05:50 -0700 (PDT)
Date:   Mon, 27 May 2019 16:05:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] tegra-hsp: fix a missing-check bug in
 tegra_hsp_doorbell_create()
Message-ID: <20190527140549.GA7202@ulmo>
References: <20190527130430.GA5367@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20190527130430.GA5367@zhanggen-UX430UQ>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 09:04:30PM +0800, Gen Zhang wrote:
> In tegra_hsp_doorbell_create(), 'db->name' is allocated by=20
> devm_kstrdup_const(). It returns NULL when fails. So 'db->name' should
> be checked.
>=20
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 11fc9fd..b613c46 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -292,6 +292,8 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, cons=
t char *name,
>  	db->channel.hsp =3D hsp;
> =20
>  	db->name =3D devm_kstrdup_const(hsp->dev, name, GFP_KERNEL);
> +	if (!db->name)
> +		return ERR_PTR(-ENOMEM);

I don't think this could ever happen, since name is always from .rodata
and hence devm_kstrdup_const() never returns NULL. But formally this is
correct, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzr7rcACgkQ3SOs138+
s6Hd8A//fg5fcdNI/oAjJsmTdTg0zepmc4GvUXAhcMbvB9yGHL0jCumWWMS/UgyZ
8s8z5+3IBQUJl3WvIgJuzhuP5wS0EnmF3XHrNjMRMAACoemXlwPRQ/4BR6dQnxBx
0REskkPLrqdEs3t4RAtVZVJhBTAm3jlWCXpFXImfzLcHqRYvNuTayj6iuT/twxMx
ZZXMD5LUZkQJzauVU7MD4+CcvYwQNB6lOa97N1W32ueHiO4kjOdgEPHkzWxyTn7S
oCsCYmIPSFUgsq4rLRKsVzap6oQ0WglVRmvOqv7D8EgNYglw3frxwynVBP0TVGxp
U3wXBrOSzk8MktqYbSJkFuzooE1xY59fq5V8SLu/RIP0tePQRnsL/0GdoDgswd1W
FBmqSHqSEwVBmkCAJh3B8ZPGRK5rTfTNs+PPEXLfCIuaOQ2fK1KXKfr7QDASj7oo
Fyfk4APGqaxVIOhhL1kVWG94x5QQbWQnFB4SWw3aupHMn+N3Z2+4qBSYSOs2m+lo
vwAeA1ugvNvACRuQZ0rxZ41tylo8JooLM/DehkoDQk2vkG233GBQ4znJOPOTTF7d
ZKF6nByrDvhQ3dfEkPV5wUF8T3a+pvh5Ajh+Nv60jR7LHsvQkOlqGgOjDGW4ARsm
QaZqeSHavaxFs82nyD4d2JnHyUwbdRzmsHz0Yir93EKhnd/QGTQ=
=dYIV
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
