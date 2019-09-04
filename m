Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25865C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C0B23402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hMmtYMXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfIDANh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 20:13:37 -0400
Received: from ozlabs.org ([203.11.71.1]:53439 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfIDANg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 20:13:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46NPRx71w0z9sP3;
        Wed,  4 Sep 2019 10:13:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567556014;
        bh=9sKqcVmNPYcGRbL8j5mK/risVZPS130A9GxQFjJc+2w=;
        h=Date:From:To:Cc:Subject:From;
        b=hMmtYMXzvtmigmoLB8fOijNYtv0w5+23EcHc04CBtf7WVe1yOFljK8/8JBMv0QYYK
         sj3vgnkfMV07qCWR2S11v+HEgAcxQiXVr2h7CBqCSoon2uSCqelyjObd3OHkACDdbq
         TQ4jsVE5GPT7/F6jlmtINjBcCW64T4xw64tqMJU1TM9tfUkRWLVMe6pDEom1/9R2fZ
         xRnuZE1vNZQWMPFf6lIYE8QRrqUt4SHTw39cJZK/ye9bNwlse+27i6lpiUefqlZRCF
         mqOmFYYFQRIK56R+XSEQqfLtnuJdEmzpE29jGxuYiEN9PJ8jd6qM12eYrSCoVOzryg
         N4W6fPgtzWARQ==
Date:   Wed, 4 Sep 2019 10:13:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build warnings after merge of the kbuild tree
Message-ID: <20190904101259.2687cea4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ssBCJi3mTERdd=v=ROJKrJr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ssBCJi3mTERdd=v=ROJKrJr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (powerpc
ppc64_defconfig) produced these warnings:


Presumably introduced by commit

  1267f9d3047d ("kbuild: add $(BASH) to run scripts with bash-extension")

and presumably arch/powerpc/tools/unrel_branch_check.sh (which has no
#! line) is a bash script.  Yeah, is uses '((' and '))'.

--=20
Cheers,
Stephen Rothwell

--Sig_/ssBCJi3mTERdd=v=ROJKrJr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1vAaYACgkQAVBC80lX
0GxOmAf+IJwgmJGltVlvpa0v/AYyBNUCM/OMskna4gAT92XarZeed2UfoxwB0g/l
hXnIdav7xtwj/Enz2jsOiomWSzBEAY+D2idUi2T8VMD+VVWdV5xFXFyFKL7+c0/N
lxyYAXB/oKmyhNTOPMNJk8ThSr+hBZEgDSHX//j0iJ39+wfmf098N+RbvdVCUqXc
jirj7RLWRrWA4LcUjMMPQMky3gp+CI5olpcFdVyGNKS4j+nE3BTR/DzQCGLPO31Y
2XlhVtnbDGD18/aGnc8n0qBm5wqVexi939dCcXJDGmO2l+Jyb7iUAvPFD4Tev2u+
0HyFqdbbIU5lqfTTQGgwcKlbePY3CQ==
=l4Bs
-----END PGP SIGNATURE-----

--Sig_/ssBCJi3mTERdd=v=ROJKrJr--
