Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE96217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570549340;
	bh=FGXlU7U8Iht45bYswLcvMMu0agA8STBNwwIwNkTYpiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ToGNWPh2Ex8BWz0lwzMFOKmkTGcfk0ob7e08DLd4x6z/KeOVrw4z5X5M7h1G73zzK
	 WwF/Y98xWTFx3QchB9kzUM/aN2lPbt1vs4FDD+/cOdOY9zBfCZazYcXmXA/bFpEikr
	 Z5tcc1NuwAzigtyAovRlZjAjRcvaTZ+zRQMElNYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfJHPmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:42:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GdhMck5n++7UmnbvU0bVk6Fsaf8pOkqwSgmDxPlXMQs=; b=oEXrYv7ctkdv0gFXG0dCyuiN5
        oCLQ0wNomM5hrvuMzjp/qceW2gWf2urPZCRrYUI0v+a0xX7x+D9Wl/AyM4NOsVqGJ4ZLWOXdQyJuA
        jJMZq/1EGG1fFsFhXg2mkE1OKsBGfKLUU+mQgPQP1md1SsamgkxvoClChKe0kToN2nkiU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHrcs-0000MS-QP; Tue, 08 Oct 2019 15:42:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E14002740D4A; Tue,  8 Oct 2019 16:42:13 +0100 (BST)
Date:   Tue, 8 Oct 2019 16:42:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191008154213.GL4382@sirena.co.uk>
References: <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191007093429.qekysnxufvkbirit@pengutronix.de>
 <20191007182907.GB5614@sirena.co.uk>
 <20191008060311.3ukim22vv7ywmlhs@pengutronix.de>
 <20191008125140.GK4382@sirena.co.uk>
 <20191008145605.5yf4hura7qu4fuyg@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hdW7zL/qDS6RXdAL"
Content-Disposition: inline
In-Reply-To: <20191008145605.5yf4hura7qu4fuyg@pengutronix.de>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hdW7zL/qDS6RXdAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 04:56:05PM +0200, Marco Felsch wrote:
> On 19-10-08 13:51, Mark Brown wrote:

> > No, we shouldn't do anything when the regulator probes - we'll only
> > disable unused regulators when we get to the end of boot (currently we
> > delay this by 30s to give userspace a chance to run, that's a hack but
> > we're fresh out of better ideas).  During boot the regulator state will
> > only be changed if some consumer appears and changes the state.

> Okay, so this won't disable the regualtor?

> 8<----------------------------------------------------------------
> static int reg_fixed_voltage_probe(struct platform_device *pdev)
> {
> 	...
>=20
> 	if (config->enabled_at_boot)
> 		gflags =3D GPIOD_OUT_HIGH;
> 	else
> 		gflags =3D GPIOD_OUT_LOW;
>=20
> 	...
> }
> 8<----------------------------------------------------------------

If this is a GPIO regulator then the Linux APIs mean you can't read the
status back so it's one of the regulators for which this property was
invented.  This is a real limitation of the Linux APIs, with most
hardware you can actually read the status back so we shouldn't need
this.

--hdW7zL/qDS6RXdAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2crlUACgkQJNaLcl1U
h9DhNQf/c0tueEtIFOfwUOmWcYcHM+HAyOgQRLMkCr/JxjXvP4OyL7pvofT9Fmh4
yFFhq3w1gQ6KAatyLrrIRLc1Fu2KaGr3FtvhtzJ0vsjS5jIdpFXhalvuwxP+uQo3
MPi6g4FneYn/SHQnlV1/4JoWyYnNwgXpqmnnpyQHpXxIRQevnD7TSLSmmLbdNgq4
3W/DevfeX45f+kBLQf/xlHPHVjA7RMBaKt2zxTSP6rtFyjSigfyPN3qfJvLElInB
yMGGrjUUUjcMyLH5uhhYIvVUZY232a98v9x1w7JRNOw5Oe3T+CUlahwfind9MDyf
vKqEqsKGad/zg/S+VC0l4GIS0jogzA==
=Vs6+
-----END PGP SIGNATURE-----

--hdW7zL/qDS6RXdAL--
