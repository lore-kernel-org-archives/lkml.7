Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE89C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCA4206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CTRXVnpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfG3EhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:37:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46661 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfG3EhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:37:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yP0c5bvwz9s3Z;
        Tue, 30 Jul 2019 14:37:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564461424;
        bh=ZEK/SveL+CYAKkTNLqtDMeYcvcYDJezeg9+KKvNlKX8=;
        h=Date:From:To:Cc:Subject:From;
        b=CTRXVnpHci8dgwsm4WCheU0z7Wo7RhRqoLsYsB9dHCqCAqBuW/V0C43fq8dnSdqvS
         G89D86dDP6iOiXMy8YMBGh2U1E/PJJ/5SWBNYjbgsfAGPeUslwM4+vBhb5otx/bCEq
         tZhSdPCRoaUnXhl0Ow8yRxkYjcSxI+ORx4sY8wbCtQQz53lnfw7rutolOzGJwWnEEG
         /uKoL12TKT610vhMFkemVe9d0L8Ta1ky8eRa+QqOG8i/QMA65E/nJTqEtn6BYPorL0
         JSDh1womcDyczzaJOwKPC2lQ5oEckKnnlJPqO42sAOyr7NRXvfWft3BMrQ+49kPLFr
         ncu6ya2dz0k4w==
Date:   Tue, 30 Jul 2019 14:37:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/macintosh/smu.c: Mark expected switch fall-through
Message-ID: <20190730143704.060a2606@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WkrTSZW/7hwA8JeT.W=8kOU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WkrTSZW/7hwA8JeT.W=8kOU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: powerpc):

drivers/macintosh/smu.c: In function 'smu_queue_i2c':
drivers/macintosh/smu.c:854:21: warning: this statement may fall through [-=
Wimplicit-fallthrough=3D]
   cmd->info.devaddr &=3D 0xfe;
   ~~~~~~~~~~~~~~~~~~^~~~~~~
drivers/macintosh/smu.c:855:2: note: here
  case SMU_I2C_TRANSFER_STDSUB:
  ^~~~

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 276065c888bc..23f1f41c8602 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -852,6 +852,7 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
 		break;
 	case SMU_I2C_TRANSFER_COMBINED:
 		cmd->info.devaddr &=3D 0xfe;
+		/* fall through */
 	case SMU_I2C_TRANSFER_STDSUB:
 		if (cmd->info.sublen > 3)
 			return -EINVAL;
--=20
2.22.0

--=20
Cheers,
Stephen Rothwell

--Sig_/WkrTSZW/7hwA8JeT.W=8kOU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/yXAACgkQAVBC80lX
0GwhmAf/ePhS1Q79PIStbUXViKasLy26Y63miHzQp6DC0yYLAPcNySioEUZDBVuV
Pd4/3Pk/y8AKLhfuMOer8EMs7c16qY/yXKHn645SatMojhyHPR2HwYMLbNXQQip0
ziPURJty85qxE0ipdZJhWqtk5LC8kaIxXTXO4MRtzBOHHgSVOrMpv4LzIyuCxxbO
I59imbAfo5Uaf4EVlgg59yslaTKNc8Bf9LR2/E2KHez4eb4kh4G+mWk6hQ2p0lp8
zcsjrJpVJXUX/gZpngjhfMtiqr1KDQFHDCeOOAB4v6NwABvOqMDx5xN5Cs2OYi+K
/S1vr+2r9m0yvPEn80pZ8/HrBvhVvg==
=Gr+3
-----END PGP SIGNATURE-----

--Sig_/WkrTSZW/7hwA8JeT.W=8kOU--
