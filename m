Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA43C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0E72070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FR/srBNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLBWcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:32:14 -0500
Received: from ozlabs.org ([203.11.71.1]:55343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBWcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:32:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47RfxR0q8zz9sNx;
        Tue,  3 Dec 2019 09:32:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1575325931;
        bh=PS8ZCxyebpHnwpzLlSXRTCBEi86nooa6CSQgCnfd3EU=;
        h=Date:From:To:Cc:Subject:From;
        b=FR/srBNrQp8WZX/ZEFOpGegVjriH1GEw7pWagqXi+SOn1ioRhdlTdqAtAT+4XlQF9
         rmn24lj3EAAa7Ea1jiJ6RDQQNlu73xIOKPL8vjjyBZY8NDVPQx7FZ+A2SgbwheciEf
         rgmr0x5+BbclAX+ET/3ncSnkcDEMwxqYSfZTm/bDFLCRW23MMZsOPgNr4HCqmmI+6v
         slW76G6ha47Byv7EPhEznJcF/rLyHKc9rmSfzpF53R85HkxgHtmPVXnmvvtZOoo/VW
         Hepqt1+ldIM6KLIuvO/k+BhsOd9YZGF8i1pTqrO4EIJns3E6xk4jfIgwrC73S4o6VO
         WxH976mp7rlBA==
Date:   Tue, 3 Dec 2019 09:32:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-fixes tree
Message-ID: <20191203093203.2f88400d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XWyp_XTB+vJcGnZp0c6A90F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XWyp_XTB+vJcGnZp0c6A90F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-fixes tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

fs/quota/dquot.c: In function 'dquot_quota_on_mount':
fs/quota/dquot.c:2499:1: warning: label 'out' defined but not used [-Wunuse=
d-label]
 2499 | out:
      | ^~~

Introduced by commit

  6c2d4798a8d1 ("new helper: lookup_positive_unlocked()")

--=20
Cheers,
Stephen Rothwell

--Sig_/XWyp_XTB+vJcGnZp0c6A90F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3lkOMACgkQAVBC80lX
0GwsYQf+OeS06MzOhqa+GF9AgCmaUx3TaPXVWAqgWwE6aVI/mg6Qni8KSncB8wKr
Da7jHmKzRoYb0whthvGKhQ8j4kxv7Jmt6MM0gMfLSzylckXwO60N75nOiV6/aZ6z
dQt1m9FKdw1Q1lzkNuXzcsh90rhWWVn6wxqalOxIbrHGtc52DsEwljearMslJxw5
j21VeH4sBraoA2IeUnLdd+4APkhgpvtET083oTArnG4VqJdnb9/QwCVFkcxkjJSr
Gtjx68Itkck+iQKPGQnIkF7PtVvfykyP5GLNDA6oWAdZ11gNNB8xXoi7kvOCO7sA
pxq7rhVO7YVe0/hrIxUbjFyF5qgMvw==
=UTKA
-----END PGP SIGNATURE-----

--Sig_/XWyp_XTB+vJcGnZp0c6A90F--
