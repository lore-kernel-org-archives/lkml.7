Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BD524679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BAnyBqYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLPDtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:49:45 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfLPDtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:49:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47bnMp6YNBz9sNH;
        Mon, 16 Dec 2019 14:49:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576468182;
        bh=sGY2O5X36neo/pFKW9IY4SqpPcrhzO+xMhavweaplXs=;
        h=Date:From:To:Cc:Subject:From;
        b=BAnyBqYl/Zc2/w5BibKGylYV7tjX0Nfhe5lQ3YfKqEaehrhPinDzdC98s4OWMfjqg
         3D8tdchKogVMBZp23RIr0qE5Fn5W6yXiNBO5Nq3bCR/7+w8qzm7feSb3lWnyd9goHV
         IuKbxHLZTIRFmy8AzJjAPWFdWI/s1aWakTPj3JSFvCBm2UN3CdxVCl3lf/cfUf86/Y
         4w8JYuLp2DW8SveWwlUqzoTnXpUUyicGUq8Wep3HXoXwD2do9O4f1lLeIf8BPtBDEM
         x1wmCDApAHZXNyllNC6MLDyn04VoEexs2fjCUcyrDix4Dy7eYmCSFLPx/0VPHVea6G
         MBPSSeku1rTpQ==
Date:   Mon, 16 Dec 2019 14:49:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the vhost tree
Message-ID: <20191216144940.014b2aa7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DgP2aYm5g_4k1KpVKlxNJKD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DgP2aYm5g_4k1KpVKlxNJKD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

In file included from include/linux/list.h:9,
                 from include/linux/preempt.h:11,
                 from include/linux/spinlock.h:51,
                 from include/linux/seqlock.h:36,
                 from include/linux/time.h:6,
                 from include/linux/stat.h:19,
                 from include/linux/fcntl.h:5,
                 from include/linux/eventfd.h:12,
                 from drivers/vhost/vhost.c:13:
drivers/vhost/vhost.c: In function 'vhost_log_write':
include/linux/kernel.h:844:29: warning: comparison of distinct pointer type=
s lacks a cast
  844 |   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
      |                             ^~
include/linux/kernel.h:858:4: note: in expansion of macro '__typecheck'
  858 |   (__typecheck(x, y) && __no_side_effects(x, y))
      |    ^~~~~~~~~~~
include/linux/kernel.h:868:24: note: in expansion of macro '__safe_cmp'
  868 |  __builtin_choose_expr(__safe_cmp(x, y), \
      |                        ^~~~~~~~~~
include/linux/kernel.h:877:19: note: in expansion of macro '__careful_cmp'
  877 | #define min(x, y) __careful_cmp(x, y, <)
      |                   ^~~~~~~~~~~~~
drivers/vhost/vhost.c:1968:11: note: in expansion of macro 'min'
 1968 |   u64 l =3D min(log[i].len, len);
      |           ^~~

Introduced by commit

  b072ae74df17 ("vhost: use vhost_desc instead of vhost_log")

vhost_log::len was u64 and vhost_desc::len is u32 and len is u64.

--=20
Cheers,
Stephen Rothwell

--Sig_/DgP2aYm5g_4k1KpVKlxNJKD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl32/tQACgkQAVBC80lX
0GzSTgf/fv3oiHyqKm8C+KlTzVdPvKLVelaoOXntLLd7iCskm/bWaoad244zCsh1
A34x01gnoasKR2Avl+0Yzk1+CAQPUD+zJzEzx/fUTecOSRssol5LMCiIauYpPeUV
80miYjRdw8Cr+Mpe9zDVnDWBt8iO+07ih15YeVwJGTrKLn85lFP9XkgkPDlFchek
WPEINaTQTQc/AJMVENiTgNIYR3nildCowWWb5+F/utF6FZBq4iQMc8e1E4E0U9he
t3l/ztP050bY08+8zZVYLROIC4lCZN+Q/vhLpQD5YPB/aImiFWSKgnMHsA6MPP6e
9izjmwsTZhfuVkS5Lm+ZTtW9xOJdBQ==
=lTry
-----END PGP SIGNATURE-----

--Sig_/DgP2aYm5g_4k1KpVKlxNJKD--
