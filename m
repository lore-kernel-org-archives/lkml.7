Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6DDC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6ED229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfGXKGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:06:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50059 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGXKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:06:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CAFFA8027C; Wed, 24 Jul 2019 12:06:00 +0200 (CEST)
Date:   Wed, 24 Jul 2019 12:06:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/ipv4: cleanup error condition testing
Message-ID: <20190724100611.GA7516@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Cleanup testing for error condition.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index d666756..a999451 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -331,7 +331,7 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fq=
dir, void *key)
 	prev =3D rhashtable_lookup(&fqdir->rhashtable, key, fqdir->f->rhash_param=
s);
 	if (!prev)
 		fq =3D inet_frag_create(fqdir, key, &prev);
-	if (prev && !IS_ERR(prev)) {
+	if (!IS_ERR_OR_NULL(prev)) {
 		fq =3D prev;
 		if (!refcount_inc_not_zero(&fq->refcnt))
 			fq =3D NULL;


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl04LZMACgkQMOfwapXb+vIWlACgn46wQASoE7l4RvCoKF1g5xB4
B8EAn3x2t/A3rzZo3jpNDGs8UofXVdYd
=ROMH
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
