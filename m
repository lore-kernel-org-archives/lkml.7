Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E94C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ADD2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N9+pzOwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfB1Bbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:31:46 -0500
Received: from ozlabs.org ([203.11.71.1]:46713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730234AbfB1Bbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:31:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 448w4w0VtVz9s5R;
        Thu, 28 Feb 2019 12:31:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551317504;
        bh=l99e3C+LuMG3gSerVA5UGdsZgv6q1c8fcFRSQq5WNXg=;
        h=Date:From:To:Cc:Subject:From;
        b=N9+pzOwPMwUS2pA6JyEmvOVfwyWMA7rXv2Rt2CrdeLfhAPUuiim/FBNoXO4tPBLqn
         DnsQw6G3l3c9mvu9fMHprC7TvJbRDQpzDYAJEPRZ+SKyeVDQVCCXZ84DrOLd4dQLDf
         tEeDHdrLEJCIIHHCDrmf2tuzmSStjhCVXQITxzOUU4vRH8+EkcX+SF99pmVmqUYwRV
         jbswDrGQ62DrdWceYneMQVoTSJcMw+tbO/NIB3wy0eQerD8sku1kDcA05D+77XuYMJ
         i/2QE6E0wgTCXw3lNCGTm0DUhoVI1kUdvb4ZbfpXk46ugzx2jWmD5bV6Jmm4NIpj3J
         NxIuzDQxgf7ZQ==
Date:   Thu, 28 Feb 2019 12:31:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20190228123136.064f94a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KVSuOZSF+iWuksnPHYBlN6u"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KVSuOZSF+iWuksnPHYBlN6u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

kernel/sysctl.c:1238:13: error: 'sysctl_bpf_stats_enabled' undeclared here =
(not in a function); did you mean 'sysctl_base_table'?
   .data  =3D &sysctl_bpf_stats_enabled,
             ^~~~~~~~~~~~~~~~~~~~~~~~
             sysctl_base_table

Caused by commit

  492ecee892c2 ("bpf: enable program stats")

CONFIG_BPF=3Dy
# CONFIG_BPF_SYSCALL is not set

I applied the following patch for today, but it should be done
properly. Also this patch leaves proc_dointvec_minmax_bpf_stats() as an
unused function.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Feb 2019 12:26:58 +1100
Subject: [PATCH] bpf: hack to make "enable program stats" build

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 86e0771352f2..80a70f69cbd5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1232,7 +1232,6 @@ static struct ctl_table kern_table[] =3D {
 		.extra1		=3D &one,
 		.extra2		=3D &one,
 	},
-#endif
 	{
 		.procname	=3D "bpf_stats_enabled",
 		.data		=3D &sysctl_bpf_stats_enabled,
@@ -1242,6 +1241,7 @@ static struct ctl_table kern_table[] =3D {
 		.extra1		=3D &zero,
 		.extra2		=3D &one,
 	},
+#endif
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 	{
 		.procname	=3D "panic_on_rcu_stall",
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/KVSuOZSF+iWuksnPHYBlN6u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx3OfgACgkQAVBC80lX
0GzCGAf/QhBD93TcwOUJMY+JyzbG/g8JY95Ei9jnwYP0XKbhyA7GPVdttmWarXoZ
WLWjmsIWjbU8cI/Am+enJAWJUMclLAlyAprzZOQ7VrI40rN/97VsbsVNKGjOIov9
BbhGrM7J1p87EnlML15KWGewpNxrI+MFSgaZQYukvPx9IPE296ClXT42LFfTuCZW
fi4qqgogxR1nKn/Nl06PXCqxwY3q33VIr83vl/SGvi2xgRP+k2A7ZOhk6loo6WAM
VS4Y+nKeXywnCAlOeX+pjOmbnh4vsHbtMigcXWrnQdPseZknwJcB9oy7Wc3jOJu7
trQUxa69z+Ql8yd2BKbYSrlLkAsjhQ==
=588i
-----END PGP SIGNATURE-----

--Sig_/KVSuOZSF+iWuksnPHYBlN6u--
