Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7298C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF6020673
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 21:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfJMVoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 17:44:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53461 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfJMVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 17:44:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B6E3E80220; Sun, 13 Oct 2019 23:44:26 +0200 (CEST)
Date:   Sun, 13 Oct 2019 23:44:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrew Macks <andypoo@gmail.com>, stable@kernel.org,
        Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Regression in longterm 4.19: f2fs: use generic
 EFSBADCRC/EFSCORRUPTED
Message-ID: <20191013214440.GA20196@amd>
References: <CAFeYvHWC=RZJr2ZSAvRy=r1kAJU8YW-hxkZ3uBAd2OQEerKmag@mail.gmail.com>
 <CAFeYvHXQQPfu+r0kLpTXWRZJr8SFF1QyUWzOkjJYFE2_UVSrUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <CAFeYvHXQQPfu+r0kLpTXWRZJr8SFF1QyUWzOkjJYFE2_UVSrUA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2019-10-12 21:55:24, Andrew Macks wrote:
> Sorry for version typo in the previous message.
>=20
> In addition to 4.19, the issue was also backported to 4.14 and 5.2.
>=20
> 4.14, 4.19 and 5.2 are all missing the EINVAL fix from 5.3.

Ouch.

Well, when I seen the patch, I thought "looks like the bug is not
serious enough for -stable". I guess I should have spoken up.

Anyway, I guess we need to either revert  59a5cea41dd0a or backport
38fb6d0ea34299d97b too....

So I guess Greg and lists need to be cc-ed... and=20

Thanks for the report and sorry for the trouble....

								Pavel


> Andrew.
>=20
> On Sat, 12 Oct 2019 at 21:39, Andrew Macks <andypoo@gmail.com> wrote:
>=20
> > Hi - there is a nasty regression which was recently introduced into
> > longterm 4.19.76.
> >
> > 59a5cea41dd0ae706ab83f8ecd64199aadefb493 was committed to 4.19, however=
 it
> > introduces a regression that filesystems no longer mount if do_mounts
> > iterates through them after F2FS.  This surfaced on one of my servers as
> > F2FS superblock check happens before btrfs mount is attempted.
> >
> > With this code, my server panicked after kernel upgrade as btrfs mount
> > wasn't attempted.
> >
> > This issue has already been fixed in 5.3 with this patch in July, but it
> > was missed from the 4.19 backport.
> >
> > 38fb6d0ea34299d97b031ed64fe994158b6f8eb3
> > f2fs: use EINVAL for superblock with invalid magic
> >
> > Andypoo.
> >

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jmsgACgkQMOfwapXb+vL2NwCeNwJGQVue06R4Q3nOP1MkrMaU
sH4AnihqqfajtmJ6pQ+zd3t/bRJfqAEf
=eLSo
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
