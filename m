Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E1C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA492168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+anzo/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfFNPur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:50:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36026 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNPuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:50:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so2817316wmm.1;
        Fri, 14 Jun 2019 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e2XcDuwIyNAh57NBRLkL6rwxqRee1n0foFF5ZrRtRWI=;
        b=m+anzo/0NhjK3a5J5QJExf6oEWBHOxnYsrV0KdY0yuTaZqWMTK7J9rbAgyd1Yyn9vE
         D3JOz6hm0mAKACo4/i4FXmljdjPipx2c9x2eRO+9AO1Yw3iaJAQpV7QIJNkLvqmPMGlx
         8ZQN18xIZ0MmUSNc2mGipMKi5a9Ec51ZTbmmnM0hLo/6tvXZkK6l3WgMUrlIHw3xJEer
         9ireQccv3r69JxMkZUSkq8k6ZX4guI/BJn4qisfaFPjwHBp5z+hJyC62t9W9cwGRhH10
         19nEmqHJ8BdpmGQ+i3bNp+vy7oPMAuAijRiUYw1EbzebMUdrnrHGaHCTs91kwJj1OxRA
         JxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e2XcDuwIyNAh57NBRLkL6rwxqRee1n0foFF5ZrRtRWI=;
        b=H1AR8lwlYLQE6wFEYrVi4iwpAYjfD/TzZHzWyTy+JAUZLZ6HW47/1lnTXetNbYHwke
         NKis+Z4n29Rvok0wPKO/tF7opOI3bN0jcE6CSE8zeCCDoiVJoHtQTEaDoH/6mdkQCdWk
         KZpJPX4l73ltOPMoyRfymURvgMcT8u8+78MUR9nlYcVjwTFxZmVc2Sc4077QfBsC7Ix/
         6GAW1GO3sWC/98VOMNCgag/vnXg/yxTOr4QYGr3pb7GhyIqkIexx/iT1UK0tb7xktnkP
         NNiZ7dO1w9P/cSu8yRTsB1iynpp6iVoRV6lquKsCGgNm2kz1Ah+UrbYB0VkDIfIp8yym
         P1dw==
X-Gm-Message-State: APjAAAX/biChPecDDtvVpUKG/pNoFDpRTnNipOBDyy27QQiiwd1BPsud
        CZSZw7ZN8ALIpGHdUTjmC+E=
X-Google-Smtp-Source: APXvYqzhXBKor0kJbtvKDs5JRHIZCcjiyXGB01F6+CP/8GkLUmVUKV0LSx/on4F1VppkAP45EcMxZg==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr9038345wmj.13.1560527443712;
        Fri, 14 Jun 2019 08:50:43 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id b6sm2419009wrx.85.2019.06.14.08.50.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 08:50:42 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:50:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bitan Biswas <bbiswas@nvidia.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V1 1/2] mailbox: tegra: hsp: add noirq resume
Message-ID: <20190614155041.GB26922@ulmo>
References: <1560515734-2085-1-git-send-email-bbiswas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <1560515734-2085-1-git-send-email-bbiswas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 05:35:33AM -0700, Bitan Biswas wrote:
> Add noirq resume instead of resume callback for Tegra HSP. Tegra HSP
> resume needs tegra_hsp_doorbell_startup() call to fix timeout error for
> tegra_bpmp_transfer() during genpd resume noirq on jetson-tx2.

s/jetson-tx2/Jetson TX2/?

>=20
> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
> ---
>  drivers/mailbox/tegra-hsp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 91f1a0c..f147374 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -771,10 +771,16 @@ static int tegra_hsp_probe(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> -static int __maybe_unused tegra_hsp_resume(struct device *dev)
> +static int __maybe_unused tegra_hsp_noirq_resume(struct device *dev)

Maybe call this tegra_hsp_resume_noirq() to match the naming of the
dev_pm_ops callback?

>  {
>  	struct tegra_hsp *hsp =3D dev_get_drvdata(dev);
>  	unsigned int i;
> +	struct tegra_hsp_doorbell *db;
> +
> +	list_for_each_entry(db, &hsp->doorbells, list) {
> +		if (db && db->channel.chan)
> +			tegra_hsp_doorbell_startup(db->channel.chan);
> +	}
> =20
>  	for (i =3D 0; i < hsp->num_sm; i++) {
>  		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[i];
> @@ -786,7 +792,9 @@ static int __maybe_unused tegra_hsp_resume(struct dev=
ice *dev)
>  	return 0;
>  }
> =20
> -static SIMPLE_DEV_PM_OPS(tegra_hsp_pm_ops, NULL, tegra_hsp_resume);
> +static const struct dev_pm_ops tegra_hsp_pm_ops =3D {
> +	.resume_noirq   =3D tegra_hsp_noirq_resume,

There seems to be two extra spaces before that =3D.

Thierry

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0DwlEACgkQ3SOs138+
s6FF9hAAiJ4bYQf3muX8DROz4Scc57EGDwt0MelsUs6uPgSREWy1pruYby4Ynmub
9bT2rhXcUZYDRHZTKqnwhgl1juMnbMMjfCWfjrbE68/2sX/6td5/qYhwCiUVq0uK
4j0rlF1SgzlqIoeEWaZaVVpxiWGuh192MH1NVacIYQvJvanWhlFxJzeO9yUKX5eb
5hDxA6MrLsU9hGx3GS8GJ64Df8mfHJOy3kZ6sACOaBY/w03oB3kU3GB6LIW3B/ck
ds5wx6VLvrfw1OCuM0jlijd7aFM72/u3Gv6U0kGLmXhAaptOZtSYYGVCTcbKlCL6
mwY6ryNasRgWIIk7S7Ni2ilTo9AJaHzmf4dL/XlXgPVAK7QDHKzRm3CYu5hjCmMx
c/WBwP9Cme+/ZtI3TK/gvEBtWwdHOsLDb+kpfE8GFHCFQ2exigovGEqMy+Fscqrl
9Vs7wGoVHFEKZafXike8rFB6otmdEhRhEh0+nFVXFmn4kqa2ZeTdsettOGRmXowR
o0FB4D4bHESnGmPzv2DpD8ievqDM9jFy2blj762OjxwITNw3V6AtQ47Ay9IYNOz0
L609ZNxyqi45+6PyYUkuIIj6XR0Ny/TaAHQCkzIUDMtbg4guV9qnVr9XQxytgm9H
hnCI5uBSdK4M9nv3eFFGSsgwBnIf9sc3+Zxl12TELCvroW5MJEQ=
=IXnu
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
