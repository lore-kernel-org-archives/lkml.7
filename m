Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09400C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 22:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FF02075E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 22:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QecYlWWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEAWqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 18:46:34 -0400
Received: from ozlabs.org ([203.11.71.1]:35271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfEAWqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vYRC2NbNz9s7T;
        Thu,  2 May 2019 08:46:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556750791;
        bh=fBGEAfXaHVB+dhd3quAdwiRutAFSqo0yMmTMEyNlnGE=;
        h=Date:From:To:Cc:Subject:From;
        b=QecYlWWXzzBBQdICUao7ForAFmhkQNx9D6SGliHR2hSqCJgw5VkNAd3JB4tKedQsp
         x5R5JgKLbST6pnZvqssUf4MlTCnd3QVuFMzr/ZdWPj8mndg795xuWyyPDTDue60BfA
         DtEN90vFKp8kO2W1xCUYCLk2tMh6Ceqw8L/nqqvkBTlpBZtpOIXAxn3kJlmIbrWDXN
         d3tM16lPctIdhB4ANSXkDZwnTFlS+anpyMFiJ+xuse+bOgLJ+5aZmj9IZ+0iKMOGvS
         n5jfmPGQ026BrMg0dqvwEwIYcVC5wAI6my/gTpzY1Wjtq42vf83iyDyqIKjT1I1x1Y
         19jdRdhUlVFNw==
Date:   Thu, 2 May 2019 08:46:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the kbuild tree with Linus' tree
Message-ID: <20190502084626.108fb691@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aMI74E1W0Jhnl1fNB2aKUWK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aMI74E1W0Jhnl1fNB2aKUWK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kbuild tree got a conflict in:

  Makefile

between commit:

  6f303d60534c ("gcc-9: silence 'address-of-packed-member' warning")

from Linus' tree and commit:

  c21e4135d629 ("kbuild: re-enable int-in-bool-context warning")

from the kbuild tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Makefile
index 633d1196bf00,8b3b62f18c9a..000000000000
--- a/Makefile
+++ b/Makefile
@@@ -677,8 -691,6 +691,7 @@@ KBUILD_CFLAGS	+=3D $(call cc-option,-fno-
  KBUILD_CFLAGS	+=3D $(call cc-disable-warning,frame-address,)
  KBUILD_CFLAGS	+=3D $(call cc-disable-warning, format-truncation)
  KBUILD_CFLAGS	+=3D $(call cc-disable-warning, format-overflow)
- KBUILD_CFLAGS	+=3D $(call cc-disable-warning, int-in-bool-context)
 +KBUILD_CFLAGS	+=3D $(call cc-disable-warning, address-of-packed-member)
 =20
  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
  KBUILD_CFLAGS	+=3D -Os

--Sig_/aMI74E1W0Jhnl1fNB2aKUWK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKIcIACgkQAVBC80lX
0GyDWAgAhG9OF5Y3gtnD7UV5wo5EDp/2Pm306QK2UP3L7SZO9UetGPCvMPwcTrki
jGOX6ihfLZaVZLXSqhnXWXKE1jWGH4c4oCyMgTGDlAAUnjGtThHVD5FOQr98sSqe
QChsJkhwY0SMWfkzt42h00xghIzYJUzBS0ayJxdKva/hn5kpF1LEGPgJwXeiNOtb
PTGGAxaXsGln0ndP8pYTHqGzBnM0exk0Dt62Dx3Zm072kXUwJiK7lUvYNLYuwdyf
5ceG781YTOnTcYN9d4jk1PQLQvjPkv3WkLAUMbgKMxjBSjvZ5vZsEyPai0mrmRFr
rPdhBYmT0XLOiHWN7LwtCXKNrJ1Npg==
=on7B
-----END PGP SIGNATURE-----

--Sig_/aMI74E1W0Jhnl1fNB2aKUWK--
