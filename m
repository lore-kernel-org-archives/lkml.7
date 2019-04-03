Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2A3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF8320643
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f/6HtHrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDCBWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:22:16 -0400
Received: from ozlabs.org ([203.11.71.1]:33639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfDCBWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:22:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44YpGF1Bgyz9sPS;
        Wed,  3 Apr 2019 12:22:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554254533;
        bh=+65zE1vb+Onw1K+nuoNn9MDbALOGGOB62jodR6PA5zg=;
        h=Date:From:To:Cc:Subject:From;
        b=f/6HtHrxfeP4vvqgpemfmQ7mW4bz2rPffBhNPKnmWoFYR4vnU6lp+Qw6juy8pJAE5
         wKY5aQXNQYdXwnpErzXszY9NQpyhQ8K21h3wcQ7BQzftWK+x/Tzr74pbglZ0Rn3gO1
         n6woK2F44GlJoauxToA8nLT3VsECWhqMOEP8iAy5eQ3mxl2kOouIRtG2HWnhGKUk42
         qGH3GN7OsnYKyz9xkWQ3sC6PSVfFGFSo//1++K8ek5AhTsLRmUj2g23m7MY7saISIN
         gf2KUVZZJS3YkCdep05dO4+QClY7/EK8dhUu4cMgma89XyGXldM1YhCzWAvYEFO+E1
         jSRzOaM0lF/rA==
Date:   Wed, 3 Apr 2019 12:22:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: linux-next: build failure after merge of the selinux tree
Message-ID: <20190403122212.68a9964d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.g=JCJivCxaE/shpzUYX4f2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.g=JCJivCxaE/shpzUYX4f2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

After merging the selinux tree, today's linux-next build (x86_64
allmodconfig) failed like this:

x86_64-linux-gnu-ld: security/selinux/hooks.o: in function `selinux_kernfs_=
init_security':
hooks.c:(.text+0x8f7d): undefined reference to `kernfs_xattr_get'
x86_64-linux-gnu-ld: hooks.c:(.text+0x8ff5): undefined reference to `kernfs=
_xattr_get'
x86_64-linux-gnu-ld: hooks.c:(.text+0x91b5): undefined reference to `kernfs=
_xattr_set'

Caused by commit

  1991af34fa26 ("kernfs: fix xattr name handling in LSM helpers")

I have used the selinux tree from next-20190402 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.g=JCJivCxaE/shpzUYX4f2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlykCsQACgkQAVBC80lX
0GwEVQgAlC/wjvYSDyGUYtJRZbx6sIge9cGzDmDOL8YGwXASQ61xI6erEEhOGDn5
xMI9t0LPERB3iHeZLw+FmAifrf/+Nmoh1fGImeodTw4ActpYyj0/0LgpFw4wpi9z
c+6oaldu/iL+m907tLPmFHtrounNGK/yWRXvLyVExNrCgzAyMWO9m8Rvhj/usc4w
X7YXnllZLOhXKOuFfYs31dQrT3USsfAUu08V/I3dm/J7/BUJFAud9XomcU5e89db
7B/AzJLJH8YClXBkIuyRmx4PT0fCynJaVEIXhEz9hzUd75SyGX35+yYszu5F1xHR
PaVur/L9U/ZIwDlkVrM9srFb0XD+TA==
=VreI
-----END PGP SIGNATURE-----

--Sig_/.g=JCJivCxaE/shpzUYX4f2--
