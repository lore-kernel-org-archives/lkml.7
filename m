Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F45AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF1120645
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyGou3wF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfCDL7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:59:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34081 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfCDL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:59:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id a16so4028149edn.1;
        Mon, 04 Mar 2019 03:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0SXc/ccBIqDOJFDdSRXSkpspHO0OCRRSHCA1+2sr5WA=;
        b=JyGou3wFbwGmsPDE99fghHzJcuJpz3zT2b/dih9xdl6tw4JSIUAOpnD8/Ci+zTwZ7P
         qYpFakUauHhAbwpTyTgqC/uCrtx8Hwq+JyajluO/kyFpSgF/cDIbr3zHxI4HBI9ofX1Z
         ggCb5iCotUMUuYmvVXHvd/MSTIQiy383yrfgfpZU4n25zdlCtJvmxYyLRUDFG3WPTzYy
         xA67Bwug3tRBmJaF5dfEcKVfKd2UTmKqUas15A+knYLusl+xpgX8hXWVXVM6Zxg7W4lN
         6mN6xbqXm9P01x/oxpr+G5+oe8PTvnEtvbTAUz/IkqwrpzWZo73iz85YOeZz7EWHIugV
         OoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0SXc/ccBIqDOJFDdSRXSkpspHO0OCRRSHCA1+2sr5WA=;
        b=FbCxhrF65ZIQz6tvC6pV5IsoKiTK8bwrMRYNkazjyTNMmLgx+yS4LX4g9mQ3HS7lRY
         +VGmkl0LxA6cVkJXrIM4RGrLaIpVNPxbOvde55yen7DB9vltCb/4XQxskTkWIpXPphJO
         gRAoXkEgCz6xq/gnIaa9+d/QGDtUJa6Jvdm8DleA91dPTtNrd5FwKnzvpydhvbzy7e8T
         0rNKcYpNSv+l9mmCCZKtBHRvV+12B2Z/x+RWCsRt4PAd/K9sAHSIoMjkgTx6nbA3HQQI
         gN2v4rqMFx9z2HnJ1iEwulKA++kCXMI2f1uFbO0/OZsjPpXPHslBUMu2zx5A1xOtTHwb
         /YrQ==
X-Gm-Message-State: APjAAAWXH2bQOtU2vTuzaZSkU8YeDlZAsroe4fNLcmnNUq6tSiX/XTov
        5fucq4LT1PpF8CkihF45G0w=
X-Google-Smtp-Source: APXvYqy6rcZGrjftTo+4MbdLz8wqDGECwGBXyvFG7KXPhXYwLG0KgJD234CzYcz706qDeh0Vv45XTA==
X-Received: by 2002:a50:978e:: with SMTP id e14mr14463735edb.234.1551700749634;
        Mon, 04 Mar 2019 03:59:09 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id z49sm2025549edb.15.2019.03.04.03.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 03:59:08 -0800 (PST)
Date:   Mon, 4 Mar 2019 12:59:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 11/27] pwm: jz4740: Apply configuration atomically
Message-ID: <20190304115907.GB9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-12-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:33:57PM -0300, Paul Cercueil wrote:
> This is cleaner, more future-proof, and incidentally it also fixes the
> PWM resetting its config when stopped/started several times.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v9: New patch
>    =20
>          v10: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9EwsACgkQ3SOs138+
s6Fifw//f2H2kWj6n++VBIr3qcpgyLlpnGP7IdO8SjFN1SopHRC1vHqhKao7IdRf
7HfK6sbCuisohUtSedMVcj5aD8fDlf2eUoaLwmErr/RKtQZiOmS7oSsYCFXaWvCf
YpXCycCtRX00UT0dVAw3uVIftDnYJ1sYJbXBM4SPZC9VmYSBz4UVOy7XoY+HhOBv
f+4LKs61FYgZmKDY10FWW2Wpq8Tw36Pdh8Szl9f8H8pFc+tgGCue7EaO7JN+TR3d
ZTSJmxlF0hwzzGbouA7Y1UcLDnZrCZqgkf/SCSpyOqn4JkbaxWUdYwtIUTD9N22Q
STfBGCCLlfXVEHQkEBvbgk84PwWBlEmPCcs/6ujnJCtD9mBKUJleOnF3aiqOpfCA
KplgKB+tR+YN866fG+A9JhbbX0JkAwdiCF/DRdJAajqW4gY2pyxkiEC1FwmIe/YM
vqLqaU7KqqeDso4HHjMbpBiJkznvUszfRJDrkboMygZ9WoMkUCseRJSLKXlyoRLX
buG5vHVkjJkhhuEL5Af7CguZzNUvTIMrvKd5Zn4/fRdMolj7m5vksQ1V1Wb7qWTI
G6CvNQO8S8cYwBkKYpXuMYWmsB8agHFnmzr98op8R6toc9/3i8EGOo0kV9V8NxmX
21KrsQr738C981dGRLoBVJRVlfnSHZgv67Dni+uj2+y2MBElhxk=
=DBKx
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
