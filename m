Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E158BC468AA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B961420843
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FIIsuLYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfGEXsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 19:48:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49387 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfGEXsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 19:48:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45gWkS4YYtz9sNp;
        Sat,  6 Jul 2019 09:48:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562370497;
        bh=yn5m4IV3/kqDuT8Mhupu6WwFCYeHGVT9mYzyqZmqP+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FIIsuLYKjbmCjbq2fGexp2myAIv2EshckCQ0zp30ssFkvanZ4gmUzv4j7yOz2CewM
         N29EE7dMAv2cwQ1y8MuCGfF9M9SlBru1L//b7CQsvol+prqOz1uzTqo2cFT+8thxJK
         5asq4Aji4qyFazOb9H3shsVF/0uWI+WNEHTrctUK3PiQQFWKnYFRg4F3zepItJbhnO
         Z9M4lSOich4s14PZgtjQmQcA1WoJ+J7sv+QJSxX0gYZURlkTSvlAO0wweGOt0flQJK
         SdY4mqDKphOOcMuQLnESF8cyv2AnDmzlGYw8tur87bC8OXFNArBal94lLZ1rbSdI4Y
         AYGvYfXMCjrAQ==
Date:   Sat, 6 Jul 2019 09:48:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pagupta@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Staron <jstaron@google.com>,
        Cornelia Huck <cohuck@redhat.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: linux-next: build failure after merge of the nvdimm tree
Message-ID: <20190706094802.0963c374@canb.auug.org.au>
In-Reply-To: <CAPcyv4gU7TfBucm2WoAyUng8qaUQOxGu0PuuJNVd1u0m9Q_tQw@mail.gmail.com>
References: <20190705172025.46abf71e@canb.auug.org.au>
        <CAPcyv4gU7TfBucm2WoAyUng8qaUQOxGu0PuuJNVd1u0m9Q_tQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7pwjnDc8GonuK=mYR/fMP02"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7pwjnDc8GonuK=mYR/fMP02
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Fri, 5 Jul 2019 15:32:19 -0700 Dan Williams <dan.j.williams@intel.com> w=
rote:
>
> On Fri, Jul 5, 2019 at 12:20 AM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > After merging the nvdimm tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > In file included from <command-line>:32:
> > ./usr/include/linux/virtio_pmem.h:19:2: error: unknown type name 'uint6=
4_t'
> >   uint64_t start;
> >   ^~~~~~~~
> > ./usr/include/linux/virtio_pmem.h:20:2: error: unknown type name 'uint6=
4_t'
> >   uint64_t size;
> >   ^~~~~~~~ =20
>=20
> /me boggles at how this sat in 0day visible tree for a long while
> without this report?

These messages are produced by a new test in the kbuild tree, so you
need both it and the nvdimm tree together to get them.  That will
change after the merge window, of course.

--=20
Cheers,
Stephen Rothwell

--Sig_/7pwjnDc8GonuK=mYR/fMP02
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0f4bIACgkQAVBC80lX
0GzCIAf/TcAe8YEQk/gENwyB9EoAYwKScw41sWW0/+89oRUO3csTJBI1KsRp/AFQ
MSZfaKCphf3/dqssFM+iPWNJf61tGU09zWo2HO7c+FaIXRNjIvNQwPi3D3z7MlIk
e5Tpz/3J/SN5L+JUmxvN+o2NMyt3nolrLypYrmuFHRife6xcxJUBNhBTwxvM5S14
WRETzN1Iv5abpO2qJuDNIVn+FXFzaA4KUhsdWt2B0n389GpjFlyFUTjze9+RmGWU
kJ2XoUjcaNtXJo7Byt6Np3fC1+FCP0jq7nyh7rh5cv0C5DDa5lifq/yiu8QFBEpE
7NqLOYg6YLacQQUNJK8wWk3aXH6doQ==
=sJcG
-----END PGP SIGNATURE-----

--Sig_/7pwjnDc8GonuK=mYR/fMP02--
