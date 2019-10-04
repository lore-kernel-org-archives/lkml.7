Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926B7C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6632F21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201317;
	bh=MfhuAzXydxhBaUWterKOhhJGc1wLdjOrUOOcssF3DOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xMguwkh7USFJ1y/laKYGXo08fOMfhlM2gIn5JT1jQtaDDvET9DYVc78rX5KwvfGEw
	 ckChObYlRGoSQvY5d9VDnIcHOjEtvkkAwIyNFa7a/Rl9511vyKajY7auFxgIraACze
	 6rNWvuB4hMA950qjFTxF44+26hevDXmU6939wjfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbfJDPB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:01:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45948 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389086AbfJDPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZaTigd/mFqFEshb4ff8vggdJGTR/mzazUi0rgLPaCTg=; b=JCKsTANn2YGnsi2Y8hheYkOOz
        dJqkW3O87h+KHVEsCNYJHyy+1mxSwYktA6FsQLaS7uREgBUQkLmN5Q8wVZfKmzJv1h+8ub/YUpeCZ
        0k+qz7ztm7DvkLpQ6+fA30h4swNxQBKvYGXmInqz7JX0j3yJmt0ow7QkjucLUQtab8+Zc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iGP5b-0003Gn-MX; Fri, 04 Oct 2019 15:01:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E9C722741EF0; Fri,  4 Oct 2019 16:01:50 +0100 (BST)
Date:   Fri, 4 Oct 2019 16:01:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "zhang.chunyan@linaro.org" <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191004150150.GD4866@sirena.co.uk>
References: <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191004063443.GA26028@localhost.localdomain>
 <20191004113234.GA4866@sirena.co.uk>
 <054bc4c050f1b16988de057f812232b0feb707cb.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <054bc4c050f1b16988de057f812232b0feb707cb.camel@fi.rohmeurope.com>
X-Cookie: core error - bus dumped
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2019 at 12:03:12PM +0000, Vaittinen, Matti wrote:
> On Fri, 2019-10-04 at 12:32 +0100, Mark Brown wrote:

> > If you want the regulator to be on without any driver present then
> > mark
> > it always-on.  If you want the regulator to be enabled prior to the
> > driver being loaded then the expectation is that the bootloader will
> > do
> > that, it's difficult to see what the benefit there is from having the
> > kernel enable things when it starts prior to having a driver unless
> > the
> > intent is to keep the regulator always on.

> I thought the regulator-boot-on could have been used for that. But as I
> said - I don't really know all this so well =) And no, I am not opposed
> to offloading this from kernel to boot, I was just trying to learn what
> is the correct thing to do (tm). Thanks for educating me on this :) I
> will suggest adding the enabling to boot code if (when) I get questions
> concerning this. (always-on won't do for regulators which need to be
> controlled for power saving or heating issues).

If you want the kernel to do it early on without the bootloader then I
think we really need to understand the use case.  My guess would be that
the underlying request would be to get the driver up earlier which is
something we should be better at but often easier said than done.

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2XXt4ACgkQJNaLcl1U
h9BNdQf416+VGBOjTatwFvaSTvsGBrnD/HdQvJRJ3HcPIpxnx/TapsTWnUxLAOBP
5iNa4+1zINbju+sls2X8cIsEiM4+AsGcQ5geP25xLa+6aNwDvl566Z2ssuwSEbNa
kurJ1cXy4fg/19HaFwQ4V6BPG/aiEfPSNZ4Y2kgz0y9O57uoUctPw/aiiPO6DORa
sElQklRIbI7nKs/OwF66cCKzldUkJJg7+i/DhgY492f+ilOgXQAF+ZOq58iKdwdI
Ej6Rm8PtqEzvyQCstCBI7NvKyslfI1lGTCAiooS81SKYM94E2YlMPN1o57BrHT/6
3PaAGBvv7oDBQelirUtbvrG8opY1
=/EfI
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
