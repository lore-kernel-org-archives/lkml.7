Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FEBCA9EB3
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BBC21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="glIX1fvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438547AbfJQXTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 19:19:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46741 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391772AbfJQXTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 19:19:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46vQ9Q6XwRz9sPW;
        Fri, 18 Oct 2019 10:19:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571354380;
        bh=/ix32X7sAQTkRYblQzkJqFNP7nvPyhgVbjHaAc+Ejwk=;
        h=Date:From:To:Cc:Subject:From;
        b=glIX1fvbwyNBFuDjXXHxAgZ8bgGWvEwrbTLyhMbQ7IzwjLULeWa+nQYCh0GufXQq3
         MhjGzgEoWH+b83+gPqiT0YXpQnCUlXMKpLI+uZk2xFxeLZpjbp9Hn6ime98KUOynry
         Mjw7vt++pL8TEakVKf+4mEO076oWjpB7Ol+aWF2G0OZZG95EEl0JHm3dScilUOgpHX
         U3j0z+Ka1xzvOEo2GkQGPj+iRo7E9ROTkjVGjBMCQIVjlTkN3O2aPNAwuY0ZYzavz7
         PZE4Hw6UbOMmVxQBp7k0omm0yo6v5IQWkElx9hcJ8b54xu6DuvCfFbw6MOEr8Zchs0
         k50vQvANfpx1Q==
Date:   Fri, 18 Oct 2019 10:19:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: linux-next: manual merge of the pm tree with the printk tree
Message-ID: <20191018101938.0947d0b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//17xlm2v8hmccp96+b+ae2Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//17xlm2v8hmccp96+b+ae2Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pm tree got a conflict in:

  lib/test_printf.c

between commit:

  57f5677e535b ("printf: add support for printing symbolic error names")

from the printk tree and commit:

  f1ce39df508d ("lib/test_printf: Add tests for %pfw printk modifier")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc lib/test_printf.c
index 030daeb4fe21,422b847db424..000000000000
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@@ -593,26 -595,35 +595,55 @@@ flags(void
  	kfree(cmp_buffer);
  }
 =20
+ static void __init fwnode_pointer(void)
+ {
+ 	const struct software_node softnodes[] =3D {
+ 		{ .name =3D "first", },
+ 		{ .name =3D "second", .parent =3D &softnodes[0], },
+ 		{ .name =3D "third", .parent =3D &softnodes[1], },
+ 		{ NULL /* Guardian */ }
+ 	};
+ 	const char * const full_name =3D "first/second/third";
+ 	const char * const full_name_second =3D "first/second";
+ 	const char * const second_name =3D "second";
+ 	const char * const third_name =3D "third";
+ 	int rval;
+=20
+ 	rval =3D software_node_register_nodes(softnodes);
+ 	if (rval) {
+ 		pr_warn("cannot register softnodes; rval %d\n", rval);
+ 		return;
+ 	}
+=20
+ 	test(full_name_second, "%pfw", software_node_fwnode(&softnodes[1]));
+ 	test(full_name, "%pfw", software_node_fwnode(&softnodes[2]));
+ 	test(full_name, "%pfwf", software_node_fwnode(&softnodes[2]));
+ 	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
+ 	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
+=20
+ 	software_node_unregister_nodes(softnodes);
+ }
+=20
 +static void __init
 +errptr(void)
 +{
 +	test("-1234", "%pe", ERR_PTR(-1234));
 +
 +	/* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
 +	BUILD_BUG_ON(IS_ERR(PTR));
 +	test_hashed("%pe", PTR);
 +
 +#ifdef CONFIG_SYMBOLIC_ERRNAME
 +	test("(-ENOTSOCK)", "(%pe)", ERR_PTR(-ENOTSOCK));
 +	test("(-EAGAIN)", "(%pe)", ERR_PTR(-EAGAIN));
 +	BUILD_BUG_ON(EAGAIN !=3D EWOULDBLOCK);
 +	test("(-EAGAIN)", "(%pe)", ERR_PTR(-EWOULDBLOCK));
 +	test("[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
 +	test("[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
 +	test("-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
 +#endif
 +}
 +
  static void __init
  test_pointer(void)
  {
@@@ -635,7 -646,7 +666,8 @@@
  	bitmap();
  	netdev_features();
  	flags();
 +	errptr();
+ 	fwnode_pointer();
  }
 =20
  static void __init selftest(void)

--Sig_//17xlm2v8hmccp96+b+ae2Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2o9woACgkQAVBC80lX
0Gx5pggAmF5G1haODwNStFKBfXgaa/uD5EDhSjApQGdq36TMyUrdPNmkTkjE6EEg
PXQxWoeubM/twJiYAP0VGM22rnAEe+UE9T1M06NX9SrvTOR2B+376wPmPFLzEKq0
XO2qEguyDyla4u4J8cRD8NKfQmAHXzTyluSegL3x7cADSxYopm4z/rlWMwHfU5tg
r4Ug99n0iQgPAm5Klg0vsc3CB+Vmxy+lGTWWNfAsph4lFys+CxiJ2bMebfHgzrtj
QLPC5ySdksGKSJJWXZ+hfR8quww0ezm/O8Y4v1hqWsTrYQs6RxxoPTgn3GJn901k
d0LXIchPk/VBdS7pamMnVdejWq25EA==
=7gDW
-----END PGP SIGNATURE-----

--Sig_//17xlm2v8hmccp96+b+ae2Y--
