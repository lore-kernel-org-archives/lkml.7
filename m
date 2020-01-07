Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D42C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6D920678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AbABF670"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgAGFZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 00:25:49 -0500
Received: from ozlabs.org ([203.11.71.1]:40423 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGFZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:25:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47sLSS63zdz9sPn;
        Tue,  7 Jan 2020 16:25:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578374745;
        bh=GGE2QtSyQDFIG+i6LEkAGQRmwbyt6cF/tmEM7LuTyyU=;
        h=Date:From:To:Cc:Subject:From;
        b=AbABF6702TRuLnsj3lNDwGlfuOtva8ldvdQ1E04u05xuGj0lWxv8ZnLxb7iryEZ/l
         0IKmFGPlacWH8xVrQhuIGkmuxyOov621e8ZXRVyh0j4Ok69ChBtDArfhnN7WE2AOkc
         8fnQb4zcWkQCpw0oBxGGsjCZYputYOft3faGWHY6YiZXVNJKM9/dAfJBBj/wTP1IEZ
         rvbT7D6apASELizuW47R/covBpKFPGQeqVEM8qonQRM0OHe5lDnGXm1ZwfA7abV+eE
         nMMl0EQQ+njvtewtU/6oVoDZcaNia7hX7rXPA1IDeBgrG4Njwj6B6TAOUf5zl7b8gx
         Nfc7SZ8+eeCLQ==
Date:   Tue, 7 Jan 2020 16:25:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>
Subject: linux-next: manual merge of the akpm tree with the btrfs tree
Message-ID: <20200107162544.46fc4448@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9C6ME+UIIoHATTCJhWIZrid";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9C6ME+UIIoHATTCJhWIZrid
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  include/linux/bitmap.h

between commit:

  7a5ce045d17c ("bitmap: genericize percpu bitmap region iterators")

from the btrfs tree and patch:

  "lib: rework bitmap_parse()"

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/bitmap.h
index cb63feb3cfbe,65994b9f68f3..000000000000
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@@ -450,47 -450,6 +450,41 @@@ static inline void bitmap_replace(unsig
  		__bitmap_replace(dst, old, new, mask, nbits);
  }
 =20
- static inline int bitmap_parse(const char *buf, unsigned int buflen,
- 			unsigned long *maskp, int nmaskbits)
- {
- 	return __bitmap_parse(buf, buflen, 0, maskp, nmaskbits);
- }
-=20
 +static inline void bitmap_next_clear_region(unsigned long *bitmap,
 +					    unsigned int *rs, unsigned int *re,
 +					    unsigned int end)
 +{
 +	*rs =3D find_next_zero_bit(bitmap, end, *rs);
 +	*re =3D find_next_bit(bitmap, end, *rs + 1);
 +}
 +
 +static inline void bitmap_next_set_region(unsigned long *bitmap,
 +					  unsigned int *rs, unsigned int *re,
 +					  unsigned int end)
 +{
 +	*rs =3D find_next_bit(bitmap, end, *rs);
 +	*re =3D find_next_zero_bit(bitmap, end, *rs + 1);
 +}
 +
 +/*
 + * Bitmap region iterators.  Iterates over the bitmap between [@start, @e=
nd).
 + * @rs and @re should be integer variables and will be set to start and e=
nd
 + * index of the current clear or set region.
 + */
 +#define bitmap_for_each_clear_region(bitmap, rs, re, start, end)	     \
 +	for ((rs) =3D (start),						     \
 +	     bitmap_next_clear_region((bitmap), &(rs), &(re), (end));	     \
 +	     (rs) < (re);						     \
 +	     (rs) =3D (re) + 1,						     \
 +	     bitmap_next_clear_region((bitmap), &(rs), &(re), (end)))
 +
 +#define bitmap_for_each_set_region(bitmap, rs, re, start, end)		     \
 +	for ((rs) =3D (start),						     \
 +	     bitmap_next_set_region((bitmap), &(rs), &(re), (end));	     \
 +	     (rs) < (re);						     \
 +	     (rs) =3D (re) + 1,						     \
 +	     bitmap_next_set_region((bitmap), &(rs), &(re), (end)))
 +
  /**
   * BITMAP_FROM_U64() - Represent u64 value in the format suitable for bit=
map.
   * @n: u64 value

--Sig_/9C6ME+UIIoHATTCJhWIZrid
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4UFlgACgkQAVBC80lX
0GzRZgf/SzplGjFNk6qZXbCi3dAid8jqPGKnTRXFtci8WDX8Wl2YQuJDtZEV0K2N
AaweM3G8GJzRRMtH/lHMTdK9xuZwRiT5eUSHIbCA4qKzZGrl64zr3VBT1Y1d9xYi
HsbFMbfirDDEGhvVvO1ksm+7+OPW41czfGHAGTQSCH9k3XhmKPwl7PDnPQQ7CtYg
5mei180m/Mv34houcHTXM7BoRKT8t29w7jD+khvrW/inipVSpQxgTwXYZl/64ECZ
PV+GxeyrkNC50SLmZ33JPePZFhko9O8okfZTYHZmGy/9YGPN8SV4AbnGv3AZO/i6
u04WA9zdziuKA3R3foIS7H3FqZKVgw==
=wk96
-----END PGP SIGNATURE-----

--Sig_/9C6ME+UIIoHATTCJhWIZrid--
