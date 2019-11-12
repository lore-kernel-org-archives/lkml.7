Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F71EC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801C620659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKLVTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:19:53 -0500
Received: from sauhun.de ([88.99.104.3]:37572 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKLVTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:19:53 -0500
Received: from localhost (x590c7292.dyn.telefonica.de [89.12.114.146])
        by pokefinder.org (Postfix) with ESMTPSA id ECD472C015F;
        Tue, 12 Nov 2019 22:19:50 +0100 (CET)
Date:   Tue, 12 Nov 2019 22:19:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add
 'fixed-emmc-driver-type-hs{200,400}'
Message-ID: <20191112211950.GB3402@kunai>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
 <20191105062223.GB1048@kunai>
 <20191105083213.GA24603@vmlxhi-102.adit-jv.com>
 <20191107003907.GA22634@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20191107003907.GA22634@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

> > The first question which pops up in my mind is related to the meaning
> > of each item. The option which I envision based on your proposal is:
> >=20
> >   * minItems: 1
> >   * maxItems: 2
> >   * Item[0]: Presumably equivalent to the current
> >     "fixed-emmc-driver-type", i.e. the strength value applied in both
> >     HS200 and HS400 modes.
> >   * Item[1] (optional): Presumably equivalent to
> >     "fixed-emmc-driver-type-hs400" proposed in this series. If this
> >     element is provided, the first one should likely change its role
> >     and become an equivalent of "fixed-emmc-driver-type-hs200" from
> >     this series.
> >   + Pro: Full backward compatibility. No need to touch the existing
> >     users of "fixed-emmc-driver-type".
> >   - Con: Not sure we have such DT bindings which dynamically change
> >     their semantics based on the usage pattern.
> >   - Con: Can't easily achieve the same flexibility as accomplished in
> >     this series. For example, current implementation allows users to
> >     define each of the three parameters (i.e. HSx00-agnostic drive
> >     strength, HS200 and HS400 specific drive strengths) individually,
> >     as well as in all possible combinations. This might be needed if,
> >     in certain HSx00 mode, users still need to rely on the
> >     RAW/unmodified drive strength. I am unsure if/how this can be
> >     achieved with an array OF property with a constant or variable
> >     number of elements (I try to sketch one solution below).
> >=20
> > One option to achieve a similar degree of flexibility by using an array
> > OF property (instead of several u32 properties) would be to agree on a
> > convention based on magic values, i.e. below DT one-liner could be an
> > example of providing solely the "fixed-emmc-driver-type-hs200" value
> > (based on the agreement that 0xFF values are discarded by the driver):
> >=20
> >     fixed-emmc-driver-type =3D <0xFF 0x1 0xFF>;
>=20
> I don't understand why you have 3 values instead of 2.

Because he sketches maximum flexibility here. Have a non-HS (default)
value, one for HS200, and one for HS400:

	fixed-emmc-driver-type =3D <[default] [HS200] [HS400]>;

> I would just use -1 if you want to ignore an entry. If that's the common=
=20

'-1' sounds good to me, too.

> case, then I'd stick with what you originally proposed. If rare, then I=
=20
> think an array is the better route.

What I have seen so far: setting drive strength alone is more on the
rare side. Setting specific values for default and HS200/400 seems even
more rare to me. With this patchset, it is the first time I hear about
it.

Yet, my experience might be a bit limited, maybe others (Hi Ulf! ;)) can add
their views, too?

Regards,

   Wolfram


--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3LIfYACgkQFA3kzBSg
KbZ6AxAAogqz/CwHCOeNP4khZeJ7sC5Ygz+6eicsFbLHeuwpOH0ISXnttpqbFDmy
FIJxvL634Pqx5Cd9PsQG3S1V6prgKnnCLDZBX3KV1kYRtsAgvjx3w/AYotdeyitC
MT1fazgM4JKJV7MOdmEqBZ9KtIH1/wRqYAD/sftTcy/0sPDsq3+aCsGiQnTcUEtC
d6YA1ANOrnFYTxHFv2ze+Zo4ewaRBzFSBPNwzNL4Ps3IBB8z38iYBnq6OOgMnfub
B8pTntxQeWLank+apB7nZYxH3w3qs7t0qkuVwz/7qyhHcGxpfU41VxwhceFH0fFe
s//pE2DI1n4CwtRtNPryIoAW2PYuzMBGhNQ67oQQCQsWKjEgaQLGm29VQgEj3zYx
1dUoJIrom9MOA3t0JGURhBSXtdOw5K8RNVcspidoGobn52f1WQcxr/dwOoArDEqo
4hFZosQnzqcGkKksE74Jj7XZQON9ZnSV5t3IU8SpNaYjswPu/rWaysPZcVDSPMPa
EMFp7JwHYBoJEuUoaulsHIRZphCu1z8Zb8JsXBExs1zps0K3EwRiK6KKNoR11j1c
rhD40N2NSMMXoOLfMFYqVG/Kp/iAvD7p3fqMoL31vLPjgab2xnVHMEuXPgKaUISy
CZWEyhzRZhZ80HuDaDnaLyWjeLqBaEhxvazgd2/caBUmZSjsZZE=
=UCNR
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
