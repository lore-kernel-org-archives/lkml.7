Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73873C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F61120833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwabJv1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDHKWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:22:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46006 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDHKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:22:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so15626987wra.12;
        Mon, 08 Apr 2019 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=II/MsfRha9YtyfnMSzYYK9zpAFxrnUzG9JARyw86CmI=;
        b=IwabJv1nlo3EPBlsdD2yZz2EpyR1VgN2pCCcP5H91JdqKf1n18fPJYJE/5b/DLAnyO
         YTiIvSer9ALLsBPfwFX+rK/v8G7/4kl8ftETXyoFCXB/wtYM++sb8BigDYvQbLM8hQrD
         aKAFGGK5J4mqIsJ8H1SHBhjfyuRuwtjmSqbCzJMv/zjmCVfmrRktl/QgUxrhbs61x+96
         VxDrt5mo2gv55SVHk49XAM386LFwVc/nrBxlMqum+tJ3QD31i2xNzkL8KO5S3zigbhI5
         eEDIujw9kyUr7uu3n47/o8L9lJ2Jr4YPqkeoYapQjLq11Sh8m82zBbQ2NMcKzH8yDMFi
         RVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=II/MsfRha9YtyfnMSzYYK9zpAFxrnUzG9JARyw86CmI=;
        b=JKdzbybQQFSi827TFIHeMapgiA4lnBHuoFtbhLMTFOZotfhHYj45y9DroDPEg0Vy3Z
         OMf64VcplpXL0QZG+k7PeZLaR3oQbYAFT6kD8i+Je03KU3f118DVuVPPjzFLwmy5tANq
         p+3xHff3QU0+8yawaWu+Ou319Js0E93j3SxLpDb4WAdpagq7M7Nl1VfGIkohNJnGJNyG
         8DUuVeyA//sCahD23u3T/j4tmvhXVvfpidTtvRSvZ2u/M4ZhhNLnsK3bYtm6bGRiyycz
         MqxQPkAEg8SqmN3kaoD4bfTpirvw+Kz+FkWfAUeZzAOW9yqlqisE5Kenc0z7JLeoHagk
         vYqw==
X-Gm-Message-State: APjAAAUG8gZQJPoYfRBjZboogk3u1LkhKZuBAmzqxx69q34ss2poo7+J
        tWY0RnKieIVMAsR0oqUFmP4=
X-Google-Smtp-Source: APXvYqy1UcIjuf3hRWFQ9gqCAlvchUSWpy7XLFYx4YwlTwblvZTKZUllw665l8mEALi7vRSTRLhmpA==
X-Received: by 2002:adf:e407:: with SMTP id g7mr10526495wrm.47.1554718970979;
        Mon, 08 Apr 2019 03:22:50 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id o1sm11403927wmh.47.2019.04.08.03.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 03:22:50 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:22:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rtc: tegra: set range
Message-ID: <20190408102249.GC6644@ulmo>
References: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 07, 2019 at 11:16:44PM +0200, Alexandre Belloni wrote:
> The Tegra 20 RTC is a 32bit seconds counter (with an unused millisecond
> counter).
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-tegra.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
> index c6b0a99aa3a9..3f93a1f7abb5 100644
> --- a/drivers/rtc/rtc-tegra.c
> +++ b/drivers/rtc/rtc-tegra.c
> @@ -306,6 +306,13 @@ static int __init tegra_rtc_probe(struct platform_de=
vice *pdev)
> =20
>  	info->tegra_rtc_irq =3D ret;
> =20
> +	info->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(info->rtc_dev))
> +		return PTR_ERR(info->rtc_dev);
> +
> +	info->rtc_dev->ops =3D &tegra_rtc_ops;
> +	info->rtc_dev->range_max =3D U32_MAX;

The placement of this new block seems somewhat arbitrary, but either
way:

Acked-by: Thierry Reding <treding@nvidia.com>

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyrIPUACgkQ3SOs138+
s6EFHA//bcDrlv65Vh810bQ+bQqBQKmZg2VMLx1IKXABdzXeKleGTHMjVs+zvkeC
zL+p1/6J+z8Oaq2uhCFuwdZG42ZFqGb59afSg3nLp0Sn6Dl5yNrYKmW5ZOO2FmW2
oSw72M0WUR0B8E3yL7d8eFBYnLwEPk18hwdBjke9T71DiP6UB3q1XrD53vrqZHB/
iJhThMJoiwnhkKa/XOEidPyr1qkP8dsVttND6iEuQBK0s+y/KK+X6AcMHDK1Ng5E
tnby4q1fXHNb4avEHp0JIk7cCdHAM7NKnxbBza7gKe0UcytRWYChvigAuP6qStgR
/QvNPaDkQy0QNq1j0+8yvFkq+gkmIjr5CUI08ev+3Q8AOZJDq1RM4/NKPpvwKIy9
/J8rvlATzd7YTqXc4gM1T6r/rwGdbjjvTgvR6qWq/3NfDeK5rL0MXKsrGQkcgHsE
JJhK+vE051ltQ4OZ7VjBFfyvFsQZ4Tc3AR/9Zl7z5m5+5IwukcZnn1P83RS7uOFL
goZfATBFgtq2hUzRrIdlXLga0CQa1KZDx0jCribeEy4H1DdW6nFG4uJPFzKrcZHf
+gq875Wbp7of4h4pGeKs95aPwIXEyDNg05TX9EjFDc0oZUs4OXnQl4qK2WhLhNG3
sd8uVIYu6IcEcW4ZmIGw/M5OZJEOjLcPi1ADA9DOz+3VYLXgSLU=
=Pr/2
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
