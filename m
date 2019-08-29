Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03D0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D537233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dvFOnEK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfH2D5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:57:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfH2D5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:57:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Jpj969yGz9sBp;
        Thu, 29 Aug 2019 13:57:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567051054;
        bh=BdEMh8vbsCDcIm29Nl3Mdcn5gCwgX5s/SScJUUrf9DI=;
        h=Date:From:To:Cc:Subject:From;
        b=dvFOnEK5SfD6Pj+yigRUl29BclvRtWvZQftO35JrmsHGJvD+fPNbHb2LvZ7wMMi3C
         iemdhuYrqhO93kfBEgnjAo0RLB0pBQ8E9YU52GQ+l+Vf6UBdbLPFHjuzh7tBBQdGnw
         +mpKPcugDCwGQsYeOtKfS9R7AscxlCDgZRAYCLm8agG1r3JqIPFZFJ4hm1wFHd1aBg
         s6F5CkqqTr/qXKtyk9dfuenjc4/0uBDvrJyXoHzOKGjwozlmqKXq873+Af/+N90CoP
         xCMEvrSQdbkfy+kltH77aVPugebmYifJIvycgK3xwstdLhNXPJ5C2TsRXleKKpbvzF
         Rt5CF1ZBQDMeg==
Date:   Thu, 29 Aug 2019 13:57:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: linux-next: build failure after merge of the regulator tree
Message-ID: <20190829135733.2c6da5ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RwAbcv7ht3ZEEJhE7ZN+TsE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RwAbcv7ht3ZEEJhE7ZN+TsE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the regulator tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/regulator/mt6358-regulator.c:5:10: fatal error: linux/mfd/mt6358/re=
gisters.h: No such file or directory
 #include <linux/mfd/mt6358/registers.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  f67ff1bd58f0 ("regulator: mt6358: Add support for MT6358 regulator")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/RwAbcv7ht3ZEEJhE7ZN+TsE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1nTS0ACgkQAVBC80lX
0Gz+nQf/VHT53sxtkhoDKaMV5auKcvdxddP+AmFB8BKQgWqoBfw2Hy68id7d0WOk
Vis7kHQXKnwAAzK1mL/q424uNGZGDLKzXiCQvYF5PqNdMqF73H47bMCs2U3GUfM+
iZB4GUb0OeqKEawH7q/2bkDpwCf5e25+We+cydOjtwTVJrn85KU6QxCKyNaXjShu
/l9Qidazwj3M232azpn1qzsGogJwU62gglwimSP70Pc54Sx7gTh5XxMkVLPKkhh8
AOk04VjXhCF6fl/e7vZu5397zkyKNJlgBvBUf2Lpk0gvQnSgPTFXZojIyYLVLEBK
tfXiDq4sn/s5hA4oFr4k0U0OubONDg==
=XaNr
-----END PGP SIGNATURE-----

--Sig_/RwAbcv7ht3ZEEJhE7ZN+TsE--
