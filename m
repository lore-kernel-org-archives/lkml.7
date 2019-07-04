Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF418C06514
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8E021850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G2SxVzEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfGDGfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:35:02 -0400
Received: from ozlabs.org ([203.11.71.1]:41119 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfGDGfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:35:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fSrg16dYz9s8m;
        Thu,  4 Jul 2019 16:34:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562222099;
        bh=ZhILHJks9MQB0NyhT3uC36WO3l9Mlwo+X2CQWNwE2XY=;
        h=Date:From:To:Cc:Subject:From;
        b=G2SxVzExl2xzEr/OYCKSZEEtz7pWr8uadUDPwuVke6erIPSk3ybT8W6UN9lYysP92
         cNDMK7GRErbo8ZXhz8bunjlz3lRfFis977v71QsUwVwsRoGvNoX9eaLaWSRoCaPYxy
         XJMqyeIFjJbUwlaM9bmsH+sp/4IHU7FacYsAsQVaI1ysLyzVNCPdUglBL390HoJ0E4
         2zb2JqdaGscHF/kS+ZDOdrr1Mp0mmtCBlXjEabaQ9AU+Ud0S3PIdcT2fCtFAlcCtf8
         a96n49nAG2fYuEyKGMPfNUjGxQfoLlJBBao/j5e89b14Cv9JwhxFryk7aWil9U9BZC
         R8AluNIFBWyqg==
Date:   Thu, 4 Jul 2019 16:34:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Felipe Balbi <balbi@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pawel Laszczak <pawell@cadence.com>
Subject: linux-next: build failure after merge of the usb and usb-gadget
 trees
Message-ID: <20190704163458.63ed69d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZGNpIaApbwsvyg5i+/dSMxt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZGNpIaApbwsvyg5i+/dSMxt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arm-linux-gnueabi-ld: drivers/usb/dwc3/trace.o: in function `trace_raw_outp=
ut_dwc3_log_ctrl':
trace.c:(.text+0x119c): undefined reference to `usb_decode_ctrl'

Caused by commit

  3db1b636c07e ("usb:gadget Separated decoding functions from dwc3 driver.")

I have used the usb tree from next-20190703 for today.

This also occurs in the usb-gadget tree so I have used the version of
that from next-20190703 as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZGNpIaApbwsvyg5i+/dSMxt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dnhIACgkQAVBC80lX
0GwyUAf/RuqQ3Lf3xDl/jpmN4r8g23YHHWfwmND8C5Td3xjXL3Wa338Dfbb2DEDw
xIiXletr03+udvJgiSJiLA61pkzIj6QJDmQVjlUiI+6YMGCjX3Yw/FQQuWp+5tLF
CglouxPj7I9y/TtQjVit3FIEjg5eEKOEEyEWZe6l7xu5wneR6Pyu1tJa5Cvl3bjc
Bp+4aO2n+uF0EnyTzsgyeoL924FAIA89vmxoLGw/sZsnCweSA0mmh5urpsIyUYdu
geALFU9PxhvlW0Z1h/ELz9/2LkYRsrILMR9IfZWTDg3R04zoWqMQJM4qWWxPtUKj
YH4cSY71xtwiiTgRjcLBYExP+hzopg==
=fD2v
-----END PGP SIGNATURE-----

--Sig_/ZGNpIaApbwsvyg5i+/dSMxt--
