Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A84C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AA9206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfGaTLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:11:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47597 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGaTLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:11:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5177E802D1; Wed, 31 Jul 2019 21:11:04 +0200 (CEST)
Date:   Wed, 31 Jul 2019 21:11:15 +0200
From:   Pavel Machek <pavel@denx.de>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Ocean Chen <oceanchen@google.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 077/113] f2fs: avoid out-of-range memory access
Message-ID: <20190731191115.GB4630@amd>
References: <20190729190655.455345569@linuxfoundation.org>
 <20190729190714.022413119@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20190729190714.022413119@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 56f3ce675103e3fb9e631cfb4131fc768bc23e9a ]
>=20
> blkoff_off might over 512 due to fs corrupt or security
> vulnerability. That should be checked before being using.
>=20
> Use ENTRIES_IN_SUM to protect invalid value in cur_data_blkoff.
>=20
> Signed-off-by: Ocean Chen <oceanchen@google.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/f2fs/segment.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8fc3edb6760c..92f72bb5aff4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3261,6 +3261,11 @@ static int read_compacted_summaries(struct f2fs_sb=
_info *sbi)
>  		seg_i =3D CURSEG_I(sbi, i);
>  		segno =3D le32_to_cpu(ckpt->cur_data_segno[i]);
>  		blk_off =3D le16_to_cpu(ckpt->cur_data_blkoff[i]);
> +		if (blk_off > ENTRIES_IN_SUM) {
> +			f2fs_bug_on(sbi, 1);
> +			f2fs_put_page(page, 1);
> +			return -EFAULT;
> +		}
>  		seg_i->next_segno =3D segno;

We normally use -EUCLEAN to signal filesystem corruption. Plus, it is
good idea to report it to the syslog and mark filesystem as "needing
fsck" if filesystem can do that.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1B59MACgkQMOfwapXb+vKm+wCaA0MU06luGhPkGR0VcewLLETN
nO0AniAbQox6kLkCPYywtE0Jd77Wlw72
=J5xo
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
