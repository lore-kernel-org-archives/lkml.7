Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C7EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41A621852
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z86ccvCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfIPPuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:50:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46967 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfIPPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:50:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id i8so473503edn.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DXT5s5fcLo5soj6xPZXRL1OiieH+UG8Sh7YMbwrqdTY=;
        b=Z86ccvCJI2Ejf1Us2VTCs5VOixyaILzuUwsvay36+/c6qmGFGLxx/9cKATXG/I17tZ
         mORrbl5596r0TfEbX3g3qi7IJ5RkZ+AIeJO90befmT2ShG/Pg3ykLQNPEc7D2+t62vmk
         lTyMSb/ZS0NNJDnrR5m8xCCC0LzXaXFo7ynisqndrutAslb+pEfoo6bSEilKm2gz2Mc/
         noOpnkTqfvAUjSZhFT7x7kUlWUR53Ek73PKSFqRH4Spp2cHgxJVz0Bk6QKnCdEmECHSB
         gaPg8Pj+lVu/RXgXLQF5/XFBSkEVRblwmxuX2krVH2V8QgloFoTn61ux+s2QIFqc6ws0
         r9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXT5s5fcLo5soj6xPZXRL1OiieH+UG8Sh7YMbwrqdTY=;
        b=A+T28KP8CHqq6gKe7crSWh+oc++4Fr4OdwlHzThU0/ctf6pfFfNbEuWhCT1KM/86gh
         F/8+icgIkXdJdra7+ZoOkAc7HbTazECr/d6+SMletoVYLiLcedXiBNd/jvEfVqlufxzk
         AiNDJFyH1LD8IfGK9k7AHR4ytzC7dJnRq6tBa8HpQ2dR2GCU9zSiy5PES5uX0L9yyCQN
         +A+yS7YHBeSNsKn+kQnP3Mc3Uu6rKZnb9XL1lddhZya2wF4FwuuS/lDR8cCQH/LOIB79
         4/GWxySqzsmaLqXZOAsuymCgnD+zBPgTIKFB1DyABb+xDa53nME53z4/TBbE7SvBg1xJ
         BcVQ==
X-Gm-Message-State: APjAAAUcvUcrGJAJ/mO5eIHKaajw+2If12HV4KpU6t1fV8X/QwwhWk0a
        pbFmhR/rv61wV+SEGRbg85g=
X-Google-Smtp-Source: APXvYqxemzQcB+foO0oWW16WA8jesorwVSirhODeLhX0PsKWxQEP74hj5zCxde53PT5+a6JMAEj5cA==
X-Received: by 2002:a05:6402:1501:: with SMTP id f1mr8902512edw.76.1568649034241;
        Mon, 16 Sep 2019 08:50:34 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id oo23sm4321225ejb.64.2019.09.16.08.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:50:32 -0700 (PDT)
Date:   Mon, 16 Sep 2019 17:50:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
Message-ID: <20190916155031.GE7488@ulmo>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
 <20190914152544.GA17499@roeck-us.net>
 <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
 <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net>
 <20190916134920.GA18267@ulmo>
 <20190916154336.GA6628@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <20190916154336.GA6628@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 08:43:36AM -0700, Guenter Roeck wrote:
> On Mon, Sep 16, 2019 at 03:49:20PM +0200, Thierry Reding wrote:
> > On Mon, Sep 16, 2019 at 06:17:01AM -0700, Guenter Roeck wrote:
> > > On 9/16/19 12:49 AM, Arnd Bergmann wrote:
> > > > On Sat, Sep 14, 2019 at 5:26 PM Guenter Roeck <linux@roeck-us.net> =
wrote:
> > > > > On Mon, Jan 30, 2017 at 12:05:06PM +0100, Thierry Reding wrote:
> > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > >=20
> > > > > > Hi everyone,
> > > > > >=20
> > > > > > This small series is preparatory work for a series that I'm wor=
king on
> > > > > > which attempts to establish a formal framework for system resta=
rt and
> > > > > > power off.
> > > > > >=20
> > > > > > Guenter has done a lot of good work in this area, but it never =
got
> > > > > > merged. I think this set is a valuable addition to the kernel b=
ecause
> > > > > > it converts all odd providers to the established mechanism for =
restart.
> > > > > >=20
> > > > > > Since this is stretched across both 32-bit and 64-bit ARM, as w=
ell as
> > > > > > PSCI, and given the SoC/board level of functionality, I think i=
t might
> > > > > > make sense to take this through the ARM SoC tree in order to si=
mplify
> > > > > > the interdependencies. But it should also be possible to take p=
atches
> > > > > > 1-4 via their respective trees this cycle and patches 5-6 throu=
gh the
> > > > > > ARM and arm64 trees for the next cycle, if that's preferred.
> > > > > >=20
> > > > >=20
> > > > > We tried this twice now, and it seems to go nowhere. What does it=
 take
> > > > > to get it applied ?
> > > >=20
> > > > Can you send a pull request to soc@kernel.org after the merge windo=
w,
> > > > with everyone else on Cc? If nobody objects, I'll merge it through
> > > > the soc tree.
> > > >=20
> > >=20
> > > Sure, I'll rebase and do that.
> >=20
> > I've uploaded a rebased tree here:
> >=20
> > 	https://github.com/thierryreding/linux/tree/for-5.5/system-power-reset
> >=20
> > The first 6 patches in that tree correspond to this series. There were a
> > couple of conflicts I had to resolve and I haven't fully tested the
> > series yet, but if you haven't done any of the rebasing, the above may
> > be useful to you.
> >=20
>=20
> Maybe Arnd can just use your branch (or rather part of it if you would
> split it off) since you already did the work ?

Yeah, I can just send the pull request for the 6 patches after -rc1.

Thierry

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1/r0cACgkQ3SOs138+
s6Hcsg//fOHVfHF/Lf4ZR1EsztDM9RWSeiV9KzV5if3/BHqV9rjYuaYD5mEGOS5/
PDmXH7k6ndPcHqi2x+QfSNUhd629S+6X63wsFswe40l1mGOcAWIYS+0Qs+hKLZh2
FtaX78iD9aKSe1/l6HEwMhw2PEGDYTSCEXr39/O8zfNRhfgmVWTXVKDFC5UR+XHw
BThItNfSoGksS1MdGERKUemF4mNhX+2tPfPYEE7sjPkf/f+Fg/vufZYCsTETWQo2
Bj35696KNjRgsYZjN5WQ3FgFA6Sz4dOqsV4c7A2iZ1294OSfKIfi4WKIWg3tJX5q
yVH/E+mXwi59c62LqNhYiS/A+ukYvMcSZZvKKCQFCw5Gc/KmdUcR724N1Xi+zMAk
kHMHJ7ADvsyJ3tYi9vck1yFpZzsCkQJzcrR///MGx3mO41offZed73j/gH/kFm7r
hoYb9y2x+E97keY++ESodR758zUlSyWXF4sR4LVmpeeqHQw25Xc+s8wXlAfy+K3T
2zE1DbxdlPB4qIjZ2FTKah7Y/h4th0+oaUa7P6ZDbrySrswFuwv3RoIK+UkZROB2
B0FRfEvtXsgqMr6T/e8x9svVhFxdar8uFtXlT9cArc79wPusjANzFP70opkQ62zN
SokCNLDqLbv0Fx4YBAZt2eFlVhvrMGQE34Ni/2R6nuDbMNHu5R4=
=bM0l
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
