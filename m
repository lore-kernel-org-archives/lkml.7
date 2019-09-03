Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224B8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82682173E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567532893;
	bh=fpHWju9iDAcUth0qUXFxtfbspBkgFy3ozSWAWork6T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s3e7+3nPwErGgTXQg1h1XTfUmw33S3K+VXuz+KShPZvyMVnCjNTVM8KZnJYG6JAbM
	 VySriLntFTZ3hFS7dlcgPocsuuexSg5O5rkMJpgNcSIGdCjw5tjiEB20tIqdcM/htF
	 ZeMTg64qh44y0qqJs/xqpV/sA6nAp268Veh1iVM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfICRsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:48:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48438 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zvy0cmcCS2UqHRB6ROv3+py+lgL7vtVDSDbGP6ppS/Q=; b=oJ1NeYUe3QPF59vT/aorPVMR+
        JYiFvXyF5mjFZEqRUjNCtIKJpxwQ2Fy1ty/ow3ho0KrzoqLyw7xPWsahEk8nCno2KOau9dYfA4lHr
        9zKk7LlbJA+6oisS5wm8o9S8PBsvFclpl684Ji+hRyPHd5gweZvwNoMvwOGm7oxpb0tyA=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5CuQ-0000uI-0y; Tue, 03 Sep 2019 17:48:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 294862740A97; Tue,  3 Sep 2019 18:48:01 +0100 (BST)
Date:   Tue, 3 Sep 2019 18:48:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ASoC: es8316: judge PCM rate at later timing
Message-ID: <20190903174801.GD7916@sirena.co.uk>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <20190903165322.20791-1-katsuhiro@katsuster.net>
X-Cookie: You will pass away very quickly.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2019 at 01:53:19AM +0900, Katsuhiro Suzuki wrote:

> Root cause of this strange behavior is changing constraints list at
> set_sysclk timing. It seems that is too early to determine. So this
> patch does not use constraints list and check PCM rate limit more
> later timing at hw_params.

hw_params is a bit late to impose constraints, you want them to be
available to be available to the application before it gets as far as
picking the parameters it wants so that you don't get hw_params failing
due to an invalid configuration.  That makes everything run more
smoothly, applications should be able to trust the constraints they got
and some will not handle failures well.

The way this works with the variable MCLKs is that you end up in one of
two cases (wm8731 and wm8741 do this):

   1. The system is idle, MCLK is set to 0.  In this case no constraints
      are set and we just set MCLK to whatever is required in hw_params()
      in the machine driver.
   2. One direction is active, MCLK is set to whatever that needed.  In
      this case startup() sets constraints derived from the MCLK.

There are races in this if streams are being started and torn down
simultaneously, there's not much we can do about them with the API the
way it is so we do have to validate in hw_params() anyway but it should
be validation not constraint imposition.

If the system has a fixed MCLK it just sets that on probe then we always
get the constraints applied on startup through the same code that
handles case 2.

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1up1AACgkQJNaLcl1U
h9BQogf+P2FPf4VyCSSMUsxKQIRYcVqySrIM/8U5LYf3W/Ti2KizQbw7G/N19kU5
Q1USsYI+BktP4bDUdRukW6qnNYp4kQTzVlhdS+JWz8s5sBDrErcKA0gOfBTDzfX2
jtM/LGASFQUhHV7i23g3FYyfmYkLR6fw6As3XI1gTWwZWpwb8L07XWZpy1YPs/ca
4m6Tnt1qb12CSzV1sclwRovoVWpwnDL7XYyTjRV3d2ywl9nyrKjke8TZP+PBKXlB
n+6Q+uBSHmxKBaBOlHkymNojgXP5pNrd2Dsq/Ngf/VBMnHOEAUNh1kWlHZAhqTPq
THnfPYSffJSt83BF5PwCEeRdv66pSg==
=QPbn
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
