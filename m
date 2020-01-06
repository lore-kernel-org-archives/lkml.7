Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BAC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B955215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bjT+Ocl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgAFGHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:07:48 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgAFGHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:07:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47rlRN5HdNz9sNH;
        Mon,  6 Jan 2020 17:07:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578290864;
        bh=UDwlrivPPJ8XSRXPOf6uF0KaDm0hn0VSjcTGznD/YBQ=;
        h=Date:From:To:Cc:Subject:From;
        b=bjT+Ocl0E7ur14LMOf9bopC2R0C6Oi84OlBz45vPEdiWdSigG0TMXZrDfn1u17ARa
         67Rs3BR3hfGQOxfBIQhJ/ejPwCbrcNxxVaMnu2DgA5H95fQKTnw+xiAB+JaAICa7WW
         6P0p+SiA2zISDqIvS5ioZGCSqutK9cCPZerkc/L1Uj8WjlGGbd/TsiYBBS6mhOEw+T
         tPx2nlvdK4+xoGooKAuKl7BE0ntIpfTZtB0abWf1s90oUCXhjP9rDIEuxUi9yRqFJO
         gwc1Uioo0tN5REejxBwAzPH6fercl9WSXBgD2qCDxt3VN63PixsKMGaS7Qbkk+fYtC
         0yXlzR3O9aqUg==
Date:   Mon, 6 Jan 2020 17:07:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: linux-next: build warning after merge of the akpm tree
Message-ID: <20200106170744.5b6ca678@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/30WeM7X7uMQfbLSg0Gj1uh5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/30WeM7X7uMQfbLSg0Gj1uh5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

arch/x86/mm/dump_pagetables.c: In function 'ptdump_walk_pgd_level_core':
arch/x86/mm/dump_pagetables.c:403:1: warning: the frame size of 2128 bytes =
is larger than 2048 bytes [-Wframe-larger-than=3D]
  403 | }
      | ^

Introduced by commit

  710fae4f03f2 ("x86: mm: convert dump_pagetables to use walk_page_range")

--=20
Cheers,
Stephen Rothwell

--Sig_/30WeM7X7uMQfbLSg0Gj1uh5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4SzrAACgkQAVBC80lX
0Gzx6Af+Jjc+DM+uEB2HcWogRDp/75rEKTl+Fw237TASZRlsrT6VUrZAMwr+IfB/
iVCGXYDYhC7Dj9kPa6tinKYkj5Bmd7/mMIuy3eoW00o191405YA9B2L+ReVdmmmb
LBpwsAiTaUi92q2xbaobb03CdHJbQd4tMY+IzUD7Y6sKMih9FOqu+8YBB8nlslOL
u4IMVO0xlM+QbhK9AVkobs2cGUHw30nY42Y16zgoyzK7+4Fyep3pbRGL0fji4sxC
znZHtZpg7NX3u2XmSy3HBdtQCcTxBBdD2BJQuNm4gHTeCP7uK72nxkrpx4/pn3YC
dwJQ7rfCnjIpchSXtDlVq6yGBCYCBg==
=/BKR
-----END PGP SIGNATURE-----

--Sig_/30WeM7X7uMQfbLSg0Gj1uh5--
