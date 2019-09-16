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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D6C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8824A2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVMPpmwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403789AbfIPU2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:28:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbfIPU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:28:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so758981wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ANumgDbyzeiaEEBfEWsEly4Hx36OR5yCOPyK3D9zUTo=;
        b=EVMPpmwJ5lcayMI8roeCK+PBvGUEgpLaXdtyxrbP6GTdWB2LnBZJl1MPWFxjIr8BHx
         9bepwJut16YP8TB6ofZfE4079DxAI0EOgsWkUp0DWBwsUgJw6se5vfkok2h66p42YIV8
         nOqdH8KrhjsXpXSgSVX3CwawF7LvtK2c73r8Ivcq/77wPalfcKVerSeZKTEoDX3tI1+c
         6hKIa0iypmdFVICAv6kU3hKS7PhmixeVb4tD9oKT3fDAByh4idNXCBzRkUZJjhvMlFfq
         hTNscwvGyIYpzvGB89RO1ZoQCKa2jGnB45sJRPRkA32ftH/RDIR6GWLXY9a3c6IjZlYE
         fkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANumgDbyzeiaEEBfEWsEly4Hx36OR5yCOPyK3D9zUTo=;
        b=qYv/gLYX4hZUqzPxLzIpiZ3OgAc/O/phhhxlpdc+eV+XO7hQzGEqu7vaHo86nWMsqZ
         Ge4y4grK24Pc4emY94seNpeaOPQMFm/3cehUzG7feoGbXUIAYNikd6GLnKYMB+BgMtK7
         Nifqu3FPjK9U45Or7pMUELNw5vlBpykg79fyxjqj03wZuuG+Ypy6JIlwwsldWwcw2fx8
         va5lQdFaDqTMzrnz+QUesMRbSbJ+LUc76lsc3lyOuyhR9DsEOUFyHnEAtk5Aporhwmoo
         MEfkGEYalzLiZkCNhhcJ9wgVTdXvI9KJ3c73v4UTG2OcIZhwsMiq8nn/FP/56dgN5+vo
         7RRg==
X-Gm-Message-State: APjAAAWafdX9f4nB3G/5IdUWWV7zZxu1Sb5nLmVlSF+IkHMp9ZOy7KtZ
        Wdjl3D4wFF/KoeEXyG+Pz5U8yz5/
X-Google-Smtp-Source: APXvYqzf/jl6fcz9CXqR/ytZkxJvV1mvIGMLlL9KvGTQctWzDgy377sUNEfpwUPiGRcRNcbHuVhHbA==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr706196wmx.168.1568665691855;
        Mon, 16 Sep 2019 13:28:11 -0700 (PDT)
Received: from localhost (p200300E41F0FEE00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f0f:ee00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id s12sm11955wra.82.2019.09.16.13.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:28:10 -0700 (PDT)
Date:   Mon, 16 Sep 2019 22:28:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
Message-ID: <20190916202809.GA42800@mithrandir>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
 <20190914152544.GA17499@roeck-us.net>
 <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
 <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net>
 <20190916134920.GA18267@ulmo>
 <20190916154336.GA6628@roeck-us.net>
 <20190916155031.GE7488@ulmo>
 <CAK8P3a1EZi5apOm90B6YW2GzFXsirz5wk-D66daR20oj_TLXNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1EZi5apOm90B6YW2GzFXsirz5wk-D66daR20oj_TLXNg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 06:29:30PM +0200, Arnd Bergmann wrote:
> On Mon, Sep 16, 2019 at 5:50 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> > On Mon, Sep 16, 2019 at 08:43:36AM -0700, Guenter Roeck wrote:
> > > On Mon, Sep 16, 2019 at 03:49:20PM +0200, Thierry Reding wrote:
> > > > On Mon, Sep 16, 2019 at 06:17:01AM -0700, Guenter Roeck wrote:
> > > > > On 9/16/19 12:49 AM, Arnd Bergmann wrote:
> > > > > > On Sat, Sep 14, 2019 at 5:26 PM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> > > > > > > On Mon, Jan 30, 2017 at 12:05:06PM +0100, Thierry Reding wrot=
e:
> > > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > > >
> > > > > > > > Hi everyone,
> > > > > > > >
> > > > > > > > This small series is preparatory work for a series that I'm=
 working on
> > > > > > > > which attempts to establish a formal framework for system r=
estart and
> > > > > > > > power off.
> > > > > > > >
> > > > > > > > Guenter has done a lot of good work in this area, but it ne=
ver got
> > > > > > > > merged. I think this set is a valuable addition to the kern=
el because
> > > > > > > > it converts all odd providers to the established mechanism =
for restart.
> > > > > > > >
> > > > > > > > Since this is stretched across both 32-bit and 64-bit ARM, =
as well as
> > > > > > > > PSCI, and given the SoC/board level of functionality, I thi=
nk it might
> > > > > > > > make sense to take this through the ARM SoC tree in order t=
o simplify
> > > > > > > > the interdependencies. But it should also be possible to ta=
ke patches
> > > > > > > > 1-4 via their respective trees this cycle and patches 5-6 t=
hrough the
> > > > > > > > ARM and arm64 trees for the next cycle, if that's preferred.
> > > > > > > >
> > > > > > >
> > > > > > > We tried this twice now, and it seems to go nowhere. What doe=
s it take
> > > > > > > to get it applied ?
> > > > > >
> > > > > > Can you send a pull request to soc@kernel.org after the merge w=
indow,
> > > > > > with everyone else on Cc? If nobody objects, I'll merge it thro=
ugh
> > > > > > the soc tree.
> > > > > >
> > > > >
> > > > > Sure, I'll rebase and do that.
> > > >
> > > > I've uploaded a rebased tree here:
> > > >
> > > >     https://github.com/thierryreding/linux/tree/for-5.5/system-powe=
r-reset
> > > >
> > > > The first 6 patches in that tree correspond to this series. There w=
ere a
> > > > couple of conflicts I had to resolve and I haven't fully tested the
> > > > series yet, but if you haven't done any of the rebasing, the above =
may
> > > > be useful to you.
> > > >
> > >
> > > Maybe Arnd can just use your branch (or rather part of it if you would
> > > split it off) since you already did the work ?
>=20
> The branch needs to be rebased once more as it is currently
> based on linux-next.

Yeah, I usually do that once -rc1 is out.

> > Yeah, I can just send the pull request for the 6 patches after -rc1.
>=20
> Ok, sounds good. I'm also happy to take the remaining patches
> in that branch, for the other architectures.

All of the patches beyond the 6 in this set rely on the system reset and
power "framework". I don't think there was broad concensus on that idea
yet. If you think it's worth another try I'm happy to send the patches
out again.

Thierry

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1/8FUACgkQ3SOs138+
s6HQbRAAsAUrB9Y5EaS4wEkYNlG8Rh/+XitObYyO7DUe3QoQrleUdMXXeKD3JFXK
xqS07ZGmP+QktlmXAB0qv+g6buemf5MhbV4bBc2wos69IQIvoGoEBzg2RWBsNboY
TCTHB+j/brHP5T4sAjG2BON/zF/0p/JUUSzhpgdZqjmw7E+G05ylY35LUevlqM4o
kPLPSMuGgjZJN5DyJS4NAazq7qCh633q1XzCCNhwbO/qXYNn+LVu4pTNrM4g7MAN
S2h4tiJtmq+QAIUxHOLEPnZoV2n1XDFaJdyaAdAE/a9x23enYy5W9l042RoHIJBv
+vi35fDODi+KTgtJEkwkpoo5af8fjKILC6MLkTEKsc/JK3gOnXhW7xrdgsxtzAR0
1ZbA5EiEcGTwUn6AuTlTucAwW48HeI4pnzf/ieehbD2xr5SYjav7swns2ELrMV+Q
KQSWVGYuu2aDlicqcb3LU643Eip3b+kZrwsY0rURrZuiuYGm4IdQkImpdaQned+m
Zr5JU51cparoKgaedXAL+j4S4NWHa7gFzEURfto/WtlloguvZnLUg65y35SCqPaV
7xinlyQ9c7gBAMWy4dNoK5oLx9dsL0b+wjq/kVFYvtcX61ggphBOIVmwjQsAb5Yq
w+UhuTklA/79e7xaD7nwYHphQrWcI+NTOkj1CFdJGM5NkFuzMy0=
=0vrW
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
