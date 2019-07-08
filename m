Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B3C5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720CC20659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nCctON+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfGHER7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:17:59 -0400
Received: from ozlabs.org ([203.11.71.1]:45259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfGHER7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:17:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hscg58vyz9s3l;
        Mon,  8 Jul 2019 14:17:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562559476;
        bh=VieVy7UWn7o5F9dBWHqJRxeZCvRi9w06XTxRVgaaLSo=;
        h=Date:From:To:Cc:Subject:From;
        b=nCctON+2mEZ27IiocbsqLKyxSCENVjWSU9x7Tcp7egEBJWMEo+WVMLGy4Dptq5sAG
         TMEqZd/cyEKNVqIoSYQFCIpSBV5QcAuZlNp1+cmxK73L6sodwH1lfSib76PjoJvjNh
         hSgWdK/t0ZC19MZk0+sLV5eMvvT5L287XP3PjMXoRVcqq412MC3OGeIMNadzwjG8z2
         DeIFTfUCZXf4WoAh3zCtEqKXRS4yCXaK1Xi0lKN6Q2OOxex0dOvV2HXKGw8jdi4GTn
         QUxq06GYcN1LzvZpBr3OnHHg13XgWbyAaUBzgN7jhir6moezog7492chDqB/I+LTlN
         +WuLel+ynccwQ==
Date:   Mon, 8 Jul 2019 14:17:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Hackmann <ghackmann@google.com>
Subject: linux-next: manual merge of the drm tree with the vfs tree
Message-ID: <20190708141754.64d32ebe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u04U78ytM4vB=CX3N=GbpPy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u04U78ytM4vB=CX3N=GbpPy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  include/uapi/linux/magic.h

between commit:

  ea8157ab2ae5 ("zsfold: Convert zsfold to use the new mount API")

from the vfs tree and commit:

  ed63bb1d1f84 ("dma-buf: give each buffer a full-fledged inode")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/uapi/linux/magic.h
index 85c1119d0b0b,665e18627f78..000000000000
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@@ -91,6 -91,6 +91,7 @@@
  #define UDF_SUPER_MAGIC		0x15013346
  #define BALLOON_KVM_MAGIC	0x13661366
  #define ZSMALLOC_MAGIC		0x58295829
 +#define Z3FOLD_MAGIC		0x33
+ #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 =20
  #endif /* __LINUX_MAGIC_H__ */

--Sig_/u04U78ytM4vB=CX3N=GbpPy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0iw/IACgkQAVBC80lX
0Gw5VAf8DDgJkQqJA0KHL5lzWfnr+HAflbMU2MMXJBSG3NsClNnp1GE5JDyRxueR
HXZqxdX8X0pQ9bNsELol5xB75QB5cTedZdc29EFeTcB7EB95DSzzBHRBrL/ygvJg
d43wZR3GJtnKPRiOajlXwfE13piL2v8iJzarCmsVwC8Qr3cOqScUxsk0xaCMVfxK
fFLbdrW9J04vf+iS//JLLdvDboj1xtQIN2I/kWIklV06+QwxI1ThjX/PpMUocHbb
DWZSW41v4wjv+IqHqElhL4ZyQRuPcIQVPGtDdGPTXndClaKfCD7P/WNyoCRNtycG
l8NnwvFCccaiCnsaFDBrWHl0bOQihA==
=8SNV
-----END PGP SIGNATURE-----

--Sig_/u04U78ytM4vB=CX3N=GbpPy--
