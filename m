Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C270C606D3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4376A216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N66MPXc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGHXVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:21:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfGHXVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:21:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jLzr20mXz9sML;
        Tue,  9 Jul 2019 09:21:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562628072;
        bh=rhV1VkbbZZ9REZJVL/XyG+DliqWQyoI7D08d6+VqimM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N66MPXc2bqWiB6iWKXIxki/j5/ITYXMp06xL9G6p8Fo4RO515UXBTGh5sO2qp6z1P
         1OKEvGpy0gEe9MR6KRiuNJe9UZXtmO4uIOdbohh6tj0Qb0DRFUcjOo9wXJhxLB9R8t
         cXuME+v4iWZbH0wMvgD/0cWSc6K2giutF3Okc1JyzCvfe2zmWlqjtlkVA0OY/SaGBR
         EB3xtK18YLHVVUrbsYtjabXrMbyEf/UyERn5jy+O0mIfPXacAtb21xDJKsDat/cqeO
         8z2hoDrV+cx9gr9UHDCJBpBFdII2pN2AbmSq5AJQRb5H7W/TJaRM/czcA5v0cd09IQ
         01clUq8Vdfwrg==
Date:   Tue, 9 Jul 2019 09:21:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@snapgear.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 m68knommu tree
Message-ID: <20190709092111.2945cb33@canb.auug.org.au>
In-Reply-To: <20190614190606.559dc8dc@canb.auug.org.au>
References: <20190614190606.559dc8dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4SeA6DlhJNfdXbuDb=jOtwa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4SeA6DlhJNfdXbuDb=jOtwa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 14 Jun 2019 19:06:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   fs/binfmt_flat.c
>=20
> between commit:
>=20
>   6071ecd874ac ("binfmt_flat: add endianess annotations")
>=20
> from the m68knommu tree and commit:
>=20
>   db543c385059 ("fs/binfmt_flat.c: remove set but not used variable 'inod=
e'")
>=20
> from the akpm-current tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/binfmt_flat.c
> index 80d902fb46e3,7562d6aefbe4..000000000000
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@@ -429,9 -415,7 +429,8 @@@ static int load_flat_file(struct linux_
>   	unsigned long textpos, datapos, realdatastart;
>   	u32 text_len, data_len, bss_len, stack_len, full_data, flags;
>   	unsigned long len, memp, memp_size, extra, rlim;
>  -	u32 __user *reloc, *rp;
>  +	__be32 __user *reloc;
>  +	u32 __user *rp;
> - 	struct inode *inode;
>   	int i, rev, relocs;
>   	loff_t fpos;
>   	unsigned long start_code, end_code;

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/4SeA6DlhJNfdXbuDb=jOtwa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jz+cACgkQAVBC80lX
0GxO5QgAlxdqNGmXJToiL1oRKfokmNyoqu/Yj4LxK5ZGoXlAnjtB+I00z9LeVpIe
dVnSG/v5ltOQmmtFwc2Qinb2vGKaATUsd5BXuisdUdZq3mkTMIW2zTcglU+6+0O1
BrnRpmE7ZXPUy5J2PSYrGZ8J9xHuewuI9G/+OHle5Rt+FmNpwJBG6Qtpa0znOG8M
28iFuj/UtFPc3Go8AZflmAE7bt+Gyq5Npv0anh0J4Q4lcDfb4vJe2h0scKk0oiUs
YCJkp6lqS2uZ5UJNXVAjMmYfhcnUesdFwe5RbyYJn4Om/aMTg5fnPDTk8Bcyhd32
kqUPewzWtCpcG1kX6jz0FQCdrot0Sw==
=B7mD
-----END PGP SIGNATURE-----

--Sig_/4SeA6DlhJNfdXbuDb=jOtwa--
