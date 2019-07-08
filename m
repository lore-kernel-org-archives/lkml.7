Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04423C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18E120665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TbZlXwgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfGHC5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 22:57:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGHC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 22:57:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hqqp0gjmz9sNC;
        Mon,  8 Jul 2019 12:57:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562554646;
        bh=VFMvekxiALG5/T3w/s22q5Spces/S/G1tm9jk6S5Ia8=;
        h=Date:From:To:Cc:Subject:From;
        b=TbZlXwghZ0pglE1yKKcLXI8E6jaP9LAExweQlJwrN0pGBJVMkrjW3HuJmIbP6VdZs
         P3t3oRkCqEwSj1XW8wVh5BU59PA9ZwSbuzM9w+Op0lJp7HmJTkEoREciybkvLxdNcP
         86R/N7P5JsupgKxz3OKcvl6hg81dy9b1HDY+pdHi1ohVnJreZbQjfYdO5W5vBDCPUb
         aj5QryyxjvTw0RRD5H/bKW6hMTOL45WIaWQttPfvSpNtHy8Zg4MfPn/ATFy50lp1aO
         C/vtgrVfSVXm0wdXy9xS49nO6Ys5CzN/JlOHLE2rIMMHjGigHSIRQO5HNYMMncuX7K
         tjEQsUqp+xBgw==
Date:   Mon, 8 Jul 2019 12:57:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: linux-next: build failure after merge of the rdma tree
Message-ID: <20190708125725.25c38fa7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XLgGCQZ6W/s0w.HJzRujD_g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XLgGCQZ6W/s0w.HJzRujD_g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from <command-line>:32:
./usr/include/rdma/rvt-abi.h:13:10: fatal error: rdma/ib_verbs.h: No such f=
ile or directory
 #include <rdma/ib_verbs.h>
          ^~~~~~~~~~~~~~~~~

Caused by commits

  dabac6e460ce ("IB/hfi1: Move receive work queue struct into uapi director=
y")

interacting with commit

  0c422a3d4e1b ("kbuild: compile-test exported headers to ensure they are s=
elf-contained")

from the kbuild tree.

You can't reference the include/linux headers from uapi headers ...

I have used the rmda tree from 20190628 again today (given the previous
errors).
--=20
Cheers,
Stephen Rothwell

--Sig_/XLgGCQZ6W/s0w.HJzRujD_g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0isRUACgkQAVBC80lX
0Gzswwf+PwNBgvj9IuYO+/veo1nviKwhkdPSFbCMesZiaO24KSyoAiRI0p8/X30/
ufIK4+HM/iJ2oGev/BbnoyP6Daveg2ycq8atSDV/pXQi+Hvlb82qyu2drOIJDerM
eKPILbsGJmhftzj8GBbQzEdTcCTpjHCInS+OPqs6r5iHasWkkxoGpknnViVhTDVM
j/DfUaxTxv/AP3EWNHC6jRRo5KmuqiQKxsQ2ziURCivFWOaWmBNsxg1Bq+vGjdIm
3uWJOtV6dGvFev9596t54IOvUxNTkCTtRMOJaQLi/vCM8UktApWEahZ65JvGR2U+
dkb0yR+POQx7x2Xsfa1R+mQ/9UBZ9A==
=kVX7
-----END PGP SIGNATURE-----

--Sig_/XLgGCQZ6W/s0w.HJzRujD_g--
