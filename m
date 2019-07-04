Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE8C06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CD5218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cLWxkb6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfGDKBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:01:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfGDKBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:01:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fYRB2XB4z9s4Y;
        Thu,  4 Jul 2019 20:01:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562234503;
        bh=T0+7N2k7pCg1r7C05ldU6b0MGchRpIZaW9IbP9QJOYk=;
        h=Date:From:To:Cc:Subject:From;
        b=cLWxkb6aPM0fWgSjBYkQWaHI3qA5wD1zlMcU6KUAS8GOosS+axnyxwJebkB86xdFU
         mamGKfRRdVOtzW5DKMaJK/I7gWebY9k7JAyIkTkCcMeaGSSxGjbiKDsj+LIbLsAieC
         8j3Z7Gtmo+EXC/wH9zcrAmcNsRoEfL1pJdYQOWGs/tcpOSrwBVA/cMZvybrCffmHZa
         465amo7k14ntH+ye65Moxar5qM1jS2w8oKyTRt+AKGFWAGO27fRYGHjToLCdT7Nnsv
         9lDWm7MbR0Qr19tyQOAt3FkJojAyAoCWuAyeEcPWLhHm5wlplWDynYJbNOxCMvObFY
         wBaBNrhUCZCzA==
Date:   Thu, 4 Jul 2019 20:01:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: linux-next: manual merge of the akpm-current tree with the hmm tree
Message-ID: <20190704200139.696330e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fY.s_Ut8h2cNGK1xTp_zhLe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fY.s_Ut8h2cNGK1xTp_zhLe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  drivers/dax/dax-private.h

between commit:

  ea31d5859f58 ("device-dax: use the dev_pagemap internal refcount")

from the hmm tree and commit:

  420a0854e8f2 ("device-dax: "Hotremove" persistent memory that is used lik=
e normal RAM")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/dax/dax-private.h
index c915889d1769,9ee659ed5566..000000000000
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@@ -43,6 -43,9 +43,7 @@@ struct dax_region=20
   * @target_node: effective numa node if dev_dax memory range is onlined
   * @dev - device core
   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
 - * @ref: pgmap reference count (driver owned)
 - * @cmp: @ref final put completion (driver owned)
+  * @dax_mem_res: physical address range of hotadded DAX memory
   */
  struct dev_dax {
  	struct dax_region *region;
@@@ -50,6 -53,9 +51,7 @@@
  	int target_node;
  	struct device dev;
  	struct dev_pagemap pgmap;
 -	struct percpu_ref ref;
 -	struct completion cmp;
+ 	struct resource *dax_kmem_res;
  };
 =20
  static inline struct dev_dax *to_dev_dax(struct device *dev)

--Sig_/fY.s_Ut8h2cNGK1xTp_zhLe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dzoMACgkQAVBC80lX
0Gw2jgf+MW/2gLFzzReQCIJ/9LaEyxKfqRotANdBRXSHmPGJ7XSpGDP86EHbmVGY
jfZXVrlvcbA+YzcO1yQ7SpchMeVK3UqhpSfurN6xW621DfIqq6HS1FBTmVV2VBvi
0p4FDxTV2FQF3dUc3hJheYEsl6WWsningFDA4a7jGYItzhg7PEAViIhLO3JtUNjw
SnREMv4ALUsngSZSzlmMr7b/tLaZDNXP4VuFpux86dvG2mo4xfgQA9dkP/YTEMOo
MJqV0mXwCmSp0TUxuy26J9/MUCYsqR+LcwxqxCY/JIlFT7xib7J3nTQHcbUHq9Y2
xgtyNLE/X8fLR28kKt+6WJyqyPBUtw==
=AI65
-----END PGP SIGNATURE-----

--Sig_/fY.s_Ut8h2cNGK1xTp_zhLe--
