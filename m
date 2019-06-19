Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7747C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFDD2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqW9F6rX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfFSISj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:18:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35027 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfFSISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:18:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so2336645wrv.2;
        Wed, 19 Jun 2019 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TfKV/QJ6MODqpZH4t1FgTPZ5kgciDVs/ij498gOZ+sQ=;
        b=HqW9F6rXQwlgBuw878bPr5+atIRJNuOA55cJjJPTwxVirZKbemvd7jan+cbhG1Ifzk
         kpM+rcURh25S7wc46624upKNwlSBbhTUCgaAjOPCKyVxw4tnyWu+htzq4BI43qlHbmiy
         HJPFRPGviNomwFpuIUV3kayllVvPPRFBIGuoF7ZzRhtToQTRvtijJLqcjldfemeziMt+
         OU2vwXBwKJnnST8bZWe3/D8LWu4WRN/SIcLtJoIUFnywRaal8eeqk01tvTjkRhNyySr0
         PwlskL7gnl436G9V3FKiRuDByoYxCiGuSD0MkMVwRK4Z99HHDW6JbiZW/HTpKRw/HVz5
         5xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TfKV/QJ6MODqpZH4t1FgTPZ5kgciDVs/ij498gOZ+sQ=;
        b=GygWxwTdh16Eq3nMlivhlKRnYvtTrLfAGTK17f0hhPUqOJSJwPoOW/GMwkr5X1I3AP
         xpD19QhR0zMdOoj9/mRmvzgJ6wLfS7qBqRPygek7UbjqK7mlTkkMHyW2sEUP43cua1tq
         UjjgGRK/Ryh0ViMFzCI4fHI+VS/kvKUjkBaxb5fI3gXXMq0Xvn//1L9iCeiR8xh+zCND
         a6KBoaUPImvDBKE76fOgEgVIcCeV3M1g+I234M6rY3MN5PBzDPb0eW1ickNuJV54HJFW
         HQEG/VYZ6Twb1ZiOMOqaphWNiy3PqSjTDjbz49OGu6YF7pglNGfYCHNnGr58I1ElMjVh
         LGhQ==
X-Gm-Message-State: APjAAAXcpfQPmotWXbim6J2FUPC6KDnavAWWa89Qelzymhf/rwffjzei
        djRq9JTqHOt5KXEcqB5K/K7UP5W4qMc=
X-Google-Smtp-Source: APXvYqx5AI4NCOY+51tYIi8rq9Rjx+/2uMHiUzGdLXRhXrhFA6ZSqphs1zLB/NG52/RAF1e5xUP8oA==
X-Received: by 2002:a5d:6207:: with SMTP id y7mr63642772wru.265.1560932315904;
        Wed, 19 Jun 2019 01:18:35 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id q1sm580396wmq.25.2019.06.19.01.18.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:18:35 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:18:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] clocksource/drivers/tegra: Drop unneeded
 typecasting in one place
Message-ID: <20190619081834.GE3187@ulmo>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <20190618140358.13148-5-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:03:54PM +0300, Dmitry Osipenko wrote:
> There is no need to cast void because kernel allows to do that without
> a warning message from a compiler.
>=20
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J79oACgkQ3SOs138+
s6GsNA//XZ5xYkaF3xgvvfM6XBRUNXdQj6smE51BlUt55h4LccLgovbawGnHOly2
uKrBXYhyTwM1zeJSNK5jRJa60M6gHUhUOvYd604sIRPNkuLlTSDmmbCp9phROWGz
Z5TMuXTUVtG0EswN1Li3CUbAa1bDpPR0XHTLLlJMkIkzdA4DUGww01OFMN+CmBDJ
WQ4JHr7s6asbpkPr51jyVDMYLrv+eAlaTVPN96kp2zA/oD0XcknoMPjfh/XOUsM8
xciWMj6Et9Z4ztt6acI1hXG5pblA+vyR3DIcO85nEH5eA3DF7sRitnUZCoUZxfr+
lVJi/isfxMDxyUaiUdgzKJMGds4qUsIBPx6qnVFcfC4kDBKrSAVDYrFJ5UgvrHQ8
JT0+mrI1OQYK3kEut48/eO0H6tTB1QYzdMPlYbA1G9r1hGvUFLio6EwQchJjoOmG
R2Ee6FoEJUNL2gkwMaitHtEkr2nZGSSPEU6asi61dvHB0Iw9ETg+CJ7U0mwWGlHQ
g29XcPbp7hxA8LYhvQpsTPO78HagayPv4qNgOJVK+FgXYDuDeKxmjSveBJGJaQD0
mE79WYfawkGf++ZI6zvdjlNxwf8HzbHFonNTWXyIiCn43S2kvVj9p3L8EsP4+it/
Oo9c4yD15Wyd/HfxeoztGzd2mDRyTcY6K82BggklOmB+qR6i+uI=
=rquA
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
