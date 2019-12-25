Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B27C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82802075E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLYNE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 08:04:59 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56710 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfLYNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:04:59 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BD6FB1C228F; Wed, 25 Dec 2019 14:04:57 +0100 (CET)
Date:   Wed, 25 Dec 2019 14:04:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au, david@ixit.cz
Subject: Re: f2fs compile problem in next-20191220 on x86-32
Message-ID: <20191225130456.GA18929@duo.ucw.cz>
References: <20191222154917.GA22964@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20191222154917.GA22964@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-12-22 16:49:17, Pavel Machek wrote:
> Hi!
>=20
> I'm getting this:
>=20
>   LD      .tmp_vmlinux1
>   ld: fs/f2fs/file.o: in function `f2fs_truncate_blocks':
>   file.c:(.text+0x2968): undefined reference to `__udivdi3'
>   make: *** [Makefile:1079: vmlinux] Error 1
>=20
> when attempting to compile kernel for x86-32.

David bisected it:

https://bugzilla.kernel.org/show_bug.cgi?id=3D205967

And the bug is actually easy to see:

+int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
+{
+       u64 free_from =3D from;
+
+       /*
+        * for compressed file, only support cluster size
+        * aligned truncation.
+        */
+       if (f2fs_compressed_file(inode)) {
+               size_t cluster_size =3D PAGE_SIZE <<
+                                       F2FS_I(inode)->i_log_cluster_size;
+
+               free_from =3D roundup(from, cluster_size);

#define roundup(x, y) (                                 \
{                                                       \
        typeof(y) __y =3D y;                              \
        (((x) + (__y - 1)) / __y) * __y;                \
}                                                       \

div64 is needed instead of div in the roundup macro. Or actually... It
is quite stupid to use roundup like this on value that is power of
two, right?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXgNeeAAKCRAw5/Bqldv6
8gAnAJkB6UOAeFnYaGssoMD7pN4R87rzqQCgtc0Xa9Nq7JZXPTZM7moIZTXWTXs=
=8DW7
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
