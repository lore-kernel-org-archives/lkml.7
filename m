Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5488C0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEE720717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gqtezC10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfHFCPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 22:15:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbfHFCPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:15:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 462dX92Jsrz9sBF;
        Tue,  6 Aug 2019 12:15:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565057737;
        bh=+QU8r+QEPvR0/c+i1mAJXOGDW63fLQfMU95ysF2g8RQ=;
        h=Date:From:To:Cc:Subject:From;
        b=gqtezC10/iushRRO7RCt1zPCrqYauWin6a4TKr88x1TDiQS4R9ni04E7RL9HqKyNv
         KHTywB0ZMzM8MIwjQvPYip3nrnTO0zyZWCZmhSQCMP0jAQDuMGtkXRDYoZRj2J6B35
         CsJGK3Rwu6Hli9yfOnP0j8EtRxFamFCBXtibHeeXhBjwfRhdM+eX0VSiJwg47665VS
         Yqu4QYocHCstMnzajkszfzi67DHFCZKqXYrov9Bq4s5j97fJ3fn48McVsDpyCoXcL5
         zbB0mdk8xlI7blKDbSnGXMl47AgP2kXMYhLULXW3ij0E0QjOpC4OCSJP94dQzKbp4W
         jiDsbDesnrg2w==
Date:   Tue, 6 Aug 2019 12:15:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: linux-next: build failure after merge of the integrity tree
Message-ID: <20190806121519.0f8ac653@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zTLvc.ANXYxn/G.A9CglH=f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zTLvc.ANXYxn/G.A9CglH=f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the integrity tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from <command-line>:
include/linux/module_signature.h:32:2: error: unknown type name 'u8'
  u8 algo;  /* Public-key crypto algorithm [0] */
  ^~
include/linux/module_signature.h:33:2: error: unknown type name 'u8'
  u8 hash;  /* Digest algorithm [0] */
  ^~
include/linux/module_signature.h:34:2: error: unknown type name 'u8'
  u8 id_type; /* Key identifier type [PKEY_ID_PKCS7] */
  ^~
include/linux/module_signature.h:35:2: error: unknown type name 'u8'
  u8 signer_len; /* Length of signer's name [0] */
  ^~
include/linux/module_signature.h:36:2: error: unknown type name 'u8'
  u8 key_id_len; /* Length of key identifier [0] */
  ^~
include/linux/module_signature.h:37:2: error: unknown type name 'u8'
  u8 __pad[3];
  ^~
include/linux/module_signature.h:38:2: error: unknown type name '__be32'
  __be32 sig_len; /* Length of signature data */
  ^~~~~~
include/linux/module_signature.h:41:54: error: unknown type name 'size_t'
 int mod_check_sig(const struct module_signature *ms, size_t file_len,
                                                      ^~~~~~
include/linux/module_signature.h:41:54: note: 'size_t' is defined in header=
 '<stddef.h>'; did you forget to '#include <stddef.h>'?
include/linux/module_signature.h:1:1:
+#include <stddef.h>
 /* SPDX-License-Identifier: GPL-2.0+ */
include/linux/module_signature.h:41:54:
 int mod_check_sig(const struct module_signature *ms, size_t file_len,
                                                      ^~~~~~

Caused by commit

  c8424e776b09 ("MODSIGN: Export module signature definitions")

We now have build time checks to make sure that include files are self
contained.

I have added the following fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Aug 2019 12:09:36 +1000
Subject: [PATCH] MODSIGN: make new include file self contained

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/module_signature.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/module_signature.h b/include/linux/module_signat=
ure.h
index 523617fc5b6a..7eb4b00381ac 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -9,6 +9,8 @@
 #ifndef _LINUX_MODULE_SIGNATURE_H
 #define _LINUX_MODULE_SIGNATURE_H
=20
+#include <linux/types.h>
+
 /* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
 #define MODULE_SIG_STRING "~Module signature appended~\n"
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/zTLvc.ANXYxn/G.A9CglH=f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1I4rcACgkQAVBC80lX
0Gzw6gf+KRVWNfz612RsV41gpCJO04MKJt5O2JENYUhAKLQUOEKgF7EyYuN4sxk3
2o26m2vt40nBv4qXgGc1aKwqnqz7SFuIijzc/wxCh2SoJISI/F2MjXunF9PmxIwN
Z5bjxxZUhgB7z83evNe5kEstS3W9iV4N2cAJkU8cMDed9CehFkFUsN06JZgfoysD
i2pNOFSOS9IJcYttRIk1e1C+H5su5JgErSv5zteQFzG3vCDsmgWfPLN92kBTT9MO
H/tdeAVx/hn9aLj6gpfOtggtrbQkFgc5Oj8zEsi8MfBwzdrW8Fnymjuc7subdtWp
7W8XouRhQTa0rls3sPu6sOMydiIk6w==
=Qd6n
-----END PGP SIGNATURE-----

--Sig_/zTLvc.ANXYxn/G.A9CglH=f--
