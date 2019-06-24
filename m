Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB967C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2181208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dcmAsoE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfFXHjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:39:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfFXHjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:39:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XLl568T1z9s4Y;
        Mon, 24 Jun 2019 17:38:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561361937;
        bh=Oqr9VoGz+H8jU7f/XIrLkeTzjqIaQSafjkzl8YOhV38=;
        h=Date:From:To:Cc:Subject:From;
        b=dcmAsoE3wE6sxEBKxRgtdhUrf9MneoOPjpaBjDvJBPTyOY6dtGdn1i/G9j31rotfm
         DUAbH0aS2dzHy6pOoVnTchmvjmrXwg8dQrYxHJxDtfZjNXgRfjeF127yfKSvE4na+b
         S48j47uIjZ7Bf2eqLGC6j/bpf26Dxr7hdGec+NCCEW2nCfnUeTvg97Egk8IIYaeFVX
         a2h4z5obwQFzaY+6WiACdxGGPqAt98Unpde3/Zsv2bZ21Sdd5D8zmxDno5cTL2U3rP
         /twFr3SMX74O+8evCTsz7rEgHBFLkRohAhV5MdfhqXDaQ763JekGfJ8bjm/CsrkDIB
         Zzh0EQAnA59DQ==
Date:   Mon, 24 Jun 2019 17:38:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: build failure after merge of the staging tree
Message-ID: <20190624173855.3c188955@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9SW7r59S7rwskzNWbdJmoBt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9SW7r59S7rwskzNWbdJmoBt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the staging tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

lib/Kconfig:132:error: recursive dependency detected!
lib/Kconfig:132:        symbol CRC32 is selected by XZ_DEC
lib/xz/Kconfig:2:       symbol XZ_DEC is selected by FW_LOADER_COMPRESS
drivers/base/firmware_loader/Kconfig:158:       symbol FW_LOADER_COMPRESS d=
epends on FW_LOADER
drivers/base/firmware_loader/Kconfig:4: symbol FW_LOADER is selected by KS7=
010
drivers/staging/ks7010/Kconfig:2:       symbol KS7010 depends on CRYPTO_HASH
crypto/Kconfig:65:      symbol CRYPTO_HASH is selected by CRYPTO_CRC32_ARM_=
CE
arch/arm/crypto/Kconfig:123:    symbol CRYPTO_CRC32_ARM_CE depends on CRC32
For a resolution refer to Documentation/kbuild/kconfig-language.rst
subsection "Kconfig recursive dependency limitations"

This is just while doing the "make multi_v7_defconfig".

Caused by commit

  3e5bc68fa596 ("staging: ks7010: Fix build error")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9SW7r59S7rwskzNWbdJmoBt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Qfg8ACgkQAVBC80lX
0GzU6Af/Yk5/1ayGEFjMSZJt8rqJc6Z4IP4BqTY0EpUEi2KXgb5doSlOxMDCqYIi
RzS4pk+TZiBQr2khAxuFMEN9dCxP1inL/YhAQ+RaiC8/WluFtWz2Enii+pgxkctN
9a6Yl8Q9IhemJcKlezgqdNP/4pzAZI/rkR+XcBmzfoWvTOPfiK1JWe3ic4GVXpnt
yGhImdF7hjrKVh6cKAATjXRiWP+6gTs+PW+zzDD7hxzkk8fSmcZHSNDEGRDyzP8s
v1ueNsoOcYsRdF2rU5hLUlVP36sFvV24M7W48EszLsGRne0g48CzJyIh3bX7ycZY
6gEQwpVtianhWVw/tDZvhpfMp/RtOA==
=2Stc
-----END PGP SIGNATURE-----

--Sig_/9SW7r59S7rwskzNWbdJmoBt--
