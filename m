Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1CAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2498720729
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573732478;
	bh=MR/xDbzY1OeC4MSdJyv6RZ4DXouXjyx9c/SgwTk+pew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qmb43Wt7xESWuRQ/CUuFY1pBSCgiYUzv3Hk6CuJH1aci7QI515KltvHMPl1KXL+Z9
	 Ncimn0YOj6ju3tO1TQYuiAs7r2iffO+j+A/QNj5gY0ncsPYQjPAyrf+jv6GuLI42Js
	 1pgVjigQJy6TEMqD9MAaSIvFCT7nIA3Unc68Nn8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKNLyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:54:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46294 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfKNLyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FNFzuQqZujPKD40NyWLxKJ7ScaxZfKC5iYYyS8XkM3Q=; b=U4Xnof6DO4C4dZv5uxffqA6A+
        X6SuBWBQSg7FldXtlOHOaT2Z+O8uq8Dxv9a239/E9GuKr8QWRZUePi1MnpK/YEumZatpyyXZmoTg1
        4KOnujtj/pjpEGWJSNvlhD4vGySC/V5s3nLIJJmlGH8lfAJ/WCJpaP95RVagzjigLfePc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVDho-0006ru-Dj; Thu, 14 Nov 2019 11:54:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id F4155274328E; Thu, 14 Nov 2019 11:54:30 +0000 (GMT)
Date:   Thu, 14 Nov 2019 11:54:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, phh@phh.me,
        b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
Message-ID: <20191114115430.GA4664@sirena.co.uk>
References: <20191113182643.23885-1-andreas@kemnade.info>
 <20191113183211.GB4402@sirena.co.uk>
 <20191113202633.66a91d96@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20191113202633.66a91d96@aktux>
X-Cookie: Santa Claus is watching!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 08:26:33PM +0100, Andreas Kemnade wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > This definitely looks like a bug but without a datasheet or testing it's
> > worrying guessing at the register bit to use for the enable for the
> > second LDO...

> I am hoping for a Tested-By: from the one who has submitted the patch
> for the regulator.=20

Or a reviewed-by from someone with access to the datasheet.

> Well, it is not just guessing, it is there in the url I referenced. But
> I would of course prefer a better source. At first I wanted to spread
> my findings.

The URL you provided looked to be for a different part though?

> I am not pushing anyone to accept it without Tested-By/Reviewed-Bys.
> What is a good way to avoid people bumping into this bug?
> Maybe I can find the right C on the board to check.

That'd be good.  Or we could fix it by just removing enable/disable
control for the second LDO entirely and if someone needs that control
they can always re-add it.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3NQHMACgkQJNaLcl1U
h9AObwf9G+cj84GDYKW0w7bOS2mrpyX7lheGzkT+ZNZDOphlbpbHoFKpKjqLiml1
SAOLjBUs1UlN0xQu/TqzdqFcCV3pWSQRQUJVDpp3zjivU6he7YfTbdVoK2ILyn+d
lfgmvyIBmx3PcAXpaGvJr0G4zqHOw9R46pzPQUe3S1LeJtgWwBFSqy76Bk3g3crD
F1/eg2Entc6fl3oVKq+UC2Di9lBbnJD5yiNMnzIgWLgr0Jw+/VlMzTCIW6gjXbqT
tEQvAzBV626UQ90mxyq3YKDLiuYypPpsWHLlZiVa0Kzm+J0CFi+2TzCuIAIXak6T
W8Ac2gQE1ybaiVNprxbqZZ7Tp97Rhg==
=xuQF
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
