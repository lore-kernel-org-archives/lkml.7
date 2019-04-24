Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9014CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672782148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfDXJyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:54:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34997 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfDXJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:54:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 293AE80737; Wed, 24 Apr 2019 11:54:23 +0200 (CEST)
Date:   Wed, 24 Apr 2019 11:54:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Message-ID: <20190424095431.GA32457@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-23 07:55:05, Jens Axboe wrote:
> On 4/23/19 4:22 AM, Pavel Machek wrote:
> > Hi!
> >=20
> >>> It boots ok (unlike mainline -- I'm debugging that), and I can suspend
> >>> and resume... but then cursor in X is moving and I can talk to
> >>> applications cached in memory, but any access to disk hangs.
> >>
> >> Mainline problem was identified.
> >>
> >> But resume is still broken. I took advantage of fact that I can still
> >> do cached commands, and got complete dmesg. I'm attaching it.
> >=20
> > Still broken in 0418. Ideas would be welcome at this point.
>=20
> Bisect it?

commit fdbbda7b3a0622fcfe630238d0bf6c57c4ba3663
Merge: 3c442d5 6c88d73
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Apr 22 13:57:36 2019 -0600

Works ok. So... block is not responsible.

Let me check

commit 91b112cf3b599f06f1e810cfedf37023f25d5588
Merge: fb2c4a8 e32d939
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Mon Apr 22 01:52:48 2019 +0200

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAMlcACgkQMOfwapXb+vI9CACbBVdZPuDTZnB6N+4WWKA46QXT
sSMAn3pEtsfh4gRUS6PeCk2XXc7i31lW
=WkcG
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
