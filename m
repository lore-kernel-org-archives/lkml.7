Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157CCC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EED2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfFSQY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:24:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39083 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFSQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:24:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B2F5C804A3; Wed, 19 Jun 2019 18:24:45 +0200 (CEST)
Date:   Wed, 19 Jun 2019 18:24:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, security@kernel.org,
        linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
        marcel@holtmann.org
Subject: (Small) bias in generation of random passkeys for pairing
Message-ID: <20190619162456.GA9096@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's a (small) bias in passkey generation in bluetooth:

                get_random_bytes(&passkey, sizeof(passkey));
 		passkey %=3D 1000000;
		put_unaligned_le32(passkey, smp->tk);

(there are at least two places doing this).

All passkeys are not of same probability, passkey "000000" is more
probable than "999999", but difference is small.

Do we care?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0KYdgACgkQMOfwapXb+vIpbACdESrG2uX8VrOmg0/hD77A6bpQ
75YAniV2BHuvjLcaxwks3pCJVyNcOrjC
=9pXo
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
