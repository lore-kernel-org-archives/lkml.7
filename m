Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA3C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0133B2072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tRIIzx9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgAFXXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:23:12 -0500
Received: from ozlabs.org ([203.11.71.1]:39233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgAFXXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:23:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47sBQ51trzz9sNH;
        Tue,  7 Jan 2020 10:23:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578352989;
        bh=iRoTQMD5mCvcOCd5jnHIkFA5apf7bDAYlWymXM1ohGY=;
        h=Date:From:To:Cc:Subject:From;
        b=tRIIzx9X2bp7NGPyFw1iotj39nDe2CIcCZ2m/sH+Jye5z9DRWbGQXS3RQk4TtBeDH
         Nb0wS7675e7oBxDUeni25eAAO4ZXHCjMkKIguP5nzY9n3AYAi2W/7XYm8FHPKBbiz0
         fkOUUscZWK7MqVF6W7fzxc8WoeEPkYk1o1k7rkDmaFkjV4BdTf3VYHuE3YWx9fjkOL
         iHTFJvbqc4S6mxDUrTYO1dRDqLsM6gvSmwQVXRGOlaFUQztkBm/TYFjySRCuIFcgZj
         f5fFYKaoeXLLVxLszRgLP6VbPlDu/Jdjod4VESsGol+U5xWcXhdLlnLWxyH2u+1dqe
         Pa4S9ZxYINYcg==
Date:   Tue, 7 Jan 2020 10:23:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: build warning after merge of the iomap tree
Message-ID: <20200107102308.3d89af44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VJZ9N8t7Rf9AdN.Ze56I1FB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VJZ9N8t7Rf9AdN.Ze56I1FB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iomap tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

fs/ext4/inode.c: In function 'ext4_page_mkwrite':
fs/ext4/inode.c:5910:24: warning: unused variable 'mapping' [-Wunused-varia=
ble]
 5910 |  struct address_space *mapping =3D inode->i_mapping;
      |                        ^~~~~~~

Introduced by commit

  4a58d8158f6d ("fs: Fix page_mkwrite off-by-one errors")

--=20
Cheers,
Stephen Rothwell

--Sig_/VJZ9N8t7Rf9AdN.Ze56I1FB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4TwVwACgkQAVBC80lX
0Gy7zgf+LLRf9j3cLHoEDCSvs00cbQ4qU0YycT05WBmzp63qQAsonRLH1ToPLsGy
11inp5z8q2++/ex56b7tn56dKuLxK92CXE9K5HgdeiT1G3Qf04POeC+DitKe/IkU
FC130lOio37Sv7EUrJmZ8aqLPXmNz28py3/WXD8FF7PwqY6N11tITFpYlRGRxHdw
olUTnUoIKnt5vuPEagR1V/7mpc9EG4wcOM9RR6aa5BC2i+Dc7HFgfxvhY9GAoG0V
BJCwXkNDftdFzW5od0aqFMQAVTSG49YbzZYS8RxzWK+cR2uFRJ9gqXefQm8MoWiz
S1kO2xveNquOouVCq7JA2UR3tn6yOw==
=kfCb
-----END PGP SIGNATURE-----

--Sig_/VJZ9N8t7Rf9AdN.Ze56I1FB--
