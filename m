Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BCCC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653732166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pBmMKw/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfGIBiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:38:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48919 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfGIBiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:38:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jQ2b1Lrgz9sMQ;
        Tue,  9 Jul 2019 11:38:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562636328;
        bh=0iCGW0qL/OpS03ZHi0LH5gcvYgC7h7FYwZotn3mruNE=;
        h=Date:From:To:Cc:Subject:From;
        b=pBmMKw/RMkESVj97LJ52bMnYHYoIuI48109e0TmtnUUWZ9XFZVETflN9ZujQi7sK2
         hpIfa9q7j/Zwnxs0zrr3OB7+HrvCc9VCKtKf87K0YsxfgA3KKsX+Qimqq7njLfYdWo
         XqEqp+wJH5r4+0G4Luei+7DvNXCIHQhTC3SnwyBprLiqkIEhUH4OTf8iENi3lhoM2J
         bokUf6NptPK7IHS+Auji3MWETojq2sk5lKoo9vjFQ3Tl4itLI1A/Jqmt3vZypwboCk
         Bsnqpw+SWdVbvW1jclWa1+IduIMJsWALn/38M+bFyUoaE/eBZYE7v2AL7XfmQ54ATt
         DvK5toJAm/3YA==
Date:   Tue, 9 Jul 2019 11:38:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michele Dionisio <michele.dionisio@gmail.com>,
        Richard Weinberger <richard@nod.at>
Subject: linux-next: manual merge of the vfs tree with the ubifs tree
Message-ID: <20190709113845.553963e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/37bZ=OT_Jw8oxZKN5QkVAYE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/37bZ=OT_Jw8oxZKN5QkVAYE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/ubifs/super.c

between commit:

  eeabb9866e4c ("ubifs: Add support for zstd compression.")

from the ubifs tree and commit:

  334d581528b9 ("vfs: Convert ubifs to use the new mount API")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ubifs/super.c
index 5c472cca3876,62f339d901c1..000000000000
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@@ -939,49 -937,42 +939,43 @@@ enum=20
  	Opt_auth_key,
  	Opt_auth_hash_name,
  	Opt_ignore,
- 	Opt_err,
  };
 =20
- static const match_table_t tokens =3D {
- 	{Opt_fast_unmount, "fast_unmount"},
- 	{Opt_norm_unmount, "norm_unmount"},
- 	{Opt_bulk_read, "bulk_read"},
- 	{Opt_no_bulk_read, "no_bulk_read"},
- 	{Opt_chk_data_crc, "chk_data_crc"},
- 	{Opt_no_chk_data_crc, "no_chk_data_crc"},
- 	{Opt_override_compr, "compr=3D%s"},
- 	{Opt_auth_key, "auth_key=3D%s"},
- 	{Opt_auth_hash_name, "auth_hash_name=3D%s"},
- 	{Opt_ignore, "ubi=3D%s"},
- 	{Opt_ignore, "vol=3D%s"},
- 	{Opt_assert, "assert=3D%s"},
- 	{Opt_err, NULL},
+ static const struct fs_parameter_spec ubifs_param_specs[] =3D {
+ 	fsparam_flag	("fast_unmount",		Opt_fast_unmount),
+ 	fsparam_flag	("norm_unmount",		Opt_norm_unmount),
+ 	fsparam_flag	("bulk_read",			Opt_bulk_read),
+ 	fsparam_flag	("no_bulk_read",		Opt_no_bulk_read),
+ 	fsparam_flag	("chk_data_crc",		Opt_chk_data_crc),
+ 	fsparam_flag	("no_chk_data_crc",		Opt_no_chk_data_crc),
+ 	fsparam_enum	("compr",			Opt_compr),
+ 	fsparam_enum	("assert",			Opt_assert),
+ 	fsparam_string	("auth_key",			Opt_auth_key),
+ 	fsparam_string	("auth_hash_name",		Opt_auth_hash_name),
+ 	fsparam_string	("ubi",				Opt_ignore),
+ 	fsparam_string	("vol",				Opt_ignore),
+ 	{}
  };
 =20
- /**
-  * parse_standard_option - parse a standard mount option.
-  * @option: the option to parse
-  *
-  * Normally, standard mount options like "sync" are passed to file-system=
s as
-  * flags. However, when a "rootflags=3D" kernel boot parameter is used, t=
hey may
-  * be present in the options string. This function tries to deal with this
-  * situation and parse standard options. Returns 0 if the option was not
-  * recognized, and the corresponding integer flag if it was.
-  *
-  * UBIFS is only interested in the "sync" option, so do not check for any=
thing
-  * else.
-  */
- static int parse_standard_option(const char *option)
- {
+ static const struct fs_parameter_enum ubifs_param_enums[] =3D {
+ 	{ Opt_compr,	"none",		UBIFS_COMPR_NONE },
+ 	{ Opt_compr,	"lzo",		UBIFS_COMPR_LZO },
+ 	{ Opt_compr,	"zlib",		UBIFS_COMPR_ZLIB },
++	{ Opt_compr,	"zstd",		UBIFS_COMPR_ZSTD },
+ 	{ Opt_assert,	"report",	ASSACT_REPORT },
+ 	{ Opt_assert,	"read-only",	ASSACT_RO },
+ 	{ Opt_assert,	"panic",	ASSACT_PANIC },
+ 	{}
+ };
 =20
- 	pr_notice("UBIFS: parse %s\n", option);
- 	if (!strcmp(option, "sync"))
- 		return SB_SYNCHRONOUS;
- 	return 0;
- }
+ static const struct fs_parameter_description ubifs_fs_parameters =3D {
+ 	.name		=3D "ubifs",
+ 	.specs		=3D ubifs_param_specs,
+ 	.enums		=3D ubifs_param_enums,
+ };
 =20
  /**
-  * ubifs_parse_options - parse mount parameters.
+  * ubifs_parse_param - parse a parameter.
   * @c: UBIFS file-system description object
   * @options: parameters to parse
   * @is_remount: non-zero if this is FS re-mount

--Sig_/37bZ=OT_Jw8oxZKN5QkVAYE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j8CUACgkQAVBC80lX
0Gxccwf/dA4YTS5GciaOP8vzfyt3nlhI+IIffDNzt5IlStAB8sySURdnQiO7BPKP
dEKSvAj+bmESM1sP31jZSAUoB/p5tkP3fS6jg6nI+4YWgpVky7yK35tYkAUYi5dM
OpivujFSeP+8A0+47NSsogU697Toe+WX3SK7vU8dQ7nQ1GL/NrvZrbbHb35dIXFV
ynqehJK+lagcyyzPD3cEslUV08+Eb4vd8nonW+qbA8AFV6jI2abbB2nJpqmOOf4S
Rq8fX3TVbYTCMQThMKUnxX6NjRBif3B1NH/IlXgAa9p+Qm/QzSeDMEKTTszLZ2UW
DXAF+w/BU0E7V0ff3S9Pe/ishADQSw==
=TP2/
-----END PGP SIGNATURE-----

--Sig_/37bZ=OT_Jw8oxZKN5QkVAYE--
