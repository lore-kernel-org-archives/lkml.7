Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E479C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD1D206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="obh3DPXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfGALJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:09:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbfGALJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:09:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cl48276Lz9sPF;
        Mon,  1 Jul 2019 21:08:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561979337;
        bh=TsIHxcBzCHhZQDVafpPUKveYRycGCR5XtzfjkPEjZRU=;
        h=Date:From:To:Cc:Subject:From;
        b=obh3DPXJcRIFLYi1UOmDqNaCNCn6z99jLJR9sybisRxuYYcAIJWS2couB0kgVpKdz
         G6M8FB8hsaPLhfkMWLRvRNT5UzpDQdFTxST1mC/BYAcArn8YhNrshQ2RFHgMPKQ0sL
         IJpyETuJ6VBUKVCdMhfO+rfy2TBjAYwLY7yYWnaJZYjYgE8uBq6vE4fDmiTA2pbpv2
         1sx4EBypVCrMRWxmeSqu2ofQZxgqYlIpJC3aypWcFVonZlgIeEjn6tGkQDexJi/qNm
         njsFoQnN2rIFu3gxVoMseFNq3tuRHQwzbe/gyABbWcMUkwvB43+3jD+4KN5Jh49DDz
         NBCB4V7QQZXFA==
Date:   Mon, 1 Jul 2019 21:08:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: linux-next: build failure after merge of the hmm tree
Message-ID: <20190701210853.0c72240b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FKIgdE.+Owqka1kDpKHLUls"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FKIgdE.+Owqka1kDpKHLUls
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hmm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

mm/hmm.c: In function 'hmm_get_or_create':
mm/hmm.c:50:2: error: implicit declaration of function 'lockdep_assert_held=
_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=3Dimplicit-f=
unction-declaration]
  lockdep_assert_held_exclusive(&mm->mmap_sem);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  lockdep_assert_held_once

Caused by commit

  8a9320b7ec5d ("mm/hmm: Simplify hmm_get_or_create and make it reliable")

interacting with commit

  9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() ->=
 lockdep_assert_held_write()")

from the tip tree.

I have added the following merge fix.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 1 Jul 2019 21:05:59 +1000
Subject: [PATCH] mm/hmm: fixup for "locking/lockdep: Rename
 lockdep_assert_held_exclusive() -> lockdep_assert_held_write()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index c1bdcef403ee..2ddbd589b207 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -47,7 +47,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 {
 	struct hmm *hmm;
=20
-	lockdep_assert_held_exclusive(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_sem);
=20
 	/* Abuse the page_table_lock to also protect mm->hmm. */
 	spin_lock(&mm->page_table_lock);
@@ -248,7 +248,7 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_o=
ps =3D {
  */
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
 {
-	lockdep_assert_held_exclusive(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_sem);
=20
 	/* Sanity check */
 	if (!mm || !mirror || !mirror->ops)
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/FKIgdE.+Owqka1kDpKHLUls
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Z6cUACgkQAVBC80lX
0Gw/+Af9Env8AG0K0JMrb9vaNnUgMUBVs3sNfcg9nWHC8j6zRtIpiUJNHyp7zUGZ
MAoPXvRkmhWz+L5pZFh2CJYebrWC0THTpMu5my81MQJJaPphA+lS6qYCTBfi+xHD
25gmNOt/IEGzLrJrkLOIEO2aag0hpuUkhueUxApKkQzN4xBnLUuFevaAA5mVTnoc
t8qFYFtkCsZxt/NnWmp1DNllGOSIx5T2HfAu3i3hcM/UJeQUvBhEchpMF+tlI6Nf
UA8tmYNoiUVd8lUDnU2SHlz9ObTCb4Ral7tbo8aSr9wxGRyGu5bnNtCHq0rBcLvq
LEKls0F1F6iDij49wT9TC7Ia2PNBOQ==
=6/YF
-----END PGP SIGNATURE-----

--Sig_/FKIgdE.+Owqka1kDpKHLUls--
