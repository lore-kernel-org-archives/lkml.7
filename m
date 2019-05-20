Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04D6C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8A520645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391432AbfETMkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:40:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54078 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391226AbfETMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:40:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 94E4680350; Mon, 20 May 2019 14:40:04 +0200 (CEST)
Date:   Mon, 20 May 2019 14:40:14 +0200
From:   Pavel Machek <pavel@denx.de>
To:     stable@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        gustavo@embeddedor.com, davem@davemloft.net,
        gregkh@linuxfoundation.org
Subject: net: atm: Spectre v1 fix introduced bug in bcb964012d1b in -stable
Message-ID: <20190520124014.GA5205@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


In lecd_attach, if arg is < 0, it was treated as 0. Spectre v1 fix
changed that. Bug does not exist in mainline AFAICT.

Signed-off-by: Pavel Machek <pavel@denx.de>
# for 4.19.y

diff --git a/net/atm/lec.c b/net/atm/lec.c
index ad4f829193f0..ed279cd912f4 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -731,7 +731,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 		i =3D arg;
 	if (arg >=3D MAX_LEC_ITF)
 		return -EINVAL;
-	i =3D array_index_nospec(arg, MAX_LEC_ITF);
+	i =3D array_index_nospec(i, MAX_LEC_ITF);
 	if (!dev_lec[i]) {
 		int size;
=20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzioC0ACgkQMOfwapXb+vLAjACeOlgtOzrrBAegsl6a1fZoRiIb
lXsAnRFbWxVub7cuBl8jlTjcZKhX5MRO
=MB+O
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
