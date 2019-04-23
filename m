Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7EFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045EC2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P/cVa6bY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfDWFNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 01:13:52 -0400
Received: from ozlabs.org ([203.11.71.1]:36233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDWFNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 01:13:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pBSF08wzz9s9G;
        Tue, 23 Apr 2019 15:13:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555996429;
        bh=0p7810v6jjnN67jkL/a5uQ9WFqa9DPuQ6mA1k2oTlbo=;
        h=Date:From:To:Cc:Subject:From;
        b=P/cVa6bYPJHAJ61EGijGxJqb/1diwEsg06JQN33FGVp0RKWprFwNIlDrGGTP9qctV
         NuKGJzjnZcZabTfWDyNN3Q7wSB5d58YYvSi9FasxNl/Yd3SVPGT8l6m921pfwy/wEk
         1v0XuDlJRc5zDrfklUMJTuUcS8SpV4f5DNL8cknilnpjv/LT983ASml+nGG2hFkOTA
         5Khlgfvd21K0eEPBRZEGrI4AxVu9r61Rei6lIkhD3lY4w2z78SRJCOvAbnQ88FesfG
         phSx7XCoL8Z7D2f9M7sr0PuAiILxQpEPSXfA78dWZQoJTUfAmV4MzixHv7CNX0vkBC
         uEdQ7Jm2g7GxA==
Date:   Tue, 23 Apr 2019 15:13:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sickler <Matt.Sickler@daktronics.com>
Subject: linux-next: build warning after merge of the staging tree
Message-ID: <20190423151347.4ec9f51e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+/jYVB/VZPM.LzNzc7/cZbJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+/jYVB/VZPM.LzNzc7/cZbJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the staging tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/staging/kpc2000/kpc_spi/spi_driver.c:97:5: note: offset of packed b=
it-field 'wl' has changed in GCC 4.4
     } bitfield;
     ^
drivers/staging/kpc2000/kpc_spi/spi_driver.c:97:5: note: offset of packed b=
it-field 'cs' has changed in GCC 4.4
drivers/staging/kpc2000/kpc_spi/spi_driver.c:97:5: note: offset of packed b=
it-field 'wcnt' has changed in GCC 4.4

Introduced by commit

  7dc7967fc39a ("staging: kpc2000: add initial set of Daktronics drivers")

--=20
Cheers,
Stephen Rothwell

--Sig_/+/jYVB/VZPM.LzNzc7/cZbJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+nwsACgkQAVBC80lX
0Gy20Af/X0CaM9Vv/zCUD/M7WO9/cY8wk6XGk53ydByELFmv6+tf95Wd/US3AXJ8
hYukqJEI159o6omGF3TqpfuuyY/yEHSLNOFzgqJ5AvF+LH+StkzOMDG2TGLN3RVq
5LWSRSG6IVyge6jBlL4zJlIL59Zof0tQW5mf10mXMwul5DnWGlfdMi/EyZhsehHb
ed6oHNJLBbcM//I1MRM/Aw2/UV8nF5OcnUu5D3yDqc7hiYVGMCw+MXfVXezzNaIw
fHEhsMfuk61T9Vi/rS3cCNsvjlowdaoX6KsbzwhLOLqSoonRDxuWi3aEWNny1b7z
WjcdEOS7BNpy/xPrzx3+hYWbfheQBw==
=71M1
-----END PGP SIGNATURE-----

--Sig_/+/jYVB/VZPM.LzNzc7/cZbJ--
