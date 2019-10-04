Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADDC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1102070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570188762;
	bh=gfT5rm558XD0r2XVVjYoBImMD7mL+PRY0vjWS+DxR80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yiJTRpCAANeVadlEPVOaH+4INhcO34ZNMgGwqpmAYO0KQcP4q2yHdMwApl0mHvW22
	 d7mM3UUFJ9qAncpiqoApVupQ1FtqBVZwTKNJlxiWivghWxOlvi0jO9Qg8Cw1FBH1ks
	 FtybGxhYp6m9yz523vIEh7L2YfRvUaKe/SNuxgbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfJDLcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:32:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32782 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfJDLck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EibQ8tD/9wgxAWvxS0B7FIca/N/JJVXRnv1WMqemY7I=; b=imLlfLAh1WLMbRkrplm9Q9h3e
        AEPtD9ovg21kDzc4PLf/tQF0oW2kLNM8CPZ26354FKVq+zYQ0RZbSlGCeD0oI9LLLw0PKGwaGHnir
        9TMoLBfx8aT7Fd0krcq6SPoyXbfxYlsADhPU9d0LK17R/6n91Md271EQkMouvsJ8wse4E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iGLp5-0001t9-RH; Fri, 04 Oct 2019 11:32:35 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9EC5A2741EF0; Fri,  4 Oct 2019 12:32:34 +0100 (BST)
Date:   Fri, 4 Oct 2019 12:32:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191004113234.GA4866@sirena.co.uk>
References: <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk>
 <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191004063443.GA26028@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20191004063443.GA26028@localhost.localdomain>
X-Cookie: core error - bus dumped
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2019 at 09:34:43AM +0300, Matti Vaittinen wrote:
> On Tue, Oct 01, 2019 at 12:57:31PM -0700, Doug Anderson wrote:

> > I don't think your fix is correct.  It sounds as if the intention of
> > "regulator-boot-on" is to have the OS turn the regulator on at bootup
> > and it keep an implicit reference until someone explicitly tells the
> > OS to drop the reference.

> Hmm.. What is the intended way to explicitly tell the OS to drop the
> reference? I would assume we should still use same logic as with other
> regulators - if last user calls regulator_disable() we should disable
> the regulator? (I may not understand all this well enough though)

Yes.

> > It's a fixed regulator controlled by a GPIO?  Presumably the GPIO can
> > be read.  That would mean it ideally shouldn't be using
> > "regulator-boot-on" since this is _not_ a regulator whose software
> > state can't be read.  Just remove the property.

> How should we handle cases where we want OS to enable regulator at
> boot-up - possibly before consumer drivers can be load?

If you want the regulator to be on without any driver present then mark
it always-on.  If you want the regulator to be enabled prior to the
driver being loaded then the expectation is that the bootloader will do
that, it's difficult to see what the benefit there is from having the
kernel enable things when it starts prior to having a driver unless the
intent is to keep the regulator always on.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2XLc8ACgkQJNaLcl1U
h9CKbAf+MomEnF8qsWJhH9+YKxaRKOYjSkI7/venKgKu1CmyONAjtLnoMzTKLz+4
KvoSnUFict+yFSnQFQNoqsVU5mRGrW9PPWorWWrwGE+mRZwMCEXVVOWz4BwDt2mQ
xS93SntDUZ+QEONQnCHFAKJV5aO3VW4BQ6uncrEjh1cGiy5x1Ktt1PX68rBWCuf+
bNuqDH+M0zjjtQ/dfvYHeb1vehVm5ngE4Qnam8z+DC586cWoRnbzoIBA6wKRchin
MOBa6n8zo1ZnffK56v5Ym7fkiWFqIE/R3GoO5DnORNj8JXwgz5DBiKC+d6X8b4Pv
ufQqiKHY+2apWrQcpfi3PPkHodczJQ==
=j7+o
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
