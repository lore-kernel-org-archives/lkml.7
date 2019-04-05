Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA605C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53802184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="q2MU7EQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfDEEzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:55:55 -0400
Received: from ozlabs.org ([203.11.71.1]:59695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEEzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:55:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44b6vr0cdBz9sPM;
        Fri,  5 Apr 2019 15:55:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554440152;
        bh=+6MyyiwWchaDZcFHvCmvV03oL329V7Jt6QnlGuRjGd4=;
        h=Date:From:To:Cc:Subject:From;
        b=q2MU7EQKMKTnx5TCcTdRLTDz6ivVBvvVd6MrC6ymHyXCt8LIN9OAyr7mksFQDQjeq
         tN2JbpMRg/VybIxtCX+bHJmKGopNQGk1KxFzoYWBCRJCjiSD8JgPyUlVeJvyPzRoci
         mZ2vXfBPytEJRLC6xssz4tGdsxlctYnfDn3OS4RLbpNP8t1WcjZkRJY7kI9dXrXpM2
         EouDodUuc/RqpkT91QrM1JA7V63fw5ONdlcrqz5pJ3eVQAW77pSLrvxeuLB8Zsc/AI
         OJHkGuvwgIqH3YNHA9k0LUn2j8SAXUIqCqZizUONpJ5mWWDd/SlXXjv8g0uLyUTpyd
         NIIcmVvkSnr2g==
Date:   Fri, 5 Apr 2019 15:55:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190405155550.5648e84e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cLp97bMfCJzh/a1bl_E5SiI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cLp97bMfCJzh/a1bl_E5SiI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

kernel/dma/contiguous.c:19:10: fatal error: asm/dma-contiguous.h: No such f=
ile or directory
 #include <asm/dma-contiguous.h>
          ^~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  4f2a8f5898ec ("drm: Add ASPEED GFX driver")

I have disabled that driver for today (by making it depend on BROKEN).



--=20
Cheers,
Stephen Rothwell

--Sig_/cLp97bMfCJzh/a1bl_E5SiI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlym39YACgkQAVBC80lX
0Gz92Qf8DLTL+IPx0dSo3+SLZ/6T0WfhrUE9hS6pgqWXcSA2xILzcf6IgizaMZhp
V5WnSi03VxImCC5iupTmc9nbjqQ11NKxAm+Vk3H/njahENtZKPO0+Fb7UZxhl75p
md1g3f12Ia5YTN0KXYAIGaLCzux1AVuB3LgtVHw/lKIpmSnOyF3VbnMfqmVTrbC5
rrcVNiDgGtinYDDJP2u04wxqi/fQjVTlgw6FZG6IL0II/Gv5uXooib8nvQgMBpNV
2jdvDwbtHXe3X6tH6mia7Bm8tW8z5YkN6E36Tbgm0QyEhhcl7/DKaH7fmNcjNhxM
+yLohG7+9WAPZypqgFzB+mXBRoQsDw==
=Slc4
-----END PGP SIGNATURE-----

--Sig_/cLp97bMfCJzh/a1bl_E5SiI--
