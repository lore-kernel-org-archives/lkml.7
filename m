Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1154CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFC121726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iq4jfqas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFZXfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:35:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfFZXfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:35:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YzsT2l4pz9sBZ;
        Thu, 27 Jun 2019 09:35:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561592109;
        bh=qMfcxqk4G2kzYq2wlabyoCO9Jbk0YAFRUFR1ilLG5kA=;
        h=Date:From:To:Cc:Subject:From;
        b=iq4jfqas37jNNL/akHubkPa0aPi6FwKRzK8q7n8gxV3ZPpkh6qrsL+4ChQ0VfOP/Y
         ajwOvWE1ba6AE+uYOop9BuovurAwPWZWVIwtKzQnnnpaJkMItu3L7mcLQ2jHrCWSg8
         K3nV6X+VhgNx6sr0GTztrboXt38ne9CEHV2t1lLjBPqxhvkpQElHSanC6zXQbnlk7/
         biAUiK2ERQSfBS7MNoAZBwfiJntVOwuTg/vLiGzdhb4SUSHrf/f3O9mC99OH94lAi6
         5442hZwLEy4556XF7m3pFfKybtNZdDZHtBq0gWLVgkB+KO9yWUaHdvSP7tk3rWJT1D
         p84Kk+7jvOQoQ==
Date:   Thu, 27 Jun 2019 09:35:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: linux-next: manual merge of the arm64 tree with the arm64-fixes
 tree
Message-ID: <20190627093503.094106d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EHexR=Ls15yx5V+tV1u47RH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EHexR=Ls15yx5V+tV1u47RH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/kernel/module.c

between commit:

  6f496a555d93 ("arm64: kaslr: keep modules inside module region when KASAN=
 is enabled")

from the arm64-fixes tree and commit:

  7dfac3c5f40e ("arm64: module: create module allocations without exec perm=
issions")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/module.c
index 71530e080ecc,5b5936b7868c..000000000000
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@@ -29,12 -39,9 +29,12 @@@ void *module_alloc(unsigned long size
  	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
  		gfp_mask |=3D __GFP_NOWARN;
 =20
 +	if (IS_ENABLED(CONFIG_KASAN))
 +		/* don't exceed the static module region - see below */
 +		module_alloc_end =3D MODULES_END;
 +
  	p =3D __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
- 				module_alloc_end, gfp_mask, PAGE_KERNEL_EXEC, 0,
 -				module_alloc_base + MODULES_VSIZE,
 -				gfp_mask, PAGE_KERNEL, 0,
++				module_alloc_end, gfp_mask, PAGE_KERNEL, 0,
  				NUMA_NO_NODE, __builtin_return_address(0));
 =20
  	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&

--Sig_/EHexR=Ls15yx5V+tV1u47RH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UASgACgkQAVBC80lX
0GzTxwf+OqovGorYRLpMze4h0oyLKXzv79/eFCgNoZJ/HyGszyMKkJb52BWi/juA
Mph+lfAgue+VIp0/p8MiTDp882FnfVoi/SBpB4sgQiSrMb6602l60sVl++ZQs9S6
/efkX042yTD3JwS+7LVl1Zm5Zg1+q3QM0W7RdK1yWVkKOR7aJFndnbQST2npjrna
dGup4YzRT/TtFEd1CdJJJIwFPbE2eBn2lA4TkWCj/RGy7PwGnneV+qOAf0+l1AG7
uEbQR4MSUDANHQR/nGKheh3dq0JLqSa9fsVSE9U4JVgwt3GKkmLJ572rC7VJd/IQ
tWpnv+OMLNQ9BsHl6xsnEKL3D5NsOQ==
=x+n7
-----END PGP SIGNATURE-----

--Sig_/EHexR=Ls15yx5V+tV1u47RH--
