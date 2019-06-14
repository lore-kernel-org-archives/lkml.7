Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CC8C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2748720851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AUez3GFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfFNFfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:35:01 -0400
Received: from ozlabs.org ([203.11.71.1]:37113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfFNFfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:35:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Q8Sf3Pwjz9sBb;
        Fri, 14 Jun 2019 15:34:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560490498;
        bh=h0CJvH5c+33+Ehq+hkgxp6meel343fWZ2RepqdMfLdA=;
        h=Date:From:To:Cc:Subject:From;
        b=AUez3GFQ2fwhBKOR4r59/lWYMWYyhy0zWLiA65nMFQ6rDxBuK5yWhOJb4flbCsnLS
         RrceAy02kdiS+wV3WT++lQGk8NhSS8z0p7egmTlEQZSSHp4cnUCKi1JC3ZPVTUGPbJ
         lDidO3f4ovZXWyVxfy+Non1ynLHh+HFIV6G4s1R4pNWx5a4zXD3SvshMKyb/k5Ckh1
         gkE2VX7rjQ9i4CRwHoGFeHqD0CMd4B6X4zV5JxI2zOG/bO+H9d3oRAQcq3D6PzFbtk
         z+6UNZAVrl4AZOWUC6a+SibeBfXyOF3R4m79j0mXh5ygxviLGDQt3ztnUTxuMMskDx
         U/h5ogDq1Surw==
Date:   Fri, 14 Jun 2019 15:34:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: linux-next: build failure after merge of the integrity tree
Message-ID: <20190614153459.49c3d075@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zCu2Pfsbp_z8xj0M7kihiBQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zCu2Pfsbp_z8xj0M7kihiBQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the integrity tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/infiniband/core/device.c: In function 'ib_core_init':
drivers/infiniband/core/device.c:2531:8: error: implicit declaration of fun=
ction 'register_blocking_lsm_notifier'; did you mean 'register_lsm_notifier=
'? [-Werror=3Dimplicit-function-declaration]
  ret =3D register_blocking_lsm_notifier(&ibdev_lsm_nb);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        register_lsm_notifier
drivers/infiniband/core/device.c:2550:2: error: implicit declaration of fun=
ction 'unregister_blocking_lsm_notifier'; did you mean 'unregister_lsm_noti=
fier'? [-Werror=3Dimplicit-function-declaration]
  unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  unregister_lsm_notifier

Caused by commit

  bafe78e69508 ("LSM: switch to blocking policy update notifiers")

CONFIG_SECURITY is not set for this build and the !CONFIG_SECURITY
declarations were not fixed up in linux/security.h.

I have used the integrity tree from next-20190613 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/zCu2Pfsbp_z8xj0M7kihiBQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0DMgMACgkQAVBC80lX
0GyFuQf/Z3dl+ET12LfU+IuPUAtLhWL+rGZ6OTzW4loBYLcIwTI0ncGjRB15e54s
LzZ7MPbAnl1jmU7HFGPMBOi6F3MoJ3Gbugu1ztAKZFdZYyP2JfGtytfZdFNTw2ER
hSg1XE5xR14+35m/gDRjXmXRUqz7VupeQDfjzdwGQYuu1VMgR5uQWXvrWaFJHWrv
PhwWofpSpVDzTm7Ao8xzkKwBf86T7YgyUQXWUhdbiS7e26YpzmO55of1+YKLLwEk
mIjzPk6tqmuqj5aNM4N111In49r4M69s9RQXS5UfVu6TyEN2QnQjbHJvPhzHRcDd
i6EW9ZujftwXNoe8c7WZCyXHH2doow==
=EIUP
-----END PGP SIGNATURE-----

--Sig_/zCu2Pfsbp_z8xj0M7kihiBQ--
