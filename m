Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE67C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B78218BB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tAwnOtEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfGEItz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:49:55 -0400
Received: from ozlabs.org ([203.11.71.1]:45599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfGEIty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:49:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45g7nq3Vpwz9sNf;
        Fri,  5 Jul 2019 18:49:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562316591;
        bh=nyRwtSwtERYZCc5hikUskoW0XV1gf6SCs+FLYgI/+vc=;
        h=Date:From:To:Cc:Subject:From;
        b=tAwnOtEUsWgdr1s4V3AICsAq9kW8dVi3vmmnMYYR4bSNAL3LhftMzPCiPfHcervwx
         vtBt4P1osnxi6IUrxP+Wdh4SfFhhhcI0Kci136NuYcL3P65OvbBVyb3ld57D74Oaa4
         2VnOdsFcGgt5Fk30HBvwRQj1tOYc4KbSm4oGBq/4m+T5X5CKNS9vE971yfUh6VPjPm
         AvWhiYJw/1YJcpX3HXuOVSe4TYg1erjO9TNG0n8J0AbwiIeZpqPW/gwiAOYg8o1f0o
         27YtTn8RMYSjlMwygMoMgzRiF6XJs1C5fqq5IDseO6dj94QyqH97tWeufeVZz8G1lO
         J6qmo+CdJLwOw==
Date:   Fri, 5 Jul 2019 18:49:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190705184949.13cdd021@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jEO0gQpIYlIpR9SaOyN4f3t"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jEO0gQpIYlIpR9SaOyN4f3t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/compiler.h:257,
                 from arch/arm/kernel/asm-offsets.c:10:
include/linux/kasan-checks.h:14:15: error: unknown type name 'bool'
 static inline bool __kasan_check_read(const volatile void *p, unsigned int=
 size)
               ^~~~
include/linux/kasan-checks.h:18:15: error: unknown type name 'bool'
 static inline bool __kasan_check_write(const volatile void *p, unsigned in=
t size)
               ^~~~
include/linux/kasan-checks.h:38:15: error: unknown type name 'bool'
 static inline bool kasan_check_read(const volatile void *p, unsigned int s=
ize)
               ^~~~
include/linux/kasan-checks.h:42:15: error: unknown type name 'bool'
 static inline bool kasan_check_write(const volatile void *p, unsigned int =
size)
               ^~~~

Caused by commit

  4bb170e54bbd ("mm/kasan: change kasan_check_{read,write} to return boolea=
n")

I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 5 Jul 2019 18:44:55 +1000
Subject: [PATCH] mm/kasan: include types.h for "bool"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/kasan-checks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index 2c7f0b6307b2..53cbf0ae14b5 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_KASAN_CHECKS_H
 #define _LINUX_KASAN_CHECKS_H
=20
+#include <linux/types.h>
+
 /*
  * __kasan_check_*: Always available when KASAN is enabled. This may be us=
ed
  * even in compilation units that selectively disable KASAN, but must use =
KASAN
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/jEO0gQpIYlIpR9SaOyN4f3t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0fDy0ACgkQAVBC80lX
0GzPVwgAje5eBZwEcQrJp3Vh6/qbD6QqBGH2G/4W830DDYlfqEg7wjejai+AREKL
aNmqilJpVU0ND4lIIINrN/WjCdmr29ZUYdUMokAJkkuvTwbgiu+Z74JflGQfPk0Z
O3uJq/+pJyojI8vXewKSSJzHjrpcbEEcky+siblDCUvOyowYTl1lW4AlR3co0Fny
Umy2QWwBa4xYZnRJM5MaOaDkh8KEDGtM++31Sk9B8SyrhRh7pAOhbeNDvelpZKbI
qD54crO6lz2QDTSqwJgAMwxMSuOFVO7d1Jprw2tbTEd01jaMIKo62JZN43M6IoDl
sFros5+uIBXfaUI1Y8Ozwp2kVVktRA==
=l2qj
-----END PGP SIGNATURE-----

--Sig_/jEO0gQpIYlIpR9SaOyN4f3t--
