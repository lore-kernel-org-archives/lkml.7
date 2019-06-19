Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7004AC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4943220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z0zS/GZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfFSKGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:06:19 -0400
Received: from ozlabs.org ([203.11.71.1]:48295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfFSKGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:06:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TLFM4FRCz9s7h;
        Wed, 19 Jun 2019 20:06:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560938776;
        bh=NQWnQbn9ruPrlyTKLaenXzcl811ZqmMgk2/3HM89J+A=;
        h=Date:From:To:Cc:Subject:From;
        b=Z0zS/GZQTWn2wiVSG1xN799YKt1XgewhSXZ+Ie8LPs8Nn3i0RVAB/PjOS4WT5JlbB
         Oz2laSae9HZqqQyfdZsE4EJZqN8kp6c6JRThrscww4H6fk+aC0DQEazaUIK0zqGIU7
         KByWoBmJ8EjaZbfgPrQ9gHmyqSRrW35gIwlgUFBWQluAB/c76d5k9Hb9takIpYoF+U
         SUmQlmh3mVIQMv0Wmy07bExOK6x89Qd+ew25F7Px5EU16qy6i9NL9Qs0/ymo1F+yKw
         46U0VpvNw8lWmBQWuD3zHoDfLFegdSJiqcTk4WG57fLaATh5EtgvMVv0KWDfyzI4Sx
         Sostm7cmXIykg==
Date:   Wed, 19 Jun 2019 20:06:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190619200608.69474286@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cS_b5m3u4YGfN21kfl4VTik"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cS_b5m3u4YGfN21kfl4VTik
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from usr/include/linux/byteorder/big_endian.hdrtest.c:1:
./usr/include/linux/byteorder/big_endian.h:6:2: error: #error "Unsupported =
endianness, check your toolchain"
 #error "Unsupported endianness, check your toolchain"
  ^~~~~

Caused by commit

  1ac94caaee11 ("byteorder: sanity check toolchain vs kernel endianness")

Presumably exposed by commit

  b91976b7c0e3 ("kbuild: compile-test UAPI headers to ensure they are self-=
contained")

from the kbuild tree.

I have reverted 1ac94caaee11 (and its following fixup) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/cS_b5m3u4YGfN21kfl4VTik
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0KCRAACgkQAVBC80lX
0GzYdwf6AmUgQCAIHGO6IoZEy11yHbgenWP6uaetHH3EWO+cWmiUV0WNwfrUYIGv
c/QRT7c66Ul1kIGyRJaXo0Pn0IgNiwBF1ioQrK9oqELjObHBfHmEv5CX/frEOOlo
Q3/iP0l7wZhPvoiRe/c/QSSOvmbKyxQKOWaqqxCKoTZgIrgsli5dpNUsybk5SPW+
wSaz1ghy2Ej01rLqwoGY+vVxuSK3AECtCZJWQm0UpbO5/gzvtkuDAPflblEZ+0xX
TU4t08sSoQP3pdby9A8NR7RVU0wiB7+nhB4ynukYoWA6k2gzyxmPzXTQlLPGd8fY
VyvEY6+dMCQ8z0L3Z2xTeiRegxODmQ==
=Gy5k
-----END PGP SIGNATURE-----

--Sig_/cS_b5m3u4YGfN21kfl4VTik--
