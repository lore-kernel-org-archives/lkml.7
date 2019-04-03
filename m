Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3591FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E833B2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f3ZQ1Qvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDCAk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:40:56 -0400
Received: from ozlabs.org ([203.11.71.1]:51193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDCAkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:40:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44YnLW5Ym5z9sSS;
        Wed,  3 Apr 2019 11:40:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554252052;
        bh=oAXVDkHSFGEKugVr9r0x8EknX8mIeDGlz+bsEt7Thv8=;
        h=Date:From:To:Cc:Subject:From;
        b=f3ZQ1QvotvWqtHfiPFeB518ex07QW0h/6mAcPmQP09NSGLeDCbt7/G7eiFrWVPQIA
         KFHioqG7gLS9YHysOCc2OW6w4aW7ebdr/zGN8pOWP13FauqF+wGkrv9S0kS/lw5sdk
         RPayJ5GEUZnUnSeRRjwnzNLDnUO6z11bGsZGYAntNuJcMk/u7QF8Y0TljaUxWcn4Wp
         NMpnoKr9DgNNrMBEiez61mPVvXmzWeVnuI7BE5CzDRez9D953VtPKHXf4QALflhpNS
         HCmWeiTe6La6zzp5rCrPoIYZkvj8IdE6LbhPZjiLGQJf8huO5TswjqSXNiLevDFmJK
         5dNiy+GTaTEoQ==
Date:   Wed, 3 Apr 2019 11:40:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wei-Ning Huang <wnhuang@google.com>
Subject: linux-next: build failure after merge of the mfd tree
Message-ID: <20190403114050.57053326@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4vUOT_NJGnO_..0Nn08EZfG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4vUOT_NJGnO_..0Nn08EZfG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/mfd/cros_ec_dev.c: In function 'ec_device_probe':
drivers/mfd/cros_ec_dev.c:422:33: error: 'EC_FEATURE_FINGERPRINT' undeclare=
d (first use in this function); did you mean 'EC_FEATURE_HANG_DETECT'?
  if (cros_ec_check_features(ec, EC_FEATURE_FINGERPRINT)) {
                                 ^~~~~~~~~~~~~~~~~~~~~~
                                 EC_FEATURE_HANG_DETECT
drivers/mfd/cros_ec_dev.c:422:33: note: each undeclared identifier is repor=
ted only once for each function it appears in
drivers/mfd/cros_ec_dev.c:445:33: error: 'EC_FEATURE_TOUCHPAD' undeclared (=
first use in this function); did you mean 'EC_FEATURE_USB_PD'?
  if (cros_ec_check_features(ec, EC_FEATURE_TOUCHPAD)) {
                                 ^~~~~~~~~~~~~~~~~~~
                                 EC_FEATURE_USB_PD

Caused by commits

  4483a6f22432 ("mfd: cros_ec: Instantiate properly CrOS FP MCU device")
  a03871b9e9ea ("mfd: cros_ec: Instantiate properly CrOS Touchpad MCU devic=
e")

I have used the mfd tree from next-20190402 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/4vUOT_NJGnO_..0Nn08EZfG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlykARIACgkQAVBC80lX
0GxvEwf9ERi1vnhWLV2OwLwqyz6qDGQVtpKmK2+uNT13vVxr52cT3vIe9SX/+H5e
YuKZ5SEM4363ImI6yhtOMorU1upnJrqzyerJR6KIvYeoTAPeiq2B9vv5TJasqoiO
jTf8yK9g0xJzgQw9hifI6lZb32GEhXtIXnvf8V6//VBlypUVvqCBf9ajsuj9Krlp
MrUuutgNAr1GFGRqSmDydw5mXlSQI2GvbNbzTZ2JEqaJoDg5GHUPNjujrZWgbS/P
rCEMwtyBueHYm/Qoepa5heXfnRJ/tLYKCF/A7o+09BOmL1l9AWNq9xfk7JPr56Bw
i5L4H90ruBc4bMhXFlcB6AsBNVuOgw==
=yx2X
-----END PGP SIGNATURE-----

--Sig_/4vUOT_NJGnO_..0Nn08EZfG--
