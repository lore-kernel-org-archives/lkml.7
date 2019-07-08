Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF3FC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABFC20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cuiqTSHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfGHDD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:03:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbfGHDDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:03:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hqzC6mT5z9sNF;
        Mon,  8 Jul 2019 13:03:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562555032;
        bh=kzaW4wYJTEYFrOqTKjRKd+T9uIcp5lMpH2cp+bHLSn0=;
        h=Date:From:To:Cc:Subject:From;
        b=cuiqTSHtPIxSyFRQIbQsSAb4hTRRavWAaSBWNz3gSz8WuE5gTX8+ZwFMMlpEXexk+
         e/MdSzkcpnviQj/i0kXlc+KQKHje2JW0kfa+PShFt0gupDISYkOn62eEmfWrUzatsv
         sIe+ighO98GNTYxtDuDIs6wg7dnmyrR9dTNqtgLoNLjoIvoLRA5MDocn/ZPztO1V3Z
         ljkt6Kpm86f4ACkM8EKBr8NBCv0xa2T9AKcTWE73z6zmNk6x3YmCsUdB5htkWmc8lw
         Qi+897ssAtoKvDihbaTuLBhjCSY5ANEC/MP+5aFNSsQvlNEayJKDwK/V7EPXsMRwlT
         W1yXwj5QTZ7pg==
Date:   Mon, 8 Jul 2019 13:03:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: linux-next: build failure after merge of the rdma tree
Message-ID: <20190708130351.2141a39b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kA.hB=1qdLs1zSTZSdnbIXv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kA.hB=1qdLs1zSTZSdnbIXv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/asm-generic/percpu.h:7,
                 from arch/x86/include/asm/percpu.h:544,
                 from arch/x86/include/asm/preempt.h:6,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:51,
                 from include/linux/seqlock.h:36,
                 from include/linux/time.h:6,
                 from include/linux/ktime.h:24,
                 from include/linux/timer.h:6,
                 from include/linux/netdevice.h:24,
                 from drivers/infiniband/sw/siw/siw_main.c:8:
include/linux/percpu-defs.h:92:33: warning: '__pcpu_unique_use_cnt' initial=
ized and declared 'extern'
  extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;  \
                                 ^~~~~~~~~~~~~~
include/linux/percpu-defs.h:115:2: note: in expansion of macro 'DEFINE_PER_=
CPU_SECTION'
  DEFINE_PER_CPU_SECTION(type, name, "")
  ^~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro 'DE=
FINE_PER_CPU'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
        ^~~~~~~~~~~~~~
include/linux/percpu-defs.h:93:26: error: redefinition of '__pcpu_unique_us=
e_cnt'
  __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;   \
                          ^~~~~~~~~~~~~~
include/linux/percpu-defs.h:115:2: note: in expansion of macro 'DEFINE_PER_=
CPU_SECTION'
  DEFINE_PER_CPU_SECTION(type, name, "")
  ^~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro 'DE=
FINE_PER_CPU'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
        ^~~~~~~~~~~~~~
include/linux/percpu-defs.h:92:33: note: previous definition of '__pcpu_uni=
que_use_cnt' was here
  extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;  \
                                 ^~~~~~~~~~~~~~
include/linux/percpu-defs.h:115:2: note: in expansion of macro 'DEFINE_PER_=
CPU_SECTION'
  DEFINE_PER_CPU_SECTION(type, name, "")
  ^~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro 'DE=
FINE_PER_CPU'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
        ^~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_main.c:129:33: warning: 'use_cnt' initialized=
 and declared 'extern'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
                                 ^~~~~~~
include/linux/percpu-defs.h:94:44: note: in definition of macro 'DEFINE_PER=
_CPU_SECTION'
  extern __PCPU_ATTRS(sec) __typeof__(type) name;   \
                                            ^~~~
drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro 'DE=
FINE_PER_CPU'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
        ^~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_main.c:129:33: error: redefinition of 'use_cn=
t'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
                                 ^~~~~~~
include/linux/percpu-defs.h:95:44: note: in definition of macro 'DEFINE_PER=
_CPU_SECTION'
  __PCPU_ATTRS(sec) __weak __typeof__(type) name
                                            ^~~~
drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro 'DE=
FINE_PER_CPU'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
        ^~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_main.c:129:33: note: previous definition of '=
use_cnt' was here
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
                                 ^~~~~~~
include/linux/percpu-defs.h:94:44: note: in definition of macro 'DEFINE_PER=
_CPU_SECTION'
  extern __PCPU_ATTRS(sec) __typeof__(type) name;   \
                                            ^~~~
drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of macro 'DE=
FINE_PER_CPU'
 static DEFINE_PER_CPU(atomic_t, use_cnt =3D ATOMIC_INIT(0));
        ^~~~~~~~~~~~~~

Caused by commit

  bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")

I have used the rdma tree from 20190628 again today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kA.hB=1qdLs1zSTZSdnbIXv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ispcACgkQAVBC80lX
0Gw0cAgAkKRy9OxJPfFu0rHajKiGMPyuq+s1F8tFQU/e+EGZF0V4uee9OMtdvo3S
EvhOAjnSiK4KjhaUomqXAozjbKfA+ltfM/NRfdM7UpXToG9KXTa3Q+05xlcEuVeK
zKSjh6kouMuv4p+W+IBls6YaSnWTpdFLN9v5+FjpcCFGNZa8gLD7GHmEckTc3a0D
rFUm+ht43wWWjPJN4/9g/bMTzfWwY40mT/BR7fvpBZKai5t3amfMDF6y2EqVZQv7
l7cl+NntiNqI7zkUnDsxIfUUNo7Tc6WEsH6CmD7w62KDQvE97oh0Y2f57GfAjvlq
5JdnLCY+GoYcgiuIioK4BJBo7l++Gg==
=L+GM
-----END PGP SIGNATURE-----

--Sig_/kA.hB=1qdLs1zSTZSdnbIXv--
