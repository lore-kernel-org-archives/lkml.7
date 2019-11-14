Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A7FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5415206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="CkbkWMlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKNRDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:03:46 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:36262 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNRDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pc9fQikYaAe6/ClSXdt1Pl5bjZ94c01iG49coDy8QuE=; b=CkbkWMlw6R+GzR94wPV/UNW4B
        3KPva2GFj+9PaCxKw47u+BXC2akNDWn8q4N9HYhzTnu2y8QnpSDKXMWDNC2LLxH4fGgAaHMfiEdb8
        BGm9goyMD45IVOSMDpDdx9bzHGBVxZlEZ4ePEM+kepdTSKQq25l4/9DqfizqfP85juw8Q=;
Received: from [77.247.85.71] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iVIX1-0007pf-8x; Thu, 14 Nov 2019 18:03:43 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iVG8h-0007vp-J8; Thu, 14 Nov 2019 15:30:27 +0100
Date:   Thu, 14 Nov 2019 15:30:26 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, phh@phh.me, b.galvani@gmail.com
Subject: Re: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
Message-ID: <20191114153026.354f87bd@kemnade.info>
In-Reply-To: <25f0d55696be463def622a37a1f2b826@agner.ch>
References: <20191113182643.23885-1-andreas@kemnade.info>
        <20191113183211.GB4402@sirena.co.uk>
        <20191113202633.66a91d96@aktux>
        <20191114115430.GA4664@sirena.co.uk>
        <25f0d55696be463def622a37a1f2b826@agner.ch>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/79gjsROfYYqfaMMMG9hO6W0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/79gjsROfYYqfaMMMG9hO6W0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2019 13:13:47 +0100
Stefan Agner <stefan@agner.ch> wrote:

> On 2019-11-14 12:54, Mark Brown wrote:
> > On Wed, Nov 13, 2019 at 08:26:33PM +0100, Andreas Kemnade wrote: =20
> >> Mark Brown <broonie@kernel.org> wrote: =20
> >  =20
> >> > This definitely looks like a bug but without a datasheet or testing =
it's
> >> > worrying guessing at the register bit to use for the enable for the
> >> > second LDO... =20
> >  =20
> >> I am hoping for a Tested-By: from the one who has submitted the patch
> >> for the regulator. =20
> >=20
> > Or a reviewed-by from someone with access to the datasheet.
> >  =20
>=20
> I guess Pierre-Hugues should have access, as he introduced the part?
>=20
> >> Well, it is not just guessing, it is there in the url I referenced. But
> >> I would of course prefer a better source. At first I wanted to spread
> >> my findings. =20
> >=20
> > The URL you provided looked to be for a different part though?
> >  =20
> >> I am not pushing anyone to accept it without Tested-By/Reviewed-Bys.
> >> What is a good way to avoid people bumping into this bug?
> >> Maybe I can find the right C on the board to check. =20
> >=20
> > That'd be good.  Or we could fix it by just removing enable/disable
> > control for the second LDO entirely and if someone needs that control
> > they can always re-add it. =20
>=20
> We use the RN5T567 and I added support for it. Unfortunately I have no
> access to the RN5T618 datasheet so I cannot tell. The RN5T567 has both
> bits in marked reserved, but looking at how it the enable bit are
> distributed otherwise this patch fixes it in the only way it makes
> sense...
>=20
Well, the rn5t618 does not have these regulators, either. It is only the
rc5t619.

Regards,
Andreas

--Sig_/79gjsROfYYqfaMMMG9hO6W0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl3NZQIACgkQl4jFM1s/
ye9fNw/+K7EWXflnHuqjelDOdEjg7Zq6H4OZ8lzbhyNJnDnMdhmJOVOwzWT+ml25
lZwar+pKxxdN3uo1MAGp0Xm1ba/3qO40YXgN6aN8yOZYZfwZDX6ozfy7RmDH6CAv
0dUFw2HsmNowiGfwgrvfVJXke70EPn6tpZnJjRbmz4ZxCTXKmY/6O6qIt8IWroW9
zsgaOQAfF4v7EYH1uZ2KhYk9ZlX5AvY8uV1J/r/nE1POcbTixKhmfqPQDKcOfnll
KBBy0f+0zTaFY1AXkIlfu8rMrSJqijhFwx8zeeFLDPs7uOF4jZIBEryBi3KXiLdb
mfChO3ZHxDtixRgDlaYvJeD3Jq0vuoz0nIoNezaGYOfn7XzEpPYm+QwOU4ucuEOw
4yh4+Ugwk51aLcTn4U4B2vtvvTsE4MReGhzBRprqjAKrEGsGuEY6XpxYec+qz1+e
1fkdCuh3YTOxlIMLlzE2MA3vxAfQYOg1llIvr7qNcAk5UTftJ+7lacF5c7DvTpUH
1j9T0MfQ1txUsRKmDS9bi6C29W8Pf/qnb+LC6n6pc8u+3NXSiV/HwTpOvwzvMNUG
aQAPD/evbtInOwWP7N20HcMj7pDtq9NZDhwGsDtyHPLbW0flFNfEGjIZelRMIUkg
QkQmuPGG86CKQX0UtRC8KYaLwyTvDlIoCFJJT1Iw0y88Szp6Ijs=
=NEK4
-----END PGP SIGNATURE-----

--Sig_/79gjsROfYYqfaMMMG9hO6W0--
