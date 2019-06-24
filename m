Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B059DC48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FFB20820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DBQTRL0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfFXLAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:00:51 -0400
Received: from ozlabs.org ([203.11.71.1]:39939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbfFXLAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:00:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XRCx3V6bz9s4Y;
        Mon, 24 Jun 2019 21:00:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561374046;
        bh=8m4TcE68yekSxQEtnkp/kllxDbk1vCDS2zmgRrW6X5s=;
        h=Date:From:To:Cc:Subject:From;
        b=DBQTRL0i51NzjVRpj7yW9LX4BO2Cj1lt2hVj+NHa6/9St1Dl9oMe4Qm6zabHb7jx+
         g5tx3FkfuDPZWepsvAqqggR7SLw8TmguxMTehjRa9BIf6/5WsBC++bTa9RC9hI51J+
         Bh8sdCtILl7m4RuRNcXTHWWhu6j5eJeZXWW7r4mAOdt/q0JS3fkcpkujth1/qqKraK
         LSFO6XqoHEWp3LBQQNn4lZqzjRp+PywsxiX29Vg8tD9ycKfqQAzw8mkzF/FV5+QwSl
         Ux30DIGH4TNYYgkV/AB2PVXkd1qYVkOb8elP7/lJDPKS66HePtISa7pDzpyeCSyj6h
         LQE8Hyfw1QkHw==
Date:   Mon, 24 Jun 2019 21:00:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190624210043.13c924f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EJNkLuX6x/0R_//4wZQNdO7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EJNkLuX6x/0R_//4wZQNdO7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

mm/util.c: In function '__account_locked_vm':
mm/util.c:372:2: error: implicit declaration of function 'lockdep_assert_he=
ld_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=3Dimplicit=
-function-declaration]
  lockdep_assert_held_exclusive(&mm->mmap_sem);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  lockdep_assert_held_once
cc1: some warnings being treated as errors

Caused by commit

  610509219f27 ("mm-add-account_locked_vm-utility-function-v3")

interacting with commit

  9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() ->=
 lockdep_assert_held_write()")

from the tip tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 24 Jun 2019 20:57:23 +1000
Subject: [PATCH] merge fix for "locking/lockdep: Rename lockdep_assert_held=
_exclusive() -> lockdep_assert_held_write()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 021648a8a3a3..932b00a7c28e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -369,7 +369,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned =
long pages, bool inc,
 	unsigned long locked_vm, limit;
 	int ret =3D 0;
=20
-	lockdep_assert_held_exclusive(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_sem);
=20
 	locked_vm =3D mm->locked_vm;
 	if (inc) {
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/EJNkLuX6x/0R_//4wZQNdO7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QrVsACgkQAVBC80lX
0Gwdjwf/Yly8Pz5OlIVugfFWZ5CVMC6OhmSPC1mTFWz2NlQOgjRxntMMrI3MU0UF
NFhQy8r4KC/jLMkL5zwBPAh1S/YxwjWDb0LvYWQ0UkgQDfFrfhVUGRAMt59yNBIU
49g+RGrBEizV5nCrZqeDqSlIpcMuvCDPrfUl2ohkjYqUSLvp50+kmrhTs6DeGWJ0
Nx5l5PWqeI7831lTrmQvWlEv97iMBc6X/vXA6xOUJpPQKKJUwDO/qZ4yhEp29oQn
6NDzir95TADEyRQUDr2nlDSmz6gexgna0J0Wb66Nj8hoSRP6x06vTAQZEAVgCBxN
TbxTXSItJ2FWuJ9SICGZZK/CkSQoSw==
=uWGQ
-----END PGP SIGNATURE-----

--Sig_/EJNkLuX6x/0R_//4wZQNdO7--
