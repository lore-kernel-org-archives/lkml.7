Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A79C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4430620657
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfFPTyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 15:54:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54828 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfFPTyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 15:54:33 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A19428021E; Sun, 16 Jun 2019 21:54:20 +0200 (CEST)
Date:   Sun, 16 Jun 2019 21:54:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 034/118] f2fs: fix to avoid panic in
 f2fs_inplace_write_data()
Message-ID: <20190616195430.GC6676@amd>
References: <20190613075643.642092651@linuxfoundation.org>
 <20190613075645.482628218@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <20190613075645.482628218@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 05573d6ccf702df549a7bdeabef31e4753df1a90 ]
>=20
> As Jungyeon reported in bugzilla:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203239
>=20
> - Overview
> When mounting the attached crafted image and running program, following e=
rrors are reported.
> Additionally, it hangs on sync after running program.
>=20
> The image is intentionally fuzzed from a normal f2fs image for testing.
> Compile options for F2FS are as follows.
> CONFIG_F2FS_FS=3Dy
=2E..
> The reason is f2fs_inplace_write_data() will trigger kernel panic due
> to data block locates in node type segment.
>=20
> To avoid panic, let's just return error code and set SBI_NEED_FSCK to
> give a hint to fsck for latter repairing.

> index 03fa2c4d3d79..8fc3edb6760c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3069,13 +3069,18 @@ int f2fs_inplace_write_data(struct f2fs_io_info *=
fio)
>  {
>  	int err;
>  	struct f2fs_sb_info *sbi =3D fio->sbi;
> +	unsigned int segno;
> =20
>  	fio->new_blkaddr =3D fio->old_blkaddr;
>  	/* i/o temperature is needed for passing down write hints */
>  	__get_segment_type(fio);
> =20
> -	f2fs_bug_on(sbi, !IS_DATASEG(get_seg_entry(sbi,
> -			GET_SEGNO(sbi, fio->new_blkaddr))->type));
> +	segno =3D GET_SEGNO(sbi, fio->new_blkaddr);
> +
> +	if (!IS_DATASEG(get_seg_entry(sbi, segno)->type)) {
> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> +		return -EFAULT;
> +	}
> =20

Would it make sense to print some kind of debug message, as we do in
the other error cases?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0GnnYACgkQMOfwapXb+vLp8gCgvGQ0G+7oFz87ngoQkAmdeobn
o6YAnRvgQkvVHfao+qX+IclUlE2ncSeu
=HTdA
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
