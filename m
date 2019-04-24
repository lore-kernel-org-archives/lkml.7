Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8653C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B212089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ixWlRqFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfDXFKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:10:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58297 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbfDXFKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:10:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ppL52k2sz9s6w;
        Wed, 24 Apr 2019 15:10:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556082638;
        bh=kSPMn1crfBknvu1HWN7CZ6K116S69it87DcabL9Lpqc=;
        h=Date:From:To:Cc:Subject:From;
        b=ixWlRqFz7WcrAjSXkSrqHUlGhEweJTImTtuvg0L37htQL6rfbqqOWAqPk5MAWSteB
         zmIYHFDymAW2bTRJFFO6CHxv/1LoxGqUo1fZKdSm9j/0Xr3TjElmgHDjU2bghacNaq
         IIU9FhVHsoJkNmav+EuzJm52LCivXoit7VsP0nd/TrWCjGMjMzd5WhxelozzLed7kR
         h5fzRdjRaVBG3DL1nhEIwd2ghJlaWfan1cKdQbR48t4ZF069cq8cRD5RM3a9VFzpSm
         L8KEAjA8tk8nDLzDcsMk+7KftLGMzqsGpLlWihz3vYf99NV6G88I3Huptja2PAw6jP
         a6/FOI8k5dPeA==
Date:   Wed, 24 Apr 2019 15:10:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the tip tree with the asm-generic tree
Message-ID: <20190424151036.260a58f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZjJN/=kO2oLlAR.mBqf/4j4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZjJN/=kO2oLlAR.mBqf/4j4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/arm64/include/asm/Kbuild

between commit:

  c67fdc1f00cb ("arch: mostly remove <asm/segment.h>")

from the asm-generic tree and commit:

  46ad0840b158 ("locking/rwsem: Remove arch specific rwsem files")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/Kbuild
index afd8a3740b18,60a933b07001..000000000000
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@@ -17,7 -16,7 +17,6 @@@ generic-y +=3D mmiowb.
  generic-y +=3D msi.h
  generic-y +=3D qrwlock.h
  generic-y +=3D qspinlock.h
- generic-y +=3D rwsem.h
 -generic-y +=3D segment.h
  generic-y +=3D serial.h
  generic-y +=3D set_memory.h
  generic-y +=3D sizes.h

--Sig_/ZjJN/=kO2oLlAR.mBqf/4j4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/78wACgkQAVBC80lX
0Gzkggf+MQGgwftVnnKAFwlcWHA2BxguCtawsm2gvUObDrGdRJmezE/hv57tctue
pFirI/XApa6x0dSBq1WS5Jq4uMjKzuQcKAEClRtkXXZ4sqc/q09d1ohqgCA9c1ty
80P36Mfn3sUiIMbT/wXGjAJxwwTnqWVL4QCQRKcPaaUt2ILdNeNfwD+PwC1phkf0
eWOeMKDnBWed5EqVttJbs5NTehB9S5NakXg3u5+3r59frkUdYY7JyymG1MVqd67C
Q0fthbPkAP/FVFNl44bw2lRnSJD6219eKSfBPYLcI0Uz2NdHPOei5JZT0voe1G3H
HDC2hSmnzrYfpwrojQVuj3XPERUG5A==
=xa6z
-----END PGP SIGNATURE-----

--Sig_/ZjJN/=kO2oLlAR.mBqf/4j4--
