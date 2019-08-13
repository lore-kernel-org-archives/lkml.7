Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C54C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED15520842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GtRHyITL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfHMH56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:57:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58531 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfHMH55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:57:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4674nt6YRbz9sNm;
        Tue, 13 Aug 2019 17:57:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565683075;
        bh=yDggRPhc2GSkJIFl1/H+L4pY1wqdl7Q3/g0mgM7BCN8=;
        h=Date:From:To:Cc:Subject:From;
        b=GtRHyITLNkWDBznY3EVnN8w6l8seMv/kXr3mTsM00/im9x6U1ikD7AjUMaN6I9aiu
         6UhTmJknBIw4FBPEWQwxxgJNYFkt8EWGDamNAynpsz6rVrn17PRj1ZeqYNdpSz4qtK
         j5iEHeh8KDfOcjytEV+lCD3UU08Ayyppq6QwGlo9j5H0Q22lFeZDIqbrKKMfZZuAT2
         FTzVCTEpWUBrVbILbGrePYAcKxnoyPE2FdAHpjc2pLy83b/YN+L2yIekJGv6vkPaeJ
         8A2LOLAHn/yLQajevIoL8PgKQdchqmYEheiHIWkDEv3kOstLbVRn5H3sKarSeHW6x/
         0/SpcvmN+mLkQ==
Date:   Tue, 13 Aug 2019 17:57:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20190813175732.2c97d412@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PMBweslkJGQ1tTeaDx.LUR/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PMBweslkJGQ1tTeaDx.LUR/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (powerpc allnoconfig)
failed like this:

drivers/base/core.c: In function 'device_links_read_lock_held':
drivers/base/core.c:106:9: error: implicit declaration of function 'lock_is=
_held'; did you mean 'lockref_get'? [-Werror=3Dimplicit-function-declaratio=
n]
  return lock_is_held(&device_links_lock);
         ^~~~~~~~~~~~
         lockref_get

Caused by commit

  4a3a5474b4c1 ("driver/core: Convert to use built-in RCU list checking")

lock_is_held() us only available if CONFIG_LOCKDEP is set.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/PMBweslkJGQ1tTeaDx.LUR/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1SbWwACgkQAVBC80lX
0Gw6Xwf/YS2mW2kJX45IJzGSD4sICLGkWoPxzKloHd8v7tcc/hhuwDZEB4iCzoM8
FVu+veUZoHOh17Hi7eNDqHKfClKF8OjTDvSSbw4xdWOWZNB3Asz5iiyMMhdOsFz5
hKFTvA89oS+4cWk2WSK3PsFgak5oRxSsrI7aRIvFoM9PuYt3uoFO/6tLP7qpPXbG
0K18yWhmwQvRbUgORAREBKixxx8sckxS3YfAH2d1iiPLV3fKI6gReukVY1CLHEsk
HWBustLBQIAoyrPhRyYl7LO52B2DUxzh+8yQqAG8zbYgjSo+3P3K9eo5h2UKWU0J
q4NYBb5VsAPs5zPyZv9ht3A3e5BoCw==
=JoNt
-----END PGP SIGNATURE-----

--Sig_/PMBweslkJGQ1tTeaDx.LUR/--
