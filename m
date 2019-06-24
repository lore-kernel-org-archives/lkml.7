Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610BC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600AA20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="adMZa+qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfFXXcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:32:01 -0400
Received: from ozlabs.org ([203.11.71.1]:56761 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfFXXcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:32:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Xlth4H1sz9s3l;
        Tue, 25 Jun 2019 09:31:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561419116;
        bh=NElVkcs7Bo8coH7xUUrQR63+ACAWkHBl1JeWQSI9KSg=;
        h=Date:From:To:Cc:Subject:From;
        b=adMZa+qPdBedM/hq4O60FSIy4xbypwg38g92kQYU5yZ5hD4gcH8HneQyWiHmrI8BV
         v4xYuBQWpN3fLr3B/kgexFB6lfqlxkshQH0TiwX8yYVkAfsuZc+bnxNgC4ZD95ueiW
         mYoPCqDWkFI8PSAGrfxAbtDYd7EsUeoSeey5ez0tfWn67ytXmV6PP+LLaFn0eRVY2r
         6I0Udz623hFqx3UKoJ6gcRykAQWsbaD9guO5LechvlwavcLdSVRXJTSOue0doE5GLm
         C53EcAorhxN9McmVwq6540JqWMPYYGdk0IHoA1QIgGOWxENyrrOsmKXnVBhIyouq6K
         EfqV86TcErNAw==
Date:   Tue, 25 Jun 2019 09:31:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20190625093150.05ed44bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DeOjKe.nyb8=QR_HMF4wUB8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DeOjKe.nyb8=QR_HMF4wUB8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  mm/vmalloc.c

between commit:

  8e41f8726dcf ("mm/vmalloc: Fix calculation of direct map addr range")

from Linus' tree and commit:

  4739d53fcd1d ("arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/vmalloc.c
index 4c9e150e5ad3,6bd7b515995c..000000000000
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@@ -2123,22 -2123,11 +2123,11 @@@ static inline void set_area_direct_map(
  /* Handle removing and resetting vm mappings related to the vm_struct. */
  static void vm_remove_mappings(struct vm_struct *area, int deallocate_pag=
es)
  {
 -	unsigned long addr =3D (unsigned long)area->addr;
  	unsigned long start =3D ULONG_MAX, end =3D 0;
  	int flush_reset =3D area->flags & VM_FLUSH_RESET_PERMS;
 +	int flush_dmap =3D 0;
  	int i;
 =20
- 	/*
- 	 * The below block can be removed when all architectures that have
- 	 * direct map permissions also have set_direct_map_() implementations.
- 	 * This is concerned with resetting the direct map any an vm alias with
- 	 * execute permissions, without leaving a RW+X window.
- 	 */
- 	if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
- 		set_memory_nx((unsigned long)area->addr, area->nr_pages);
- 		set_memory_rw((unsigned long)area->addr, area->nr_pages);
- 	}
-=20
  	remove_vm_area(area->addr);
 =20
  	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */

--Sig_/DeOjKe.nyb8=QR_HMF4wUB8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RXWYACgkQAVBC80lX
0GzUYggAjFOBeVTNx8yqkGdZFxuUIAUUDQXCf721+9o8xvC0plrhYr2iLRKjQZrL
aRv3wRVdO1FV2dLbp9bwu8kf4inGlQm7UhoxDMmvcDXQgr66CPo126viVNdupclk
mjKugWCVb+LvkXv+AR+KMk/vMS7BPq7AV24LIW4ENGvevTX7PuL1kE/RmUlEeUFx
/0ui4cynCOsr9NsVJRIoVM26Rj/81280u3uQtTAE3gcBhNHTCsbmtYRmLoUifiI+
3dsUOkaptYZ/u2ibn3DEMf72IjT4SWAKlZ7v71mMBpMcNDHbIuILDSc+kPGAJA9Z
UNoGeGA/Vb45LyCD9ZFhoGi/9gh7jQ==
=tnwC
-----END PGP SIGNATURE-----

--Sig_/DeOjKe.nyb8=QR_HMF4wUB8--
