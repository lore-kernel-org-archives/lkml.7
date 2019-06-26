Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913EFC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E84620656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p+qs/7H1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfFZLlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:41:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfFZLla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:41:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Yh1z3dz6z9s4V;
        Wed, 26 Jun 2019 21:41:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561549287;
        bh=IBXpPTnb+rrfyl0P2KOgDj8QipZVEOsj8CdQPK6S0m8=;
        h=Date:From:To:Cc:Subject:From;
        b=p+qs/7H1ZYW7llzTtYhTUQULwdDot/r8zwLJZ1HebURdz6IE7OvmlwHAPO5ekIhs1
         D9IyuYXjux8bUWEkmLDK4DboSv4n5a1xHcglxuGLhbAD3uoZ4ywOnM2QsAOFcvpuBH
         eg50sWkAjnvu/dga28Xz3E5uI3UX94wq90QCJ9lj0mujvU3kwHLNVrkznzsh3WNBEN
         UuDdwwdUMKzBWjqEmx26FCgo3TGTIMcpU1LpUiGV2js5eWAU0CJcB++5lNsSuve0yT
         d6iaCzWV9AGSVX6xgGP4Nn4CCe2ax2ke5c882X4fi5eUHXfFt9akloFNhxpkh6He/U
         88AR8DknON2mA==
Date:   Wed, 26 Jun 2019 21:41:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190626214125.6d313c15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iFLTFbXuP.37vyb5vKaNnWg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iFLTFbXuP.37vyb5vKaNnWg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: lib/ioremap.o: in function `.ioremap_huge_init':
ioremap.c:(.init.text+0x3c): undefined reference to `.arch_ioremap_p4d_supp=
orted'

Caused by commit

  749940680d0b ("mm/ioremap: probe platform for p4d huge map support")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/iFLTFbXuP.37vyb5vKaNnWg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0TWeUACgkQAVBC80lX
0Gyziwf/e5SZ7nabWCACoyK5KMUrt3REGEICPcRmc6y+Kf5D+v269S8tKPLRHE7n
aXNfIxsmEsWaVtMCMRoFV7cF/y9SUfcdULSYlVVz0jpVQRHtEf/215MtWPdgCc4S
dV7wAsvfcCQYAeOdhSy1Nn4IDbUvcnHzCwvzZIfp1ahx6yRxikAKAvdTHfxKhrsf
92eZg0leDXUXBHjdPgZR0aIFcARTVIAa/29Cy+AN/OtH1n2JGO7U9lKuKlpFcuOq
grEPx4eOWXdGLR4LrH1JnnWx0XMigrOyY8Lgshe0PTbj8Dgog5q4ARTuXmjzHgyA
pOoWN3NmamxyvHQJBSwnlT+dP58VAg==
=yTF3
-----END PGP SIGNATURE-----

--Sig_/iFLTFbXuP.37vyb5vKaNnWg--
