Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C4C606DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE8C2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CSVdk3HF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfGIJyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:54:05 -0400
Received: from ozlabs.org ([203.11.71.1]:46199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGIJyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:54:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jd215rHdz9sMr;
        Tue,  9 Jul 2019 19:54:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562666042;
        bh=I20rMtRdhtlHMbcdjzh5SUTN7cTyewBku+YTQLIPT30=;
        h=Date:From:To:Cc:Subject:From;
        b=CSVdk3HFOPUf6pSg16PKWsUjklN10sK4BwnscIlTR3x6j9QVYh6GcIcmSb5MaiOXN
         wdx/Oxon1ra/zLHr9v14MDuaM6ja9Ip3LPIKBwQRKNI+D27v7bPMIvgVxDAdFWk+Da
         Wy+dkX+E6Yvzvk3gIULEauhcCSocJe6ax3IqO5u3nHBHQ+uO7XHXovdMclcopoWLA6
         +sfmh/EATqmweJwTl256uA3SXnI3ym3NOWqJweq/HolG+65yq3HwPrZ7B8fovhVGzO
         XPgwBZCqrrxnhHzMK7aNf10nCrnmVPZzGlXUlvQ1FYZ2dqo2PCgUCAqMOTtLKnRaPE
         9GI9jkyRbnELQ==
Date:   Tue, 9 Jul 2019 19:53:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: linux-next: manual merge of the hyperv tree with Linus' tree
Message-ID: <20190709195358.25af244b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V7L34NyEN+m=5fUhaJzV.Aq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V7L34NyEN+m=5fUhaJzV.Aq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hyperv tree got a conflict in:

  arch/x86/include/asm/mshyperv.h

between commit:

  dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource I=
SA agnostic")

from Linus' tree and commit:

  765e33f5211a ("Drivers: hv: vmbus: Break out ISA independent parts of msh=
yperv.h")

from the hyperv tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/asm/mshyperv.h
index f4fa8a9d5d0b,080a92025748..000000000000
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@@ -397,4 -246,76 +256,6 @@@ static inline int hyperv_flush_guest_ma
  }
  #endif /* CONFIG_HYPERV */
 =20
 -#ifdef CONFIG_HYPERV_TSCPAGE
 -struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *t=
sc_pg,
 -				       u64 *cur_tsc)
 -{
 -	u64 scale, offset;
 -	u32 sequence;
 -
 -	/*
 -	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
 -	 * Top-Level Functional Specification ver. 3.0 and above. To get the
 -	 * reference time we must do the following:
 -	 * - READ ReferenceTscSequence
 -	 *   A special '0' value indicates the time source is unreliable and we
 -	 *   need to use something else. The currently published specification
 -	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
 -	 *   instead of '0' as the special value, see commit c35b82ef0294.
 -	 * - ReferenceTime =3D
 -	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
 -	 * - READ ReferenceTscSequence again. In case its value has changed
 -	 *   since our first reading we need to discard ReferenceTime and repeat
 -	 *   the whole sequence as the hypervisor was updating the page in
 -	 *   between.
 -	 */
 -	do {
 -		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
 -		if (!sequence)
 -			return U64_MAX;
 -		/*
 -		 * Make sure we read sequence before we read other values from
 -		 * TSC page.
 -		 */
 -		smp_rmb();
 -
 -		scale =3D READ_ONCE(tsc_pg->tsc_scale);
 -		offset =3D READ_ONCE(tsc_pg->tsc_offset);
 -		*cur_tsc =3D rdtsc_ordered();
 -
 -		/*
 -		 * Make sure we read sequence after we read all other values
 -		 * from TSC page.
 -		 */
 -		smp_rmb();
 -
 -	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
 -
 -	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
 -}
 -
 -static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_p=
g)
 -{
 -	u64 cur_tsc;
 -
 -	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
 -}
 -
 -#else
 -static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 -{
 -	return NULL;
 -}
 -
 -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *t=
sc_pg,
 -				       u64 *cur_tsc)
 -{
 -	BUG();
 -	return U64_MAX;
 -}
 -#endif
 -
+ #include <asm-generic/mshyperv.h>
+=20
  #endif

--Sig_/V7L34NyEN+m=5fUhaJzV.Aq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kZDYACgkQAVBC80lX
0GzydQf9H/yv8PTKxH+N2Th2kxmnt0mWoR/8wsK2SqqgxvVxsdm/HajhE6wilJJo
f1rAjjXMw86JN0rKclumVndvUUlAogqXjHeXzelHzyvN0nwDrWI/oHw7I/U/OGMI
fg3GGC3QKTJErC6Xx/3lNbHeSwbM5ghx/j4GLQQI+TpRaBSYPoLbI4d5SIYU1p45
lIFaxysd079gxPQzere/oiqAc0vxQKF+a6YmXALUeRSQs2lpb0OsVSFGrVF2QerF
abuGZbBv3bBChUyEuLp8XiSqYPLMfysCULAsCHltq8Ki0Lg+t6up+FXTIDkOwGhd
Z511df1aVUVGCozcOoyExTYwGkbiTw==
=eQ4X
-----END PGP SIGNATURE-----

--Sig_/V7L34NyEN+m=5fUhaJzV.Aq--
