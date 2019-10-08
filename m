Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D427C35280
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767D9218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570551821;
	bh=7LSvG7Z2/shv9SD/4ep9F4XsDMDUqCWfKeBaQ6bS/iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nZ9VhpniJhJFkONt7kj/QAd0DKgYJ6VoT04ZNjZAvbfNMSJUvnqcTfgeQ490dFXkf
	 HpKG5gZkGXDdcx7AWiDRXCXY1qLkK06BFxJgmzRsXWwH+1zVGnL/yeDxOVFALn1AV8
	 rjOfqppARfxAJQqrZ9UEY+bLrDpgWGXlcH80EM4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfJHQXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:23:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ii7hnic6xKdkLBwpZElFY044FUzKz7oXyF0dN3nO9SM=; b=MTZKPqsnxtWOHMIpMUPYFu5Vw
        wOxnm0fVU4p3m5h3f/rNDOyIoSObvw/GUtbQkeTb16pXVksMvyC1Y7BfYDXsNjAE8OXTx/yEGy9Lf
        XkfkK7fHfJM0gT5JG0kBpoZBe3WBdmKu+49HbeZAXMgF0MwvaMqJL3xSUstUEnodhlCRQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHsGs-0000Sd-Fc; Tue, 08 Oct 2019 16:23:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DEBA62740D4A; Tue,  8 Oct 2019 17:23:33 +0100 (BST)
Date:   Tue, 8 Oct 2019 17:23:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191008162333.GP4382@sirena.co.uk>
References: <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191007093429.qekysnxufvkbirit@pengutronix.de>
 <20191007182907.GB5614@sirena.co.uk>
 <20191008060311.3ukim22vv7ywmlhs@pengutronix.de>
 <20191008125140.GK4382@sirena.co.uk>
 <20191008145605.5yf4hura7qu4fuyg@pengutronix.de>
 <20191008154213.GL4382@sirena.co.uk>
 <20191008161640.2fzqhrbc4ox6gjal@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OmL7C/BU0IhhC9Of"
Content-Disposition: inline
In-Reply-To: <20191008161640.2fzqhrbc4ox6gjal@pengutronix.de>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OmL7C/BU0IhhC9Of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 06:16:40PM +0200, Marco Felsch wrote:
> On 19-10-08 16:42, Mark Brown wrote:

> > If this is a GPIO regulator then the Linux APIs mean you can't read the
> > status back so it's one of the regulators for which this property was
> > invented.  This is a real limitation of the Linux APIs, with most
> > hardware you can actually read the status back so we shouldn't need
> > this.

> I know and I followed the discussion between you and Doug. But it
> is a valid use-case to have a external gpio-enabled regualtor connected
> to a panel. If I don't mark the regulator as 'regualtor-boot-on' and use
> the fixed.c driver (IMHO this is correct), the regulator gets disabled
> during probe. So I will have a panel off/ panel on sequence during boot.

Right, this is why I am saying that this is one of the regulators for
which this property was defined and where you should be using it.

> To avoid this I set the 'regualtor-boot-on' property but then I can't
> disable the panel during suspend..

As you'll have seen from the discussion that's a bug, nothing should be
taking a reference to the regulator outside of explicit enable calls.

--OmL7C/BU0IhhC9Of
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2cuAUACgkQJNaLcl1U
h9DJ8Af/d9MHeegO3mG0aWykYncA/Uz7MQ8AB1ExPlJrkChn+k1IhFInP0BUaEMf
xR6K6jBZRAiFiehJJWMFY8b73OLLaWhqjVEz7VHSIyGotcFPykDF6ESj8w279FiZ
wZEeXbW366ztz7GqWo0U60Hv+yp5wUVrdxtFTKHOzl+kSHDgpy+Fq4sTu5GEtlmb
T8XI50JK1npkImJ4a+MutR4DQhZm9hoSR7Tq4FSiP6Wlex2jvMgLrDxexgUQhbkY
iGFt5TAgSy4WSds2O9o9ujNU6evUhr8mzh0Ze7k4FAz4EhrsfibuJBHGoSl0oPdY
0vUrqwoqjuPTzftepnXUcghNVuhubg==
=LEgR
-----END PGP SIGNATURE-----

--OmL7C/BU0IhhC9Of--
