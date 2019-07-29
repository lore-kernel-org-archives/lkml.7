Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A603C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E411720651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="D970EviR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfG2EEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:04:09 -0400
Received: from ozlabs.org ([203.11.71.1]:55489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfG2EEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:04:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xmK16BrJz9s3l;
        Mon, 29 Jul 2019 14:04:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564373046;
        bh=5aMRIYgwHdRX5tRFfBsaakpgQFBynoRUdtJ0cJDOsYk=;
        h=Date:From:To:Cc:Subject:From;
        b=D970EviRRTwcwnbjcyMb//7TvqiWl0JWjSMpIT5M4QQpUPasPQFYC50qMQT+ssW8N
         mdEuM9K+woTKCxexJ2FU913sRPWjVByeh+Y3/MQvzg1Qv90C26a9IJ80mFZSZqV0mY
         HYD7twSpf9XHPKPB/DuX96bwRxgt5YIX/VfqKF9H/1yRjMjFtwETvqiQw3gVywzdxB
         +EWQIEx3cGoPOBITqN0OMk47aX1lvY99qGPiA7otdOtsb+EI1ECRF3nV+AfOYYjXuQ
         w5OHwAu0VcDOUVe7BEbpaxC8nkCe8JI6qUJXKdEsoz+EFajgF+i+ncmc6jFFIKY3a5
         C/WyCdy+j+ZzA==
Date:   Mon, 29 Jul 2019 14:04:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of Linus' tree
Message-ID: <20190729140404.37bac29e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yDBVGcXbmvxPZtM=KzrxmqT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yDBVGcXbmvxPZtM=KzrxmqT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the origin tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

sound/aoa/codecs/onyx.c: In function 'onyx_snd_single_bit_get':
sound/aoa/codecs/onyx.c:377:37: warning: 'c' may be used uninitialized in t=
his function [-Wmaybe-uninitialized]
  ucontrol->value.integer.value[0] =3D !!(c & mask) ^ polarity;
                                     ^~~~~~~~~~~~

Introduced by commit

  f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")

This warning has been around for a long time.  It could possibly be
suppressed by checking for errors returned by onyx_read_register().

--=20
Cheers,
Stephen Rothwell

--Sig_/yDBVGcXbmvxPZtM=KzrxmqT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+cDQACgkQAVBC80lX
0GxmdAgAkoSRWTyYbU9Sus611bowFouwUga0JzX+bwmwUpUQyrE6IkWJvzZHSoxF
d+Tjl59Cq8hKS1CnsHKb3guldkT7+rJuroyhIqa/Dmq7yixOwppvnuRDl4pvQzm3
dpWJS6ZQX/PAgfhKbWslQGKxuJiQC0Dej/ZXvsaslETAv/yaqzjKVX6VbFOPhxUz
967tX1OsZmK2OHEZQzeg4mDdy9u6vxvkjTXI2kQwnji6KP58R7clqx7ChHPAAJj1
R1G1i8a82JzTmacU3W2Ynpk5nPXiEWOjN5wCwlZHtf4S3o01bOYPATgcWqEXR6jP
ZRSP6w5sMaUWHV5Zmu0bVuMV2UslyQ==
=+qQD
-----END PGP SIGNATURE-----

--Sig_/yDBVGcXbmvxPZtM=KzrxmqT--
