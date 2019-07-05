Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14998C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70AD218BB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IF8hbMVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfGEHUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:20:30 -0400
Received: from ozlabs.org ([203.11.71.1]:33181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfGEHU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:20:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45g5pf1sT2z9sPF;
        Fri,  5 Jul 2019 17:20:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562311226;
        bh=7SomDwwvQ/Ys6vf/okYTjAjs8NCzeGdG05x5ihuhGw8=;
        h=Date:From:To:Cc:Subject:From;
        b=IF8hbMVB2mdGRstJ3q7RoL1vkETqMJaXgtWfI3wh31dJryhOlLexKaS1hmP8ADhun
         C/BYvZnR8E75lJC91zt9dpcOyjDEl/zHvJ6L+g5trQaLa+UHgTLc9H7LDdbG6+ZfT5
         yjqicLeH1f+lQZ6dQoTIYzBuvEP6QgGFm7/dHVV0Bc0sF0+Ykw6+x5ZqMx1MkgNO+1
         G2JdsEHuVnwdv5zpwP0LKMLvqFiKUZqjxNBM1EQqm6jSxUtLmLMyW26f/fKXJSXr4e
         RZ6Jn6m0K8y0QmJJi4mZujTB9mjTzIfZq4rX/ATEZ6DvtGWQ2WgSVe2435mlDD9avJ
         LSyxfC9dmCxiQ==
Date:   Fri, 5 Jul 2019 17:20:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pagupta@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Staron <jstaron@google.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: linux-next: build failure after merge of the nvdimm tree
Message-ID: <20190705172025.46abf71e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VfAM2Z0+e0fgkdG2CS//LRJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VfAM2Z0+e0fgkdG2CS//LRJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nvdimm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from <command-line>:32:
./usr/include/linux/virtio_pmem.h:19:2: error: unknown type name 'uint64_t'
  uint64_t start;
  ^~~~~~~~
./usr/include/linux/virtio_pmem.h:20:2: error: unknown type name 'uint64_t'
  uint64_t size;
  ^~~~~~~~

Caused by commit

  403b7f973855 ("virtio-pmem: Add virtio pmem driver")

I have used the nvdimm tree from next-20190704 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VfAM2Z0+e0fgkdG2CS//LRJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0e+jkACgkQAVBC80lX
0GxUWwgAmyZnc8NFgdtyVIE3QXX4INlxGxsspyUs0hZCN3jZEJq09iJJ8AFFFe2Z
PF0P7zJ1exHmf1+1MQedDlv1YKZGKepMqXsWxdM8r1n7spwAZw4W+0EGRbIgbdkO
y/IggrOhV3Mz6i7x1ww7m40oKREGiHTY46VGcRbEDP0zKCmCppKQCg3sTUJ2riAH
B4BCwy1wws9gZz6L1WjN0+vkU7C3IsRJpHMn55NoUMNQ+g4g0Nh60V1suH57z6ZJ
Vc6fhOsec3HpCGOa3G1LQyurBDAAs8eVKToHDItkfkHH3oMwI9yUjm7Hb/aYjm0h
rirbCtVb3A1aD4pGHcHILFJhULXDdg==
=8J3i
-----END PGP SIGNATURE-----

--Sig_/VfAM2Z0+e0fgkdG2CS//LRJ--
