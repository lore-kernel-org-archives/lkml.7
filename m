Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD048C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA76217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KYL0eVFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfHHEss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 00:48:48 -0400
Received: from ozlabs.org ([203.11.71.1]:52825 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfHHEsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 00:48:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463wqv1MsSz9sBF;
        Thu,  8 Aug 2019 14:48:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565239724;
        bh=1f250LMXLwWnqdNimCN3355njptLrOoXy2MrxX2uGkE=;
        h=Date:From:To:Cc:Subject:From;
        b=KYL0eVFoAsTG5l4EZg05MuHHgNwA44WcFniPxrbOxpQIU5ClfTd3JUM8E/hBeQifZ
         FBLEO33jJWG05x6rItSgfljYFdKxzlIe/qhbUt1DwfY70KsOntCUvUM75scVFnJn8G
         Egc0fFEKn6H4wp+NYBVDFU8A7b4EFKcfXOsfWDQMNOEWwubSO8qY+3BQD/xy0N/ao2
         tGGSvMfV/5OvRh5B2X6XqdF0I0NziEaRB6tj7apdGRpELNvLMK4FFjJaYr3mjW+VBG
         p7WePddpSxP6S3S8qTgaQz2DXwkTpc8BXFJsOZ4g6BM3b+qbIyy1jeAFY7zqFcJyby
         dIbBn7YkGQHGQ==
Date:   Thu, 8 Aug 2019 14:48:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20190808144841.7f6f820f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UpkGkPk3ustXJR1oHAzBBx5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UpkGkPk3ustXJR1oHAzBBx5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

kernel/locking/mutex-debug.c: In function 'debug_mutex_lock_common':
kernel/locking/mutex-debug.c:32:42: error: dereferencing pointer to incompl=
ete type 'struct mutex_waiter'
  memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
                                          ^~~~~~~

Caused by commit

  5f35d5a66b3e ("locking/mutex: Make __mutex_owner static to mutex.c")

I have reverted that commit for today.

BTW, there is another reference to mutex_waiter in sched.h!
--=20
Cheers,
Stephen Rothwell

--Sig_/UpkGkPk3ustXJR1oHAzBBx5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1LqakACgkQAVBC80lX
0Gx/3gf9E2Fa5lCdYFV4iiOe5r9ttX0R9W/vqXMGR8s1HACZgNbPlGViwvvhWeGM
OiKaulKViUCOcX/FqqoeU57/nv1wQTsLLcYDycNnoyBTfupWtRoLjaYwrKDngapv
VY1RS8e7ccOn58FqInSKT33+RhVJhjrk++a2VZlYBK/d0p6LzsK01z9hkASjGLzx
jtS/LEjqh5QlxDqr4s1Vv1gEfYschdRw0Tn3sYPHWLTuZ4ml3VD63US17zDR1cMj
NoxTQk2pXgPALWqy6wZP6jVwk5jOmQf+LkuPAuvOHBTONEFtZ3bktYxPo8r5PYtF
OrzW/9s9W2eXz/qXrZH2ahN1J7hWKw==
=VBTh
-----END PGP SIGNATURE-----

--Sig_/UpkGkPk3ustXJR1oHAzBBx5--
