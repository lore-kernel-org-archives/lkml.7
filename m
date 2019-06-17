Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA6C31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 02:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7201D2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 02:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rkGhFF5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfFQCUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 22:20:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42349 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfFQCUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 22:20:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Rw0J1MRlz9s7h;
        Mon, 17 Jun 2019 12:20:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560738000;
        bh=wBWMGBVBQ5ezlMDp8R8/aMimo8d/aDPG24E9jYAmeSo=;
        h=Date:From:To:Cc:Subject:From;
        b=rkGhFF5cjSTtmBpVmDUMKOYFLSzUvvwQFSohFd88NVzJ4VWm2EQAAGOT89n+Vr6Ef
         x6BhiN8j+dp8klWxYoegLWibEx/kXkP+2YjND+rYgi8oXeREdX/oJbfQ5CecARJBLY
         KA3YrVAYXtHqtoxzX4BDNvw52q8d7vKL1iD+0AO6hWVrJJwVs+bODUWnf9HuHT995p
         MhqYjJglgrMxURnaYRQGLAQstsIuXzqy0vRMCkOLMLcg2Q6jfsc5h0hxfsF3NnSj2Y
         icnYrSDV5nNMT9/XJVY2ovSeKS73MR+ONPUOOnR6Z+2RLJbK8tPUvpR50AjCErUyXk
         fNmxvFBQOiM3A==
Date:   Mon, 17 Jun 2019 12:19:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20190617121959.55976690@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U_rax0R86/Jb9AOPQ_OoMry"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U_rax0R86/Jb9AOPQ_OoMry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  include/linux/mlx5/eswitch.h

between commit:

  02f3afd97556 ("net/mlx5: E-Switch, Correct type to u16 for vport_num and =
int for vport_index")

from Linus' tree and commit:

  82b11f071936 ("net/mlx5: Expose eswitch encap mode")

from the mlx5-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/mlx5/eswitch.h
index e9a55c0d50fd,174eec0871d9..000000000000
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@@ -61,5 -62,16 +62,16 @@@ void *mlx5_eswitch_uplink_get_proto_dev
  u8 mlx5_eswitch_mode(struct mlx5_eswitch *esw);
  struct mlx5_flow_handle *
  mlx5_eswitch_add_send_to_vport_rule(struct mlx5_eswitch *esw,
 -				    int vport, u32 sqn);
 +				    u16 vport_num, u32 sqn);
+=20
+ #ifdef CONFIG_MLX5_ESWITCH
+ enum devlink_eswitch_encap_mode
+ mlx5_eswitch_get_encap_mode(const struct mlx5_core_dev *dev);
+ #else  /* CONFIG_MLX5_ESWITCH */
+ static inline enum devlink_eswitch_encap_mode
+ mlx5_eswitch_get_encap_mode(const struct mlx5_core_dev *dev)
+ {
+ 	return DEVLINK_ESWITCH_ENCAP_MODE_NONE;
+ }
+ #endif /* CONFIG_MLX5_ESWITCH */
  #endif

--Sig_/U_rax0R86/Jb9AOPQ_OoMry
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0G+M8ACgkQAVBC80lX
0GyIqwf/euuoa2saCB1tjTHOdRXh3JOKS3ESEPtDirzWa2+Rdq6HxrfX0uewVQKt
I1SL9flqDm+ePueHtsb6/WnZTfnvJWcVgJLUdfDR2mWM8CAmkGdUhqv7PNFa2Wqs
UFxwpON95a0RyqF7hhYvojKLaDJBfeimwmifEN9AT8mfCJAxG99+q2YW2FP7KgSg
D4N5eG93zgXz6NGrFWmtG/tjXs2TacALWxzFtz7hbOaSsT9TPLHz5Tu6Q+vvil/D
6sp024MGnxnarPaNjOJEARtL3X6Uhb92GgdV+3lYHJQKNi6eU/BYgssL1cAOSUbG
IixeBV10/O3djeXrZNcJlI8AptYoRA==
=U43T
-----END PGP SIGNATURE-----

--Sig_/U_rax0R86/Jb9AOPQ_OoMry--
