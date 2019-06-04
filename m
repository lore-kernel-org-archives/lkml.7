Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2B02075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfFDSAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:00:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53546 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbfFDSAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:00:46 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hYDjk-0007Nn-0w; Tue, 04 Jun 2019 19:00:41 +0100
Date:   Tue, 4 Jun 2019 19:00:39 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Gen Zhang <blackgod016574@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <20190604180039.gai2phwdxn7ias6n@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ti6drzhvh3soblcf"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] Revert "consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c"
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ti6drzhvh3soblcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This reverts commit 84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac.

con_insert_unipair() is working with a sparse 3-dimensional array:

- p->uni_pgdir[] is the top layer
- p1 points to a middle layer
- p2 points to a bottom layer

If it needs to allocate a new middle layer, and then fails to allocate
a new bottom layer, it would previously free only p2, and now it frees
both p1 and p2.  But since the new middle layer was already registered
in the top layer, it was not leaked.

However, if it looks up an *existing* middle layer and then fails to
allocate a bottom layer, it now frees both p1 and p2 but does *not*
free any other bottom layers under p1.  So it *introduces* a memory
leak.

The error path also cleared the wrong index in p->uni_pgdir[],
introducing a use-after-free.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/vt/consolemap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 79fcc96cc7c0..b28aa0d289f8 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -489,11 +489,7 @@ con_insert_unipair(struct uni_pagedir *p, u_short unic=
ode, u_short fontpos)
 	p2 =3D p1[n =3D (unicode >> 6) & 0x1f];
 	if (!p2) {
 		p2 =3D p1[n] =3D kmalloc_array(64, sizeof(u16), GFP_KERNEL);
-		if (!p2) {
-			kfree(p1);
-			p->uni_pgdir[n] =3D NULL;
-			return -ENOMEM;
-		}
+		if (!p2) return -ENOMEM;
 		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) =
*/
 	}
=20

--ti6drzhvh3soblcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlz2scEACgkQ57/I7JWG
EQnwLg//W6+PZHw+ewkg7a4f9GxIRXbEoN/ZsHbj4EY8ue8hJUL7gGnK3R7Pbtos
ncI0BLEHbPzOU3nRwGz04vFQ4k4Mkj9qqLNozggY8078EEgqxrRmfOJigr4fnDYw
Yr5I2Lk6O7zUffEVURUM/qO7rO36/NaW/c6EhZC8OltcSr5marLXizOPKOW5ocLD
VYp5CCoi4/YX/Ya424jfilSml288dVrmzPaU5Fqcn6E+J9cUZMEIaSon1+/Ti6Qp
xcVqhkMcP2VSTaBZCTe1xBsozdgEmdNMC8Y9ozFc2t+bCj9Qg3M/KKllHGSeX5tW
skZkpfdqmvghVG5FRbzAbGdwMKQNWdm5ns64yrdDx016Y9NM4khg8JGCOTcW/dn7
69oZYYpd0Poo0zK5ZBuXZOxXA2qkRN8faifyZhQZ2KTPHvXt+D9GX7nCp1/SjbH0
LwB8U4ESlbmoKktYf33VmzRbG0jfzoy3GySrH/rAvJrWJ9EVO2qW1Qk1PK4nv/R8
16x7YVsZx7XS756lITjcoj38tlBgwOXbk5bxNfIaXy2erXhuUinZG95tqrrw/iRy
5BwFveu6Np2icDwDULV1OtD3D+mr4TrCLu9zwg51uYeNeXVAj4TUd0XRnVP39jhA
gDWVzbBZ1jDLn4XXuhk5+1wX6oVhRM6uUSXpy5EwK/9Ml3GpEGs=
=Owvk
-----END PGP SIGNATURE-----

--ti6drzhvh3soblcf--
