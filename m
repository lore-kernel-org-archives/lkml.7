Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D72C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F3820828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZRiXMKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLJMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:22:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37401 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:22:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so2934510wmf.2;
        Tue, 10 Dec 2019 04:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a+dlcCmsRbzcBFunwr1JnGDOPrlivjZmuvq7yoce49M=;
        b=GZRiXMKSMxG+7Ceuvnbe7cMAlxU1dIJR80oFbAtAEjX8QsNdjuOTrX5/i1lV7gq4B8
         1oqUbs9g+3jesCLKBcX6mEcG1wkv15LVTEMy5JwvvEd3cvKm0ioauZR8LKIMn1v1+kIK
         ivekR+5IgYIguWNreGRGctdb1BIsQE0MfIkLSx5398hz5KQ4E4xb51tmhguvmlQrSk8z
         b8zX63KIDDeDgFXSSfiFX5sQAhmH58Ic4Cfv94oxvXmKBDUQofIBR1sYuaT69a8xa2W7
         KMumPJu76ZO8ZjI0P4+k76jxMljOze0K/WiM+/xkmUw/TH9BY1c+ZOfOkTRPMjYIkFsh
         yAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+dlcCmsRbzcBFunwr1JnGDOPrlivjZmuvq7yoce49M=;
        b=q4sRHuBmbAZPXm2NE8ZQlP9c2O3p3Z1+tWP6s/SXVHWsI5GGUgziJ3zjCqKDYsrqGo
         sv8+oOcMgzs9JgAddpBeGochjbiXYT45o23AJE6KRLDnz0FMnZCk+T+dA5xAnXGZ2GH+
         j1HZMM4xUmrA9ZbnCymSzL21Imt/AXHunJsYvSeKyE9c2/yVLkhqEcRkQATipPGJqBZ4
         1KZ2TdyxFYeKbJHrE475WW6zx6IekaVPIQe3Ps/U8/5X16PRqaJ6/T9CvGNPB/V7B4Bz
         G8v5qm+Dx78OTg1207IdGm0DFHoNy0xVICXqa6KoU3M+8MW6Pdy/NOTiQWo+yB9kXAHp
         WnmA==
X-Gm-Message-State: APjAAAVc8/yO0a/ABrbdFOauvrfnn4Ja7I6mLypRIZ0Fq1KmZig1BAZG
        m6eXvTJLZVyzHDAslgOuLPTKBQeO
X-Google-Smtp-Source: APXvYqwwHyU3bBJ5PUaapPSWnHIXfXABUdZ/1utxorIxSjqTXYyPG/AXrZXuKhWTDpQtcl+SrcK1TQ==
X-Received: by 2002:a1c:3c86:: with SMTP id j128mr4868723wma.137.1575980522789;
        Tue, 10 Dec 2019 04:22:02 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id m7sm2967979wrr.40.2019.12.10.04.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 04:22:01 -0800 (PST)
Date:   Tue, 10 Dec 2019 13:22:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: tegra: Fix double-free in tegra_clk_init()
Message-ID: <20191210122200.GC2703785@ulmo>
References: <20191210020512.6088-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20191210020512.6088-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 05:05:12AM +0300, Dmitry Osipenko wrote:
> It's unlikely to happen in practice ever, but makes static checkers happy.
>=20
> Fixes: 535f296d47de ("clk: tegra: Add suspend and resume support on Tegra=
210")
> Reported-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Good catch:

Acked-by: Thierry Reding <treding@nvidia.com>

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3vjegACgkQ3SOs138+
s6GOoRAAidaUWN9p+mEK9ws/uUDXI6Xmy+ARBVvNkFB/tvhUIuI/gLHE+dpeLwsh
pmatWTRMujK3ILr1DJ2hojSZU0nEMdceLztyP2u0aiyoDYYUeI+WSb7Jcqd+9Bq4
ug6ZwkWs++U+S1FGNxETPiXm2xFLSWTPa/+n4fvC5bMTcbHV3yU98j7h20MEiFkr
6V1o86caDHp4mFDeJd4+3G6j8KHV1CPK3UycWed6A6GNJVxbVdF4+y+T/itMduIo
lMDaIsNFm6+LqNVDyQoYJRPmPYS/ClgZk5Hz6/ZJgyTzDEYeJkDaod8bJaVrpt/U
qzdn3u+C9M8xX68hOe8NQxZi5my/tSIx/G8RpK2fNDIc8kN0Mi8Bo8hKZjSXNB6X
6tippzUuQ2Nw1MoGcOgsCPKyCY6SfsOnZG4UGqsuGkPD/OXNvhWTr51v7TsAhCvs
p0ElbZrFy2n6Yw15LCHyJoDf+ovGOZrKNVfz7jZrG0buloGux8Iu+RInQKLPexGm
Hv7k1O8x5/k3ALRUo3fZG6mvt0CPdh06tLkbuX0fZQ2zmgfxTRLbaNAbjk8g9XWR
xV+qUkhDcEKQ8zkkGiO7IcWh+hQUzsPZU4Bn4eknIa6TShCZHG8a/+vR0kxLNlOu
F3ZpPW1PKNiKgFtDjnNhIzFWz4VC07Po4VrayaR9HGpFn5xxVmE=
=5N0X
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
