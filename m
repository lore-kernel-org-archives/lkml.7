Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52152C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFB420811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hgX6wGFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfDVWkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:40:49 -0400
Received: from ozlabs.org ([203.11.71.1]:43225 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfDVWks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:40:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44p1kh28xVz9s7T;
        Tue, 23 Apr 2019 08:40:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555972846;
        bh=6w/xfxRMU+HgAigY7XYa1avpShbpahKC+Ohd6gOt780=;
        h=Date:From:To:Cc:Subject:From;
        b=hgX6wGFxy5gPoab8q0XIhpsB2o2iZJxcRY1XFlcayrKPzAxvXtNg2E4qg9KlOFiDY
         ijrjsQE2tprFQoXOzbS6ZSPzgN4sZ6lUQlQv4qJOeABTJtuw1i0spZNu/yZ9lFlDD1
         N+mVhSQf3NPkkHx3d0vwBN/r7Qg/QPfRzIFbi5Ux3DuiZSXwXOJ4Xyn6jrua/fksNL
         Jvb84bodL48OkEQy9CpLIyyvjJcV0zc+ESvIWs8gGNGQZM0C8Fzv09xKpJIpkBvY7K
         PJxoibx0CcpsP55RM6RfxXlw5SXB3ulJ2fpPFHFA9paOc+0PY2+XK8hksCQHLybq6L
         ErKpd8M/CoKJw==
Date:   Tue, 23 Apr 2019 08:40:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: build failure after merge of the at91 tree
Message-ID: <20190423084042.29fd9c03@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/viFDtRPHsDztPYGKC4FRGVu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/viFDtRPHsDztPYGKC4FRGVu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the at91 tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/mach-at91/pm_suspend.S:17:10: fatal error: pm_data-offsets.h: No s=
uch file or directory
 #include "pm_data-offsets.h"
          ^~~~~~~~~~~~~~~~~~~

Caused by commit

  ab690fa1eb4b ("ARM: at91: move platform-specific asm-offset.h to arch/arm=
/mach-at91")

I used the version of the at91 tree from next-20190418 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/viFDtRPHsDztPYGKC4FRGVu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+QuoACgkQAVBC80lX
0GxptQf/eh89qqrmdmAN/MG1zs5M+JFtIoqW6ZJqnhPjnNWSObuz7rImFfprQTWQ
84CK2p3OKS6V6JubBQfuSE30aADj+bgfsEReaUxeCko53GbZ6Zu5mUQAq7SP7inK
p6VOvk05cM8csKVADQE/3Ri1v8pt/FI3c3+oBG07fABssx69Ghs5LuT/b88NJRyB
gCVy+2L+kgI4uHg0ArGGuwbvemYfJpIWasmzJhJXI/LyEbm7wdyl/BQYuM15hyNb
YMdNnCufYj7Z5Uq7Lll7IVkJWf320Y4oHXRs/aIxukubsHVtFdEYaLYlnUFcl1FR
8Loim0X1oxD8bd+tBWElxHOMA/ACJw==
=aW8/
-----END PGP SIGNATURE-----

--Sig_/viFDtRPHsDztPYGKC4FRGVu--
