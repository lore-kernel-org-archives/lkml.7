Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B59BC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701BA2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jVsYide1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfHQGlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:41:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49471 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfHQGly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:41:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 469VwD0sXNz9s00;
        Sat, 17 Aug 2019 16:41:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566024111;
        bh=4nKN+dtX/7wuzT5GrZjZ+8QB5BS+ODvFmupXRiDfeVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jVsYide1uBvF8pZn4SuA71W2JoegOfvD3iqPy8gGc+oyyaBRPP/lMk7K5cgOdl+/K
         FdaOIhWZn84LexYg5uVP/POdv0odw166DME/fwwYuPSCP0wUWl+DuqmKdYA1ySibB5
         WgZt4b8AmIXqt2yRzoc2Bg4L5rIyq2lWMygrPRa5SoiqEkIL+Ts4YgpmJ5EFdkXxsm
         rw9lNOX3o57WdWBo+WYBSNKb90mET1RRfyJZIUk3U+Qww4QkU6CjjSoCWq4KqxR9uU
         GFdv+tIU6+1nnIIaj+XgjtlWIVsSL9QARGpQDka/5qV/6MBcLT4tUQwY+wL+pJrsEY
         Vhy+KjDyXFP3w==
Date:   Sat, 17 Aug 2019 16:41:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190817164124.683d67ff@canb.auug.org.au>
In-Reply-To: <20190816140623.4e3a5f04ea1c08925ac4581f@linux-foundation.org>
References: <20190808154240.9384-1-hch@lst.de>
        <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
        <20190816062751.GA16169@infradead.org>
        <20190816115735.GB5412@mellanox.com>
        <20190816123258.GA22140@lst.de>
        <20190816140623.4e3a5f04ea1c08925ac4581f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yU+iNNy5O7f5Ky43FGaKJK1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yU+iNNy5O7f5Ky43FGaKJK1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 16 Aug 2019 14:06:23 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Fri, 16 Aug 2019 14:32:58 +0200 Christoph Hellwig <hch@lst.de> wrote:
>=20
> > On Fri, Aug 16, 2019 at 11:57:40AM +0000, Jason Gunthorpe wrote: =20
> > > Are there conflicts with trees other than hmm?
> > >=20
> > > We can put it on a topic branch and merge to hmm to resolve. If hmm
> > > has problems then send the topic on its own? =20
> >=20
> > I see two new walk_page_range user in linux-next related to MADV_COLD
> > support (which probably really should use walk_range_vma), and then
> > there is the series from Steven, which hasn't been merged yet. =20
>=20
> Would it be practical to create a brand new interface with different
> functions names all in new source files?  Once all callers are migrated
> over and tested, remove the old code?

I certainly prefer that method of API change :-)
(see the current "keys: Replace uid/gid/perm permissions checking with
an ACL" in linux-next and the (currently) three merge fixup patches I
am carrying.  Its not bad when people provide the fixes, but I am no
expert in most areas of the kernel ...)
--=20
Cheers,
Stephen Rothwell

--Sig_/yU+iNNy5O7f5Ky43FGaKJK1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1XoZQACgkQAVBC80lX
0Gx26Qf+Mrpwo57HDnrmpbDvtJAnQrIWM4inlDkl3Iu+YmyFE8EHher8hI0V7ak/
/iF78ubLfNWcDW1yffWNh7Cmor5Pbi7tSegB66lEJHrwnZX420rSEI6Zqho+xQvW
D5+VL/7LkCrtHb5CWXiJ3tWplUQ79bysPwD51Ya9XN49wczUkJy6WmESooHYy0uI
zW5H+TlsDOea9rTIKkYjFwdJqpbhpCbm2kx3nxFu7+cjXnt5aUMrQr7oOn/m8nch
FavqnC3phbmYVJ6mw6Na4PuNshZzah2Uz80Wmz9s7iG/czAsxuRcHHiRK+x+KSUL
Xgzpyg+dWsE7kUNT5c4kf7Miy8facQ==
=ykR8
-----END PGP SIGNATURE-----

--Sig_/yU+iNNy5O7f5Ky43FGaKJK1--
