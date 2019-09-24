Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E90C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B84A20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569349688;
	bh=cEi39glZ3UfUh8uyutFIaso7FlO39gsnaw69MB7w3bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rCWz156vdgNsJh/iXou4F8NhgmvYvWGXcrLWnp0rqgv8bUIiNbeAksQyprTzWI5DS
	 p/LJbPFO69lZ2OWzmjHZmsouXmoMThlD2w1NDdweXtUgVs+UrSamlbb8QkT8gpHu35
	 KNNLbZexze2li6zhqdhiSpTrBQsRligyD3jCNDFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404494AbfIXS2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:28:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43210 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392088AbfIXS2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ru9mal8KOKGk0u5+JjM3snNEFIiw/GH6sWJmew5Mbmo=; b=iMLalSqvX4V4f2ZB9579UTxiC
        lFacjFxCpjbg3bcmuHXinoLVyEIgzJZj57QM/ilpgiSTFqIn7z8RiWKSzAOmbW6MzPWbLkM1j5IJN
        NnqGQjGRpWpPDN0uZUcqASVioB13zC8zrjvXhgDNRlc7ftnKk6u+KQRb8YsTKhRTcjCIc=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iCpXb-0002nG-W2; Tue, 24 Sep 2019 18:28:00 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 65E56D02FC7; Tue, 24 Sep 2019 19:27:58 +0100 (BST)
Date:   Tue, 24 Sep 2019 11:27:58 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20190924182758.GC2036@sirena.org.uk>
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-2-m.felsch@pengutronix.de>
 <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk>
 <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uMD30mxrM/iO8yI3"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uMD30mxrM/iO8yI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2019 at 03:40:09PM -0700, Doug Anderson wrote:
> On Mon, Sep 23, 2019 at 11:49 AM Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Sep 23, 2019 at 11:36:11AM -0700, Doug Anderson wrote:

> > > 1. Would it be valid to say that it's always incorrect to set this
> > > property if there is a way to read the status back from the regulator?

> > As originally intended, yes.  I'm now not 100% sure that it won't
> > break any existing systems though :/

> Should I change the bindings doc to say that?

Sure.

> > It should be possible to do a regulator_disable() though I'm not
> > sure anyone actually uses that.  The pattern for a regular
> > consumer should be the normal enable/disable pair to handle
> > shared usage, only an exclusive consumer should be able to use
> > just a straight disable.

> Ah, I see, I wasn't aware of the "exclusive" special case!  Marco: is
> this working for you?  I wonder if we need to match
> "regulator->enable_count" to "rdev->use_count" at the end of
> _regulator_get() in the exclusive case...

Yes, I think that case has been missed when adding the enable
counts - I've never actually had a system myself that made any
use of this stuff.  It probably needs an audit of the users to
make sure nobody's relying on the current behaviour though I
can't think how they would.

--uMD30mxrM/iO8yI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2KYC0ACgkQJNaLcl1U
h9Bi9Qf/eBRr9wwlGQ2FMJOED0zECVIPit6Vf3FVdmFrjp3PyY6Fh+LlwcHs3/3j
c12CzWN8RhLBFHLGS3pBoQ1+5Ye0bYjv+ryTtNzYUAv7npXMYJTV4ae3rsgY4Hd5
Sfs+lz3d2Co5TJ7aF+CBP1qFSjVQb28v5lsx3IBV6i5+2lm2Vtq9JOMXgno6aMcU
ojHBTKKLYK7vft/65lltxopiRJ5XyE0GBppaNWvS1cewc+cpdcJsw5p1SYOidkQh
zADgVSyfUps8fdr2EemHJu5WsfT0A/iFoEEsQCMB4IyMRF5tAtT2YffhoNl6PZkP
LXLXO6fRmz4Ow8SuRTX0X9FdFojJJQ==
=wK9+
-----END PGP SIGNATURE-----

--uMD30mxrM/iO8yI3--
