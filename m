Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB2BC48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0654208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KjdMkESu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfFTJmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:42:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfFTJmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:42:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Txgp5M9zz9s3l;
        Thu, 20 Jun 2019 19:42:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561023766;
        bh=BnWu035yer0Ose+3iL8DXlaSET5VRns6Pd3E+LOltjc=;
        h=Date:From:To:Cc:Subject:From;
        b=KjdMkESukwjUSnxFl6p2jcFLOM6qGW7HnGqsvxlbXqyBAWf161K1/S6UIuwoV2xg7
         Xr5Cwy3yvBxXuFkr5ucHmTwpxBzdDEYiSqvT23st5CJIfBxjKUzDliu5vQuSAc+a6R
         GmC+TCetO3vwFE1ezEfcaalPnutbzdjRiepWJ4o3c82s2uR10OMq9q7Tbj1dcu9Vrp
         xkyUL2aWm/fsdBfawjJrAhnUPpuBZImGDixNclx8mccBjqkFjnloA80U0nSAx4PECb
         IkVPWX5XjpYNx2T26O3VkP4cE+e+jnTX5IHsH4XaLC5FkxCXZhoSGsr7LYddO90yHd
         jfkr0Q3Tqx7pw==
Date:   Thu, 20 Jun 2019 19:42:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190620194244.474a83e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GmjbN.zEeNy_F7a4Pi8p9zb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GmjbN.zEeNy_F7a4Pi8p9zb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/base/memory.c: In function 'find_memory_block':
drivers/base/memory.c:621:43: error: 'hint' undeclared (first use in this f=
unction); did you mean 'uint'?
  return find_memory_block_by_id(block_id, hint);
                                           ^~~~
                                           uint
drivers/base/memory.c:621:43: note: each undeclared identifier is reported =
only once for each function it appears in
drivers/base/memory.c:622:1: warning: control reaches end of non-void funct=
ion [-Wreturn-type]
 }
 ^

Caused by commit

  29be27f12cc8 ("drivers/base/memory.c: Get rid of find_memory_block_hinted=
()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/GmjbN.zEeNy_F7a4Pi8p9zb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LVRQACgkQAVBC80lX
0GxWxAf+P8Opt9Xr27NriFBGKoLNBakqhKlgZrTWQ30uTIUgr0KqcrgmYij642pi
yVHz61M9epU5ZQfv7gtAgD8ikUbRmjUeiThqXvlvZtEbJFeOtcnhgEf1exq5Fc0b
G5x6PL4H0EaHCjDm3zS3HNyGycYfcqgHciyCPpgLdA4Om5Y3U7kc7DsPt7s+/c5+
agUXoocujuj7ZmH7QK64BezQeGUPOluyq/TPf2TT6kvI1+nw4T/Sic5XtDFKTFwT
cFfdFlRBVPWGDGPpr5H4LS2RpP+Aj7XK2b/HvDXq+xMSDZnV6WrgUnXaBT2iTr5m
4Y2JCeN/2WBAAMPWWXvGPWztHu/gPw==
=1t42
-----END PGP SIGNATURE-----

--Sig_/GmjbN.zEeNy_F7a4Pi8p9zb--
