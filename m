Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F624CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC6C20578
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldhtE7i1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfJ2N3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:29:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55219 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfJ2N3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:29:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so2571472wmk.4;
        Tue, 29 Oct 2019 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZyrQT++JHzLcRfuKcgHsyUe0SmNfdkUBvT+LupMK3wE=;
        b=ldhtE7i195ivrWivpGZUMMDIfoQ6Ye6gbJsIq43K18miEvSx5uYCNouD8x5utAhviE
         5aR3r0L0D58JT2r4fiiw4YBWG1tZ6bb4qVp4JeRr2Ci9c4OKXFq21Uc5DyRpXRqCjBKV
         Too8aJeQMF3MGc1W7oVhq9Y6xfsAPk7V9lhpq0lR7V9eI0C773R/cEcb/J8CeCVwOS+R
         5iMZZMxcLynllufl/Pyu3lmBEuEgUCT/m2opoie5nDt2qSHF/X2lMl1xSfEmMRZ9G9ct
         JWN5itJhL16pMGZpHPORERxRbBZFBfmWD5Os9nFU3teFsWflsTVxjd3cM8fCoH2NNOMe
         +Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZyrQT++JHzLcRfuKcgHsyUe0SmNfdkUBvT+LupMK3wE=;
        b=KVbG5GeTE+ivt1WXg7RzYpLEVY7S0gTk+aH0W0FFi2wEm0+lEglntvrBCL+8+d/+qs
         blxG9+MNOlaV9MlA1q1mhMcoeCj57+sfL62okiZ4WSwACTKE8QZnCDfUnbH3hT3+MTM9
         DJcLIp7efLSJGq2bx5atdAiOGcxqj7M3EOk/nuK82baXoeqL3wBtLnKq1gNjixiCgY0j
         qWiGieQcqWZRSg5LXoidGXl9rlqurEI1SdnLiLBY3PfbziUyudE/gC1IEaoYS0hVrgt7
         sOqpkD9k7Tnh9Nxjx6cgjOZROzR/MJoclYfZJGoDNb1NGOVUESXdWMsgHmdJDxCt+Dsn
         DfIw==
X-Gm-Message-State: APjAAAVKb41d6ti/PlN0Z2ohWF4HSYPQ+uzGezFlCoJ8FKLg7mcPN0td
        iltjawRhtxou2JlLXUrVDbY=
X-Google-Smtp-Source: APXvYqxVOR2/ernxtfHe/O0saeRgpwaX6roQc9/VnbXSJO0ROt+1HZfqwRfBD/S0aVS9NS8im21nVg==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr4044683wmo.140.1572355789192;
        Tue, 29 Oct 2019 06:29:49 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id p21sm2489874wmc.25.2019.10.29.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:29:47 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:29:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: tegra124: nyan-big: Add timings for RAM
 codes 4 and 6
Message-ID: <20191029132946.GF508460@ulmo>
References: <20190723033744.4219-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline
In-Reply-To: <20190723033744.4219-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 06:37:44AM +0300, Dmitry Osipenko wrote:
> Add timings for RAM codes 4 and 6 and a timing for 528mHz of RAM code 1,
> which was missed due to the clock driver bug that is fixed now in all of
> stable kernels.
>=20
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>=20
> Changelog:
>=20
> v2: Improved commit's message a tad.
>=20
>  arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi | 7917 ++++++++++++++----
>  1 file changed, 6272 insertions(+), 1645 deletions(-)

Applied to for-5.5/arm/dt, thanks.

Thierry

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl24PsgACgkQ3SOs138+
s6HRhRAApan8ZzBX81Q/qwmDIQQNXoQw7XUsmTuuTdWXo4RjmCsIDH7oOjzG4r/4
QMujhT5FlJECfZOKffZJv2X19jz24TzCHdEmJP5bR8A95KaDZEp3KoT278etnzee
a05vW1hBf42mEvI6d5z48+i4k1uzhaBVeBTGN3GwaCbmskpc8efztRYJDvAONWfD
P81N2uBarekZlLTkvY9VNVdE0C3DfyGaAPUlzyiPZHYcPFVYLEKU1dsB1UcZRiE6
fdn62simDa1zZEAlIAN+Oh06Cp106UwUq4ktALQR/p8NyJTPQpByNwldSoXutB5P
gzMyFYUdq5j7Xd2GE1dozlkB3+OnSvUzC6OlNVAs1in2V4xOVj3CBUFy924U9Xo5
MKTkes0FJMsQUEP3WiLHBhp8oTJWxt6REJtEXIQBLVFjIyYfqHPKCx+dx/u08r9x
RNMVlyVM+lTR/POTX5QW3/GMnqwv4f7KMUntN+A3+fpwiJFzPspLQZJ2ZUM1akcA
siUMc9C21YSw4tJ+z6tGHZBvY8mGzFBIr0PPFhhvDFTxRO30YTfTPybgtNAHzmdz
4O22fcpzcTuDYloX9sRQ3lQhJD8TkS12d8jDRIE2SbT/AcIkDH8FEoeHRZAhOiE1
BG8Qwb4dahKDaKDoMYpq2YmiXDGZ1nFJP5UuNMvXmBxqt1dU3t4=
=ZqeM
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--
