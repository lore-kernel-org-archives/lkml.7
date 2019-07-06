Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B395EC468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 09:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE6121873
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 09:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y/04bv8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfGFJoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 05:44:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfGFJoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 05:44:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45gmyV19tbz9sN4;
        Sat,  6 Jul 2019 19:44:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562406274;
        bh=jN/7aXKTNXGNzNCpVKyNExjEokyV5XFPkMBOPX3cg00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y/04bv8nEFpDLuoOOMGamZ2WYgHu1/bK/qtrlH4Eqjnpl753XkVHGLTvnzSHcHyzq
         dgc/o5l12o+LvZ+378gGwZxNs9F/jK5No5HVqkSe8iIkvEkRfb2b3VLjsGJeFgUbiF
         bZWar6Up5ZpnWIVcZO+hjmGlz+rFyyO2Eo6CaqLYnbdV5bsmdg1PFiTXD/Qzs5vVjg
         NqroR50wIqc+BBhx4i/lI0/drDeMAGQo9a5sTXRrL0ZRhbIYinILQP9sm1Ze6xUQ8m
         lcFFUJWZdctphVxD2wwtBa9o7myvWsfGRi6qX4qviys67jJ9ChgS/ZS/9LemKZdKg3
         MhKRnsvWkOkVg==
Date:   Sat, 6 Jul 2019 19:44:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 4
Message-ID: <20190706194412.64c15c42@canb.auug.org.au>
In-Reply-To: <20190706083433.GB9249@kroah.com>
References: <20190704220945.27728dd9@canb.auug.org.au>
        <20190704222450.021c9d71@canb.auug.org.au>
        <20190706083433.GB9249@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lHxyJZbwGeuo4cVydYHzWt/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lHxyJZbwGeuo4cVydYHzWt/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, 6 Jul 2019 10:34:33 +0200 Greg Kroah-Hartman <gregkh@linuxfoundatio=
n.org> wrote:
>
> On Thu, Jul 04, 2019 at 10:24:50PM +1000, Stephen Rothwell wrote:
> >=20
> > This release produces a whole lot (over 200) of this message in my qemu
> > boot tests:
> >=20
> > [    1.698497] debugfs: File 'sched' already present!
> >=20
> > Introduced by commit
> >=20
> >   43e23b6c0b01 ("debugfs: log errors when something goes wrong")
> >=20
> > from the driver-core tree.  I assume that the error(?) was already
> > happening, but it is now being reported. =20
>=20
> What are you passing to qemu to get this?  I just tried it myself and
> see no error reports at all.  Have a .config I can use to try to
> reproduce this?

It is a powerpc pseries_le_defconfig kernel and I run qemu like this:

qemu-system-ppc64 -M pseries -m 2G -vga none -nographic -kernel vmlinux -in=
itrd rootfs.cpio.gz

> And from a recent syzbot report, I don't think you are alone, as I saw
> the messages showing up there too...

I feel less lonely, now :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/lHxyJZbwGeuo4cVydYHzWt/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0gbWwACgkQAVBC80lX
0GwVbQf+OmGl3kODaZvbugCuljeQH86H4LuiHAGSkGdYqq4W0l7euAbBghOImVt4
qhr9xO1nRiy0YFme7rp87ivbHjtteo40ba4uAckqP1lBMzMMNjxxUsgbCPFOZTUD
cP1BQ8Vj8tmKnRnWBZ2ml38L39+DHywYZfhZ1anPrlO2aHsmdmEj3LhYpOsdl/8d
Ha2R+Y5Z4Q+sg2GUwkwhQr3IbmZyKtqbpINLNrNQ8BXRBQ6piXSpEU3iISNqwDmq
dpzcYS105F3kFRV/Stk2kAJcmPDLXPwkso30t3d+vRxWBDV5v6Ikt3pJ2Zno4x6i
ujsndaeckXhZUHKG1aXY7DBsOqsb/Q==
=pNDz
-----END PGP SIGNATURE-----

--Sig_/lHxyJZbwGeuo4cVydYHzWt/--
