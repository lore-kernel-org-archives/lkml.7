Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C58BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EA920820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R2EpiSMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDJXT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:19:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46717 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDJXT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:19:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44fg9Q2xhPz9s47;
        Thu, 11 Apr 2019 09:19:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554938394;
        bh=nDkKOK0ZJNJ7ZVVKjy34CJr2+9yk4eMTkzrZgvw/JE4=;
        h=Date:From:To:Cc:Subject:From;
        b=R2EpiSMRTWhj3q0UdIUAj+MSGJOQHtCOCNXQ7IK4dY0Tm7AZbg2va7cDtbMEgDZnq
         MIQJoPKslr2CeyoXkGIri7G4i7K+pm0CKkVzp+/RpR/H4tamEI5HlL6mYyCPISX3a3
         wq4CKqB8A/W1Yxeus9m3/0bfU4Z0UP/b0aTnT6i1UbUWBpwW0Kw1K1ArnudzQyB/UN
         TqdjdL6F7epufxdYDMEnYx8LOC7piRgVfKF5a361FlA90fxhENJlnKn++t5WLSuK2j
         KxSrl8IIWzA22ZbXNUPJ4vz77iGYrSOc4TC7RknRdT0KtjAFQwMImk6OfP+qcgrQ74
         572Cm06lw6CbQ==
Date:   Thu, 11 Apr 2019 09:19:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Brandenburg <martin@omnibond.com>
Subject: linux-next: build failure after merge of the orangefs tree
Message-ID: <20190411091947.741fa90d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TD_ROFwRk9Q9Bq8gyuRi6Mj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TD_ROFwRk9Q9Bq8gyuRi6Mj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

After merging the orangefs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/home/sfr/next/next/fs/orangefs/file.c:438:18: error: initialization of 'vm=
_fault_t (*)(struct vm_fault *)' {aka 'unsigned int (*)(struct vm_fault *)'=
} from incompatible pointer type 'int (*)(struct vm_fault *)' [-Werror=3Din=
compatible-pointer-types]
  .page_mkwrite =3D orangefs_page_mkwrite,
                  ^~~~~~~~~~~~~~~~~~~~~

Caused by commit

  c32607e8fc3b ("orangefs: write range tracking")

I have used the orangefs tree from next-20190410 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/TD_ROFwRk9Q9Bq8gyuRi6Mj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyuehMACgkQAVBC80lX
0Gz2dwf/Wh3cZVr6xtLK9sa9G+qy2Tv/uh+KrApbAHRN6CNRJ586lKdMKYfPkkNF
g7vog9xDKOWmGLoLJJ1DZUdleTuf+6QsolBkGJhW+p8/1eeii/+cVnmmwNR9vFJn
rqigYe0aWvxR85A4GqdEqtEMxW1r/QDw0rTdkpGb0mN8mhHAbxQtnBiB/32Ty1S5
GicRROqzafGcgOlt6FVtOOt8kGBRr9bqC9zO1AXR3eZrZj+xMbw38aw2jlZ5BEJB
9uZHS5k2zxiflx53ce3+iF1VmWT2+1ElX4vT9sEw+NYCw3aX1cmWJqm2BJT4/E5q
lfTaxeYP3ZZsJhJ11i+fr6jqgSlP5g==
=snbl
-----END PGP SIGNATURE-----

--Sig_/TD_ROFwRk9Q9Bq8gyuRi6Mj--
