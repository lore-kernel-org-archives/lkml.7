Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E2C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D1D20862
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfFPT7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 15:59:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54912 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfFPT7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 15:59:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8C39E8022F; Sun, 16 Jun 2019 21:59:09 +0200 (CEST)
Date:   Sun, 16 Jun 2019 21:59:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org,
        Eddie Horng <eddiehorng.tw@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 4.19 117/118] ovl: support stacked SEEK_HOLE/SEEK_DATA
Message-ID: <20190616195919.GE6676@amd>
References: <20190613075643.642092651@linuxfoundation.org>
 <20190613075651.140948053@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <20190613075651.140948053@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> ---
>  fs/overlayfs/file.c |   44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>=20
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -146,11 +146,47 @@ static int ovl_release(struct inode *ino
> =20
>  static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>  {
> -	struct inode *realinode =3D ovl_inode_real(file_inode(file));
> +	struct inode *inode =3D file_inode(file);
> +	struct fd real;
> +	const struct cred *old_cred;
> +	ssize_t ret;
> =20
> -	return generic_file_llseek_size(file, offset, whence,
> -					realinode->i_sb->s_maxbytes,
> -					i_size_read(realinode));
> +	/*
> +	 * The two special cases below do not need to involve real fs,
> +	 * so we can optimizing concurrent callers.
> +	 */

AFAICT correct english is "optimize".

Thanks,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0Gn5cACgkQMOfwapXb+vJTSACePQLECVr8Z3jKQJfjVY2QEcuP
aRgAn22jQ6MwSz21apPC57t368GmKDFv
=Ejvc
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
