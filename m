Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F91C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C82820848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxlFOcnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfFQJVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:21:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFQJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:21:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so9095134wrm.8;
        Mon, 17 Jun 2019 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52fOR4EmlSTl6p5K6cDrjlKg/KeC1MUaln6oFxSrOjU=;
        b=dxlFOcnbjOZOWWnfb/ieu1A7WpmO7JkiyKwmziYEpi7ygdj+kD6F2nMqRNpijFSdH0
         r40ac/KqsI7joPNCV41eZZxXR5dJtqg8PoHB5KXd/bAxvLJFihxnt649R6TNa+xOiYn6
         bEkNYQ9btO1PV1eZp7x+GRzSE/Ixa+9avFln22naVMe4cRxGaV01mRfT/FPXFR+x6/Vy
         Rd85lwMLyXgMOf7NFfeFn1DMn2Fcf68tIELSHTl4wob/0Op8aa1wheUCWFrAIW2YeKWf
         97KstsnHj2ZcDMIixWAkVcWS6PcKn/oWaWSug+cMWTAvxfX+OgjZzfaJUo35+Qe1+APR
         sJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=52fOR4EmlSTl6p5K6cDrjlKg/KeC1MUaln6oFxSrOjU=;
        b=t5v/kEPDPYt28F+QobaRcXRWuAAeIYXMizsBxPZht+AZUx0FAPj/I11CPJvIFX4zWF
         XRcO2WQNmDewt/Kvi+MvWRrEoR5r4aYx6FNbRj+pY663CHQ4dIDJBKPB4NI65oCE+p4J
         +XWU/SdhhhKQ8QNDbaBbfuEzAdo9jLOzZn0jiA6S/QUbXizq+ZmiBHOHYrKnQv/PPb3z
         7iShhrSb4hYda/1ThJPC/hRqf4lAMuO94Ha6lIdKNFznp+EXMqH6UVfADHMg4zVtAFO1
         0ZBOS8oHDTK4SZc7KWMe/yuQTnnrZt9dqzrAFakyNk4/qGlWFOxZ4ZOsg1aHcKCNwHeV
         ZRjg==
X-Gm-Message-State: APjAAAXVobr9rn6KA64huRhFLjSiZ8vsFasPyTdavWdf6gOLVdMmtEcm
        OZzPFqd+qGrUYgphEWJ588Y=
X-Google-Smtp-Source: APXvYqyW0ZeOP4sbQOuHkaMP7/0vNVAsCgoN2X3g1SLfWVz2teEVGYA8rh8mTsmS8n+G5Hgzyj3IJg==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr23155923wru.242.1560763309835;
        Mon, 17 Jun 2019 02:21:49 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id c6sm9918833wma.25.2019.06.17.02.21.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 02:21:49 -0700 (PDT)
Date:   Mon, 17 Jun 2019 11:21:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] clocksource/drivers/tegra: Cycles can't be 0
Message-ID: <20190617092148.GA508@ulmo>
References: <20190616234744.8975-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20190616234744.8975-1-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 02:47:43AM +0300, Dmitry Osipenko wrote:
> The minimum number of "cycles" is limited to 1 by
> clockevents_config_and_register().

Looks to me like cycles also depends on the multiplier and shift that
are computed for the clock source. It looks like the multiplier will
never be zero and the shift will always be such that it won't result in
a zero cycles either. But might be worth mentioning this in the commit
message. And it might be nice to also repeate that in a comment close to
the code, just to document this.

It took me a couple of minutes to track this all down, so I think we
should take the same amount of time to document it so that we don't have
to go through it again once we've forgotten why we made this change.

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/time=
r-tegra.c
> index f6a8eb0d7322..090c85358fe8 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -54,9 +54,7 @@ static int tegra_timer_set_next_event(unsigned long cyc=
les,
>  {
>  	void __iomem *reg_base =3D timer_of_base(to_timer_of(evt));
> =20
> -	writel_relaxed(TIMER_PTV_EN |
> -		       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
> -		       reg_base + TIMER_PTV);
> +	writel_relaxed(TIMER_PTV_EN | (cycles - 1), reg_base + TIMER_PTV);

Maybe keep the n+1 scheme comment and explain why we don't need to
handle the case where cycles < 1. That way it becomes crystal clear that
we don't need it, so we decrease the chances of somebody coming around
and trying to "fix" this.

Thierry

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0HW6kACgkQ3SOs138+
s6H95xAAt3MihWlhBTfBQKS+SEt8OK3jGabb9ObCvnOeFgW0+ZoQ1j9FxZ1W6n6v
0f2OlhTcGaZz+2WlivwemWmTxE2QSLbYYPCkoDOHwP1tUF61s0IiMmXMZNYUbnMF
343t1M3zI001EqXI1mOGRi4AKGotxp5nnqnvPmRtX27YMPxLG0s9pKvxkTHEPNMM
nMInSLkWzQtLvqosmIDw81FF6s0AI3b27WTHHQwNwEVJPmV1qE4vWp3rfsnAbpct
H1WibUTvayJN9Yfvy+tVYOrI29FGE4n4o/Yrks3spFzJRxoSZ10fU+VrXYlykT8M
Y5h5vEsKnoIj3tBCdoWru42+uLfwPsOjDxk99MlFxx+GNITsuePSL5h1wnJDcOrp
ySlqLTXvWkBcPXqiJzvrvOD3Gyq34x3jADuR4oKI4mGK3tX1zv2cGSVtdp/URk2N
PQvlijaMNh6mS47AWB/i9/+gsTQVUOIsCw0fqktQhghD36VrtXJGnMX5oz9FjXEI
zaCZwfBqNjO2AVxgADH+T2nrlnY9jl1wOMf6jKxjD97XwNbAZIvp0l9G4+CMmqI0
SVfpmg9ERRWf2PF8vmMm1BzSjBgYjnPOua/YWdnJC240mXJ/+MqciLfeLbExeAqU
T9k8N0hAZOb232Y2jWCNi1SOvMgUTgnDuvKwaXsA79z3b4ENsyY=
=CQ3S
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
