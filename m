Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11715C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457021721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570614866;
	bh=ZC0vOQINsyNGd7xIhrWMkm7yGm7rqIMBGe9F5iuKzp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SrDtiSESEoMgFiZt9pa5ZFKe6/TcQmVWrBTOVmR1b7QpBJodH1VlKiARdlTyOr41I
	 vv2aTKTULEFtVU8gp27iBPsvhLGgE3IPK7MXrSxGXZDPRJtAJqLV4zWtyx8DT2Jrjr
	 zFdo1gDeu+SdNZI58hvFHTBVyE263ekAAesISGPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfJIJyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:54:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJIJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZC0vOQINsyNGd7xIhrWMkm7yGm7rqIMBGe9F5iuKzp0=; b=bZ9rVTGfpMwKT1WRVhvpYn72M
        pDxhbm/g4CYbX9rDigYBt0P6RNMxH6mRC892W7BkNJEzIoGycoLpa+sMV+jYX/p+InTpINoFvtZRV
        hxkjH5ONKseDV8pb/ub8u/K2CSYf2M/6De6LjHRJLkk9niSZyI63/Mp2PYdxwL6exoo2c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iI8fl-0004Kh-4b; Wed, 09 Oct 2019 09:54:21 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E41C02741DF9; Wed,  9 Oct 2019 10:54:18 +0100 (BST)
Date:   Wed, 9 Oct 2019 10:54:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191009095418.GA3929@sirena.co.uk>
References: <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191007093429.qekysnxufvkbirit@pengutronix.de>
 <20191007182907.GB5614@sirena.co.uk>
 <20191008060311.3ukim22vv7ywmlhs@pengutronix.de>
 <20191008125140.GK4382@sirena.co.uk>
 <20191008145605.5yf4hura7qu4fuyg@pengutronix.de>
 <20191008154213.GL4382@sirena.co.uk>
 <20191008161640.2fzqhrbc4ox6gjal@pengutronix.de>
 <20191008162333.GP4382@sirena.co.uk>
 <20191008201622.b7ev4nfyhqapspon@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20191008201622.b7ev4nfyhqapspon@pengutronix.de>
X-Cookie: Every path has its puddle.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 10:16:22PM +0200, Marco Felsch wrote:
> On 19-10-08 17:23, Mark Brown wrote:

> > As you'll have seen from the discussion that's a bug, nothing should be
> > taking a reference to the regulator outside of explicit enable calls.

> Okay now we are on the right way :) Is the solution proposed by Doug:
> ".. we need to match "regulator->enable_count" to "rdev->use_count" at
> the end of _regulator_get() in the exclusive case..." the correct fix?

Yes, I think so.

> Another question. Please can you have a look on the "DA9062 PMIC fixes
> and features" series as well?

I don't know what that is, sorry.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2drkcACgkQJNaLcl1U
h9DViAf/RF0TfpMLNnbhaomXY8PrEACy0gtxPIe5mkYd8WvYRw5Eb1C5fooJv7iW
PlRmOSXX+75jH4LO0ZzxRfqcXaV0mrML4O33x2OSSRgbNarvYcdN6xIDD6S5ITl8
qGTKoeL3K92Uw2CVPhZrQ2kMxPdl2vAduXMHK7KKRcGjDJ3+h696yBmgMdyJRmVN
koryxbEsEwQEHO9gOG210wzclfmLCHwuDgIQfGX/bO1l2bR73jzh+3ysHV/3KEt+
FOFo3We/7WzpOQaRKIh+p/4KFQfXECnPmeHv2mNo4FFIfgfb8gbitZL3wvyGwPzG
0EBVt6V5CitmxEzOuoSQTYbfanYSbA==
=hAJk
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
