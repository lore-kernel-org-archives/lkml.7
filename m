Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B9C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14D0214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AEkJIejs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHFXu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:50:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56161 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfHFXu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:50:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463BG72psQz9sNk;
        Wed,  7 Aug 2019 09:50:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565135423;
        bh=zct1gQ9OQBGfGzQ+4xFemqwOdAOZIJVO/pR0Gb+YSis=;
        h=Date:From:To:Cc:Subject:From;
        b=AEkJIejspy7zsU6YjSn9laq+MRe00X4B+ioeu3td9UU2EDWZyGWuePImAHkbm0oh1
         FB4FAriX/Vr4zIdJuZthrwbJfpySIlvCMagbr2qifR9pT2MEpaOQ/6mPZ3XJ/mm0Op
         XGL1dPH/Hukm9W5qur4eIRVlUJ9vtAHYqhfYEVu/8JLbD95Zf5c1JrHbwsM/oSfd6T
         TD7b//u3auQpXwfqluTwtpRVHl9gdYkwW23sNl1Ysa3sYE6NGAyogV6aE53yHayRjj
         4o7sn5v84bZlaw1aHmxKiehssBzCtdr8sVWLqHUI9kNqGYEMqp0VanZ5yD2cLrM6MO
         TokYjK1SZ7ZPg==
Date:   Wed, 7 Aug 2019 09:50:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: build failure after merge of the arm64 tree
Message-ID: <20190807095022.0314e2fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7emCAv/hhDBzUrOu7i.tONe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7emCAv/hhDBzUrOu7i.tONe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm64 tree, today's linux-next build (powerpc
ppc64_defconfig) was just spinning in make - it executing some scripts,
but it was hard to catch just what.

Apparently caused by commit

  5cf896fb6be3 ("arm64: Add support for relocating the kernel with RELR rel=
ocations")

I have not idea why, but reverting the above commit allows to build
to finish.

--=20
Cheers,
Stephen Rothwell

--Sig_/7emCAv/hhDBzUrOu7i.tONe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1KEj4ACgkQAVBC80lX
0GxI2Af+InUCBZC1eshxBKWx+T8XmnaIXtcTPt9Y4CjwTJwSn8X+cwd65CudkIYZ
UhXKADJRVgGowqIzyU/MptSux5vCw49L5Pjn9XcfIqdwBWe267db2Usd4zI/9+o7
iELYB2FZKfFd51J2ZJe4xq1AZCPD/yoZTarEPTb/xzaPThA7Yc/X+yjAStcz7WtP
IknugKRYSteCLu8TyVppp6D971vgn6/d8mW5HyQbv9HnrbVBLEzbCy8/NCDqirnn
CcSGZdEzlqHKDAmKbwk/uPZAMBYP0staGklQt4N7uH9zGg4G231/Ml0HUKdQA3n3
T5GtHA9h+jlEIxEDnEdvalT/TH9Q+g==
=h4LQ
-----END PGP SIGNATURE-----

--Sig_/7emCAv/hhDBzUrOu7i.tONe--
