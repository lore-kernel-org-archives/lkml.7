Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B9C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C632A20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S7Dzbxks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfDQCba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:31:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfDQCba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:31:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kR7g2NRRz9s4Y;
        Wed, 17 Apr 2019 12:31:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555468287;
        bh=N6XJvE2sPWEMulBEn20x1fhchncL4AtWlBYLBmK6A3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=S7DzbxksWt1kV7mNva13j1fKaqDkkd+J+kp5tNNK9V2b3XS8+iS17jMcuXcKgkymV
         QpJAadXZ6f5rEedi8euGDP9gNRyo8A4S92acjPvsaGQEvZnjFGRw6/Rvmn+YQljB5G
         a1brclnI4lEXTi3P/1Ss2KMZvQuzGWmQf96rdlmfY+hzu9FHuoJnuJYcXehd3i57Fi
         HaIFWxA/sW8pNkTyh9DHIIEJjeVJFVOm9SkKLrMwOFC8E87LDa79/ISu8y36GUhhoY
         aWtsrPD1oIwMbeqP0oxh3K9m7qAg97B/wtbmFiXyvDG1+5oyYxopTQz/w0Buu5EKux
         hbXq4hnUOmv4Q==
Date:   Wed, 17 Apr 2019 12:31:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chao Yu <yuchao0@huawei.com>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20190417123125.3de22f73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mNdL3ruxYKIGVZtrZ5ARkKw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mNdL3ruxYKIGVZtrZ5ARkKw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

fs/f2fs/node.c: In function 'f2fs_remove_inode_page':
fs/f2fs/node.c:1193:47: warning: format '%zu' expects argument of type 'siz=
e_t', but argument 5 has type 'blkcnt_t' {aka 'long long unsigned int'} [-W=
format=3D]
    "Inconsistent i_blocks, ino:%lu, iblocks:%zu",
                                             ~~^
                                             %llu
    inode->i_ino, inode->i_blocks);
                  ~~~~~~~~~~~~~~~              =20

Introduced by commit

  90ae238d9dac ("f2fs: fix to avoid panic in f2fs_remove_inode_page()")

from the f2fs tree interacting with commit

  72deb455b5ec ("block: remove CONFIG_LBDAF")

--=20
Cheers,
Stephen Rothwell

--Sig_/mNdL3ruxYKIGVZtrZ5ARkKw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly2j/0ACgkQAVBC80lX
0GzDiwf/d9CUHjUAyzzDO9kDZdrbLqFE3thRc+3V4nrx1ZPK9YGjsQ4PQB6hhh7v
pHdnVHq8V07WIYzPLvM/AW9MTwBhSQ+R5jpMfc7jIO3s2wACVjSrM2qofaZJqx89
jXOEhPlQiRbDvYcgRvPpDACafFSeGe7gpB7e53pXPRdzlykIY0PYz/76J/87xVZd
rrfz4fZ1PhYF8hODUIxll0BxiNQCdwO6v1ZJIf02Eb2E+C5Yft6t72Ro0sMaQtRg
nP/3dMp41Yn+yiWhUn44RieVSpSwHPxOM0tUTMA6Q41jfnm+Iah+1+fbmvnRWgOs
ZsaFjpACo22wyCovrk568/qk3Wma6g==
=v9pi
-----END PGP SIGNATURE-----

--Sig_/mNdL3ruxYKIGVZtrZ5ARkKw--
