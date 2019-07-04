Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D8AC06510
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 03:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DF821882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 03:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N5dBp5nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGDD6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 23:58:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfGDD6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 23:58:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fPMf0p9qz9s8m;
        Thu,  4 Jul 2019 13:58:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562212686;
        bh=+JknrCbseCBQVVRqI76JmSRNZa6J5xmyEX8iMAFeHfM=;
        h=Date:From:To:Cc:Subject:From;
        b=N5dBp5nqYSDA4MFmyr0AMB1aw9XGTa45iaGkX408/FbF/bQ1JGBO5Y/P2wNAQnq6h
         Cpokx6VHcnbaCsKbEEOK4+oxMhB9SvCsStKvwe2aZpSuEgk5VFVIEsHyOiVtMBrdY4
         tQDjsn4EtCdQPzeB4u/EIE1vkedIM7jlz8c5pduviOpAlI0qi5m6LorhDskVjhyTEz
         wAEBIq7mH9MQeGXo6qTTDjr9dK8N9tBx4G4vfsOqt77ddl5O/c9PdLoYwkYkFL6+tH
         DWJDtj1h9qy/pBIM+QVNjwUAvkx10gtTrutLaP/eqBM/aXkHFjVAHN/DsB7RdeQzWl
         45WzRWrYbodnQ==
Date:   Thu, 4 Jul 2019 13:58:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: manual merge of the device-mapper tree with the jc_docs
 tree
Message-ID: <20190704135805.6b077b57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//GxNH+=keHIH0Nb1xPUa7XL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//GxNH+=keHIH0Nb1xPUa7XL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the device-mapper tree got a conflict in:

  Documentation/device-mapper/snapshot.rst

between commit:

  f0ba43774cea ("docs: convert docs to ReST and rename to *.rst")

from the jc_docs tree and commit:

  a8a9f1434a86 ("dm snapshot: add optional discard support features")

from the device-mapper tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/device-mapper/snapshot.rst
index 4c53304e72f1,1810833f6dc6..000000000000
--- a/Documentation/device-mapper/snapshot.rst
+++ b/Documentation/device-mapper/snapshot.rst
@@@ -31,7 -30,8 +31,8 @@@ original data will be saved in the <CO
  its visible content unchanged, at least until the <COW device> fills up.
 =20
 =20
 -*) snapshot <origin> <COW device> <persistent?> <chunksize>
 +-  snapshot <origin> <COW device> <persistent?> <chunksize>
+    [<# feature args> [<arg>]*]
 =20
  A snapshot of the <origin> block device is created. Changed chunks of
  <chunksize> sectors will be stored on the <COW device>.  Writes will

--Sig_//GxNH+=keHIH0Nb1xPUa7XL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0deU0ACgkQAVBC80lX
0Gwbnwf+JKjJyQTyNdobCshf+gPms6olS7MsyBnnxAbB50DUwdAI6BGLQ3PcOHwg
Y25IilS6hPkXWL77CjEYPXDofU+Lm5/HXOL7fI5kxaKI2ape7ExU6sPX88HQ8nsn
vN8VtW4yg9c2vcwhvJp3k+L4k76dbcejQkm7mzG5Q0HWuf9f1xhzwBjXRAKbGV11
2LRZAkhPapVdKw4+uF/McK53LgNCScNDAcdFSdSuWvkpO/bAA+3oGo+ATD4/VTAb
XAkKPUUDwTvp7V50EAmMvR6eEkncj+bqET5s85rXr0mXloNinRIGswmmP2L6vNCt
Xl4OX2InjQ+nvT9/6UyeR5w98+TzAQ==
=a2G7
-----END PGP SIGNATURE-----

--Sig_//GxNH+=keHIH0Nb1xPUa7XL--
