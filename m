Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D62C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F620835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfDXUVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:21:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59014 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfDXUVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:21:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 090EF806AA; Wed, 24 Apr 2019 22:21:10 +0200 (CEST)
Date:   Wed, 24 Apr 2019 22:21:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jens Axboe <axboe@kernel.dk>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Message-ID: <20190424202119.GA26357@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
 <20190424095431.GA32457@amd>
 <20190424104850.GC32457@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20190424104850.GC32457@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-24 12:48:50, Pavel Machek wrote:
> On Wed 2019-04-24 11:54:31, Pavel Machek wrote:
> > On Tue 2019-04-23 07:55:05, Jens Axboe wrote:
> > > On 4/23/19 4:22 AM, Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > >>> It boots ok (unlike mainline -- I'm debugging that), and I can su=
spend
> > > >>> and resume... but then cursor in X is moving and I can talk to
> > > >>> applications cached in memory, but any access to disk hangs.
> > > >>
> > > >> Mainline problem was identified.
> > > >>
> > > >> But resume is still broken. I took advantage of fact that I can st=
ill
> > > >> do cached commands, and got complete dmesg. I'm attaching it.
> > > >=20
> > > > Still broken in 0418. Ideas would be welcome at this point.
> > >=20
> > > Bisect it?
> >=20
> > commit fdbbda7b3a0622fcfe630238d0bf6c57c4ba3663
> > Merge: 3c442d5 6c88d73
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Mon Apr 22 13:57:36 2019 -0600
> >=20
> > Works ok. So... block is not responsible.
> >=20
> > Let me check
> >=20
> > commit 91b112cf3b599f06f1e810cfedf37023f25d5588
> > Merge: fb2c4a8 e32d939
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Mon Apr 22 01:52:48 2019 +0200
>=20
> Suspend/resume ok, so pm not responsible. Let me check next-20190423.

Not block, but it seems scsi subsystem is:

pavel@duo:/data/l/linux-next-32$ git bisect log
# bad: [76c938fcaa4b4a5d8f05fa907925d5043834964e] Add linux-next
specific files for 20190423
# good: [7142eaa58b49d9de492ccc16d48df7c488a5fbb6] Merge tag
'mips_fixes_5.1_3' of
git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect start 'next-20190423'
'7142eaa58b49d9de492ccc16d48df7c488a5fbb6'
# good: [ed04f675fa2c22316d7b57bea1258a18a47537ea] Merge
remote-tracking branch 'crypto/master'
git bisect good ed04f675fa2c22316d7b57bea1258a18a47537ea
# good: [4a99e5b3463f5c936540958914bff57ec50ac1e0] Merge
remote-tracking branch 'spi/for-next'
git bisect good 4a99e5b3463f5c936540958914bff57ec50ac1e0
# good: [61cabbda2a7e966b689a6791050ad675e6dff274] Merge
remote-tracking branch 'staging/staging-next'
git bisect good 61cabbda2a7e966b689a6791050ad675e6dff274
# bad: [c8f0c2453f64529035e25fbfb9de9d24e98baff7] Merge
remote-tracking branch 'coresight/next'
git bisect bad c8f0c2453f64529035e25fbfb9de9d24e98baff7
# bad: [6fb251c6f174d3cc571391baa9f6e57fff505446] Merge branch 'misc'
into for-next
git bisect bad 6fb251c6f174d3cc571391baa9f6e57fff505446
# bad: [78a8ab3cc0f95a66c8fb2429030289103de173e7] scsi: qedf: fixup
bit operations
git bisect bad 78a8ab3cc0f95a66c8fb2429030289103de173e7
# good: [c0327e67ecd86e88f5bc5fd54bfdf9b422a1c93f] scsi: core: remove
the scsi_ioctl_reset export
git bisect good c0327e67ecd86e88f5bc5fd54bfdf9b422a1c93f



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAxT8ACgkQMOfwapXb+vJLkACgjrICQ4T63zbaeqMZ13MHEI2S
hUIAn0VbbKBQjEZaEQmsZHyj+BrmdQQq
=flzY
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
