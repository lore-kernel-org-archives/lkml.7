Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE6CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B14C21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYuZS4nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfKAJuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:50:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42702 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKAJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:50:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id a15so9079263wrf.9;
        Fri, 01 Nov 2019 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zYnFFUu/yRKOCTeyRORXYMNFN+XI69i8FjjNc/RJUws=;
        b=PYuZS4nNyDdvjg4Ecjx/3hPCOKoauW6EfoMWScbZ1HlB5XGz5m6Hj3Du+SbfzURmqi
         MTRMO/mMOzvlLrsB6mWKF1wHPybc0CbMaC+J8P8kawz/+xwYJJflGkmszxfNk2XnjNdP
         2dbSUOfLYyhvxSaJPpbO2aAJ2uWVWsjIe/YkgAsESVXWo8PSFZkkedVZXBz8FtCDNLIg
         b9V7r2MD3zdWKs6FQ5n+9B4EM+7tw7YOWbTwojPvex3/b7bBYxBE2WVu8TC8vJaeb5WE
         xrQuaFCkYRHZSESr69iUOLZ5sSi4PPStRBHCwFMZbxC+dQi+DtpOGPFAxZ8ZtL1mrruI
         Z3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zYnFFUu/yRKOCTeyRORXYMNFN+XI69i8FjjNc/RJUws=;
        b=TjwFrfgnzlkHwcWzD6MamavPu89BeThvaCmjZeyHijFNgJBJmJktHcK0PxWQXDkesl
         ZoclclL1GxNpvQctL3S82kfp62UgJDMPKCdm9sqiGqHNGBI9c699XIAn27A0ogRuNFQn
         T5R2j1AUs6zuEURvQj8/n0nnd5CCKxXGDFu+7JdXCAa60NXpgbrDopOcYunmFXYTqDMZ
         tYWt3/Nje+TjkXN6qEwok8Ah6tJaWLGVDGepQU2iwjRot+ssB2luB2dCFlQAOh2gJM5L
         B/Rk+wC39WA0SVwhoKippQfU5L+Gw4R7ip4pZbVlQYjKlmXXhTMPbcp8KifLTvS2Kii8
         TQEg==
X-Gm-Message-State: APjAAAVPVhZHsxCgs1+7z6ICm44p/vAXSv+UMWoroHa/I1bmbTVF3DYK
        mhWjkE1VQxtAEE6jux8NkaU=
X-Google-Smtp-Source: APXvYqwodVDJz0hKCBc4Cmn9OUpC5RGzuKKGRx9FqsNyzqMOfMwuJTjL7+To/u/BEv+k7Jar9A3iLg==
X-Received: by 2002:adf:f048:: with SMTP id t8mr6179803wro.237.1572601810817;
        Fri, 01 Nov 2019 02:50:10 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r13sm12172283wra.74.2019.11.01.02.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 02:50:09 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:50:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, skomatineni@nvidia.com, digetx@gmail.com,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk: tegra: Fix build error without CONFIG_PM_SLEEP
Message-ID: <20191101095008.GB1167505@ulmo>
References: <20191030125650.36776-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20191030125650.36776-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 08:56:50PM +0800, YueHaibing wrote:
> If CONFIG_PM_SLEEP is n, build fails:
>=20
> drivers/clk/tegra/clk-tegra210.c:3426:13: error:
>  tegra210_clk_suspend undeclared here (not in a function); did you mean t=
egra_clk_ndspeed?
>   .suspend =3D tegra210_clk_suspend,
>              ^~~~~~~~~~~~~~~~~~~~
>              tegra_clk_ndspeed
> drivers/clk/tegra/clk-tegra210.c:3427:12: error:
>  tegra210_clk_resume undeclared here (not in a function); did you mean te=
gra210_clk_suspend?
>   .resume =3D tegra210_clk_resume,
>=20
> Use ifdef to guard this.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 27d10d548c04 ("clk: tegra: Add suspend and resume support on Tegra=
210")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/clk/tegra/clk-tegra210.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-5.5/clk, thanks.

Thierry

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl27/9AACgkQ3SOs138+
s6HHBA/49ZPYvqC1AKre9jJzUfxicONkluYmQwjpNsbuJn44O6tNsj4YK+eiDbBc
jKoCC81MV+Z1IgKUWNjMgcV8GtD4huXCpuoBbnNrKkWQsyk4ZHp3O1HPkM+hqPDJ
ypjG89Nohev4Nig6gFzFM735nFSC45VvL0MYz/Q/wHqmtDXpaoZ/kFm7QEJWchlm
p2VGxJOonjG3+ClxEAiFPL2tt6E/uM7IChPCUo/XxcG4pnmAJ+g5dABeVD0R+CyT
+INdCpJMwOWJWWe5LN1TMEX1zuhhntxYDmhl4STl3fQ9ItEDqENlKTjXqw1RNzes
/Cvq7KPrYv/cfu2EDivbXHll60oxKIscML4rgTTbDBg/Rg7uYG3GudYnj95cSjt5
hP3ZjK1VG4hnl3g2tyu/5AdKjqAV8S1W26oAAiUi0w6ktZQch1iynlJ8/C+udwci
r4v7d4RaTjQ2LMz5cQMGrIj7arc1cPOcny4CIcSn/cfvJFz1TANT/c2pxf60CUiA
jIc0g7XjI7ErTYJFFR4zzHB7sp4Wf/Prw+z+im70ZKVt9aDBSZHNC1Ugc1NXeLLy
m8JV+YwKiHV9ZVRHMmYq2C7qk0n34TS50EcFo6goU4Ezc9qGPmCBhBM2HJ9Vog8N
sAwZ0t0zDBY0mmj8xW+1MykeqbgSk+BTyk5kx/KhaY+cLPYSkQ==
=XFPw
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
