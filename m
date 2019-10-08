Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55583C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290372070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570539107;
	bh=jRM4Zesg0jN0JswFt/PNJV46h2fvDyIbSQSWcSr8ats=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CkD5Z4z1/hGh7jlBufsjoF57rfMhBSbFff0zzKZPeeoR5fR6KMZPYR+lnSXAXtQIy
	 fSxY5saAeC1AULHhOlLzJWr4LFdWZSiG31uzu3twS7L+rSXMYac6HvgnKqDA+htSxv
	 yDWqiKL8UO7+fN07gYL3VAW9X84KIewmXTgiKw/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfJHMvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:51:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49882 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2n6KBQWMDX1NrqLedWsDmkizN7mYazzOB0W13u6An5A=; b=G78Y/6i08x9DeNvvEVM96XWyE
        RyIXDeJjTcvYB1OiwKv3Max1iEOCv/EU4MKXFnpaYtkllhq70vjDUR2VBHd7CWNAUfid7BWAf3MCJ
        2dRGVWWL2Coi7+Ho6WhEmGGBwR3QQxVDPu+shjKh2OnQL0j0JSk1ih8B4ADBXE6qblTdc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHoxp-0008LX-Rd; Tue, 08 Oct 2019 12:51:41 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 149212740D48; Tue,  8 Oct 2019 13:51:40 +0100 (BST)
Date:   Tue, 8 Oct 2019 13:51:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191008125140.GK4382@sirena.co.uk>
References: <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191007093429.qekysnxufvkbirit@pengutronix.de>
 <20191007182907.GB5614@sirena.co.uk>
 <20191008060311.3ukim22vv7ywmlhs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="08ATZu8fEq0x2T3M"
Content-Disposition: inline
In-Reply-To: <20191008060311.3ukim22vv7ywmlhs@pengutronix.de>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--08ATZu8fEq0x2T3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 08:03:11AM +0200, Marco Felsch wrote:
> On 19-10-07 19:29, Mark Brown wrote:
> > On Mon, Oct 07, 2019 at 11:34:29AM +0200, Marco Felsch wrote:

> > > Sorry that won't fix my problem. If I drop the regulator-boot-on state
> > > the fixed-regulator will disable this regulator but disable/enable this
> > > regulator is only valid during suspend/resume. I don't say that my fix
> > > is correct but we should fix this.

> > I'm having a bit of trouble parsing this but it sounds like you want the
> > regulator to be always on in which case you should use the property
> > specifically for that.

> Sorry my english wasn't the best.. Imagine this case: The bootloader
> turned the display on to show an early bootlogo. Now if I miss the
> regulator-boot-on property the display is turned off and on. The turn
> off comes from the regulator probe, the turn on comes from the cosumer.
> Is that assumption correct?

No, we shouldn't do anything when the regulator probes - we'll only
disable unused regulators when we get to the end of boot (currently we
delay this by 30s to give userspace a chance to run, that's a hack but
we're fresh out of better ideas).  During boot the regulator state will
only be changed if some consumer appears and changes the state.

--08ATZu8fEq0x2T3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2chlwACgkQJNaLcl1U
h9DiZwf/bvPEqEoOEgmUuBCG0BmsfN+JJ8gdKd2SO2lyrse3oD/ilDKaaX8Noiay
6PyqZ8OzEUwuHoAru466V12PvIJQgcHthAI4RWjVM3JkjpdzGbEZkjsbwa6h7iL0
jfKZm9So7YUY8h6TVqU14X6eUPG7zFPKXYfh8w+CiSqFW/AdQ8lofUTYCW5Ib1Vx
qsVbqH/oOb79jAdo5Y8Glp/9nZspLePSfav96s3ORv2mVo7VjkBsEcyDksWJs1/3
Ul9E3g0SuYYJpcO4PP5vKI4eCZY0oTaEVEgruAVs0Sr0Y5jM0ZJ8rbMtPkS+066L
vY86ztk/oB7s+yai0Rsdq/SmBEK2HA==
=K3vQ
-----END PGP SIGNATURE-----

--08ATZu8fEq0x2T3M--
