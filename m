Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B41BC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B8A20818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GaP44zLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKCYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:24:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43013 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfDKCYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:24:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44flG96pBKz9s3l;
        Thu, 11 Apr 2019 12:24:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554949458;
        bh=BbcGnj23b10G3Nthin6BRg7O8vxWrhLf97KzW+jCYtg=;
        h=Date:From:To:Cc:Subject:From;
        b=GaP44zLptblMSs66VQ8a9Yt+P5OUTBmXf+gbyygY6F/ttCbCv+4u6luiU1JGNFtgj
         S8RvS9tLb3KKOWQ0oWsmswf5sSyL0NOjc/g8ZSKKtnFxmULnxCIBfXxCAVonyMlV53
         iuHnKPIaz1OwTA3jwKSL14y9CcMOWe3pS+xHcKcoW+GY8QeVd5r5NPQ5tT+PYe8cGp
         orHQSbaLpIiI7hbb3gWgg+HIBsFRbOJdCAMgaifJ/TFNgCKhjjflFqcVloHWbc1J9t
         ipxEVwIapa3XW8W8wK5Uvv9TuRnhikY6FwIi08RsF4xdXkPLz0tF+02UmU64ws87Mj
         JXQVBJ4+vYGCA==
Date:   Thu, 11 Apr 2019 12:24:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Chris Coulson <chris.coulson@canonical.com>
Subject: linux-next: manual merge of the apparmor tree with Linus' tree
Message-ID: <20190411122408.7b35cf74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q/8EpOQ53.R7ce447/f/weu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q/8EpOQ53.R7ce447/f/weu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the apparmor tree got a conflict in:

  security/apparmor/lsm.c

between commit:

  e33c1b992377 ("apparmor: Restore Y/N in /sys for apparmor's "enabled"")

from Linus' tree and commit:

  876dd866c084 ("apparmor: Initial implementation of raw policy blob compre=
ssion")

from the apparmor tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/apparmor/lsm.c
index 87500bde5a92,e1e9c3c01cd3..000000000000
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@@ -25,8 -25,8 +25,9 @@@
  #include <linux/user_namespace.h>
  #include <linux/netfilter_ipv4.h>
  #include <linux/netfilter_ipv6.h>
+ #include <linux/zlib.h>
  #include <net/sock.h>
 +#include <uapi/linux/mount.h>
 =20
  #include "include/apparmor.h"
  #include "include/apparmorfs.h"
@@@ -1420,46 -1424,37 +1436,77 @@@ static int param_get_aauint(char *buffe
  	return param_get_uint(buffer, kp);
  }
 =20
 +/* Can only be set before AppArmor is initialized (i.e. on boot cmdline).=
 */
 +static int param_set_aaintbool(const char *val, const struct kernel_param=
 *kp)
 +{
 +	struct kernel_param kp_local;
 +	bool value;
 +	int error;
 +
 +	if (apparmor_initialized)
 +		return -EPERM;
 +
 +	/* Create local copy, with arg pointing to bool type. */
 +	value =3D !!*((int *)kp->arg);
 +	memcpy(&kp_local, kp, sizeof(kp_local));
 +	kp_local.arg =3D &value;
 +
 +	error =3D param_set_bool(val, &kp_local);
 +	if (!error)
 +		*((int *)kp->arg) =3D *((bool *)kp_local.arg);
 +	return error;
 +}
 +
 +/*
 + * To avoid changing /sys/module/apparmor/parameters/enabled from Y/N to
 + * 1/0, this converts the "int that is actually bool" back to bool for
 + * display in the /sys filesystem, while keeping it "int" for the LSM
 + * infrastructure.
 + */
 +static int param_get_aaintbool(char *buffer, const struct kernel_param *k=
p)
 +{
 +	struct kernel_param kp_local;
 +	bool value;
 +
 +	/* Create local copy, with arg pointing to bool type. */
 +	value =3D !!*((int *)kp->arg);
 +	memcpy(&kp_local, kp, sizeof(kp_local));
 +	kp_local.arg =3D &value;
 +
 +	return param_get_bool(buffer, &kp_local);
 +}
 +
+ static int param_set_aacompressionlevel(const char *val,
+ 					const struct kernel_param *kp)
+ {
+ 	int error;
+=20
+ 	if (!apparmor_enabled)
+ 		return -EINVAL;
+ 	if (apparmor_initialized)
+ 		return -EPERM;
+=20
+ 	error =3D param_set_int(val, kp);
+=20
+ 	aa_g_rawdata_compression_level =3D clamp(aa_g_rawdata_compression_level,
+ 					       Z_NO_COMPRESSION,
+ 					       Z_BEST_COMPRESSION);
+ 	pr_info("AppArmor: policy rawdata compression level set to %u\n",
+ 		aa_g_rawdata_compression_level);
+=20
+ 	return error;
+ }
+=20
+ static int param_get_aacompressionlevel(char *buffer,
+ 					const struct kernel_param *kp)
+ {
+ 	if (!apparmor_enabled)
+ 		return -EINVAL;
+ 	if (apparmor_initialized && !policy_view_capable(NULL))
+ 		return -EPERM;
+ 	return param_get_int(buffer, kp);
+ }
+=20
  static int param_get_audit(char *buffer, const struct kernel_param *kp)
  {
  	if (!apparmor_enabled)

--Sig_/Q/8EpOQ53.R7ce447/f/weu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyupUgACgkQAVBC80lX
0Gx45gf/VB40HfJVDnmWY+s10LavRxSl+A0EbfHr4qU6PsC+vjkxxO62tWWLzcVZ
SoGk/RhQ6zFZ6v7A8DJ6zFPKt+SyzKu8z4wvm5qaT+p5Tixjm1AzdL9re0FUEz7u
QH9q5eGM7HiS1phlanEJVscIm1wtRkXZo8HYmWKOh8ukAEF5Jv0T5OZ5uGurFeUq
/xelZvOpWqljZrYiUFwPqoMD7loqiH0kYLJTTgpXVlBGgdlbV6Qm3H8oOgEMO6No
j1marxDD2H2VtZsuO6vg94Uf3MjNXjFhJ2SHTpGWKG4TQQ2oxorYfq+FvyAqGhD5
Da4gRfEZutuLBQCmR8M6FC+AdDcIyA==
=HLfv
-----END PGP SIGNATURE-----

--Sig_/Q/8EpOQ53.R7ce447/f/weu--
