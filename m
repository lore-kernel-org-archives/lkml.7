Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 12:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18592084B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 12:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfJFMPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 08:15:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45730 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfJFMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 08:15:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 626FA80463; Sun,  6 Oct 2019 14:15:31 +0200 (CEST)
Date:   Sun, 6 Oct 2019 14:15:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Kurt Roeckx <kurt@roeckx.be>, linux-kernel@vger.kernel.org
Subject: Re: Stop breaking the CSRNG
Message-ID: <20191006121545.GF24605@amd>
References: <20191002165533.GA18282@roeckx.be>
 <20191003033655.GA3226@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <20191003033655.GA3226@mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-02 23:36:55, Theodore Y. Ts'o wrote:
> On Wed, Oct 02, 2019 at 06:55:33PM +0200, Kurt Roeckx wrote:
> >=20
> > But it seems people are now thinking about breaking getrandom() too,
> > to let it return data when it's not initialized by default. Please
> > don't.
>=20
> "It's complicated"
>=20
> The problem is that whether a CRNG can be considered secure is a
> property of the entire system, including the hardware, and given the
> large number of hardware configurations which the kernel and OpenSSL
> can be used, in practice, we can't assure that getrandom(2) is
> "secure" without making certain assumptions.  For example, if we
> assume that the CPU is an x86 processor new enough to support RDRAND,
> and that RDRAND is competently implemented (e.g., it won't disappear
> after a suspend/resume) and doesn't have any backdoors implanted in
> it, then it's easy to say that getrandom() will always be secure.

Actually... if we have buggy AMD CPU with broken RDRAND, we should
still be able to get enough entropy during boot so that getrandom() is
cryptographically secure.

I don't think we get that right at the moment.

> Bottom line, we can do the best we can with each of our various
> components, but without control over the hardware that will be in use,
> or for OpenSSL, what applications are trying to call OpenSSL for, and
> when they might try to generate long-term public keys during the first
> boot, perfection is always going to be impossible to achieve.  The
> only thing we can choose is how do we handle failure.
>=20
> And Linus has laid down the law that a performance improving commit
> should never cause boot-ups to hang due to the lack of randomness.
> Given that I can't control when some application might try to call
> OpenSSL to generate a long-term public key, and OpenSSL certainly
> can't control if it gets called during early boot, if getrandom(2)
> ever boots, we can't meet Linus's demand.

You can. You can just access disk while the userpsace is blocked on
getrandom. ("find /").

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2Z2vEACgkQMOfwapXb+vKfXwCfabBwBy1NSsdYvWFokr8878nN
mtEAn0xKb8plDgbKxaqnpvotbEMhhc6b
=JIat
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
