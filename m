Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB326C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4F721985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UekWyx7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfGVWXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:23:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52619 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGVWXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:23:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45sx2L3hTyz9s8m;
        Tue, 23 Jul 2019 08:23:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563834187;
        bh=bMh3qU2PDCWNtEpKX7nuGKJnWnSwXYOvRFXJCbytzOA=;
        h=Date:From:To:Cc:Subject:From;
        b=UekWyx7kAiEFv0BZDBKPNF4ZjaVEdNtJBX10Uc29aD7wBbeq8qYyqILXxtnvh6M5A
         37RbFWfPTJCuYExLNiM5KcrlrtZL+w3fuWFFKh22G2nkDJ6XeaiJBzwwOSFIzEfF0e
         B9OzRYczNSmN1Qj8b59Kg01PJhY4/JMkTmAAqHcwDZqBa0IajsgVw3JoZgCJ/k89Xz
         IZ1jz7BpS8oEcpn7sn4Pbez2H8L8tvdNL4ZMG90iE83O/ioEIsyygTXkDQrPzePf4D
         i7wJY1GPdmIsAcRWSh842vu1RGQ9HdgWy5de3CcEPAtX+vQIMdMZIgp5u4zrHL8j+N
         l6LWrJEfG1ISg==
Date:   Tue, 23 Jul 2019 08:22:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: linux-next: build warning after merge of the char-misc.current tree
Message-ID: <20190723082253.33b55afe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g2ghnbiKxLvjyzxIm.zDC33";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g2ghnbiKxLvjyzxIm.zDC33
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc.current tree, today's linux-next build
(arm multi_v7_defconfig) produced this warning:

In file included from drivers/base/firmware_loader/main.c:41:
drivers/base/firmware_loader/firmware.h:145:12: warning: 'fw_map_paged_buf'=
 defined but not used [-Wunused-function]
 static int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
            ^~~~~~~~~~~~~~~~
drivers/base/firmware_loader/firmware.h:144:12: warning: 'fw_grow_paged_buf=
' defined but not used [-Wunused-function]
 static int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { =
return -ENXIO; }
            ^~~~~~~~~~~~~~~~~

Introduced by commit

  c8917b8ff09e ("firmware: fix build errors in paged buffer handling code")

These need to be inline (as well as static) ... :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/g2ghnbiKxLvjyzxIm.zDC33
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl02Nz0ACgkQAVBC80lX
0GyUuQf+NSccSUGLPC0eMEKL4nOrSREHMTHzhZYWfkZ3Qi1SAX9FjPpgCNXL6iPh
Vb/b41jJBU/phXppk59gTC+g5F+tMoC7CC2G4bP8eP8OICmv2GmNXLWSaqbw2nzV
R13qG2zAhZHTcBADHdDigQOeEuB9eXYzbDZvKxHuj4AEzed5OpwjTXR0ZLZip6Nt
MAZ+b5tX3H1cd5q92iZQcSb1T0Sp4wbYN27eiElDSNNN/pQBJ9mHNUqdBSrhWvNh
TP5cK0S+LlLUTKquEXkXbBsxWCXkJ+825B3uPBH7cPhq0GjkKEnW5hK5qrsSqh4u
+MHXBfRjSHPV5739g5wkhDYQ83CWXg==
=jI9h
-----END PGP SIGNATURE-----

--Sig_/g2ghnbiKxLvjyzxIm.zDC33--
